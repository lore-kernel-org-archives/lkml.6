Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E6EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101002077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101002077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeIESfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:35:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbeIESfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:35:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85E0DwU127846
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 10:04:38 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2maf5bmr31-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 10:04:36 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 5 Sep 2018 08:03:42 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 08:03:39 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85E3cBX26214434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 07:03:38 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6411DBE05B;
        Wed,  5 Sep 2018 08:03:38 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68DB7BE04F;
        Wed,  5 Sep 2018 08:03:35 -0600 (MDT)
Received: from [9.199.40.212] (unknown [9.199.40.212])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  5 Sep 2018 08:03:34 -0600 (MDT)
Subject: Re: [RFC PATCH v1 00/17] ban the use of _PAGE_XXX flags outside
 platform specific code
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Wed, 5 Sep 2018 19:33:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18090514-0004-0000-0000-00001484725D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01083914; UDB=6.00559407; IPR=6.00863915;
 MB=3.00023126; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-05 14:03:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090514-0005-0000-0000-000088B51A28
Message-Id: <95ee30b8-70b5-0f74-b677-417d3b0ca19e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 06:06 PM, Christophe Leroy wrote:
> Today flags like for instance _PAGE_RW or _PAGE_USER are used through
> common parts of code.
> Using those directly in common parts of code have proven to lead to
> mistakes or misbehaviour, because their use is not always as trivial
> as one could think.
> 
> For instance, (flags & _PAGE_USER) == 0 isn't enough to tell
> that a page is a kernel page, because some targets are using
> _PAGE_PRIVILEDGED and not _PAGE_USER, so the test has to be
> (flags & (_PAGE_USER | _PAGE_PRIVILEDGED)) == _PAGE_PRIVILEDGED
> This has to (bad) consequences:
> 
>   - All targets must define every bit, even the unsupported ones,
>     leading to a lot of useless #define _PAGE_XXX 0
>   - If someone forgets to take into account all possible _PAGE_XXX bits
>     for the case, we can get unexpected behaviour on some targets.
> 
> This becomes even more complex when we come to using _PAGE_RW.
> Testing (flags & _PAGE_RW) is not enough to test whether a page
> if writable or not, because:
> 
>   - Some targets have _PAGE_RO instead, which has to be unset to tell
>     a page is writable
>   - Some targets have _PAGE_R and _PAGE_W, in which case
>     _PAGE_RW = _PAGE_R | _PAGE_W
>   - Even knowing whether a page is readable is not always trivial because:
>     - Some targets requires to check that _PAGE_R is set to ensure page
>     is readable
>     - Some targets requires to check that _PAGE_NA is not set
>     - Some targets requires to check that _PAGE_RO or _PAGE_RW is set
> 
> Etc ....
> 
> In order to work around all those issues and minimise the risks of errors,
> this serie aims at removing all use of _PAGE_XXX flags from powerpc code
> and always use pte_xxx() and pte_mkxxx() accessors instead. Those accessors
> are then defined in target specific parts of the kernel code.

We recently did on book3s 64.

static inline int pte_present(pte_t pte)
{
	/*
	 * A pte is considerent present if _PAGE_PRESENT is set.
	 * We also need to consider the pte present which is marked
	 * invalid during ptep_set_access_flags. Hence we look for _PAGE_INVALID
	 * if we find _PAGE_PRESENT cleared.
	 */
	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_INVALID));
}

So I guess with that pte_present conversion we need to be careful.

Do you have a git tree which I can use to double check?

-aneesh

