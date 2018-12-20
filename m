Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFF1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F5F217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbeLTRUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387952AbeLTRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:42 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBKHEXZY066035
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:20:40 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pgdqf4peq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:20:40 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 20 Dec 2018 17:20:39 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Dec 2018 17:20:35 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBKHKYsk14614712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Dec 2018 17:20:34 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D698EAE063;
        Thu, 20 Dec 2018 17:20:34 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C838CAE05C;
        Thu, 20 Dec 2018 17:20:31 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.80.210.228])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 20 Dec 2018 17:20:31 +0000 (GMT)
References: <20181219213338.26619-1-igor.stoppa@huawei.com> <20181219213338.26619-5-igor.stoppa@huawei.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, igor.stoppa@huawei.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] __wr_after_init: x86_64: __wr_op
In-reply-to: <20181219213338.26619-5-igor.stoppa@huawei.com>
Date:   Thu, 20 Dec 2018 15:20:29 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18122017-0052-0000-0000-0000036ABA69
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010255; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01134556; UDB=6.00589901; IPR=6.00914729;
 MB=3.00024772; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-20 17:20:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122017-0053-0000-0000-00005F2D2D08
Message-Id: <87r2ecunc2.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=922 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812200140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Igor,

> +/*
> + * The following two variables are statically allocated by the linker
> + * script at the the boundaries of the memory region (rounded up to
> + * multiples of PAGE_SIZE) reserved for __wr_after_init.
> + */
> +extern long __start_wr_after_init;
> +extern long __end_wr_after_init;
> +
> +static inline bool is_wr_after_init(unsigned long ptr, __kernel_size_t size)
> +{
> +	unsigned long start = (unsigned long)&__start_wr_after_init;
> +	unsigned long end = (unsigned long)&__end_wr_after_init;
> +	unsigned long low = ptr;
> +	unsigned long high = ptr + size;
> +
> +	return likely(start <= low && low <= high && high <= end);
> +}
> +
> +void *__wr_op(unsigned long dst, unsigned long src, __kernel_size_t len,
> +	      enum wr_op_type op)
> +{
> +	temporary_mm_state_t prev;
> +	unsigned long offset;
> +	unsigned long wr_poking_addr;
> +
> +	/* Confirm that the writable mapping exists. */
> +	if (WARN_ONCE(!wr_ready, "No writable mapping available"))
> +		return (void *)dst;
> +
> +	if (WARN_ONCE(op >= WR_OPS_NUMBER, "Invalid WR operation.") ||
> +	    WARN_ONCE(!is_wr_after_init(dst, len), "Invalid WR range."))
> +		return (void *)dst;
> +
> +	offset = dst - (unsigned long)&__start_wr_after_init;
> +	wr_poking_addr = wr_poking_base + offset;
> +	local_irq_disable();
> +	prev = use_temporary_mm(wr_poking_mm);
> +
> +	if (op == WR_MEMCPY)
> +		copy_to_user((void __user *)wr_poking_addr, (void *)src, len);
> +	else if (op == WR_MEMSET)
> +		memset_user((void __user *)wr_poking_addr, (u8)src, len);
> +
> +	unuse_temporary_mm(prev);
> +	local_irq_enable();
> +	return (void *)dst;
> +}

There's a lot of casting back and forth between unsigned long and void *
(also in the previous patch). Is there a reason for that? My impression
is that there would be less casts if variables holding addresses were
declared as void * in the first place. In that case, it wouldn't hurt to
have an additional argument in __rw_op() to carry the byte value for the
WR_MEMSET operation.

> +
> +#define TB (1UL << 40)
> +
> +struct mm_struct *copy_init_mm(void);
> +void __init wr_poking_init(void)
> +{
> +	unsigned long start = (unsigned long)&__start_wr_after_init;
> +	unsigned long end = (unsigned long)&__end_wr_after_init;
> +	unsigned long i;
> +	unsigned long wr_range;
> +
> +	wr_poking_mm = copy_init_mm();
> +	if (WARN_ONCE(!wr_poking_mm, "No alternate mapping available."))
> +		return;
> +
> +	wr_range = round_up(end - start, PAGE_SIZE);
> +
> +	/* Randomize the poking address base*/
> +	wr_poking_base = TASK_UNMAPPED_BASE +
> +		(kaslr_get_random_long("Write Rare Poking") & PAGE_MASK) %
> +		(TASK_SIZE - (TASK_UNMAPPED_BASE + wr_range));
> +
> +	/*
> +	 * Place 64TB of kernel address space within 128TB of user address
> +	 * space, at a random page aligned offset.
> +	 */
> +	wr_poking_base = (((unsigned long)kaslr_get_random_long("WR Poke")) &
> +			  PAGE_MASK) % (64 * _BITUL(40));

You're setting wr_poking_base twice in a row? Is this an artifact from
rebase?

--
Thiago Jung Bauermann
IBM Linux Technology Center

