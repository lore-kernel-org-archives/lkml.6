Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14C6C65C24
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850922087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq678KJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850922087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeJHANO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 20:13:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38351 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeJHANO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 20:13:14 -0400
Received: by mail-io1-f66.google.com with SMTP id n5-v6so3826920ioh.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDpggDKNfWVkL4QKwUKTVv1OeV29o+9xUog3pjIdBMM=;
        b=Aq678KJG8IA79NNLsnD0ZBxVq79CwwtJ3N7WM+JcKQ9lwzk8acYocGnsIcYzm35zjY
         PMjBWXBws8hLhDGn8PPqWQ/pNxuDYpWwl4iak+cQchfzj+CTJ1sBV58kSxllJ1ni5V9R
         C61YW/sJ+n8kl60dCziOCIh8Ob21dwyBCWTvS7G1AGO8EQn5ezrGUvHMWgzcfnXmki7e
         FLHzgbC3Rqz0dSM5Hjv1guICmZ77fMSgVN9LH0rt6+Y/0sGn9yQPiWUDMlV7lldub46r
         NA8bUGuGalHMCtFJX4ws69kfzeQmuUcBJ0VVXKmipajhuEXYYoyj3JbC+nO/ij/smBv4
         3ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDpggDKNfWVkL4QKwUKTVv1OeV29o+9xUog3pjIdBMM=;
        b=HZ17aIFIsfzoW/2XbZjGV6J8w33tMWHGGaZ4KmbJ3oNkcRZ4zlJR3hjb5UatDEUYUp
         f03yBOajXYdkw7I78AMQMhU5YfNsNZlkFbH0/FVpEIYrQ3p39v8SrPnWgR3WF6ON7ma9
         XW7mSX0Pk6CS5onD9khgj2QY79CzegCB0x63Fn/ML0qAC6nlUHKyFJ81KNIDtEMS6diT
         FBVBRsKTdAASpsYwX0GD73WWNxACbA4P9FCUYVLLZPgawRZEZFE/xkyLvg6I6G1pP7z3
         /vDhVCCnl6rI+oi/KOaH3Ry5cLjYmENoLPoig2Ca5YwpYLcCplQh8hf/1LHqpBXRIYCW
         k4Qw==
X-Gm-Message-State: ABuFfojTpKiommNdqYCy34oAjQZtM4p3ighqqPB/YtrytT1CNDLBLSHc
        Ye+z5ugLl+533Kg1cFpLV73CZ2s9VjtRY9QvyuM=
X-Google-Smtp-Source: ACcGV63EB+HRFxxMm4eToKDbDWRT8IbDd7r/5lGMbXC1qbZfkJt6uczC8GTML+r1Sa8E2m1iwl9cg85j5HiGFrBvknc=
X-Received: by 2002:a6b:1505:: with SMTP id 5-v6mr13763676iov.56.1538931919525;
 Sun, 07 Oct 2018 10:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com> <s5h1s98s78q.wl-tiwai@suse.de>
In-Reply-To: <s5h1s98s78q.wl-tiwai@suse.de>
From:   Connor McAdams <conmanx360@gmail.com>
Date:   Sun, 7 Oct 2018 13:05:07 -0400
Message-ID: <CAM8Agx0on73x9p3S54UB-9fY+5rRXFeP1m7TFr2RmQmuQPR-yQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] Add ZxR support + bugfixes
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have fixed the microphone issue, and will try to get the patches
written by the end of the week so they can be in the next kernel (at
least I think that's what Takashi Sakamoto said, two weeks from 7 days
ago). With the two suggestions by Takashi Sakamoto, do I need those in
order for it to be merged? I will work on them regardless, but with
those it may take me longer (they might be simple, I haven't dug into
what they require yet).

Let me know.

Thanks,
Connor.
On Tue, Oct 2, 2018 at 11:23 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sun, 30 Sep 2018 05:03:15 +0200,
> Connor McAdams wrote:
> >
> > This patch series adds support for the Sound Blaster ZxR, as well as a
> > few bug fixes. This should be the last ca0132 based Creative card that
> > needed support to be added.
> >
> > Also, I did check to make sure each patch compiles properly this time,
> > but you can check yourself just to be sure. :)
> >
> > Connor McAdams (11):
> >   ALSA: hda/ca0132 - Fix AE-5 control type
> >   ALSA: hda/ca0132 - Fix surround sound with output effects
> >   ALSA: hda/ca0132 - Add ZxR quirks + new quirk check function
> >   ALSA: hda/ca0132 - Add ZxR pincfg
> >   ALSA: hda/ca0132 - Add DBpro hda_codec_ops
> >   ALSA: hda/ca0132 - Add ZxR init commands
> >   ALSA: hda/ca0132 - Add ZxR DSP post-download commands
> >   ALSA: hda/ca0132 - Add ZxR input/output select commands
> >   ALSA: hda/ca0132 - Remove input select enum for ZxR
> >   ALSA: hda/ca0132 - Add ZxR 600 ohm gain control
> >   ALSA: hda/ca0132 - Add ZxR exit commands
>
> Now applied all 11 patches (with Sakamoto-san's Reviewed-by tags).
> Thanks!
>
>
> Takashi
