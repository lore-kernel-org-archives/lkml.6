Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D4EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2B322507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2B322507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbeKMKQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:16:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46937 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeKMKQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:16:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id s9-v6so5081558pfm.13;
        Mon, 12 Nov 2018 16:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=73RFXV5rJTuvOfDgu6D0bP3GNhjhWsfJubWtZnhM8es=;
        b=sqlhVfgty1NxtOxyNYVj5BujHtjrY8RMd6CbvZPK2RU5Wo7dSZVkd6XjS57N25vLuh
         cOip4+3N4aNAtJ5+05Hd0JVqAGygbKOekt6nzl8Se/H3Atf+/uwxMlvHxcL88oPyJjGn
         79A+VywnBioSEUnHpVtXYCfJPmW/yJ3dYhU1Rk5WIQhIaBfshz3fTxAIwCMKi5Iors3a
         o5q5jtKEKDI3GhCefwjwo9SeZm1L41jXRdx6f1CS6ujZ6Ei/hwPI5ow1rPqGprb3eSKo
         dg+jbhHXwVUjKwSqdvLUXyc7GcH9sU84Hz2Kxh95qJSWGFOxtr4USxS8bm9Zmo28v7RG
         l8fQ==
X-Gm-Message-State: AGRZ1gJzUavTGrOvk665dmUaJUAC98EG6DRGTcom+eLpkaPjy+OyIEfV
        gGHfGwq7a32S9V7FyCRnZQ==
X-Google-Smtp-Source: AJdET5etdV3WGrGgufciZoGqcreWhb0Yxhpr4Qrsmits4jEE2CNCqNDpSWy1N/KoNsJeuSMTwOV8MQ==
X-Received: by 2002:a62:5146:: with SMTP id f67-v6mr2966927pfb.238.1542068451144;
        Mon, 12 Nov 2018 16:20:51 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id d68-v6sm19241087pfa.80.2018.11.12.16.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 16:20:50 -0800 (PST)
Date:   Mon, 12 Nov 2018 18:20:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: Re: [PATCH V5 1/2] dt-bindings: mmc: sdhci-msm: Add SoC-specific
 compatible strings
Message-ID: <20181113002049.GA26402@bogus>
References: <1542005537-19154-1-git-send-email-vbadigan@codeaurora.org>
 <1542005537-19154-2-git-send-email-vbadigan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542005537-19154-2-git-send-email-vbadigan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 12:22:16 +0530, Veerabhadrarao Badiganti wrote:
> Add SoC-specific compatible strings for qcom-sdhci controller.
> 
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
