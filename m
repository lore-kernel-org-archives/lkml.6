Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISREv9vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1B7B60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeFFL0f (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:26:35 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38425 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeFFL0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:26:32 -0400
X-Google-Smtp-Source: ADUXVKLs7kZ6uMGc5kVvJGKwmUT7L1Yd5SS/SLiY6UU1LDHTYpfP6iRqCR4LZ4exWLr+HV6uwAWp4VYnFVPaRtx4iQk=
MIME-Version: 1.0
In-Reply-To: <20180525160632.66726-1-arnd@arndb.de>
References: <20180525160632.66726-1-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Jun 2018 13:26:30 +0200
X-Google-Sender-Auth: Z5OM7Dgplge999BHqttlEIwwgjk
Message-ID: <CAMuHMdUR-K3utp7qao6exo4amWZz7+-b0DqXpLGbQAM7WmJ_5Q@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: qcom: mark PM functions as __maybe_unused
To: Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 6:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The #ifdef guards around these are wrong, resulting in warnings
> in certain configurations:
>
> drivers/usb/dwc3/dwc3-qcom.c:244:12: error: 'dwc3_qcom_resume' defined but not used [-Werror=unused-function]
>  static int dwc3_qcom_resume(struct dwc3_qcom *qcom)
>             ^~~~~~~~~~~~~~~~
> drivers/usb/dwc3/dwc3-qcom.c:223:12: error: 'dwc3_qcom_suspend' defined but not used [-Werror=unused-function]
>  static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
>
> This replaces the guards with __maybe_unused annotations to shut up
> the warnings and give better compile time coverage.
>
> Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
