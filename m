Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DD3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CDC21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfAXFm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 00:42:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbfAXFm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 00:42:57 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 970ABBD16C759AD83E4E;
        Thu, 24 Jan 2019 13:42:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Thu, 24 Jan 2019
 13:42:52 +0800
Subject: Re: linux-next: build warning after merge of the gpio-brgl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <20190124151837.1ca96816@canb.auug.org.au>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <df1743f8-71c8-3b18-1e8a-94198d99477d@huawei.com>
Date:   Thu, 24 Jan 2019 13:42:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190124151837.1ca96816@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/24 12:18, Stephen Rothwell wrote:
> Hi Bartosz,
> 
> After merging the gpio-brgl tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> drivers/gpio/gpio-davinci.c: In function 'davinci_gpio_get_irq_chip':
> drivers/gpio/gpio-davinci.c:472:9: warning: function returns address of local variable [-Wreturn-local-addr]
>   return &gpio_unbanked.chip;
>          ^~~~~~~~~~~~~~~~~~~
> drivers/gpio/gpio-davinci.c: In function 'keystone_gpio_get_irq_chip':
> drivers/gpio/gpio-davinci.c:480:9: warning: function returns address of local variable [-Wreturn-local-addr]
>   return &gpio_unbanked;
>          ^~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   ee5e87158e63 ("gpio: davinci: drop pointless static qualifier")

I'm very sorry for this.

I misread the code, Pls revert this.

> 

