Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930B9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D3921720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="DVTWvLT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeLaVfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:35:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33428 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbeLaVe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:34:58 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so18874022lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6wuk01MYx/T22n1RmoV6mfsD4mjku4gy0h2Bo9Voas0=;
        b=DVTWvLT37ypW4gOCh6b4mVN/BkBu01d8Of67AUs6nF/MtEWBi/ZdxgbavSuiGdfe7D
         LJcw6fuqHmb16pDjdPDuJr4L2368GH27nXLlBGlm/6Fe8vpa26ceWBjx1ucBhP7gqJeJ
         4T7eLy/B0Zk1qPxp7e1eLjcuTjpSnGUA5o4EhdMfimXRsKM+ino20O0dPSqJxr1j7zmT
         0Vgi39ushQqzgqXHbWE1udaMhcPkqb8B4739dxpABLYSxQJpgIkFgUrX4lEjCDxhaQQn
         Kbeh3el435uNeXf9rMLfk6HSCIVBZYEbnCFbCGuEHkHqZYtXlmzJBxpL2+QGpd92yHXh
         SGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6wuk01MYx/T22n1RmoV6mfsD4mjku4gy0h2Bo9Voas0=;
        b=hl8w0lcMCKcJMhvOjX9alzHICeNURJzDD5rXNWkTA3qvrGteM1TNxTrMIR1bZCDXxs
         0bXCP7pRV7apXFWwEpjYY95sQxm3pdPZ1Ja2/hf+zmz7gRbYEKZb311OG+PWKG6I3M1p
         UOOXWZQAY+jdCNVLS6AeUuAnSDCcJsusWeIIqL3cxRCEKd7ae7RS48zo7syS9OeiyC1H
         jijDB7k/SVma9PjxVEHMrcXQpMmiQFl4X5fKg+KEtTltHpEo3fS8r/L84H+kUOdCrMcE
         g29JR5wwgks3xzKy3Ebkmu64N2k5ggdfejv7wk+lodfZ9Cj5FYsLasvPahaPWGv3vI9D
         P1mw==
X-Gm-Message-State: AA+aEWbFwYbNGDBBOtqLvMpUmyEWm6L1j8qkDTtD0KLUzf1afLGPmT2s
        r9Z+wJQyz4B2z4USGXPPzXPBNA==
X-Google-Smtp-Source: AFSGD/UM14oFPYEKwXDHhVLvqF6b0XwXj9MM+5NAxkGY00KskwvcJgxIQFdf0NaGsZ6qfhAM+iM2mg==
X-Received: by 2002:a19:789:: with SMTP id 131mr20383130lfh.11.1546292095582;
        Mon, 31 Dec 2018 13:34:55 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id e19-v6sm10416018ljf.67.2018.12.31.13.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Dec 2018 13:34:54 -0800 (PST)
Date:   Mon, 31 Dec 2018 13:13:42 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     arnd@arndb.de, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net
Subject: Re: [PATCH v7 00/11] Add initial RDA8810PL SoC and Orange Pi boards
 support
Message-ID: <20181231211342.ulg4jytermffqi34@localhost>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 08:32:27PM +0530, Manivannan Sadhasivam wrote:
> Hello Maintainers,
> 
> This patch series adds initial RDA8810PL SoC and Orange Pi boards (2G IoT and
> i96) support. RDA8810PL is an ARM Cortex A5 based SoC with Vivante's GC860
> GPU. The SoC has been added as a new ARM sub architecture with myself as the
> maintainer.
> 
> More information about the boards can be found in below links:
> 
> 1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
> 2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/
> 
> All patches are reviewed by the corresponding subsystem maintainers. The
> clocksource and irqchip patches are reviewed and merged while the serial
> driver got review from Greg but I'm not sure who will apply it.
> 
> So as per my discussion with Arnd, sending the individual patches instead
> of a Pull request so that the rest of the patches can go through the
> ARM SoC tree.
> 
> Please consider applying it.

Hi,

I've applied this series to our next/late branch. It's a branch we'll try to
get merged by the end of the merge window, but it's not a guarantee that we'll
be able to get it done. If not, the material will be moved to the next release
instead.


Thanks!


-Olof
