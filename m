Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501B0C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80A2224E3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E4f9+qhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80A2224E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932836AbeGGDZ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:25:28 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53786 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932754AbeGGDZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:25:26 -0400
Received: by mail-it0-f65.google.com with SMTP id a195-v6so18904692itd.3;
        Fri, 06 Jul 2018 20:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Z60fKfi/wRLzkdhnfkFGjXCnt5tDdicXs/+Dhr4sPM=;
        b=E4f9+qhCI3WUpX9OrBPbynx2si8dB4u91i/zxEPw2IZb4YzcAxJ+hf42zZ7JdGqf/E
         Xq83t+FN/XAS9wGMSaBXFUE+MWmGXxdgqCrNnJOg7EFOJ6S2cZpNeQJH6I2Y+WZ+dUzY
         KoS20z0ctV2Bsj2ml+7qG9ckbo8T2VkSqpLZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Z60fKfi/wRLzkdhnfkFGjXCnt5tDdicXs/+Dhr4sPM=;
        b=WGxi9fvq3uDYaRVl+UgvkHkjMxMeAknDs1vLiANUdVQI1wf69upW488aUDSNvrSDk/
         qZB2+GNr1E+vFwbY3dTXz7CaHLa/KYoYj01AjCvRfyHNOSEJiRfuZd+3umVEUWW9bRx5
         tgrclNh0lKMfrz2W5s14ICfQMjQuU/LxICMJQcTl/6tyj+a/w4OCBXcF2AAPIGRfYyyy
         qTQL3RZOZTqKAP2O/J3OE0Nv2qQwkjsncSFabOThTA5U15CfXKV+MWbu7/pX6fph92uJ
         tcRI4ncIQ5lvPRwMaU4shrrkfuF+UtOj92QFzoSIH8ppA1bSV99NqntozbWpySr9Hr73
         8tIw==
X-Gm-Message-State: APt69E2OytmxILrkpv93l3eyMRfPridepfAwVYEwqWIHWg0uCBPk4okl
        d0sCafhMYZNNtU5+h80KF8oyZxz4pQG3oO7iDwy09A==
X-Google-Smtp-Source: AAOMgpcaju4Hv50sxENsI/loi8wzlOgXE4FXRfI4gWNmqI3//DLVquPbTiC/aVLnZYA/DfdIDrF21JNFA7SZq6IL2ts=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr9773283itm.113.1530933925693;
 Fri, 06 Jul 2018 20:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <1530913134.3135.2.camel@HansenPartnership.com>
 <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
 <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com> <CAG48ez1rkG=R82eeuYA7s9S6z7+iRfJpVb__PmYaecjZAZETaw@mail.gmail.com>
In-Reply-To: <CAG48ez1rkG=R82eeuYA7s9S6z7+iRfJpVb__PmYaecjZAZETaw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jul 2018 20:25:14 -0700
Message-ID: <CA+55aFxp8zRN_QDaAsezWwHTYhtvLYqromaeB5F4eDz18Tdxcw@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 4.18-rc3
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Doug Gilbert <dgilbert@interlog.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 8:08 PM Jann Horn <jannh@google.com> wrote:
>
>
> I guess we could try that...
> Douglas Gilbert said that the read/write interface was the original
> one, so there might be some users left...

I think it's the "original" interface as in "predating Linux, and
maybe early 90's".

There are *very* few things that do direct SCSI commands in the first
place. The traditional thing was for things like low-level formatting
and for reading audio CD data or burning CD/DVD's.

Yes, in _theory_ there are other things, but they are much more rare.

ATA made /dev/sg* irrelevant for CD/DVDs, and you literally *had* to
use SG_IO to do it.

And if it's anything even remotely generic (ie "this can work on SATA
or NVMe"), again, only SG_IO has a chance in hell of working.

I could imagine that yes, there's some crazy vendor disk array
configuration tool that still uses read/write since it only works with
some very particular hardware, but even then SG_IO should just be much
more convenient than the odd read/write interface.

> > but maybe some distro decided that everybody should have direct device access..
>
> Al Viro pointed out that some distros grant access to CD devices to
> non-root. I've checked in a Debian VM and a Ubuntu VM, and there,
> /dev/sg0 is mode 0660, group "cdrom". That's not "everybody", but it's
> not just root. At least in the Ubuntu VM, the user account that the
> system installer created has access to "cdrom", but accounts that I
> create afterwards using the settings UI don't get access to that
> group. Unless other distros are more lax, it's probably not a big
> issue?

I suspect Fedora is similar. I have a USB storage device, which is why
I have /dev/sg0, and it's in the "disk" group. I'm not part of it even
as the primary user, so..

Anyway, cdrom devices are definitely *not* a reason for using
/dev/sg*, exactly because no cdrom burner would ever use anything but
SG_IO, because it they did, they'd not work in 99% of all cases during
the big reign of cheap ATA CD/DVD drives.

                Linus
