Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A393CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFEB20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547825556;
	bh=HrhTVSLMX3w2LVPon8UoTXBjyruR8yIHMnaUErd9dQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HXpJpdv6XAcDdsOoZSn3ekiN/hLJNPoR04gsqy6kho2J0E2duOm2EEfUEyDt/y52M
	 MSPRdcxXY/Y/gkjZvvUGXtfpCTaqG244FGBAZUjpzsC0PGJS56QMRMwjGXaLd37r2N
	 cPvhBm3S4h1pPd7ckaUA28xRxFlDrZJJ05heFKs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfARPce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:32:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbfARPce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:32:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6386820850;
        Fri, 18 Jan 2019 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547825553;
        bh=HrhTVSLMX3w2LVPon8UoTXBjyruR8yIHMnaUErd9dQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zVfpaHJNGqs3/dk83lkVY6FmVRxSIco88EqNV84EzsPC5yEWKvc1gS7AupVMQ7fIp
         owhbbvWD8h5jfW6W6+W1nqgluS2PKmVdpNiBeE7qQH+shIDcRKDV0+fbO96ah32RWh
         8OOuQFFH4mI5bBkX4+lhvEZU3myaYfEtBboPPYHY=
Date:   Fri, 18 Jan 2019 16:32:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V5 1/3]  misc/pvpanic: return 0 for empty body
 register function
Message-ID: <20190118153231.GA27443@kroah.com>
References: <1545282888-38059-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545282888-38059-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 01:14:46PM +0800, Peng Hao wrote:
> Return 0 for empty body register function normally.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
> v4 --> v5 : resolve kbuild issue: handle all typo "drvier/driver" 
>             in funtion name. 
> 
> v3 --> v4 : use pcim* function instead of pci* function.
>             handle typo "drvier/driver" in funtion name. 
> 
> v2 --> v3 : resolve kbuild issue : a uninitialized variable in some path.
> 
> v2 --> v1 : resolve kbuild issue : arch=sh don't support pci, adjust
>             CONFIG_PCI macro. 
> 
> v1 : QEMU community requires additional PCI devices to simulate PVPANIC devices
> so that some architectures can not occupy precious less than 4G of memory 
> space.
> 
>  drivers/misc/pvpanic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index 3150dc2..f84ed30 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -125,7 +125,7 @@ static void pvpanic_unregister_acpi_driver(void)
>  #else
>  static int pvpanic_register_acpi_driver(void)
>  {
> -	return -ENODEV;
> +	return 0;

No, you want -ENODEV as this can only happen if acpi is enabled, and you
are on an kernel without acpi.

But, that can not happen, as if CONFIG_ACPI is not set, then
acpi_disabled is always set to 1, and then this can never be called.

So I don't see why this needs to be changed at all.

thanks,

greg k-h
