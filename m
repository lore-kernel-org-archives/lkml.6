Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A6DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27FA2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQtc2wGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27FA2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeJZFxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:53:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38889 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeJZFxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:53:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id b14-v6so2871544wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O0xLKvkS57ApuPCnSmwFrvRxS/Ryg/owy5LT6XV2XGI=;
        b=OQtc2wGdKX8SsLO6ukEofwSC1cL0Uosy0zWRRpCNTWM+p5h3XGF1qss5juG4FmLoCR
         clejaqyRnsV3kN6951WwA+eHvFAlaki9IAGndDf7jJxugcL85mjO8D+8xuW3Y5Sf92Ed
         X6Ugb4LLMLP/uG2mD0Cnvlh8EcANOmeVxp4LW1znyaPMn8QWX7iJCtTqJw5OUJApq1g7
         u77wNllnuoxp/sk6j6p6yAZG8evgXaXpNLBiQvk9DK5A5TgWmZ5HlQ4MM2S3T8n8ywlJ
         8/cav3b8klh9x0xcMuioFA/slKzclggfiygCeekbBBT14KfAeCG56kVe67pbFLRcZa7B
         U7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O0xLKvkS57ApuPCnSmwFrvRxS/Ryg/owy5LT6XV2XGI=;
        b=JGh1JBkK73NFjaTZqrPwQCfp5AMZzmt/DdlxT+DKTw9187wiIaVV73nxMexxsBZ0n9
         GGLoklwGM7bwYXI0yWjNfvRC/1H6Esjjw5taKjVU9j+Fy3C3eFS8FPJ4wEh3ENt9rd1D
         i8pozAHDcqt+4aHLLOMmsntTVtEA/ZE8uoKfQVUt4fcc5hMjQakwRn8g0jhygAMa8ncZ
         ZCwRzjaUycnICmAl06vNqZUCq437SRYbt/MWHtin3AANPw1S0FjWizbJwrnkhZS85EDj
         hpQb9B2M8sozwaDibgOq8PSDEpU6MVl6QMtsJ4rrCyVhka84L+oXrbwik1qWIocNdqvq
         ic4Q==
X-Gm-Message-State: AGRZ1gLLDMPEyZl5P3L3xw5bNwKPj2Tq/fxrZXkedBh6NkarzvOnias1
        FrfkRWbTJRSRNg6xKV1DauI=
X-Google-Smtp-Source: AJdET5fNn/G96jZQn7OC3ooGg4AePeojBYVT9w19Z06wLg7pHfRA1h504AiU2OKL9on297bV/xJ8ig==
X-Received: by 2002:a1c:f312:: with SMTP id q18-v6mr3271983wmq.14.1540502368455;
        Thu, 25 Oct 2018 14:19:28 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 4-v6sm1424254wmt.16.2018.10.25.14.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 14:19:27 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:19:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boaz Harrosh <ooo@electrozaur.com>
Subject: Re: [PATCH] fs/exofs: Remove ignored __weak attribute
Message-ID: <20181025211925.GA24709@flashbox>
References: <20180930205126.25840-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930205126.25840-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 01:51:26PM -0700, Nathan Chancellor wrote:
> Clang warns that the __weak attribute is going to be ignored on
> g_attr_inode_data because it's not in the correct location (needs to be
> after the type).
> 
> In file included from fs/exofs/dir.c:35:
> In file included from fs/exofs/exofs.h:41:
> fs/exofs/common.h:186:21: warning: 'weak' attribute only applies to
> variables, functions, and classes [-Wignored-attributes]
> static const struct __weak osd_attr g_attr_inode_data = ATTR_DEF(
>                     ^
> 
> Turns out that GCC ignores the attribute too albeit silently because
> moving the attribute after either osd_attr or g_attr_inode_data like
> all other uses of __weak on variables in the kernel causes a build
> error on both GCC and Clang because static variables cannot be weak
> since weak definitions rely on not having internal linkage:
> 
> In file included from fs/exofs/namei.c:34:
> In file included from fs/exofs/exofs.h:41:
> fs/exofs/common.h:186:30: error: weak declaration cannot have internal
> linkage
> static const struct osd_attr __weak g_attr_inode_data = ATTR_DEF(
>                              ^
> 
> Just remove the attribute because it hasn't been correct since the
> initial addition of this file in commit b14f8ab28449 ("exofs: Kbuild,
> Headers and osd utils").
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  fs/exofs/common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exofs/common.h b/fs/exofs/common.h
> index 7d88ef566213..45da96a1528d 100644
> --- a/fs/exofs/common.h
> +++ b/fs/exofs/common.h
> @@ -183,7 +183,7 @@ struct exofs_fcb {
>  #define EXOFS_INO_ATTR_SIZE	sizeof(struct exofs_fcb)
>  
>  /* This is the Attribute the fcb is stored in */
> -static const struct __weak osd_attr g_attr_inode_data = ATTR_DEF(
> +static const struct osd_attr g_attr_inode_data = ATTR_DEF(
>  	EXOFS_APAGE_FS_DATA,
>  	EXOFS_ATTR_INODE_DATA,
>  	EXOFS_INO_ATTR_SIZE);
> -- 
> 2.19.0
> 

Hi Andrew,

Can you take this with Boaz's ack?

Thanks,
Nathan
