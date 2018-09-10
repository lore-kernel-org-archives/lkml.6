Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0006C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877E820854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877E820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeIJLBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:01:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726185AbeIJLBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:01:23 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8A68xvD130785
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:09:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mdd5pkns6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:09:00 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 10 Sep 2018 07:08:52 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Sep 2018 07:08:50 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8A68nBR63176872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Sep 2018 06:08:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4C364C044;
        Mon, 10 Sep 2018 09:08:41 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3FDA4C040;
        Mon, 10 Sep 2018 09:08:39 +0100 (BST)
Received: from skywalker (unknown [9.85.68.199])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 10 Sep 2018 09:08:39 +0100 (BST)
Received: (nullmailer pid 15332 invoked by uid 1000);
        Mon, 10 Sep 2018 06:08:46 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 00/17] ban the use of _PAGE_XXX flags outside platform specific code
In-Reply-To: <1f4d6cc9-5d18-b171-02b0-d715629d594f@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr> <8736uneylc.fsf@linux.ibm.com> <1f4d6cc9-5d18-b171-02b0-d715629d594f@c-s.fr>
Date:   Mon, 10 Sep 2018 11:38:46 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18091006-0008-0000-0000-0000026EF712
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091006-0009-0000-0000-000021D72831
Message-Id: <8736uhsx3l.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-10_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809100067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> On 09/06/2018 09:58 AM, Aneesh Kumar K.V wrote:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> 
>>> Today flags like for instance _PAGE_RW or _PAGE_USER are used through
>>> common parts of code.
>>> Using those directly in common parts of code have proven to lead to
>>> mistakes or misbehaviour, because their use is not always as trivial
>>> as one could think.
>>>
>>> For instance, (flags & _PAGE_USER) == 0 isn't enough to tell
>>> that a page is a kernel page, because some targets are using
>>> _PAGE_PRIVILEDGED and not _PAGE_USER, so the test has to be
>>> (flags & (_PAGE_USER | _PAGE_PRIVILEDGED)) == _PAGE_PRIVILEDGED
>>> This has to (bad) consequences:
>>>
>>>   - All targets must define every bit, even the unsupported ones,
>>>     leading to a lot of useless #define _PAGE_XXX 0
>>>   - If someone forgets to take into account all possible _PAGE_XXX bits
>>>     for the case, we can get unexpected behaviour on some targets.
>>>
>>> This becomes even more complex when we come to using _PAGE_RW.
>>> Testing (flags & _PAGE_RW) is not enough to test whether a page
>>> if writable or not, because:
>>>
>>>   - Some targets have _PAGE_RO instead, which has to be unset to tell
>>>     a page is writable
>>>   - Some targets have _PAGE_R and _PAGE_W, in which case
>>>     _PAGE_RW = _PAGE_R | _PAGE_W
>>>   - Even knowing whether a page is readable is not always trivial because:
>>>     - Some targets requires to check that _PAGE_R is set to ensure page
>>>     is readable
>>>     - Some targets requires to check that _PAGE_NA is not set
>>>     - Some targets requires to check that _PAGE_RO or _PAGE_RW is set
>>>
>>> Etc ....
>>>
>>> In order to work around all those issues and minimise the risks of errors,
>>> this serie aims at removing all use of _PAGE_XXX flags from powerpc code
>>> and always use pte_xxx() and pte_mkxxx() accessors instead. Those accessors
>>> are then defined in target specific parts of the kernel code.
>> 
>> The series is really good. It also helps in code readability. Few things
>> i am not sure there is a way to reduce the overhead
>> 
>> -		access = _PAGE_EXEC;
>> +		access = pte_val(pte_mkexec(__pte(0)));
>> 
>> Considering we have multiple big endian to little endian coversion there
>> for book3s 64.
>
> Thanks for the review.
>
> For the above, I propose the following:
>
> diff --git a/arch/powerpc/mm/hash_utils_64.c 
> b/arch/powerpc/mm/hash_utils_64.c
> index f23a89d8e4ce..904ac9c84ea5 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1482,7 +1482,7 @@ static bool should_hash_preload(struct mm_struct 
> *mm, unsigned long ea)
>   #endif
>
>   void hash_preload(struct mm_struct *mm, unsigned long ea,
> -		  unsigned long access, unsigned long trap)
> +		  bool is_exec, unsigned long trap)
>   {
>   	int hugepage_shift;
>   	unsigned long vsid;
> @@ -1490,6 +1490,7 @@ void hash_preload(struct mm_struct *mm, unsigned 
> long ea,
>   	pte_t *ptep;
>   	unsigned long flags;
>   	int rc, ssize, update_flags = 0;
> +	unsigned long access = is_exec ? _PAGE_EXEC : 0;


I guess it will be better if we do

unsigned long access = _PAGE_PRESENT | _PAGE_READ

if (is_exec)
   access |= _PAGE_EXEC.

That will also bring it closer to __hash_page. I agree that we should
always find _PAGE_PRESENT and _PAGE_READ set, because we just handled
the page fault.

-aneesh


