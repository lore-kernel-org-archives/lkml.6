Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BBCC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B5020883
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B5020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeILILQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:11:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726027AbeILILP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:11:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8C344Hn141366
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 23:08:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2meqxfdgyh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 23:08:54 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 12 Sep 2018 04:08:52 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 04:08:49 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8C38lkc64946286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 03:08:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C43275204F;
        Wed, 12 Sep 2018 06:08:36 +0100 (BST)
Received: from [9.124.35.146] (unknown [9.124.35.146])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D5B3052052;
        Wed, 12 Sep 2018 06:08:34 +0100 (BST)
Subject: Re: [PATCH] perf test: Add watchpoint test
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        tmricht@linux.ibm.com, sandipan@linux.ibm.com,
        brueckner@linux.ibm.com, kim.phillips@arm.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180910095811.22892-1-ravi.bangoria@linux.ibm.com>
 <20180910103154.GD15548@krava> <20180910134754.GC5147@kernel.org>
 <20180910141830.GI5147@kernel.org> <20180910173122.GC15516@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 12 Sep 2018 08:38:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910173122.GC15516@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18091203-0020-0000-0000-000002C4EDDE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091203-0021-0000-0000-0000211240C6
Message-Id: <f5bd0ead-166a-74e8-09fa-3c76d55e2503@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2018 11:01 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Sep 10, 2018 at 11:18:30AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Sep 10, 2018 at 10:47:54AM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Mon, Sep 10, 2018 at 12:31:54PM +0200, Jiri Olsa escreveu:
>>>> On Mon, Sep 10, 2018 at 03:28:11PM +0530, Ravi Bangoria wrote:
>>>>> Ex on powerpc:
>>>>>   $ sudo ./perf test 22
>>>>>   22: Watchpoint                                            :
>>>>>   22.1: Read Only Watchpoint                                : Ok
>>>>>   22.2: Write Only Watchpoint                               : Ok
>>>>>   22.3: Read / Write Watchpoint                             : Ok
>>>>>   22.4: Modify Watchpoint                                   : Ok
> 
>>>> cool, thanks!
> 
>>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
>>> Thanks, applied.
> 
> Oops, fails when cross-building it to mips, I'll try to fix after lunch:


Sorry for bit late reply. Will send v2 with the fix.

Thanks
Ravi

> 
>   18   109.48 debian:experimental           : Ok   gcc (Debian 8.2.0-4) 8.2.0
>   19    42.66 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
>   20    22.33 debian:experimental-x-mips    : FAIL mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
>   21    20.05 debian:experimental-x-mips64  : FAIL mips64-linux-gnuabi64-gcc (Debian 8.1.0-12) 8.1.0
>   22    22.85 debian:experimental-x-mipsel  : FAIL mipsel-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
> 
>   CC       /tmp/build/perf/tests/bp_account.o
>   CC       /tmp/build/perf/tests/wp.o
> tests/wp.c:5:10: fatal error: arch-tests.h: No such file or directory
>  #include "arch-tests.h"
>           ^~~~~~~~~~~~~~
> compilation terminated.
> mv: cannot stat '/tmp/build/perf/tests/.wp.o.tmp': No such file or directory
> make[4]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/tests/wp.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>   CC       /tmp/build/perf/util/record.o
>   CC       /tmp/build/perf/util/srcline.o
> make[3]: *** [/git/linux/tools/build/Makefile.build:139: tests] Error 2
> make[2]: *** [Makefile.perf:507: /tmp/build/perf/perf-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
> 

