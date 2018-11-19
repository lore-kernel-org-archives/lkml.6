Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC245C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B2F20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MepLuQLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B2F20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbeKSXhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:37:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47005 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbeKSXhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:37:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so21270278lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 05:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OG4uBd/12Y4fignxTWOFn8ECtjrY6OYtlRRMwmhpwlw=;
        b=MepLuQLpFKRZbmSSDCaiRxZAZsoiwH+b/8EozDFyAaIPczS5/YsXP9fj7Em2HCtOk6
         fXRwb/xvcP3A6a7N3unBUB4A+72Z7zJXxmxsrtnc8RuQrSCHK2Pn++8tXEEKBis5zrQg
         2YgBMArQC/VskNQOHfNcG/c2jdxVt+hjX+WwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OG4uBd/12Y4fignxTWOFn8ECtjrY6OYtlRRMwmhpwlw=;
        b=O8Ai3xcAPshx2EJG1PhW6zSAHBqilbWiosRTCrmiR+UUpuqOnGVinTf/7mdCeugw1/
         5EbSbcVx2L7q81EWyUue+x1uyRkoQ/f0FgUv2Aw04RqcTHSwFjdYH1lPpA4Ngf6e5qQx
         N+Oeofu5NsJjChBjTT6AOTfaG9YnQa6QJkUY15yUTY+r5Q/IsZZP+gHrDR0asSOpRRg0
         jjylkYrjtPS4w562YEuGDNqVy7BTSSPHryRXRq6E9S6nQkIIO/o3HQ8leHhDXYFUNwun
         BGtUoNmQYsIg8EnqTof0kyr5mo8E4R0KEVyvDs+XGrv0bUJUXYTJJXETARWL3jrlKY17
         jKWQ==
X-Gm-Message-State: AGRZ1gK5qwS8SvrjUVZynUpqwum/yacf/0gMltHph2I3zpcnSQr+P8Dy
        mNOPr9HvomQZvp736GSvIP0Ovo4AdK+Tsxow98Ojhw==
X-Google-Smtp-Source: AJdET5fzwUDly+UUw+xSZPFIcrDT1OjzgangfyiMsrAC/G9FJeh3zrl/Si38VsNNj0NPWM+mLyKQ9fdqQbOR8RvlHHo=
X-Received: by 2002:a19:c801:: with SMTP id y1mr10300471lff.53.1542633217544;
 Mon, 19 Nov 2018 05:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20181115124748.268286-1-pn@denx.de> <20181115124748.268286-6-pn@denx.de>
In-Reply-To: <20181115124748.268286-6-pn@denx.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 14:13:25 +0100
Message-ID: <CACRpkdZqvnmzzAn4SRWuchniMn7K6GrxUXynW=Hf5zrgDH11JQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] arm64: dts: actions: Add pinctrl node for Actions
 Semi S700
To:     pn@denx.de
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, mp-cs@actions-semi.com,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        linux@cubietech.com, saravanan sekar <sravanhome@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 1:48 PM Parthiban Nallathambi <pn@denx.de> wrote:

> From: Saravanan Sekar <sravanhome@gmail.com>
>
> Add pinctrl nodes for Actions Semi S700 SoC
>
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please merge this through the ARM SoC tree.

Yours,
Linus Walleij
