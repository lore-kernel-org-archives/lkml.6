Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D444C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376C120837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8SJymKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376C120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeLIOe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:34:56 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39437 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeLIOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:34:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so8068980otl.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 06:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7rY/0nb46pp/FAfdQSNBw+IP1tJlV9Urwj6W0rS+3VU=;
        b=W8SJymKR8wzUZHmt6VneN3iabkj3BUW2S6Z4UuXpePNROkI3DEp7/cgw5hTzuO11oD
         HXI8LbipMwfHLnZM1t0oecDFiHmBZWxCTtR1k/tiql0bs2FHwdvfOIMDgwkqpjY8zgWi
         +CZsFSts+pRm5g08OAxorZjjQMnxosCtvOHWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7rY/0nb46pp/FAfdQSNBw+IP1tJlV9Urwj6W0rS+3VU=;
        b=ROqz79w2SQ7r4cIICpCuMBRsFFmRz+8pM+Ip5S3LfgtijMzkL2V8c43MSsDg/LX0SY
         WpA2tuEMU/vjzqiQScaXtlIGwN2Qyr364HgqtmS8FLL1EMEBPCXuHQ4oL3uE1Nxb7LR+
         FuUsc05F+PRsDdjBrQpmNZNt5R5hM0N8elbcmNBWOjpdg2aKn1YRwVJrPahsMoeuaRbC
         h/lyI1GySiwE2M5I06YbJnImgaeGQ/fwx6OHLhy2J2LEHtrNIiwlvbf/vfkjKVs4A7DM
         yiasMbvcH/Gtz79zVgheeCsZ3QElIyzy/+UnfBbwy2hSHeRx3fuitb46IadK9K+Dw0Xj
         PlJg==
X-Gm-Message-State: AA+aEWa9xcWCszazxfpDtvU5fldyAfMyPv/Teg9mzVEUkc+zPMsDnVPN
        BJmVuKwk80/jyoqrPhjpNUMOTYdxjYE0ow==
X-Google-Smtp-Source: AFSGD/W4Vcts2PYofm1A2YqiibU9ClUXwfNPG+jqw6+cnYhNdPIBM8haWn0TiPK1C4bXklnG9HKDtw==
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr1204576otr.299.1544366095349;
        Sun, 09 Dec 2018 06:34:55 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
        by smtp.gmail.com with ESMTPSA id s13sm4431607otc.40.2018.12.09.06.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 06:34:54 -0800 (PST)
Subject: Re: [PATCH v6 01/13] arm64: add comments about EC exception levels
To:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave P Martin <dave.martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-2-kristina.martsenko@arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <73743377-b3d2-6f9f-654d-cbb00a7c70f9@linaro.org>
Date:   Sun, 9 Dec 2018 08:34:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-2-kristina.martsenko@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/18 12:39 PM, Kristina Martsenko wrote:
> To make it clear which exceptions can't be taken to EL1 or EL2, add
> comments next to the ESR_ELx_EC_* macro definitions.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>  arch/arm64/include/asm/esr.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
