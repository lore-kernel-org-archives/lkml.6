Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598B0C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194312086B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194312086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbeHNXnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:43:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46035 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeHNXnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:43:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so9771903pfo.12;
        Tue, 14 Aug 2018 13:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ko7GnAOY35zzHEzsCp0GnBFQkiiYxsRan5/p0dFnnu4=;
        b=hL07Wf7gILKCBiYQHGBcYvqzJD5sO0XiRJOU0oGc9zv5tYFnL5UNAF9YxErDOpyscQ
         ByNw0bB+52gowJfDzeXrAnkFKQm9EmDZ1kxfUIRJ7yfQUCVsCZ021t+L7Yao/bXMJVkV
         m6z2kW6B3fLxBJZLVkHrk8WgxJZhPKFpGC+RqyyTKdG3qr8U6SJqVEcu0W2mEx4MUwZ5
         5QSlxoe+Qxl6dSBlmsL2gBgjx4F6PzazOxBIQHCEVXslXhmNVeFy0wIMV9zkJ/xc8/tz
         TSIDu58R3WIcPz/gkqx92o47o6eXVKsMvEAtZF6SsNrn6RL0bNAed1QeC1TwBNzE7Xfm
         fc2Q==
X-Gm-Message-State: AOUpUlEfflYIcThPKlFcyhhNqQHeXGub4SuuV4/AEt1oRgEufR4cjo0i
        klKGQt866fKyNlLTPTVeDA==
X-Google-Smtp-Source: AA+uWPxDZleU51f0oFo6MRzShDQwZdWqmuzIu4vSR511/a2zIfdHvoRavtFv6szVlJaRRTbUnYKBtA==
X-Received: by 2002:a62:ea05:: with SMTP id t5-v6mr24838829pfh.228.1534280048652;
        Tue, 14 Aug 2018 13:54:08 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id j5-v6sm20521615pgp.6.2018.08.14.13.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:54:08 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:54:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     xuwei5@hisilicon.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 3/4] dt-bindings: arm: hisilicon: Add binding for
 HiKey970 board
Message-ID: <20180814205406.GA19066@rob-hp-laptop>
References: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
 <20180810175339.25421-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810175339.25421-4-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 23:23:38 +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for HiKey970 board.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
