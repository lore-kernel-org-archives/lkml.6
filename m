Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44CBC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7626221899
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7626221899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbeHMSHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:07:07 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52207 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMSHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:07:06 -0400
Received: by mail-it0-f66.google.com with SMTP id e14-v6so13627897itf.1;
        Mon, 13 Aug 2018 08:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ocbgtEahqKRjgPeqHg39tIUlKOf/rjKNIllWuWkaAmY=;
        b=FpaP8Ib1FE79/MFsLI6Y3WbhcObxt7aq7Fje2V4KKTGJmTzjxMW18dN4kG1gt68mM+
         JpWDeGVZDImhRhxq4ed3JktAHMQ1NMaSkrT9nOlHS86JsO+CmrJ9WeLsIgQMlNe0mfus
         HM/G2wv/kZeDk63NzPeJooiTiqBGqVXok7y6o8FoqOUJ+45xjgFf2oYVhCHvW8r77aFe
         XSuQRrNbyP6YDzyeAx+bWukhEOYsWAiAZyeO93wQlChwUZmolN1AU+DBkysG0LfV/b74
         PKVNPg53pus6Sw3MTDozDCJCPUptmR3u5ndmS9hgVoBlO+mxwQ6qnkmvhW1miMB5fX6T
         hUhA==
X-Gm-Message-State: AOUpUlFUQdmBohsZspsDrn95z+mrEFMV5gRvVBCpq7AwXIGBHM+h+AOh
        2ITkDLxuvFxHkpuVg7p5K9ZRBMY=
X-Google-Smtp-Source: AA+uWPxlHcQyHznD8zmn8GUxPhyBYhVH9xhP3V9ni/lNHx4qJsgcE1xoMZ39djlSqaEeC6Qejlx7pQ==
X-Received: by 2002:a24:3c53:: with SMTP id m80-v6mr11034591ita.86.1534173864245;
        Mon, 13 Aug 2018 08:24:24 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 14-v6sm5839462itu.20.2018.08.13.08.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 08:24:23 -0700 (PDT)
Date:   Mon, 13 Aug 2018 09:24:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 04/24] dt-bindings: Add doc for the Ingenic TCU drivers
Message-ID: <20180813152422.GA18650@rob-hp-laptop>
References: <20180809214414.20905-1-paul@crapouillou.net>
 <20180809214414.20905-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809214414.20905-5-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 11:43:54PM +0200, Paul Cercueil wrote:
> Add documentation about how to properly use the Ingenic TCU
> (Timer/Counter Unit) drivers from devicetree.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |  25 ----
>  .../devicetree/bindings/timer/ingenic,tcu.txt      | 134 +++++++++++++++++++++
>  .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  17 ---
>  3 files changed, 134 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt

Reviewed-by: Rob Herring <robh@kernel.org>
