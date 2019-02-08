Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6801C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3DF20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKs3hDcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfBHSPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:15:32 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38595 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfBHSPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:15:32 -0500
Received: by mail-ot1-f49.google.com with SMTP id e12so7360192otl.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fC1RvnwFrYgz6BCjd2ndzz+PsaKqX+zYFD4OnGitx8=;
        b=RKs3hDccshU9rxJ1dhh1rmEhFOZnI/yvDlvfA5O6Xi1hzA8zs4oYuZUu5P6uUSsnx6
         /4/MvViu1Lt+q30WoR9FjS36nrNZiZpiHpAuFfqsffxIy8sO5c31QYgD10EGQH2JeQKw
         Q2GFziY4CQBVIFpVaWwD8tIZ6G2hpe3jzT5YEKGS9xjLnWeMWg18fgdOMGRAzzF5Zvgg
         nsbYtgJjaQnPf+1VG3PM675zVbdH3pIXgc+t8yIsEpmtAbC0D1ZAMu2NCAlPKD3xKRB6
         csO8VpNOsxDNVBIbNI3RxloqStsv2NSsIVyWXfsFJ+iaE/tq5JcuG4Trm5vRlMaftG+6
         NnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fC1RvnwFrYgz6BCjd2ndzz+PsaKqX+zYFD4OnGitx8=;
        b=QOgYS/9fCZR6YQmtsfLaBd554PuqXZ0BOEcs9yfaxTmdgJW6tURq/x1/NnQnmwwt8C
         3vLjR0SnobalehvC0l5QjmeieAMIQCqQCcGfKIXhzlBSX2drpGK060h6S2vMa2fOTn3a
         ku3cwmIV2pRuisrzGxX0PJZy18IVoGoIkv8bTZpw5y38AaXgoNAJ5PC+JnCbO3+Z5HgR
         WpUx68Nuta5rZbkz0OI5x1cLVeJrBF3ySP/K7ePpUiASRbCC91Btv5gW+/M5szPKOkXt
         Yo/BhhVbBbO0kUhetnwxhKwuw8dGmGOSsDC8COAIbw5yeR6vqYEpmTiRfbefbxBMnHzc
         3YmA==
X-Gm-Message-State: AHQUAuZ2eJ8FbjADipwF/MphkIsGNqYI/PlU4qaMdQV44faV0kosP0Gu
        5dGokQRANidoeKFFpWCnn3EO0qseff3Jqo2n/lA=
X-Google-Smtp-Source: AHgI3IZKYBMp3sY2O/vyhcuXt8BERMfG9FzlKUG0EAYhcWArX8R7YqjbqVLnIcAIKVBALjoDk7yTsYtYsVAsIOri8IM=
X-Received: by 2002:a9d:4504:: with SMTP id w4mr716223ote.18.1549649731313;
 Fri, 08 Feb 2019 10:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <20190204220952.30761-2-TheSven73@googlemail.com> <20190208170656.GL50184@devbig004.ftw2.facebook.com>
In-Reply-To: <20190208170656.GL50184@devbig004.ftw2.facebook.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 8 Feb 2019 13:15:20 -0500
Message-ID: <CAGngYiUFQKpTUQKJtWvDftmntueb=e2AXqX=OhJLaRDKxzKxYg@mail.gmail.com>
Subject: Re: [RFC v1 1/3] workqueue: Add resource-managed version of INIT_[DELAYED_]WORK()
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Fri, Feb 8, 2019 at 12:07 PM Tejun Heo <tj@kernel.org> wrote:
>
> I don't object to the basic idea but cancel_[delayed_]work_sync()
> works iff queueing is disabled already, so there can be situations
> where this can lead to surprising / subtle failures.  Given that, it
> *might* not be a bad idea to keep this explicit unless there is a way
> to reliably block future queueing.
>

Yes, I'm "coming around" to your opinion myself.

There's also the question of which one is appropriate for clean-up:
cancel_work_sync() or flush_work().

And what about work scheduled on more than one workqueue?
Or work scheduled on multi-threaded workqueues?

The workqueue API sounds too complicated to have a devm_
helper. It would lull developers into a false sense of security.
