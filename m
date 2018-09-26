Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E7FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003BE21480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003BE21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeIZPfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:35:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeIZPfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:35:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AECD988311;
        Wed, 26 Sep 2018 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E1955D73F;
        Wed, 26 Sep 2018 09:23:04 +0000 (UTC)
Subject: Re: [PATCH 0/3] find_next_iomem_res() fixes
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     dan.j.williams@intel.com, brijesh.singh@amd.com, bhe@redhat.com,
        thomas.lendacky@amd.com, tiwai@suse.de, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com,
        tglx@linutronix.de, bp@suse.de, dyoung@redhat.com,
        akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
References: <20180921073211.20097-2-lijiang@redhat.com>
 <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <1894f2ba-42ab-c044-ea0c-63eab98d9815@redhat.com>
Date:   Wed, 26 Sep 2018 17:22:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 26 Sep 2018 09:23:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2018年09月25日 06:14, Bjorn Helgaas 写道:
> Hi Lianbo,
> 
> These three patches are a possible replacement for your first patch
> ("[PATCH 1/3 v3] resource: fix an error which walks through iomem
> resources").
> 
> I think the interface of find_next_iomem_res() can be improved to make
> the code easier to read and also avoid the errors you're fixing.
> 
> I can't test these, so they've only been compiled.  If you can test
> them and if you like them, feel free to incorporate them into your
> series.  If not, just drop them (but please at least fix the same
> error in walk_system_ram_range()).
> 
Hi, Bjorn
Sorry for my late reply about this. No need to incorporate them into
my patch series, you might freely submit them to upstream.

I will test your patches whether it can also work well for my case, and
you will get feedback about my test later.

Thanks.
Lianbo

> ---
> 
> Bjorn Helgaas (3):
>       x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one error
>       resource: Include resource end in walk_*() interfaces
>       resource: Fix find_next_iomem_res() iteration issue
> 
> 
>  arch/x86/include/asm/kexec.h |    2 -
>  kernel/resource.c            |   96 ++++++++++++++++++------------------------
>  2 files changed, 43 insertions(+), 55 deletions(-)
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
