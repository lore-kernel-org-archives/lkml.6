Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id joAoDiMjGls+ZAAAmS7hNA
	; Fri, 08 Jun 2018 06:34:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A3D00607DC; Fri,  8 Jun 2018 06:34:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 178816074D;
	Fri,  8 Jun 2018 06:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 178816074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeFHGen (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:34:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751108AbeFHGel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:34:41 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w586Xrvq110250
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 02:34:41 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jfk39ugmv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 02:34:40 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 8 Jun 2018 07:34:38 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 07:34:33 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w586YWt433554574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 06:34:32 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CAA111C04C;
        Fri,  8 Jun 2018 07:25:15 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E193411C050;
        Fri,  8 Jun 2018 07:25:09 +0100 (BST)
Received: from [9.195.45.85] (unknown [9.195.45.85])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jun 2018 07:25:09 +0100 (BST)
Subject: Re: [PATCH 0/7] Uprobes: Support SDT markers having reference count
 (semaphore)
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: oleg@redhat.com, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
 <20180608101023.cbf20db485026213d490cb7c@kernel.org>
 <0d487b32-3141-ec30-6cca-eba7159d70b0@linux.ibm.com>
 <20180608141431.c0196a2c80a8d4701bc9db58@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Fri, 8 Jun 2018 12:04:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608141431.c0196a2c80a8d4701bc9db58@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18060806-0016-0000-0000-000001D96D22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060806-0017-0000-0000-0000322C86D7
Message-Id: <71f19b63-a641-1705-f087-a39b8b81c4be@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

>> So for kernel modules,
>>
>> is it fine to change current ABI from
>>     uprobe_register(inode, offset, consumer)
>> to
>>     uprobe_register(inode, offset, ref_ctr_offset, consumer)
>>
>> Or I should introduce new function for this:
>>     uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)
>> and export it to kernel module?
>>
>> What's your suggestion?
> 
> Latter is fine to me. Since the refctr is introduced totally in userspace
> (for SDT) and free-address userspace probing doesn't need refctr, maybe
> we should keep those separated.

Sure.

> 
>> [...]
>>
>>>>
>>>>  - This patches still has one issue. If there are multiple instances of
>>>>    same application running and user wants to trace any particular
>>>>    instance, trace_uprobe is updating reference counter in all instances.
>>>>    This is not a problem on user side because instruction is not replaced
>>>>    with trap/int3 and thus user will only see samples from his interested
>>>>    process. But still this is more of a correctness issue. I'm working on
>>>>    a fix for this.
>>>
>>> Hmm, it sounds like not a correctness issue, but there maybe a performace
>>> tradeoff. Tracing one particulear instance, other instances also will get
>>> a performance loss
>>
>>
>> Right, but it's temporary. I mean, putting everything in to this series was making
>> it complex. So this is the initial one and I'll send followup patches which will
>> optimize the reference counter update.
> 
> Ah, OK. If you have prepared the followup patches, could you also send it
> with this series? Perhups it will help us to understand the issue clearer.

Not ready as such.. it's making the code bit complicated. I'm working on it
and will send the next series with those patches included.

> 
>>
>>> (Only if the parameter preparation block is heavy,
>>> because the heaviest part of probing - trap/int3 and recording data - isn't
>>> executed.)
>>>> BTW, why this happens? I thought the refcounter part is just a data which
>>> is not shared among processes...
>>>
>>
>> This happens because we are not calling consumer_filter function. consumer_filter
>> is the one who decides whether to change the instruction to trap or not in a given
>> mm. We also need to call it before updating reference counter.
> 
> Hmm, it sounds simple... maybe we can increment refctr in install_breakpoint/
> remove_breakpoint?

Not really, it would be simpler if I can put it inside install_breakpoint().
Consider an mmap() case. Probed instruction resides in the text section whereas
reference counter resides in the data section. These sections gets mapped using
separate mmap() calls. So, when process mmaps the text section we will change the
instruction, but section holding the reference counter may not have been mapped
yet in the virtual memory. If so, we will fail to update the reference counter.

Thanks,
Ravi
