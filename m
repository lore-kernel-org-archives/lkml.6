Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD34C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF54820821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C9F6FpEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfBEAQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:16:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45352 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfBEAQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 19:16:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so694226plm.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 16:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KUHaO+b4z9WQHKowf1+0k08jiP/q8cVKrqg0BIHYCxA=;
        b=C9F6FpEWu7IyWU0Vd8y/VgtTok+Nk5PAZWS+P73r/66Bc1jj6JbwackRhp/xWGSHRb
         C3f5x0oEuqoCcBK4RIVQ3DgwjnGzCyEFVp/9tNznucvsU/gGVCfzgmDT768hDZxFT41w
         jup9o0eQ42uIx6nl0wORW0MqQQ6Paoq7IyzU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KUHaO+b4z9WQHKowf1+0k08jiP/q8cVKrqg0BIHYCxA=;
        b=GKGR3b1NeZw+SmLFOwZrMZmbiPK5dE6FXvXfhAU4vGelLZ/0wc75+NQ+s7agmlhmqZ
         rpukhIhnhuQ/CJ9XkbiLdD3RU4BU89nbMPwbkzTH/HoipUpmG5YGsd+dPPMJ0Qon3lQe
         GvzATRfBX5V0UMnGPeb6MvglfstnQmTixh6E3i0fB8hvVVV1uRSLT0wzgRKV5e0Ft/GV
         ajXZSnXkoH7o3xJKfJdDMzPSMb7y0FB/qJuhL3c9mGjnn2DMSxQX6RnGdRQZ+naWjr+V
         zssp5jKNGJsUqhOAexiRds3Ul+Oj5qD2co2KULN0L6VIzXzBFCJw866aEA1adLWFtwak
         1lsQ==
X-Gm-Message-State: AHQUAubnY2Z7My8nDIHv/KQTp3ufGrZiORqCjOpjt2wQLk14rpjo8zsG
        maCOeFHYAoXFWSp6yQymHLqNAl06HAicZ7XM
X-Google-Smtp-Source: AHgI3Ib0XNaSZ4wNJJ02/Qp7pGUfMpSI3Xz+pd8s7S4yhBWj/JxivqIrgJa6xr36Fq70UFmghbIxnA==
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr2104087pln.224.1549325784515;
        Mon, 04 Feb 2019 16:16:24 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 19sm1768576pfs.108.2019.02.04.16.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 16:16:23 -0800 (PST)
Subject: Re: [PATCH v6 0/3] Stingray thermal driver support
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <a6113115-453c-4606-f99d-c79263d8f4bb@broadcom.com>
Date:   Mon, 4 Feb 2019 16:16:19 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang/Eduardo,

Can this patch series be merged? It looks like Srinath has addressed all
review comments?

The following tag should be added to the binding document patch:

Reviewed-by: Rob Herring <robh@kernel.org>

Thanks,

Ray

On 1/3/2019 12:55 AM, Srinath Mannam wrote:
> These patches adds the stingray thermal driver and its
> corresponding DT nodes with documentation.
> 
> Changes from v5
>   - Addressed Eduardo Valentin comments.
> 
> Changes from v4
>   - Addressed Rob Herring comments on DT parameters and
>     thermal driver architecture.
>   - Removed brcm,max-crit-temp DT parameter
>   - Changed driver to thermal sensor registration model.
>   - Added trip DT properties.
> 
> Changes from v3
>   - Addressed Daniel lezcano comments.
>   - Elaborated commit description of thermal driver patch.
>   - Added brcm,max-crit-temp DT parameter.
> 
> Changes from v2:
>   - All stingray TMON DT nodes are combine together into single.
>     Temperature registers are combined into one mem resource.
>     brcm,tmon-mask parameter has available TMONs mask value.
>   - All available TMONs are initialized together in single
>     instance of driver probe call.
> 
> Changes from v1:
>   - Fixed auto build sparce warning.
> 
> Pramod Kumar (3):
>   dt-bindings: thermal: Add binding document for SR thermal
>   thermal: broadcom: Add Stingray thermal driver
>   arm64: dts: stingray: Add Stingray Thermal DT support.
> 
>  .../bindings/thermal/brcm,sr-thermal.txt           | 105 ++++++++++++++++++
>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89 +++++++++++++++
>  drivers/thermal/Kconfig                            |   3 +-
>  drivers/thermal/broadcom/Kconfig                   |   9 ++
>  drivers/thermal/broadcom/Makefile                  |   1 +
>  drivers/thermal/broadcom/sr-thermal.c              | 122 +++++++++++++++++++++
>  6 files changed, 328 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
> 
