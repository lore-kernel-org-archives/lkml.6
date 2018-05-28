Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeE1GuV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:50:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753330AbeE1GuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:50:18 -0400
Subject: Re: [PATCH] perf test 39 (Session topology) dumps core on s390
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180524135600.77128-1-tmricht@linux.ibm.com>
 <610eac04-1e34-9032-0a95-2f9818a31a9b@linux.ibm.com>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Mon, 28 May 2018 08:50:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <610eac04-1e34-9032-0a95-2f9818a31a9b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18052806-0040-0000-0000-0000043E73BE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052806-0041-0000-0000-00002643BC9F
Message-Id: <9042034b-0d46-0bfb-7737-717e7d5803d6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805280084
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 05:49 AM, Ravi Bangoria wrote:
> Hi Thomas,
> 
> On 05/24/2018 07:26 PM, Thomas Richter wrote:
>> @@ -95,7 +98,7 @@ int test__session_topology(struct test *test __maybe_unused, int subtest __maybe
>>  {
>>  	char path[PATH_MAX];
>>  	struct cpu_map *map;
>> -	int ret = -1;
>> +	int ret;
> 
> This is failing for me:
> 
> tests/topology.c: In function ‘test__session_topology’:
> tests/topology.c:101:6: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   int ret;
>       ^
> cc1: all warnings being treated as errors
>   CC       util/intlist.o
> mv: cannot stat 'tests/.topology.o.tmp': No such file or directory
> /home/ravi/Workspace/linux/tools/build/Makefile.build:96: recipe for target 'tests/topology.o' failed
> make[4]: *** [tests/topology.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> 
> 
> Thanks,
> Ravi
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Thanks for the pointer, will provide V2.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
