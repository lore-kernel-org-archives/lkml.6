Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7609C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6795620825
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="klT8nfs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6795620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbeKOTri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:47:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39797 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbeKOTri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:47:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so13671052lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QJpX1y6f0yA6cx/zC+9hW6WJx9ESoj2bQ2QbvIj2pM=;
        b=klT8nfs+C3GY95BTrHnbnb5tyNw+ueWyT6F9sipaoD63M+Xvlo5bV2g4Bxl8UGWDZs
         21MUuUCfYYY58p2ZySNBLJMb7uddmUTaRHH2lNVtgEvev/jMLPj+6HiN7IJ7sAdZRzno
         CXRBBJzuclTNmxuJm288iB8DTbF42tID5bOqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QJpX1y6f0yA6cx/zC+9hW6WJx9ESoj2bQ2QbvIj2pM=;
        b=oteAjX7b+nLUbFwDfqqExfpsC1geI4JswKMRou3uC7c3Pud27hulQPFv+AhmK/+S7U
         GSHGkdi/Bfr6sL0OqsOvSEGtUUC5HJrpka4aRxk1i3qGxBgor5+EioiokFjSrN76iVsq
         G75aLirIMUJPKiT4R9gqY37wLBPSxorzbG8Nf8Ztvc7U/N86AlLe0PrHI5i9gfeRWibA
         kdFKR8X1+zRONo2RbYXbfV2d4xiSHeNEZRQ35SM5G/qzcKZ27AbSGz7KRA/RrAfJzKIz
         e27pY91f3CIl2vJrMQagUIlgs7VTDH5Ebx6Po5OZwjUrsmKJGxFyDidpTfViE53z76oN
         JU2Q==
X-Gm-Message-State: AGRZ1gK78/8GMYmJwCnG22jrvOheHzUsGnHPd6iVjGE29oXHAH+6YA82
        b3mv/Tm2ljGVTFAayhKhEK620h6s+vd7k6pazKKw7A==
X-Google-Smtp-Source: AJdET5fypNKPaZnzKzlXWv08oXvaOiEfZtlsHtIjhS+zADDfexP26oaOlEM3Qi5IBps9WeXYhxMYD7XjTLlStgO6TZc=
X-Received: by 2002:a19:2752:: with SMTP id n79mr3288340lfn.11.1542274832149;
 Thu, 15 Nov 2018 01:40:32 -0800 (PST)
MIME-Version: 1.0
References: <1541603580-17448-1-git-send-email-andrei.stefanescu@microchip.com>
 <1541603580-17448-3-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1541603580-17448-3-git-send-email-andrei.stefanescu@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 10:40:19 +0100
Message-ID: <CACRpkdbg5LTYAkSZTmLvfjWyhOrOFw9xEQKB_WgVOMULAii_yQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] MAINTAINERS: add maintainer for sama5d2 PIOBU GPIO driver
To:     Andrei.Stefanescu@microchip.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Cristian.Birsan@microchip.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 4:12 PM <Andrei.Stefanescu@microchip.com> wrote:

> This patch adds a maintainer for the sama5d2 GPIO controller
> driver.
>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>

Just merge this in with the driver patch, thanks!

Yours,
Linus Walleij
