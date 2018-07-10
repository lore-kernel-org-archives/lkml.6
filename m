Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39234C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF0D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyFlw8rF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF0D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389091AbeGJSqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:46:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39012 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732278AbeGJSqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:46:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id t7-v6so17514570ljj.6;
        Tue, 10 Jul 2018 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HwMfIp6qq4Py9nW1BBZLqpEEcR/GqgFA7zz3v9IC9Ms=;
        b=AyFlw8rFv1eJ8/6MsEXor3CHRH2AouMgRG9jwSFcVuO/5b/NmT+6V4wXIPm9MVCwuY
         iQYQa0+HaJJMyaIdLbBzME2pIv7DSP3kms6xU9k3n1ccosGYEWMDu8fyvc6fkbR2zMD4
         QBiGKsRAxgb9aXyYJSBgDCxiL2j9NexhmAX8caL0kuopb7k6RZFfeON1Z7s7Tz0Ulz/y
         1MZEd46yolCw5UbT/Ca/IuMEehgSpZoKgGo8hQWTOoY4yuL8NwFc7gGfaXnZxC2ojekn
         1IpTc+xJeb+WL9TysKdoIlZDTzvYu3Ge3tWxL6qN+HsPQmMckE9iRN0aTPyRZiPzyNHi
         eWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HwMfIp6qq4Py9nW1BBZLqpEEcR/GqgFA7zz3v9IC9Ms=;
        b=nmXM375Xk6oJfwp1MgmM1FX4zqgjMoXJcwC03SFpJZxr/Kt8MuCJUsvck32gjoby2b
         cX77z5Z+Iv77jh8Rto7CeybyF0PKaKqvX45Nryzk6XJaO7Y+ywWOlC0VK5TvXby0hNsg
         Azq+ATKi8y+CXTHjeHx/L000ej3s80mY0khz1bBhcdj8E557L/DeielDbw/tTX23wwYX
         FaE+gO6397G/02xVVf1+NX2gM2GAv9q8+k4Ajgnojkihf41BRoKyifqxfr/8NAhPpuOp
         9FDHx9Xbg8IZT+aTmomn1+iuX9YUIpcp3kzFFLXuk/3ybHwu/VXC7KlWvPLYM3R/XT7R
         6sVQ==
X-Gm-Message-State: APt69E0hmdp5qnQCqqeakaesy5A3XBn2NF0UoCHJ5sCmYSuuCVDrPWlR
        FPUHu4po66ulxFltt8TWNKE=
X-Google-Smtp-Source: AAOMgpdHd66mKOgpulwxWNbnPUJmJX5voT6/cnvWqY0kRHdt3VvTYszUIAc57EoyhjOQNyjm6AU2xA==
X-Received: by 2002:a2e:5c4:: with SMTP id 187-v6mr15208999ljf.28.1531248376519;
        Tue, 10 Jul 2018 11:46:16 -0700 (PDT)
Received: from gmail.com ([46.194.208.109])
        by smtp.gmail.com with ESMTPSA id w4-v6sm2797053ljj.58.2018.07.10.11.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 11:46:15 -0700 (PDT)
Date:   Tue, 10 Jul 2018 20:46:17 +0200
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
Message-ID: <20180710184617.GA5839@gmail.com>
References: <20180529185021.13738-1-marcus.folkesson@gmail.com>
 <87r2ltcopp.fsf@linux.intel.com>
 <20180530140415.GE2939@gmail.com>
 <20180608185443.GB874@gmail.com>
 <87efh4zeqb.fsf@linux.intel.com>
 <20180622164823.GA5351@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622164823.GA5351@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Filipe,

On Fri, Jun 22, 2018 at 06:48:23PM +0200, Marcus Folkesson wrote:
> Hi Filipe,
> 
> On Mon, Jun 18, 2018 at 11:22:04AM +0300, Felipe Balbi wrote:
> > 
> > Hi,
> > 
> > Marcus Folkesson <marcus.folkesson@gmail.com> writes:
> > > Hi Felipe,
> > >
> > > Should I send out v4 or what do you think?
> > 
> > sorry for the delay, have been busy with other tasks.
> > 
> 
> It is no hurry :-)
> 
> > > On Wed, May 30, 2018 at 04:04:15PM +0200, Marcus Folkesson wrote:
> > >> Hi Filipe,
> > >> 
> > >> On Wed, May 30, 2018 at 03:28:18PM +0300, Felipe Balbi wrote:
> > >> > Marcus Folkesson <marcus.folkesson@gmail.com> writes:
> > >> > 
> > >> > > Chip Card Interface Device (CCID) protocol is a USB protocol that
> > >> > > allows a smartcard device to be connected to a computer via a card
> > >> > > reader using a standard USB interface, without the need for each manufacturer
> > >> > > of smartcards to provide its own reader or protocol.
> > >> > >
> > >> > > This gadget driver makes Linux show up as a CCID device to the host and let a
> > >> > > userspace daemon act as the smartcard.
> > >> > >
> > >> > > This is useful when the Linux gadget itself should act as a cryptographic
> > >> > > device or forward APDUs to an embedded smartcard device.
> > >> > >
> > >> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > >> > 
> > >> > this could be done entirely in userspace with functionfs, why do we need
> > >> > this part in the kernel? It does very little.
> > >> 
> > >> Andrzej pointed this out, and I actually do not have any good answer
> > >> more than that the userspace application could be kept small and the
> > >> important configuration of the CCID device is done with well (I hope)
> > >> documented configfs attributes.
> > 
> > can we use existing open source applications without modification by
> > accepting this glue layer?
> 
> 
> If you mean existing open source application to talk to the "daemon", the answer is
> yes. I have been using PCSC-lite and OpenSC on Linux, and PCSC on
> Windows to communicate with the smartcard.
> 
> If you mean existing application as the "daemon", the answer is probably
> no.


Just sending a friendly ping on this one.
I've sent out v4 as I had it prepared for a long time, just to catch
comments in the meanwhile, but none so far.

> 
> > 
> > -- 
> > balbi
> 
> Thanks,
> 
> Best regards
> Marcus Folkesson
> 

Thanks,

Best regards
Marcus Folkesson
> 
