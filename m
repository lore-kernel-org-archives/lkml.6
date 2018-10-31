Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5F6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F052084A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrEsewnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F052084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbeKAIai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:30:38 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45837 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbeKAIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:30:37 -0400
Received: by mail-vs1-f65.google.com with SMTP id 124so11153716vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtQH7+VlIPJvqHuErN8wezZ8VBDVAx5jnhNjxzFm3kA=;
        b=qrEsewnY+t4jX4U05jF/Kx4jTbnEe38Z2ihgWj77fURbXyk+e6LLFsBpcmavx68skf
         OGEIwQLKR8iD+WyW42XZS6MSkDMbegQfik2GGRHVB2zZdVgqFGHtGwB/IxhntvBd1+5J
         32Rcg/KK9mza3H29w7X9kF7TeC8g9YlTFbDhatsHePgsrKyMFAQ+j/9OL4R4RUK0OyX8
         uiCxGBZi9m+e5qji+4C/Oq/vmKDvWPE6mm4Fqh37UYrWug3gBHtDIJ8yED2ztWJYWKtp
         aZ4fANm03MGwOp3rTS3cF6sn5WRJe98blNqhSMmq1XK683b08rkaHVTIMQONuL8SByVv
         JVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtQH7+VlIPJvqHuErN8wezZ8VBDVAx5jnhNjxzFm3kA=;
        b=XugomNbJJt9gFUYwvYJZfkIB1e5T23gn0Na/vYGskPWyGlRkOwub/2U+wOxmbUqsGj
         H6h8NZVxYeqS3M1s1sLeTRg2HoqwkW3VNF8KDSHuOu5CsjSm0aZU1ecTw8IiW61KXc3i
         ckgQi0Ikc0CFbhl7UrhUprp6YfVqETgXt0Y9I7AXiPMJFLeEGZwuwKvHVX2JSFPioKzu
         eW3nc+fHGq05UL17hECD+Z3MQ63gqsci37TtzquOkvOejrnNs2amL7hFJyrR9/bn7ESQ
         +Cn+d1mHx51h6jX8W5CqWJdDZBiXDq+0F64PqPF6xAxPfXgfeQB6DHXZ0DEz4OP0PORF
         MWgw==
X-Gm-Message-State: AGRZ1gKZxtkp2jGzK6ZZAmbevf49PKUi8WtTC4bXXDKaMaAqI5qTgleB
        nZmdXZqa9KBq8NbF32QncqN4Cz9woMrvVOFdN/eKH3ms
X-Google-Smtp-Source: AJdET5d7eHSXGLwz0mA9PDQdk2J9BEbcRlyXX9akuB/uAcP8p8gDt9gBvVaeOaMyOP6cihRfHb8HRNNFCLFRVWB6nTU=
X-Received: by 2002:a67:60c7:: with SMTP id u190mr2253775vsb.85.1541028619223;
 Wed, 31 Oct 2018 16:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181031205737.cingeaqget7hkbs6@smtp.gmail.com>
In-Reply-To: <20181031205737.cingeaqget7hkbs6@smtp.gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 31 Oct 2018 23:28:59 +0000
Message-ID: <CACvgo535WoPfiaHzwd=UW11iKid7a2VPg+fYX1_VTLjO-WRzMg@mail.gmail.com>
Subject: Re: [PATCH] drm: Rename crtc_idr as object_idr to KMS cleanups
To:     shayenneluzmoura@gmail.com
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        outreachy-kernel@googlegroups.com,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shayenne,

Welcome to DRM.

As far as I can see you're a newcomer to kernel development, so I'd
recommend watch a recent talk from Marc [1]
He provides a very good introduction, both for newbies and for people
willing the know the deeper reasons behind.

That said, here's some suggestions:

On Wed, 31 Oct 2018 at 20:58, Shayenne da Luz Moura
<shayenneluzmoura@gmail.com> wrote:
>
I'd rename the title to "drm: rename drm_mode_config::crtc_idr to object_idr"
The "... as ... to KMS cleanups" translation is very strange in
English. It confused me and I've read the TODO over a dozen times ;-)

> Rename 'drm_mode_config.crtc_idr' as 'drm_mode_config.object_idr',
> as proposed in the task description in TODO list for KMS cleanups.
>
Similarly here.

> Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
> ---
>  drivers/gpu/drm/drm_lease.c       | 6 +++---
>  drivers/gpu/drm/drm_mode_config.c | 4 ++--
>  drivers/gpu/drm/drm_mode_object.c | 8 ++++----
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
As pointed out in the talk - always self review and ensure patches
don't break things.
Here, DRM doesn't build which is obviously not correct and breaks things.

HTH
Emil
[1] https://www.youtube.com/watch?v=LIdznotOxvg
