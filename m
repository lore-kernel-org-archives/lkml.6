Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4227EC43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C5120866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="urApPeQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C5120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeIKFrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:47:19 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46367 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeIKFrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:47:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id y207-v6so43904942oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 17:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wHG4bM5hw+N7h11nxMZHpivINrfHFRwaL7MB49e1fOg=;
        b=urApPeQaAm1YWCZ5VCnVMkuNHrUU2E6vNP/unQtPnejaOdgDvsUjpI4J5ixPeIZjP7
         PMMM7dgDqCGMQRNtaloKe6NjvBINeJ4ZBJ72w7slYkFFT/ztbP1/h4Mi5ubVKWRLyKJ0
         MvPPts717gd4c4RNjN50bFi+1JFEDYUqKi7boxQqc32SwaXENt8AGaETXli6VuNectxF
         hP4Q8iKAsutUEZtJwUQil79zXzsYn1hQY+2tGwF69k1xcxbYhMLyeXuvf+siUiuxdYxW
         JO0HEZ0f7y+3Hobcdmh2UuevZj5Ogygqf3B1UQHEFOqml4FK7BxoE22q+TIElOfmRvND
         CDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wHG4bM5hw+N7h11nxMZHpivINrfHFRwaL7MB49e1fOg=;
        b=RpuaBdgEK0mn7Pn3ocJRjdooG2GOB1ybWWT0nW331uh+HWbldZ27kAHjyh+db0dX0p
         nt++UynG/16nk3lLIj0i8d48EFOGgK9NopguGV+d3ZpMwRJEIKemhGz3E9pr5/jVjXEb
         xJM48qjJALQu0JMRfD7khKfmfnsXagCUjpERG+qEu1cQfyg3D66QoN6DGYd4h9zfHyvi
         Q45esRebqcUGciOl3OEZpukQqVHjt9l0yffimDhqTQuA0vZYZQFyOB4G3fMQBTyquInx
         1B7ZLTuPqrC/Sd7BXRqEfej1p5a4oQPBGhyUKFV5/HGEMzQi/VJVqvswa5opmjP6ICVE
         XeAQ==
X-Gm-Message-State: APzg51C/1fEuPCt1jlHkC3irucviT4pjDqC+d+TqYrA2NOhBUslVRvwA
        h2klEZz8BaLQ7s901QvpRR/vgP7VKTpVnR+ahFGxqA==
X-Google-Smtp-Source: ANB0VdZRIOEhw0PxHkSmFXdBfdHLGmYRHqJSASTuRF4Mo1cowc1WoFEMPVABfomSp37GcSp0UibnUIL8E+VsN1y/jLM=
X-Received: by 2002:aca:4083:: with SMTP id n125-v6mr23162356oia.167.1536627040185;
 Mon, 10 Sep 2018 17:50:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2682:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 17:50:39
 -0700 (PDT)
