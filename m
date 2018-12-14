Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF59AC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8478620879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544762595;
	bh=0PodPA7J2fdcawuaOBgMyvAecMGGOoRfwK8VnZAZW8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hLLIzZMReARIdwz+d1nMbqCqEtXuo+INzxGRMS7DdiBoK8ZyimiqXND7B6SQYla8/
	 rib53NdPOObDt+veo9nu+74VgfaCP/0UQKvrEXb232kMqh8HKPC3YUAAFpulz7HMdM
	 3KPwj2a1LjVB+Od9dW6Dz6m87FS0JLbsH1a2TopI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8478620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeLNEnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbeLNEnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 23:43:14 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6C0E2086D;
        Fri, 14 Dec 2018 04:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544762593;
        bh=0PodPA7J2fdcawuaOBgMyvAecMGGOoRfwK8VnZAZW8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYdhiPwfHKZxGQV94JK29P1To0MsxDpT+BipZafX9uSA+FpXvdiQ8m0Kxi+9LtuLz
         3wTdm8dc+Mxp8atPvS6sXoJN3vkk+nYlHpnuu8hffEPjWJQjU8yucAAxjYE/yzV1x9
         nUsjHoAShBr2ZPWcGQYGU6Szd/73ez5TDz5FNRoI=
Date:   Fri, 14 Dec 2018 12:43:08 +0800
From:   Guo Ren <guoren@kernel.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/27] elf-em.h: add EM_CSKY
Message-ID: <20181214044308.GA15793@guoren-Inspiron-7460>
References: <20181213171833.GA5240@altlinux.org>
 <20181213172200.GG6024@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213172200.GG6024@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, Dec 13, 2018 at 08:22:00PM +0300, Dmitry V. Levin wrote:
> The uapi/linux/audit.h header is going to use EM_CSKY in order
> to define AUDIT_ARCH_CSKY which is needed to implement
> syscall_get_arch() which in turn is required to extend
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
> 
> The value for EM_CSKY has been taken from arch/csky/include/asm/elf.h
> and confirmed by binutils:include/elf/common.h
> 
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
> 
> Notes:
>     v6: unchanged
> 
>  include/uapi/linux/elf-em.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
> index 42b7546352a6..ee0b26ab92b0 100644
> --- a/include/uapi/linux/elf-em.h
> +++ b/include/uapi/linux/elf-em.h
> @@ -45,6 +45,7 @@
>  #define EM_ARCV2	195	/* ARCv2 Cores */
>  #define EM_RISCV	243	/* RISC-V */
>  #define EM_BPF		247	/* Linux BPF - in-kernel virtual machine */
> +#define EM_CSKY		252	/* C-SKY processor family */
>  #define EM_FRV		0x5441	/* Fujitsu FR-V */
>  
>  /*
> -- 
> ldv
