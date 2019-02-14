Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A23C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943CB222DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvecI/wC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394905AbfBNRwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:52:21 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43809 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbfBNRwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:52:21 -0500
Received: by mail-ot1-f51.google.com with SMTP id n71so11929921ota.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+CQQ4sqd3HTdAH4Z+JWkYWdl3h+ZH3GKYotMk4xl/g=;
        b=PvecI/wC/y+v3HPOSIq443SAggQcmNq3r9afBFLvACx8Uk1CE79YFAdWxzqGnaZx0F
         6d+LzjzL6q1GfHLh9sLfLS49AFFga/yrsbx458ASEuCnhprd+CXUYcLL40PYmCwdAo6v
         9vRkwwWnmOYuc2MtQ0KXYrplBigF3kmMhsOFQX99pUXqogo8ztJvBW7cOAOmrBY7GbnJ
         LXCipJRuTO7fJjpnjk5IcQJ00oWfYEi1XHw6L7E2oUcbeJGMfvZUWAqrM+ZvXfS13YbA
         iIQQjLTiYWyx5nv1F76iP++AHEA8VSubSk59KCPAuTb6CvAr30CLeX0hW6keEm3fiHzl
         /xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+CQQ4sqd3HTdAH4Z+JWkYWdl3h+ZH3GKYotMk4xl/g=;
        b=atWjgNbNNucbJ/9OOPAHTgmxkZyB9jh1uPn8LvV71SJCQBsB5aFzwhMjInqjfYm7ga
         xQSFjvX8EZJApvegIpACAdIoDUMtDmGjQ/nOLSxpwnRRUzj/+hY+eRnPfQRPfbdcQEzx
         Zan8TfeGZDQQ6o1QtBLHW6YxXR9IH9PB2FRVQ2IY/gbUurcAPnqEC3WZuYGnwxSi+qtj
         KpxWUmTvGFWqHMKFCqc5q0smpmUxmE8UlvRlf9q/XitlwlM7zBxIHFicM/QY6CW5jA2K
         Rryr9ETgQh3jv5T4xtTd4zDAmc2EvpdRB06pX0GXKeO2FMuwQUq5D5WA3za8XbVs7cay
         gWZg==
X-Gm-Message-State: AHQUAuaGwGPNkpXWvOuWuYquH29ZJGI7+dhmrUKTJ/CNtHInPN2nA2M+
        +rrpe/EZUrEGDswJhrx4ERoWRJqQg+biY/JwSKqfmw==
X-Google-Smtp-Source: AHgI3Ia7gA3+S8xbI6k0y68jWxb6PRf+GIk6/SfnKOjYX6gwhWNIxBNCDRM6sexTk8nFMEFmwbCSnLXGPRiZ4IDGGQs=
X-Received: by 2002:a9d:781:: with SMTP id 1mr2995261oto.250.1550166740673;
 Thu, 14 Feb 2019 09:52:20 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUTJ0TjdTu=UB9yXRJ_mXG8LPmcuBQBDha+T5RHoRUvcQ@mail.gmail.com>
 <CAGngYiXcogd69n-MvBD1n5ZJpBzqCau8UOfLMgXEXLnAev=srw@mail.gmail.com> <alpine.DEB.2.21.1902080745480.4201@hadrien>
In-Reply-To: <alpine.DEB.2.21.1902080745480.4201@hadrien>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 14 Feb 2019 12:52:09 -0500
Message-ID: <CAGngYiU-W6ipt0ZEPwbAY6onOjcWuvYfBRtah4dsEVi+URhE8A@mail.gmail.com>
Subject: Re: Fwd: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Julia,

On Fri, Feb 8, 2019 at 1:57 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> > - is this important enough to ping back to authors of affected modules?
> > - should this be added to the kernel as part of 'make coccicheck' ?
> > - does this result make people "feel better" about devm_init_work() ?
>
> If the answer to the other two questions is yes, then the answer to the
> second question is yes as well.

Some maintainers seem to accept the patches created to fix the issues
flagged by this script. So maybe it's worthwhile to try and get this
into scripts/coccinelle.

Before we get started: even in a best-case scenario, the script will flag
issues which should not, or cannot be fixed. This could be because
they are false positives, or even because the author/maintainer does
not wish the issue fixed. So when the script is run, how do you 'filter out'
warnings that should be ignored? Is there anything specific I
should add to the script to accommodate this?
