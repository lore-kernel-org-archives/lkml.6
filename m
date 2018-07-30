Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0AEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7006F20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7006F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbeGaAzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:55:49 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39709 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732038AbeGaAzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:55:49 -0400
Received: by mail-it0-f65.google.com with SMTP id g141-v6so1703383ita.4;
        Mon, 30 Jul 2018 16:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xss1/4xuqomBUoh2UIT2G9zChKz2bG2HfxEMx/RkQDw=;
        b=C3N3tYumh3+z3mjkD4XnUruE0raYQrEqijfSD5gyp6MCg80cN+su7GqQZavV0tCwCn
         /D22N/1BHJKeYB2Xvte7qD7uDVYMl0yudR9x7JZDRf1eilmNsi+qWC1d5/ZM+SxkGuMR
         EkcyBZc48TJGgms5ysXjDobnouu0iq9SDX6CQG3esceA8eds7G6z++td5z6P5/yHbWG2
         3UMa5NFz6JYTH5neOlQT0uf9SEZ2+SyfaiPMr85Dqj8SVd00RhddcUgKgS/j1Eb2UzX1
         ojGGZ0FjdyN1vFPXcsW9nINhZEOyBrhy8mErXcbIbKXOA7NA3f2nh13oykv75RYFvJE9
         dXJw==
X-Gm-Message-State: AOUpUlEeZ9knPDmi0Ge2qy7Q5OPsgKdlFsjucmeTmc/vzDTEH6etsUg9
        SpIi2OBoqvY31kFPT6wl1A==
X-Google-Smtp-Source: AAOMgpe+K+AxV0kMO2gmARkfzA1l7HSD7eZ24d/7vDcQMxpwUvTJK6UAA1t0t3Z437arTXejy5jFXw==
X-Received: by 2002:a02:b804:: with SMTP id o4-v6mr18521339jam.12.1532992710966;
        Mon, 30 Jul 2018 16:18:30 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id g18-v6sm392265iti.4.2018.07.30.16.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 16:18:30 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:18:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        mark.rutland@arm.com, afaerber@suse.de, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pn@denx.de,
        mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com
Subject: Re: [PATCH v3 3/5] dt-bindings: pinctrl: Add bindings for Actions
 Semi S700 SoC
Message-ID: <20180730231829.GA11190@rob-hp-laptop>
References: <20180729182551.19383-1-sravanhome@gmail.com>
 <20180729200038.11795-1-sravanhome@gmail.com>
 <20180729200038.11795-4-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729200038.11795-4-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 10:00:36PM +0200, Saravanan Sekar wrote:
> Add pinctrl and pio bindings for Actions Semi S700 SoC.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../bindings/pinctrl/actions,s700-pinctrl.txt | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/actions,s700-pinctrl.txt

Reviewed-by: Rob Herring <robh@kernel.org>
