Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KuawBE/7HVvvPwAAmS7hNA
	; Mon, 11 Jun 2018 04:32:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E270C60792; Mon, 11 Jun 2018 04:32:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6BE8260385;
	Mon, 11 Jun 2018 04:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BE8260385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932204AbeFKEcK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 00:32:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753736AbeFKEcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 00:32:09 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5B4TGcl100686
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 00:32:09 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jhhaahewr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 00:32:08 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 11 Jun 2018 05:32:06 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Jun 2018 05:32:02 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5B4W1rm30277788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jun 2018 04:32:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 813C0A4040;
        Mon, 11 Jun 2018 05:22:56 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A778A404D;
        Mon, 11 Jun 2018 05:22:53 +0100 (BST)
Received: from [9.124.31.215] (unknown [9.124.31.215])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jun 2018 05:22:53 +0100 (BST)
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
 <71f19b63-a641-1705-f087-a39b8b81c4be@linux.ibm.com>
 <20180609004549.ea7b1854772217598bb1cdfd@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Mon, 11 Jun 2018 10:01:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180609004549.ea7b1854772217598bb1cdfd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18061104-4275-0000-0000-0000028C4520
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061104-4276-0000-0000-0000379361FB
Message-Id: <6225481e-fa00-a242-2b57-223559e3c488@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=717 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806110054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

>>> Hmm, it sounds simple... maybe we can increment refctr in install_breakpoint/
>>> remove_breakpoint?
>>
>> Not really, it would be simpler if I can put it inside install_breakpoint().
>> Consider an mmap() case. Probed instruction resides in the text section whereas
>> reference counter resides in the data section. These sections gets mapped using
>> separate mmap() calls. So, when process mmaps the text section we will change the
>> instruction, but section holding the reference counter may not have been mapped
>> yet in the virtual memory. If so, we will fail to update the reference counter.
> 
> Got it. 
> In such case, maybe we can hook the target page mmapped and do install_breakpoint()
> at that point. Since the instruction is protected by a refctr, unless mmap the
> page on where the refctr is, the program doesn't reach the tracepoint. Is that right?
> 

You mean, when mmap(text) happens, save the target page somewhere and when
mmap(data) happens, update both instruction and ref_ctr?

This sounds feasible. Let me think on it.

Thanks for suggestion,
Ravi
