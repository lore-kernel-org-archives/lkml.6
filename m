Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbeBQGP3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 01:15:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750803AbeBQGP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 01:15:28 -0500
Subject: Re: [PATCH 1/3] tools include powerpc: Grab a copy of
 arch/powerpc/include/uapi/asm/unistd.h
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180129083417.31240-2-ravi.bangoria@linux.vnet.ibm.com>
 <20180216165245.GD24436@kernel.org> <20180216165616.GF24436@kernel.org>
 <20180216170336.GG24436@kernel.org> <20180216170812.GA16919@kernel.org>
 <20180216172901.GB16919@kernel.org> <20180216175002.GC16919@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Sat, 17 Feb 2018 11:47:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216175002.GC16919@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18021706-0040-0000-0000-00000413A372
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021706-0041-0000-0000-00002616A96E
Message-Id: <a7b11ddd-2c24-ff15-0861-6621053f9c86@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802170082
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops.. Really sorry about that.

I've tested acme/perf/core on ubuntu ppc32 with and without libaudit-dev
and it's working fine.

Thank you very much for fixing it,
Ravi

On 02/16/2018 11:20 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 16, 2018 at 02:29:01PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Humm, we need to create two tables, one for 32-bit and another for 64,
>> even with ppc not having (AFAIK) clashes in syscall numbers for 32/64...
>>
>> Trying to do it now.
> Now seems to work, take a look at my perf/core branch, should be one of the first few csets.
>
> perfbuilder@cc1a85517216:/git/perf$ grep 192 /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_32.c 
> 	[192] = "mmap2",
> perfbuilder@cc1a85517216:/git/perf$ powerpc-linux-gnu-gcc --version
> powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
> perfbuilder@cc1a85517216:/git/perf$
>
> perfbuilder@9d7fc9dcfb73:/git/perf$ grep 192 /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_32.c
> 	[192] = "mmap2",
> perfbuilder@9d7fc9dcfb73:/git/perf$ grep 192 /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_64.c
> perfbuilder@9d7fc9dcfb73:/git/perf$ powerpc64-linux-gnu-gcc --version
> powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
> perfbuilder@9d7fc9dcfb73:/git/perf$ 
>
