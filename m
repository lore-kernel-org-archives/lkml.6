Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E677C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C9E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544480929;
	bh=Iujl6Z1h93bXUy6uJYDg4ILXwUfZM+aRZvuJ4ev4RuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1yrO4nRm7tKB5d6aERjpuovprqZeTU6FbTcZK0s0N+Opa1ubb8NYwuT0ii9OCsVcf
	 HwIVk482MTKZtMEa9ZGkjaaeFUVGFHMVQh5BQTiVmvJqD56N2LBaHj6c0l9D31bu8f
	 dL5f+t5O9iWy98IABkDZmrBX34Z0l3OncDaEa/TQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C9E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeLJW2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:28:48 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40002 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJW2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:28:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id t204so10400403oie.7;
        Mon, 10 Dec 2018 14:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x52jxDVnYyc/nJ0TF5Uu7Cb+36Wn0tQj02hikO5MTiU=;
        b=ekjJA2FQCpch8CTS6ExSIibD17VdvZOKfSZ9jpNZN21qBwAmLXaRwgRtHj4/pLelIh
         vvy3Qqrw/7V12IK+rD9D3n4S1ooEcWKGQiOjlbBOhln2XOj0CdGDSqBLKqCoL1YPpW2E
         mGmzcHr71OPg7sO9KlFT4W8YezqMx2l76NhvsP9ioVogdnLXS0ezaTOpOHV3ZfuaOIyp
         GxZ0uVdyWUuDWVC09Apdc5z9eKEbYRqATc+siI+XynnDBvKbxIx6gKyNB+ML7Pj7hHUo
         VllGrpJHVkgTgHQsqBBcMUqyvfJWCTb6iP36K9NfUxd3uM6XAdx6vxg5oZlkjv0xOZ4t
         nEkQ==
X-Gm-Message-State: AA+aEWY3px6OUWwd/BJ/Cf2Gkbd+TiS21GGHhJB7oMJKF4hVQBkAhrQf
        VGbOA91tyCUjM/pxvo2/Bw==
X-Google-Smtp-Source: AFSGD/VnCsnT+TV5aLn5Geh7vnUYfpffkIxR11UO/EDRv+HVIqSxSrLPfHiESwGWhEdOwH1c75hfdA==
X-Received: by 2002:aca:7581:: with SMTP id q123mr8792160oic.176.1544480926946;
        Mon, 10 Dec 2018 14:28:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z191sm8133883oig.3.2018.12.10.14.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 14:28:46 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:28:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrei.Stefanescu@microchip.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Nicolas.Ferre@microchip.com,
        Cristian.Birsan@microchip.com, Claudiu.Beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andrei.Stefanescu@microchip.com
Subject: Re: [PATCH v3 1/3] regulator: dt-bindings: add MCP16502 regulator
  bindings
Message-ID: <20181210222845.GA9114@bogus>
References: <1543917126-32572-1-git-send-email-andrei.stefanescu@microchip.com>
 <1543917126-32572-2-git-send-email-andrei.stefanescu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543917126-32572-2-git-send-email-andrei.stefanescu@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 09:52:28 +0000, <Andrei.Stefanescu@microchip.com> wrote:
> This patch describes the compatible and the device tree
> bindings necessary for the MCP16502 PMIC.
> 
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
> ---
>  .../bindings/regulator/mcp16502-regulator.txt      | 143 +++++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
