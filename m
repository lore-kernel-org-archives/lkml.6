Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F1EC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB76D251B2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bivyOW2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB76D251B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936518AbeF2VrT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:47:19 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33447 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936356AbeF2VrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:47:16 -0400
Received: by mail-ua0-f194.google.com with SMTP id g18-v6so3950517uak.0;
        Fri, 29 Jun 2018 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2wCN6iFo8daxboSfoUXFrDoBEP98qg5W7ZRxp2rl81Q=;
        b=bivyOW2BNbsHFo3Kc9noKXV1FhQMj+50Bs2pVAiCrzDPXxf43JLShJagnWkZxjxWSB
         CO3jxLszTstZaKDOkbeAhyI1Fm//cF3dFov92yc2rDqCu3UTPLqUVzhyZWpL3Rt+md2E
         Rq/p8kqzkhsTSnRHfCXfZzkdeA/eA7qWM6DrXjX1yY+tyuJqBr2M9YU72vsvzsDITn5N
         QEWQ7QI2TT9GqMzqLfJ1aF0V9Xi6B+5uwG9nAU5+tg2e86uPK2mcFX9cRcarfFOq8iCL
         vMOqIcZq2iFknSodNV9DDBgZuryCIluwmAoO7PZ0X9Gi1Ov+zXuSK3/HofhQPDU/tUlS
         jKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2wCN6iFo8daxboSfoUXFrDoBEP98qg5W7ZRxp2rl81Q=;
        b=nO06qg3P67GXw7takLQ4qzxUP3A2xwRWXJGluDxmksSJrFWnMbYU0v7ge1ZTZFCkLd
         MX4v3E1+Wt0iqj6RdSnHYGdb2BOXU+5bQzib80hglKaCk3O64N+0w5SsE0BmKaOzZpV5
         8jP7JE0fQTrutbzO0HpVGvClD+4HPAvm82PIy+fd/4ZuTlEzqlYjm2vtaBdU95BWNofj
         6hgRFDnY/aUmuc2VfptVl5tcnnvKUPt2m0Xeap10RPHMf7nGvcK+zb6IMAx03XqVyR+Y
         ZajCP0zjStMpbsFvrE9CuiSGdh+DoXp8uh1/MrO0VTrwRo+P4U5lilg3dGG0QiHpEpl6
         Jfdg==
X-Gm-Message-State: APt69E0+gWlEv0rHqgZ1yv52wC0ozbQhS2Tw9M3hHp3v28c4vMSKvtZ/
        bvLy3nIPMo3PY4Sc8X2uO49m71G+xyYh9RE4ghc=
X-Google-Smtp-Source: AAOMgpev5ZbjpzMJu6jI7psUwNlfmlE/vaHk36nwxCmN71E3p7yAAtB2giABcG5D1hEKuk+Q1R/hbW81VNP7lcGakbM=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr10494067uae.12.1530308836023;
 Fri, 29 Jun 2018 14:47:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 14:47:15
 -0700 (PDT)
In-Reply-To: <20180629025135.12236-1-yuehaibing@huawei.com>
References: <20180629025135.12236-1-yuehaibing@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Jun 2018 00:47:15 +0300
Message-ID: <CAHp75Vet-vTz_Ld=Lturmm8NSpK1etvoj-7Wzn4-h=bM2FQgZg@mail.gmail.com>
Subject: Re: [PATCH] atmel: using strlcpy() to avoid possible buffer overflows
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     simon@thekelleys.org.uk, Kalle Valo <kvalo@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 5:51 AM, YueHaibing <yuehaibing@huawei.com> wrote:
> 'firmware' is a module param which may been longer than firmware_id,
> so using strlcpy() to guard against overflows

strncat() is against overflow, this does a bit more.

>         priv->firmware_id[0] = '\0';
...
>         if (firmware) /* module parameter */
> -               strcpy(priv->firmware_id, firmware);
> +               strlcpy(priv->firmware_id, firmware, sizeof(priv->firmware_id));

In either case the above '\0' is not needed.
But it looks like the intention was to use strncat() / strlcat().

-- 
With Best Regards,
Andy Shevchenko
