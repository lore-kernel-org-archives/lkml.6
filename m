Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228B8ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8A321476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueqbbMfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8A321476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJSVtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:49:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39533 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbeJSVtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:49:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id e21-v6so2081784qtp.6;
        Fri, 19 Oct 2018 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KwGRl7FpIDhBFacpLBjjceNQS3WXJYar8/h3LGwxyE=;
        b=ueqbbMfQ42MELeu0/ZD76HBKI6iwjyvo7LiF0mulDbjLF+ZWBSFPBdohiBOXoGrn4V
         6HUB/aogBwfZ1K6Gfng/YQtW8XCAdIhZniSJFkOuFMyQIgM1+8I7S53bmOYW2l13XmWp
         UnBarxalyugfDNhvQvMB2ZLrZP3245TNF9b49LZ7W/OzFJQERyQ7WdueEYd29uF1a6Ta
         I+0nX9HMg08+nGPgQhTi/jXHxcDeHAOY+5H8zb1GaJt06+JtHFyUAfbSEQdMJRq325rz
         Z7/125B5TFZgjqLw4MJfO6iik/LU8BhgvHzpox/wSv2NG6S2143HfIAouJqyIn/kzEBP
         TpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KwGRl7FpIDhBFacpLBjjceNQS3WXJYar8/h3LGwxyE=;
        b=ks9QBT0nHegfHyWtabEivYNAM0bBS/AxCUs3r6Cs0Q1EGMlgVu0+XCn+UKfM9qmyHI
         kgepUsREnY0XNzNwx94kkUwTG0FP9y/qT8PaFTkEkis1wbhRm8k/nbuil/o6xQKKln+Q
         jPJHAcBrGj3p4cip8QUxd/3iK4jXgskOWLEIC0FoPtB2qYizcjzWBEHmynOTo3YMhE/D
         j5YW+gRskeB/tgGSre4yYVrAsIshHaB0xnfId5teP0ULTiBaimSEyUSdGrfee+afLCoh
         9cclUB50C9FJdonT1fh5hW6GyaEesqma1W0LcOLOjYz1kXUQEiaUKXcEEt8Gsp3N/dvZ
         AhPw==
X-Gm-Message-State: ABuFfogT3zSlfmG7AzKQiFSzmDxyEjgSP37VJGtv2y1BTO6R+lzI5qHA
        agrmeDt/yjl2rpLB/zI5B1uuD1q7NVxrPEpzeq0=
X-Google-Smtp-Source: ACcGV62/bkCmGzej4y7qilkrr6cjck84LAaqXvqSIVCgwbcJ9ElDMVBn32jGjNl1WHRBrgDJs7EETu4hcdQUaBDTdok=
X-Received: by 2002:a0c:819c:: with SMTP id 28mr35193680qvd.7.1539956613974;
 Fri, 19 Oct 2018 06:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-12-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-12-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 16:43:22 +0300
Message-ID: <CAHp75VdnrWUSONXwPfVD1HuON5DyGq3qF4JOJbhC-LKudhRdng@mail.gmail.com>
Subject: Re: [PATCH 11/15] x86, olpc: Use a correct version when making up a
 battery node
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature. Add a different compatible string to the 1.5
> battery.

> +int olpc_dt_compatible_match(phandle node, const char *compat)
>  {
>         char buf[64];
> +       int plen;
> +       char *p;
> +       int len;
> +
> +       plen = olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
> +       if (plen <= 0)
> +               return 0;
> +
> +       len = strlen(compat);
> +       for (p = buf; p < buf + plen; p += strlen(p) + 1) {
> +               if (strcmp(p, compat) == 0)
> +                       return 1;
> +       }
> +
> +       return 0;
> +}

DT doesn't still have a helper for that?!
I hardly believe in that.

> +               olpc_dt_interpret("\" /battery@0\" find-device"
> +                       " \" olpc,xo1.5-battery\" +compatible"
> +                       " device-end");

Please, don't split string literals.

>                 olpc_dt_interpret("\" /pci/display@1\" find-device"
>                         " new-device"
>                         " \" dcon\" device-name \" olpc,xo1-dcon\" +compatible"
>                         " finish-device device-end");

Yeah, this and similar also needs to be fixed.

-- 
With Best Regards,
Andy Shevchenko
