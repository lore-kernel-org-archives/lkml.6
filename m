Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63D8C67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2382082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2382082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeLJPvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:51:16 -0500
Received: from mout.gmx.net ([212.227.17.22]:37319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbeLJPvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:51:15 -0500
Received: from ovpn-121-90.rdu2.redhat.com ([71.184.117.43]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0McR00-1go3EU3Fs8-00HeV5; Mon, 10 Dec 2018 16:50:23 +0100
Subject: Re: [PATCH v3 0/7] dma-debug cleanup and dynamic allocation
To:     Robin Murphy <robin.murphy@arm.com>, hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, salil.mehta@huawei.com,
        john.garry@huawei.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <cover.1544447601.git.robin.murphy@arm.com>
From:   Qian Cai <cai@gmx.us>
Message-ID: <75cd198e-3a4d-0bb4-1b2b-956c8c4e5f9b@gmx.us>
Date:   Mon, 10 Dec 2018 10:50:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <cover.1544447601.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OR6AmaXzbW6ZBCpJOUn+XcFrsSD3w/SCRl741EVTn13hOT+fD5o
 BU9sS4Lo3vFhIg5Xf0+IOtdLfiT6eQxJV0N1lib1CFrwddMUwrMOVNIJBikaLItbR6SBLLk
 X48PIy3lLdVaZfQFLHC7sPFCtuAf9x65TXRcri7xSky+Ctn6J3ZPBHUGyZs0vyiKyndWqT1
 4mEthfbrEps/g//HYD6FQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LJxQ0XMyFvY=:b2MwdibJ/eHj4TaBIX34XE
 vFTyF9McGVfestNt24ka0Z0MS470dsw+zc4kexe+DAMuTess+m/5bj5Zl5NDMfDsJ9IBdNKeJ
 yL/xJjaTEE8ZsuWHb3Y6jgjwjF2vTYQRFQnHk6mrzkOD26JA2fDdY1fn6fHIe6udJvI+FEjlD
 0yilGmitdTaUZ5nRv2dfkcC/IqAwrU8cJitrGc6Rtc1ttJZJ7SiLCMBWphDxD9Ms6j8QaC6AH
 11oBwuhgFAVQ35TCermuqY5kVvv6dWhwqgX15GqTWnoNdMEWkRJHriCp+ydrYgaUUqmNdfcqj
 5URPT8T0nG2uUaIyX+DaLYcceE5cOcrDfGm3FI80G9CkDQEeooDsDab+2rZgiZY/UzDh6W8ok
 1D0vsNl4Vz9ir7ZumO4aG0aKIlDJdg9QkamRAkLWD0YZVQFlBAYIOY68aCviS1AQand74aETq
 3X5c+K8+d+BpDO66MwMF3JRGX9bMaSFQFprgYr/JwjaybN8yBhAhx7AHuiCZuhmW9Z4NyA8bc
 UzGDQjTmp1F9KYW8dll9i4QWDSljXM3icQXNOeuCsfIpluqTWBmodSaoC7flFgnkWwfq/VMmJ
 pXMyifn3rPGOBtNJPajMXOsAD4KangrzMP+HKIfoxKFH1O3k5cnQDDhr4ubsBzwJwtYN3MoSc
 ayeBmt7f6K84jlMkOMaZN4deumr8pRuc0nrhGhMngCyjN62DUPV+fkbTSwM5HuXev5I7IB/S3
 H6yLWwpF2/b1TW/0IDRmfFbh332hpX7lwV4P8vwHmGYfFZPc295MiHDBGqfu1vDZcNyw5/juB
 0TVJtClFsGB9MRNyzLVzeabUN+snBtYuj2StQFNoF8an1aeopcIFB3dBQjx/Az6sVgIv8fXEq
 VaBAdJEPGMVMNI6y5MNHMdDj/bcgJzgi7eYgDUHjq1SgatbQsKR1UCpuKX4xE6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/18 9:00 AM, Robin Murphy wrote:
> Hi all,
> 
> Here's some assorted cleanup and improvements to dma-debug which grew
> out of the problem that certain drivers use very large numbers of DMA
> mappings, and knowing when to override "dma_debug_entries=..." and what
> value to override it with can be a less-than-obvious task for users.
> 
> The main part is patch #4, wherein we make dma-debug clever enough
> to allocate more entries dynamically if needed, such that the
> preallocation value becomes more of a quality-of-life option than a
> necessity. Patches #5 and #6 do some cruft-removal to allow patch #7
> to make the allocation behaviour more efficient in general.
> 
> Patches #1, #2 and #4 are some other cleanup and handy features which
> fell out of the discussion/development.
> 
> Robin.
> 
> 
> Robin Murphy (7):
>   dma-debug: Use pr_fmt()
>   dma-debug: Expose nr_total_entries in debugfs
>   dma-debug: Dynamically expand the dma_debug_entry pool
>   dma-debug: Make leak-like behaviour apparent
>   x86/dma/amd-gart: Stop resizing dma_debug_entry pool
>   dma/debug: Remove dma_debug_resize_entries()
>   dma-debug: Batch dma_debug_entry allocation
> 
>  Documentation/DMA-API.txt                 |  20 +-
>  Documentation/x86/x86_64/boot-options.txt |   5 +-
>  arch/x86/kernel/amd_gart_64.c             |  23 ---
>  include/linux/dma-debug.h                 |   7 -
>  kernel/dma/debug.c                        | 217 ++++++++++------------
>  5 files changed, 109 insertions(+), 163 deletions(-)
> 

Tested-by: Qian Cai <cai@lca.pw>
