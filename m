Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344B8C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E496E21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E496E21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeHUBeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:34:14 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38935 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHUBeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:34:13 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so28679091oib.6;
        Mon, 20 Aug 2018 15:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H+d2rf/4BilLtj6MkGdA0I6n6CB4uJZ2XsXeACCOyiU=;
        b=mJiOdFly2UT8Ghc351HXWTrUqpCzwCTCXUMWOaayQAXj4GdQBgjYae0S3A85/jjObc
         dixiQ7hNi8iF7T78nK1DfERnqqx52a77NbojY72BeH8Z35vnBia9rpDAzay9o21z/LCh
         ygeCUPSr55G/GeyE2AruSNGGplgJCwQfHnuACHKPw7/G6JA6Ih1POYvpJ+HP0AZKd+sK
         Bbxvws4Y+jIR+qdAE3okN6WFktJWuwnC4ojcEkhpK9/XoNXIm9riHj2JdnbExcwzJCbu
         Jj/ANJnqLXgGQuVH8w++PV7wz4Tm9jfDV4jnRZ9Y+sQubxvrH1gQL1Yxqf/NVR8RKFMd
         lpQA==
X-Gm-Message-State: AOUpUlG3itqMdD1CW7hf99H05Bq6EKNmOF8GNbTJuyvCtDPeKREy2Opu
        gK/D83XfsHFE/WPaTUz2VA==
X-Google-Smtp-Source: AA+uWPxlxUIRjU3GPiUi0EPHeKB5WiCxcSI3Px32y8Fs2IXv/Q9KOxtFLYHnPaOuQ68eyxKg+eUiow==
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr16688066oie.174.1534803409198;
        Mon, 20 Aug 2018 15:16:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i132-v6sm9822313oif.20.2018.08.20.15.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 15:16:48 -0700 (PDT)
Date:   Mon, 20 Aug 2018 17:16:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RESEND v1 1/5] dt-bindings: pinctrl: add wakeup capable
 GPIOs for SDM845
Message-ID: <20180820221647.GA8711@bogus>
References: <20180817191026.32245-1-ilina@codeaurora.org>
 <20180817191026.32245-2-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817191026.32245-2-ilina@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 13:10:22 -0600, Lina Iyer wrote:
> Update the documentation to use interrupts-extended format for
> specifying the TLMM summary IRQ line that is requested from GIC and the
> PDC interrupts corresponding to the wakeup capable GPIOs.
> 
> Update the example to show PDC interrupts for the wakeup capable GPIOs
> for SDM845.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 58 ++++++++++++++++++-
>  1 file changed, 55 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
