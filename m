Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6433CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E2D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdYkoNGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E2D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeIAChI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:37:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36244 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeIAChI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:37:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id m27-v6so12491162wrf.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=28ABW0HadfOd0UbBM8/lbqREG6g70PohuNZ7emK4y7Q=;
        b=ZdYkoNGXMn5yDqGQjUAVLhOFYtwDL8DD6hq8IrigEA+wYo+ThC3whAqcMQ9pcyK33C
         4ukDvLTVW6KpMrs5V/GaUdNttjDWrKrpz0iBmOGP00k2+TO06j0nnrfbeOWiVZ6QR7uw
         50QEZJNrqTs0vbWWkiM2LVUaQNjCbQ0+pCpVuIWYEjg4MKI6cjgZ+EZ6SLEn7XdQwB1D
         QrIdXI6CngxdI4o7Tku8AfTFs8OcyyZ5zKRGKgLpQOFfM/c0rwgr3Wmc6POU943i3vwe
         MEnzzAcBoII+/amwUD15X91AMNkF3vSiwQog1S41jyZT32WIF1kknwlyp3Mnfmmx7NKa
         XAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=28ABW0HadfOd0UbBM8/lbqREG6g70PohuNZ7emK4y7Q=;
        b=C7SSgZ54LGoQRgV8ad+Hm5VJqpO87PNxSIJycNT0WjOtlq/3gVde8Xv/+AD5h4NVdl
         ScQG2zVnAxl2aIkv663nLH/COKrZzHwVRp40uNlSxBuvpBn7vnQK55N0BcUDmKSzUQE1
         fEOTUub1+EoZtM7hhLtmdVZtJsPh7W7rj92wSusS4yiOAFGH/z/XsIqRBbAjeruoT77Z
         4gnwwtRG4ku5P1tDstHCewDntD6aEyAZAHtPVIbcNKrDHCRpW4ZAOzAimEOv4uTOfwfO
         mF3v2QR+BJ2zqxqZ4kyRU68AGpOYf1RWjPEZbsj0SLATEKnwTax/UXQm3DVsU6cVnNR0
         yDgQ==
X-Gm-Message-State: APzg51DqBJ22i7qwBvE31anO0D8DTNqli2jhSfx0MdEfQtqhXCzRVNl8
        Hvng1o0bglKAZ8A7v6O/yAI=
X-Google-Smtp-Source: ANB0VdYnc7UGHkR1ZZeJq/9vGAJc7SFCW2e6PF4IdlfcKqnFUhp0tIyDbxd+qWdwM1kBbBnkziGTQw==
X-Received: by 2002:a5d:4401:: with SMTP id z1-v6mr12903666wrq.227.1535754454495;
        Fri, 31 Aug 2018 15:27:34 -0700 (PDT)
Received: from xux707-tw (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id u7-v6sm10463045wmd.46.2018.08.31.15.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 15:27:33 -0700 (PDT)
Date:   Fri, 31 Aug 2018 23:27:43 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 01/21] staging:rtl8192u: Rename AdvCoding - Style
Message-ID: <20180831222741.GA16530@xux707-tw>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
 <20180829203547.15650-2-johnfwhitmore@gmail.com>
 <b621a12258c3f0d0a9fcb61ac454af4822814e67.camel@perches.com>
 <e302edd8-4b00-8c28-8375-2a781877f019@lwfinger.net>
 <20180829215508.GA16451@xux707-tw>
 <56ff743b826b618cee60608160f2e798c5968871.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ff743b826b618cee60608160f2e798c5968871.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 03:34:01PM -0700, Joe Perches wrote:
> On Wed, 2018-08-29 at 22:55 +0100, John Whitmore wrote:
> > On Wed, Aug 29, 2018 at 04:21:54PM -0500, Larry Finger wrote:
> > > On 08/29/2018 04:14 PM, Joe Perches wrote:
> []
> > > > Perhaps support for the chipset could be converted to use
> > > > mac80211 and moved into the directory with the other realtek
> > > > drivers in drivers/net/wireless/realtek/rtl8xxxu/...
> []
> > > All the Realtek USB devices should be added to rtl8xxxu, not merely moved
> > > into that directory. Jes Sorensen created a well-designed driver the is
> > > structured to permit addition of different initialization routines, etc.
> > > That said, the conversion will not be easy. In addition, it will require
> > > having your hands on a real device - a requirement that I cannot meet for
> > > the RTL8192U.
> []
> > > Oops... it probably doesn't look like it, at the moment, but 'actual code
> > changes to this driver' was where I'm hoping to get to. There's a lot of
> > stuff in the header files, including member variables, which are not used
> > in the code. I was hoping to strip these out incrementally to minimise
> > the amount of source code that has to be understood. I'm not familiar
> > with the overall network, or 80211, subsystem architecture, but it's hard
> > to see why this driver has it's own private ieee80211.h file.
> 
> That's true and the reason why this code should
> eventually be deleted if possible and its functionality
> integrated into the existing realtek/rtl8xxxxu code.
> 
> > I must try and get my hands on the device in question. 
> 
> That'd be good, though likely this device is obsolete.
> Good luck finding one.
>

Maybe if the whole driver was deleted nobody would notice ;)
Thanks for your help. I'm afraid I carried on in the same vain
cleaning stuff up but I do have to look at realtek/rtl8xxxxu, thanks
for pointing out where the goalposts are, miles away ;) 

> > Thank ye for your comments, and sorry for the "somewhat useful" changes
> > to date, but doing these changes is letting me get the hang of this code,
> > which I refuse to comment on because there are probably guidelines on using
> > naughty language on here. ;)
> 
> Feel free.
> 
> The one look I took at any existing multi-platform realtek
> code with all the #ifdefs made me not want look at it again.
> 
> https://github.com/hadess/rtl8723bs/
> 
> I said a naughty under my breath too.
