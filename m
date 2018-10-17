Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65E9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CAC214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CAC214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koikeco.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeJQMMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:12:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34317 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbeJQMM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:12:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id o17-v6so28579237qtr.1;
        Tue, 16 Oct 2018 21:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DMprZeq/UiWnZrSRCaJlHaZ9WK3zUfxHnQ6rc1FtAbw=;
        b=jhLpXygg7QH/hwq5lPVigWbHF503TYtKNPg0WA3SQhKSAELRV+Dnh//Del0Ye5FPBX
         nYfVpsx/2LTatZwjMuDBlK9NfAFYXM/ZhoA5FulS9+BwxUo5AfTKfZBr5iaVmDohCAhZ
         XIp/VRhO7P+Vg9P9d/gfGz2+XNeayqr+z/Np70WlaEGsNY5V7cxwJZjKGtkdfpVZkRqP
         zHtONFkgs8Pm5zbXpZyYTxpuli/z71hjacj6uRbjB+Z/FuNytykj05ownra8BcKeeNuj
         xiKuMB70IrNGewN3dzDLHO5kaTP98FnHtFnmQ2Ni1quNEHq3V0K6ySWCg5XnNh+BwMui
         2guQ==
X-Gm-Message-State: ABuFfohJUc/Dx1PmR/XBt2a7uIFc6SrAqAJK2OaSSx3jdzqkuNk+wJZw
        hkC1DHwgfqaU8xJJiVgcAzo=
X-Google-Smtp-Source: ACcGV63YS1GtP04bP5wnwtlHcMQcityiIQhphKBSkhPEBwKojpFUWWMRdWWFs5SFYzfQwZ/UNy153w==
X-Received: by 2002:a0c:e3cf:: with SMTP id e15mr13163289qvl.51.1539749926335;
        Tue, 16 Oct 2018 21:18:46 -0700 (PDT)
Received: from ?IPv6:2804:431:9718:6346:661:e081:23ef:66b? ([2804:431:9718:6346:661:e081:23ef:66b])
        by smtp.gmail.com with ESMTPSA id p64-v6sm9084183qkc.96.2018.10.16.21.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 21:18:45 -0700 (PDT)
Subject: Re: [Lkcamp] [PATCH 4/4] Changes macro usage to avoid shadowing a
 variable.
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
References: <20181017000943.GA21382@WindFlash>
From:   Helen Koike <helen@koikeco.de>
Message-ID: <1f8c4570-4e56-1e96-711d-78f119f8d261@koikeco.de>
Date:   Wed, 17 Oct 2018 01:18:40 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181017000943.GA21382@WindFlash>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo,

Thanks for the patch, just some small comments below.

On 10/16/18 9:09 PM, Leonardo Brás wrote:
> Changes the usage of DEF_FIELD_ADDR in this function to create a
> reference and operate over it using an aux variable.
> It also changes the loop logic used to find duplicates, to avoid
> creating another variable.
> 
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  scripts/mod/file2alias.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 7be43697ff84..9ea1db2aefdb 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -641,25 +641,27 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
>  	unsigned int i;
>  
>  	device_id_check(mod->name, "pnp", size, id_size, symval);
> +	DEF_FIELD_ADDR(symval, pnp_card_device_id, devs);
> +	typeof(devs) devs_last;
>  
>  	for (i = 0; i < count; i++) {
>  		unsigned int j;
> -		DEF_FIELD_ADDR(symval + i*id_size, pnp_card_device_id, devs);
> +		devs_last = devs + i * id_size;
>  
>  		for (j = 0; j < PNP_MAX_DEVICES; j++) {
> -			const char *id = (char *)(*devs)[j].id;
> -			int i2, j2;
> +			const char *id = (char *)(*devs_last)[j].id;
> +			int j2;
>  			int dup = 0;
>  
>  			if (!id[0])
>  				break;
>  
>  			/* find duplicate, already added value */
> -			for (i2 = 0; i2 < i && !dup; i2++) {
> -				DEF_FIELD_ADDR(symval + i2*id_size, pnp_card_device_id, devs);
> +			while ((devs_last -= id_size) >= devs) {

You forgot to consider the dup variable.

Also you inverted the order of this loop, I am not sure this is
important (I just took a quick look) but you need to be careful.

This is also hard to read, I would define another variant macro where
you can set any name of the variable, e.g.

#define DEF_FIELD_ADDR_VAR(m, devid, f, var) \
	typeof(((struct devid *)0)->f) *var = ((m) + OFF_##devid##_##f)

In this way you don't need to change the logic, just the name of the
variable.

>  
>  				for (j2 = 0; j2 < PNP_MAX_DEVICES; j2++) {
> -					const char *id2 = (char *)(*devs)[j2].id;
> +					const char *id2 =
> +						(char *)(*devs_last)[j2].id;
>  
>  					if (!id2[0])
>  						break;
> 

Regards,
Helen
