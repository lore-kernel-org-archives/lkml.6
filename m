Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wNqQG3S9GFvHFAAAmS7hNA
	; Thu, 07 Jun 2018 05:07:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4E3AA6089E; Thu,  7 Jun 2018 05:07:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3Nsm4/B"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A66C66063F;
	Thu,  7 Jun 2018 05:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A66C66063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeFGFG5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:06:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54683 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752336AbeFGFG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:06:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id o13-v6so15275876wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 22:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=T6cMgT9Hi0s/ZSriMEJ1/E7XQx5AFKeemrAYgNTbaNY=;
        b=X3Nsm4/B47DVt0Fq7ScmbTd0pEnRbzgFw2wWmeiusq4MVQFUAHA0XviWKB8W89ZKbe
         rDGu6nBfBChAl3aQ+WAvg8jl7SBoLBETCAQXcsQk43R1gbsnbQgTzEotVUeaFgOad0NO
         FwzhCAfbxA+i3JSy6jApaxbiJr/V5aaT8OTWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T6cMgT9Hi0s/ZSriMEJ1/E7XQx5AFKeemrAYgNTbaNY=;
        b=UowjAIjCfyio83BkCAXkwDP1wWAGyzITEf8kIcL8L/8vCcmutnXcNrFauB8LhMJlig
         bhnrpHmbcv0/yFMF4ci450yYe3f86MpkB32c9KpFLFunPXALSduOVLnQfM+WLjGjVkBx
         YgV0GirtJ6Vgb0IVIwuB/0VYBi/qDhR5ArKQHCADP7w8xo9LQZd37v7s1i+qHovA++O6
         rru4GubGvku5igYZZHXZahJdRT+5bjV4zRzFBGkKm9/9HkVTimfT48jKrFREwSTABNSR
         7gU+8Q8iuk/7zbtsPw2++hrCa5SFX2e/F9n3EAB1SkiP7p+mJMZBL5ubzp2zAK9lOVis
         5XCw==
X-Gm-Message-State: APt69E1MVRh5PrJuvn8z6TprFw4rJptzkpHc3iNty4CWkhgCSM0GFIcb
        M15d67+QXRtjW/b7cPsb0vyecw==
X-Google-Smtp-Source: ADUXVKJApYXwfisB3GKFNoeAsDHrRVpwIBVUrFhCgGjbyRp7Nm68E0tAVBeOo1uz9At+TwYuuTNgyg==
X-Received: by 2002:a1c:7192:: with SMTP id d18-v6mr418568wmi.115.1528348014980;
        Wed, 06 Jun 2018 22:06:54 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id t66-v6sm935630wme.6.2018.06.06.22.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:06:54 -0700 (PDT)
Date: Thu, 7 Jun 2018 06:06:52 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: fix build warning with CONFIG_DMA_ENGINE
 disabled
Message-ID: <20180607050652.GC21163@dell>
References: <20180525210843.1821071-1-arnd@arndb.de>
 <20180606081827.GD11810@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180606081827.GD11810@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jun 2018, Thierry Reding wrote:

> On Fri, May 25, 2018 at 11:08:30PM +0200, Arnd Bergmann wrote:
> > Without dmaengine support, we get a harmless warning about an
> > unused function:
> > 
> > drivers/pwm/pwm-stm32.c:166:12: error: 'stm32_pwm_capture' defined but not used [-Werror=unused-function]
> > 
> > Changing the #ifdef to an IS_ENABLED() check shuts up that warning
> > and is slightly nicer to read.
> > 
> > Fixes: 53e38fe73f94 ("pwm: stm32: Add capture support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/pwm/pwm-stm32.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Applied, thanks.
> 
> Lee, I applied this on top of your immutable MFD/PWM branch because it
> depends on the capture support that you applied. I wasn't sure what your
> PR timing was going to be, so I thought I'd do it this way since I'm
> pulling in some last minute fixes for v4.18.

I don't see a problem with that.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
