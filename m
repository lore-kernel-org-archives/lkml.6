Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1026C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C866520675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404912AbfAPPdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:33:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732887AbfAPPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:33:06 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GFU8Fo022327
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:33:05 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q24cmrsc2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:33:05 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Wed, 16 Jan 2019 15:33:02 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 15:33:00 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GFWx1Q4850158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 15:32:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A9FE42041;
        Wed, 16 Jan 2019 15:32:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F5234203F;
        Wed, 16 Jan 2019 15:32:58 +0000 (GMT)
Received: from [9.83.224.254] (unknown [9.83.224.254])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 15:32:58 +0000 (GMT)
Subject: Re: [PATCH 1/4] gcov: clang: move common gcc code into gcc_base.c
To:     Tri Vo <trong@android.com>
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Greg Hackmann <ghackmann@google.com>,
        Trilok Soni <tsoni@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
References: <20190114210426.177543-1-trong@android.com>
 <20190114210426.177543-2-trong@android.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Wed, 16 Jan 2019 16:32:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190114210426.177543-2-trong@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011615-0028-0000-0000-0000033A06D4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011615-0029-0000-0000-000023F72E73
Message-Id: <4d5052ca-aeec-27f3-63d2-1b064282d234@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.2019 22:04, Tri Vo wrote:
> From: Greg Hackmann <ghackmann@google.com>
> 
> base.c contains a few callbacks specific to GCC's gcov implementation.
> Move these into their own module in preparation for clang support.

Minor nitpick: at least in commit messages, a consistent capitalization
of "Clang" would be preferable.

> diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
> index ff06d64df397..45431ed679d1 100644
> --- a/kernel/gcov/Makefile
> +++ b/kernel/gcov/Makefile

[...]

> -void __gcov_merge_icall_topn(gcov_type *counters, unsigned int n_counters)
> -{
> -	/* Unused. */
> -}
> -EXPORT_SYMBOL(__gcov_merge_icall_topn);
> +int gcov_events_enabled;
> +DEFINE_MUTEX(gcov_lock);
>  
>  void __gcov_exit(void)
>  {

Unless __gcov_exit() is required by Clang, it should also be moved.

> diff --git a/kernel/gcov/gcc_base.c b/kernel/gcov/gcc_base.c
> new file mode 100644
> index 000000000000..823565bcf9bf
> --- /dev/null
> +++ b/kernel/gcov/gcc_base.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kernel.h>
> +#include <linux/mutex.h>

linux/export.h should be included for the EXPORT_SYMBOL() macro.


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

