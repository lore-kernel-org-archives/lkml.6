Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4373DC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B3A20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B3A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJOLof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 07:44:35 -0400
Received: from ozlabs.org ([203.11.71.1]:54989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeJOLoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 07:44:34 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42YPr562wDzB2xb; Mon, 15 Oct 2018 15:01:09 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 425752c63b6f3fed7b5a9cba2b8101a92cf36995
In-Reply-To: <1539235983-25259-2-git-send-email-ego@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Anton Blanchard <anton@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v10, 1/3] powerpc: Detect the presence of big-cores via "ibm, thread-groups"
Message-Id: <42YPr562wDzB2xb@ozlabs.org>
Date:   Mon, 15 Oct 2018 15:01:09 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-11 at 05:33:01 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On IBM POWER9, the device tree exposes a property array identifed by
> "ibm,thread-groups" which will indicate which groups of threads share
> a particular set of resources.
> 
> As of today we only have one form of grouping identifying the group of
> threads in the core that share the L1 cache, translation cache and
> instruction data flow.
> 
> This patch adds helper functions to parse the contents of
> "ibm,thread-groups" and populate a per-cpu variable to cache
> information about siblings of each CPU that share the L1, traslation
> cache and instruction data-flow.
> 
> It also defines a new global variable named "has_big_cores" which
> indicates if the cores on this configuration have multiple groups of
> threads that share L1 cache.
> 
> For each online CPU, it maintains a cpu_smallcore_mask, which
> indicates the online siblings which share the L1-cache with it.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/425752c63b6f3fed7b5a9cba2b8101

cheers
