Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757D7C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45ED1207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45ED1207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koikeco.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeJXFjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 01:39:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33505 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeJXFjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 01:39:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id y140-v6so12501462wmd.0;
        Tue, 23 Oct 2018 14:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qr1FmtSftxN0zwALW5CK++3qISzQ5YIkwO/jQxA0fvo=;
        b=mYh2MatR10CZNVsJArN5ZVxhvmT+BkEXKTrTYVbBF0EZSTWR7pn4OeudRikSCvBUk2
         9WgAQU3ghG9jymJ16o/1yQPwSvCnLrKszND6FurNmDfosBxjWPGZ+aqTYTY5Qh0neoBN
         0YUxF3seKPuC7xIs2xH3MzejrIu1tQOOaMToXjlSQLVicYPzYoPDcMkTzHv2FQz/kAz2
         NQtQJYktbnHzyd6K+AWCUnaloott1w6cMKyF89ALl8rTmwMECb4bCtfd/4POs5NrRRn+
         Gkwx/BQjrQyv6Ij31MFTgA7mBDSuFelUjwEIogbbwji52Uk5/EVfAw5u6EkTZ9JJY0OT
         E1FQ==
X-Gm-Message-State: ABuFfogleeODvaFKDM0YKXwnGdbNMNVQFmzAqZ28MFA9g5dJj3dyCmLq
        Fb5nMbPhjbXA6x0hfbybPzMI+BGrb1c=
X-Google-Smtp-Source: ACcGV62P9x+Y34dapTAZmf0BfxdV94mpt6kwgVtqYcAEuUyWaws6KBkSqKM4l2TtOYiQL0TV56AfmQ==
X-Received: by 2002:a1c:a55:: with SMTP id 82-v6mr22929957wmk.54.1540329285653;
        Tue, 23 Oct 2018 14:14:45 -0700 (PDT)
Received: from [192.168.1.178] (host-92-3-126-56.as43234.net. [92.3.126.56])
        by smtp.gmail.com with ESMTPSA id x186-v6sm2452461wmx.24.2018.10.23.14.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:14:44 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] Creates macro to avoid variable shadowing
To:     =?UTF-8?Q?Leonardo_Br=c3=a1s?= <leobras.c@gmail.com>,
        lkcamp@lists.libreplanetbr.org
Cc:     Borislav Petkov <bp@alien8.de>, David.Laight@aculab.com,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181023011042.GA6582@WindFlash>
From:   Helen Koike <helen@koikeco.de>
Message-ID: <8872be37-0ef3-7498-a846-bac3c38ee948@koikeco.de>
Date:   Tue, 23 Oct 2018 18:14:41 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181023011042.GA6582@WindFlash>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo,

Thanks for your patch.

On 10/22/18 11:10 PM, Leonardo Brás wrote:
> Creates DEF_FIELD_ADDR_VAR as a more generic version of the DEF_FIELD_ADD
> macro, allowing usage of a variable name other than the struct element name.
> Also, sets DEF_FIELD_ADDR as a specific usage of DEF_FILD_ADDR_VAR in which
> the var name is the same as the struct element name.
> 
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  scripts/mod/file2alias.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 7be43697ff84..3015c0bdecb2 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -95,12 +95,20 @@ extern struct devtable *__start___devtable[], *__stop___devtable[];
>   */
>  #define DEF_FIELD(m, devid, f) \
>  	typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
> +
> +/* Define a variable v that holds the address of field f of struct devid
> + * based at address m.  Due to the way typeof works, for a field of type
> + * T[N] the variable has type T(*)[N], _not_ T*.
> + */
> +#define DEF_FIELD_ADDR_VAR(m, devid, f, v) \
> +	typeof(((struct devid *)0)->f) *v = ((m) + OFF_##devid##_##f)

You created this macro but you don't use it below, maybe you forgot to
update the patch? Please check.

Helen

> +
>  /* Define a variable f that holds the address of field f of struct devid
>   * based at address m.  Due to the way typeof works, for a field of type
>   * T[N] the variable has type T(*)[N], _not_ T*.
>   */
>  #define DEF_FIELD_ADDR(m, devid, f) \
> -	typeof(((struct devid *)0)->f) *f = ((m) + OFF_##devid##_##f)
> +	DEF_FIELD_ADDR_VAR(m, devid, f, f)
>  
>  /* Add a table entry.  We test function type matches while we're here. */
>  #define ADD_TO_DEVTABLE(device_id, type, function) \
> @@ -641,25 +649,27 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
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
> +			while ((devs_last -= id_size) >= devs && !dup) {
>  
>  				for (j2 = 0; j2 < PNP_MAX_DEVICES; j2++) {
> -					const char *id2 = (char *)(*devs)[j2].id;
> +					const char *id2 =
> +						(char *)(*devs_last)[j2].id;
>  
>  					if (!id2[0])
>  						break;
> 
