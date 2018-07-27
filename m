Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F32DC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179D120873
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179D120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeG0Hr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 03:47:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbeG0Hr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 03:47:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6R6OVjj073579
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 02:27:37 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kfwg01e37-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 02:27:37 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 27 Jul 2018 07:27:34 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 07:27:29 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6R6RSLW40173570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 06:27:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CCDB4C04A;
        Fri, 27 Jul 2018 09:27:42 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE5BE4C040;
        Fri, 27 Jul 2018 09:27:41 +0100 (BST)
Received: from oc3784624756.ibm.com (unknown [9.152.212.85])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 09:27:41 +0100 (BST)
Subject: Re: BPF relocation 'perf test' entries failing was: Re: [GIT PULL
 00/27] perf/core improvements and fixes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sandipan Das <sandipan@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Clark Williams <williams@redhat.com>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180726131534.GD17940@kernel.org>
 <2fbfac01-e103-8daf-6187-b94d1725dbd0@linux.ibm.com>
 <20180726185805.GA20438@kernel.org> <20180726191435.GB20438@kernel.org>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Fri, 27 Jul 2018 08:27:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180726191435.GB20438@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072706-0008-0000-0000-000002586E9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072706-0009-0000-0000-000021BEF24D
Message-Id: <8b7e30c5-338c-7e9b-536f-9418792936d7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 09:14 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 26, 2018 at 03:58:05PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Jul 26, 2018 at 11:04:08PM +0530, Sandipan Das escreveu:
>>> I came across the same problem. Does the following patch fix it?
> 
>>> https://lkml.org/lkml/2018/7/26/669
>  
>> Oh my, that one was subtle... Checking...
> 
> Right, when it said it was running:
> 
>   40.3: BPF prologue generation
> 
> In fact it was running:
> 
>   40.4: BPF relocation checker
> 
> That error message in the 'perf test -v' output:
> 
>   libbpf: Program 'func=sys_write' contains non-map related relo data pointing to section 65522
> 
> Was the _expected_ one for "40.4: BPF relocation checker", then it
> failed when it couldn't run the off by one "last" subtest, duh.
> 
> Thomas, this was a problem introduced by a patch from you, just for
> reference, this one:
> 
>     Fixes: 9ef0112442bd ("perf test: Fix subtest number when showing results")
> 
> I should have caught this by running 'perf test' before/after applying
> that patch, I'll now make sure this is done before sending pull reqs
> upstream.
> 
> In fact I did after, and thought, hey, some BPF related regression, I
> must've updated clang/llvm and something new appeared on the radar, so I
> went that direction and went nowhere, well, now I have an uptodate
> llvm/clang combo to play with BTF, pahole, etc 8-)
> 
> Thanks!
> 
> - Arnaldo



Sandipan,
thanks for fixing what I have messed up.

Arnaldo,
sorry for the hickup, I should have caught this too. In fact I ran
perf test before and after, but redirected the output and just 
looked at the grep'ed lines on the screen....
I should be looked more carefully...

Apologies for the mess and thanks again for fixing this.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

