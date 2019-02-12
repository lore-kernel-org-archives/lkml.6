Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6388C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12D82083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3pERqbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfBLOmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:42:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36531 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:42:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so1358696pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWN/Ds4yifyduWyWjng4M5eUe6ihpkX+4HQVzLhVysA=;
        b=D3pERqbtsoIlTIbszyeKTNXPZ+GkLddmdSRUSvwJHDhWYZ0EqlXl5JJAr/GMcG6cjm
         8w5vx8/SDFhkqzbZgsKpqr0f4nZk6teNBoiF5JrHjo07S6czoaoyELtYc71vGpzyzs9l
         NKnFgwCi60/YZdMaMFGrYNIrZJZn2mSb2Q2hCQyeJR0pu0bSXUDOZdvsVvhftOd+WrVn
         CvLXALeXUkj7euauowxZvk3pJCCGMmVB494ZHjnVWNUCk968lBDIAv3zbmoFePfV+G42
         kpqNIiqSitztWYrh796I+tCga+Avu7baBk7xTqV0UC/zalFM85YdC+Wi6QZRI4PmQ/WT
         b3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWN/Ds4yifyduWyWjng4M5eUe6ihpkX+4HQVzLhVysA=;
        b=D6NN/NuLyJOn+sVXHEhwIAJ4X9qwGt8ouD7auPveW/brKRebuseafBYBL3flBefdrL
         6I2L48CDi12rpV9NQ4RADYNThqAwIqlKYY2urfzOoTRHmPsvfZtjZoVjJdS9jmOWDiFY
         GqCbHHlA3Itt7gqRkEXlSXmzOeoSKUpVEdRuIoBLbgYgMcK8VLep9FYwGXqZ0FQW+eVn
         J4JFXXekbh0yeXkgZmyc26cdKIHHhY5qINi238eGOlLfmlsC5/5g160dZgkp5r2/ec/m
         omTZaa8wgVEeovNnFIrGPO+sd/yYw9LrKMzWtTalOpzYjZEwR1Ob9TCS6yP31h4OIHZc
         bHqw==
X-Gm-Message-State: AHQUAuYq+YFn0nijtWru9mSGpdNB7FBzCv4UffZLYjTHVb+JqDyCAGS8
        39OD1E9rpWChyTMdLKE31anJn1mQVfFlTGkBgQ6v7g==
X-Google-Smtp-Source: AHgI3IYgtw7553bt/kX1nbTlW7KCUUqhRqSJL+6wm63TySJUMnntddOnlFpHAngJvAlvJHA369dBbKh2JM1nLqBFX/I=
X-Received: by 2002:a62:6047:: with SMTP id u68mr4229328pfb.239.1549982561579;
 Tue, 12 Feb 2019 06:42:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549921721.git.andreyknvl@google.com> <3df171559c52201376f246bf7ce3184fe21c1dc7.1549921721.git.andreyknvl@google.com>
 <4bc08cee-cb49-885d-ef8a-84b188d3b5b3@lca.pw> <CAAeHK+zv5=oHJQg-bx7-tiD9197J7wdMeeRSgaxAfJjXEs3EyA@mail.gmail.com>
 <c92d6890-a718-a968-9937-13bdfeda773c@lca.pw>
In-Reply-To: <c92d6890-a718-a968-9937-13bdfeda773c@lca.pw>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 12 Feb 2019 15:42:30 +0100
Message-ID: <CAAeHK+xDYvjMxrkczTQaDbMSu5u3GsxW_mFi1=9OAjCi2Q-6iQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] kasan, slub: fix conflicts with CONFIG_SLAB_FREELIST_HARDENED
To:     Qian Cai <cai@lca.pw>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 2:43 PM Qian Cai <cai@lca.pw> wrote:
>
>
>
> On 2/12/19 8:26 AM, Andrey Konovalov wrote:
> > Hm, did you apply all 6 patches (the one that you sent and these five)
> Yes.

I'm failing to reproduce this in QEMU. You're still using the same
config, right? Could you share whole dmesg until the first BUG?
