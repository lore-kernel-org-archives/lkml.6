Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645CBC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7D42087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqeb2kBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7D42087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeJLTvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:51:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38193 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbeJLTvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:51:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id q19-v6so2789227pll.5;
        Fri, 12 Oct 2018 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KHlA4gPIBa6fmT8DwOXNseW2vfPOIwsQ7KcH5w1G9B0=;
        b=Mqeb2kBQ1xA7FD/MQJJo5MWaRIQOWs6TCP11BNumaO9++Yi0vVid2F3Ey5UJn4t/ee
         EN/XUcYhPXrnkBUXYVVLbl/P7OECagrAIkhT97G5F4rK2s0YpYZbi/LlKJUUC8B9ZBYx
         6URhJ0ZD00uZn7wPiL2po90PjXamblHv/E+EllHwHfN2dgIA37Z5/aOQL4d+J50pg8XD
         zA1WM/pzvVGXeFKgkoX3C2tv2CqyPd9gmaXv0XDAb6HBXuoWqmB6bk2W3XmpDIrox+dK
         fZMHLRItnqPqL9Eq7qERTmgweBxlFa94gHQSq/W+h1EZgj98rlls59YPnrdSMu2GHJw5
         W8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KHlA4gPIBa6fmT8DwOXNseW2vfPOIwsQ7KcH5w1G9B0=;
        b=S2wFDD/6VEwcZibtTvLaWKNxY/w6Dhn2alnlmQUsG8B4uUYdeDRb4U37JGKWHZ/MaN
         gBLLIsVoJ8nGzBfrlo0wSHxY5vzAvM/KN1WCVqZ+X1hwSz4CsOlwKPe6dgAFYJnZVv+W
         4kEXvYB5ZbxhsiCt03jB/H6hj0/cZkDMMVCQs4RXP+KDf/fCmHfVpNSYuxC0yzqf3vMm
         FT0tsgL1HULnAm3m70i1j8nKUb5sc7kH/G6X5kGQOg/tJajpm16SxcLegWrsI7QUi45k
         QTlUYpEZUuyLN0/ZZCZ6JLnSLBl44J+79FsB34Izd/+X/BBNr+yqZ5J25VQzIjU5Cp3M
         9drw==
X-Gm-Message-State: ABuFfohJeHxCGA+DHaMQKgozntKaM5ruenPssHiy0dgNZ2fS5YF8pfhK
        +XrgGnJXTVjiHxTzZ8cbFUzuZUQ4
X-Google-Smtp-Source: ACcGV62+WL34ViPYSviqmZU73yUvPcNXDpKwgWfe/xiHcvyoT2tdA1fFxcYCVftbRxPosMsI4Fxryg==
X-Received: by 2002:a17:902:16a4:: with SMTP id h33-v6mr5630259plh.3.1539346759660;
        Fri, 12 Oct 2018 05:19:19 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h19-v6sm3798367pfk.71.2018.10.12.05.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 05:19:18 -0700 (PDT)
Subject: Re: [PATCH 3.18 000/120] 3.18.124-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181011152549.500488630@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9b2c52e4-56ce-37a3-b515-a6ff831fe17e@roeck-us.net>
Date:   Fri, 12 Oct 2018 05:19:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 08:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.124 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 13 15:25:29 UTC 2018.
> Anything received after that time might be too late.
> 

[preliminary]

arm:allmodconfig:

drivers/mtd/spi-nor/fsl-quadspi.c: In function 'fsl_qspi_init_lut':
drivers/mtd/spi-nor/fsl-quadspi.c:170:5: error: 'LUT_0' undeclared

Guenter
