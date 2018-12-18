Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09969C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C905E218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545154032;
	bh=kxUvsOyDTqLHwe1shpxJEKAtHdYM5IW0FRBQoxhGY7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1yCv3nA+KUwmTq8CcoXo44VVrtesjgSPhcnIA8MbcDLioZjSvu9am8DRnLeUD0qNl
	 j2BeF2C8LYBHtu2YnBVFrXnSDpxyc54CeMnEnPgYWvAZGNjjei113zMoVstvbvFw3n
	 RnFW+8uDrIUYe5rrYcMMcpR4Ipq9ZaAfwPCC6bk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeLRR1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:27:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45839 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeLRR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:27:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so16373926ota.12;
        Tue, 18 Dec 2018 09:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ayJEj22fjGMBH+oW4YmpMd5fNmXzaycv+scYNi+UhFI=;
        b=s83ykHkQKOuusPrHvA+qBMMzr75tJJu+9hbXzntp3NZ9jieQbqC4C6der+IvadD+E7
         iBcS9dbjOQETqKJzbRNtpA7ARFssRxDg2hiocJLT/g+6+IIW/w1n8FiBQiIeHmO0LvjK
         PpK2mTvH0GDOFgpbKPCnHDVk4EgkYe/lMU14kpLyPDLYJ4u4FTdn4w5GpEXAQ8aQ1RBL
         u9gacQy/JAczPTa/NRAgyc9+Mw8SUJXpk3QgI9DAZPhqFSFE87O31Iwu+CCOhYDO+bWz
         fwFveTFaEN9qorc58viEnC8BG3tlPK5oFWOFqEECrDgTRF2Gkw2KsSYXe1bTamnqGhxD
         FnXg==
X-Gm-Message-State: AA+aEWZnj5883sCAtfxc6meXAo8lZJIZ2e/OqQVpaOecSsH7jqoTUi7r
        BGBLnDVRfwYfK9mgyZZfFQ==
X-Google-Smtp-Source: AFSGD/Vdjs3wY1LW/no6TLz1N5yhO2ikwZcX8qoEFBzEmnJUgqTk4qbXOIPDrrJ82AU8gJlaqqyDTw==
X-Received: by 2002:a9d:5f85:: with SMTP id g5mr3978681oti.333.1545154030663;
        Tue, 18 Dec 2018 09:27:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s17sm7696890otp.36.2018.12.18.09.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 09:27:09 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:27:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        evgreen@chromium.org, briannorris@chromium.org
Subject: Re: [PATCH v2 2/7] dt-bindings: remoteproc: qcom: Add clock bindings
 for Q6V5
Message-ID: <20181218172709.GA19660@bogus>
References: <20181217100724.4593-1-sibis@codeaurora.org>
 <20181217100724.4593-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217100724.4593-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 03:37:19PM +0530, Sibi Sankar wrote:
> Add missing clock bindings for Q6V5 MSS on SDM845 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt       | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 9ff5b0309417..780adc043b37 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -39,13 +39,17 @@ on the Qualcomm Hexagon core.
>  - clocks:
>  	Usage: required
>  	Value type: <phandle>
> -	Definition: reference to the iface, bus and mem clocks to be held on
> -		    behalf of the booting of the Hexagon core
> +	Definition: reference to the list of 4 clocks for the modem sub-system
> +		    reference to the list of 8 clocks for the modem sub-system
> +		    on SDM845 SoCs
>  
>  - clock-names:
>  	Usage: required
>  	Value type: <stringlist>
> -	Definition: must be "iface", "bus", "mem"
> +	Definition: must be "iface", "bus", "mem", "xo" for the modem sub-system
> +		    must be "iface", "bus", "mem", "gpll0_mss", "snoc_axi",
> +		    "mnoc_axi", "prng", "xo" for the modem sub-system on SDM845
> +		    SoCs

This seems to me a list of all clocks you need enabled, not what clocks 
actually go to the modem. Specifically, shouldn't the *noc_axi clocks be 
managed by the interconnect driver?

Rob
