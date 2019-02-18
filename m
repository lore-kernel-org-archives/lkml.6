Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4C3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A89B2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550508330;
	bh=QU2UgcPUAccH9HTvOtNBTb078j+XMuXQoiyQMrYP7J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=10QmV8NvtG6sG4vuVUTHvT8AZ+1DSHrCSBg/pek84PIuyo9JFhlmwwW1HsyxrdHMx
	 1oLT/JYq3HEJloQESoY4o/8p9Qsj5bpBL97GcEUyxA2JtGqnLMXzUicL8LCDEgkL70
	 /GKwO/DGIkImLKX+jRYFr78qW3HLVeCo6BmaSo7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbfBRQp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:45:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46632 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbfBRQp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:45:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id c18so7733432otl.13;
        Mon, 18 Feb 2019 08:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r0RbpQNLkeIuoLTSc4LRdbNTPI4NVxo5sXSpkaEhmfo=;
        b=PMb/Z+XRjeo2uWFalLmS07dSKZ+Zqt9pDXUdijnVwfxQwmA4me7Uc3jTZnx7WxefFW
         o4Uhu85Nap3/YG/0N6P+QDNnXOyWFBlRErCbNRuDkSuFvnECsvzEbd4/cSgBNqBzoxyD
         ci/LjjQSrdb8QfV4jyecRwYa5x7QCl2dB+/hp3jb8+eEdawt7ABFvl6j/Fe+cAX3F6Wx
         SzA/+fVdYjh1Jh2ZbUVa9r4OrE65uFbN24PQ91MGo+WRJk+vjlZOPAcEuE2XS3OCmzYU
         Qpa5n63e62VWiA5Vsfm9C7tRevpsmZTpWPPO0WqnmiqXDyDBp7aiHlFg7gRgwyst+0WO
         pzWw==
X-Gm-Message-State: AHQUAuYPwZdxCugqme1J07u5ofUG6xiDOi05yKegIzPdzGSUxuqwSd4m
        WZtrmq8prj9cqgaq9F68Uw==
X-Google-Smtp-Source: AHgI3Ibjk9v+IXxtpjzUiTo5cIz56v9rTtezW1IWrRk6lF1SmJ445J9Bi7ysFijvEBHGn4VUVe7f3A==
X-Received: by 2002:aca:cd93:: with SMTP id d141mr14949521oig.163.1550508327699;
        Mon, 18 Feb 2019 08:45:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p129sm6228294oif.17.2019.02.18.08.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 08:45:27 -0800 (PST)
Date:   Mon, 18 Feb 2019 10:45:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de, tduszyns@gmail.com,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm-stm32-lp: document pinctrl sleep
 state
Message-ID: <20190218164526.GA1356@bogus>
References: <1550139951-25788-1-git-send-email-fabrice.gasnier@st.com>
 <1550139951-25788-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550139951-25788-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 11:25:49 +0100, Fabrice Gasnier wrote:
> Add documentation for pinctrl sleep state on STM32 LPTimer PWM.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
