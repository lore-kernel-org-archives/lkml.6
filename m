Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F69C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5A32170A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5A32170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeHHI6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:58:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726869AbeHHI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:58:20 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w786cs5p087487
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 02:40:05 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kqphnhh00-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 02:40:04 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Wed, 8 Aug 2018 07:40:03 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 07:40:00 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w786dx6W38469762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 06:39:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A75B64C052;
        Wed,  8 Aug 2018 09:40:07 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36CE44C046;
        Wed,  8 Aug 2018 09:40:07 +0100 (BST)
Received: from oc3784624756.ibm.com (unknown [9.152.212.85])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Aug 2018 09:40:07 +0100 (BST)
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390
 auxiliary trace
To:     mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-3-tmricht@linux.ibm.com>
 <87r2j9bkax.fsf@concordia.ellerman.id.au>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Wed, 8 Aug 2018 08:39:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87r2j9bkax.fsf@concordia.ellerman.id.au>
Content-Type: multipart/mixed;
 boundary="------------13D9DBA6A4F3C4927657562D"
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18080806-0028-0000-0000-000002E7C753
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080806-0029-0000-0000-000023A0D000
Message-Id: <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------13D9DBA6A4F3C4927657562D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 08/08/2018 05:37 AM, mpe@ellerman.id.au wrote:
> Thomas Richter <tmricht@linux.ibm.com> writes:
>> Add support for s390 auxiliary trace support.
>> Use 'perf record -e rbd000' to create the perf.data file.
>> The event also has the symbolic name SF_CYCLES_BASIC_DIAG,
>> using 'perf record -e SF_CYCLES_BASIC_DIAG' is equivalent.
> ...
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
>> ---
>>  tools/perf/util/s390-cpumsf-kernel.h |  71 ++++++++
>>  tools/perf/util/s390-cpumsf.c        | 244 ++++++++++++++++++++++++++-
>>  2 files changed, 314 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/perf/util/s390-cpumsf-kernel.h
> 
> 
> I'm seeing a build break on ppc64le which seems to be caused by this
> commit (I haven't bisected):
> 
>   util/s390-cpumsf.c: In function ‘trailer_timestamp’:
>   util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
>     return *((unsigned long long *) &te->timestamp[te->t]);
>     ^
> 
> 
> And on powerpc big endian:
>   In file included from util/cpumap.h:10:0,
>                    from util/s390-cpumsf.c:150:
>   util/s390-cpumsf.c: In function ‘s390_cpumsf_basic_show’:
>   util/s390-cpumsf.c:187:10: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘size_t {aka unsigned int}’ [-Werror=format=]
>      pr_err("Invalid AUX trace basic entry [%#08lx]\n", pos);
>             ^
> 
> cheers
> 

Can you please try this patch. Thanks a lot

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

--------------13D9DBA6A4F3C4927657562D
Content-Type: text/x-patch;
 name="0001-perf-report-Fix-build-error-for-s390-auxiliary-trace.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-perf-report-Fix-build-error-for-s390-auxiliary-trace.pa";
 filename*1="tch"

From add6a709f79e20e8b4eaa6ded2bd1af043f8a235 Mon Sep 17 00:00:00 2001
From: Thomas Richter <tmricht@linux.ibm.com>
Date: Wed, 8 Aug 2018 07:11:23 +0100
Subject: [PATCH] perf report: Fix build error for s390 auxiliary trace support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 73eeeea48b7e ("perf report: Add raw report support for s390 auxiliary trace")
introduced a compile errors on powerpc:
  util/s390-cpumsf.c: In function ‘trailer_timestamp’:
  util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will
	break strict-aliasing rules [-Werror=strict-aliasing]
	return *((unsigned long long *) &te->timestamp[te->t]);
	^

  In file included from util/cpumap.h:10:0,
                   from util/s390-cpumsf.c:150:
  util/s390-cpumsf.c: In function ‘s390_cpumsf_basic_show’:
  util/s390-cpumsf.c:187:10: error: format ‘%lx’ expects argument of type
	‘long unsigned int’, but argument 4 has type
	‘size_t {aka unsigned int}’ [-Werror=format=]
     pr_err("Invalid AUX trace basic entry [%#08lx]\n", pos);
            ^

Fix these errors:
1. Use memcpy to extract value from character array.
2. Use %zu as format string in pr_err

Fixes: 73eeeea48b7e
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/s390-cpumsf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 15555604ddb3..2bcb160a08f0 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -184,7 +184,7 @@ static bool s390_cpumsf_basic_show(const char *color, size_t pos,
 				   struct hws_basic_entry *basic)
 {
 	if (basic->def != 1) {
-		pr_err("Invalid AUX trace basic entry [%#08lx]\n", pos);
+		pr_err("Invalid AUX trace basic entry [%#08zx]\n", pos);
 		return false;
 	}
 	color_fprintf(stdout, color, "    [%#08x] Basic   Def:%04x Inst:%#04x"
@@ -219,7 +219,10 @@ static unsigned long long trailer_timestamp(struct hws_trailer_entry *te)
 	/* te->t set: TOD in STCKE format, bytes 8-15
 	 * to->t not set: TOD in STCK format, bytes 0-7
 	 */
-	return *((unsigned long long *) &te->timestamp[te->t]);
+	unsigned long long ts;
+
+	memcpy(&ts, &te->timestamp[te->t], sizeof(ts));
+	return ts;
 }
 
 /* Display s390 CPU measurement facility trailer entry */
-- 
2.14.3


--------------13D9DBA6A4F3C4927657562D--

