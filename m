Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B14C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7077C21EF6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKXDifrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7077C21EF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeHJJYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:24:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33961 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeHJJYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:24:12 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so14180625ois.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 23:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VIT5pBLEs8pV4p05cyoQVg0TMlj90PAJM7OAqUi62n8=;
        b=mKXDifrhVZRajeLQT7J0y8cIi0k4SJ6e5iOrWq8iJGAxrzaIEeqC2ydKSww8rB6OoJ
         6VNrTemKeBHoRwyq+hkImN0m3Ivpd144jZ397uD3ZwH0OdNiz0arLwYPSZAOgkkNuV26
         Qxf0VlV2Z1FVOAGmNAuhfgZ+vLvtc8VQE6U78AxDSymYnXojKVRcHOY2uk81biMon7eS
         iqVkb/9myxm9Uodd+RF9/E8r/dyiKhk0MqAT6KJVrJGgLb6JPcvvPF9YLstAY2gxV4Bj
         5QDMac5Bzpzw0DulRHAFImmuQGrQp+7yxsZ9SCbTblZplidCGjHVtX/M6/hmITYIRHF6
         blCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VIT5pBLEs8pV4p05cyoQVg0TMlj90PAJM7OAqUi62n8=;
        b=HKcZ9vXZHy5toBFUenvOGrGAKfWXk6MAESI56+hygpr+honXiqe4lO0NKfBKmHKNww
         ufCBrZMVkajROuUR3E+87XoVeuUDGBUmkNpEMGJ3qfy1GtQqxuubGs+3kUKJvx+AwUTU
         VMk0vwknuHNRGBqsDkRVRlDWZDL075wFyLQjrh+LRYKFQbt6wNNXDdQSNl8cWgCsBZm/
         SQtwP6vOymMt0azhR7j+RmlB5LRHGLsm3vPvdltwByvDl0yOfHRJ7ZgY2JNKO/dQEG3A
         SJtET+KLG9H8SSUl5FFQyo++NdUPm1jKkRwds277VChAukXIPZ40MiOi6EscKQmebS9U
         fKpQ==
X-Gm-Message-State: AOUpUlERZHCE65HXZFDoMMyqwKW3lwjT4Ap33P5eNS8HgH9Q23cJFGMp
        ncpe6zuyP0Nb31w5qeqV1Q6BGg8C25B1CiX6qVA=
X-Google-Smtp-Source: AA+uWPx55eImrBL7alo9UTeFqoi+bAP63RAiWO3wvNU4262dhWs6ChM+QG6YtVo/q4QcwMmANlxVDEzl0KrjeGHywME=
X-Received: by 2002:aca:5b88:: with SMTP id p130-v6mr5667961oib.247.1533884141413;
 Thu, 09 Aug 2018 23:55:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:1785:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 23:55:40 -0700 (PDT)
In-Reply-To: <20180809181224.0b7417e51215565dbda9f665@linux-foundation.org>
References: <20180809025409.31552-1-rashmica.g@gmail.com> <20180809181224.0b7417e51215565dbda9f665@linux-foundation.org>
From:   Rashmica Gupta <rashmica.g@gmail.com>
Date:   Fri, 10 Aug 2018 16:55:40 +1000
X-Google-Sender-Auth: kSM2Y4pQbhd0_u07QW-xfLdy3aQ
Message-ID: <CAC6rBs=yYYZw-c02yp6rx-+TN2oUGgrp=uuLhZ=Kc_nnjmTRqA@mail.gmail.com>
Subject: Re: [PATCH v3] resource: Merge resources on a node when hot-adding memory
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     toshi.kani@hpe.com, tglx@linutronix.de, bp@suse.de,
        brijesh.singh@amd.com, thomas.lendacky@amd.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
        dan.j.williams@intel.com, mhocko@suse.com, iamjoonsoo.kim@lge.com,
        Vlastimil Babka <vbabka@suse.cz>, malat@debian.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        osalvador@techadventures.net, yasu.isimatu@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:12 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu,  9 Aug 2018 12:54:09 +1000 Rashmica Gupta <rashmica.g@gmail.com> wrote:
>
>> When hot-removing memory release_mem_region_adjustable() splits
>> iomem resources if they are not the exact size of the memory being
>> hot-deleted. Adding this memory back to the kernel adds a new
>> resource.
>>
>> Eg a node has memory 0x0 - 0xfffffffff. Offlining and hot-removing
>> 1GB from 0xf40000000 results in the single resource 0x0-0xfffffffff being
>> split into two resources: 0x0-0xf3fffffff and 0xf80000000-0xfffffffff.
>>
>> When we hot-add the memory back we now have three resources:
>> 0x0-0xf3fffffff, 0xf40000000-0xf7fffffff, and 0xf80000000-0xfffffffff.
>>
>> Now if we try to remove some memory that overlaps these resources,
>> like 2GB from 0xf40000000, release_mem_region_adjustable() fails as it
>> expects the chunk of memory to be within the boundaries of a single
>> resource.
>>
>> This patch adds a function request_resource_and_merge(). This is called
>> instead of request_resource_conflict() when registering a resource in
>> add_memory(). It calls request_resource_conflict() and if hot-removing is
>> enabled (if it isn't we won't get resource fragmentation) we attempt to
>> merge contiguous resources on the node.
>
> What is the end-user impact of this patch?
>

Only architectures/setups that allow the user to remove and add memory of
different sizes or different start addresses from the kernel at runtime will
potentially encounter the resource fragmentation.

Trying to remove memory that overlaps iomem resources the first time
gives us this warning: "Unable to release resource <%pa-%pa>".

Attempting a second time results in a kernel oops (on ppc at least).

With this patch the user will not be restricted, by resource fragmentation
caused by previous hotremove/hotplug attempts, to what chunks of memory
they can remove.



> Do you believe the fix should be merged into 4.18?  Backporting into
> -stable kernels?  If so, why?


I hit this when adding hot-add code to memtrace on ppc.

Most memory hotplug/hotremove seems to be block or section based, and
always adds and removes memory at the same place.

Memtrace on ppc is different in that given a size (aligned to a block size),
it scans each node and finds a chunk of memory of that size that we can offline
and then removes it.

As this is possibly only as issue for memtrace on ppc with a patch that is not
in 4.18, I don't think this code needs to go in 4.18.


>
> Thanks.
