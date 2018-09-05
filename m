Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85684C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E9F2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0QYOlWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E9F2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIETAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:00:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35226 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIETAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:00:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7-v6so3542232pgf.2;
        Wed, 05 Sep 2018 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=u6+1xcDyqr2TuMvjZ9Anx9jcq72zj5YlFA5wz/VQIuU=;
        b=b0QYOlWPUXKqSBnHDAmb8w79Mnd13t+I+VaaQY4RLWCbbwWtJir3DRYpLw0N5kmABr
         coIGfZ0CFQLgkPJM/I34OB9yo5iMWNxfIjoHgi0A65ZhIRSwHSX/xTQgftm3U5X5xnmK
         BENOYnvh2N2vv5Qa5e+7/9Aq2iEb1UinEBhvrgEvU55d9YYD2qyU9UEFQVmVHjvCtCLU
         o7aOY2RgV9hcR41wBRUVvfpKxcvlToO7el+TvGDX4KY3/BbKxqWorbHbbsaWWPBtAn6g
         w0vNgfnnzMBx+Thod8D6v5uIqU7pTYHrVTwahCZPingRpf9tvyWaG1cB80L81Hg+I6jZ
         hZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=u6+1xcDyqr2TuMvjZ9Anx9jcq72zj5YlFA5wz/VQIuU=;
        b=FbBGhq5wLsOnNCpZbo+nJrmLoIWsJrNtYANCTjv6YokcM89Y2jAiQ4mT+3aIvKXp6W
         ZFwChQqiyoFQ5FAWeJY+X0NUnBUGRd1KjFSQ5FGptR6YMEvlud+mIVBqfKVyE8+3JegU
         CiTwQxpZTBPsMYfWtEvvKDrNkxgQI938mOuJupLEF1W4tbSHairh2kAvFLrA3/MH3msp
         ab2HdYRgR6jzu8BabsrVFBjSi1Gb7mqkACZIU0+sYIPhHGtJlxVsdIdCtLL43FrDWOIH
         El2gY283RslYq7+bwagELPsdyrXg0SHMK1181RtaeLfI/LaeabUkBKLsqQBTgR8t6J1T
         eBEg==
X-Gm-Message-State: APzg51BGoP/HxM/HnBE31tqRKeVW3FJWfazI1NyjIB/nevU7zyzL4XAf
        I0QW9jCnRSIypG35sWX4/hXSCbgZ
X-Google-Smtp-Source: ANB0Vdb2++4+kAoy9mSSJbO7a2u5jum//d7pr5btK2hD2ZbcOU7WedmQWhqVLxKmRUOV8d2x5NaJig==
X-Received: by 2002:a63:5d4b:: with SMTP id o11-v6mr35902662pgm.349.1536157794507;
        Wed, 05 Sep 2018 07:29:54 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m20-v6sm7497571pfg.61.2018.09.05.07.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:29:53 -0700 (PDT)
Date:   Wed, 5 Sep 2018 07:29:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Subject: Re: [PATCH 3/3] mm: optimise pte dirty/accessed bit setting by
 demand based pte insertion
Message-ID: <20180905142951.GA15680@roeck-us.net>
References: <20180828112034.30875-1-npiggin@gmail.com>
 <20180828112034.30875-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180828112034.30875-4-npiggin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 28, 2018 at 09:20:34PM +1000, Nicholas Piggin wrote:
> Similarly to the previous patch, this tries to optimise dirty/accessed
> bits in ptes to avoid access costs of hardware setting them.
> 

This patch results in silent nios2 boot failures, silent meaning that
the boot stalls.

...
Unpacking initramfs...
Freeing initrd memory: 2168K
workingset: timestamp_bits=30 max_order=15 bucket_order=0
jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
random: fast init done
random: crng init done

[no further activity until the qemu session is aborted]

Reverting the patch fixes the problem. Bisect log is attached.

Guenter

---
# bad: [387ac6229ecf6e012649d4fc409c5352655a4cf0] Add linux-next specific files for 20180905
# good: [57361846b52bc686112da6ca5368d11210796804] Linux 4.19-rc2
git bisect start 'HEAD' 'v4.19-rc2'
# good: [668570e8389bb076bea9b7531553e1362f5abd11] Merge remote-tracking branch 'net-next/master'
git bisect good 668570e8389bb076bea9b7531553e1362f5abd11
# good: [7f2f69ebf0bcf3e9bcff7d560ba92cee960a66a6] Merge remote-tracking branch 'battery/for-next'
git bisect good 7f2f69ebf0bcf3e9bcff7d560ba92cee960a66a6
# good: [c31458d3e03e3a2edeaab225a22eaf68c07c8290] Merge remote-tracking branch 'rpmsg/for-next'
git bisect good c31458d3e03e3a2edeaab225a22eaf68c07c8290
# good: [e0f43dcbe9af8ac72f39fe92c5d0ee1883546427] Merge remote-tracking branch 'nvdimm/libnvdimm-for-next'
git bisect good e0f43dcbe9af8ac72f39fe92c5d0ee1883546427
# bad: [f509e2c0f3cd11df238f0f1b5ba013fe726decdf] of: ignore sub-page memory regions
git bisect bad f509e2c0f3cd11df238f0f1b5ba013fe726decdf
# good: [2f7eebf30b87534f7e4c3982307579d9adc782a5] ocfs2: fix clusters leak in ocfs2_defrag_extent()
git bisect good 2f7eebf30b87534f7e4c3982307579d9adc782a5
# good: [119eb88c9dd23e305939ad748237100078e304a8] mm/swapfile.c: call free_swap_slot() in __swap_entry_free()
git bisect good 119eb88c9dd23e305939ad748237100078e304a8
# good: [21d64d37adf3ab20b4c3a1951018e84bf815c887] mm: remove vm_insert_pfn()
git bisect good 21d64d37adf3ab20b4c3a1951018e84bf815c887
# good: [90cd1a69010844e9dbfc43279d681d798812b962] cramfs: convert to use vmf_insert_mixed
git bisect good 90cd1a69010844e9dbfc43279d681d798812b962
# good: [c7dd91289b4bb4c400a8a71953511991815f8e6f] mm/cow: optimise pte dirty/accessed bits handling in fork
git bisect good c7dd91289b4bb4c400a8a71953511991815f8e6f
# bad: [87d74ae75700a39effcb8c9ed8a8445e719ac369] hexagon: switch to NO_BOOTMEM
git bisect bad 87d74ae75700a39effcb8c9ed8a8445e719ac369
# bad: [3d1d5b26ac5b4d4193dc618a50cd88de1fb0d360] mm: optimise pte dirty/accessed bit setting by demand based pte insertion
git bisect bad 3d1d5b26ac5b4d4193dc618a50cd88de1fb0d360
# first bad commit: [3d1d5b26ac5b4d4193dc618a50cd88de1fb0d360] mm: optimise pte dirty/accessed bit setting by demand based pte insertion
