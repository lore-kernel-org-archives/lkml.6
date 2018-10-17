Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F05C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C0C214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoE0bsaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C0C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJQNz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:55:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53249 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeJQNz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:55:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id y11-v6so682656wma.3;
        Tue, 16 Oct 2018 23:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RbTVT/zYvpQ9SEC1HNt9MSqZUZ8u14s6yZ3GVbd73yQ=;
        b=PoE0bsaU7dQtlxI+OnySxUU07CoI6VSQbXCMeeQDV0jDszJKhJPQTrFxjY1X66/QZD
         wqZa/tSlt3/Pvdm9cXSCvf+7N60BVK3uZdA6Brz0SKCLnCLTs7S/bIoLrE+B0oXNtSm5
         fte7J2dcxJo+LXYTL2ccJ7Y83+xgQi2nwkPxkoSdVN7/eTTq5ctq1YzSynBcspwdu+uD
         mmxBeZNaNRwwEW+lZKCMsTrGiExyAI0aL9hBIICSt9Xf8GX972HxAg6SNbOLxcTxEyE1
         KgwAu3/eht1zTsImXvyDGGGP6+DVKoyJE4xyNOOSNjNnI08dcc47TXlVLl3EHG+6DvfB
         u9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RbTVT/zYvpQ9SEC1HNt9MSqZUZ8u14s6yZ3GVbd73yQ=;
        b=cm7i2zDp6IL/+LetoGzG1FY8gBE3PUpSkDoFJOACQNBP7pAEly5nkfqUOU45vxAnsb
         J5dhJ7joGO8e2kw5YFCvZ5YgNnfUjixgylEJtaaa0AnA+YScFj2oPvxhaBIbpqcWB35Z
         xFi3lvokQqW9rt8xBkCcM1qH4VWOCalViK+LIm3xY8JX6yLQUvVMSLc3L0yqIeBmdUq1
         6tcXPIVwdKzHW/m6kaeaRocm8+2UeGi1FnRf4Xcy0fxEZ79SAroWBXcI17Z1Hda7l/po
         ARejfBR5GbF9L6gNqbjDUzYqPSnlZmi9Qji6MwvcaHNBgB/xnSkv21W56Z0UF9OLswvk
         hLwg==
X-Gm-Message-State: ABuFfogMUByjmFtnCICfqcoHqlxaqovaBrGcszmXFcd2oVlebL9PJYIf
        K/2dZLioqQ5hJtCs2We5TKM=
X-Google-Smtp-Source: ACcGV62HEZ5J2EKh22tB4Bx0IYTX+SeHFyr61F+utME/U8KAhRRpq/7vgctp2FTDkLVFgjsJv0m8OQ==
X-Received: by 2002:a1c:e583:: with SMTP id c125-v6mr1316513wmh.134.1539756114255;
        Tue, 16 Oct 2018 23:01:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t13-v6sm9450232wrn.22.2018.10.16.23.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 23:01:53 -0700 (PDT)
Date:   Wed, 17 Oct 2018 08:01:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
Cc:     lkcamp@lists.libreplanetbr.org,
        Matthew Wilcox <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/4] Renames variable to fix shadow warning.
Message-ID: <20181017060151.GA1105@gmail.com>
References: <20181017000834.GA21330@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181017000834.GA21330@WindFlash>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Leonardo Brás <leobras.c@gmail.com> wrote:

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
>  
>  		for (k = 0; k < NSYMS; k++) {
> -			if (!strcmp(name, required_syms[k].name)) {
> +			if (!strcmp(name2, required_syms[k].name)) {
>  				if (syms[k]) {
>  					fail("duplicate symbol %s\n",
>  					     required_syms[k].name);

NAK.

Please read and understand the code and rename both variables to 
meaningful names, not just a mindless name/name2 ...

Thanks,

	Ingo
