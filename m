Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BC4C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A4320850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A4320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeLCKh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:37:27 -0500
Received: from foss.arm.com ([217.140.101.70]:34034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbeLCKh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:37:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8718780D;
        Mon,  3 Dec 2018 02:36:58 -0800 (PST)
Received: from [10.1.37.145] (p8cg001049571a15.cambridge.arm.com [10.1.37.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B855F3F59C;
        Mon,  3 Dec 2018 02:36:57 -0800 (PST)
Subject: Re: linux-next: build failure after merge of the akpm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181203180037.0a54279b@canb.auug.org.au>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7ddea267-9a62-ae47-03d1-b33b8f1a36d6@arm.com>
Date:   Mon, 3 Dec 2018 16:07:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181203180037.0a54279b@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/03/2018 12:30 PM, Stephen Rothwell wrote:
> Hi Andrew,
> 
> After merging the akpm tree, today's linux-next build (powerpc_le perf)
> failed like this:
> 
> bench/numa.c:37:10: fatal error: linux/numa.h: No such file or directory
>  #include <linux/numa.h>
>           ^~~~~~~~~~~~~~
> 
> Caused by patches
> 
>   "mm: replace all open encodings for NUMA_NO_NODE"
>   "mm-replace-all-open-encodings-for-numa_no_node-fix"
> 
> For linux/numa.h to be generally availble to the tools builds, it must
> be copied into tools/include/linux ...
> 
> I have done that copy for today:
> 
> From 6dabc11d5513510d0ec0a6b0a4aa8b9051b71516 Mon Sep 17 00:00:00 2001
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 3 Dec 2018 17:57:27 +1100
> Subject: [PATCH] linux/numa.h is now needed for the perf build
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Makes sense. Thanks Stephen for taking care of this build failure
more than once.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
