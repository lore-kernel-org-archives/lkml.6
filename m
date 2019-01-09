Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75A6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EA8206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I694WTCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbfAIJJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:09:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42946 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbfAIJJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:09:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so3030182pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 01:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kne/1rwxvEQVYUqdURyQzsm2qtrysS+ltgkZX30h+UU=;
        b=I694WTCpmwWC0WuYLv7WsYxo4tGLM5ydINXE4AkyloiuGy0W1HOYMcnUwYpyBdWTIC
         tv9NHHxRk/ppXAg2JbrbFxbDAL98WTvEoM+IK+legychh/2u0IVBltVyL95NNY9rWz8K
         k4bF9T5qtaDc0l86jh8pO92cao3pQz3As2glo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kne/1rwxvEQVYUqdURyQzsm2qtrysS+ltgkZX30h+UU=;
        b=EAHbMupX4fb73Ma5Iw4ib7wkOD8Er9pyR4DGKD+GNMLDcLG4H4va7KwxURkKSLl/JE
         cPcK2iMzkr8/cTpPvTDDicSVXukhLLtOoLUKvegmoB7e27VZLHHKQtfZmjgTw8M2hYqs
         eN04yx8QEnnereiQfgSPDJuNiZuSZ88CnYR/48APRr8JoLDWDqXzdX+N1oMJYF6BALlU
         +jdxVRGhkteedZkc4NUOBN3E56FGmEqCT2fiFOUM09C0DAxZ58Tx80bX+cjWncFkPHw2
         Fq5Jhmtou4nClWmN+/c9ggA8kOEG3MCAMd81GIcb1SLHkvxe+W43jGnSMBGh04iVbSkJ
         KyLQ==
X-Gm-Message-State: AJcUukepjuGN2EHsZd8grS7A0ic3/OTzH9i8rmWmMallsCwGgBpxdB4y
        hIaNlkkOBXKFAU0gIWd58BM6Ag==
X-Google-Smtp-Source: ALg8bN65XBZXib6z1EpXiQDyEFJBMd/ZWLLraigoqVxGssxL/rrUkrHE6xfojxT81L4Y/Q/GkqE0sg==
X-Received: by 2002:a63:e84c:: with SMTP id a12mr2432638pgk.241.1547024955079;
        Wed, 09 Jan 2019 01:09:15 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id m3sm88381439pfi.102.2019.01.09.01.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 01:09:14 -0800 (PST)
Date:   Wed, 9 Jan 2019 14:39:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     andy.gross@linaro.org, robh@kernel.org, sboyd@kernel.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com
Subject: Re: [PATCH v10 1/9] dt-bindings: opp: Introduce opp-level bindings
Message-ID: <20190109090912.ciq4uzo5sjghyms2@vireshk-i7>
References: <20190109090420.8100-1-rnayak@codeaurora.org>
 <20190109090420.8100-2-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109090420.8100-2-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-19, 14:34, Rajendra Nayak wrote:
> On some SoCs (especially from Qualcomm and MediaTek) an OPP
> node needs to describe an additional level/corner value
> that is then communicated to a remote microprocessor by the CPU, which
> then takes some actions (like adjusting voltage values across variousi
> rails) based on the value passed.
> 
> Add opp-level as an additional property in the OPP node and describe it
> in the OPP bindings document.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index c396c4c0af92..e83fb7cbfd58 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -129,6 +129,11 @@ Optional properties:
>  - opp-microamp-<name>: Named opp-microamp property. Similar to
>    opp-microvolt-<name> property, but for microamp instead.
>  
> +- opp-level: On some SoC platforms an OPP node can describe a positive value
> +  representing a corner/level that's communicated with a remote microprocessor
> +  (usually called the power manager) which then translates it into a certain
> +  voltage on a voltage rail.
> +

This binding is generic enough and doesn't have anything to do with a
remote mp and so such statements should be avoided in here. And then
Linux can use it the way it wants.

Maybe just say that it describes the performance level of the device.
That's all.

>  - clock-latency-ns: Specifies the maximum possible transition latency (in
>    nanoseconds) for switching to this OPP from any other OPP.
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

-- 
viresh
