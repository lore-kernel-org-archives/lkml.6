Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CADCC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8C8208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7rHcpGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8C8208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755357AbeFRQsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:48:24 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37624 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752835AbeFRQsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:48:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id y5-v6so8459170pfn.4;
        Mon, 18 Jun 2018 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q11XRtjbqqMUasQGLsI7jy0txfH61VaWuivAZxYYUEU=;
        b=g7rHcpGnrUrUwW63ltXuTKvdzPFUNB3PJsGK+6wgEZorjxnmFeGpnAs3E2QaDW6lp7
         u66oJjLcq1KC9gT7QSZyXknggl3EcL2wduW12gSO2SKXY64aOA3Qz9mIdYVxq9eqBAox
         bWYsPBgMrLAQkecNfzYT1cdgJH6qojydzntGtGNf1Oz4PSRjJkT4Hdr/WKmsuVDlqHEI
         erFPaGqY1SJ8Vi0TNUhDecsJ/cOxgRT1oixB1LDKR3ueVht02LYvKFIUKSv2oscndvkZ
         3TuvMW3+kr9Ri2SoJXKPsWNarrsw4ULbnwolmZdqOI0PVRiKnTUpswyVt2/fo2xQFzzb
         Hs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Q11XRtjbqqMUasQGLsI7jy0txfH61VaWuivAZxYYUEU=;
        b=atRMS8bvGZH7f6nIsi4lERb9sgHh8LEh8G5/31eGuT47bZP0mrCboUD3PN5jHP9GpL
         4QvyNJecdXbXCDjt8y4uG+DubF7IQNw6Qt4MpZ/ACDiHDOgHUkr3Wit+JarBtbyidjn+
         M8vSFyo3+J6OZ/VFO+TEUiIwfAyUYBwtVulRXPhePXZuwpCbc/pEoHj+Fb8z/3snuJx9
         4YpTThUoMKwu5FOzCKzyw3vn3mCBvAt0TjK1sR48mBbZvgpOy8gXoypeCyKfWXMOv4vw
         Q6kN2v3MUUzpCf8FvwNbOdTRCYrEkEX/0CmlsLRGbb7DVBlG5DZlh5aCr8RcS9/qLRLt
         cRgQ==
X-Gm-Message-State: APt69E1/A91lxUDQNrfYtkuPqw2aIWQg21jY1vVqsobQpUBQMQm47ppw
        8oR0T9bo/asjijFzvrRw+ZysNXnl
X-Google-Smtp-Source: ADUXVKLCbxlqFdE20Nhx9aJHhBZzg+KPulTtLvqWcfldhfuHAV08ibrJb5NugF+xiwQtp/tmgPPwQw==
X-Received: by 2002:a65:51cb:: with SMTP id i11-v6mr11874408pgq.320.1529340501056;
        Mon, 18 Jun 2018 09:48:21 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id a23-v6sm18401197pgd.85.2018.06.18.09.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 09:48:19 -0700 (PDT)
Subject: Re: [PATCH 0/5] Fix Cygnus, NS2, Stingray interrupt type
To:     Ray Jui <ray.jui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <ac955f7d-6770-63a1-db85-024b0ee0b8af@gmail.com>
Date:   Mon, 18 Jun 2018 09:48:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 01:21 PM, Ray Jui wrote:
> This patch series fixes incorrect interrupt types for I2C and PCIe in DT
> for Broadcom Cygnus, NS2, and Stingray SoCs
> 
> This patch series is based off v4.17 and is available on GIHUB:
> repo: https://github.com/Broadcom/arm64-linux.git
> branch: cygnus-ns2-dt-irq-type-fix-v1

Series applied to:

- 1&2: devicetree/fixes
- 3-5: devicetree-arm64/fixes

Thanks Ray.
-- 
Florian
