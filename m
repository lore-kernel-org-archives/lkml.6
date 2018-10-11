Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66EFC46463
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17082077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17082077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeJKSgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:36:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726071AbeJKSgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:36:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BB9Bci108690
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 07:09:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n23wmuxkf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 07:09:58 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Thu, 11 Oct 2018 12:09:56 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Oct 2018 12:09:51 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9BB9oKc7799278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Oct 2018 11:09:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0CB7AE045;
        Thu, 11 Oct 2018 14:08:33 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68101AE057;
        Thu, 11 Oct 2018 14:08:33 +0100 (BST)
Received: from [9.152.212.168] (unknown [9.152.212.168])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Oct 2018 14:08:33 +0100 (BST)
Subject: Re: linux-next: build warnings from the build of Linus' tree
To:     Greg KH <gregkh@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     arnd@arndb.de, Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180824172053.20fa197294f51496dcec5605@kernel.org>
 <20180824204756.e787765461975cd1e27502dc@kernel.org>
 <20180824224211.2934d7c0@canb.auug.org.au>
 <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
 <20180828072333.36af4d5d@canb.auug.org.au>
 <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
 <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
 <20181011114809.5590ecb3@canb.auug.org.au>
 <d5b166d6-461c-f382-e3d2-8993b845bd5a@linux.ibm.com>
 <20181011205849.6f6645fa@canb.auug.org.au> <20181011103750.GA29735@kroah.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Thu, 11 Oct 2018 13:09:53 +0200
MIME-Version: 1.0
In-Reply-To: <20181011103750.GA29735@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101111-4275-0000-0000-000002C82393
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101111-4276-0000-0000-000037D358F4
Message-Id: <c885947f-2f66-745f-f8c9-1b3dd8162989@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2018 12:37, Greg KH wrote:
> On Thu, Oct 11, 2018 at 08:58:49PM +1100, Stephen Rothwell wrote:
>> On Thu, 11 Oct 2018 09:44:36 +0200 Peter Oberparleiter <oberpar@linux.ibm.com> wrote:
>>> On 11.10.2018 02:48, Stephen Rothwell wrote:
>>>> OK, I have been carrying this "quick fix" patch in linux-next since
>>>> September 7.  Is anyone going to pick this up and send it to
>>>> Greg/Linus, please?  
>>>
>>> Sorry about that - I posted a modified fix at
>>>
>>>   https://lkml.org/lkml/2018/9/13/367
>>>
>>> but didn't get a response. I guess I should have reposted sooner. But
>>> before I do that:
>>>
>>> Arnd: Is this something that you can pick up or should I include someone
>>> else?
>>
>> It would be nice if it could go in before the v4.19 release because the
>> commit that exposed the warnings went into v4.19-rc1.
> 
> I agree.  If someone could at least review/ack it, that would be great.
> What tree does this normally go through?

gcov-kernel related changes are usually picked up by Andrew Morton (on
cc now). In this case I wasn't sure who best to address since its mostly
asm-generic/linker script changes.

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

