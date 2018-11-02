Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0F7C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232972081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zez+yZcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232972081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeKBVm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:42:26 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46886 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeKBVm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:42:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id k64-v6so1410066oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YG3VChNFQS0CtyRt5u1f3UsENmETTfaopErDD3Ti+LM=;
        b=Zez+yZcyjdTsYznjTiD1KQXSConV9IKL9qSvzK7x9KMKAs1kkhXP2DdQ2QZM6oTKko
         sZrN4EoP0ZZ11ZPvlCQQe+e/4Q1GwOJwb13k4IOlyKArPRTXIZiXKAiWux+0az8hq0mK
         cTNpGbTIoxHbtplOET2WVEh3y/F2FEE53d0OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YG3VChNFQS0CtyRt5u1f3UsENmETTfaopErDD3Ti+LM=;
        b=KvYmHeRUoT1citEKdTnAfuX5piciFZUonWb7k8hnLCNf/AjDU7mVFeJWrrDCoODC7+
         ruFQBMUGEMlAs3WCRwFZx6l1+jGekRvh+xDnQWGR6oK3dny0lO8HHtVA8o3vmYRpHtQh
         oCuDxWk/g9KuuAQywAiFSwjfvae2spk1m0zzOdf3OvvZzTCxfOxAF4qFlVWj/J0ee657
         qxzkaeY4tnu1t58FDkhkU6KhUHjxcw/6zI3YoRN9ck2aImr1iiFvwBB9Nj8MDcperNKx
         7ymf5TVI//Cq+Be+WUfZmfCG5cC9IN7XAsIMWPMDbTBxol0P9523B6t8trkoAgWbMh5o
         L8wg==
X-Gm-Message-State: AGRZ1gLcdbPLf03EggEKkPF3oAX8Q4FdXGmp+pyVwPXvUHhRMcRaktVp
        Qu9vYp2EDmMszJU5LvsgMv2Et/355xqziC/7PLnN
X-Google-Smtp-Source: AJdET5cDmlaw2HcOA5mtu3Rix6UT8HJxQ8O9BV8oYmwBNRSoyTxmBCosRR9Axmxa6Sg8p0Gvs+SQ898q7em+RHthgaA=
X-Received: by 2002:aca:f50b:: with SMTP id t11-v6mr6989387oih.57.1541162122995;
 Fri, 02 Nov 2018 05:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181031081945.207709-1-vovoy@chromium.org> <20181031142458.GP32673@dhcp22.suse.cz>
 <cc44aa53-8705-02ea-6c59-f311427d93af@intel.com> <20181031164231.GQ32673@dhcp22.suse.cz>
 <CAEHM+4pSkv_fD3Yb2KX1xFrOmRHU1e=+wCBrCyLAAMBG3zP75w@mail.gmail.com> <20181101130910.GI23921@dhcp22.suse.cz>
In-Reply-To: <20181101130910.GI23921@dhcp22.suse.cz>
From:   Vovo Yang <vovoy@chromium.org>
Date:   Fri, 2 Nov 2018 20:35:11 +0800
Message-ID: <CAEHM+4rvBmFWhzPXZrwxXvMEmVdkpsgRg26wVNYSA8HKF_8AwQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm, drm/i915: mark pinned shmemfs pages as unevictable
To:     mhocko@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 9:10 PM Michal Hocko <mhocko@kernel.org> wrote:
> OK, so that explain my question about the test case. Even though you
> generate a lot of page cache, the amount is still too small to trigger
> pagecache mostly reclaim and anon LRUs are scanned as well.
>
> Now to the difference with the previous version which simply set the
> UNEVICTABLE flag on mapping. Am I right assuming that pages are already
> at LRU at the time? Is there any reason the mapping cannot have the flag
> set before they are added to the LRU?

I checked again. When I run gem_syslatency, it sets unevictable flag
first and then adds pages to LRU, so my explanation to the previous
test result is wrong. It should not be necessary to explicitly move
these pages to unevictable list for this test case. The performance
improvement of this patch on kbl might be due to not calling
shmem_unlock_mapping.

The perf result of a shmem lock test shows find_get_entries is the
most expensive part of shmem_unlock_mapping.
85.32%--ksys_shmctl
        shmctl_do_lock
         --85.29%--shmem_unlock_mapping
                   |--45.98%--find_get_entries
                   |           --10.16%--radix_tree_next_chunk
                   |--16.78%--check_move_unevictable_pages
                   |--16.07%--__pagevec_release
                   |           --15.67%--release_pages
                   |                      --4.82%--free_unref_page_list
                   |--4.38%--pagevec_remove_exceptionals
                    --0.59%--_cond_resched
