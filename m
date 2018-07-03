Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256C4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53F120855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3HYytQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53F120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbeGCVbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:31:21 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:41896 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeGCVbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:31:19 -0400
Received: by mail-ua0-f194.google.com with SMTP id t14-v6so2167360uao.8;
        Tue, 03 Jul 2018 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GEZjqWzosX9Nc3/6d/iOyX0FksjRuu7mQ7KvFUWoSb0=;
        b=I3HYytQ8EupaLg5RR2If6JBYBFmyT6QXaJzsEmyhJzb+gvRfiXKhEJCDNPS/FzP3bK
         PRya5UHWjusmEsxfrA5qN7O01LY1W5ZptVWwOqnMjblJzyGO1kD8UfMhgXv6PAJShGqK
         Z8mRp5/qDtpIMbSeSnG8a2nUzBMUZ7txutBI29yZLLvY80NPHv1UqU0b+QDk9MQLXCR/
         qhgjGMVaj0QHp9lFsWZphahVX7NBO3OhVV76MKH02KjBXBCUau2b4LGcsMSatowgam6C
         nG+y3XPOkQPL2DWx1Dzo+GN5K4a1JEoOOKqHgWY7n7aYMqWXzQGgtGjA9mx0gQ90Y0SL
         9iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GEZjqWzosX9Nc3/6d/iOyX0FksjRuu7mQ7KvFUWoSb0=;
        b=LGHb03FOiNeobImNY+O+uHe4lyCc7nbnD+GC8ruqgOdBLhgl8Dti0BnGLNLiZ/lZHo
         MQvXgomymSrVv5DshWaoUQhF4d3LvgB2DyiwrJPQrNkcYhj4HJnj4kRLCpjw9svoqQqm
         VHcDMPwnO8isIwQCjd2oMnVfvQIeWtyZrUPZ936CioydgDs4VbZDeJeuhg0M3CKG9nQp
         TfUn8aF9GL9AD/18DWD074/kfIG/RwKJ4UvmS3HejcQqEcf2MyvtUo+TxgpCMhE4s/Yw
         4QKIm41nAOYaozOyuJpBB+4XuBbo79uLBK+Jm5mRAXRkS/HQ4ucg4ULyTZ2c6GQa5oGb
         ByLA==
X-Gm-Message-State: APt69E0be5t05x+FzK4OfzgaG8sNRR0VMY1OhZ6sPGl6ZHLxWZE/nnZ9
        1sG05qyWj3HhXT+8LsDK3smXlhsQnIptOLOz9Ds=
X-Google-Smtp-Source: AAOMgpcWfVRXfU9qe6QR1eZ4WuZLAt8ppW9aRaobT+2m0iFlsOky0veT5tzj0OSrDcnjZGsIsc/L/yiUWHGMWESc2uM=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr19450504uai.47.1530653478694;
 Tue, 03 Jul 2018 14:31:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 14:31:18 -0700 (PDT)
In-Reply-To: <93a290d7082ed2e4d3e2b91dc7f6e941c9242a41.1530600804.git.nikolaus.voss@loewensteinmedical.de>
References: <93a290d7082ed2e4d3e2b91dc7f6e941c9242a41.1530600804.git.nikolaus.voss@loewensteinmedical.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 00:31:18 +0300
Message-ID: <CAHp75Vdn-Fn_bwgBjvnLa_s2LORgdEjLH0jpRvVDjwyxKOLEBw@mail.gmail.com>
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

On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
> of_device_id table "compatible" strings in DSD, a pointer to the
> corresponding DT table entry should be returned instead of a null
> pointer. An acpi_device_id match still takes precedence.

I'm not sure what you are trying to achieve here.
This works solely for ACPI case.
For PRP0001 (which is just a _temporary_ solution for device in
question) we have special code path in SPI and I2C cores.

https://elixir.bootlin.com/linux/v4.18-rc3/ident/acpi_driver_match_device


-- 
With Best Regards,
Andy Shevchenko
