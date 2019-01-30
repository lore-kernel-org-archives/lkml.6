Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103C1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61D820989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzhs9qXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbfA3JbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:31:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43832 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfA3JbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:31:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so16835035lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5olWaqjb7x80gD4BNcQwMsktXckzDlly11atHEqv1Jk=;
        b=bzhs9qXfjjXjLbxKwmn8if/G9l+scj73HmsErDyC+qIZcRlh2jmewpzo777mbUsmnS
         hb/L/MSyTGN1yft22M8W/BS9qpB2cAV5KAG9SmViCjpN8RBJVL/q+YO+3Zb9iHpENYB6
         Va2B8QW/T2LiBx7X1gmDCamqb2AgnqHmSvZNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5olWaqjb7x80gD4BNcQwMsktXckzDlly11atHEqv1Jk=;
        b=p2Lj5tMGcj2hpHV2RzpN65b7ZrVKM3YkHBmUCrBQV8rI6cTDVHp30pfJ5fGRYftdkC
         Afcif7w0X1iGnQc/xuuiQ7csfNZ7vBu9Fmd5ky3Ps8zo4D8nX2s8H3eXKXlO03TlHepk
         jDhBRQICqLSzVM9M8uxU9crStRzMrlfYoNGFcvH/WRGVFp2nRuPNRX/T2t5jujD76yDQ
         OnHaE4ZrbiJULfsNsPTDRUsHIGbnZ1ctW5eWjnKLqjWeeqqcnlUqHY2rn/izNX95CgvC
         6ye3sKmBdLDuduZOyucXKwkTxgO+cPyXZlW9tmbpDo36pJmfKdC4ox8vUhxU1uCpuYBw
         dIhg==
X-Gm-Message-State: AJcUukdZIhUraqSWwBWOO7hcpfTJpppq240HZJKg7T5u+3zXVEGT2tv2
        PhMHfaIW54FMD8PHEDapT5J5YgQLOoorVf9kawSKTg==
X-Google-Smtp-Source: ALg8bN5WjYLj1ouCzDt95/wRbCJWkdbndIvPkJlioVcbT5asJOv1NwrC8rjdUm7l/s5kH/HMS47Q3ula4mLhuunwo8k=
X-Received: by 2002:a19:f20:: with SMTP id e32mr22594885lfi.51.1548840681740;
 Wed, 30 Jan 2019 01:31:21 -0800 (PST)
MIME-Version: 1.0
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
 <1548688799-129840-1-git-send-email-zhouyanjie@zoho.com> <1548688799-129840-4-git-send-email-zhouyanjie@zoho.com>
In-Reply-To: <1548688799-129840-4-git-send-email-zhouyanjie@zoho.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Jan 2019 10:31:10 +0100
Message-ID: <CACRpkdYgj-Ng-b4PVWdZx3knR9ac6srp6uxeu72K=4KyMj2VGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Pinctrl: Ingenic: Unify the function name prefix
 to "ingenic_gpio_".
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>, syq@debian.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, 772753199@qq.com,
        Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 4:29 PM Zhou Yanjie <zhouyanjie@zoho.com> wrote:

> From: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
>
> In the original code, some function names begin with "ingenic_gpio_",
> and some with "gpio_ingenic_". For the sake of uniform style,
> all of them are changed to the beginning of "ingenic_gpio_".
>
> Signed-off-by: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>

Patch applied with Paul's ACK!

Yours,
Linus Walleij
