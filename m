Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523B6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137DE20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IqmxIbmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137DE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbeKGApG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:45:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35074 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbeKGApG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:45:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id 81so11750712otj.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 07:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CT7v4DQ09v3qvwbCogv4FsUWAqnPJyTXp0JhFTTMed4=;
        b=IqmxIbmkn9dUfkcnvsYUEFL4EldPsXQ5y4nzzMeUYmy5KJTVFBx8OktDujcvringmR
         zX7Kc+jzfXKkLN3tHu5OorqFJvU+gWKiSuc0gZvqFI70IG4VNmKbYOUPUr6P1Pdvaznv
         EzoqpE0LeRTCMq1Jn0pjqTVjVNEqp6wk5Jd9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=CT7v4DQ09v3qvwbCogv4FsUWAqnPJyTXp0JhFTTMed4=;
        b=MPJnrAgwBpClGAS4JAnoGYJTgKTsbwJB+74Ir0Mqcm/gscwlOZBjIb9Zd0uyzU8DOL
         rVaVOMitpGLE2ld6rBJKIxzil1vXdZpzjQuH65kg7XkFcaNZbHBAXpnQySDfpXeX5Xt7
         Aliy1Q4x9aiSUZS50aYCJZtbZdz8nH6/1ly2R8AdB4TjMOjnViNmj5G2x+EONSz2lGZs
         5Svg5XNxwCNBO/WU6TasUeWrGdoE0lIYJoxmNWkauVn0YM+cytqXkQufNVW7PFJcnnFJ
         iPX7rhK1BOo4maSFvXgDzbJT86xExdaH+JI+N0uj2N6v2D6HXAWIgRFVgy1XhC0frcSy
         Jf3A==
X-Gm-Message-State: AGRZ1gJBrLkxra+kbUlZiT8DRhAxB0esVr+ty8b2I9JSL5egnGj13o7M
        IuH4qY6t8RDXLvjHc1kX/pCZPoLCB4cKNleBswiCRF4=
X-Google-Smtp-Source: AJdET5fTF5FICeFF0t2QZF+yAnlzGpMfds1QlQ3d1zJu1dF61Hxc3Uj8q+kTZOeJ22ObXjMjQF7Cl1e2cN9o+ViuH6E=
X-Received: by 2002:a9d:738a:: with SMTP id j10mr16742980otk.188.1541517563761;
 Tue, 06 Nov 2018 07:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20181106093100.71829-1-vovoy@chromium.org> <20181106105406.GO21967@phenom.ffwll.local>
In-Reply-To: <20181106105406.GO21967@phenom.ffwll.local>
From:   Kuo-Hsin Yang <vovoy@chromium.org>
Date:   Tue, 6 Nov 2018 23:19:12 +0800
Message-ID: <CAEHM+4oLesko3TPGDm2+FTCJT=gYw4fy0YmCQGuT1CTHFZgmkg@mail.gmail.com>
Subject: Re: [PATCH v6] mm, drm/i915: mark pinned shmemfs pages as unevictable
To:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 6:54 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> There was ages ago some planes to have our own i915fs, so that we could
> overwrite the address_space hooks for page migration and eviction and tha=
t
> sort of thing, which would make all these pages evictable. Atm you have t=
o
> =C4=A5ope our shrinker drops them on the floor, which I think is fairly
> confusing to core mm code (it's kinda like page eviction worked way back
> before rmaps).
>

Thanks for the explanation. Your blog posts helped a lot to get me
started on hacking drm/i915 driver.

> Just an side really.
> -Daniel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
