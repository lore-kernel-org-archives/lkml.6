Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1EAC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DFD2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfglaQEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DFD2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeLFChc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:37:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35374 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLFChc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:37:32 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so24783189qtc.2;
        Wed, 05 Dec 2018 18:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoHr8lruXoTODdZ/3ftu6AEKExytx/3sK8QukZl/o1I=;
        b=RfglaQEL60bCcv5habg3c83fjaN8jUnXk0m5XpnTRPXOmitifjFUtmS9hqEb+weF8m
         52RtqPVVbUKgpicS8dRaeQXBY2Eu4DMUKRi5kUNgQ7pn7TtiULw+MKJhbqymBw24oBjs
         jZ4UxoxGXoek2Z/DPIWsxg8VuU5ioHUziaPD4CAiXRsxSuOvlVWVnxTtYezVQxtK2/q5
         TuwSVM2ktWR9shZoVofXtADu0n+dagh72qg8K/AN1U94Wf9kryw7WU1nCOIxBuIkzGVy
         AqVjYPyq243Z6pWtYVohijkrblPoQzvGVr8G8AoEmfmS2HQ7tIFSyvvGGGueyZo65hEy
         uAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoHr8lruXoTODdZ/3ftu6AEKExytx/3sK8QukZl/o1I=;
        b=bf6GsYHS31EDTMgsiF6uu1JQyD+57PQY9TyDnq2gu1RiQ+Z15Iv06zHrE9zxnyCxYT
         2/V3ySi8L2feo1WGRvwVUNSyjAM9LlSnnPx87V1dE+6r2GfcnobP8IL68vPWjhbPXS9D
         O/nGWXyKQKuYmqVmIrzvYQvRggzXknaqFn8bZ3HAjUH9CmYJGoFv6xQPhwDcmzCM1cCr
         8rtEiwzu/A0Qwe2W7Bk+/LUC7PP5EqaCwqlJrq3GiIQEEYUAyVweuYGN/J/CFnw+xbdh
         Z8gONM1fQqsxBI0JZNqOP+LkwnPoCI4upeQ1zKkn7xLOYRKC9kKYzZSlSaeu4/BCt6jY
         5iig==
X-Gm-Message-State: AA+aEWalu3fBtNK6BKUdxT6815KLgvYCUs5umHnNrRGOiCmHzN/5Tt0P
        rgOanRBYV3HyX9EDBLlPP6ftj5sJ+29e+ABojT5dV5SY/ws=
X-Google-Smtp-Source: AFSGD/XFTzxkLtS0QsruB925aVlFegp6A+wxn71NCFDzuUCQN7qKSL60ZDD3iswtZcNme9E2fJCBEuMY1yYmly7ao5o=
X-Received: by 2002:aed:2d26:: with SMTP id h35mr26176501qtd.373.1544063851054;
 Wed, 05 Dec 2018 18:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20181206010914.21964-1-wen.yang99@zte.com.cn>
In-Reply-To: <20181206010914.21964-1-wen.yang99@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Dec 2018 04:37:18 +0200
Message-ID: <CAHp75Ve-nZsyvHJcVJxb7wfk=0NDw7mwGdoZwh+VD6nnJpuNJg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_ips: Remove unnecessary NULL check
 before debugfs_remove_recursive
To:     wen.yang99@zte.com.cn
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhong.weidong@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 3:09 AM Wen Yang <wen.yang99@zte.com.cn> wrote:
>
> debugfs_remove_recursive() accepts a NULL parameter and returns
> immediately, there's no need for a NULL check in the caller.
>
> This issue was detected with the help of Coccinelle.
>

Thank you, similar patch is already in my queue.

> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> CC: Darren Hart <dvhart@infradead.org>
> CC: Andy Shevchenko <andy@infradead.org>
> CC: platform-driver-x86@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/platform/x86/intel_ips.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
> index 225638a1b09e..f8175b972537 100644
> --- a/drivers/platform/x86/intel_ips.c
> +++ b/drivers/platform/x86/intel_ips.c
> @@ -1300,9 +1300,7 @@ static const struct file_operations ips_debugfs_ops = {
>
>  static void ips_debugfs_cleanup(struct ips_driver *ips)
>  {
> -       if (ips->debug_root)
> -               debugfs_remove_recursive(ips->debug_root);
> -       return;
> +       debugfs_remove_recursive(ips->debug_root);
>  }
>
>  static void ips_debugfs_init(struct ips_driver *ips)
> --
> 2.19.1
>


-- 
With Best Regards,
Andy Shevchenko
