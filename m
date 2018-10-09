Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590D1C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F3F213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QtDdEEwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F3F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJINQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:16:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33176 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeJINQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:16:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so271403pge.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 23:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=nhineWP9hseGNpXMeQQAIXvodxGH6hDyDKoIOkC+gig=;
        b=QtDdEEwClZRh0tpA1geDGvH8GJsnyRlGKuGMn+K0pzbvVpkZlzHDhK51DK+QDrfRNo
         +hn+zx3F7t5ZMKBiy5qkZnHLIZkyGJFHKe8KvExxfxU4TZNDfilqtG8M7gsvvkBr9ED+
         FEe3YQOZ6RfCtjvVaCiNzApq8biH8Vphhqu3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=nhineWP9hseGNpXMeQQAIXvodxGH6hDyDKoIOkC+gig=;
        b=d30NJ7WHgxodawUEX12+uR1PrA/C4M45TsNm2dk6Prt8ny7ysp5hJYxIDh6UhY99g4
         abB8SuVNDI9ZihEEgV9C8RXIf0REqfnFg2vEcyp18TFMLCIzvRisP/pGcdc4qTjsqhaq
         83RJ9rvOYj5OgKap7j7NXvVAcX0HP/szsELpEEjnh9E0sLrTOPSdVhHiu+vEQzPTaM6D
         x4Cz+mM94fmcBrfazPTmKavcLFB0hiBTPGJ0VlIf7TxBWrAzv8wBoesM8FDz7MjlaT0I
         qbVnd8/FAxVs+twVpGWRWiYEqo7mFcRTDvu3pL9tuO3CglYr6QUSunJDLb5+cQrydtPz
         0xXQ==
X-Gm-Message-State: ABuFfoj8S9V77bI4GnsslPhNm6NtNszvf4uQkCoc1T2lkW+LVQMfOyiB
        +PzZWMDo1xb9Ym3vONRQTioaOA==
X-Google-Smtp-Source: ACcGV60sfnTMPY5ZcEmXMDE3E+C4VXPvVrzD2so5MkXwErMCThuf6lED7nhZpftr3bRsELOZCtSoPQ==
X-Received: by 2002:a65:6144:: with SMTP id o4-v6mr18871411pgv.387.1539064876522;
        Mon, 08 Oct 2018 23:01:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 70-v6sm27886129pfz.27.2018.10.08.23.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 23:01:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     kbuild test robot <lkp@intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <201810091251.jzXVZxHH%fengguang.wu@intel.com>
Cc:     kbuild-all@01.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20181008163216.97436-2-swboyd@chromium.org>
 <201810091251.jzXVZxHH%fengguang.wu@intel.com>
Message-ID: <153906487527.119890.6761556114422000083@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/4] gpio: Assign gpio_irq_chip::parents to non-stack pointer
Date:   Mon, 08 Oct 2018 23:01:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting kbuild test robot (2018-10-08 21:56:25)
> Hi Stephen,
> =

> I love your patch! Perhaps something to improve:
[...]
>    net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx=
_stats.packets' not described in 'sta_info'
>    net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx=
_stats.bytes' not described in 'sta_info'
>    net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx=
_stats.last_rate' not described in 'sta_info'
>    net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx=
_stats.msdu' not described in 'sta_info'
>    include/linux/dma-buf.h:304: warning: Function parameter or member 'cb=
_excl.cb' not described in 'dma_buf'
>    include/linux/dma-buf.h:304: warning: Function parameter or member 'cb=
_excl.poll' not described in 'dma_buf'
>    include/linux/dma-buf.h:304: warning: Function parameter or member 'cb=
_excl.active' not described in 'dma_buf'
>    include/linux/dma-buf.h:304: warning: Function parameter or member 'cb=
_shared.cb' not described in 'dma_buf'
>    include/linux/dma-buf.h:304: warning: Function parameter or member 'cb=
_shared.poll' not described in 'dma_buf'
>    include/linux/dma-buf.h:304: warning: Function parameter or member 'cb=
_shared.active' not described in 'dma_buf'
>    include/linux/dma-fence-array.h:54: warning: Function parameter or mem=
ber 'work' not described in 'dma_fence_array'
>    include/linux/gpio/driver.h:105: warning: Incorrect use of kernel-doc =
format: Documentation Makefile include scripts source private: For use by g=
piochip_set_cascaded_irqchip()
> >> include/linux/gpio/driver.h:167: warning: Function parameter or member=
 'parent_irq' not described in 'gpio_irq_chip'

Ok! That was a little rough to pick out. Is there any way to mark
something as private with inline kernel doc?

