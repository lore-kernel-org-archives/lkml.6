Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEC3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCAB20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547548189;
	bh=gQt5/yKDOG4Ew3f0MLlYxvDBjVu/PV0obx+13BhsYak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=doqSBPoYWhTQ5vrZb8kLJZgsYRIHN2imlsU4hz/9htKbbI8RxvAf09VG3GIojUJRt
	 Yr6YlnZvyxC2RwyUXqdfwfcvMMN20VoV115onU/mQYDe+LmPKHv/ctb3CkCAiMJbiA
	 AYEy85lQmaFSg2IodAs0+sHuFKteJX3sCuY6LdZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfAOK3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:29:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45401 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfAOK3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:29:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so1812759ljd.12;
        Tue, 15 Jan 2019 02:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y5szvELKeShoHewV8/WaejB4OxKNh4HyjuJbyW+ISJI=;
        b=JsRS2fXCQfdFZUL5RdhpY5Ngz2YNeixtGUq0ZKdfeWFAk+YJ79bHwzLNMMvzbxL8lj
         AARrPOuA5Nj4dnUtB2BZMCE2H/WGX8rup937ZfD84KOv06ny8LrGQlMcXPznpQCRQs7M
         v4vB5fRkJNmziL5QKXkswRK2LJ7zmuHI64tmSjxP4xAm9WyxcDpc+P26UMYTYrDACNij
         wufj+1CzlxWOegCCOT0LEdIi5Ppy+VogsNIapcy7382PTlxo35He5Yw6+7kAg1Xts8ds
         6lovlP4kXDX16bEaYGaaa8xADUM/uGce6EkL0yEPfXWdzlLgjB/QncNNbGhk0LbBR2DF
         QB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y5szvELKeShoHewV8/WaejB4OxKNh4HyjuJbyW+ISJI=;
        b=j9H9hxxTlYbOZbeZwr41o6aPwmXHoIdlP0gQyZusU3LWpIMx6A1Xxw6RTcZsp5q72S
         //L+XiB7qGyTrU3i7gpQmZP2GPuYUkUnWtN1Y/fo7bEKJVb8q0IWMlJxUugWE8BoqhXk
         ypU3FBlYSZ1t+J9Scb1lyN9vexhAo72iMexNCd3Awcc9P1qrItsXL0Qo9+8OyESQwp2N
         rJh67fwZ72xNMqKXOZYR+PFzlYqYmXGVEiPMtfMTePJ4pmRR2GFvOAXMgHytHFRr9x/m
         bYmJVt6h3lDpUT9jYM5dFOyWSuvTWbEAqWtoeUUnIVgbIxJMdhzmq8l6BoxrmW4cYWff
         AFKg==
X-Gm-Message-State: AJcUuke0hZsJWQ+MGB9TrO6tPUQgcZ0/E3t6VuNmXTC1vO3SVoWx6NtG
        CCNPTpvVUgeDD53N3T48wp4=
X-Google-Smtp-Source: ALg8bN7lAZvM79HcdCMHSYETfUT8kJJpvMauZm9S4hqhjx0pho6liq3g1u89YirI6FZA0Ji/tUNzFQ==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr2392786ljj.61.1547548184397;
        Tue, 15 Jan 2019 02:29:44 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y1-v6sm498938ljh.39.2019.01.15.02.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 02:29:43 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gjLyY-0000HE-HI; Tue, 15 Jan 2019 11:29:43 +0100
Date:   Tue, 15 Jan 2019 11:29:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: Fix GPIO in autosuspend
Message-ID: <20190115102942.GO3691@localhost>
References: <20190115085743.GL3691@localhost>
 <20190114194352.4579-1-pados@pados.hu>
 <15f71a61af66817847d4b11b9e2e60e8@pados.hu>
 <20190115092607.GN3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115092607.GN3691@localhost>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:26:07AM +0100, Johan Hovold wrote:
> On Tue, Jan 15, 2019 at 09:17:58AM +0000, Karoly Pados wrote:
> > > I think it's better to add the autopm call to gpio210x_gpio_get/set
> > > only. This will allow for a simpler patch, and keeps the autopm handling
> > > confined to the gpio paths.
> > 
> > I'll submit a v2.
> > 
> > >> @@ -1383,6 +1397,7 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int
> > >> value)
> > >> } else {
> > >> u16 wIndex = buf.state << 8 | buf.mask;
> > >> 
> > >> + usb_autopm_get_interface(serial->interface);
> > > 
> > > Also make sure to always check for errors from autopm_get().
> > 
> > I checked everywhere else, the reason I didn't check here is on
> > purpose based on your previous feedback. The caller function here
> > doesn't have a return value, so the only way to return errors is to
> > log, but in my last patch to ftdi_sio you made clear that errors from
> > autopm_get shouldn't get logged. Trying to call usb_control_msg() even
> > though the device could not wake does not cause issues, and the return
> > value from usb_control_msg() clearly identifies the reason for failure
> > (failure due to autosuspend), so error information is not lost either.
> > So I thought not checking here has no real disadvantage and I still
> > stay conformant to your previous guidance.
> 
> Ok, I understand your reasoning, but please do check for errors and bail
> out early if autopm_get() fails. No need to log errors.

Actually, we should probably add the missing error handling to the
callers and have gpio_set() propagate errors too. If you want to take a
stab at that, that could be a follow-on patch.

Thanks,
Johan