In-Reply-To: <1536560508-24564-1-git-send-email-oceanhehy@gmail.com>
References: <1536560508-24564-1-git-send-email-oceanhehy@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 Sep 2018 17:50:39 -0700
Message-ID: <CAPcyv4hvtL6eu7=c+7GRqpy6TG2w0-mLZi8smdeTjHX3xxnpZw@mail.gmail.com>
Subject: Re: [PATCH 0/3] libnvdimm: reset seeds for next namespace creation
To:     Ocean He <oceanhehy@gmail.com>
Cc:     zwisler@kernel.org, Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ocean He <hehy1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 9, 2018 at 11:21 PM, Ocean He <oceanhehy@gmail.com> wrote:
> From: Ocean He <hehy1@lenovo.com>
>
> When pmem namespaces created are smaller than section size twice, the
> second creation would fail and meanwhile there is a kernel call trace
> which comes from commit 15d36fecd0bdc7510b70 ("mm: disallow mappings that
> conflict for devm_memremap_pages()").
>         ------------[ cut here ]------------
>         nd_pmem pfn1.1: Conflicting mapping in same section
>         WARNING: CPU: 84 PID: 51974 at kernel/memremap.c:194 devm_memremap_pages+0x4a0/0x4e0
>         CPU: 84 PID: 51974 Comm: ndctl Kdump: loaded Tainted: G W E 4.19.0-rc2-23-default+ #27
>         RIP: 0010:devm_memremap_pages+0x4a0/0x4e0
>         Call Trace:
>          pmem_attach_disk+0x3ab/0x581 [nd_pmem]
>          nvdimm_bus_probe+0x69/0x150 [libnvdimm]
>          really_probe+0x262/0x3d0
>          driver_probe_device+0x60/0x120
>          bind_store+0x102/0x190
>          kernfs_fop_write+0x105/0x180
>          __vfs_write+0x36/0x1a0
>          ? common_file_perm+0x47/0x130
>          ? security_file_permission+0x2c/0xb0
>          vfs_write+0xad/0x1a0
>          ksys_write+0x52/0xc0
>          do_syscall_64+0x5b/0x180
>          entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Here is an example (section size is 128MB) based on kernel 4.19-rc2.
>         # ndctl create-namespace -r region1 -s 100m -t pmem -m fsdax
>         {
>           "dev":"namespace1.0",
>           "mode":"fsdax",
>           "map":"dev",
>           "size":"96.00 MiB (100.66 MB)",
>           "uuid":"ef9a0556-a610-40b5-8c71-43991765a2cc",
>           "raw_uuid":"177b22e2-b7e8-482f-a063-2b8de876d979",
>           "sector_size":512,
>           "blockdev":"pmem1",
>           "numa_node":1
>         }
>         # ndctl create-namespace -r region1 -s 100m -t pmem -m fsdax
>         libndctl: ndctl_pfn_enable: pfn1.1: failed to enable
>           Error: namespace1.1: failed to enable
>         failed to create namespace: No such device or address
>
> When above second creation failure occurs, the expectation is to destroy
> namespace1.0 to create a new namespace which size is aligned with section
> size. However, both namespace seed and pfn seed have been consumed, the
> new namespace creation still fails.
>         # ndctl destroy-namespace namespace1.0 -f
>         destroyed 1 namespace
>         # ndctl create-namespace -r region1 -s 128m -t pmem -m fsdax
>         failed to create namespace: Device or resource busy
>
> To ensure pfn_seed/dax_seed and namespace_seed are always ready for next
> namespace creation, this patch set enables seed detach and reset. Back to
> the example, the new namespace creation never fails if this patch set
> applied.
>         # ndctl destroy-namespace namespace1.0 -f
>         destroyed 1 namespace
>         # ndctl create-namespace -r region1 -s 128m -t pmem -m fsdax
>         {
>           "dev":"namespace1.0",
>           "mode":"fsdax",
>           "map":"dev",
>           "size":"124.00 MiB (130.02 MB)",
>           "uuid":"0d0e7506-d108-4a88-824a-edef26fd0399",
>           "raw_uuid":"efeb9647-12f5-44cd-8a52-2f3a0d14589a",
>           "sector_size":512,
>           "blockdev":"pmem1",
>           "numa_node":1
>         }
>         # ndctl create-namespace -r region1 -s 128m -t pmem -m fsdax
>         {
>           "dev":"namespace1.1",
>           "mode":"fsdax",
>           "map":"dev",
>           "size":130023424,
>           "uuid":"689828dc-8779-434d-8e93-0406d4e1e536",
>           "raw_uuid":"d86e1025-c224-48b6-b2a7-6ccef152d5fd",
>           "sector_size":512,
>           "blockdev":"pmem1.1",
>           "numa_node":1
>         }
>
> The mode devdax (-m devdax) has the same issue, this patch set could
> cover it.

This is good analysis, but I believe this is better fixed / handled in
ndctl directly. This is just one of a few reasons that namespace
creation can fail, and it should be ndctl's job to recover from failed
creation. The kernel only provides the mechanism the policy of what to
do with errors and interrupted namespace creation is up to userspace.

Also, in the future, the plan is to allow namespaces smaller than a
section size which will fix this particular failing condition
properly.
