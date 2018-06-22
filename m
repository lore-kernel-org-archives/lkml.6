Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CA7C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E91A2460E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phNl8mD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E91A2460E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754428AbeFVQsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:48:31 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39261 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754336AbeFVQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:48:28 -0400
Received: by mail-lf0-f68.google.com with SMTP id t2-v6so9527025lfd.6;
        Fri, 22 Jun 2018 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZSgN+PceKA6df1xtbLmUze7vVw38PPqUkZDC0Rqtv3g=;
        b=phNl8mD9BDIzFIFlQBw0QY6W3o0wkWapR7XLq/3djiYP+wEPPrNQW4fsPvmQaNKmUM
         LzUZ8K0G+K3v9J8UAKcqiKRi+ydrhOPRSg2xBqnFB21+h2RgcvJ5N6xWEOMWZwhXhM9J
         9cUsLzmqihucHbu04LSJmSkedFigmv6o/E62tsee/BoKyVP2mbFEoTyDWCCVWu6kRpl4
         ctpDB1Op3mL7WoqpO3/hvbb5+KS2+HN//T4zfoo0IaAxyzJzBnVuIik+A8SQC9zbqVqs
         Jq2BBS5fzBMwE2MO7FmnckOet5SLpibQhZJgnGAPSGaJozTOePpScCKqu+nDZKPc7VWG
         dG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZSgN+PceKA6df1xtbLmUze7vVw38PPqUkZDC0Rqtv3g=;
        b=XTuGiNSoYPB5MUTN3aJQymvIcAvSCTE8khGSdcQL/SfHescbkc5WHQJTintLWyed+3
         2b3kaNs1w4QkSx0zE+a5pFzS+JbyvsRH4GXkl/O5NDuw8sQ4uLwfYliOBhq5cDow71rm
         ymGedAUstJDhIYsLSZquroxNAlK9Uv1BohgQuyblu3kof3zs9eq6Nc/RSIBmWkCy6kf/
         HCT9EcqzD7lyXTIwXqyxjbqihzEJcLosBawe4fAEaR6oYGLriJZfviaYzW7AcNpuj9s5
         OIz/tuGkZZDUwxJjSzkNm2INWCFAMw4gzgwu/b5+ywuLTt8za568zZos5tEdDKUOkfrL
         2k6Q==
X-Gm-Message-State: APt69E1FQ39F8NEoTsvmKIXXQ+XKVAKT3+6r1sDrPTa7/GQ6ITf9JR5S
        IYKcoNjMs8mRlzx/gfRfsWY=
X-Google-Smtp-Source: ADUXVKJ+dP23u+zB/6NDiW+PIw44iU490Ugt3nsreMmeECr/LmM/py62l8EpC0b7LR9+/UASv1FXVw==
X-Received: by 2002:a19:8fd4:: with SMTP id s81-v6mr96107lfk.118.1529686107113;
        Fri, 22 Jun 2018 09:48:27 -0700 (PDT)
Received: from gmail.com (213-238-244-10.customers.ownit.se. [213.238.244.10])
        by smtp.gmail.com with ESMTPSA id b204-v6sm1672273lfb.12.2018.06.22.09.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 09:48:25 -0700 (PDT)
Date:   Fri, 22 Jun 2018 18:48:23 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: gadget: ccid: add support for USB CCID
 Gadget Device
Message-ID: <20180622164823.GA5351@gmail.com>
References: <20180529185021.13738-1-marcus.folkesson@gmail.com>
 <87r2ltcopp.fsf@linux.intel.com>
 <20180530140415.GE2939@gmail.com>
 <20180608185443.GB874@gmail.com>
 <87efh4zeqb.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efh4zeqb.fsf@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Filipe,

On Mon, Jun 18, 2018 at 11:22:04AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Marcus Folkesson <marcus.folkesson@gmail.com> writes:
> > Hi Felipe,
> >
> > Should I send out v4 or what do you think?
> 
> sorry for the delay, have been busy with other tasks.
> 

It is no hurry :-)

> > On Wed, May 30, 2018 at 04:04:15PM +0200, Marcus Folkesson wrote:
> >> Hi Filipe,
> >> 
> >> On Wed, May 30, 2018 at 03:28:18PM +0300, Felipe Balbi wrote:
> >> > Marcus Folkesson <marcus.folkesson@gmail.com> writes:
> >> > 
> >> > > Chip Card Interface Device (CCID) protocol is a USB protocol that
> >> > > allows a smartcard device to be connected to a computer via a card
> >> > > reader using a standard USB interface, without the need for each manufacturer
> >> > > of smartcards to provide its own reader or protocol.
> >> > >
> >> > > This gadget driver makes Linux show up as a CCID device to the host and let a
> >> > > userspace daemon act as the smartcard.
> >> > >
> >> > > This is useful when the Linux gadget itself should act as a cryptographic
> >> > > device or forward APDUs to an embedded smartcard device.
> >> > >
> >> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> >> > 
> >> > this could be done entirely in userspace with functionfs, why do we need
> >> > this part in the kernel? It does very little.
> >> 
> >> Andrzej pointed this out, and I actually do not have any good answer
> >> more than that the userspace application could be kept small and the
> >> important configuration of the CCID device is done with well (I hope)
> >> documented configfs attributes.
> 
> can we use existing open source applications without modification by
> accepting this glue layer?


If you mean existing open source application to talk to the "daemon", the answer is
yes. I have been using PCSC-lite and OpenSC on Linux, and PCSC on
Windows to communicate with the smartcard.

If you mean existing application as the "daemon", the answer is probably
no.

> 
> -- 
> balbi

Thanks,

Best regards
Marcus Folkesson


