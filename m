Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9POZHvLoGVvJEgAAmS7hNA
	; Fri, 08 Jun 2018 02:29:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 97BA86089E; Fri,  8 Jun 2018 02:29:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 02679601B4;
	Fri,  8 Jun 2018 02:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02679601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeFHC3z (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 22:29:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752413AbeFHC3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 22:29:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w582THRr045461
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 22:29:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jfcmy8wy6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 22:29:52 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 8 Jun 2018 03:29:50 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 03:29:45 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w582TiE323855238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 02:29:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAF3CA4051;
        Fri,  8 Jun 2018 03:20:43 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0350EA4040;
        Fri,  8 Jun 2018 03:20:39 +0100 (BST)
Received: from [9.195.45.85] (unknown [9.195.45.85])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jun 2018 03:20:38 +0100 (BST)
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
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Fri, 8 Jun 2018 07:59:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608101023.cbf20db485026213d490cb7c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18060802-0016-0000-0000-000001D95E1F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060802-0017-0000-0000-0000322C76DE
Message-Id: <0d487b32-3141-ec30-6cca-eba7159d70b0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On 06/08/2018 06:40 AM, Masami Hiramatsu wrote:
> On Wed,  6 Jun 2018 14:03:37 +0530
> Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:
> 
>> Why RFC again:
>>
>> This series is different from earlier versions[1]. Earlier series
>> implemented this feature in trace_uprobe while this has implemented
>> the logic in core uprobe. Few reasons for this:
>>  1. One of the major reason was the deadlock between uprobe_lock and
>>  mm->mmap inside trace_uprobe_mmap(). That deadlock was not easy to fix
>>  because mm->mmap is not in control of trace_uprobe_mmap() and it has
>>  to take uprobe_lock to loop over trace_uprobe list. More details can
>>  be found at[2]. With this new approach, there are no deadlocks found
>>  so far.
>>  2. Many of the core uprobe function and data-structures needs to be
>>  exported to make earlier implementation simple. With this new approach,
>>  reference counter logic is been implemented in core uprobe and thus
>>  no need to export anything.
> 
> I agree with you. Moreover, since uprobe_register/unregister() are
> exported to modules, this enablement would better be implemented
> inside uprobe so that all uprobe users benefit from this.


Sorry, I think you got me wrong. I meant, I don't need to expose all core
uprobe _static_ functions to tarce_uprobe.

Now, about kernel modules, basically uprobe_register() takes three parameters:
    inode, offset and consumer.
There is no scope for the reference counter there. So I've created one more
function: uprobe_register_refctr(). But this function is not exported as ABI
to kernel module. i.e. kernel modules still does not have a way to create
uprobe with reference counter. So for kernel modules,

is it fine to change current ABI from
    uprobe_register(inode, offset, consumer)
to
    uprobe_register(inode, offset, ref_ctr_offset, consumer)

Or I should introduce new function for this:
    uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)
and export it to kernel module?

What's your suggestion?

[...]

>> 
>>  - This patches still has one issue. If there are multiple instances of
>>    same application running and user wants to trace any particular
>>    instance, trace_uprobe is updating reference counter in all instances.
>>    This is not a problem on user side because instruction is not replaced
>>    with trap/int3 and thus user will only see samples from his interested
>>    process. But still this is more of a correctness issue. I'm working on
>>    a fix for this.
> 
> Hmm, it sounds like not a correctness issue, but there maybe a performace
> tradeoff. Tracing one particulear instance, other instances also will get
> a performance loss


Right, but it's temporary. I mean, putting everything in to this series was making
it complex. So this is the initial one and I'll send followup patches which will
optimize the reference counter update.


> (Only if the parameter preparation block is heavy,
> because the heaviest part of probing - trap/int3 and recording data - isn't
> executed.)
>> BTW, why this happens? I thought the refcounter part is just a data which
> is not shared among processes...
> 

This happens because we are not calling consumer_filter function. consumer_filter
is the one who decides whether to change the instruction to trap or not in a given
mm. We also need to call it before updating reference counter.

Let me know your thoughts.

Thanks,
Ravi
