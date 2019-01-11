Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0665BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2ED320700
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547235916;
	bh=CXY+98g+PJvADRe/ANXTIKWXZGmq9QhWL59zUq73F94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Txl2Dy82CmbllbSBLBaR6dZDWdCfVTJVgwqUZfqBAIkCoqNaZ5OdDfW+OPz3dqyf4
	 vzyi4jmbNj+zqdaRYMMqmPMvsH5bZCZyy21ptYuYDJT7IW2wDN+RpkuQT6E/5lBjhl
	 uIpJvMUobBPWr6shQJYNqgolA/bbiEr6NYYvwoCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbfAKTpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:45:16 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36972 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732889AbfAKTpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:45:15 -0500
Received: by mail-ot1-f68.google.com with SMTP id s13so5654113otq.4;
        Fri, 11 Jan 2019 11:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Kf1FM98exgQJHOBMRMPPRO6dBSs4QLvl+lqi/ByeFE=;
        b=NWvcDvcdAkfzgoBV5lpqFK5m/aeUu8J4RewtvCdWWCIwgyAp+scIYEuRxTLe7uBStv
         Qv4aRfgkc386rYlmX9u8U2ulu7+edM5F+1WjRHQcrKtJWwaPUXdDOIxOzK7LDq4ilyEi
         qcKY5uHNEQV8CjCuyFtuCFT5P7ySZYWSHG7usswhyYc3z65jcmvRNIsoS3B/Gnu1boVA
         cpQdM+obCLWpbatbNJ5q8UtT8BXoqUUEjtGSMwrsKzWb1Ko1hiZO4F6GZfmA6LFF2ukT
         uwCIe/34NlIzWngeZMd3ogpWCVUQrWFpwKaM9+b8hZc5+iQn64pjGcG/egRkgM39fwnu
         Lj0Q==
X-Gm-Message-State: AJcUukfvg/0KkWL9m1Ocrh9jyACIuZIdLVQeHtRfFskNjGjwYB6Enito
        uVgDTnOSHK1ZZupJKAXjyA==
X-Google-Smtp-Source: ALg8bN5z4PF+ib69dqhTo+4RjYdNhuwGK7M1rLsSIxs0h3zfnwyVZLRt1SdExq/V1V+QlXLzissnGA==
X-Received: by 2002:a9d:1405:: with SMTP id h5mr9788194oth.331.1547235914801;
        Fri, 11 Jan 2019 11:45:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v3sm71325341oib.57.2019.01.11.11.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 11:45:14 -0800 (PST)
Date:   Fri, 11 Jan 2019 13:45:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     kishon@ti.com, bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 4/6] phy: qcom-qmp: Add QMP V3 USB3 PHY support for
 msm8998
Message-ID: <20190111194513.GA13699@bogus>
References: <1546620647-2467-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546620647-2467-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 09:50:47AM -0700, Jeffrey Hugo wrote:
> MSM8998 contains a single QMP v3 USB3 phy similar to the existing sdm845
> support, however MSM8998 does not have display port (DP) support.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   5 +
>  drivers/phy/qualcomm/phy-qcom-qmp.c                | 142 +++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h                |   4 +
>  3 files changed, 151 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index 41a1074..6061b6f 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -9,6 +9,7 @@ Required properties:
>  	       "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
>  	       "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
>  	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
> +	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,

Please make bindings a separate patch. Combining patch 1 and 2 
binding changes is fine.

Rob
