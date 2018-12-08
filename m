Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CF3C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075132082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VHqQZv4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075132082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeLHQt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:49:28 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38991 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeLHQt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:49:28 -0500
Received: by mail-oi1-f195.google.com with SMTP id i6so5852358oia.6;
        Sat, 08 Dec 2018 08:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u90qm1lo7zTFrCsP0QkupscbeCB3oj/DeM1IBcmae7A=;
        b=VHqQZv4xqGsWOCX6VjS22EXP/xM1K5bJ3skQu82H51mdnHqkr6EPBhi3HIsxkH0BP5
         RKxa9j1MsbRb9r3pwF7YHwZ8OIx31J+l49Xtx7gYiGnOt1ky1wiD2u8h1f1fYQ6zrIak
         klyPw1fu6wkJ/JBspCmeLBdVwikp5NbIYa4ioJYtPiuTQ8ll/WMnTC9tVJAvuzbcf4kh
         3QAyTCydjThnN4D1htuh6qyJCD+mBWA6BY/XA2u11M0UxSCEpx8+NLlWSjELGEwY8Krp
         BF7ApDW7CZqW7h0Mh2cHmHPMi/bvDISAztc3iaqyu1/o6OsxruWHpYubnMYqjp1XlTOU
         3I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u90qm1lo7zTFrCsP0QkupscbeCB3oj/DeM1IBcmae7A=;
        b=IHh6mm6Yxfn+kDY3rAn4DV7C+6FyYa/e0bMOZ3friPKmfjwbNUI6N+C4gmGd7xXGCF
         K0pc0SVONtS4qjT7PFEliU4NX2LlNc3qt9x0eIOhZun2Gi7T5n7vAWCov3RW/W502oPU
         ibWqRE9pKMEY7dwAxgKxT2Nl8btn2W4h5eRcp+vNYc3Q5LIZnnfHQll7GDTFMfGod1Z8
         SXRFQGdqfFeePLlWn4r5DGN3Dew+g2iMDEgLKxDpw9t6W7lGSkGcZQQtR6RIlz1AxRrW
         9/A9Yd/Q9VUq/XW8ONH+qlx4yodty9pupYTlR0zUKdDL6Lxlx6Uoc1bODeTcA3x0/+hS
         jgGA==
X-Gm-Message-State: AA+aEWZUj8nmF46nfHh+RpCDOKDzQmvH8D78T6cCZJMcCpNDiSa2IyDL
        /o4v+o9nv3Muq14EItPJSGwhzpMNzHU8NRWMPGjuSXf5lAw=
X-Google-Smtp-Source: AFSGD/Wqz50QtT39QED0fEXerJkV6pJrc4q3XpoPITTO87pXZWMLSj4wX+8UfnwnFWAvgG28gN6nwouRgewXO1QfMCg=
X-Received: by 2002:aca:5b43:: with SMTP id p64mr3644106oib.41.1544287767599;
 Sat, 08 Dec 2018 08:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 8 Dec 2018 17:49:16 +0100
Message-ID: <CAFBinCDuFCrJHrzY_98REiwnZMcezxUbth8Sd+Bz0jxipPhyWQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: dts: meson: add the APB/APB2 busses
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 8, 2018 at 5:46 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> This adds the APB bus on Meson8 and Meson8b as well as the APB2 bus on
> Meson6. This is preparation work for adding the Mali GPU which is
> located on theses busses.
>
> Meson6 seems to have it's APB at 0xc8000000 instead of 0xd0000000. The
> region at 0xd0000000 is called APB2 or A9_APB and it has a different
> size (256k) compared to Meson8 and Meson8b (2M).
>
> Addresses and sizes are taken from the Amlogic 3.10 kernel sources:
> - Meson6: [0]
> - Meson8: [1]
> - Meson8b: [2]
>
>
> [0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson6/include/mach/io.h#L61
> [1] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8/include/mach/io.h#L53
> [2] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8b/include/mach/io.h#L53
>
>
> Martin Blumenstingl (3):
>   ARM: dts: meson6: add the APB2 bus
>   ARM: dts: meson8: add the APB bus
>   ARM: dts: meson8b: add the APB bus
I incorrectly sent this series with the patches twice (once with a
typo in APB and once without the typo).
I'll re-send a fixed v2 - sorry for the noise


Regards
Martin
