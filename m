Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980B8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4B32146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfBHRE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:04:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:49270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbfBHRE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:04:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 222A1AF1B;
        Fri,  8 Feb 2019 17:04:25 +0000 (UTC)
Subject: Re: [PATCH v2] mm: proc: smaps_rollup: Fix pss_locked calculation
To:     Sandeep Patil <sspatil@android.com>, adobriyan@gmail.com,
        akpm@linux-foundation.org, avagin@openvz.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@android.com, dancol@google.com
References: <20190203065425.14650-1-sspatil@android.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5b8e236d-7c43-6c2b-cb3f-cbb0b8923fe2@suse.cz>
Date:   Fri, 8 Feb 2019 18:04:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190203065425.14650-1-sspatil@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/19 7:54 AM, Sandeep Patil wrote:
> The 'pss_locked' field of smaps_rollup was being calculated incorrectly.
> It accumulated the current pss everytime a locked VMA was found.  Fix
> that by adding to 'pss_locked' the same time as that of 'pss' if the vma
> being walked is locked.
> 
> Fixes: 493b0e9d945f ("mm: add /proc/pid/smaps_rollup")
> Cc: stable@vger.kernel.org # 4.14.y 4.19.y
> Signed-off-by: Sandeep Patil <sspatil@android.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.

> ---
> 
> v1->v2
> ------
> - Move pss_locked accounting into smaps_account() inline with pss
