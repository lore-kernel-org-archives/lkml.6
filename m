Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4338C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E9C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E9C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koikeco.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeJQKuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:50:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39024 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQKuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:50:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id q5-v6so15592383qki.6;
        Tue, 16 Oct 2018 19:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m5IUGdii/M9sXi5C4halVokt26M1fUvRyuOCoFTvlbA=;
        b=JCdpO8K5IWwwJ0J+vdq84dSFhRWs5taGPHyE6PWUhRjpvJS9yrDpdRASVn1eDEctFy
         9cGt7XhTCv3fJVwMYduA+Pq1mOABMbpZc234DB2c71F6VWoAYpMYx7l1ioPAK7leh62k
         kAbtuCzCt7hBLWLHN2tBuqdrWApZUzzmJDa8VWN53kFd1j8tvYtVzipC+vk0ODKrzZpo
         jfaVyinzs8aX8cCoFrtAgmW4JITAto7GXy5gWKuqh0Z/txlrZL8o/t2dHdltyqQqwa53
         A0SO7LlxoynCzQk/0+Ib9gRzLImYfQo7K0zaNqozVbKqYUkpnTQ9nEYyrcn9ri5mvaMy
         FmpA==
X-Gm-Message-State: ABuFfoj/LynZumHRAzLy+gKPaWI/ub5o9fJcwU+cCPkZNAWNbXfgZRly
        zpdPR+5iK7UvzvIyPlaKe4A=
X-Google-Smtp-Source: ACcGV62A3O+Y35VUjYrXaPR/XkXgmSl62LSyM5GNvX24rZ3ZHGcCVt4ZMjPvl2vwTlsHPZWsUjS9IA==
X-Received: by 2002:a37:3b05:: with SMTP id i5-v6mr22077114qka.172.1539745022880;
        Tue, 16 Oct 2018 19:57:02 -0700 (PDT)
Received: from ?IPv6:2804:431:9718:6346:661:e081:23ef:66b? ([2804:431:9718:6346:661:e081:23ef:66b])
        by smtp.gmail.com with ESMTPSA id o185-v6sm9186232qke.34.2018.10.16.19.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 19:57:01 -0700 (PDT)
Subject: Re: [Lkcamp] [PATCH 2/4] Renames variable to fix shadow warning.
To:     =?UTF-8?Q?Leonardo_Br=c3=a1s?= <leobras.c@gmail.com>,
        lkcamp@lists.libreplanetbr.org
Cc:     x86@kernel.org, linux-kbuild@vger.kernel.org,
        Matthew Wilcox <willy6545@gmail.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181017000834.GA21330@WindFlash>
From:   Helen Koike <helen@koikeco.de>
Message-ID: <b17297ec-9044-d0c4-ee0e-664b53713020@koikeco.de>
Date:   Tue, 16 Oct 2018 23:56:56 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181017000834.GA21330@WindFlash>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo,

Thanks for the patch, just some small comments below.

Please, check previous log messages with git log
arch/x86/entry/vdso/vdso2c.h, you will see that most patches had the
prefix "x86/vdso:" in the commit message.

On 10/16/18 9:08 PM, Leonardo Brás wrote:
> Renames the char variable to avoid shadowing a variable previously
> declared on this function.
> 
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  arch/x86/entry/vdso/vdso2c.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
> index fa847a620f40..9466998d0f28 100644
> --- a/arch/x86/entry/vdso/vdso2c.h
> +++ b/arch/x86/entry/vdso/vdso2c.h
> @@ -93,11 +93,11 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
>  		int k;
>  		ELF(Sym) *sym = raw_addr + GET_LE(&symtab_hdr->sh_offset) +
>  			GET_LE(&symtab_hdr->sh_entsize) * i;
> -		const char *name = raw_addr + GET_LE(&strtab_hdr->sh_offset) +
> +		const char *name2 = raw_addr + GET_LE(&strtab_hdr->sh_offset) +
>  			GET_LE(&sym->st_name);

Could you please use a more meaningful name instead of name2 please? I
believe sym_name should be fine.

>  
>  		for (k = 0; k < NSYMS; k++) {
> -			if (!strcmp(name, required_syms[k].name)) {
> +			if (!strcmp(name2, required_syms[k].name)) {
>  				if (syms[k]) {
>  					fail("duplicate symbol %s\n",
>  					     required_syms[k].name);
> 

Regards
Helen
