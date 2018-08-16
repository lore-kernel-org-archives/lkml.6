Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81317C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9842148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7U1cSZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9842148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbeHPMEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:04:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38618 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbeHPMEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:04:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id w11-v6so891529wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 02:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cZnoUTDbb0O87OvXx1NSJ3OBYrRm1QrYgqMNawlGscY=;
        b=b7U1cSZIIEky6pBMx4qejN+lWykIzqY0uqmfNiGKRjsv0NZXZ3meqbC8qMVetxw4ju
         1Z9o9Eq/UrBtQ+lFUBVbfuUg7qgVnLcg+AmPyhKVVRtxdAhrv+YB1/4aWIZLe/CyKPxe
         ukYKxT7Az3H9qSoCqBZBamQGhlksiiGdOtMVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cZnoUTDbb0O87OvXx1NSJ3OBYrRm1QrYgqMNawlGscY=;
        b=Vt+rZ+s1eHpObiSm11UI2PkW3ZYVSRl1NJae1naaj9XF6gIWUS3805rKGyRjMz+H7x
         Z7hPJk9FVqTYMWMF6nLaLwIcIEuCJNrwd+W4BkA6VeI8oSk2bpURKuvnq9EpG/6GEz41
         FslK5I/PPyQAc0UK54lDVR3ZCj6wNofZXYKMbTHPalLcCd3183UaFXGxOFQDlgumUZgj
         Alvnu3oiRpOXHv6846CXOMoBiabNTQ4FKgjtlX5MTFLaFNoyGpAvDngu2Uk1NbPNsLeV
         /p5nINgbyS/WbnV7+pEihFtQPPMMr83uUM75/A/Lwn++JbDpzw916aVoyPRPxqCow0Sb
         G8+Q==
X-Gm-Message-State: AOUpUlEs6vhIxzqRVEErr9JS/ZBwo/mJJzQgJ+o8Bq9V4QDkNFtTcYi0
        eYCm9kGyjD+eFbXv/9zVXT8GKCEmwN8=
X-Google-Smtp-Source: AA+uWPwunYK9w7NgCn33sLzvx0vfgWMWNSS/8Gxe91U6fjBD2SZzftTig3v3q0BXt4NWHKuTJZPxhQ==
X-Received: by 2002:adf:a644:: with SMTP id k62-v6mr622569wrc.78.1534410424026;
        Thu, 16 Aug 2018 02:07:04 -0700 (PDT)
Received: from dell ([2.31.163.71])
        by smtp.gmail.com with ESMTPSA id 200-v6sm1322452wmv.6.2018.08.16.02.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 02:07:03 -0700 (PDT)
Date:   Thu, 16 Aug 2018 10:07:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sm501: Set coherent_dma_mask when creating
 subdevices
Message-ID: <20180816090701.GE10054@dell>
References: <1533355191-26512-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1533355191-26512-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2018, Guenter Roeck wrote:

> Instantiating the sm501 OHCI subdevice results in a kernel warning.
> 
> sm501-usb sm501-usb: SM501 OHCI
> sm501-usb sm501-usb: new USB bus registered, assigned bus number 1
> WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516
> ohci_init+0x194/0x2d8
> Modules linked in:
> 
> CPU: 0 PID: 1 Comm: swapper Tainted: G        W
> 4.18.0-rc7-00178-g0b5b1f9a78b5 #1
> PC is at ohci_init+0x194/0x2d8
> PR is at ohci_init+0x168/0x2d8
> PC  : 8c27844c SP  : 8f81dd94 SR  : 40008001
> TEA : 29613060
> R0  : 00000000 R1  : 00000000 R2  : 00000000 R3  : 00000202
> R4  : 8fa98b88 R5  : 8c277e68 R6  : 00000000 R7  : 00000000
> R8  : 8f965814 R9  : 8c388100 R10 : 8fa98800 R11 : 8fa98928
> R12 : 8c48302c R13 : 8fa98920 R14 : 8c48302c
> MACH: 00000096 MACL: 0000017c GBR : 00000000 PR  : 8c278420
> 
> Call trace:
>  [<(ptrval)>] usb_add_hcd+0x1e8/0x6ec
>  [<(ptrval)>] _dev_info+0x0/0x54
>  [<(ptrval)>] arch_local_save_flags+0x0/0x8
>  [<(ptrval)>] arch_local_irq_restore+0x0/0x24
>  [<(ptrval)>] ohci_hcd_sm501_drv_probe+0x114/0x2d8
> ...
> 
> Initialize coherent_dma_mask when creating SM501 subdevices to fix
> the problem.
> 
> Fixes: b6d6454fdb66f ("mfd: SM501 core driver")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/mfd/sm501.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
