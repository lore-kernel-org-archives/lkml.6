Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B99C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF800208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF800208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756314AbeFOSHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:07:03 -0400
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:58648 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752703AbeFOSHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:07:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 88346180F5D3F;
        Fri, 15 Jun 2018 18:07:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spoon69_2fa75c54c20b
X-Filterd-Recvd-Size: 1675
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Jun 2018 18:07:00 +0000 (UTC)
Message-ID: <b7ace76dba30099151e645aa7496c84dff18b29a.camel@perches.com>
Subject: Re: [PATCH] RFC: bus: fix semicolon.cocci warnings
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Jun 2018 11:06:59 -0700
In-Reply-To: <alpine.DEB.2.20.1806151958100.14023@hadrien>
References: <alpine.DEB.2.20.1806151958100.14023@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-15 at 19:59 +0200, Julia Lawall wrote:
> From: kbuild test robot <fengguang.wu@intel.com>
> 
>  Remove unneeded semicolon.
[]
> +++ b/drivers/bus/96boards-mezzanines/96boards-secure96.c
> @@ -223,7 +223,7 @@ out_unreg_leds:
>  	platform_device_unregister(sec->leds_device);
>  	for (i = 0; i < ARRAY_SIZE(ledinfos); i++) {
>  		mezzanine_ls_put_gpiod(ls, sec->secure96_leds[i].gpiod);
> -	};
> +	}
>  	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(secure96_populate);
> @@ -244,6 +244,6 @@ void secure96_depopulate(void *data)
>  	platform_device_unregister(sec->leds_device);
>  	for (i = 0; i < ARRAY_SIZE(ledinfos); i++) {
>  		mezzanine_ls_put_gpiod(sec->ls, sec->secure96_leds[i].gpiod);
> -	};
> +	}
>  }
>  EXPORT_SYMBOL_GPL(secure96_depopulate);

While these are clearly correct, perhaps it would
be better to remove the braces too.
