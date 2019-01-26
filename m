Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70398C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E9F21872
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUbm1RMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfAZR32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:29:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44164 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfAZR32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 12:29:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so10874807lji.11;
        Sat, 26 Jan 2019 09:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ts1w3T54HtsmywScM6GQ009Eclo9K7q1iILIsmRfRSY=;
        b=nUbm1RMZ8qlMl5qX9oBJWNmNu6/LRa2R+UHsAFurT8v634DLiRfhOseLYCMRpMJ3Lg
         qcPVThFKuWPY8iwE0kSM8L7ZSMmo0oPCJy3tpfWbQlLmaqozY8H6/0U5tKwq9XpgZ0fi
         msF6TQo0peSZS45jfyNXL6G1sqFMZzgEPE4F9qDEmXAiAc3lOB4tRNO+9q2eluKPGOjB
         GxxmhKICQzCgtq2bF5WGazCLKT7/nIXRWqC3CsizNyHpoU76fJDLKbo9QtG7YrszShJ2
         Izpa/Dc/uFGVnHq4fNEMJjZAtEimpPccqnEU7IP9qGd8hoXLUq4fdRhEbWB9lqgAFaxG
         Wnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ts1w3T54HtsmywScM6GQ009Eclo9K7q1iILIsmRfRSY=;
        b=W9au2tFCkur+Sef+XUJH01TQv4PQMMqcAR6qLeqmixDcS/UV8g+uWFgtKC/GPEUwkT
         KRmt4Slxk3YHxqKRee5pfauAexlCGtOrMuTBz7i1WG5YcqI64xKUaFsUfJlMiu3noFx+
         mIkpEjfLReJ1TX+l9QMRdMWPH4Ct7lHSYx5m1uk6mvUXzWMY/2x/sw/VKzCiFmjx7QMi
         QsbtlmBt8oQz5XHmPpXjhfKrpTQuvrK2Zd8DW2RCdPp1sql5n7kg1xUnSpc3hLfbhBAW
         GDHgoEU1zl3A/Sa4vH1l3TbNNqc5HqKBTmcPJUvFaXZlMa42x+VDK1ToUv3RiVuU8l0H
         LauA==
X-Gm-Message-State: AJcUukepl9oXGlYRP6F8hwds+Z0buJh3goF3qLb08FIBq6LkO3hjgBm3
        v8VwW7h9ud+dNxPj64O4L03SzCEu
X-Google-Smtp-Source: ALg8bN5FDaJek2Pmt91DguS8QiqyjTWHbuYwgnCVXScafwHf/H5yiI4DcZxXqxSGYzBgRKIz838QHg==
X-Received: by 2002:a2e:8596:: with SMTP id b22-v6mr12412845lji.122.1548523766125;
        Sat, 26 Jan 2019 09:29:26 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id t18sm2132068lft.93.2019.01.26.09.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 09:29:25 -0800 (PST)
Subject: Re: [PATCH V3 1/3] i2c: tegra: Sort all the include headers
 alphabetically
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <df091b4b-58a1-13ce-2041-0557759c6d8e@gmail.com>
Date:   Sat, 26 Jan 2019 20:29:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.01.2019 6:57, Sowjanya Komatineni пишет:
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> -#include <linux/io.h>
> +#include <linux/init.h>
>  #include <linux/interrupt.h>
> -#include <linux/delay.h>
> -#include <linux/slab.h>
> -#include <linux/of_device.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/reset.h>
> +#include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/iopoll.h>
> -
> -#include <asm/unaligned.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>

<linux/slab.h> isn't needed too.

