Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89664C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAE72171F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAE72171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbeHNXft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:35:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45627 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeHNXft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:35:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so9764024pfo.12;
        Tue, 14 Aug 2018 13:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7oXHCN6uSXvNrFyIIIzCQX+EEdOjX+dTPdanTGU8HH0=;
        b=pPVKU+VpXn9Ro9vGC5qwuwG4nWPR9H5Uxng+9HDFwrSDmqTA6bvF9EMt0fX2kF+6m2
         axIQS1PFl9DHQeksIN524zCgJvsWMJGes9gskdOxDR59viDUhXpFdqqFsu25v0Oj8OOf
         pjcR6Ox1CaWZQwjDEY0xxBVWYVsuBi48DMb2zUTd61gnDzkdzp1MgaTgKQJvmVS3Gtjw
         68GFFF8XUsJtiktwSocUMtume6OgLl++NQQCY5mi0q9mvPzlZIHWyR2wzbO4J5meu/Ir
         rFVmhkIsCTde8yEncrTnacQgKW61lCIHLE6j7qtuvPVdtKZ3CN5g/8Qs/FdQ59SYaUOL
         JSsA==
X-Gm-Message-State: AOUpUlFJh0IUUH6MUz3a4+0+RqOASuO9uaMbqywT+MIHpcrUmOp7k8+q
        DTg7WXtoGWpTE7sqUIWCSY2avBY=
X-Google-Smtp-Source: AA+uWPyV6XF3arKlW4oqeSlY7qAWs7ImD+QpqqKAYiUI424oo5NoR9QDXGID4/de658p8VybFttG0g==
X-Received: by 2002:a63:5055:: with SMTP id q21-v6mr21698376pgl.397.1534279613229;
        Tue, 14 Aug 2018 13:46:53 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id p19-v6sm35403849pgk.28.2018.08.14.13.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:46:52 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:46:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: vadc: Fix documentation of 'reg'
Message-ID: <20180814204645.GA8696@rob-hp-laptop>
References: <20180808191339.16875-1-mka@chromium.org>
 <20180808191339.16875-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808191339.16875-2-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Aug 2018 12:13:37 -0700, Matthias Kaehlcke wrote:
> The documentation of Qualcomm's SPMI PMIC voltage ADC claims that the
> 'reg' property consists of two values, the SPMI address and the length
> of the controller's registers. However the SPMI bus to which it is added
> specifies "#size-cells = <0>;". Remove the controller register length
> from the documentation of the field and the example.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
