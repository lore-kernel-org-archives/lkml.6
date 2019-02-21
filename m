Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AAAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA042083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550767670;
	bh=U834xFdsuICBP+MX4HOEI26M3OrFECZBAsPeqdvrMhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=poaVCnU5uOyAxaT1gkT6zwAnMqp0/41HSO7lL8As5cMdQyjLxyiSS+dP6OLo7Nvxb
	 zUZY+QtOV5zHb7rxGYjZUkNg2g0Y3twPU7EITFLZR4enr24O4Pb6HTI5nOiZ9Bm3kL
	 lpW41GAT2tyOwWMSdmBAq0XJpo3KtWdLqh+QlphM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfBUQrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfBUQrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:47:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 461142083E;
        Thu, 21 Feb 2019 16:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550767667;
        bh=U834xFdsuICBP+MX4HOEI26M3OrFECZBAsPeqdvrMhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pmr+R/8+KV7gbIdO2V4UXG3RYwCUy/y4XpfI6VHvfe60WrPJISlFGy4ys+OQTQtsA
         H6T4mvu6plTaNlzDMnE5WD+lAyqZwEbo7SbALAvQHAklHU/GU/2yttLQpqMEMAkz5F
         oEgB8LJr6fYVsAlf4AbiiyYNKkIWk41xywVGHDUs=
Date:   Thu, 21 Feb 2019 17:47:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] drivers: depend on HAS_IOMEM for
 devm_platform_ioremap_resource()
Message-ID: <20190221164744.GA12055@kroah.com>
References: <20190221162627.3476-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221162627.3476-1-brgl@bgdev.pl>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 05:26:27PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We only build devm_ioremap_resource() if HAS_IOMEM is selected, so this
> dependency must cascade down to devm_platform_ioremap_resource().
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/base/platform.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
