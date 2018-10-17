Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDEBECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F3021528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F3021528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJQV3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:29:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38945 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeJQV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:29:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id l58so26167132otd.6;
        Wed, 17 Oct 2018 06:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SeCSrusglQu4nppH7XoMBfU5pQ/tjBz9pcaKRUoqPAw=;
        b=ryDBWBe49H2u+H7L+I2IKHr9+qp+axiTp0Ia65ndsr9Xn8SW3aGVWWv2LYP50yy1sf
         3JLdRHwlfAEyWBtCr4uSnU7XbQNXv4kWPwbKNV+y5oEvIoM8u1uzynItlTx9EZ8nnO1f
         EwXNYNtjveEdmAXyGdf4uHG58h1lLACWRg4/aBoy2N0NlTabNwUOu/5K3tCf6p2Hm8Ot
         fr3GNoJZJDEx795fRzJ0MKxzZzLnenrwwpVXeNv9JciVGUwJHbcLyFGeFcomMcXITQTG
         u3sHn4x09M3MNV9ncUmUukbO0otWWtQS7p2PTBhetWld6uwh61ZUcvpIaQb0pUI0f1WF
         FMkg==
X-Gm-Message-State: ABuFfohV9/czOk1gM9A8Clm3DRhOXbKWJ5D5Xwe+bDjxRF1LIqMOAojo
        jeHbkHeyy0/gC9GgJz6gUg==
X-Google-Smtp-Source: ACcGV62JmB+k9SCw+OkHtZHWfLiXzeOwuEWK1I0+1QuQlk8YHhY7VkhDsnfjP7MyjROm1Yo+q7cbIg==
X-Received: by 2002:a9d:5302:: with SMTP id g2mr17529861oth.88.1539783205790;
        Wed, 17 Oct 2018 06:33:25 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l56sm6026295otd.55.2018.10.17.06.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 06:33:25 -0700 (PDT)
Date:   Wed, 17 Oct 2018 08:33:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v1 07/11] dt-bindings: regulator: Document new
 regulator-max-step-microvolt property
Message-ID: <20181017133324.GA5459@bogus>
References: <20181005153638.1886-1-digetx@gmail.com>
 <20181005153638.1886-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005153638.1886-8-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Oct 2018 18:36:34 +0300, Dmitry Osipenko wrote:
> Certain hardware may require supply voltage to be changed in steps. Define
> new property that allow to describe such hardware.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/regulator/regulator.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
