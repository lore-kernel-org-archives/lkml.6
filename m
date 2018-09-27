Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6790C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998C8216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998C8216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeI1BGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:06:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34743 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeI1BGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:06:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12-v6so3614827otl.1;
        Thu, 27 Sep 2018 11:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dbxbl5OVda9ZVbKRmjeStu0K1EUlwT5YlOyFzt04/Sk=;
        b=oxXddilPS3ZqW5GT7eem9nPDXTm32SISarCXvedBGuMrAzUECx4pBw+7V5rvF8VLYA
         +uwmYzwXwh7kFYjRxs7FPGE21f8qehxEz68lu7DbQKbPCypupPtYsSL105sToyiPjU1Z
         nU6Eo1PmkU5woVhx0YrXKHuKoN1j3AFt6Z7x/gkCumhzCvRE5cKupZBkLAchSRC8znzo
         PncLxQoDgbVFPyI6iT5PhdTFdohmq4AADvmvrmgI2LeMMtke5ByMr+y34S6OxBHdjk3P
         2lO9YnCqBvAY6lTN+6HpQAaVfTmbNOg83V/nfT/UhE+2Znzyu960cRntsVTVIMU4w4lL
         +ezg==
X-Gm-Message-State: ABuFfoiwO0x/TU//Rp03LJiPg9h2Qtg7rmzdH3E+0tu51dAnUqCfVyGT
        Y5KpbsWq2RtCP2EGISAtUuDLjUHFGsv/
X-Google-Smtp-Source: ACcGV61o3gGERcz2ti8Yi5m+NESSavJ54EO13ZOjp2njo2mz/D8Nf2QCSqv2KoRvwkI87ER6SZEpOw==
X-Received: by 2002:a9d:fcf:: with SMTP id m15-v6mr8147774otd.81.1538073993943;
        Thu, 27 Sep 2018 11:46:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w3-v6sm1207710ota.33.2018.09.27.11.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:46:33 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:46:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: pinctrl: qcom: Add SDM660 pinctrl
 binding
Message-ID: <20180927184632.GA31215@bogus>
References: <20180925173801.3835-1-ctatlor97@gmail.com>
 <20180926162644.10039-1-ctatlor97@gmail.com>
 <20180926162644.10039-2-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926162644.10039-2-ctatlor97@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 17:26:43 +0100, Craig Tatlor wrote:
> Add the binding for the TLMM pinctrl block found in the SDM660 platform.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---
> Changes from v3: 
>    Updated for tile structure
>    change irq field
> 
>  .../bindings/pinctrl/qcom,sdm660-pinctrl.txt  | 181 ++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
