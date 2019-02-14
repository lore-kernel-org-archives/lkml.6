Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DA6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E6D222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GYpPNaGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436508AbfBNIPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:15:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41879 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390715AbfBNIPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:15:47 -0500
Received: by mail-lj1-f195.google.com with SMTP id e17-v6so4412007lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkcnW3N3+D48Hq5AkocdBx7Fg3CgCmllWSzN8Ysh2IA=;
        b=GYpPNaGtbTvm9c63EWLUmicX4OURy3VeoQCOkR72EKIvkByVGnWumE9B5vosv72Bay
         7Pc1B1opAWAM7MfuwGGQRi/52doGqxsIaXEf9scoj9f4grm0vPvV5qNkA1+5ljYPcf83
         2M9+TaNg6s2v9c2ihyH+h1khfgRlqFa20bBd8gOYrdh1sUu1W0LcAa7+HQriy9VwuYgY
         nsRJwLQnfcKWq7ft74UTB4eCDbkv51Z74a1oMGruSkcIYJ3k4/GTpOx1P1FCTzjusHjF
         5Jn4vcXFu0JZeYODMfitbOFVZllXLrfw3fOGsjQ25g4LPyqeC6selVNATiD+OPl3reif
         m0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkcnW3N3+D48Hq5AkocdBx7Fg3CgCmllWSzN8Ysh2IA=;
        b=a9WAoRv98AfLW83Iinz7FJQKZjT0wOcqd6PIxaKhkKORKDGxxrTjvoEl/ZK/uk/iNl
         sajiphX+ptbuyQpphUf2tSYPVubgKYMrq9121QPMEDG85eKlfG2FaLLJyc58FAjPcXPn
         hGUt+yjoWd5eiuRVdAmKTElu2+DWaNRXmtDZWZRDqzmmqha5wd+sJYvG0Jyhx2Im9gy/
         Fj/gVMmD7F6GEyzFRi9nSoHVCzPOO3Vqn0myB2GP0MhZgAVMkSaDz6GsjYlw1eOFxKO2
         5h2gspwulRzW1JRpNhDfvO/HTrTXZq/fwhkpqyTVpKuNPByVDUl6Xmygq0nsav1dvnx/
         eZ4A==
X-Gm-Message-State: AHQUAubOhhN+NjbbWPdIbZz5r4tP2+zrdkv/yiaX8Zz/gxpf+437CUXt
        GeHVWyjbabwbjcGvzHgwWZ5jsXQYN0VYMbDKCxsReQ==
X-Google-Smtp-Source: AHgI3IbSsMSBnC5YxZc963RLo0wNAA9TkI9n1GeSvmUJeNtTyRh416SRr4OAUoZgYUpuWmE/vEe8LHOClZ8TV4Y+CwU=
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr1516825ljb.126.1550132145031;
 Thu, 14 Feb 2019 00:15:45 -0800 (PST)
MIME-Version: 1.0
References: <20190214013641.9740-1-masneyb@onstation.org>
In-Reply-To: <20190214013641.9740-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Feb 2019 09:15:33 +0100
Message-ID: <CACRpkdZA5FmJtXqSiqMDB1tw9S8ByRfgA2Dxse7iiVNAqZ6-2Q@mail.gmail.com>
Subject: Re: [PATCH -next 1/3] spmi: pmic-arb: select IRQ_DOMAIN_HIERARCHY in Kconfig
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 2:36 AM Brian Masney <masneyb@onstation.org> wrote:

> Select IRQ_DOMAIN_HIERARCHY for pmic-arb in Kconfig since this driver
> uses the version 2 IRQ interfaces. IRQ_DOMAIN_HIERARCHY selects
> IRQ_DOMAIN, so it can be removed from here.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Patch applied on the devel branch with Randy's tags!

Yours,
Linus Walleij
