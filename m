Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28876C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1A6214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1A6214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJIXr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:47:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:46179 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbeJIXrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:47:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 09:30:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,360,1534834800"; 
   d="scan'208";a="76647593"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.93])
  by fmsmga007.fm.intel.com with ESMTP; 09 Oct 2018 09:28:42 -0700
Subject: Re: [PATCH v2] x86/numa_emulation: fix parsing of numa_meminfo for
 uniform numa emulation
From:   Dave Jiang <dave.jiang@intel.com>
To:     mingo@redhat.com, dan.j.williams@intel.com
Cc:     tglx@linutronix.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <153738070476.51648.10732413805504758768.stgit@djiang5-desk3.ch.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.jiang@intel.com; prefer-encrypt=mutual; keydata=
 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
 o6nmKbYpUAltQObU2w==
Message-ID: <306ff5d0-d6b6-c169-f43c-bb24c4be7fb1@intel.com>
Date:   Tue, 9 Oct 2018 09:28:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153738070476.51648.10732413805504758768.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/19/2018 11:12 AM, Dave Jiang wrote:
> During fakenuma processing in numa_emulation(), pi gets passed in and
> processed as new fake numa nodes are being split out. Once the original
> memory region is proccessed, it gets removed from the pi by
> numa_remove_memblk_from() in emu_setup_memblk(). So entry 0 gets deleted
> and the rest of the entries get moved up. Therefore we should always pass
> in entry 0 for the next entry to process.
> 
> Fixes: 1f6a2c6d9f121 ("x86/numa_emulation: Introduce uniform split
> capability")
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Ingo,
Is this ok to make 4.19-rc as a fix? Thanks!

> ---
> 
> V2:
> - Add comment for the code change (Dan)
> 
>  arch/x86/mm/numa_emulation.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
> index b54d52a2d00a..d71d72cf6c66 100644
> --- a/arch/x86/mm/numa_emulation.c
> +++ b/arch/x86/mm/numa_emulation.c
> @@ -400,9 +400,17 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
>  		n = simple_strtoul(emu_cmdline, &emu_cmdline, 0);
>  		ret = -1;
>  		for_each_node_mask(i, physnode_mask) {
> +			/*
> +			 * The reason we pass in blk[0] is due to
> +			 * numa_remove_memblk_from() called by
> +			 * emu_setup_memblk() will delete entry 0
> +			 * and then move everything else up in the pi.blk
> +			 * array. Therefore we should always be looking
> +			 * at blk[0].
> +			 */
>  			ret = split_nodes_size_interleave_uniform(&ei, &pi,
> -					pi.blk[i].start, pi.blk[i].end, 0,
> -					n, &pi.blk[i], nid);
> +					pi.blk[0].start, pi.blk[0].end, 0,
> +					n, &pi.blk[0], nid);
>  			if (ret < 0)
>  				break;
>  			if (ret < n) {
> 
