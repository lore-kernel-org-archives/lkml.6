Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbeFEG7M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:59:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42344 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbeFEG7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:59:11 -0400
X-Google-Smtp-Source: ADUXVKKapf/ctfpqA315ZiRbEwqxVJXiC0U+B1x72FovKUY2wlycP3iccBATurwFY+SgaW2qyROWVQ==
Date: Tue, 5 Jun 2018 07:59:07 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: bleung@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cros_ec: Use devm_kzalloc for private data
Message-ID: <20180605065907.GE21163@dell>
References: <CAFqH_50VYJC7aep6P+KtN4qmFeV66GEXvxmFy8KrNp1BRv33xg@mail.gmail.com>
 <20180530165422.51178-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180530165422.51178-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018, Gwendal Grignou wrote:

> Use dev_kzmalloc, remove .release entry point.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Change sinc v1:
> - Readd __remove to avoid a warning when loaded as a module.
> 
>  drivers/mfd/cros_ec_dev.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 1d6dc5c7a19d..81466264f7fc 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -262,12 +262,7 @@ static const struct file_operations fops = {
>  #endif
>  };
>  
> -static void __remove(struct device *dev)
> -{
> -	struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
> -					      class_dev);
> -	kfree(ec);
> -}
> +static void __remove(struct device *dev) { }

I missed this line when reviewing.

Why are you keeping the function around?

As a result, we now suffer with a build warning:

  drivers/mfd/cros_ec_dev.c:265:13: warning: '__remove' defined but not used [-Wunused-function]
   static void __remove(struct device *dev) { }

Can I just remove the line?  What are the ramifications of doing so?

Please reply swiftly, so resolve this issue in good time.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
