Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1F1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77126217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4z95qwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfBZOqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:46:50 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38347 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfBZOqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:46:50 -0500
Received: by mail-lf1-f65.google.com with SMTP id 131so622740lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CtY/Nl4X7NF+/KxU24SveJuHrM3pcpLR+KKZZ+2zku4=;
        b=U4z95qwhDcqVDPQ9TWCbkqAdPwnqHobXhzg/xTM2YASLdwUR/Dmg7fjeMlc6jNGrkY
         Fj3qYD+PCdqX657hKal3udwp4KnRxmkWlXvfUvqNH0S80XOhqpNAjrCXw6m2knxN3oPf
         A2PVqMIOZaYOv8q7863wI9ZOhL7JlmmaJwwDUmH9RYJrC9w/AxwxmjP8wN6fDPa/RvcN
         htC764XIg3qTIUHQNVzWOqiLedXM9Fc/zvYObV1GTY4IeDYZ98kG1VZS9e1FwC4S1vmm
         /ObM8JT93BjPYqlbjRhTSVtz2Kqzp3PW31x2zwMFIwE6LeTm+rq+i4h5fRhf1eQE1hH7
         K2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CtY/Nl4X7NF+/KxU24SveJuHrM3pcpLR+KKZZ+2zku4=;
        b=CfRzmNmBIs1q4v623+dqgz7zpueEYHg9RLe5u9VK1G1w0PphmsM/N/4fxc4UNt1yCy
         g1hTPicb3kZMWmuz38z2krA55EERfCHMq/c+5EcpUuAfOgXUi/3I+jdCDoAfFttIgy07
         JTV1SnBKkzustxSFMkO0X41euKlMQmI1cDTYUfaPgQR+u9Lcii375jbAEpcWv1+4hcpX
         TbGKG1bSYpySk/zcV/5c+P+ujaSxi9LaDW/pMKrxUZqk0KHRqnnIVnR+WUzwiAcjz66Q
         RTi1etE1KJoCIAQG3FBqqtHoR+ATGbH+8urb79UzuNblkrXhB3BegkE4/D3Qj/yJZY9/
         cxvA==
X-Gm-Message-State: AHQUAuYLNf2zkgoG9Gxeio6vRm903Urz/52BTRNoFy576syqD3RxLEtt
        ZJa0aJBRRTSZf0u7y8r9ioAmaVg1
X-Google-Smtp-Source: AHgI3Ia9CgEB9hKxVOp5aIab8u4PcYZoNdmGwdU71eBkKScqGhUySXlPEXwZc8lBhXdvY6p7fSmAcg==
X-Received: by 2002:a19:c795:: with SMTP id x143mr10653944lff.26.1551192407732;
        Tue, 26 Feb 2019 06:46:47 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id d26sm2918498ljc.15.2019.02.26.06.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:46:46 -0800 (PST)
Subject: Re: [PATCH v2] ARM: tegra: enforce PM requirement
To:     Sameer Pujar <spujar@nvidia.com>, linux@armlinux.org.uk,
        jhogan@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org
References: <1551169537-17548-1-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <86293ce9-fb0d-3412-df9a-0ff380ab2eb6@gmail.com>
Date:   Tue, 26 Feb 2019 17:46:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551169537-17548-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.02.2019 11:25, Sameer Pujar пишет:
> The requirement for this came while adding runtime PM support for HDA
> driver. There were concerns about driver explicitly handling !PM case.
> In general, drivers need to handle !PM case with work arounds for
> managing clocks and power explicitly, which is not really necessary
> when PM support on tegra is in good shape. In fact ARM 64-bit Tegra
> platforms enforce PM support and there is no reason why this cannot be
> done for 32-bit.
> 
> More details with regards to above can be found in following patch,
> http://patchwork.ozlabs.org/patch/1036645/

I think you meant this: https://patchwork.ozlabs.org/patch/1031007/
