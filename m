Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C9DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4EA20844
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/Esee+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4EA20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932338AbeGCVgs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:36:48 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42216 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbeGCVgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:36:47 -0400
Received: by mail-ua0-f194.google.com with SMTP id x18-v6so2171732uaj.9;
        Tue, 03 Jul 2018 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jJSzEO7ZeJR7J7HWuQmZXtDQbaJenoxmvLF8QFzanj0=;
        b=K/Esee+UMWjwwPzVLBdujzS1dyfXgkC/PLbX3PpM3a7wdICRo2mB1vATcqaCr5bGAJ
         PO2jBEofVIdTtj8GG2mnGEPR6458OCIbvGjWL7nKdPH7n8cgLWgUeSu4eWkWGiM/9g0s
         sAdgrnncLelC4+z5Qnf+hHU0RELvVJHlS7cCLlhpU+9+n3QTPvPx9AAgvhomK1IPeGWc
         HqwEaJeCzoAv4CfjF/MIZMZjNph9Lju4XBDHoVTic0uQ4NtvaRu+WFGVNlCzi8KHYj/f
         JkW921hmtMP6F31hy2b2ts4dAq0xoSWiaDvBJBmJ0BsOt5Cjr1yMLEBTZgUnmpamPmNM
         yR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jJSzEO7ZeJR7J7HWuQmZXtDQbaJenoxmvLF8QFzanj0=;
        b=XCb/BK+PvBwmGo8lnRNEbNbh4jcPUWLbtt+tYmNN3C5FWBwKXIenHY3svrfaG3AO3Q
         sUiT/yCggWhrnfoDTc6Pfq9t/mgYieXai2J7mKqgX5zfBSyvLMI9EWMcRa8MuivGv/5j
         a9eOWyBIZjQp7vacB/C2DY6OicpcoVhLHBXrrVRYf2xGeVLO6TLzq/GhSeVy9d1SWaeQ
         DIj/8LroJ02KyxZMGL+F/kUJY4SPl0/djGhrgwrXB1Nm7fDvdkwUXsxE3td6Yi4WPmLP
         tjBmlwP6acU+PSjxVXSnZ58b8TWqAJuUgPD9PgunM2dbnv99RrG4uBlSKmncEADjt18S
         bNiQ==
X-Gm-Message-State: APt69E0e87kzGeff6mgzrFW8MtiDTu0LSJOAJMvV9xY8+pw43ux0loKE
        drkZTRZwye+6JMHMBtjFssboObMwzrIVfblATZhsmcrV
X-Google-Smtp-Source: AAOMgpfMnq5Myjx6GPV7ABO+jezfZ2xMtwApa/EnTxE2yWrg0cneDx/8S9A45eew6gVTYDbw7+hDyGMdbSGhTJv4rBk=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr11289978ual.141.1530653806255;
 Tue, 03 Jul 2018 14:36:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 14:36:45 -0700 (PDT)
In-Reply-To: <CAHp75Vdn-Fn_bwgBjvnLa_s2LORgdEjLH0jpRvVDjwyxKOLEBw@mail.gmail.com>
References: <93a290d7082ed2e4d3e2b91dc7f6e941c9242a41.1530600804.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vdn-Fn_bwgBjvnLa_s2LORgdEjLH0jpRvVDjwyxKOLEBw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 00:36:45 +0300
Message-ID: <CAHp75Vck_1FcPQogmT5vd-47Uy3o9_bSVpNwxVaj3ckHZL3Ccg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bus.c: Let acpi_device_get_match_data() return DT
 compatibility data
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 12:31 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>> When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
>> of_device_id table "compatible" strings in DSD, a pointer to the
>> corresponding DT table entry should be returned instead of a null
>> pointer. An acpi_device_id match still takes precedence.
>
> I'm not sure what you are trying to achieve here.
> This works solely for ACPI case.
> For PRP0001 (which is just a _temporary_ solution for device in
> question) we have special code path in SPI and I2C cores.
>
> https://elixir.bootlin.com/linux/v4.18-rc3/ident/acpi_driver_match_device

Just have to add, that PRP0001 is enumerated via OF per se.
It means the driver in question must have compatible strings and
MODULE_DEVICE_TABLE(of,...).
Also don't forget to enable CONFIG_OF in your kernel.

-- 
With Best Regards,
Andy Shevchenko
