Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B38C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9D3218DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JrymG7lJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfBHVd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:33:27 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43897 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfBHVd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:33:27 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so2972962vsc.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9oSgnPm07vwmWODWGHcHoCNDCiBPV7B6kOG9r5qu5s=;
        b=JrymG7lJoXWsdlGvV/4XrNQKV5jFNCCv7L/CdKsF5P4YfcP2Qdm6BaAisbUTma5Sr5
         5ZEj6Lg+JfPditlcaBaxH5uT/4F4vpWUSDCUoD6rEub+eC2hLSdRykft9yOhldj1bq5D
         O2qgglxnNx7XN59JI0RXLfuJ2BB5TsBgpdRMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9oSgnPm07vwmWODWGHcHoCNDCiBPV7B6kOG9r5qu5s=;
        b=WeIxocGWrM/4yk9RmgNJlVWCDrHKs6jQiWiRW7Y/CGzkvqwyUBP0lCoW1qD1iFuD5V
         PKT5odyksuTBny0BpgxM3Wyha8w3gx6x9tKL51u4zgg4bJw8NZafszggtVVjHHnobI3t
         RsMiDetixPx/YGvq7ayXNUah7xOjvATvxk49ZvnhJEH2bJ+alroUsni122JA+dMboKHV
         6StI/8/50vc+r33pKhAHC6aCtX3QwzFqqN0UVlyGL2+Vk+84ubQQgka/mpbkSlQ9bamG
         hN/iXM4YdTZPeWaiZZzBxr3NqKFq7thph9avOFdyRo/uNaAmTRbyzXBP+RKbz7B7MYeB
         ahLg==
X-Gm-Message-State: AHQUAuY9Tpp8GXcEV7/u0iv4J+KLmNQt1hvb+L7DSk/c6f7HmoqVQneE
        eiEsQ1IvPdmt3AkWDvgacU4lSFxO+GI=
X-Google-Smtp-Source: AHgI3IY4QxLXOIlXalnk75eW6CBJhkKzQtd1nmCAewq53E+Cqi5vafI4fr/JRLBPrWNZt/NAsbavhw==
X-Received: by 2002:a67:f9d5:: with SMTP id c21mr1638222vsq.124.1549661606141;
        Fri, 08 Feb 2019 13:33:26 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id g195sm1034698vka.5.2019.02.08.13.33.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 13:33:25 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id e7so3010596vsc.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:33:25 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr9843074vsd.222.1549661604836;
 Fri, 08 Feb 2019 13:33:24 -0800 (PST)
MIME-Version: 1.0
References: <8f48e1d0-c109-f8a9-ea94-9659b16cae49@i-love.sakura.ne.jp>
 <0d23d1a5-d4af-debf-6b5f-aaaf698daaa8@schaufler-ca.com> <201902070230.x172UUG6002087@www262.sakura.ne.jp>
 <6def6199-0235-7c37-974c-baf731725606@schaufler-ca.com>
In-Reply-To: <6def6199-0235-7c37-974c-baf731725606@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 8 Feb 2019 13:33:13 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJm+qxgnmRjJtTuaqj6N7WP+TVF4tUm30WUmMDT3irvFg@mail.gmail.com>
Message-ID: <CAGXu5jJm+qxgnmRjJtTuaqj6N7WP+TVF4tUm30WUmMDT3irvFg@mail.gmail.com>
Subject: Re: [PATCH] LSM: Allow syzbot to ignore security= parameter.
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@vger.kernel.org>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 8:24 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> I added Kees to the CC list. Kees, what to you think about
> ignoring security= if lsm= is specified? I'm ambivalent.

This was one of many earlier suggestions, and the consensus seemed to
be "don't mix security= and lsm=". Why would anyone use both?

-- 
Kees Cook
