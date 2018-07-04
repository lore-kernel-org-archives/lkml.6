Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9E1C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316D72445F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316D72445F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933722AbeGDHiV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:38:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932467AbeGDHiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:38:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w647XmQw050919
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 03:38:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0su2rf3d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:38:18 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <brueckner@linux.ibm.com>;
        Wed, 4 Jul 2018 08:38:14 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 08:38:10 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w647c9jr42401946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 07:38:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA75852059;
        Wed,  4 Jul 2018 10:38:34 +0100 (BST)
Received: from lynx.boeblingen.de.ibm.com (unknown [9.152.212.204])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id C6D8252052;
        Wed,  4 Jul 2018 10:38:34 +0100 (BST)
Received: from brueckh by lynx.boeblingen.de.ibm.com with local (Exim 4.90_1)
        (envelope-from <brueckner@linux.ibm.com>)
        id 1facMb-0002z0-AQ; Wed, 04 Jul 2018 09:38:09 +0200
Date:   Wed, 4 Jul 2018 09:38:09 +0200
From:   Hendrik Brueckner <brueckner@linux.ibm.com>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf trace arm64: Use generated syscall table
References: <20180703123238.b9f546a3324178dc5d99f259@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703123238.b9f546a3324178dc5d99f259@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070407-0008-0000-0000-0000024F7CCB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070407-0009-0000-0000-000021B58F57
Message-Id: <20180704073809.GB4680@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 12:32:38PM -0500, Kim Phillips wrote:
> This should speed up accessing new system calls introduced with the
> kernel rather than waiting for libaudit updates to include them.
> 
> It also enables users to specify wildcards, for example, perf trace -e
> 'open*', just like was already possible on x86, s390, and powerpc, which
> means arm64 can now pass the "Check open filename arg using perf trace +
> vfs_getname" test.
> 
> Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  tools/perf/Makefile.config   | 2 ++
>  tools/perf/util/syscalltbl.c | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index b5ac356ba323..3126155810bb 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -54,6 +54,8 @@ endif
> 
>  ifeq ($(SRCARCH),arm64)
>    NO_PERF_REGS := 0
> +  NO_SYSCALL_TABLE := 0
> +  CFLAGS += -I$(OUTPUT)arch/arm64/include/generated
>    LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
>  endif
> 
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 0ee7f568d60c..3393d7ee9401 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -38,6 +38,10 @@ static const char **syscalltbl_native = syscalltbl_powerpc_64;
>  #include <asm/syscalls_32.c>
>  const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_32_MAX_ID;
>  static const char **syscalltbl_native = syscalltbl_powerpc_32;
> +#elif defined(__aarch64__)
> +#include <asm/syscalls.c>
> +const int syscalltbl_native_max_id = SYSCALLTBL_ARM64_MAX_ID;
> +static const char **syscalltbl_native = syscalltbl_arm64;
>  #endif
> 
>  struct syscall {

Looks good.

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

