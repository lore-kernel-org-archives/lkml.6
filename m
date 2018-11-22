Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B6EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C08B20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeCFUbWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C08B20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394744AbeKVWHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:07:41 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:47099 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732238AbeKVWHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:07:40 -0500
Received: by mail-qk1-f178.google.com with SMTP id q1so6589230qkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 03:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6dcMw5qWvBUY0upfnsdusf61wr0B6myfBamIXVWuFI=;
        b=WeCFUbWKEb91lF57D8utDioyVgHanwM9BhLz4otL/YiuisJ5d6QfKn+Vpqy0+juHCz
         P1Rlf9N7m1YADFuOR75LFtdVv7MEatayajGWB1wGM/hqYF01dctuDYwmDBiojfw2Tn39
         X++B2oWLRfFQz1cmVu06R9eN2GY1G1W7TelJC5tOQctltXZZMUE89OQwVLl2c1sOi0k3
         24UyAr4XOS9TozCfCygziGjcHzW9TnzvE7hIDhCzN4lcGojhfP2sdZnIr8gnYPEYip91
         29/XfQa9ohVEUwTIh5gGPin7rL/g/Ll2rJLePiVVdJ6XhWLN6i1XeR2ZGpLXdLpgFmBn
         VglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6dcMw5qWvBUY0upfnsdusf61wr0B6myfBamIXVWuFI=;
        b=PZTTYlgcjsvoVAAXBsNjM+FKJCGOw+QdPZUYcFew+Sr8JrU5LoQXg+by1u/e+4MtPF
         OsRr0rwsvPi7NVJmKtsykFitn7A2GQaLeJC8d5uSpSpRxfkpq3G1jBMoD7A3FB35hqxX
         VkVkgc3zouva9HJH5jbtaIKOXug5KMRrUWnh9V/+pWEMnrFOoXOUfCvNkr3zmLUNTRWs
         0CuQstpJRW/+GXJcSHKZQJDqlFlm4ljf+TQsQDwqBt4xS6sfpeFYvLit4o/yXzoEy6pb
         ihFf1WEeYKXGXeYW0NQxNc0V5GioVXRR3aTmLfnMnDBsO9Dpw/5xcZ4fu7MF0ICL0h69
         bvjw==
X-Gm-Message-State: AA+aEWauUQVw+W2dDtRcl5vFF1kqWiV9Tw0cm0ejAtEoNnKCkdsg0Etq
        SURuOLO+QK1LIm+PIxJUams9wVlxlmSAPWEBWf0=
X-Google-Smtp-Source: AFSGD/WD4sQQgw7vNkkLQ8apttmA4kTpRdbojlWVv22WAnjqpIzmWjAms9sVZ7hw30rRq4NZwFcxW9QiHUrMXvOyzBM=
X-Received: by 2002:ae9:f50d:: with SMTP id o13mr9484648qkg.137.1542886122601;
 Thu, 22 Nov 2018 03:28:42 -0800 (PST)
MIME-Version: 1.0
References: <1de01d9e-7cf4-5803-be65-e24a6c5e30c6@elvees.com>
In-Reply-To: <1de01d9e-7cf4-5803-be65-e24a6c5e30c6@elvees.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Nov 2018 13:28:31 +0200
Message-ID: <CAHp75Vc0HC9_12GzSN7C0xxD5BYZ+Zi=63oecMotPv_OHORSXw@mail.gmail.com>
Subject: Re: using ioremap() memory in dma_map_sg()
To:     okitain@elvees.com, Sumit Semwal <sumit.semwal@linaro.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 6:31 PM Olga Kitaina <okitain@elvees.com> wrote:
>
> Hi.
> As part of our driver, we want to have some device memory to be
> available to other devices via the DMA-BUF subsystem. The device memory
> is managed by genpool, and mapped from the sram driver via ioremap_wc().
> We initially used sg_set_buf() with the virtual address returned from
> gen_pool_dma_alloc(), but it seems like the wrong thing to do, since the
> virt_addr_valid() check fails. Attempting to use vmalloc_to_page()
> results in a failure down the line, such as:
>
> Unable to handle kernel paging request at virtual address ba405000
> Backtrace:
> (dma_cache_maint_page) from (__dma_page_dev_to_cpu+0x88/0x108)
> (__dma_page_dev_to_cpu) from (arm_dma_map_page+0x5c/0x60)
> (arm_dma_unmap_page) from (arm_dma_map_sg+0x64/0x8c)
> (arm_dma_unmap_sg) from(foo_dmabuf_map+0x60/0x8c [foo])
>
> Is there an appropriate way to put an ioremapped buffer into an SG table?

Olga, I'm not sure you really want DMA-BUF subsystem for your task.
Anyway, I Cc'ed to couple of maintainers, hope they can help you.

-- 
With Best Regards,
Andy Shevchenko
