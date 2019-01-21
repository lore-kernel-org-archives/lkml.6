Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CE9C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770C020663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548090940;
	bh=7pf9yreBmfqff5hIhgefFssNdJRpsm6s+buvpRYoknk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B0u/2Q4qLcuPY5TH2ehxWxBjTJByGIpvkUEJsKcfu+kRXWFUSLy/pdaCOs6xqKODL
	 AEWeJlGsGo3UHs3VpfxGnqP0a2iagI9VkrYM0WdaepZCePJfGqOyvi3juFIjSt7DK9
	 wvd7owV+i8e6T3s0vYukfAF/0PxXO0DZiNNEDTwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfAURPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:15:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36415 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfAURPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:15:38 -0500
Received: by mail-oi1-f196.google.com with SMTP id x23so15131877oix.3;
        Mon, 21 Jan 2019 09:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aIbnHP3kQnWvLMSaXvoD0S8eEMf5emNZxF2RqvW+3Jo=;
        b=Wf6vDV/hmbQt+VbOKVGbUcTxUEnvhrdacozPhb8XPX77DBbNlaWj4XKx7sl/kn89QT
         427QbtH7IK+8+SgFy/plfhx1IO88TJR8NfoGC4MEIadjd6oJtqw79yjNnbJIKo0gTdop
         roBHHtW5PfdiLaFIUiSpjY60xNeV95vC7AUwNkd2HuZSW696c1PDgsko6oLVXxY8hNQZ
         JZfe6cNQiOL7DauEQrfPpwyPoD+oKMPry7LrAWD9SAlzh+3+lRZta3Y10cnL7p8KmLAj
         AKM6lVGdRTqkuPy1sNWqhu6q7Ml/NuonawT2pKF/HCV28yM57vH/8Wqjwe9E2BLBmvNo
         F7sA==
X-Gm-Message-State: AJcUukfHHU/JN1RNV3Ju9aBRTjxGDtpqge40Kmdc0H5ym7+RBvM1ILsu
        vl2MeQTB9g/boNiy2pJPx6Yg2go=
X-Google-Smtp-Source: ALg8bN7qaFeQDQYWo/V0UuQFAq8jsy2svnIfPmoOKY/zBZK6HWCq6qgVK8MpJD2mhQcd3VeTEs/Sig==
X-Received: by 2002:aca:6155:: with SMTP id v82mr6351123oib.259.1548090937861;
        Mon, 21 Jan 2019 09:15:37 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p203sm6737239oic.49.2019.01.21.09.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 09:15:37 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:15:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/4] dt-bindings: memory: jz4780: Add compatible
 string for JZ4725B SoC
Message-ID: <20190121171536.GA12475@bogus>
References: <20190118151329.8040-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118151329.8040-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 12:13:26 -0300, Paul Cercueil wrote:
> Add a compatible string to support the memory controller built into the
> JZ4725B SoC from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
> ---
> 
> v2: No change
> 
>  .../devicetree/bindings/memory-controllers/ingenic,jz4780-nemc.txt       | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
