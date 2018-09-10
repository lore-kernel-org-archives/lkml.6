Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC7EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5793A2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5793A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeIJSVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:21:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728403AbeIJSVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:21:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8ADPJXm128202
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:27:28 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mds5bhf29-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:27:27 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Mon, 10 Sep 2018 14:27:26 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Sep 2018 14:27:22 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8ADRLpY39977068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Sep 2018 13:27:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D7CAAE051;
        Mon, 10 Sep 2018 16:26:38 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BE59AE053;
        Mon, 10 Sep 2018 16:26:38 +0100 (BST)
Received: from [9.152.212.144] (unknown [9.152.212.144])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Sep 2018 16:26:38 +0100 (BST)
Subject: Re: linux-next: build warnings from the build of Linus' tree
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arnd@arndb.de
References: <20180824133206.4218c2e5@canb.auug.org.au>
 <20180824172053.20fa197294f51496dcec5605@kernel.org>
 <20180824204756.e787765461975cd1e27502dc@kernel.org>
 <20180824224211.2934d7c0@canb.auug.org.au>
 <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
 <20180828072333.36af4d5d@canb.auug.org.au>
 <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
 <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
 <20180907014209.49e2940f74615a1e4f544ffd@kernel.org>
 <ebad9c9d-a7d0-44cc-f000-bf5e500fcd24@linux.ibm.com>
 <20180908125749.9c903e507a33046d5586e841@kernel.org>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Mon, 10 Sep 2018 15:27:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180908125749.9c903e507a33046d5586e841@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18091013-0020-0000-0000-000002C41EE6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091013-0021-0000-0000-000021116949
Message-Id: <1de08f6a-7c9e-1a75-e3bd-e8bcf99f5e35@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809100138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.09.2018 05:57, Masami Hiramatsu wrote:
> On Fri, 7 Sep 2018 14:50:59 +0200
> Peter Oberparleiter <oberpar@linux.ibm.com> wrote:
> 
>> On 06.09.2018 18:42, Masami Hiramatsu wrote:
>>> Peter Oberparleiter <oberpar@linux.ibm.com> wrote:
>>>> I've attached a quick fix that should address both problems. I'd
>>>> appreciate if this patch could get some testing before I post proper fix
>>>> patches.
>>>
>>> Hmm, I'm still not able to reproduce it on powerpc cross build even with
>>> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y ... So, sorry I couldn't test this patch.
>>
>> Maybe this is related to the compiler/binutils versions used. I'm using
>> Fedora 28's gcc-powerpc64 and binutils-powerpc64 packages:
>>
>> powerpc64-linux-gnu-gcc (GCC) 7.1.1 20170622 (Red Hat Cross 7.1.1-3)
>> GNU ld version 2.29.1-4.fc28
>>
>> For reference I'm also attaching the config that I used to reproduce the
>> problem on kernel v4.18.
>>
>>>> diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
>>>> index ae5fdff18406..2ca33277a28b 100644
>>>> --- a/arch/arm/kernel/vmlinux.lds.h
>>>> +++ b/arch/arm/kernel/vmlinux.lds.h
>>>> @@ -48,6 +48,7 @@
>>>>
>>>>  #define ARM_DISCARD							\
>>>>  		*(.ARM.exidx.exit.text)					\
>>>> +		*(.ARM.exidx.text.exit)					\
>>>
>>> BTW, why would we need this?
>>
>> That's necessary to fix one of the two ARM linker failures reported via
>> https://lkml.org/lkml/2018/8/24/345
>>
>>>>> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
>>>>> kernel/trace/trace_clock.o: defined in discarded section `.text.exit'
>>>>> of kernel/trace/trace_clock.o
>>
>> Section ".ARM.exidx.text.exit" refers to ".text.exit" which was
>> discarded. With the change above, the extraneous section
>> ".ARM.exidx.text.exit" is also discarded, resolving the linker failure.
> 
> OK, so your patch fixes following issue too?
> 
> https://patchwork.kernel.org/patch/10584685/

Yes it does, by discarding the text.exit section unconditionally. I
don't think we need to keep any exit-related section introduced by GCOV
profiling. It is my understanding that the code contained in such a
section is only relevant for user-space profiling, to process profiling
data when a program ends.

Also discarding .ARM.exidx.text.exit seems to be more consistent to how
.ARM.exidx.exit.text is handled.

> In that case, we should drop above patch.

Yes, I agree.

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

