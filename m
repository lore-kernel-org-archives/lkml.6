Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F821C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF9D20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Py76GZPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfAQQNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:13:07 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44949 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfAQQNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:13:06 -0500
Received: by mail-vs1-f66.google.com with SMTP id u11so6524249vsp.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POIHIy8WHIt7GfVYplk/uxHt/+BaFsTKEnF1REbZlzE=;
        b=Py76GZPTeAwOpO4nfHEIyH/vLkv5AXrAv9ihlhocX71Q6xdTarNC7Ut3iJCUuYpN/6
         J9dxhlc6HkIoiK/DhcRBfNoqaI6akRrDQed9zS9eevdJqpp5NO3gEqVOr8z5cVpspTKn
         CAvPb2PzyzwWB1UoOkqOvm03SuMJVVpiDKS3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POIHIy8WHIt7GfVYplk/uxHt/+BaFsTKEnF1REbZlzE=;
        b=Yk0+/wwxTwFqZZUIuF/g9QFC5cOJQX0K5xEodDmTPMXnn1dPHCMrT9cR82iscedrpl
         Ngmt+7N8lMR7t2QHNtl6wW1i5ymnL1W3efUrrDRfSfzVNmRbC6G/j2xlcVe/ZPaCpzn0
         Aenh4QpEUpv+Fdtv6HiC6SN9RIR8xtV9ZR2tl2j1pFd5HlFS7kcaNGVxMt0FJBxaK0Mo
         rgO0Sl2weN53C5fM1Bsi6MHLwA56m/DItFWZpZk3y1szGhrG17xVFVd4X1mFU2npr+Hn
         mbdHTJMvzq1ehfqJe3IqWlkq++SZaF8f/Rwk5QimDqZ5UM3VCIaJJsekp9KobFKw8VPV
         TaKw==
X-Gm-Message-State: AJcUukcsiDZZJry0qiZrCuczbvCLiloA8DLrJ5RwtzNetboM6O1qb4Pt
        h/j7pZ96f5I6n4TNEHE2XW8jYhnT994=
X-Google-Smtp-Source: ALg8bN7wCFCXJ3N8XCypsUUeMjpBqiGpBbNO7Xz7CM/zgLl1aE0IMeghnaEZ+Guz0jicmX6QeIqILw==
X-Received: by 2002:a67:c01d:: with SMTP id v29mr2671755vsi.124.1547741585679;
        Thu, 17 Jan 2019 08:13:05 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id s195sm21506937vks.28.2019.01.17.08.13.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:13:04 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id n13so6567310vsk.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:13:04 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr6343351vsc.48.1547741583684;
 Thu, 17 Jan 2019 08:13:03 -0800 (PST)
MIME-Version: 1.0
References: <7cd7d5bc-1d69-57f5-4a98-81b036f81682@kernel.org>
 <CAGXu5jLGqXstRCmM1_fxUxn4djs1YLUun2Fc8ExcaN4-CKyELQ@mail.gmail.com>
 <20190117004416.GA17449@cisco> <f665bb74-293b-d627-2605-5b8de7671743@kernel.org>
In-Reply-To: <f665bb74-293b-d627-2605-5b8de7671743@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 17 Jan 2019 08:12:50 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ0VK4UiOeKTqv_TZSn5aZAVsXjUZgiXD=KFbZ-Ng_+KQ@mail.gmail.com>
Message-ID: <CAGXu5jJ0VK4UiOeKTqv_TZSn5aZAVsXjUZgiXD=KFbZ-Ng_+KQ@mail.gmail.com>
Subject: Re: Linux 5.0-rc2 seccomp_bpf user_notification_basic test hangs
To:     shuah <shuah@kernel.org>
Cc:     Tycho Andersen <tycho@tycho.ws>, James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 5:26 PM shuah <shuah@kernel.org> wrote:
> I am running Linux 5.0-rc2 and not an older kernel.

Weird. I couldn't reproduce this on 5.0-rc2, but I did see it on a
kernel without seccomp user_notif. Does the patch I sent fix it for
you? (And if so, can you take it in your tree?)

Thanks!

-- 
Kees Cook
