Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AF8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963272184E
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="A7oN0MY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfBQWHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:07:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38824 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfBQWHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:07:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id m1so25236339otf.5;
        Sun, 17 Feb 2019 14:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fb34zk0pI4o5Yrm2AzckhgwIT5jFzU1CY3//3+bCSd0=;
        b=A7oN0MY1nq9XiqE4fU9+ijO7qYjmTi2Z5sQYDo+7t3bvAHG7Q8MbP4TUygf6sSW1pN
         6K+7fa1+CmfXP6TFi3FHVlPA15eaD1Cuc8J5wjraCWWrD+cee1aPjnaB68qTs+o+PsQT
         EeNcg+H/n04u0VxjAYndEJzuIWOqBm9lrlu8dasBkHVQTGDjAR2WX67tGYbQD8dU7MJp
         nwH9cepymQFmk3vKI3BWbIg61bqo2MvK5JzI1MWCVQwzuBaOsdxBkl1gEjhEo+POtlyq
         BAYVAYqUZrT6YAFuOCW1RFaEt4L/b0SYaBwha4WCvQMZUlZAR3avxnxTaAZYZBtFQ1z4
         tawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fb34zk0pI4o5Yrm2AzckhgwIT5jFzU1CY3//3+bCSd0=;
        b=XUOpvwWwCWJvyOtXJmyUwpPKCMruRXJxg/1O2FD1zOqXAEtPddjCVuRz/Z4KztGak2
         aTNEfEGS7gCgOuaTw+/MP0Uad9HPil7EfiycGB5qnPfKmQv6Xp07QfC62gtY1cEc+eah
         DfuNBiYtFpTMfMQ3TG2Iorix+Ux6kH5Apens4H7VzmL8jD4cihZHvSrdiWKOIL8Mj/EQ
         +Iti4Sfo3yYb2tKJ+mKIK/GHNer/tNFxVgGgrmM5qUH4eJQjoBgmdHcL+viOmjDIMWSY
         PXjBJdRpK5AjbIJudV6JkBroIlzAVTNKzwF0QEqCTuE6HZz7K1u/MTvuoXp3A66TdsQz
         ZReg==
X-Gm-Message-State: AHQUAual1keGqrodJqApljvLra5XQzBl+80ViFtLxplVUXEerIYiNFfL
        mr8tZ7hdD2BxgRDFm6Zn6yXGtjv6EsUUxCF5Yxs=
X-Google-Smtp-Source: AHgI3IYF/eF8fEVvtPrPZpkO1gTS5g5/omwxFYl/mMCwZWICPyeLgArW+TSfazpEo5v5xBnUUV8mbIBAlthSrVXUlEo=
X-Received: by 2002:a9d:798c:: with SMTP id h12mr4342848otm.86.1550441260987;
 Sun, 17 Feb 2019 14:07:40 -0800 (PST)
MIME-Version: 1.0
References: <20190212151413.24632-1-narmstrong@baylibre.com> <20190212151413.24632-4-narmstrong@baylibre.com>
In-Reply-To: <20190212151413.24632-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 17 Feb 2019 23:07:30 +0100
Message-ID: <CAFBinCCHy5-kxFoAGUvA7KgOFTjvRFjVE962U+FS1UZnGKEOXA@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Feb 12, 2019 at 4:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Adds the specific compatible string for the DWC2 IP found in the
> Amlogic G12A SoC Family.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> index 6dc3c4a34483..e150b7b227c9 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> @@ -14,6 +14,7 @@ Required properties:
>    - "amlogic,meson8-usb": The DWC2 USB controller instance in Amlogic Meson8 SoCs;
>    - "amlogic,meson8b-usb": The DWC2 USB controller instance in Amlogic Meson8b SoCs;
>    - "amlogic,meson-gxbb-usb": The DWC2 USB controller instance in Amlogic S905 SoCs;
> +  - "amlogic,meson-g12a-usb": The DWC2 USB controller instance in Amlogic G12A SoCs;
if anyone is curious: starting with GXL (not supported by the dwc2
driver yet) the dwc2 core is "peripheral mode" only while previous
SoCs had one host-only dwc2 instance and another OTG capable dwc2
instance

I also discussed the compatible string with Neil off-list because I
was not sure if we have unique compatible names for the dwc2
controller and the "USB control" registers.
The "USB control" registers are named "USBCTRL" according to Neil (I
assume he got this information from the datasheet to which I don't
have access). Thus the compatible string for the "USB control" device
will be "amlogic,meson-g12a-usb-ctrl" - so we don't have any naming
conflict.


Regards
Martin
