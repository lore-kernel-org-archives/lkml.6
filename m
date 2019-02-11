Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E53C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8E32184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PiojzZ6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfBKXSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:18:23 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33202 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfBKXSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:18:22 -0500
Received: by mail-vs1-f67.google.com with SMTP id k11so465941vsm.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 15:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Qz8ODHkzIZKJF9S1SR/qImm6fQJbGaGKVmJiMCoO3Y=;
        b=PiojzZ6pT87KyLWfn4wr2y+PjdwzlG0xh9ULcIgvSW1hOUvDZc9wsK6NvUYtAtJtOp
         T0g8tV3d2vtfpAyhG6RaLiAwI3Z4xrmmmhEJvTAjrRxEk1/oDWWIZ310t2uynvXqFjMh
         z36iA/akXMaLofWmZB7pEz79rwrXKXziMlPlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Qz8ODHkzIZKJF9S1SR/qImm6fQJbGaGKVmJiMCoO3Y=;
        b=LQV1Ltjd/Fig6EXXyGrWG2viqMH4pFtK6JooXd1BSlSS6wOIM/2oXjkkQJV9/gdngw
         /ZbeHS337+UNAAZjgRnMngSu4yJee8HpstLIekZOH9S/SAbJT4aQ//WF7hxuRgpvW9Ba
         Ez+iJT78xGMUYLuxCql9efjIHpr7dbqz57UYiKcGgx3nPdrQsRvkcUprsGEfTJGRcca9
         fdpObusuI+vWBWULE6+4qbCLs+hOrGT5dukQpLlKkWKuZf5dtNB3WxgVDprh0c1Zaknt
         zbhw9ABjvc0VuIHDnUxGYSFtkjDKc2akkkhVZLbiKUGgg/J/3RfcsY/DijBbJ3QlI1Ae
         un0w==
X-Gm-Message-State: AHQUAuaepx1VrKsPrsM2+ih7vR7L3raHxqc0T2xSoIGoNViAC3E0XTJp
        hN9jF2Y7U5T8n7lNSkVfmAhof0y8G/g=
X-Google-Smtp-Source: AHgI3IYATF0+K+NZIicEt9Xeb7iMemIzZ1jylRo/d+9DCLLjTYPABs7Wil5bzLNWE+jfZCy14d8fZw==
X-Received: by 2002:a67:7848:: with SMTP id t69mr295258vsc.211.1549927101083;
        Mon, 11 Feb 2019 15:18:21 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id l10sm12324456vkl.54.2019.02.11.15.18.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 15:18:20 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id n10so412054vso.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 15:18:20 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr338916vsc.48.1549927099716;
 Mon, 11 Feb 2019 15:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20190211225403.GA7769@beast> <74310e83-a258-e9c0-7d98-8b2cc5ced3a4@schaufler-ca.com>
In-Reply-To: <74310e83-a258-e9c0-7d98-8b2cc5ced3a4@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Feb 2019 15:18:07 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLvwLxWWiyM4ThJ=eKzDniy_w2Eaizc-h5tK4x7oCEG2w@mail.gmail.com>
Message-ID: <CAGXu5jLvwLxWWiyM4ThJ=eKzDniy_w2Eaizc-h5tK4x7oCEG2w@mail.gmail.com>
Subject: Re: [PATCH] LSM: Ignore "security=" when "lsm=" is specified
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 3:10 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 2/11/2019 2:54 PM, Kees Cook wrote:
> > To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
> > used on the command line, and report that it is happening.
> >
> > Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  security/security.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/security.c b/security/security.c
> > index 3147785e20d7..e6153ed54361 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -288,9 +288,13 @@ static void __init ordered_lsm_init(void)
> >       ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
> >                               GFP_KERNEL);
> >
> > -     if (chosen_lsm_order)
> > +     if (chosen_lsm_order) {
> > +             if (chosen_major_lsm) {
> > +                     pr_info("security= is ignored because of lsm=\n");
>
> This is a little awkward. How about "lsm= supersedes security=".

Fine by me. James? What would you like here?

-- 
Kees Cook
