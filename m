Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B010C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE6D20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPqa7QQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfA3JaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:30:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40134 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfA3JaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:30:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so20072074lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYTNODS+SExLCzBWxNqtKae9gWk4/P8WpLgQQjinLvQ=;
        b=SPqa7QQRafsp8Wa3PQ2G3cPCkhbH2aJ/3H+HhbSRePIXlZgBDHmcfGhxpeTY8Wzsrm
         JOkqw/fDdN/EwiszgzSAoxVGqYbKqFf6NPM0EXVyC3f8I4JBioFlmOV5CnuHdoTDsRio
         MbQtmcAwDlG7sGNilXBdZdjiIhhlshbZmb94M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYTNODS+SExLCzBWxNqtKae9gWk4/P8WpLgQQjinLvQ=;
        b=kf5IDsKJXtQn4aAdYSWyyJVwRSnIodnxlQlAym8JARNv7sIc6E4lyxgJrdWAZIFxuI
         KSY2TGeGhADox4HoQ9uXdutFLPjYM6qJvZ9zbFqNP+j26xgVKQcvoQe+UIshSetlBWjC
         J7t123idKQTR11r+FplSyZZvYQ9W1hpsI+A/KsD18BZYIPqidUdLlLTQ6Tyvb5V0+Kal
         kf/CGotTSX4cXS27pzZP2t0m45IGlVSQGIshpP96uvMEe7r9Gfbxy+1oxj6nQ5fXBVO9
         RxsObeN7m1x2h85NruNfvXWYN2hiCIv7hrwpg2hchqlBQ00ubHYwIGI99XeuJblXeu+B
         biLw==
X-Gm-Message-State: AJcUukdtr2BC7dRYmunj5bc2oWbjFHil5H0RZnC+1J0c4Tpnb2rPVPg6
        5M+oEFSz76TN70ArJfQH0prVmUNLEUswJ3CSTPKh4g==
X-Google-Smtp-Source: ALg8bN4qP+N1rJBTWoMbcuXJmJDOU4FQrncPwvitjBpwNkNt36N5QxQZAOaOgHtbY553EGlgXsY/GLAlFU/dFJtnvpQ=
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr23590611ljh.135.1548840615446;
 Wed, 30 Jan 2019 01:30:15 -0800 (PST)
MIME-Version: 1.0
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
 <1548688799-129840-1-git-send-email-zhouyanjie@zoho.com> <1548688799-129840-3-git-send-email-zhouyanjie@zoho.com>
In-Reply-To: <1548688799-129840-3-git-send-email-zhouyanjie@zoho.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Jan 2019 10:30:04 +0100
Message-ID: <CACRpkdZ08riGsySXzKsPgRxdTJL0UPLYSd95y54AP6KeUchR1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Pinctrl: Ingenic: Add missing parts for JZ4770 and JZ4780.
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

On Mon, Jan 28, 2019 at 4:28 PM Zhou Yanjie <zhouyanjie@zoho.com> wrote:

> From: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
>
> Add mmc2 for JZ4770 and JZ4780:
> According to the datasheet, both JZ4770 and JZ4780 have mmc2. But this
> part of the original code is missing. It is worth noting that JZ4770's
> mmc2 supports 8bit mode while JZ4780's does not, so we added the
> corresponding code for both models.
>
> Add nemc-wait for JZ4770 and JZ4780:
> Both JZ4770 and JZ4780 have a nemc-wait pin. But this part of the
> original code is missing.
>
> Add mac for JZ4770:
> JZ4770 have a mac. But this part of the original code is missing.
>
> Signed-off-by: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>

Patch applied with Paul's ACK!

Yours,
Linus Walleij
