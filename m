Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC41C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E74240CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E74240CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbeGEVUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:20:08 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45570 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754225AbeGEVUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:20:06 -0400
Received: by mail-oi0-f68.google.com with SMTP id m2-v6so19576022oim.12;
        Thu, 05 Jul 2018 14:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bCz4KLrMPzmGpU8/if8ZnRryHO2GoJAiMAcLfeosWBc=;
        b=Eiq7g6+7X71KCA2EU3C/G8axhHDU8/9alMVpvE5YNhQJVrYSwB6rIqtfDqf+aQHWOQ
         OBap15ZrWR/VutgdqVf67bnwh4b75Slck43pe3Isnvz1C5cU7wkzOywQBVtXFb19X3JA
         B4Ul5sk++Z8lMfpqt4mZadvdEa0bJwjMVZhVoFz4QqcL8+TWm0d+6quQGpdV4lCXBKKm
         Ru89JTj8cg2nqGwUTqqobdBpuLxQPF2vh7DsfM00la2RsAqO4ISbo0aFlsam1vz3ifhV
         CzO8za7VOUSp8/y+aqPvnQ7/q02mToz6ALE5665oWEZ9jUmqRX3bSZs9ZOIFLiQ+4C1u
         NXZw==
X-Gm-Message-State: APt69E2S5akDnZNAa+iDDNiJL0/Op4VEY5NdtbrC4Z60tRUe0gunkNT2
        xSjFn858iX8u9AzjBvbMpw==
X-Google-Smtp-Source: AAOMgpe7RcXIvFbc0NjDmG1N+um/viSFhKnMsEHIBY6D4VuUARPaMY+hAkP6/tr19chsTWxmNnJhLQ==
X-Received: by 2002:aca:f20a:: with SMTP id q10-v6mr7804359oih.165.1530825605484;
        Thu, 05 Jul 2018 14:20:05 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p4-v6sm8235393oig.43.2018.07.05.14.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 14:20:04 -0700 (PDT)
Date:   Thu, 5 Jul 2018 15:20:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     wsa@the-dreams.de, afaerber@suse.de, linus.walleij@linaro.org,
        linux-i2c@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com
Subject: Re: [PATCH v4 1/6] dt-bindings: i2c: Add binding for Actions
 Semiconductor Owl I2C controller
Message-ID: <20180705212004.GA9185@rob-hp-laptop>
References: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
 <20180701172305.15663-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701172305.15663-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 10:53:00PM +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for Actions Semiconductor Owl I2C controller
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/i2c/i2c-owl.txt       | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt

Reviewed-by: Rob Herring <robh@kernel.org>
