Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeC0NnH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:43:07 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41711 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeC0NnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:43:06 -0400
X-Google-Smtp-Source: AG47ELtTTlzbQ816XwI6wjy436zJP1c9Vgg83AN/Uoe/6AtSoV5U3HeErMEc5+IsvuuxV8PUSwDgU+njBuMMh0aX+Ek=
MIME-Version: 1.0
In-Reply-To: <1521934848-5674-1-git-send-email-albeu@free.fr>
References: <1521934848-5674-1-git-send-email-albeu@free.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:43:00 +0200
Message-ID: <CACRpkdaqeOccK_a0foGRwLbi_ATaRrD7eA=wGcV3QUZarRfGCw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: ath79: Fix potential NULL dereference in ath79_gpio_probe()
To: Alban Bedel <albeu@free.fr>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 12:40 AM, Alban Bedel <albeu@free.fr> wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> platform_get_resource() may return NULL, add proper
> check to avoid potential NULL dereferencing.
>
> This is detected by Coccinelle semantic patch.
>
> @@
> expression pdev, res, n, t, e, e1, e2;
> @@
>
> res = platform_get_resource(pdev, t, n);
> + if (!res)
> +   return -EINVAL;
> ... when != res == NULL
> e = devm_ioremap(e1, res->start, e2);
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> [albeu@free.fr: Fixed patch to apply on current tree]
> Signed-off-by: Alban Bedel <albeu@free.fr>

Patch applied.

Yours,
Linus Walleij
