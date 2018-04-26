Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754446AbeDZIKI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:10:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754366AbeDZIJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:09:55 -0400
Subject: Re: [PATCH] perf test: Adapt test case record+probe_libc_inet_pton.sh
 for s390
To: Martin Vuille <jpmv27@aim.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180412081959.85193-1-tmricht@linux.ibm.com>
 <20180412131012.GC9818@kernel.org>
 <25418aa4-60bb-9f16-c880-8caaf8a20931@aim.com>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Thu, 26 Apr 2018 10:09:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <25418aa4-60bb-9f16-c880-8caaf8a20931@aim.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18042608-0020-0000-0000-000004163CBF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042608-0021-0000-0000-000042AB409B
Message-Id: <151b93fd-8e12-4abf-1e69-329de6eab777@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-26_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804260079
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/2018 04:19 PM, Martin Vuille wrote:
> Apologies for any problems my patch may be causing.
> 
> I'm unclear on what is the proposed fix, other than reverting the commit.
> 
> In the problem scenario, is a --symfs option used? Is the debug info being obtained from the symfs directory?
> 
> Unfortunately, I've had to change my focus for the time being, so won't be able to investigate further for a while.
> 
> Arnaldo, I'm fine with you reverting this change for now.
> 
> Regards,
> 
> MV
> 
> 

Martin,

there is no need to revert the patch. I have adopted the test case for s390 and it
now stops at main, which is identical to x86.

The --symfs option was not used, however the debug file selected for dwarf examination
was different. With you patch it changed from /usr/lib64/libc.so (old) to
/usr/lib/debug/lib64/libc-2.26.so.debug (new)
and I think that this file has not all the info (at least on s390).

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
