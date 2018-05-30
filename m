Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932587AbeE3XAX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 19:00:23 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:40867 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753734AbeE3XAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 19:00:19 -0400
X-Google-Smtp-Source: ADUXVKJmWII4bGSUdZD2O2Sn3fBIAnnP7EmbtfkTXtVB7wyoLrTUjbf8wFKO/obQQJGQXoil1DnTCyJ/PAhxOiwkXjg=
MIME-Version: 1.0
In-Reply-To: <20180525160632.66726-1-arnd@arndb.de>
References: <20180525160632.66726-1-arnd@arndb.de>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 May 2018 16:00:17 -0700
X-Google-Sender-Auth: Z-c0Acl1WKhDFm_sv3gfQfI6jBo
Message-ID: <CAD=FV=UAw+JB4=++cPDBT1GtO_AChhrgtayJZqV3+yE7RLxcAQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: qcom: mark PM functions as __maybe_unused
To: Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manu Gautam <mgautam@codeaurora.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 25, 2018 at 9:06 AM, Arnd Bergmann <arnd@arndb.de> wrote:
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
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
