Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A645BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B9220645
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I55yvt9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B9220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJSDMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:12:45 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40125 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeJSDMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:12:45 -0400
Received: by mail-yb1-f195.google.com with SMTP id w7-v6so12303997ybm.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ubysk04K/XZVeUZuq+du+JHa/pP/0oyCUhEkLYTOR3o=;
        b=I55yvt9ukXdOPwV5KiRwub+vQ5fNdBn3NjJRJMX/BE/491S8J5ISTt0nuvYGS+w2hy
         mMlf2S/0pZdZ6sriPyXE6a0i2qLDftfm/eKsLUJKoeyW3OUN/IkWa+2kaXay4jKsbMqX
         EZHmeotQoGRAJhAxcLlDpdCMTT4OnKVIi/voo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ubysk04K/XZVeUZuq+du+JHa/pP/0oyCUhEkLYTOR3o=;
        b=Z0zQZQgBTPENh1mb1aCOB8eeavnXCjJBJzcB/AQziPJD/pSxXQxi23BwJXftzbuMXr
         aA70tBl402yX4lwRx/B/ri2BDlvWpE+3u8oW4KOeWe/ssggHEGf29R+WNHJOFaH/gi+M
         +cDNo0OIuI7sbOy3CHk+fG8f5mYO2mFHt1cJWKgDGs+s6n6xUFsh+/1UN5mQu+YG1xki
         5cYBxGV6vB23q4rYlyQShK/GZbKX5DwTMhnAntMMdZYQX97vGWHo6XQLf/sSNpS8yKwc
         w6ELGHrs+TaA4iG2r4k22U9R2Iv/xZv/u3k3MvV6NJBK5H01uNnqlnOsJVyRIbm8Hmff
         EMFg==
X-Gm-Message-State: ABuFfoiMGx/x4xesYsYHi0dp0CrVGgUmYkx738XAS2yRAw2IcOoldQ3T
        /xwDg9xDlLBcWfTM4nhlEDP8Pg==
X-Google-Smtp-Source: ACcGV60NY8uoUq2OB0Oq4nf9MfDFFezM3iJ38xADdeULTx2Ax9BeqJ3dIycJVVxPWeD5NZPQu7S4RA==
X-Received: by 2002:a25:7b02:: with SMTP id w2-v6mr12774989ybc.353.1539889819700;
        Thu, 18 Oct 2018 12:10:19 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z14-v6sm548704ywj.81.2018.10.18.12.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 12:10:18 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] Stingray thermal driver support
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <6fb140ab-bdce-6eeb-7955-454a5988916e@broadcom.com>
Date:   Thu, 18 Oct 2018 12:10:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All Acked-by: Scott Branden <scott.branden@broadcom.com>

On 2018-10-16 8:11 a.m., Srinath Mannam wrote:
> These patches adds the stingray thermal driver and its
> corresponding DT nodes with documentation.
>
> Changes from v4
>    - Addressed Rob Herring comments on DT parameters and
>      thermal driver architecture.
>    - Removed brcm,max-crit-temp DT parameter
>    - Changed driver to thermal sensor registration model.
>    - Added trip DT properties.
>
> Changes from v3
>    - Addressed Daniel lezcano comments.
>    - Elaborated commit description of thermal driver patch.
>    - Added brcm,max-crit-temp DT parameter.
>
> Changes from v2:
>    - All stingray TMON DT nodes are combine together into single.
>      Temperature registers are combined into one mem resource.
>      brcm,tmon-mask parameter has available TMONs mask value.
>    - All available TMONs are initialized together in single
>      instance of driver probe call.
>
> Changes from v1:
>    - Fixed auto build sparce warning.
>
> Pramod Kumar (3):
>    dt-bindings: thermal: Add binding document for SR thermal
>    thermal: broadcom: Add Stingray thermal driver
>    arm64: dts: stingray: Add Stingray Thermal DT support.
>
>   .../bindings/thermal/brcm,sr-thermal.txt           | 105 ++++++++++++++++
>   .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89 +++++++++++++
>   drivers/thermal/Kconfig                            |   3 +-
>   drivers/thermal/broadcom/Kconfig                   |   9 ++
>   drivers/thermal/broadcom/Makefile                  |   1 +
>   drivers/thermal/broadcom/sr-thermal.c              | 138 +++++++++++++++++++++
>   6 files changed, 344 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>   create mode 100644 drivers/thermal/broadcom/sr-thermal.c
>
