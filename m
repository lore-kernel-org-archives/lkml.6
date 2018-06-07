Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5ak/Bbm9GFtWFgAAmS7hNA
	; Thu, 07 Jun 2018 05:08:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EE7496089E; Thu,  7 Jun 2018 05:08:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="euEcTOeY"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 476926063F;
	Thu,  7 Jun 2018 05:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 476926063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeFGFIF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:08:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35186 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeFGFIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:08:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so16166920wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 22:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=saN0P3aMk8uZ7XdzVkuQgIQh9rnFYnS3HHSOAGCTEFA=;
        b=euEcTOeYagOzfjLceWsWIGdbReHA8sRBWVddL9hb70KLsLxLlAnsXNR2mB4wl/Gj8x
         rMxZ6pyFaphGH0XhMoBAK+sTpJZZM6wpUtgX6ZXiEWwUUQ9aB4ZuwUIYjAu52wLCH6Xv
         +Gw823hSZI8CzAgJ1xscYHCOGi801SrhLLT04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=saN0P3aMk8uZ7XdzVkuQgIQh9rnFYnS3HHSOAGCTEFA=;
        b=F60XwAx8gcWtDGramIzS8s4osgbwkocIhNCF2gsdU7RxO9j+XjdT8Sh7shUJ3mXt1W
         YQyVG97+xtHvu7CYoPlhAhYX4b+TiHTB8QjZm1RJI/TxckhmavgjHIamHHyGYdjDHKGq
         2Q2kuEHr4QYA3cpC7mXhPh+HWPbbqmZjfxe3RG/xug7lrDTjVB3AXyPGHw3etBDkxvB8
         Z0FVUrtlRslWgH3uzTcNq0ZcvRr08tlU0L+weVttcLcIwFYpsxRrv2De0DmywOWeh+xz
         SstHjQLzx7SuDDeLzRP63k6vpRBeyfvTSQmT6mkzp2iHzTMv148IHFlK56YNLmlfoX5B
         8Eng==
X-Gm-Message-State: APt69E22HTuLX++esIFPks7E33OoJCKPOP8zTNvhFn3WicG+88NgzifF
        rx87sPZbtPCERk1ndXU5p996VA==
X-Google-Smtp-Source: ADUXVKIE9gZ45IbVwfNtJejC4ebgCS+5u8VE9kW8uxtNhyeUlPPWWZ4QQ5/+pD4UccvfYgZ5rS9RLw==
X-Received: by 2002:a1c:5ec9:: with SMTP id s192-v6mr425915wmb.54.1528348082885;
        Wed, 06 Jun 2018 22:08:02 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id f133-v6sm600639wme.42.2018.06.06.22.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:08:02 -0700 (PDT)
Date: Thu, 7 Jun 2018 06:08:00 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: enforce dependency on CONFIG_MFD_STM32_TIMERS
Message-ID: <20180607050800.GD21163@dell>
References: <20180525160523.29124-1-arnd@arndb.de>
 <20180606081314.GC11810@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180606081314.GC11810@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jun 2018, Thierry Reding wrote:

> On Fri, May 25, 2018 at 06:04:54PM +0200, Arnd Bergmann wrote:
> > When compile-testing the pwm driver without also enabling the
> > stm32_timers MFD, we run into a link error:
> > 
> > drivers/pwm/pwm-stm32.o: In function `stm32_pwm_raw_capture.isra.6':
> > pwm-stm32.c:(.text+0xcb0): undefined reference to `stm32_timers_dma_burst_read'
> > 
> > We don't need the '|| COMPILE_TEST' here, since stm32_timers itself
> > can be built with CONFIG_COMPILE_TEST on all architectures, so we do
> > get the coverage through allmodconfig and randconfig builds even
> > when we make it a hard dependency.
> > 
> > Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/pwm/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I think Lee already picked up a patch by Fabrice that fixes this by
> adding a dummy implementation, see:
> 
> 	http://patchwork.ozlabs.org/patch/916435/
> 
> I prefer your solution, though, because the dummy is pretty redundant if
> we can just make this a hard-dependency and still get the same coverage.

The two patches aren't mutually exclusive. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
