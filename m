Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C09C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E17E20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPGTLUW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E17E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeIZOCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:02:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45641 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeIZOCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:02:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id m16so9427458wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gN8jvDbRPiopPPXZoi9ZR7cxo31h+1bXes5HxQIcc/I=;
        b=iPGTLUW5Wk95Y/5vnSsZx1Xypwlg83sLQaY86iEnisGHLJW49UPLV5j8/N2rEjTaSZ
         XkU9/8PmNh3YRHYdjawF/zFcfXmZO4TUJuek1wa7OFMWqXRgGqCNop0EVJF4B6D6qYNZ
         M4H68rRuVPAJ2wS3iV/KH9p+LqgLnAFZAA3MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gN8jvDbRPiopPPXZoi9ZR7cxo31h+1bXes5HxQIcc/I=;
        b=nE7eayqnz2QpPzRII6rQ4/VfKKCXSBwrROXsn7x/Hvm/V0yk+USwZ9qsPiU++iaBhr
         Rz9bdGGTnIVO/7PamkNYjBdEVdURv1iEy5WETjrzlKbjOIPD5wFOnxuNoUpEuTLUriSi
         KDHQeIYIfUDrhNaVx2BHkZVY3EGj6rFZVFZ/tovZX0Z/Fcfb8BqalicDuAvikr4r20ZK
         zIF0GWUF++aAJVc4qmvL4IDrq0PpbFiLMbot8TCtlB8c3rxeEuxCvMeALq0n18ageXEp
         4OKERvp/OsWkBVN6+UxQEPkzOqrsSXZBiAvvN1H+PA8LF7qb9Sd3w0qKZOJMRDDPhFE7
         cRhA==
X-Gm-Message-State: ABuFfogCVjYbbtQdbOQgCEXFC+4MceHhiWTmu6P5L5latPlmdty2hyCf
        aY/wt8oMq8BGvfUWFCZOgZTKZw==
X-Google-Smtp-Source: ACcGV63wnEVofYKm/z7EWJYVdMguWTI4DyzM0C2/LXS2eeHP7eJsjVBHyGZNp3DxpnbgHcfwks5yyg==
X-Received: by 2002:a05:6000:1291:: with SMTP id f17mr3861315wrx.215.1537948271984;
        Wed, 26 Sep 2018 00:51:11 -0700 (PDT)
Received: from [192.168.27.123] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id j133-v6sm7173268wmd.12.2018.09.26.00.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 00:51:11 -0700 (PDT)
Subject: Re: [PATCH v9 3/5] venus: firmware: register separate platform_device
 for firmware loader
To:     Vikash Garodia <vgarodia@codeaurora.org>,
        stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org
References: <1537314192-26892-1-git-send-email-vgarodia@codeaurora.org>
 <1537314192-26892-4-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <b1753857-70d9-c909-26b6-2b5ff3468bd9@linaro.org>
Date:   Wed, 26 Sep 2018 10:51:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537314192-26892-4-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 09/19/2018 02:43 AM, Vikash Garodia wrote:
> From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> 
> This registers a firmware platform_device and associate it with
> video-firmware DT subnode. Then calls dma configure to initialize
> dma and iommu.

Please replace the description with something like this:

This registers a firmware platform_device and associates it with
video-firmware DT subnode, by that way we are able to parse iommu
configuration.

> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c     | 14 +++++---
>  drivers/media/platform/qcom/venus/core.h     |  3 ++
>  drivers/media/platform/qcom/venus/firmware.c | 54 ++++++++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/firmware.h |  2 ++
>  4 files changed, 69 insertions(+), 4 deletions(-)
> 

-- 
regards,
Stan
