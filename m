Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1FC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B00206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546874918;
	bh=RcixJq78h0C952Zgsn01+myiP+SUgsh5msjaZxrUJm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XpRFSUyYnA07q8QW0VzRv4Thtvt/BxAS3sxDt1pd85Ns9TGe3+PhzXEJnf7ftY5Hn
	 V3zrCaBZyXDUq24vJhOha8olrP19sQdIWIJMEuIi2oTaF//hFN6LlcAskcewKfxexB
	 rs9AIiFmj23XQ9x0IHjVRylakBT+fy/ddwUjDhrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfAGP2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:28:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37486 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbfAGP2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:28:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id t18-v6so675277ljd.4;
        Mon, 07 Jan 2019 07:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aWgsobAhrek/X2lv+z2iwZQ0pv5cj7NcHN3lmCT1VaY=;
        b=k+IjXNorJBKjNh1L4Eu1C/P7UeKcE1Y1hYWYhkY6AMrORQC17sowJg4S474M7jjmI5
         PLla+zTHuw0WZxA6PBaR8wpS/wbnajkbsU7xQ3Ngi6gpmuCRC9TKQgmwUF2dHH9YGEBA
         1YXsGl1aZJP3v8ASpoN0VJ/jOk26n8znPBj3qTXbfPWHlop8TIll0DdXaeWNpqatKqXH
         MgrUzY8rLq8UDm1rFSOYoYmjzc78JqEVs/MgjHcw4XOCVk2aqVo7phXoUkdvD5bPdMDa
         vbLb1K+HJra0ienW0DtktcTxWjszuLXvxZRXKtab48WRDgBeTwUNbGXctTXYHEICXIN8
         P4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aWgsobAhrek/X2lv+z2iwZQ0pv5cj7NcHN3lmCT1VaY=;
        b=iZ7SHjtYAzK7FGxMO14zVBVu7DtDLKuI263Pv9/SeHyIn6J8HfPVLo0Wvzexgnr8XA
         HHBTb1mlGrGTVubtYI2ZqphsWShoGWsbMVX8N5iMXeX2h6EpsAVYV0N3UOAtmsAhTJET
         wyNWFgYFQAQTG26TlxP5oH+rTWmDsGFk2ReyEV92h8a7rH/mVj5efMynAA+G3G30JiHW
         z+11f0o3PkepB8yZ9HY0EmbEujFq1aVMU4aVkmKHpssxeI1u8OVkbSoXGEYiRlsG/AEC
         gB5XbOKgoyW/OHEe4mwi4hzUe81xHimuTS+BW+fXz7qAgYjnmT5dzWFOENj+9+XR4qo6
         KqGQ==
X-Gm-Message-State: AJcUukeFgqxhA5beb9ez0+v3WQlwK8Sxv5OuLSpOFqKOGHIfZE/b50zB
        LQeKVbX+XH3H5fkDYjmBCNs=
X-Google-Smtp-Source: ALg8bN6gqCHucZ0GB6CO/t9fGUK+uCdHzcIi4JGUrbgJCXeYKAWVnjYzaCnPRkX1wZKfbUIIPJetTA==
X-Received: by 2002:a2e:94ce:: with SMTP id r14-v6mr34162556ljh.34.1546874914004;
        Mon, 07 Jan 2019 07:28:34 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id a62sm12756190lfa.37.2019.01.07.07.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 07:28:33 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ggWpO-0003VN-Ir; Mon, 07 Jan 2019 16:28:34 +0100
Date:   Mon, 7 Jan 2019 16:28:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Rob Herring <robh@kernel.org>, linux-lpwan@lists.infradead.org,
        linux-serial <linux-serial@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [RFC lora-next 5/5] HACK: net: lora: sx130x: Add PicoCell
 gateway shim for cdc-acm
Message-ID: <20190107152834.GC14782@localhost>
References: <20190104112131.14451-1-afaerber@suse.de>
 <20190104112131.14451-6-afaerber@suse.de>
 <CAL_Jsq+BMOvRLEbD2Eo2D=n446vSubeXV3-FbkBSHjpfL=LYsg@mail.gmail.com>
 <9d97fec5-31b0-8717-cd10-de4f36d1cf05@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d97fec5-31b0-8717-cd10-de4f36d1cf05@suse.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 12:43:48AM +0100, Andreas Färber wrote:
> Hi Rob,
> 
> Am 04.01.19 um 18:07 schrieb Rob Herring:
> > On Fri, Jan 4, 2019 at 5:21 AM Andreas Färber <afaerber@suse.de> wrote:
> >>
> >> Ignore our device in cdc-acm probing and add a new driver for it,
> >> dispatching to cdc-acm for the actual implementation.
> >>
> >> WARNING: It is likely that this VID/PID is in use for unrelated devices.
> >> Only the Product string hints what this really is in current v0.2.1.
> >> Previous code v0.2.0 was using a Semtech VID/PID, but no card shipping
> >> with such firmware is known to me.
> >>
> >> While this may seem unorthodox, no internals of the driver are accessed,
> >> just the set of driver callbacks is duplicated as shim.
> >>
> >> Use this shim construct to fake DT nodes for serdev on probe.
> >> For testing purposes these nodes do not have a parent yet.
> >> This results in two "Error -2 creating of_node link" warnings on probe.
> > 
> > It looks like the DT is pretty static. Rather than creating the nodes
> > at run-time, can't you create a dts file and build that into your
> > module.
> 
> Heh, if that were the only issue with this patch... ;)

My thoughts exactly. ;)

This clearly is too much of a hack, but maintaining serdev compatible
information in the corresponding tty drivers is probably what we'll want
to do.

When the tty driver binds and registers its ports with tty core, we can
could match again on the USB descriptors, but since the device has
already been matched, we can just pass the equivalent of a compatible
string, or more generally dt-fragment, instead.

Without having had time to look into it myself yet, this sounds like
something we should be using the new software nodes for (software
generated fw nodes). That way, we don't depend on CONFIG_OF either.

Johan
