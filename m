Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7540C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872762075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872762075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koikeco.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeJXGBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:01:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52861 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeJXGBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:01:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so3274521wmw.2;
        Tue, 23 Oct 2018 14:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6kiimSHEOpzRp7ehclRKTX3KqYQiZViHrxBew/pat9w=;
        b=OZHLQchWXmzdfxc1cP9TddIYJ3Bm5M+pCmJmnqwmtW5a+Gxg0+XJUjk9d5YOVybpz3
         kuehIu/GBKMcn2wGXnszyK/rgQOzfS1pri2GiRA7hDck3Equ4Zhs9IRP3GNH87cnTCGv
         eyxLNySvXcNZzQUkh/jGQ46A414OKeG+/sdaXMw6AMXap1KIpnADcNoyKD07FOTpXhEC
         h3pA/iebWrVD355dUR1bvoSzG8q1y13TuG7zJXtujosrpDHD7e3EBOhLKdDtawdF9CfS
         m20mXVHbpk+YJ32IUBNQoPTlQDx9r0xnG1KpuHAgxPakL4aSIzrInQZkEk190ub4d5/m
         dYoQ==
X-Gm-Message-State: AGRZ1gL4dTm1FZZ7/rRnPocTFgPfuvVTiyrtvXJoDG8h2OvLk71IzTjM
        p0pEW2ce37f6pj/NAyla+kZe38QM5fU=
X-Google-Smtp-Source: AJdET5fpQP19q7AOUFxen2SFAP5FwTC1vADsnDvKhtezu2e16y7/8Ej4K3WzL9WxuFrnn/b6l4ezrg==
X-Received: by 2002:a1c:9d90:: with SMTP id g138-v6mr1463006wme.41.1540330553160;
        Tue, 23 Oct 2018 14:35:53 -0700 (PDT)
Received: from [192.168.1.178] (host-92-3-126-56.as43234.net. [92.3.126.56])
        by smtp.gmail.com with ESMTPSA id o17-v6sm3135032wro.2.2018.10.23.14.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:35:52 -0700 (PDT)
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
Message-ID: <fe54aafc-1dbc-d4a1-96b5-37455595956e@koikeco.de>
Date:   Tue, 23 Oct 2018 18:35:49 -0300
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

Instead of doing all these changes, you could just modify here with
		DEF_FIELD_ADDR_VAR(symval + i*id_size, pnp_card_device_id, devs,
devs_aux);

Like this you are not changing the logic in this file, you are just
renaming the variable which is more then enough to solve the -Wshadow
warning.
I don't it is worthy changing the logic.

Regards,
Helen.

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
