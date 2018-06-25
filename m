Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376F9C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E403025D5B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E403025D5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755260AbeFYPxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:53:09 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35067 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754600AbeFYPvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:33 -0400
Received: by mail-yw0-f195.google.com with SMTP id t18-v6so858576ywg.2;
        Mon, 25 Jun 2018 08:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6p+K+WoAHN9GVfaIv2UAcYj9lf2qTplD5CP/xIVLi+o=;
        b=Pru788Quy3iTvDMccQd7eMlhCSvVA83awcDJVCRhnx2rBUV8fItpB9YueO0kOX3fPN
         MOYYMukjsQE2tWJ8n7r056hXwoAqovY3QtnO6ZaXVMnxyd5Cm0iaM2iXYZlnABznsgmq
         EynInhajQx/51PTB3ZR13AZrcd+d+5zvWV6enkgtVUcnfzSTtaXi2wRtm5AEL9clKvAu
         j1UAfqc8vdn8nh2j6Lrw3QSGLMXRG4hkOs+crmNOR1gbIEUOMXllpyJMNrSn0rkn979h
         j9MR8qmZXpnT6hirVoGa7faQmtIGj2hnCU/2oIhYw19Sju39CRRoTsmB/9QPcuT8Ipiu
         8kYw==
X-Gm-Message-State: APt69E1hzGAK/s8KIz7RZNv03jTko3IOWWbkrHiyXtAhxPLkRajWhm/9
        H+6f0Vzfo2iWsYHF6SZuig==
X-Google-Smtp-Source: ADUXVKIG5LxaygO1QuKcGszLh+Uxr7wo9R6m5t/8SKnuteXSqdORQoQmbiWiJ8DflWXgVvHTwYymYQ==
X-Received: by 2002:a0d:cc15:: with SMTP id o21-v6mr6103252ywd.91.1529941892420;
        Mon, 25 Jun 2018 08:51:32 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id h66-v6sm3407809ywb.27.2018.06.25.08.51.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:51:31 -0700 (PDT)
Date:   Mon, 25 Jun 2018 09:51:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 1/4] dt-bindings: watchdog: add stm32mp1 support
Message-ID: <20180625155130.GA25449@rob-hp-laptop>
References: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
 <1529571737-3552-2-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529571737-3552-2-git-send-email-ludovic.Barre@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:02:14AM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds support of stm32mp1.
> stm32mp1 requires 2 clocks lsi and pclk.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../devicetree/bindings/watchdog/st,stm32-iwdg.txt          | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
