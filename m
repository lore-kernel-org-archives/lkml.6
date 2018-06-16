Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5007FC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073DD2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073DD2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754227AbeFPPHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 11:07:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754012AbeFPPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 11:07:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5GF4OrS008849
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 11:07:39 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jmvvmkvab-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 11:07:39 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Sat, 16 Jun 2018 16:07:37 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 16 Jun 2018 16:07:32 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5GF7Vfs28967014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 16 Jun 2018 15:07:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 748D911C04C;
        Sat, 16 Jun 2018 15:58:01 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5BEA11C050;
        Sat, 16 Jun 2018 15:57:55 +0100 (BST)
Received: from [9.78.192.161] (unknown [9.78.192.161])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 16 Jun 2018 15:57:55 +0100 (BST)
Subject: Re: [PATCH 0/7] Uprobes: Support SDT markers having reference count
 (semaphore)
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     oleg@redhat.com, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
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
 <71f19b63-a641-1705-f087-a39b8b81c4be@linux.ibm.com>
 <20180609004549.ea7b1854772217598bb1cdfd@kernel.org>
 <6225481e-fa00-a242-2b57-223559e3c488@linux.ibm.com>
 <20180616225032.3fc9a027dca76926ff198ff8@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Sat, 16 Jun 2018 20:37:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180616225032.3fc9a027dca76926ff198ff8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18061615-0012-0000-0000-000002801ED1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061615-0013-0000-0000-000020B14BAE
Message-Id: <fa2a2578-1f39-8858-afa0-d8076aa5bc15@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=865 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806160183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On 06/16/2018 07:20 PM, Masami Hiramatsu wrote:
> Hi Ravi,
> 
> Sorry for replying later.

No issues :)

> 
> On Mon, 11 Jun 2018 10:01:58 +0530
> Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:
> 
>> Hi Masami,
>>
>>>>> Hmm, it sounds simple... maybe we can increment refctr in install_breakpoint/
>>>>> remove_breakpoint?
>>>>
>>>> Not really, it would be simpler if I can put it inside install_breakpoint().
>>>> Consider an mmap() case. Probed instruction resides in the text section whereas
>>>> reference counter resides in the data section. These sections gets mapped using
>>>> separate mmap() calls. So, when process mmaps the text section we will change the
>>>> instruction, but section holding the reference counter may not have been mapped
>>>> yet in the virtual memory. If so, we will fail to update the reference counter.
>>>
>>> Got it. 
>>> In such case, maybe we can hook the target page mmapped and do install_breakpoint()
>>> at that point. Since the instruction is protected by a refctr, unless mmap the
>>> page on where the refctr is, the program doesn't reach the tracepoint. Is that right?
>>>
>>
>> You mean, when mmap(text) happens, save the target page somewhere and when
>> mmap(data) happens, update both instruction and ref_ctr?
> 
> Yes. I think you can just clone the target(text) page but not install
> breakpoint, and if mmap(data) happens, update both.

I'm preparing a prototype according to this. The only difference in my approach is,
I'm not delaying instruction update. I.e. let instruction update happen as it is,
just mark that uprobe as delayed. Whenever vma holding reference counter gets mapped, 
update the reference counter.

Will post the series soon.

Thanks for the reply,
Ravi

