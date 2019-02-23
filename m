Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF11C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77B220675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="DliSCpHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfBWSoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 13:44:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37112 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfBWSoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 13:44:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id z196so3379627lff.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 10:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8d2ksKb0t48p28IFWm7MH/ppMCXWwhhG5AAHRnK8znU=;
        b=DliSCpHVfit7CLu8Cq67dYqtBy93yokwUJ2RmSFkzMETYURa0PMyQikMQQ449CY57j
         XIG9hfUxxIFS5DCY8gUIMf6Y8XZs1A84HZOhRR0NYgg/r3C1+6/55Ey6xD/afr4qcpdX
         AzbHtipFtDntlZsjFmjs87Di5TLo8PZVq+R9rconCaKzaxCYb4EANTuuicXZqS+mbXSO
         fwqHycLkLcIqefEbEg9m12SgtDXfNtFgBcjRQ2yyKP2p/hSxVMiKgyYW9JToCR/5q+kc
         OeTUCWwjfGQapL0g54KulXBw/oEHh746/W9Y4Im3bbN1gj6NSsqxlCM91BA5wTYuBh/9
         hdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8d2ksKb0t48p28IFWm7MH/ppMCXWwhhG5AAHRnK8znU=;
        b=jLmFv7lm8dZxZh2Uajd3KOrJCDYVcyrDL+PZ3hF2ovmjqSlsj8D3iQ/enktEy2PxZg
         0zJLis4/c0+KZ8y7LjVoKxdny7e3o4NXitbjEs1WENDUlydinSuPKeDEfGwoDsoAUOsc
         puQrX94slksmtV5uj77il/Rj2HL2Y++actnFyhixxkiXv+UYAc04qzgmxHaJd+dTz+s8
         OMD6OKJ1uormxoKO7j4I4l9P6MVTE3a/zLuoFvLFKuAfiXRtimbthcWI8/3j9yFq4xo4
         83sE/PC9YYKFyRP/2cJ/GpFrfJODxVP375HDOoj8PLuV+AzpVExXXnVQji6quZnnNz7s
         LelA==
X-Gm-Message-State: AHQUAuYJUUj06sqHD9aBDNXswA/hCj+E45MQCwmT6Xm1uGScCmGKP/0O
        VZQwHZ+gRU9dYYoGjCFAyAqGrA==
X-Google-Smtp-Source: AHgI3IYNjELnXE7aCiWX8XQsNopW4gQTGBnWF28Fqg7i2yzaSbL0HFE3irGg8JQLJP7iIM90aG5vCg==
X-Received: by 2002:a19:f704:: with SMTP id z4mr6052902lfe.10.1550947453439;
        Sat, 23 Feb 2019 10:44:13 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.83.184])
        by smtp.gmail.com with ESMTPSA id f141sm1594305lfe.64.2019.02.23.10.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 10:44:12 -0800 (PST)
Subject: Re: [RFC PATCH 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
To:     "Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>)" 
        <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        tudor.ambarus@microchip.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nsekhar@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-2-vigneshr@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <abff6b0f-af53-b712-c0fd-fe7c9fd83a56@cogentembedded.com>
Date:   Sat, 23 Feb 2019 21:44:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190219063607.29949-2-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:

> HyperFlash devices are compliant with CFI AMD/Fujitsu Extended Command
> Set(0x0002) for flash operations, therefore drivers/mtd/chips/cfi_cmdset_0002.c
> can be use as is. But these devices do not support DQ polling method of
> determining chip ready/good status. These flashes provide Status
> Register whose bits can be polled to know status of flash operation.
> 
> Cypress HyperFlash datasheet here[1], talks about CFI Amd/Fujitsu
> Extended Query version 1.5. Bit 0 of "Software Features supported" field
> of CFI Primary Vendor-Specific Extended Query table indicates
> presence/absence of status register and Bit 1 indicates whether or not
> DQ polling is supported. Using these bits, its possible to determine
> whether flash supports DQ polling or need to use Status Register.
> 
> Add support for polling status register to know device ready/status of
> erase/write operations when DQ polling is not supported.
> 
> [1] https://www.cypress.com/file/213346/download
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

   Forgot about one thing: tags like S-o-b: need your full name,
cfr. Documentation/process/5.Posting.rst...

[...]

MBR, Sergei
