Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033545AbeBOOtJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:49:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1033102AbeBOOtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:49:03 -0500
Date: Thu, 15 Feb 2018 20:18:51 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 9/9] perf tests: Use arch__compare_symbol_names to compare
 symbols
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Ahern <dsahern@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
References: <20180215122635.24029-1-jolsa@kernel.org>
        <20180215122635.24029-10-jolsa@kernel.org>
        <20180215142711.GH22818@kernel.org>
In-Reply-To: <20180215142711.GH22818@kernel.org>
User-Agent: astroid/0.11.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18021514-0040-0000-0000-0000043411C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021514-0041-0000-0000-000020D6127A
Message-Id: <1518705799.8kkjgp6cbr.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802150182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 15, 2018 at 01:26:35PM +0100, Jiri Olsa escreveu:
>> The symbol search called by machine__find_kernel_symbol_by_name
>> is using internally arch__compare_symbol_names function to compare
>> 2 symbol names, because different archs have different ways of
>> comparing symbols. Mostly for skipping '.' prefixes and similar.
>> 
>> In test 1 when we try to find matching symbols in kallsyms and
>> vmlinux, by address and by symbol name. When either is found
>> we compare the pair symbol names  by simple strcmp, which is not
>> good enough for reasons explained in previous paragraph.
>> 
>> On powerpc this can cause lockup, because even thought we found
>> the pair, the compared names are different and don't match
>> simple strcmp. Following code path is executed, that leads
>> to lockup:
> 
> Added a:
> 
>     Fixes: 031b84c407c3 ("perf probe ppc: Enable matching against dot symbols automatically")
> 
> And CCed Naveen, the author of that patch, so that gets notified of this
> fix.

Thanks! This does fix the test on ppc64 BE. So:
Acked-and-Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

- Naveen
