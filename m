Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8C2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3011F23C40
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3011F23C40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932404AbeGCOXk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:23:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:44869 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932133AbeGCOXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:23:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w63ENKjQ032219;
        Tue, 3 Jul 2018 09:23:21 -0500
Message-ID: <fb51cbf8adfe2b50ce2b3fe0e6851ef5982d12db.camel@kernel.crashing.org>
Subject: Re: [PATCH -next] fsi/sbefifo: Add dependency on OF_ADDRESS
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 04 Jul 2018 00:23:20 +1000
In-Reply-To: <1530625429-5506-1-git-send-email-linux@roeck-us.net>
References: <1530625429-5506-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 06:43 -0700, Guenter Roeck wrote:
> The driver calls of_platform_device_create() which is only available
> if OF_ADDRESS is enabled. When building sparc64 images, this results
> in
> 
> ERROR: "of_platform_device_create" [drivers/fsi/fsi-sbefifo.ko] undefined!
> 
> Fixes: 9f4a8a2d7f9d ("fsi/sbefifo: Add driver for the SBE FIFO")
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks Guenter ! I'll include this into the fsi tree.

(I was wondering what that kbuild report on sparc64 was about... I must
have misread the code, I didn't realize of_platform_device_create
wasn't under CONFIG_OF alone).

Cheers,
Ben.

> ---
>  drivers/fsi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
> index 24f84a96b8b9..9c08f467a7bb 100644
> --- a/drivers/fsi/Kconfig
> +++ b/drivers/fsi/Kconfig
> @@ -34,6 +34,7 @@ config FSI_SCOM
>  
>  config FSI_SBEFIFO
>  	tristate "SBEFIFO FSI client device driver"
> +	depends on OF_ADDRESS
>  	---help---
>  	This option enables an FSI based SBEFIFO device driver. The SBEFIFO is
>  	a pipe-like FSI device for communicating with the self boot engine
