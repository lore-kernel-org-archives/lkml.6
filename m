Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952DEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5120D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5120D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeG3XYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:24:05 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40537 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbeG3XYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:24:05 -0400
Received: by mail-io0-f195.google.com with SMTP id l14-v6so11185039iob.7;
        Mon, 30 Jul 2018 14:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WQK6FvjTxfJSvSQBv5w7qSWyweNcGOAW89uXnqjvF2o=;
        b=oQ9tjr45wWtL+Ztqc4VGJlZvRBuRHnYnnSuHDb2w/B+ZNj+6MYzgh0K1yL1A+LZuon
         ZAKrokG1wiF1v/EH9VuHhcXGxy+z61npXG2+Rc8rOZ1riiG7LuRSidcNlMiMgAMwAce4
         Ad5oO+6dFrjiHyjMIBOPpClyo3D2WUZg5FSdb2KAAMinHk3UyHMXRJ7gRey06sn3Lbmj
         OZEQ0XIkiFzCe5qHwoko0kNf5B73anOFkmnw4xia1DbaxVrTOjdR9DkXCaz8t3a05lUA
         qlw/8obW486K2L41mUh/DVL55apfehVOivFRvhTLM9UNCpFtOmXJNQFD+QyFyP0SPtFz
         77IA==
X-Gm-Message-State: AOUpUlHwd0NPyQS7tJAnnBbjW+db6JIq2xD9CXMtRKRQ1aheccivrAR7
        BSCQLuliqeO0PAtnxRo1HA==
X-Google-Smtp-Source: AAOMgpeWbnEYeZEkmb7AW+113RMiUOH4jclwrzXOkYmBl5KvZj+Gdxb/iEctDICyhAxpKk3GIDtdBA==
X-Received: by 2002:a6b:d611:: with SMTP id w17-v6mr15492777ioa.216.1532987226992;
        Mon, 30 Jul 2018 14:47:06 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id m1-v6sm2063239iok.81.2018.07.30.14.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 14:47:06 -0700 (PDT)
Date:   Mon, 30 Jul 2018 15:47:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     broonie@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add DT bindings for UniPhier
 SPI controller
Message-ID: <20180730214705.GA25882@rob-hp-laptop>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-2-git-send-email-hayashibara.keiji@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532588943-19481-2-git-send-email-hayashibara.keiji@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:09:02PM +0900, Keiji Hayashibara wrote:
> From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Add DT bindings for SPI controller implemented in UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  .../devicetree/bindings/spi/spi-uniphier.txt       | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt

Please add acks/reviewed-bys when posting new versions.

Rob
