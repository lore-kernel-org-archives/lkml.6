Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B1CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9491120672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YDb+iCCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9491120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeLJVRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:17:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36214 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeLJVRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:17:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so6006483pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=XDQ09Tp/Ax+gyJb/FUcEX9STCMsKssGuHHluuKTb8xk=;
        b=YDb+iCCMOpyJg6K5ypWyW6fFU+ACcQ12siYXOoViImv1iA4RWCXpGPTO9mQYTNzFwt
         ZGbJFnc5uTGa9A9vhNGKMaaf+mEIA5LkAZq5fOfkiVPHcK3MTOXEKOCuQoCocFpmUfi5
         R28wd/UKtnGXboT8zT06TOp1QTOyABF2oUiJXx0UB7DRro+IIUGj4ZcPITJAF5EBlR+v
         U1OvL2romgz4Hi74sjNJG1ATXYOuYGfmqlnhp0/brUGcxyR3HFF23bFLzPHe9xFEv14P
         w6XkO5ZSJEhWb3foeno1uH3xzsaAIBT52KDN33dSWDdD2/7RU8dhSsKckpOLnen/ns0F
         RyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XDQ09Tp/Ax+gyJb/FUcEX9STCMsKssGuHHluuKTb8xk=;
        b=q6sf5HjrtE1EEZ4URP15046SRLegIEuEAm2UdF/E/4LWp685j1hsKIPVYAl7KJlR9X
         FY70DmS/8+ykVDHjNjxjsi/JBtewwJJEITjwucoI4rnreEHQ0vRL7LEm1kG57UzYB9dI
         rGa3rnIv+eOqIOjd/f9Fd6TgXKZ3y0jciiN4xvKIRIbNmGNpZO8d89rIqC6fSUDc7hdl
         2jghNssWhe/+CCDif/d3cLfnQyVeU7NWouBFCF6IHfmh71YlXXiPU2Dkiq8OXLK6FE8Q
         o2ReQdwqCt1TIjXOunwnejf+chLjcKW99+wWXc3lC9l2w3VKpqKOEth9Frp4e51Of8kw
         74uA==
X-Gm-Message-State: AA+aEWapnv+0ird3fX1Wv73x+3N3rmxzOwt5BIB2vFV25SZog8stjsiB
        UbE+3cWiFu+G/TenY2/dg5A4aA==
X-Google-Smtp-Source: AFSGD/XUfXCN2UcMXzZd1ccHNqV1PJxM1JY/M9O0lpkrnf8oOWsl/OZdFbintbLFty4K6MIZd4m2Sg==
X-Received: by 2002:a62:8dd9:: with SMTP id p86mr13654965pfk.143.1544476631178;
        Mon, 10 Dec 2018 13:17:11 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id f67sm17436997pfc.141.2018.12.10.13.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 13:17:10 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: add driver/soc/amlogic/ to amlogic list
In-Reply-To: <1544471155-26661-1-git-send-email-clabbe@baylibre.com>
References: <1544471155-26661-1-git-send-email-clabbe@baylibre.com>
Date:   Mon, 10 Dec 2018 13:17:10 -0800
Message-ID: <7hva41ulnt.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corentin Labbe <clabbe@baylibre.com> writes:

> While sending a patch for drivers/soc/amlogic/Kconfig, I saw that getmaintainer.pl give nobody for it.
> This patchs adds drivers/soc/amlogic/ to amlogic maintainers.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

nit: in Subject, I did a s/driver/drivers/

now queued for v4.21 (branch soc)

Kevin
