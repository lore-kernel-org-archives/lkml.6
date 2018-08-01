Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76643C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C441120844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C441120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbeHAKOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:14:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387666AbeHAKOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:14:37 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w718T8lY087497
        for <linux-kernel@vger.kernel.org>; Wed, 1 Aug 2018 04:30:03 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kk47jty1d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 04:30:02 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <prudo@linux.ibm.com>;
        Wed, 1 Aug 2018 09:30:00 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Aug 2018 09:29:54 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w718TrrA37879938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Aug 2018 08:29:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C72552059;
        Wed,  1 Aug 2018 11:30:04 +0100 (BST)
Received: from ThinkPad (unknown [9.152.212.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5931D52050;
        Wed,  1 Aug 2018 11:30:03 +0100 (BST)
Date:   Wed, 1 Aug 2018 10:29:51 +0200
From:   Philipp Rudo <prudo@linux.ibm.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
In-Reply-To: <20180801075820.3753-4-takahiro.akashi@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
        <20180801075820.3753-4-takahiro.akashi@linaro.org>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18080108-0020-0000-0000-000002AF39E1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080108-0021-0000-0000-000020FB5F10
Message-Id: <20180801102951.527cfc57@ThinkPad>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808010092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Akashi,

I kept thinking about this patch and remembered why I didn't made the change
you are suggesting now.

The problem is when you only check for kbuf->mem you are excluding address 0,
which might be a valid address to load the kernel to. On s390 this is actually
done when the kernel is not loaded via a boot loader. For kexec_file however,
we cut off the first few kB of the image and jump directly to 'startup'. So
checking for !0 does not cause a problem here.

Anyway, the long term safer solution would be something like

#define KEXEC_BUF_MEM_UNKNOWN (-1UL)

for architectures to tell common code to search a fitting mem hole.

Back then I didn't do the change because I had the other workaround, which
didn't require a common code change. But when you are touching the code now it
is worth thinking about it.

Just wanted to let you know
Philipp


On Wed,  1 Aug 2018 16:58:07 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> Since s390 already knows where to locate buffers, calling
> arch_kexec_mem_walk() has no sense. So we can just drop it as kbuf->mem
> indicates this while all other architectures sets it to 0 initially.
> 
> This change is a preparatory work for the next patch, where all the
> variant memory walks, either on system resource or memblock, will be
> put in one common place so that it will satisfy all the architectures'
> need.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> ---
>  arch/s390/kernel/machine_kexec_file.c | 10 ----------
>  kernel/kexec_file.c                   |  4 ++++
>  2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index f413f57f8d20..32023b4f9dc0 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -134,16 +134,6 @@ int kexec_file_add_initrd(struct kimage *image, struct s390_load_data *data,
>  	return ret;
>  }
>  
> -/*
> - * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
> - * and provide kbuf->mem by hand.
> - */
> -int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> -			int (*func)(struct resource *, void *))
> -{
> -	return 1;
> -}
> -
>  int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  				     Elf_Shdr *section,
>  				     const Elf_Shdr *relsec,
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 63c7ce1c0c3e..bf39df5e5bb9 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -534,6 +534,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>  {
>  	int ret;
>  
> +	/* Arch knows where to place */
> +	if (kbuf->mem)
> +		return 0;
> +
>  	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
>  
>  	return ret == 1 ? 0 : -EADDRNOTAVAIL;

