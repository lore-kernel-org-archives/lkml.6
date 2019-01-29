Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AA9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE272087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTEUguD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbfA2WHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:07:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46159 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfA2WHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:07:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so10321169pfe.13;
        Tue, 29 Jan 2019 14:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAQmZvSuWm53wBfkQxdKjUotVg9eRgcV9RgiTfoVLBk=;
        b=gTEUguD0qq5AhhwjPc58tMvFjpvYasrggTGpJg2gqocL0JQyWSfnVYEOaTppjtKifT
         D1wkShjO3kWYnOeRgZKNDY4SDncYC261biXoQxTpSe5XEiWjpuvHcq/cuogBAGVwBJmr
         3X9djdZDYrM2sHKuGoAWsS9W0F7XGEC/jYcz6cdnLmra8QWCeyb/B/UIrQyL+zGKXnMu
         1Cwzen2oeuMi9ULAwo9a5TwoQRtBEHYdyMgE4qMV19GQbs5SaZtEY6woI0B8Bl97p31Q
         betlOc4SHpQj0JkQBrkhXjJRcsk/fcXasEno1YKi9R1NgXAMyQ9E3TDX4WpblBVg0qgT
         eFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAQmZvSuWm53wBfkQxdKjUotVg9eRgcV9RgiTfoVLBk=;
        b=X4mqUXK+ROhpsRkYsmkbW0M1w77sNJO0Tp33taKOYDUDEOyWZmeIehVKma38FaCHe3
         4ZwPOg7Hi8oeOb0Og/2hKmR4FAs41Z+IxP6tUn5lbm5gMctpZtK5q5CXLyo0Bg2SBq6c
         44QwsXwp/bPH3gtllaKeJjlw+m1/AfsFAkkCEQLGnh7EeaW5itDist13CPK3C26yEYCR
         WjH5VHkowc7i0/qNUpyvBonqVDxjtm6fdOOrLLr4cCEKSQAD8idj8UrrmiUJiMNwTP1D
         GuFLph8pawva6RmTkOEibIPnCYYd7xS4AYmR8HlLaZB4cAmp2wDI8E3ZKo6K4tRV9B/J
         3hEg==
X-Gm-Message-State: AJcUukdz3uE5GtfvNED4XkSpU4zxxrpJ1Vt4FCpMbAZhm6Sl0zSmmWIa
        Mm5r+VbzzM/vLPILn1/xEHd+NODy72hOijr583M=
X-Google-Smtp-Source: ALg8bN61IOb3Wn4xnuQE1hmbJ8IIbaKs8H5eDVRUcl/qBptmp+/pnCRm2e7YXc7nR59iv2P7ELRYIZa4ecTI4L9/VT4=
X-Received: by 2002:a62:34c6:: with SMTP id b189mr28620494pfa.229.1548799621989;
 Tue, 29 Jan 2019 14:07:01 -0800 (PST)
MIME-Version: 1.0
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1548696487-8840-1-git-send-email-lsun@mellanox.com> <1548696487-8840-2-git-send-email-lsun@mellanox.com>
In-Reply-To: <1548696487-8840-2-git-send-email-lsun@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Jan 2019 00:06:50 +0200
Message-ID: <CAHp75VeByqLAr3hakCTSO_M3xjUyt=A0bPgpWeSV62Vomcrsog@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
To:     Liming Sun <lsun@mellanox.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woods <dwoods@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 7:28 PM Liming Sun <lsun@mellanox.com> wrote:
>
> This commit adds the TmFifo platform driver for Mellanox BlueField
> Soc. TmFifo is a shared FIFO which enables external host machine
> to exchange data with the SoC via USB or PCIe. The driver is based
> on virtio framework and has console and network access enabled.
>
> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Liming Sun <lsun@mellanox.com>


Please, go through this series taking into account review I just did
for your another patch.

On top of that, see recent (for few years I think) drivers what modern
APIs they are using, e.g. devm_.

-- 
With Best Regards,
Andy Shevchenko
