Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D324C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C5420779
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C5420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754794AbeGCKYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:24:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754757AbeGCKY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:24:29 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63AONqw134129
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 06:24:28 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k067fk24m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 06:24:28 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 3 Jul 2018 11:24:26 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 11:24:21 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63AOKiJ37027938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 10:24:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4CA6AE053;
        Tue,  3 Jul 2018 13:24:22 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 667D8AE058;
        Tue,  3 Jul 2018 13:24:20 +0100 (BST)
Received: from [9.124.31.159] (unknown [9.124.31.159])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 13:24:20 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [RFC 2/4] perf: Pass pmu pointer to perf_paranoid_* helpers
To:     Tvrtko Ursulin <tursulin@ursulin.net>
Cc:     linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        x86@kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
 <20180626153642.5587-3-tvrtko.ursulin@linux.intel.com>
Date:   Tue, 3 Jul 2018 15:54:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626153642.5587-3-tvrtko.ursulin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18070310-0028-0000-0000-000002D7ACED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070310-0029-0000-0000-0000238F2D6D
Message-Id: <5b618e5f-0dcd-5acb-96a0-a0560815c0d7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=789 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tvrtko,

> @@ -199,7 +199,7 @@ static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
>  	if (!(mmcra & MMCRA_SAMPLE_ENABLE) || sdar_valid)
>  		*addrp = mfspr(SPRN_SDAR);
>  
> -	if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
> +	if (perf_paranoid_kernel(ppmu) && !capable(CAP_SYS_ADMIN) &&
>  		is_kernel_addr(mfspr(SPRN_SDAR)))
>  		*addrp = 0;
>  }

This patch fails for me on powerpc:

arch/powerpc/perf/core-book3s.c: In function ‘perf_get_data_addr’:
arch/powerpc/perf/core-book3s.c:202:27: error: passing argument 1 of ‘perf_paranoid_kernel’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  if (perf_paranoid_kernel(ppmu) && !capable(CAP_SYS_ADMIN) &&
                           ^~~~
In file included from arch/powerpc/perf/core-book3s.c:13:0:
./include/linux/perf_event.h:1191:20: note: expected ‘const struct pmu *’ but argument is of type ‘struct power_pmu *’
 static inline bool perf_paranoid_kernel(const struct pmu *pmu)
                    ^~~~~~~~~~~~~~~~~~~~
arch/powerpc/perf/core-book3s.c: In function ‘power_pmu_bhrb_read’:
arch/powerpc/perf/core-book3s.c:470:8: error: too few arguments to function ‘perf_paranoid_kernel’
    if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
        ^~~~~~~~~~~~~~~~~~~~
In file included from arch/powerpc/perf/core-book3s.c:13:0:
./include/linux/perf_event.h:1191:20: note: declared here
 static inline bool perf_paranoid_kernel(const struct pmu *pmu)
                    ^~~~~~~~~~~~~~~~~~~~
  CC      net/ipv6/route.o

