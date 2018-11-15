Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79612C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF5720825
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ODRdwLUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF5720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbeKOTuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:50:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43705 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbeKOTuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:50:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so13661659lff.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOd+8/Uq48n6P5Ttzpt8g0qp7w41GiAcEoorAldUOxI=;
        b=ODRdwLUQKjiHNhcaiZQSKsZS0TqJ9d7Olzf9bWnljkA/IY80S7YxX9UDLEqza03pfn
         tI15VZhqEyimiUYDQPY5+ZVb65GONkHCOJOTWahTWqcxL3iGd+K0fKA6iMU74RtR+/4g
         Bp1jPfOnJykZt/DeaRLj0bKZ4UV8zq50b/o3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOd+8/Uq48n6P5Ttzpt8g0qp7w41GiAcEoorAldUOxI=;
        b=fl+A49llLVCZJZ5b7tj0p7AYpvArSIU9N7W35oRhIn9b/FoMH2cyOGClNzEdJUqNnW
         21M+FTksyKqZFlUIow8Y7l1dTX1hX0HnZP7iNxHYJxLiBq9/csoK6LPIXx+MnX5qZa6p
         jhQlIGt79YOcQplULcoPfc4aY6h6PGRV4YpGBTVIIFaArFf/Rc/7UtNRhycmr2vvg+g7
         oH1iEENh65mgpFPilGWEgdo5P98CEQMeEbtUo/XxKZKo2B52vWJ0onQ2o+haZaQBeEVZ
         RbdtfgpacdsoFMt42imL/97YG1onfps9/PrqiOvcDSOBlNvChqKQ90e1MovbchQTGxRm
         r7aw==
X-Gm-Message-State: AGRZ1gIsIrq4MNwMKvJAgrNPkILtAmYd/vnnehXhDCVOvxSJ0L/Kukui
        f02UJ5lGNy7uzFD/AubhVtzdJnc6VpE1G8ohs4DjEQ==
X-Google-Smtp-Source: AJdET5c72fxu20Z8xL9ZJ9dqOJpPS2LiU/MOJk8CB5z7uWEPl1VRUuD0XeApz1NMRuvkZvoCWbDfd2H6bl/t8dosHbI=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr3162752lfa.32.1542274996596;
 Thu, 15 Nov 2018 01:43:16 -0800 (PST)
MIME-Version: 1.0
References: <1541603580-17448-1-git-send-email-andrei.stefanescu@microchip.com>
 <1541603580-17448-2-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1541603580-17448-2-git-send-email-andrei.stefanescu@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 10:43:05 +0100
Message-ID: <CACRpkdZvJmH61C8Rd3TeTioag+11GHPGdCDwRHxx3UAzB-rUHg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: gpio: add sama5d2 PIOBU support
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

> +Required properties:
> +- compatible:          "syscon", "microchip,sama5d2-piobu"

Looks like "syscon" should be dropped, it is using a syscon,
but it is no syscon.

> +       secumod@fc040000 {
> +               compatible = "syscon", "microchip,sama5d2-piobu";
> +               reg = <0xfc040000 0x100>;
> +
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };

Isn't it easiest to just make this driver be a subnode of the
syscon so it can just refer to its parent to find the
syscon it needs?

Just state that in the bindings and make an example where
it is inside the syscon.

Yours,
Linus Walleij
