Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16613C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E386821A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404912AbfBOOHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:07:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60374 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389389AbfBOOHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:07:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6986BA78;
        Fri, 15 Feb 2019 06:07:54 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC1E63F575;
        Fri, 15 Feb 2019 06:07:51 -0800 (PST)
Date:   Fri, 15 Feb 2019 14:07:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
Subject: Re: [PATCH v2 3/5] kmemleak: account for tagged pointers when
 calculating pointer range
Message-ID: <20190215140748.GE100037@arrakis.emea.arm.com>
References: <cover.1550066133.git.andreyknvl@google.com>
 <16e887d442986ab87fe87a755815ad92fa431a5f.1550066133.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e887d442986ab87fe87a755815ad92fa431a5f.1550066133.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:58:28PM +0100, Andrey Konovalov wrote:
> kmemleak keeps two global variables, min_addr and max_addr, which store
> the range of valid (encountered by kmemleak) pointer values, which it
> later uses to speed up pointer lookup when scanning blocks.
> 
> With tagged pointers this range will get bigger than it needs to be.
> This patch makes kmemleak untag pointers before saving them to min_addr
> and max_addr and when performing a lookup.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

I reviewed the old series. This patch also looks fine:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
