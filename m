Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6C8C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007A720815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjxfD8Iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfACJFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:05:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54728 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfACJFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:05:02 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so44363507ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 01:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4aZoFYaINGL7pTaVqfSrKOmWw9hdsGePz6tgKZ2uWxY=;
        b=ZjxfD8IyYGCExepiHX8hKBG15pr4PgawwZoPPf7SsJXOojydvRzQNfLRHEh0YMpSD6
         mE7wgfinQEQJZ80QeA3hi0kQUOHe/bNmQtA9JvnXEe8PDhHRwuIDbUMK95CMfQC51GUi
         /te2NOkL7lh7Vr7jcdDvnvHgduvW40utgfOn325+oMAK9q6gFcWiH/oJkCxCm0WfyAy0
         9gueVwfHxF/rKZ5Kz1QUQJS8UkdvmuB9+Mmq9cy0Tgnlw/ANb1ZSN3ZgEBYGnT31WOVy
         V8j765pSZI7m8LyBOSBw29d8cd/fsjjjGc/vn3jLqaiwEVJuOjBEqmMBhQjqH+1n1ZtX
         j+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4aZoFYaINGL7pTaVqfSrKOmWw9hdsGePz6tgKZ2uWxY=;
        b=ViQkRP8dxqHhebt0vKUMUF//bjU7Y/Gp40ef5CTV+It24PYWEAZ9CbxZO6kJE62/oC
         k6uSJCgH8xvUthtkUVj9A782l5VnPoRmgv//7YMYcwaVOPUUz9+4OzkSwlDNH4MNfPN4
         R1ey+6a016Fsxx1rdpUHBRcUh4jaQQ9d9+p4BUsTlfCHaKSGrle5+oYycXvvrESEYfZq
         noq7IQuKmhDdwjGpgYNBJA06s3uXsgfCfzaU3tKH86g7urRUlvs86EPspkTLF3GfzuQw
         1FgZoNo2nBSqzJJztQnCqT72lSMXEmnd0kFMVrO0FnPDa2vUUhtOfAVIIc9BCf6aQNtT
         ymxw==
X-Gm-Message-State: AJcUukeJlWiN3GjvohQFXy1ngVI90NYyW4ZuYCAsps0z+Yt3YncxBqtp
        ZAIxgMyfsf9FYwEZKNSVlPDquCCwHVtW8QH/mnWTYg==
X-Google-Smtp-Source: ALg8bN6k4E646mZdy71LIAzgelVkqYiQ7Xxmx0/yCvuhOnZ2sm279Suj/H49jw69ylVA3D96z3HYYqKs5Kg8Elyg3Pg=
X-Received: by 2002:a24:6511:: with SMTP id u17mr7968458itb.12.1546506300844;
 Thu, 03 Jan 2019 01:05:00 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f56975057e374c46@google.com> <fea9b565-06e4-fbb5-7e92-efd133a7028c@linux.intel.com>
In-Reply-To: <fea9b565-06e4-fbb5-7e92-efd133a7028c@linux.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 3 Jan 2019 10:04:49 +0100
Message-ID: <CACT4Y+bKqXknE--kTngznowLaY1b9h5oGWdWBR8w=nHv8F90AQ@mail.gmail.com>
Subject: Re: WARNING: lock held when returning to user space in set_property_atomic
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     syzbot <syzbot+6ea337c427f5083ebdf2@syzkaller.appspotmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, maxime.ripard@bootlin.com,
        sean@poorly.run, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 9:55 AM Maarten Lankhorst
<maarten.lankhorst@linux.intel.com> wrote:
>
> Op 30-12-2018 om 07:21 schreef syzbot:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    903b77c63167 Merge tag 'linux-kselftest-4.21-rc1' of git:/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12d0f553400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=53a2f2aa0b1f7606
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6ea337c427f5083ebdf2
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120d906f400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1024673b400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+6ea337c427f5083ebdf2@syzkaller.appspotmail.com
> >
> > RBP: 00007ffe369ca7a0 R08: 0000000000000001 R09: 00000000004009ce
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
> > R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> >
> > ================================================
> > WARNING: lock held when returning to user space!
> > 4.20.0+ #174 Not tainted
> > ------------------------------------------------
> > syz-executor556/8153 is leaving the kernel with locks still held!
> > 1 lock held by syz-executor556/8153:
> >  #0: 000000005100c85c (crtc_ww_class_acquire){+.+.}, at: set_property_atomic+0xb3/0x330 drivers/gpu/drm/drm_mode_object.c:462
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
>
> Just guessing..
>
> Does this help?

Hi Maarten,

Please either test or ask syzbot to test:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches

> -----
> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> index cd9bc0ce9be0..004191d01772 100644
> --- a/drivers/gpu/drm/drm_mode_object.c
> +++ b/drivers/gpu/drm/drm_mode_object.c
> @@ -459,11 +459,11 @@ static int set_property_atomic(struct drm_mode_object *obj,
>         struct drm_modeset_acquire_ctx ctx;
>         int ret;
>
> -       drm_modeset_acquire_init(&ctx, 0);
> -
>         state = drm_atomic_state_alloc(dev);
>         if (!state)
>                 return -ENOMEM;
> +
> +       drm_modeset_acquire_init(&ctx, 0);
>         state->acquire_ctx = &ctx;
>  retry:
>         if (prop == state->dev->mode_config.dpms_property) {
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/fea9b565-06e4-fbb5-7e92-efd133a7028c%40linux.intel.com.
> For more options, visit https://groups.google.com/d/optout.
