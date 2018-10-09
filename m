Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5941FC67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C81B2089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="WU+wbSj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C81B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJIHfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:35:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44356 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbeJIHfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:35:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so10071780otf.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 17:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hI78rxtz5Bd0a+EXEvrpCdRbNmmli+ezXBuYUh1EPuk=;
        b=WU+wbSj6cd4nFLJ6m4/sqtDyunCEkeuOs3okKm73wPdft3Jqa/uj3j6A1cXTnkc2Vw
         pb+Zt2HXNn0D9WidLDS2rpN4A+JormME+gh2wIWOG9HOS2CUUJRjTJQntHRP1wRQFpm2
         ldwQxGY/bvGnIX8z1sSa8a4k/PqzJVSfMhLocbiqfAGUpGflkSMJ8nMY0Y7LqmMVNLBs
         CS5nQRwt9DhVmD2P34aJKUsAM5PF7uUVcjpMYymU3r7891daENdojEiU3b4gchu//y3h
         HE5DEHErHKVHX4zP1A+AMSswQVuooeWpsL5vEoX1sUE/udc8NxRvL0vcaDXuTS3Vj+XM
         EMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hI78rxtz5Bd0a+EXEvrpCdRbNmmli+ezXBuYUh1EPuk=;
        b=r6gGf4YQwWJc3myK0FVFPc72o3YyevCwN0/652azqhEtnsnEwypA04i0TZBbtDDV2E
         SbHMPdOrfIxiFIADea6hYRJMaeQ1xiCst3c9pDBLVTQLBBNoLb0ZSmT8yCOICotsAZLG
         ds1YEHGw3QdIdAfRYSIvqZrhrB1WE35+ltRDnOHzMFFzc4InpNwbtU0dSHrmpj7umPUs
         YGnxnNJf4IWLEhFSVkvVvYR354eBs+ZdtLcNXIv5+gImbNHqyUkdCec6kcWBY8yRrJxi
         64WluXg2G1/xrg9w2YMB4G3IIt2t7JpIt/BaRgdQ6SU/pjYhRLP4eTlf+VbLarwF8GtH
         lfug==
X-Gm-Message-State: ABuFfoizS1NL/C+5+llb/oYUf+glTBe8vC8bCKFidmjTOY8AMfGVT5ME
        L/pJZphqJwWUakgBP3oezZ1ldSzxc8RAI72X4Rocqw==
X-Google-Smtp-Source: ACcGV61zXKSYUHWx4ckmEG2VIpRvpOfGLK2GW5mBrgluZH7d0bAURodA/gxBj536HTQKqG6rc7GVYKBhMl/4bVIO5m0=
X-Received: by 2002:a9d:24c7:: with SMTP id z65mr14907617ota.229.1539044465520;
 Mon, 08 Oct 2018 17:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jX5WYmMYzGCBrnaqT7tqHGSVPwm7Dpi-XpuM9ns84+0w@mail.gmail.com>
 <20181008233404.1909.37302.stgit@localhost.localdomain>
In-Reply-To: <20181008233404.1909.37302.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 8 Oct 2018 17:20:54 -0700
Message-ID: <CAPcyv4jB5S7DbYr+LmMNpD0teKrO2aoVfJxnSFPrswPCcs-Snw@mail.gmail.com>
Subject: Re: [mm PATCH] memremap: Fix reference count for pgmap in devm_memremap_pages
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 4:34 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> In the earlier patch "mm: defer ZONE_DEVICE page initialization to the
> point where we init pgmap" I had overlooked the reference count that was
> being held per page on the pgmap. As a result on running the ndctl test
> "create.sh" we would call into devm_memremap_pages_release and encounter
> the following percpu reference count error and hang:
>   WARNING: CPU: 30 PID: 0 at lib/percpu-refcount.c:155
>   percpu_ref_switch_to_atomic_rcu+0xf3/0x120
>
> This patch addresses that by performing an update for all of the device
> PFNs in a single call. In my testing this seems to resolve the issue while
> still allowing us to retain the improvements seen in memory initialization.
>
> Reported-by: Dan Williams <dan.j.williams@intel.com>

Tested-by: Dan Williams <dan.j.williams@intel.com>

Thanks Alex!
