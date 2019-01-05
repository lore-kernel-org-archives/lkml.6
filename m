Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2EFC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A95720874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/Ux+HBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAEARA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:17:00 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:40161 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfAEARA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:17:00 -0500
Received: by mail-qk1-f182.google.com with SMTP id y16so22463932qki.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 16:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7jA/trgkmimgTZsEFq6Gf22Jn6wpeZB3kaQ6VpW628=;
        b=S/Ux+HBXbW2dtDxZ+uLvmG2M1VeEOSLk8Bs2iMpCGnZmmtOAVMXsz5nUHjRxOQE77i
         owg23MbqwhNDY/X/iKqwpk1yUY0IfN9tlueNQ6RrsBR2oNpvzACQSKzUt7n2mC2pp3al
         /LwFOFUGxdPyAJXnYs1Q159lWykUtXNJcMUWu4W2dBh7mflScYR2R4WMpLOsGwqK/sUC
         youPKg1mmaoa3F7tShASp3O4nZq7LqBlalsmz+tdBNYZ0LNFEWGRtbiak77RGwVAeU+q
         7g3xa52KlGCkmTH9qLQHsy9FJg3zAdBGBBOgDgT1kn5bWNfu4/EHfwvv3hYFxqUvVSU0
         jZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7jA/trgkmimgTZsEFq6Gf22Jn6wpeZB3kaQ6VpW628=;
        b=EXR6zruP99KPRbBcBfqnnHX1tZ/YoDehCu2wUC3u9btl82ooWqKfMVGRQvxsmpw3pa
         377YrjOgx/mCEA1tI3w2ghF31QigjGryWQeV7GvsEAbVRMhuUB7T2nDMedY8pVoLDU5L
         4f0aOIQFg7HUgxU7Gy8BlPvwCf6fF/1OcrgSVJDWisDrfdUfztey8Lo4yW2YSuzPmefb
         GlbsNsz655yQBWIkNdFcTPYGXsqBhu0kS74+Vc+QN8I8zsn1fJXPye+vaiJQ2EN8O74l
         Hkmnoubtr33Gd7PH2W93VMDxnwd16iMM9BZbvho1P2w4yZKgeXLbwlRVgvUBnbhIz4Ji
         HIsw==
X-Gm-Message-State: AJcUukfXZy/hT9wV22Q+WxdbNPfVbz9owKRTFfq+CNKa7tITJ8L1gstV
        2O275A+bDY2REQR5Xs4ys0ehC/T9/gBbDjEm2TGQ4nojoQQ=
X-Google-Smtp-Source: ALg8bN4RkpXtuyxu4sawACWtwSlx25jC6ILu74idlPAK+s7YnZCIVtVQ9iCAtdos5ww4WBiKnwCoBNn2j+6flyf5sjQ=
X-Received: by 2002:a37:3008:: with SMTP id w8mr49213954qkw.75.1546647418804;
 Fri, 04 Jan 2019 16:16:58 -0800 (PST)
MIME-Version: 1.0
References: <CANMdSOztZu2bsG+g=T-pThiHK9cNaMVq=tvTJ6kn2Tvu4CXJCQ@mail.gmail.com>
 <CANMdSOx2yBtLOirwQvZ=KU6Xnn1gGoAXy=PBxrNnQBMLmNm7jw@mail.gmail.com>
In-Reply-To: <CANMdSOx2yBtLOirwQvZ=KU6Xnn1gGoAXy=PBxrNnQBMLmNm7jw@mail.gmail.com>
From:   Daniel Kamil Kozar <dkk089@gmail.com>
Date:   Sat, 5 Jan 2019 01:16:47 +0100
Message-ID: <CANMdSOzy2nd8+BMm_1vb9U=r88XQCy_HzWwdSWvSbXf_a=oy4w@mail.gmail.com>
Subject: Re: "flip_done timed out" messages causing huge increase in boot time
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, azhar.shaikh@intel.com,
        ville.syrjala@linux.intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I should really get to bed ... of course, I meant
516a49cc19467e298d08a404f73a6e311f4548d1 ;-)

On Sat, 5 Jan 2019 at 01:16, Daniel Kamil Kozar <dkk089@gmail.com> wrote:
>
> Small omission on my part : I meant 4.19.12, not 4.19.2 as the last
> working version.
> Also, I can confirm that reverting
> 13947d150bae871bd880565ada318b0bcd0e690e from the current HEAD of
> linux-stable fixes the issue.
>
> On Sat, 5 Jan 2019 at 00:47, Daniel Kamil Kozar <dkk089@gmail.com> wrote:
> >
> > Hello.
> > After upgrading the kernel to 4.20, I noticed that the boot time
> > increased from about 5 seconds to 25 seconds. My machine is an Asus
> > K53SV with an Intel i7-2630QM, i.e. Sandy Bridge. I have an external
> > display connected to it via HDMI. If the display is unplugged when
> > booting the machine, the boot time stays at its old value.
> > The kernel log shows two messages like this :
> >
> > [   15.747206] [drm:drm_atomic_helper_wait_for_flip_done
> > [drm_kms_helper]] *ERROR* [CRTC:39:pipe A] flip_done timed out
> > [   26.198968] [drm:drm_atomic_helper_wait_for_dependencies
> > [drm_kms_helper]] *ERROR* [CRTC:39:pipe A] flip_done timed out
> >
> > Which are the only ones that don't appear in 4.19.2, where the boot
> > time was smaller. Bisecting the commits between these two versions
> > leads to commit 516a49cc19467e298d08a404f73a6e311f4548d1.
> >
> > Let me know if you need more information.
> >
> > Kind regards,
> > Daniel
