Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-104669-1525854761-2-4594199171295757312
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525854761; b=KIv5lUyx7MOe9oD7w3KdpdfijCU0XpcqRYKAQzh+CVPIaB8gGI
    ZTaQ9AKKgvkw9rVULlvKjC1TPFwth0kFF4jNLbeWNWabl9Obwx1Of6LF99IDo+mI
    vv3M7hsvphIKNfbxXkTy4UMQ1JgPx23MksU41ZRUdqSUsychQAqrBFAgvxAy5jGs
    CsWGV5cQN/gMNgO0sh/1AJ4zNz6t1r+nT9PoVrVy86it007cghVqBTLK0xf3mHGC
    L0PsNghZg79MHGkx5uAYnkGtLA3I8T4FjjnMb5mM1C3KEgnCwArIT1hLY6P5aIjc
    TB/NmABV+rQsF+Bd3sDAfr/7Pq0HyTjeLGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:references
    :mime-version:in-reply-to:message-id:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525854761;
    bh=eRhzm4XowvcC4MteFxo28l8ydYCXRvDMSVfgA0Rrhfs=; b=XJ/7AjIHGwWb
    LstS4/xJhWfu+1aSwFGw3wBqfqbIuhvwe0khEmEdg1kBeWHw2R92HRE4elQtocSE
    ShlkeIEgEcVQzMaDZAp8LTOUXWzZLw3s/QJ4QWRSAVj1mTz6aGxaM0R3GwnVW+56
    CnZrHirAJrex9lrHkrl8DP7CINAIDpOhne71UvdkLtJZdMHjHNE0xX24WQrMl3h6
    q1juIZGMOiGut8b7AReeZ9mHKlFMLuLHJj+LVvg19RZqNyizD826HCXKa8v3nrbM
    H55uynva4AGSzwcy+XW7v6c352iR9RKUdE2IuOfgQm90uGh0fO5RUq/ZtiKFdHO+
    xsTo4/CgkA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=de.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=de.ibm.com header.result=pass header_org.domain=ibm.com
    header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=de.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=de.ibm.com header.result=pass header_org.domain=ibm.com
      header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCxEXd/gHyZuyQFhvdPeFqV5UTP8Wbsj28mS/md2HgvHvAVK764eJXbmCUfa6SRhxjk1EMkOxjahk5i2eGFnGmFPu0UkpQX8CZNysm0N7jbU1VJADcT8
    du8Qmcwe+yW8P0AkphSqXG2WWICG/+POQ8AHhZWZOT73nn7nbkLU93cpJSzBw5NpwEZwkKjjXL0WGNVhpxW5zc3bisKR7S4OIBx3OWWa6ddC9UIagjLjeV1X
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=c-n4J4-pAAAA:8 a=a65YPoLxY-Xioese7NAA:9 a=CjuIK1q_8ugA:10
    a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933749AbeEIIcf (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 04:32:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934059AbeEIIcc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2018 04:32:32 -0400
Date: Wed, 9 May 2018 10:32:22 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: remove no-op macro VMLINUX_SYMBOL()
References: <1525852299-29134-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
In-Reply-To: <1525852299-29134-1-git-send-email-yamada.masahiro@socionext.com>
X-TM-AS-GCONF: 00
x-cbid: 18050908-0008-0000-0000-000004F4B066
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050908-0009-0000-0000-00001E88F6C1
Message-Id: <20180509083222.GC3698@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090084
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 04:51:39PM +0900, Masahiro Yamada wrote:
> VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
> is defined.  It has ever been selected only by BLACKFIN and METAG.
> VMLINUX_SYMBOL() is unneeded for s390-specific code.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/kernel/vmlinux.lds.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index 08d12cf..f0414f5 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -82,10 +82,10 @@ SECTIONS
>  
>  	. = ALIGN(PAGE_SIZE);
>  	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
> -		VMLINUX_SYMBOL(_sinittext) = . ;
> +		_sinittext = .;
>  		INIT_TEXT
>  		. = ALIGN(PAGE_SIZE);
> -		VMLINUX_SYMBOL(_einittext) = . ;
> +		_einittext = .;

Applied, thanks.
