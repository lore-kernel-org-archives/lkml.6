Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3344C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558EF20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg01JNpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558EF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933009AbeFRMvH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:51:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56304 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeFRMvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:51:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so13867141wmh.5;
        Mon, 18 Jun 2018 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OvnXDQz6NLFbtjE5xObj1a5F4PPvvp9ksZ1rhWG3CTM=;
        b=Sg01JNpIo9n7oUt1VW7T/JcKcbPFfEHoHGs4KDH2mee5RYZJ1Fo4FpW1cDLzoWQs+8
         gfGtO/d6nCZcV8fhdPEakcuFgRQC6GBlQ5qyM08U5oTb8gcv9Rh7Wglu1MBk6m3myXhu
         q2WWfJHDfejn4Jv+rCa6x/0xvmPQGDdkFYxD8aAwz50qxKPCemHE0sLz7pYz85pMSXsV
         Nqv/qaASDoN3jd8iOLzQuig9S1D4oKO0mcxCwpkAUGcoByUF5NLtO773LwXSezFkNvQn
         U0WbURwGhmhz84KIyy9yd1IId1rvRGWdMvoPwSotvQ7gmkXdEbfwI4qmJwqWMCQHsD1S
         7Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OvnXDQz6NLFbtjE5xObj1a5F4PPvvp9ksZ1rhWG3CTM=;
        b=mJSaCiDbLi9iCEbOQphFUgC/zSPilR/Sej/Io2NS5THx7PtPli6gPdvJvCABZAb9Rj
         +hMj0P+nigEMRVyZXDk+M92CM8RDt0M4lhafVAId35v+ZwDMmYAXzXgMORpSjiQecZP+
         BkIDDrFXSnJEIjdHonP1uHtYz57/g3TzKMGO1i/EdcKu6qKJK0hnhrrVGftK79kTIIqp
         mr3Wa4cFS8FSRZ3bFtWz+5cIXxqj/wonR+mLODXBVXEEmSt8I+m3QNec/ThBKnE+VcPA
         +DTB65CgWd2+u0TbqtHdd0mtDzv9nNKI6ZvfoOdaHgd5Hd8nMCGvGzBPU2KkIL4u5pLg
         Q+TA==
X-Gm-Message-State: APt69E0D1k7ndW2sBApdt+FJj1g5B7sgjB84Yx0mfoAZwuBlnkJ8jiV9
        /yr4ibyblvgla7RQQxxy3TSrI7aKSCA=
X-Google-Smtp-Source: ADUXVKLcqhGIfcGUSvia0p7Fl0DHt43WOTQGVX7GtqUNfbNwp45SVO4gqvn3TRA2h88StiI3m9gpig==
X-Received: by 2002:a1c:9015:: with SMTP id s21-v6mr8581063wmd.20.1529326263301;
        Mon, 18 Jun 2018 05:51:03 -0700 (PDT)
Received: from [10.9.10.21] (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id k36-v6sm29769189wrc.20.2018.06.18.05.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 05:51:02 -0700 (PDT)
Subject: Re: [PATCH 3/6] arcnet: com20020: Add com20020 io mapped version
To:     David Miller <davem@davemloft.net>
Cc:     kbuild-all@01.org, tobin@apporbit.com,
        Andrea Greco <a.greco@4sigma.it>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20180611142635.20712-1-andrea.greco.gapmilano@gmail.com>
 <201806120034.bUpoIKOC%fengguang.wu@intel.com>
From:   Andrea Greco <andrea.greco.gapmilano@gmail.com>
Message-ID: <7223d43a-ef82-2364-9bf7-dde50ce4a7f3@gmail.com>
Date:   Mon, 18 Jun 2018 14:51:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <201806120034.bUpoIKOC%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 06:35 PM, kbuild test robot wrote:
>     drivers/net/arcnet/com20020-io.c:34:17: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>       return ioread8((void *__iomem) addr + offset);
>                      ^
>     drivers/net/arcnet/com20020-io.c: In function 'io_arc_outb':
>     drivers/net/arcnet/com20020-io.c:39:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>       iowrite8(value, (void *__iomem)addr + offset);
>                       ^
>     drivers/net/arcnet/com20020-io.c: In function 'io_arc_insb':
>     drivers/net/arcnet/com20020-io.c:44:14: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>       ioread8_rep((void *__iomem) (addr + offset), buffer, count);
>                   ^
>     drivers/net/arcnet/com20020-io.c: In function 'io_arc_outsb':
>     drivers/net/arcnet/com20020-io.c:49:15: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>       iowrite8_rep((void *__iomem) (addr + offset), buffer, count);
>                    ^
>     drivers/net/arcnet/com20020-io.c: In function 'com20020_probe':
>     drivers/net/arcnet/com20020-io.c:219:11: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>       ioaddr = (int)devm_ioremap(&pdev->dev, iores->start,
>                ^
>     drivers/net/arcnet/com20020-io.c:288:27: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>       devm_iounmap(&pdev->dev, (void __iomem *)ioaddr);
>                                ^

Is there some clean way for fix this.
Some architetture int size is 32 bit and ptr is 64, this rise warning, 
of spark64 compiler.
Change ioaddr type means introduce a lots of casting in all other driver.

Which is the best way for proceed ?

Andrea


