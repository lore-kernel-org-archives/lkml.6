Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20A8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAC226E2B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAC226E2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934030AbeFZUjo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:39:44 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33082 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933655AbeFZUjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:39:42 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so7130208ybb.0;
        Tue, 26 Jun 2018 13:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aZJ7oLzj5a3au+iwd7jCPwHKMU/9MZfgYg4oUn3vwMk=;
        b=V9mjgwurgmSHyxzIAJYKczVkrPdUPuxG2xJgsVghNc8ZFr2wYyNNHNoLCbHuuNtfR3
         maf/OVxdYMsE3ZqWQ5XC1XiXOV8D/cyVlbbikM+oLM3Y8McgW+OYF2niGw1XQyz2+N5V
         WoEaN0e79n96WFnBUhimdcCaiNAFeHWsTRuf1kPxVfKqsT4GQlDwBb4GCnIlJ4UkDnOk
         UjtaVd4sG8DRGkTsYWib/zn57cy/+9BKMFbIzThpKiYABYnfndjUR3ew3SybQ3bshjTs
         GWS++F5v/csaz47ZHPCzOkv4KajXOEPkbMnhL2um2nFrfy9M/GXbKESMYDfsG/TCgdlV
         ajiw==
X-Gm-Message-State: APt69E1n+GyUB6NHDYYNgXCiNjiQam8uekn/RZbd+FfRHEKj0UFQ67Y6
        uoaifSilMOliOldXv2pauInv5zM=
X-Google-Smtp-Source: ADUXVKK3GGfi7FewBWybe/n+oK+4AiMZp6EHf+8BOwpFRTLmsszdxBd2BiPlsYPIDQrOtoDi7gIWaw==
X-Received: by 2002:a25:6dd5:: with SMTP id i204-v6mr1652864ybc.372.1530045581571;
        Tue, 26 Jun 2018 13:39:41 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id l141-v6sm924806ywb.67.2018.06.26.13.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:39:40 -0700 (PDT)
Date:   Tue, 26 Jun 2018 14:39:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 1/5] dt-bindings: watchdog: add stm32mp1 support
Message-ID: <20180626203939.GA17242@rob-hp-laptop>
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
 <1529941383-8653-2-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529941383-8653-2-git-send-email-ludovic.Barre@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 05:42:59PM +0200, Ludovic Barre wrote:
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
