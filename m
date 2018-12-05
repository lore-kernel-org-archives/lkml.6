Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A9DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFC420851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbCeeHmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFC420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeLEHrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:47:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45290 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeLEHrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:47:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id b14so4959640wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 23:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fhy9ph+CxFVfAm3vlG1TXZt2GlYRWKsfJC58RUu3QPQ=;
        b=JbCeeHmz00vaa4JjcvYVYx48rtfjGDoUJLQXNnzYDS9lz41iNuwPsU+Am1AAMbFzXK
         +FapXgDNH9Zsjjsx3Dc992RYeZpw1LigBoeXd9bzViEtC2vCQ1qgzi/9O/kr4Y9Y2teX
         +Q+0zY++35n21iE+FgPnZhybcEJFzrEm1Z4iv3Iy/ILyW+QuE9LePv4IjVNOaoA6AICT
         +mfdFzyGz7mE8PCn1+yQVFfN2ZjlOxdZS+WYRy6tMowEeKK5lN1gCrQBSOLvCnfAIYtH
         MvNo7XsiLju9IEiMBc1x//oq1eLMDKRvWhsym5PjmDynQSmjx3JTKkWppb+kOb3Qgck9
         nivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fhy9ph+CxFVfAm3vlG1TXZt2GlYRWKsfJC58RUu3QPQ=;
        b=eeXtHAyig82T2YmFZprqR8pCXm3s9t7h4mtFkXWDWy5bAPn4Bmk/YWWRDb8pYEesZw
         XZdjb0r3lyqE1zQTrGMUs7EtYRrzR0dRKIzCb5elPD+WNrkbhc+G65I6Rec+fVBfAMbM
         SQdx/tP0XHnqlOskD6zlBb2TOl0lFJJn4DMK7TL+WZPT+S/S2RqoTNPYMMxPc20Prfx1
         jawkY9tYnae6Gw0LBnv0CFo2pFPVx5hfzyyQw9mcWZOfUM6ofnDElsA5fYnsZtK3dhBW
         DsbGBAAiD0hC/B0ldVmPMcw/9LQSW3XA6H08ygLNvdYtwwKt6nL0e3RudPrcEl/a1+NL
         kgfQ==
X-Gm-Message-State: AA+aEWZfgGpFOg9J0XJ4Rv/c521kMfTKtnnLSSzpxCGHB7JaElFrKTJP
        FUa45dBMj/RfudOkNP+O0bismqYA
X-Google-Smtp-Source: AFSGD/XPohNVpbFvGY8xQUadf/9M5aU3zExvHy9D+pq1I6GqBJ/kgtyY28drZyepTxdQpI787gNaxw==
X-Received: by 2002:adf:90e5:: with SMTP id i92mr19602722wri.210.1543996032518;
        Tue, 04 Dec 2018 23:47:12 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 14sm24980861wmv.36.2018.12.04.23.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 23:47:11 -0800 (PST)
Date:   Wed, 5 Dec 2018 08:47:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/umip: Make the UMIP activated message generic
Message-ID: <20181205074709.GA105592@gmail.com>
References: <20181204222718.9375.11043.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204222718.9375.11043.stgit@tlendack-t1.amdoffice.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Lendacky, Thomas <Thomas.Lendacky@amd.com> wrote:

> The User Mode Instruction Prevention (UMIP) feature is part of the x86_64
> instruction set architecture and not specific to Intel.  Make the message
> generic.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
> 
> This patch is against the x86/cpu branch of the tip tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
> 
>  arch/x86/kernel/cpu/common.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 2c56b80..cb28e98 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -353,7 +353,7 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
>  
>  	cr4_set_bits(X86_CR4_UMIP);
>  
> -	pr_info_once("x86/cpu: Intel User Mode Instruction Prevention (UMIP) activated\n");
> +	pr_info_once("x86/cpu: User Mode Instruction Prevention (UMIP) activated\n");

Is there any public information about which AMD CPUs are going to support 
it?

The latest AMD CPU I can test on is a Ryzen Threadripper 1950X, and that 
doesn't have UMIP.

Thanks,

	Ingo
