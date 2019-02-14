Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32FDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF872147C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lLQgQe9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503227AbfBNUtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:49:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36956 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503209AbfBNUts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:49:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so3656843pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=65fCph2wVQLYLbAYl3Kh/IhOwVLd3uOG3Na/8tJTTl0=;
        b=lLQgQe9BdP6L/KKozxCy89gHttaXJ4MA/yuhOBLCl/O1eO8ekEikoBlRb07TggKmfT
         VEnZJpuB+R0alfezZ07DaC4KjxaWVhFw87+QptUw3Qfceuu+A4AqmvxsZpbt9TUicHg0
         pIp0nAUSBY9GINxAhjuu7lkJv4M3cJfYaDkCYM+E7KxXxeADn7bOhq3P6BdJtOi9Set7
         geGOodJQ42skGi7BhAPn2OSrGFUbhESwVHmVG7K3mUc/QqnryZ1A1g4gvHOsa+GHi8Wr
         7v0wAKu9AsvGvisJ9miN0oRC+7goN7MaAvA0WXXEqzHznU5rKaZN10qjHoUKTWZ9V4Qs
         vxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=65fCph2wVQLYLbAYl3Kh/IhOwVLd3uOG3Na/8tJTTl0=;
        b=uZFZAx3S5TCe0YzDkL1rnyDT3XFcP9e8HgwqjB0LSq/Ir6qxLj4B1PNEkb4F+L8Six
         CPbMM4cngB3zRefHr8uxAkErQLmhpu2eUl17nR0xmsssn9QW9ZK8JRlZrq5VOotv/Ogp
         bakhk5rQcOnv3j3nKBi7RcxlHCjloGrYlcXaVbh1DevnHAJcyR42ub6dyoCLQsEJzwTo
         0SNLKbZV/Pt7HjuVEtyVsTLhHq6UX4g898peP+GiET4nsAnqR6GUOvzYJnHmCYGpUVaE
         1yzK62IBB01i8nTE41FDrtNJImkqjqnzPQmH0cGWui+IVVyAgbFpXK1FZgqONBbIMx7n
         j1Bw==
X-Gm-Message-State: AHQUAubxg++QzR06hS1HN3plRwDZoz6WzDrupGZFw7V0lZixCmox0PKQ
        dNDf35+iI5bbKRx2A8Ta6AT7gQ==
X-Google-Smtp-Source: AHgI3IbLxG6jNbV4WqQPwhjvqV2Ffx3+iOXl0AxSnfqcM2rbVcz5nyD0wlnlMZsqhHytPuQm2K5IYw==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr1788701pgr.333.1550177387393;
        Thu, 14 Feb 2019 12:49:47 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l12sm3035910pgk.40.2019.02.14.12.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 12:49:45 -0800 (PST)
Date:   Thu, 14 Feb 2019 12:49:45 -0800 (PST)
X-Google-Original-Date: Thu, 14 Feb 2019 12:47:37 PST (-0800)
Subject:     Re: [PATCH 4/4] riscv: switch over to generic free_initmem()
In-Reply-To: <1550159977-8949-5-git-send-email-rppt@linux.ibm.com>
CC:     akpm@linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        rkuo@codeaurora.org, linux-arch@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        rppt@linux.ibm.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     rppt@linux.ibm.com
Message-ID: <mhng-e6dedfc5-937e-42e5-90d6-4ce400cbc6fb@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 07:59:37 PST (-0800), rppt@linux.ibm.com wrote:
> The riscv version of free_initmem() differs from the generic one only in
> that it sets the freed memory to zero.
>
> Make ricsv use the generic version and poison the freed memory.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/riscv/mm/init.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 658ebf6..2af0010 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -60,11 +60,6 @@ void __init mem_init(void)
>  	mem_init_print_info(NULL);
>  }
>
> -void free_initmem(void)
> -{
> -	free_initmem_default(0);
> -}
> -
>  #ifdef CONFIG_BLK_DEV_INITRD
>  void free_initrd_mem(unsigned long start, unsigned long end)
>  {

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I'm going to assume this goes in with the rest of the patch set, thanks!
