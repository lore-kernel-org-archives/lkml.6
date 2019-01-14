Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0333CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25D520656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbDXKSrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfANKi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:38:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34534 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANKi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:38:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id u89-v6so18573707lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TXPNpJddlN+nFIx50S8bpun/lW4F/t8xPgeguT2vRQE=;
        b=bbDXKSrq5ePEv7UJtyg0+8Eh27cr4mywPGT31x5pPUFzE6P9vp6dJn5gp3YZQXtJ5x
         RZn1mqz9kroOKIRJ3ngOoJLl/FUyYHLCxwAQvH3bCfl9l7EXS+pG5UQOpziDSKrfPSm/
         3CWM+IX+f+oj46e2Ubm6KoHryVZTJ5G5gdrZERismeX+tGH6VCDj1Ie0XaI5oiTHioRN
         t5cw/CLGw7wNS7VMZzhNThK49z0OfMJheJgYgKoe77C3PPli7vF5BHP9BlRajLRZPfFg
         cU3gQg6+6RTN3lcoBXqRLlz8qoa1c3BESM6d5TuHL9ZkAUIk3dk9H03e0YjVOjGUhNDK
         E5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TXPNpJddlN+nFIx50S8bpun/lW4F/t8xPgeguT2vRQE=;
        b=ukD7Um7JOiXcQiINDsD1cM7eQGsM5fHDc7JUWdtnpZ4v4W4R/Zx8UUS373UaWxqdGj
         nRgPhErTsz1+ZVedGGq91GNIgph0EBOHeLXDj3ZDZQi3ZZiRNZ5eFsYHLCXp+6vbnyJc
         vF9qya3j+1rQRM7eARucGa7p3JtOrWjFjbxRC1DZI8saPVh0I+YXoKfsfayl93N9eLEc
         kuEzp0T6N3KK1Ap2uhj4J0nSJwYK7Q1uWMz2iLN++OErH25yma9wTqGy0CJtlochWQ3z
         eHqB3sjToGC4BCHms4BK8WqUoa0RBtvL6uRDr5/OhqSCVaOzSfGAIJ2OlBJjMj4kzFM3
         eXlA==
X-Gm-Message-State: AJcUukewKSRCXd4pInguIzvW17upj2BoEyo5CvrJODlICyB+9iCNb5ux
        oV4Tp9105BOZi1DYZfOIMGw=
X-Google-Smtp-Source: ALg8bN6XKxuBiWgGbPTPXc+blxEb/kWh+jADdwvz5aN3KIWtdjqSdXm+ULtrIXstG7V3iEAEPE7F4A==
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr15505174lji.130.1547462334856;
        Mon, 14 Jan 2019 02:38:54 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id z6sm10691lfd.50.2019.01.14.02.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 02:38:54 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH] arch/arm/xen: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>, sstabellini@kernel.org,
        linux@armlinux.org.uk
Cc:     xen-devel@lists.xenproject.org, sabyasachi.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brajeswar.linux@gmail.com
References: <20190107173719.GA30197@jordon-HP-15-Notebook-PC>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <eab5c59d-cfb4-bd2a-de07-7db827830472@gmail.com>
Date:   Mon, 14 Jan 2019 12:38:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107173719.GA30197@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 7:37 PM, Souptick Joarder wrote:
> Remove duplicate header which is included twice.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   arch/arm/xen/mm.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index cb44aa2..e1d44b9 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -7,7 +7,6 @@
>   #include <linux/of_address.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
> -#include <linux/dma-mapping.h>
>   #include <linux/vmalloc.h>
>   #include <linux/swiotlb.h>
>   

