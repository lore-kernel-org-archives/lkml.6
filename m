Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254A5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE00C2176F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S03OrjfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389666AbeLUKbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:31:38 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:42856 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389558AbeLUKbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:31:37 -0500
Received: by mail-lf1-f49.google.com with SMTP id l10so3543857lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MahSN5eHYGobUqPuHbiUtLe6WiUqGq9YkG+F2XfFA2Q=;
        b=S03OrjfNhUzgexQT0DqjvZuFpROC+uIpMR541i5C8CgfB5dLxNQhJ4aCoBuvuZD1tF
         eqqm1SeW0lLh/XbH3PZovqmRT2hnHUiETsyDs/ryYdmwAg5rucP1LPJ2Zl+NiGUeaXB1
         WDR/e8aKa6sS3zNcknOJkoborulq9vh60RVqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MahSN5eHYGobUqPuHbiUtLe6WiUqGq9YkG+F2XfFA2Q=;
        b=sUdJ2Ei98ODk40W95F+dI3h3MzQRvnPcoH3b0xdrp5wYaqnr60aExkVDqSS5IzRGgG
         PTcaYTjWLSaVlRvSQpApDBniYMDrKvHNOvTcDp3R4G8iBrVMCcxFa5WsIcaQ8pvy8JNK
         kNzdUhNDonj3DbWV9LjHVApKiPc7ODdNanSWblMy/3yl5dHRUo6HsdicmbXQ1tkWKJIE
         OF3NAwQufcJ/qhub8kfZ3Mm53jVdYnlenrwd4NCxnLQuYtfCcPWJKsIVdt/7i0c1Z5tM
         4GCmkwNUJVfeNh4/S/FbtXVh1mi42k6qAky21mQdpTFzgU7zoQLBprWuAX6x0+hBT43F
         k1Og==
X-Gm-Message-State: AA+aEWamZYI+P80dsnn7Msz9KJefFRB6lqiU+rXluzFQneIZt+rf5SoZ
        8NOj/z+8Qx0t202dwkD3iuO7r93pMXBbblMCCyQEcQ==
X-Google-Smtp-Source: AFSGD/XH16hyGVElrgk1eguiGY+871P/JAFm6bEDD2j1GxOL2B2r/KlGbJLaOCyy+ny+D10fWrq9SgcTnmbjCzgB+1M=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr1120498lfa.32.1545388295781;
 Fri, 21 Dec 2018 02:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20181218122802.28157-1-colin.king@canonical.com>
In-Reply-To: <20181218122802.28157-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 11:31:24 +0100
Message-ID: <CACRpkdZn_s6LHeqTZqEMhzpY=u2jcda_YUvnfX0qwEw8kMWJOw@mail.gmail.com>
Subject: Re: [PATCH][next] gpiolib-acpi: remove unused variable 'err', cleans
 up build warning
To:     Colin King <colin.king@canonical.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 1:28 PM Colin King <colin.king@canonical.com> wrote=
:

> From: Colin Ian King <colin.king@canonical.com>
>
> Variable err is defined but never used. Remove it. Cleans up warning:
>
> warning: unused variable =E2=80=98err=E2=80=99 [-Wunused-variable]
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied with Mika's ACK.

Yours,
Linus Walleij
