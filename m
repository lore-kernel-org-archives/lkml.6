Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39475C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 18:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3F321720
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 18:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD1pNPTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbeLWSGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 13:06:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46530 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbeLWSGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 13:06:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so4906905pfe.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0GkPFoGI+BIUNwbP47PPUTPdGVaGdkgAmTLQ1seF/WU=;
        b=bD1pNPTjQIqfE5NlQF0A9G2fltrVSkViUP/MiyeE+QSnQVl70cUjz+pO9+mmw7NdJ4
         nDBQx/Ifoh/CKyNW2rkpDxAozd25edW2dQADnydiW0LYX86DWk85tWzTEbntIbSdXrCu
         PA23821NR+EBaNdK4nawgdp+Zs7coLh0LqeTUC4UJv1ak9H+16LVUwh0MIA4LJfKsdId
         /SYv0txB1uwKNbBoxr1e+Ux0z5ZYMfkvIhwmfCzmSFui7ebYP9M9Ak84DDvfQHVy04LO
         djB6dtK4JTcvyjsGAmDmyt6Gh26Yp9IyK0FQmClflcyOpgA2blxXQWbA7bgps33rBHJC
         OImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0GkPFoGI+BIUNwbP47PPUTPdGVaGdkgAmTLQ1seF/WU=;
        b=peddS7XkJQPK40QEha5QaP8n13H/E5BEAHaoR6SQC4NuBKx91X4+sqetTue6OdFslu
         Ku44980A6ysi0iofoa2tvke8rgeugIOdlSbfx1rzU4hhFqKSK9aEe2ZKuFIXyfyrvgdj
         /rVv5WiSuSyxBgZ4/chH8VKExFjcrzcKpPkvFUGwEIanOLcQhsHoHCBAuIArP0ODsLNK
         pv0QzgpVyT6UsfT6eQEPDF0RnKSR+eYyURADi+Ecx7aWBjXKfmeazCGQAVy1hCu2BByA
         hzCcW6elhoo3hzuTFQDBghBhUyVfJwFxTTpT9ckXi2CYyL+unY5a7tNFgPVZpd/4QZnv
         yGwA==
X-Gm-Message-State: AJcUukc8zZn3A/cpz67hZ4chS0sAH+dwC9kLRTYgT73+5/u/diJv1/n8
        xNr+cukKthje1bbgq8H8Ye4=
X-Google-Smtp-Source: ALg8bN7NOd0viQJUy87Tf0zJLK0RUfPhz6u/cxVWJ9Ozlwk4k23NtTnM/+qssVGkhTu9XNDxYNidaw==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr9905273pgc.165.1545588373120;
        Sun, 23 Dec 2018 10:06:13 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i73sm42983632pfi.66.2018.12.23.10.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Dec 2018 10:06:11 -0800 (PST)
Date:   Sun, 23 Dec 2018 10:06:09 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Marcus Meissner <christian.brauner@canonical.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: FYI: Userland breakage caused by udev bind commit
Message-ID: <20181223180609.GA102606@dtor-ws>
References: <20181223164954.hib4lbchftspidsd@suse.de>
 <20181223171703.s7jm6fkyosnsf33z@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181223171703.s7jm6fkyosnsf33z@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 06:17:04PM +0100, Christian Brauner wrote:
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
> 
> Fwiw, the addition of {un}bind events has caused issues for
> systemd-udevd as well and is tracked here:
> https://github.com/systemd/systemd/issues/7587
> I haven't been aware of this until yesterday and it seems that so far
> this hasn't been brought up on lkml until you did now.

The fallout was caused by premature enabling of the new events in
systemd/udev by yours truly (even though the commit has Lennart's name
on it due to how it was merged):

https://github.com/systemd/systemd/commit/9a39e1ce314d1a6f8a754f6dab040019239666a9

"Add handling for bind/unbind actions (#6720)

Newer kernels will emit uevents with "bind" and "unbind" actions. These
uevents will be issued when driver is bound to or unbound from a device.
"Bind" events are helpful when device requires a firmware to operate
properly, and driver is unable to create a child device before firmware
is properly loaded.

For some reason systemd validates actions and drops the ones it does not
know, instead of passing them on through as old udev did, so we need to
explicitly teach it about them."

Similarly it is now papered over in systemd/udev until we make it
properly handle new events:

https://github.com/systemd/systemd/commit/56c886dc7ed5b2bb0882ba85136f4070545bfc1b

"sd-device: ignore bind/unbind events for now

Until systemd/udev are ready for the new events and do not flush entire
device state on each new event received, we should ignore them."

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

Given that we explicitly enabled these new events in systemd/udev code
this is actually "userspace caused userspace breakage" case.

Still it is unfortunate that we did nit notice that my patch enabling
this functionality in systemd was premature.

Thanks.

-- 
Dmitry
