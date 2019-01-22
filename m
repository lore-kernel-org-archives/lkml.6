Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B8EC37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D762085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XQmTqNDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfAVAvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:51:36 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46005 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfAVAvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:51:36 -0500
Received: by mail-ua1-f67.google.com with SMTP id e16so7498717uam.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 16:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IxTrGZqf1bikahyQhxhLMNzWDIioHKwPEhCnb5vvY/M=;
        b=XQmTqNDMLZqNE8VFEHc8fjMhWSQ6mVkYXOKpHgNKQd1a480aJnETKLHOGOlsp7mD0v
         AnJ3CwFKbUD+c/bzNfTV/EspNHHj2nP21PbgK+xNNqheKhg0lvQm0xHszsCFmhFb2twz
         08avTHCDg+JMFwp+0xIllDQj3ZvTzFLSyW41E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxTrGZqf1bikahyQhxhLMNzWDIioHKwPEhCnb5vvY/M=;
        b=RnX9QOY71Mfe6v8VQkxwrReErQVbskFgWasGibWudNU0G9UUhuiLR194f3K9nzPISd
         aRUfyNa5J2gJV+0ELnmbJT94jyJ8Ubv9YjtGKMvQIG1ajldGAJIqG2qvgO2Vf29dCUTs
         SWSvxBTKEA66yzR3q3t50Xqs4ohm2K/ZhOB99KI2gCo8gwG1v84cZM/c5F1Xd0FMpdYa
         Dw94+Y7/8MxvrRgjXdkZvpkBt93ZvJFu9KIEvDV23Rl15dQ+A/5wp/ohKTKGVeTJwQn/
         IYIrcSRxlLOQCHUwJb+TVExQ/rxmQdcV/JSnLtJx4MGTX5zUfUME0tJPlpLXQhFKRe3D
         nWeg==
X-Gm-Message-State: AJcUukdzi6fmUBWXXj5mS1wOUCjfXYHYebZoSjEjAmMFRFST//S2vX4K
        VY9bxTUmVqx+m1vk0jHPiQRI4ebIL2g=
X-Google-Smtp-Source: ALg8bN6EI4mUK9Bjrhi0FvorMQHq5/Snuybcay/bY4HmMU2qyWbKa5z3uj1ArniSgn3f8KlCSGp1mw==
X-Received: by 2002:a9f:3193:: with SMTP id v19mr12737339uad.55.1548118294332;
        Mon, 21 Jan 2019 16:51:34 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id l10sm97715127vkl.54.2019.01.21.16.51.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 16:51:33 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id n13so13735836vsk.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 16:51:33 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr13220885vsl.188.1548118292735;
 Mon, 21 Jan 2019 16:51:32 -0800 (PST)
MIME-Version: 1.0
References: <001a113f711ae2110c055f45acb8@google.com> <20171212220647.GJ185376@gmail.com>
 <CAGXu5jLcuE-h9V04fTtoSfz9mZdVeH1zfJOpRncK2NZkv2gsnQ@mail.gmail.com>
 <CACT4Y+aeSz05wDyStT75OFFi_aTyxbfzz7Z6jJ6FJsLNN3Pdtg@mail.gmail.com>
 <d1e2488f-a969-30d4-5023-6fa85a4e3833@I-love.SAKURA.ne.jp> <20190121211800.GC2217@ZenIV.linux.org.uk>
In-Reply-To: <20190121211800.GC2217@ZenIV.linux.org.uk>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 22 Jan 2019 13:51:20 +1300
X-Gmail-Original-Message-ID: <CAGXu5jKYW46a-ZJF1YDN31FMiMpnsinbVReMrygYV0a2jo815Q@mail.gmail.com>
Message-ID: <CAGXu5jKYW46a-ZJF1YDN31FMiMpnsinbVReMrygYV0a2jo815Q@mail.gmail.com>
Subject: Re: [PATCH] fs: Allow opening only regular files during execve().
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot 
        <bot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:18 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jan 21, 2019 at 07:14:39PM +0900, Tetsuo Handa wrote:
> > On Tue, Dec 12, 2017 at 2:06 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > > I'm not sure what the fix will be.  Maybe the proc handlers should take a
> > > different lock instead of cred_guard_mutex.  Or perhaps execve should check that
> > > the file is a regular file before it attempts to open it.
> >
> > We can easily distinguish open() from execve() and open() from others. ;-)
>
> > +     /* The file or a script interpreter has to be a regular file. */
> > +     if (unlikely(current->in_execve && !S_ISREG(inode->i_mode))) {
> > +             error = -EACCES;
> > +             goto cleanup_file;
> > +     }
>
> We are *NOT* going to use current->in_execve to propagate that information.
> Come up with a cleaner solution, if you care, but this one is a non-starter.
> Too ugly to live.  Sorry.

What would you suggest for a cleaner indication of being in an execve?

-- 
Kees Cook
