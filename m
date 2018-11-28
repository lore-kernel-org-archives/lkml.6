Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97E5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFBC2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5jKs4i2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFBC2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeK2Ivl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:51:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34329 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2Ivl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:51:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so10836194pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 13:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B2sFRs0i8vXz6y0fhJandC/ey/yyg/GEQaJfZy9xWjs=;
        b=e5jKs4i2f2MW8/ZPoRuzlo1mSm7qxxfJ4mMrGo5dQR2ZH14yAML6SSIJunnBU6YKP7
         OerZJEZ+Z9xT81dMRgwWBsFCewGz0NpSJMK/yb98l1g/6VLXc5YITUOQPVamGysId3i0
         1uHNq9JBJ0DQUkj6siid974vq+Kb4Zc9yX1UzWdbkls6DxQTuAjJeCtIDvgbQ8XZIMbo
         wy9YHOjyRCmSB67O48nDnjEMb7/S06K01JczfTwwo4936xlGy1x4+t1yuaYpkYPnYUcV
         QsEstGeyZxNaFQxEBMruvzyiXGH8qSty/qabyoDXti6tZw0OjJ/9mkCP5WXaYW7L84KS
         KhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B2sFRs0i8vXz6y0fhJandC/ey/yyg/GEQaJfZy9xWjs=;
        b=YmPIWF8k/0VlHlaEKRfMJkQrOs8ddOZH9eC1G04ctjWpAbRckIieDSf5cUhHVl2A27
         F/8/r5q2a3bZRVo+lSHwETZgTAtah7JmTA24H4d5ExLJq98Fkq1ZqcZ2b4zUBc8Cy7y3
         Jx+mtMFns5R/76c8whJ0LYKwza8EO+HU0SIS3g5gn8f3jdwtnCP+ZX9M35/4i7L0hDmS
         kccmLdfwqtxxy9Q+xe1ooCG8i8F2lHG8CnBT8QoWLe/HRlgeUOfZck3ay1q8aSj+/zwy
         nUga+r5hgrY137+zd+9uVsWCqTN4WcNm2qd6XE51RaKyMd63d3H4NDYJj7sv4yOEgTA6
         By6Q==
X-Gm-Message-State: AA+aEWY48b3Yye1k9pizc51rTekuba2Dhb8Zxxb8we2m48SQ0OiMfagr
        UX4Dmq7LX4bkSNC1DnYaE2k=
X-Google-Smtp-Source: AFSGD/W8/scmlLBYzxVANzh5gpvGSq2SLdS827BjCCDKncekXZINH6XlojS/yLjGEDvLCYCeSTggTQ==
X-Received: by 2002:a65:5286:: with SMTP id y6mr34661741pgp.439.1543441718027;
        Wed, 28 Nov 2018 13:48:38 -0800 (PST)
Received: from [10.0.2.15] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v5sm13737260pgn.5.2018.11.28.13.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 13:48:36 -0800 (PST)
Subject: Re: [GIT PULL 2/4] bcm2835-soc-next-2018-11-27
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20181127211301.30296-1-eric@anholt.net>
 <20181127211301.30296-2-eric@anholt.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4fe7238a-5775-0cdd-b36a-d7ec5dde3d71@gmail.com>
Date:   Wed, 28 Nov 2018 13:48:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127211301.30296-2-eric@anholt.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/18 1:12 PM, Eric Anholt wrote:
> Hi Florian,
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-soc-next-2018-11-27
> 
> for you to fetch changes up to 7b369a42e6d06c59fc56a1769fb4da797fac9bad:
> 
>   ARM: mach-bcm: Switch bcm2835 and platsmp to SPDX identifier (2018-11-14 20:55:30 +0100)
> 
> ----------------------------------------------------------------
> This pull request adds SPDX identifiers to the bcm2835 platform files.
> 
> ----------------------------------------------------------------

Merged into soc/next, thanks Eric.
-- 
Florian
