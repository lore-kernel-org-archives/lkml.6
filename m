Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CB9C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3B821EFA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3B821EFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbeHISwM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:52:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730634AbeHISwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:52:12 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w79GOcMH091893
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 12:26:33 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2krqq8v3bd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:26:33 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 9 Aug 2018 17:26:31 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 17:26:28 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w79GQRmW37879980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 16:26:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9830AE04D;
        Thu,  9 Aug 2018 19:26:18 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 612EBAE053;
        Thu,  9 Aug 2018 19:26:18 +0100 (BST)
Received: from localhost (unknown [9.79.184.1])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 19:26:18 +0100 (BST)
Date:   Thu, 09 Aug 2018 21:56:24 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf probe powerpc: Fix trace event post-processing
To:     acme@kernel.org, Sandipan Das <sandipan@linux.ibm.com>
Cc:     aneesh.kumar@linux.vnet.ibm.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com
References: <20180809161929.35058-1-sandipan@linux.ibm.com>
In-Reply-To: <20180809161929.35058-1-sandipan@linux.ibm.com>
User-Agent: astroid/0.12.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18080916-0008-0000-0000-0000025F7CA8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080916-0009-0000-0000-000021C78D6E
Message-Id: <1533831952.2wznw8gaoa.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sandipan Das wrote:
> In some cases, a symbol may have multiple aliases. Attempting to add
> an entry probe for such symbols results in a probe being added at an
> incorrect location while it fails altogether for return probes. This
> is only applicable for binaries with debug information.
> 
> During the arch-dependent post-processing, the offset from the start
> of the symbol at which the probe is to be attached is determined and
> added to the start address of the symbol to get the probe's location.
> In case there are multiple aliases, this offset gets added multiple
> times for each alias of the symbol and we end up with an incorrect
> probe location.
> 
> This can be verified on a powerpc64le system as shown below.
> 
>   $ nm /lib/modules/$(uname -r)/build/vmlinux | grep "sys_open$"
>   ...
>   c000000000414290 T __se_sys_open
>   c000000000414290 T sys_open
> 
>   $ objdump -d /lib/modules/$(uname -r)/build/vmlinux | grep -A 10 "<__se_sys_open>:"
> 
>   c000000000414290 <__se_sys_open>:
>   c000000000414290:       19 01 4c 3c     addis   r2,r12,281
>   c000000000414294:       70 c4 42 38     addi    r2,r2,-15248
>   c000000000414298:       a6 02 08 7c     mflr    r0
>   c00000000041429c:       e8 ff a1 fb     std     r29,-24(r1)
>   c0000000004142a0:       f0 ff c1 fb     std     r30,-16(r1)
>   c0000000004142a4:       f8 ff e1 fb     std     r31,-8(r1)
>   c0000000004142a8:       10 00 01 f8     std     r0,16(r1)
>   c0000000004142ac:       c1 ff 21 f8     stdu    r1,-64(r1)
>   c0000000004142b0:       78 23 9f 7c     mr      r31,r4
>   c0000000004142b4:       78 1b 7e 7c     mr      r30,r3
> 
>   For both the entry probe and the return probe, the probe location
>   should be _text+4276888 (0xc000000000414298). Since another alias
>   exists for 'sys_open', the post-processing code will end up adding
>   the offset (8 for powerpc64le) twice and perf will attempt to add
>   the probe at _text+4276896 (0xc0000000004142a0) instead.
> 
> Before:
> 
>   # perf probe -v -a sys_open
> 
>   probe-definition(0): sys_open
>   symbol:sys_open file:(null) line:0 offset:0 return:0 lazy:(null)
>   0 arguments
>   Looking at the vmlinux_path (8 entries long)
>   Using /lib/modules/4.18.0-rc8+/build/vmlinux for symbols
>   Open Debuginfo file: /lib/modules/4.18.0-rc8+/build/vmlinux
>   Try to find probe point from debuginfo.
>   Symbol sys_open address found : c000000000414290
>   Matched function: __se_sys_open [2ad03a0]
>   Probe point found: __se_sys_open+0
>   Found 1 probe_trace_events.
>   Opening /sys/kernel/debug/tracing/kprobe_events write=1
>   Writing event: p:probe/sys_open _text+4276896
>   Added new event:
>     probe:sys_open       (on sys_open)
>   ...
> 
>   # perf probe -v -a sys_open%return $retval
> 
>   probe-definition(0): sys_open%return
>   symbol:sys_open file:(null) line:0 offset:0 return:1 lazy:(null)
>   0 arguments
>   Looking at the vmlinux_path (8 entries long)
>   Using /lib/modules/4.18.0-rc8+/build/vmlinux for symbols
>   Open Debuginfo file: /lib/modules/4.18.0-rc8+/build/vmlinux
>   Try to find probe point from debuginfo.
>   Symbol sys_open address found : c000000000414290
>   Matched function: __se_sys_open [2ad03a0]
>   Probe point found: __se_sys_open+0
>   Found 1 probe_trace_events.
>   Opening /sys/kernel/debug/tracing/README write=0
>   Opening /sys/kernel/debug/tracing/kprobe_events write=1
>   Parsing probe_events: p:probe/sys_open _text+4276896
>   Group:probe Event:sys_open probe:p
>   Writing event: r:probe/sys_open__return _text+4276896
>   Failed to write event: Invalid argument
>     Error: Failed to add events. Reason: Invalid argument (Code: -22)
> 
> After:
> 
>   # perf probe -v -a sys_open
> 
>   probe-definition(0): sys_open
>   symbol:sys_open file:(null) line:0 offset:0 return:0 lazy:(null)
>   0 arguments
>   Looking at the vmlinux_path (8 entries long)
>   Using /lib/modules/4.18.0-rc8+/build/vmlinux for symbols
>   Open Debuginfo file: /lib/modules/4.18.0-rc8+/build/vmlinux
>   Try to find probe point from debuginfo.
>   Symbol sys_open address found : c000000000414290
>   Matched function: __se_sys_open [2ad03a0]
>   Probe point found: __se_sys_open+0
>   Found 1 probe_trace_events.
>   Opening /sys/kernel/debug/tracing/kprobe_events write=1
>   Writing event: p:probe/sys_open _text+4276888
>   Added new event:
>     probe:sys_open       (on sys_open)
>   ...
> 
>   # perf probe -v -a sys_open%return $retval
> 
>   probe-definition(0): sys_open%return
>   symbol:sys_open file:(null) line:0 offset:0 return:1 lazy:(null)
>   0 arguments
>   Looking at the vmlinux_path (8 entries long)
>   Using /lib/modules/4.18.0-rc8+/build/vmlinux for symbols
>   Open Debuginfo file: /lib/modules/4.18.0-rc8+/build/vmlinux
>   Try to find probe point from debuginfo.
>   Symbol sys_open address found : c000000000414290
>   Matched function: __se_sys_open [2ad03a0]
>   Probe point found: __se_sys_open+0
>   Found 1 probe_trace_events.
>   Opening /sys/kernel/debug/tracing/README write=0
>   Opening /sys/kernel/debug/tracing/kprobe_events write=1
>   Parsing probe_events: p:probe/sys_open _text+4276888
>   Group:probe Event:sys_open probe:p
>   Writing event: r:probe/sys_open__return _text+4276888
>   Added new event:
>     probe:sys_open__return (on sys_open%return)
>   ...
> 
> Fixes: 99e608b5954c ("perf probe ppc64le: Fix probe location when using DWARF")
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

- Naveen


