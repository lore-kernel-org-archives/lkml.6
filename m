Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CB1ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C9B2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C9B2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gydle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJSXhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:37:43 -0400
Received: from mail.gydle.com ([64.18.173.180]:45970 "EHLO mail.gydle.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbeJSXhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:37:43 -0400
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2018 19:37:42 EDT
X-Received: from [10.42.0.204] (unknown [69.70.179.254])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboisvert@gydle.com)
        by mail.gydle.com (Postfix) with ESMTPSA id 02CD444081;
        Fri, 19 Oct 2018 11:22:38 -0400 (EDT)
Subject: Re: [PATCH V2] perf arm64: Fix generate system call table failed with
 /tmp mounted with noexec
To:     Hongxu Jia <hongxu.jia@windriver.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     kim.phillips@arm.com, brueckner@linux.ibm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        mpe@ellerman.id.au, peterz@infradead.org,
        ravi.bangoria@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
        acme@redhat.com, namhyung@kernel.org
References: <1c6964d0-a7d2-83ef-16f2-bdf349e3f0af@gydle.com>
 <1539915379-11910-1-git-send-email-hongxu.jia@windriver.com>
From:   =?UTF-8?Q?S=c3=a9bastien_Boisvert?= <sboisvert@gydle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sboisvert@gydle.com; keydata=
 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
 vnOzfc5OOiR/D+lE
Message-ID: <9da3ccbf-ec36-c676-7472-fe7d642cd7e0@gydle.com>
Date:   Fri, 19 Oct 2018 11:22:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539915379-11910-1-git-send-email-hongxu.jia@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-10-18 10:16 p.m., Hongxu Jia wrote:
> When /tmp is mounted with noexec, mksyscalltbl fails.
> [snip]
> |perf-1.0/tools/perf/arch/arm64/entry/syscalls//mksyscalltbl:
> /tmp/create-table-6VGPSt: Permission denied
> [snip]
> 
> Add variable TMPDIR as prefix dir of the temporary file, if it is set,
> replace default /tmp
> 
> Remove extra slash from `syscalls//mksyscalltbl'
> 
> Fixes: 2b5882435606 ("perf arm64: Generate system call table from asm/unistd.h")
> 
> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> ---
>  tools/perf/arch/arm64/Makefile                    | 2 +-
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
> index dbef716..bc2a284 100644
> --- a/tools/perf/arch/arm64/Makefile
> +++ b/tools/perf/arch/arm64/Makefile
> @@ -13,7 +13,7 @@ out    := $(OUTPUT)arch/arm64/include/generated/asm
>  header := $(out)/syscalls.c
>  incpath := $(srctree)/tools
>  sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
> -sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
> +sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls

Should this appear in different patch, since it is unrelated to adding TMPDIR support ?

Thanks

>  systbl := $(sysprf)/mksyscalltbl
>  
>  # Create output directory if not already present
> diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> index 2dbb8cad..c88fd32 100755
> --- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> @@ -23,7 +23,7 @@ create_table_from_c()
>  {
>  	local sc nr last_sc
>  
> -	create_table_exe=`mktemp /tmp/create-table-XXXXXX`
> +	create_table_exe=`mktemp ${TMPDIR:-/tmp}/create-table-XXXXXX`
>  
>  	{
>  
> 
