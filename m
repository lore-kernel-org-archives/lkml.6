Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA1BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099D8222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTaZh0Lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394775AbfBMV2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:28:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40654 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388680AbfBMV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:28:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so1769643pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmQjCLKll0HK84X/6EadtAaXsCgicqazfQEbsU1cSjs=;
        b=mTaZh0LqJ9dy1I6SMciTBHhhYGYrNfaRewmTso8DrpkkJlJqpthKHo7+B5+GUo0sa3
         okYnjXoYvozsPw+oUPHg4VWnN0BCl/ovW9EG/T6jvzLXo82+kGuwalmW8vP/J8DrnP5+
         /LuSNoU0Wf1GsZg55eImGsBvZ7Ao6pp55NVV0fsg0RyBtIfaoG/xuspwjCujLs6h5Xzk
         8tprRR2cwbMqKtbBiRIOmgHC5sT8A4GWJRzx5KLLRVX1n1jeii82/vx95OEjcU2yginY
         WkUdDg4Rq2dkxXKMY4I4K7k5LRdlOhFkFHMQOflhySUMTtPF5Kkd2ldO/FaX5PwefTaW
         CsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmQjCLKll0HK84X/6EadtAaXsCgicqazfQEbsU1cSjs=;
        b=fSQsUhClkrMMynpA72ujvcEiT4RxPfwKJpS+kkeBJnU6Qpti7sBuvY46AlMUQWLcIg
         s3AWLUzn+DCr6jR7qwFifc+bbI0qc4glXrmh61Lf9bjzmAXEEToltaNYAdDtZGkH//F8
         VWNblk1Oo8l6v4d51og4fwBKPTZrnM6GzttiYT77uxzdvIMt9Tdd0XCO2miZhNkRk2G7
         7qW/SJ/+ChvySDig1w6bMYQ5U7WWNiPaxAiQ4WxajLhoeqAsptyGROeAqE0GHqpwF4rK
         faC8FkOCaCt8BFGDOLMt2/hsLqP8PH8kpWBZVxLIYktet/BUymlMevTRK4IjppcKmtHV
         vs8g==
X-Gm-Message-State: AHQUAuYkqgVbeoTO6ZnKxylX+Byua0pTXe+XPqpUS0L7RJdECm1h+FNf
        QRHn93qEAdvvvC+HXNeZLckAQNw/J2J7PwU4wBT8QA==
X-Google-Smtp-Source: AHgI3IaqfAFAHULRCkhj18lAICwu4iljtEaal/xdgw3FkxfzCxymHkc7FtydVVb8D1mItBL9amRlrw3t9qwX7656iK8=
X-Received: by 2002:a63:4706:: with SMTP id u6mr214977pga.95.1550093303008;
 Wed, 13 Feb 2019 13:28:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550066133.git.andreyknvl@google.com> <20190213124159.862d62fd5dba54da7b46e3ea@linux-foundation.org>
In-Reply-To: <20190213124159.862d62fd5dba54da7b46e3ea@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 13 Feb 2019 22:28:11 +0100
Message-ID: <CAAeHK+yc1ka8YttKu86LCedFPcGn_8RtRRzsS+v4MOe=vLRenA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] kasan: more tag based mode fixes
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@lca.pw>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 9:42 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 13 Feb 2019 14:58:25 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > Changes in v2:
> > - Add comments about kmemleak vs KASAN hooks order.
>
> I assume this refers to Vincenzo's review of "kasan, kmemleak: pass
> tagged pointers to kmemleak".  But v2 of that patch is unchanged.

I've accidentally squashed this change into commit #3 instead of #2 :(



>
> > - Fix compilation error when CONFIG_SLUB_DEBUG is not defined.
