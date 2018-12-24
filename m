Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36919C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07A12173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdszBBnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbeLXJXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:23:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44724 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLXJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:23:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so5588170pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 01:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G8oAhV7292NW+1PrrO+aaTU2ZabSr8fqEr65fg94zV4=;
        b=XdszBBnVpgxSERcH6qxj4t09invDafGaQRdL1Vw2u9gXVJmDO7er0tGm5xMI6eVJav
         VoUR7Jyq13A/T0gLnFqRaqJe9Zpf/EmzepNP2BnP74ywuptkOQKPlqT3SdJIZXiio4qx
         I0NJleVNImuQ5eT7kwleaCWsbMl7mCTBaveGcVPpYFXySOwtLoA+g0VNYsnilZv4cMih
         abyVY4by2fXVOo7QiTCH9Dc9StiftcL5TQAmeTDHc7HHR1rnZRUb+BjfI7+TxwNWD9b7
         8No2Ywti2QliE4aFheWcGLmW61s35sa8fuFLKHKfduuIs3ej5xnpTM5XrSqsTjIo48qc
         /pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G8oAhV7292NW+1PrrO+aaTU2ZabSr8fqEr65fg94zV4=;
        b=rbdq6A+ola3fFpeAN3Sh9aaGT3SjSykH1fLnG45V350DYvkPOLLz7A3VVCdJ7ftxWe
         p3ZcbjlNUXvF8KLKi4k0i02Jz/P5aulWyRRIu1hY7uPTFwUJ5renOWaN5xnpUtA5loim
         G20Zqc49gmeM0p1uCqzNKxAtXAUBjJwdQ5g+uriFAfArLMl0iLlxQYKRoSzhspacgtx/
         5UyNbqk/b4kG4qlVw5FTPuLeFwL25Gw7+8HnB+wk5oPOeQoN1s2Zc/vJHcuqH1n7slRE
         tDGf/m86rymoHp0TR6cNA/iW3jcs6OJtFvqQt5TcT/9fiwKkQAlTmB6P9n9odkNDszUM
         kWLQ==
X-Gm-Message-State: AJcUukcODg/Q9BfjS46knnlUB+kuCShZqWbV80tbm+yar9fRU0DPzdWH
        X1aeNLTCi3cR9wyJB0Mi3zA=
X-Google-Smtp-Source: ALg8bN5g2PU2uG8QTCXcG7kxFWLEyUVQEjKcFOT5Q78fnppQ7qcBhCwgI40TRpBii/RCkH2u8GsRQw==
X-Received: by 2002:a63:f74f:: with SMTP id f15mr11776146pgk.190.1545643380845;
        Mon, 24 Dec 2018 01:23:00 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id z14sm36936794pgv.47.2018.12.24.01.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 01:22:59 -0800 (PST)
Date:   Mon, 24 Dec 2018 01:22:57 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Marcus Meissner <meissner@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: FYI: Userland breakage caused by udev bind commit
Message-ID: <20181224092257.GB122208@dtor-ws>
References: <20181223164954.hib4lbchftspidsd@suse.de>
 <20181224091229.GA26796@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224091229.GA26796@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 10:12:29AM +0100, Greg KH wrote:
> On Sun, Dec 23, 2018 at 05:49:54PM +0100, Marcus Meissner wrote:
> > Hi,
> > 
> > I am the maintainer of libmtp and libgphoto2
> > 
> > Some months ago I was made aware of this bug:
> > 	https://bugs.kde.org/show_bug.cgi?id=387454
> > 
> > This was fallout identified to come from this kernel commit:
> > 
> > 	commit 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
> > 	Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 	Date:   Wed Jul 19 17:24:30 2017 -0700
> > 
> > If distributions would be using libmtp and libgphoto2 udev rules
> > that just triggered on "add" events, and not the new "bind" events,
> > the missing "attribute tagging" of the "bind" events would confused the
> > KDE Solid device detection and make the devices no longer detected.
> > 
> > This did not affect distributions that rely on the newer "hwdb"
> > device detection method.
> > 
> > I have released fixed libmtp and libgphoto2 versions in November, so
> > this is under control, but wanted to bring this up as a "kernel caused
> > userland breakage".
> 
> This is complex, sorry.  When this first commit was merged, we did get
> some reports of problems, so we reverted it.  Dmitry worked through the
> issues and then we added it back again.
> 
> That was back in July of 2017, and since then, we had not heard of any
> problems that happened until this month, a very long time.
> 
> So I really don't understand the root problem here, all of the distros
> that have been shipping kernels with this code for over a year didn't
> seem to have any issues.  My systems never had any issues, and so I
> can't figure out what suddenly changed to cause problems.
> 
> Was it the fact that we all are using distros that use hwdb?  Who does
> _not_ use hwdb these days?  Heck, I would have expected Debian to report
> problems as they are the ones that are known to use old userspace code
> with kernel developers using new kernels.
> 
> So what changed to cause the problem recently?

I think this is new systemd that had my patch to handle bind/unbind
instead of ignoring them is catching up in distros. So:

- old systemd with old kernels OK
- old systemd with new kernels OK
- new systemd with old kernels OK
- new systemd with new kernels - NOT OK - losing tags on bind

Systemd folks merged my patch to disable bind/unbind again until we
teach it to no longer flush entire device state on each new uevent and
it should be well now.

Thanks.

-- 
Dmitry
