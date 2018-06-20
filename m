Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD051C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A376A2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A376A2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754460AbeFTQBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:01:35 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44084 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753960AbeFTQBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:01:34 -0400
Received: by mail-yb0-f196.google.com with SMTP id w74-v6so20436ybe.11;
        Wed, 20 Jun 2018 09:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kTj79B35cWrCsJIwxCM1SC7JbkFsxoK3K0CWfG29nKc=;
        b=PVmyFQU8Jv8txokn+TdmDdLScR3lurkehKk9VooxC/ykcqbQZwS/cgZjU3kuVcmH4D
         fA1BAQ9rxIJPJtidxu7qypcU62R4HxdKm5DtLZTwRpJGimQDYsUYZKBkNETYpCxJ79Ou
         sbYB4b4GZpnr8AWDZ2pW3BhmUrzTHDyImG6pnKT23ihlomDKZ4xFIn5iiL8THpEXBO4f
         y73pjzO5DCQQjSY+31fQHXdH/rOp7+3oUYx5yW1LlrQ6cYTRmA3JVNuarENPJJk4cGRR
         Wit2xxKfZftBg2I2xJaHzxehwDbOW3l60/RXW6fCtRJHUYqneHRgIDf6JKrDcJr3e2GV
         kj4Q==
X-Gm-Message-State: APt69E1AWNGCMWeAnPTfclN53kcso6QZXqgDauIKWlEskq+dKqVY25Ql
        NJau+QnZt7sgUjmPzUw4Ow==
X-Google-Smtp-Source: ADUXVKIPyT+dvLCi4hctk15kxId05VeRH+hfnbyOvAAXbLsSSOr1YR8dwlJJc9nOJXjpx5noenxk2A==
X-Received: by 2002:a25:c04:: with SMTP id 4-v6mr11182645ybm.247.1529510492543;
        Wed, 20 Jun 2018 09:01:32 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id w189-v6sm1134580yww.62.2018.06.20.09.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 09:01:31 -0700 (PDT)
Date:   Wed, 20 Jun 2018 10:01:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abhishek Sahu <absahu@codeaurora.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 03/15] dt-bindings: qcom_nandc: update for ECC
 strength and step size
Message-ID: <20180620160130.GA21296@rob-hp-laptop>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
 <1529479662-4026-4-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529479662-4026-4-git-send-email-absahu@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:57:30PM +0530, Abhishek Sahu wrote:
> 1. If nand-ecc-strength specified in DT, then controller will use
>    this ECC strength otherwise ECC strength will be calculated
>    according to chip requirement and available OOB size.
> 
> 2. QCOM NAND controller supports only one step size (512 bytes) but
>    nand-ecc-step-size is required property in DT. This DT property
>    can be removed and ecc step size can be assigned in driver with
>    512 bytes value.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> 
> * Changes from v3:
> 
> 1. Clubbed following 2 patches into one
>    https://patchwork.ozlabs.org/patch/920465/
>    https://patchwork.ozlabs.org/patch/920467/
> 
> * Changes from v2:
>   NONE
> 
> * Changes from v1:
>   NEW PATCH
> 
>  Documentation/devicetree/bindings/mtd/qcom_nandc.txt | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

