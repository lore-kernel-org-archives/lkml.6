Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EEA14C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2F820891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2F820891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934839AbeFLU7O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:59:14 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44175 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934816AbeFLU7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:59:10 -0400
Received: by mail-yb0-f196.google.com with SMTP id w74-v6so132268ybe.11;
        Tue, 12 Jun 2018 13:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NaoP6DmAVQjUNY1XQ7vpiYWf97gEJaHO9PqTR6rQiY0=;
        b=dAxya7NmBQ69mtNzGZmtnf0FqNzwcCUNVQMtq15B97BTtFPRr3tuZjKolkVpWgprvU
         dNlMO3Bhdp/egH7IProjQpSaKTVlbUai33HM2jLPb9L1Tf+fuwWvRm4H2f0n8PjF7unt
         OqC5JgPTHzGW7jMXMVFBIU8uHdtGt8jNOHYPe0f8jrbbV9q1/6PoRFt+sdrf0ZuKwQJj
         ukaPqGNCRRvYh4JPwJqIaVs7uP6sUGMurycn4iqQnMeS/q2KY+J4N1OiENMeLJNHvYkn
         WMNab4/MG7uThRZR8vFI1q7gegGvSJtRHqe3x5wtuUOTvdPgg6tBp6G1E7h3Zb7CGSgr
         Llhw==
X-Gm-Message-State: APt69E1L+2riIeYxnk+XjG9cjztUCTNn20kUwndip6K6GlmgGJ+q2Eik
        B6+h4ZbNLm5vj55dLFTngA==
X-Google-Smtp-Source: ADUXVKLVW1aw7qXVlyIdIxJ2V9E+RB30WHBiJfQiGfvjQ1Uw41hUIVnYGFO3IIgTjZmdgr3uAJA4KA==
X-Received: by 2002:a25:8444:: with SMTP id r4-v6mr1014949ybm.507.1528837149534;
        Tue, 12 Jun 2018 13:59:09 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id h1-v6sm389233ywj.86.2018.06.12.13.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 13:59:08 -0700 (PDT)
Date:   Tue, 12 Jun 2018 14:59:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: Introduce QCOM Display clock
 bindings
Message-ID: <20180612205907.GA12993@rob-hp-laptop>
References: <1528098985-3676-1-git-send-email-tdas@codeaurora.org>
 <1528098985-3676-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528098985-3676-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 01:26:24PM +0530, Taniya Das wrote:
> Add device tree bindings for display clock controller for Qualcomm
> Technology Inc's SoCs.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,dispcc.txt      | 19 +++++++++
>  include/dt-bindings/clock/qcom,dispcc-sdm845.h     | 45 ++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc.txt
>  create mode 100644 include/dt-bindings/clock/qcom,dispcc-sdm845.h

Reviewed-by: Rob Herring <robh@kernel.org>

