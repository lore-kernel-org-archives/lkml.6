Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E61C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89A8206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhDXFYpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89A8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeLAIuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:50:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33650 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAIuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:50:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so6626408wrr.0;
        Fri, 30 Nov 2018 13:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0sOQ8FnLAWNEUWL+b60qfl51wsA948E2vDDpCS5b+o=;
        b=dhDXFYpR4G2NqsE7jBGJm7bCA7GKrjaliw27LybM6IylnGngne/3KgjmjIp2S+nWr6
         8cX7bcfkm3HcU+A7+bR6PShHRn6+/aDLtvwXaWbD2LkV6njbb/Kv75nCZY5FXqfJD716
         WTQLll5AXbyDJXlPVemwjqbAfi+Ooj0RlQi69iBERi2fcUE1OCmo+Na4vj88+rU0Z1je
         pMyLVQT1zEdCPwjl3YF9f+ltIbuycpetEAqxHYNgUukb1d4NYUXBt3aWaUjZM7RFEbn7
         DeRnL7ts3iJU/AKSp8BFc/8f/pemZrQ8DEwQbSULuT6qbgSKp28lRN/zUSL6CLpClP5Q
         cHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=T0sOQ8FnLAWNEUWL+b60qfl51wsA948E2vDDpCS5b+o=;
        b=nbXMRC/Yb6lr7JPmt1IY/Kg25dWd49sRxXQvOIunV3j/Gj1RSqP90Puo/MQKFtvLzB
         7+sEmwDYGL6p+C6aEK5yGd6gMy4cFxblppyhqPneIki73BSBuhK3fnw+VijrBGVerum+
         gLHCudQ/hkM1Jy9GZKNryHrNGMhrkAAAqh4O3+zK/tGtv+R6P5qwCgPP/PFGqRcniHKM
         fwRUtwGXxc4nOVCQjt41yfuVtWh6aT8nQphd13BQYaPkSKe7Z5bxj2IisHkcHPiA51ld
         JgBW2muoLpup/RyOZknrox+ktqkJH4jkUB+XRnki3L8q7onzn1C4K6pPnJ9nyxntY5aD
         6BUg==
X-Gm-Message-State: AA+aEWZHR3h3UqJCzUuZvAnfnYn3boYe/3EdQMynXrPMFwKGItU1F05y
        QwqqUedL5tEOFOsx62OGnQ==
X-Google-Smtp-Source: AFSGD/WwksaPOdvH7HO7dP9KVVS3mFjLUGy3S5o9U+7Z1JKTGiK7ENxzF37EnDHh5mjNrrctaibUkQ==
X-Received: by 2002:a5d:6450:: with SMTP id d16mr6317149wrw.64.1543613991220;
        Fri, 30 Nov 2018 13:39:51 -0800 (PST)
Received: from tpdeb.localnet ([95.87.234.74])
        by smtp.gmail.com with ESMTPSA id l2sm588300wma.33.2018.11.30.13.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 13:39:50 -0800 (PST)
From:   Dimitar Dimitrov <dinuxbg@gmail.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, tony@atomide.com,
        robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com,
        jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 04/16] remoteproc/pru: Add PRU remoteproc driver
Date:   Fri, 30 Nov 2018 23:39:48 +0200
Message-ID: <308735274.C9ZyqtqOL8@tpdeb>
User-Agent: KMail/5.2.3 (Linux/4.9.0-8-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <1543218769-5507-5-git-send-email-rogerq@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com> <1543218769-5507-5-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 12/26/2018, 9:52:37 EET Roger Quadros wrote:
> +/*
> + * Convert PRU device address (instruction space) to kernel virtual address
> + *
> + * A PRU does not have an unified address space. Each PRU has its very own
> + * private Instruction RAM, and its device address is identical to that of
> + * its primary Data RAM device address.
> + */
> +static void *pru_i_da_to_va(struct pru_rproc *pru, u32 da, int len)
> +{
> +       u32 offset;
> +       void *va = NULL;
> +
> +       if (len <= 0)
> +               return NULL;

Could you please clear the upper 4 bits the of IRAM device address, in order 
to support binutils ELF images? Here is an example line to add here:

+       /* GNU binutils do not support multiple address spaces. The 
+        * default linker script from the official GNU pru-ld places 
+        * IRAM at an arbitrary high offset, in order to differentiate it 
+        * from DRAM. Hence we need to strip the artificial offset 
+        * from the IRAM address. 
+        */ 
+       da &= ~0xf0000000u; 
+


> +
> +       if (da >= pru->iram_da &&
> +           da + len <= pru->iram_da + pru->mem_regions[PRU_MEM_IRAM].size { 
> +               offset = da - pru->iram_da;
> +               va = (__force void *)(pru->mem_regions[PRU_MEM_IRAM].va +
> +                                     offset);
> +       }
> +
> +       return va;
> +}


