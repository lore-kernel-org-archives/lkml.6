Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D93C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578A5222B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DMBC3Yoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbfBLV7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:59:31 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40506 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBLV7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:59:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so103218pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6toEUE81rkzlisBawc99kYqY8lCwU87CEBqPAzAeows=;
        b=DMBC3YoqAOw1lzNH8Dot7WlXuXZ27GLCD8yGG9T2djYzwHJMRSq8ZhbeR930os5gee
         0CkauvCBb4gtsCfG76UWKp4qAXcc6fC40AuJEHzah0zNaD9nOpNeporKbtZhl23aWpEj
         QlwJiTiaRQ9CMa3Hw6JfiPaxe3+stbwFeTdbF+Y9AyG0SgpUM3DzQtGMsgIt1/BBzsbq
         9SRBnSY+y9qukACHzceKVv2grYYqeMykLFT0kGDtTxDe1mNcFPH0WOeXVbRsDQfb/pLn
         pSGWhdsxbP0m/t+a9gvihAPu+aQLmrtz6vHVCpE7Ecf1xFtfxakOk8besfk73RX282/m
         sRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6toEUE81rkzlisBawc99kYqY8lCwU87CEBqPAzAeows=;
        b=t51+57o6u3TSTq/siCkMbxkf4ReLIF52TaBYW1PX4Eq0WuJ0eNbfD1Wghu7upcURKH
         mCXAQgDS6i9QtpnC2VJYEAqCpx7KmUtv0akM0kiAaKjVlZsIkGUsSZ8AYRzOUzGzD+F0
         696go+njoKSovR7Rd/eNge7uCUQ+puV2Mn7/hxWW9lRkIWniFgt+cq1lbSo3iQEDJZe8
         16Ink6EcTIfKvgnQmQDz1aNAEUSzJUXKOy5Bp4bKLEMLT0cE8k7kEmZSI+KDXTfAZiEp
         cI20OMclH6cbSG9taP+NXNcNPHtC/gyp1j8Bjimdgjqic3EeLiYRfViiDkVd3196UOez
         fowA==
X-Gm-Message-State: AHQUAuY96RT5Ts37x1lbPg9gP1yGRcfbh0AZ/lptcwHwASnqpNrDwD9x
        zJiXJ6Q5Ta1IvkdsdkOxx5c54w==
X-Google-Smtp-Source: AHgI3IbK4IweKb4P4CB7mav+R8q43ycip8S1wtYfiNc9w96n/KoZMIgL/oCU97P+sf2kgldLM3iKNQ==
X-Received: by 2002:a65:628e:: with SMTP id f14mr5609328pgv.193.1550008770362;
        Tue, 12 Feb 2019 13:59:30 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id g136sm25685069pfb.154.2019.02.12.13.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:59:29 -0800 (PST)
Date:   Tue, 12 Feb 2019 13:59:29 -0800 (PST)
X-Google-Original-Date: Tue, 12 Feb 2019 13:59:27 PST (-0800)
Subject:     Re: [PATCH v2 6/6] RISC-V: Implement keepinitrd kernel parameter
In-Reply-To: <20190119132650.9978-7-anup.patel@wdc.com>
CC:     aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup.Patel@wdc.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Anup.Patel@wdc.com
Message-ID: <mhng-be5cef72-ac95-4f24-8b45-4c884085d2cb@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2019 05:28:59 PST (-0800), Anup.Patel@wdc.com wrote:
> This patch implements keepinitrd kernel parameter. By default,
> keepinitrd=1 but users can pass "keepinitrd=0" to free-up
> initrd memory at boot-time in free_initrd_mem() function.
>
> The keepinitrd kernel parameter is already implemented by
> unicore32, arm, and arm64 architectures and it is documented
> at: Documentation/admin-guide/kernel-parameters.txt

All I see is

"

        keepinitrd      [HW,ARM]

"

which is pretty lacking for documentation and should be improved...

I'm happy to take this as it stands for the next merge window, as if you hadn't 
mentioned documentation then I wouldn't have looked :)

> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/kernel/setup.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 9cd583b6d1cd..46e547dd8245 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -97,8 +97,20 @@ static void __init setup_initrd(void)
>  	initrd_end = 0;
>  }
>  
> -void free_initrd_mem(unsigned long start, unsigned long end)
> +static int keep_initrd __initdata;
> +
> +static int __init keepinitrd_setup(char *__unused)
> +{
> +	keep_initrd = 1;
> +	return 1;
> +}
> +
> +__setup("keepinitrd", keepinitrd_setup);
> +
> +void __init free_initrd_mem(unsigned long start, unsigned long end)
>  {
> +	if (!keep_initrd)
> +		memblock_free(__pa(start), end - start);
>  }
>  #endif /* CONFIG_BLK_DEV_INITRD */
>  
> -- 
> 2.17.1
