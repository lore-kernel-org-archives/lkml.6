Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50BEC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2B420817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2B420817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeKRCXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:23:15 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40651 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeKRCXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:23:14 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so24070978oth.7;
        Sat, 17 Nov 2018 08:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qrAa2U5TeFgyIl7tss4iXY05dCHcH17adlPuqnOQI68=;
        b=Ac3LrJ65tMLx7Kf19NaNOK2ZV8tStxNSgzzQUbuKcgASXa80t8UInB+uL1HFU/B0ys
         FhYynw+/f1ZghFnHpxg3y2jH1P8OSQtzuHeSWiYSj+Jmg9nRkT0pRsGPgkaZZUzb4OZa
         KI1eKkSV4Ay/MNIEFN0VmD869TCv8CPjHO0NBLYJuXu+LKsNMrZO30Mc0vWUilwHj8YX
         6HavwfA2dmeLCWJKnt1NtZyovbhFEqPIh3t9ZlJVL5UAgoyenRwsl57WDKKnHyqUfQNC
         bogoRvWEErmYU4MFhgx5wjzgZr1wf2uu1GF90wqSqyaPT2A6xw69S7vaZ5bV+lPjkeDe
         wURA==
X-Gm-Message-State: AGRZ1gJHaEh0uagKL78dYrEXWejuodNfSNqhZWE5jPhDnq2RBgAvZd9l
        1k6HhnA8RnAxsQFICtRFY9qPOn0=
X-Google-Smtp-Source: AJdET5d/gfxWYBtF9K4dzVIoO7dS97CL6y2sT6IKAhopxJaZ7KLShG17xpqJM2WhZjirNEix/sLgcA==
X-Received: by 2002:a9d:3b65:: with SMTP id z92mr9260579otb.275.1542470766523;
        Sat, 17 Nov 2018 08:06:06 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id i35sm1166028ote.69.2018.11.17.08.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 08:06:05 -0800 (PST)
Date:   Sat, 17 Nov 2018 10:06:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: i2c-stm32: SYSCFG Fast Mode Plus
 support for I2C STM32F7
Message-ID: <20181117160603.GA3681@bogus>
References: <1542370822-14721-1-git-send-email-pierre-yves.mordret@st.com>
 <1542370822-14721-2-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542370822-14721-2-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 13:20:21 +0100, Pierre-Yves MORDRET wrote:
> Append optional bindings to update SYSCFG Fast Mode Plus bits if
> Fast Mode Plus speed is selected.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v1:
>        * Initial
> ---
> ---
>  Documentation/devicetree/bindings/i2c/i2c-stm32.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
