Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeEREdv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 00:33:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751112AbeEREdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 00:33:50 -0400
Subject: Re: [PATCH 1/2] perf script: Show virtual addresses instead of
 offsets
To: Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@redhat.com
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com
References: <20180517063326.6319-1-sandipan@linux.vnet.ibm.com>
 <20180517195957.GD18538@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Fri, 18 May 2018 10:03:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517195957.GD18538@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18051804-0020-0000-0000-0000041E7BA0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051804-0021-0000-0000-000042B3A21C
Message-Id: <d01892c2-4c99-620c-5b1b-76dd82af3c21@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805180047
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo,

We already have a binary offset handy in perf code but there is no way to
dump it with perf script. We can derive it from symname+symoff but that's
a manual work.

Will it be good to have a '-F binoff' option?

Ravi


On 05/18/2018 01:29 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 17, 2018 at 12:03:25PM +0530, Sandipan Das escreveu:
>> When perf data is recorded with the call-graph option enabled,
>> the callchain shown by perf script shows the binary offsets of
>> the symbols as the ip. This is incorrect for kernel symbols as
>> the ip values are always off by a fixed offset depending on the
>> architecture. If the offsets from the start of the symbols are
>> printed, they are also incorrect for both kernel and userspace
>> symbols.
>>
>> Without the call-graph option, the callchain shows the virtual
>> addresses of the symbols rather than their binary offsets. The
>> offsets printed in this case are also correct.
>>
>> This fixes the inconsistency in perf script's output.
> 
> Thanks, tested and applied,
> 
> - Arnaldo
> 
