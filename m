Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0eKlDSYkGls5awAAmS7hNA
	; Fri, 08 Jun 2018 06:37:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 089D5607DC; Fri,  8 Jun 2018 06:37:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S6UxBUF+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 091D460275;
	Fri,  8 Jun 2018 06:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 091D460275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeFHGhX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:37:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:47059 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbeFHGhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:37:21 -0400
Received: by mail-wr0-f196.google.com with SMTP id v13-v6so12137597wrp.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 23:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F1yY6br/DCsQAg3+VfOEVYqQ3V8ENlZ+kX4xg6J/K6w=;
        b=S6UxBUF+xRw64XcPzlrIyGQNpE+iO3L4hCC46lJ7V4s3UhHSKV3nPenap9nw7PS5xn
         +FEeveAaqafxShzO/+sS3K5EAk3tzy0QOayxU349AwkaJxZjyKWtP/Y0i/o748D/S8Y/
         BUCKnqg6LIoHgff1Tucjgbjrcdb0uOK1AGZlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F1yY6br/DCsQAg3+VfOEVYqQ3V8ENlZ+kX4xg6J/K6w=;
        b=IqnrgqORtW9HuklMCkj/ZUXqkgWMLWS7v0v63nzE/80WkXJdnH/2RaXXZY59ICmysQ
         91X8YjiFj7GyBMpBivZI5Zwklt/IxuBIEVMkcdAu6KuF9cht0Zyj8yrujRcLIoGdPPDY
         Aihtbe/VRhgGCddTiwBy2Hlr7bLCAEN6GxMQJ5UHsUmj4dar2PJIr1oEnZ4ZxWesjTOz
         O0yEvvXJcYw2KY0OTUs1DjDPHXqGEfg/w/mqlj+0HClwOL27Jr1FaxzilvP1Xpx3yvtE
         caR3G2TrnIYhZcfQJTAYeLC+OuN6Ll5JlyW4xcnPTZXeLQUMNPBF7/3pQ6pKREKuYObo
         nHjA==
X-Gm-Message-State: APt69E1IdqokA5xNImh36KM9kkc89M/pDTonhxeLdKJKqDEr55pKXljV
        8EMa+xxJoyOA8krmiBLCqSfvEw==
X-Google-Smtp-Source: ADUXVKIrSdMMPYjXdZtpHjzuBzjKR6VREHdQdx+bya3qMRcqp13lypCkSlRUkJkUjGRryD8EqfKM6A==
X-Received: by 2002:adf:a032:: with SMTP id k47-v6mr3831920wrk.202.1528439839930;
        Thu, 07 Jun 2018 23:37:19 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id s132-v6sm840040wmf.5.2018.06.07.23.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 23:37:18 -0700 (PDT)
Date: Fri, 8 Jun 2018 07:37:16 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 01/14] mfd: da9063: Replace regmap_add_irq_chip with
 devm counterpart
Message-ID: <20180608063716.GA5278@dell>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
 <019675f0-13ff-d381-87d1-891316cbfd83@gmail.com>
 <20180607124159.GD22841@dell>
 <d62db199-0255-fcde-1de0-5d335d596dc1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d62db199-0255-fcde-1de0-5d335d596dc1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jun 2018, Marek Vasut wrote:

> On 06/07/2018 02:41 PM, Lee Jones wrote:
> > On Thu, 07 Jun 2018, Marek Vasut wrote:
> > 
> >> On 06/06/2018 11:59 AM, Marek Vasut wrote:
> >>> Use devm_regmap_add_irq_chip() instead of plain regmap_add_irq_chip(),
> >>> which removes the need for da9063_irq_exit() altogether and also
> >>> fixes a bug in da9063_device_init() where the da9063_irq_exit() was
> >>> not called in a failpath.
> >>>
> >>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >>> Cc: Lee Jones <lee.jones@linaro.org>
> >>> Cc: Mark Brown <broonie@kernel.org>
> >>> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> >>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >>> Cc: linux-renesas-soc@vger.kernel.org
> >>
> >> So it's just this one patch that's missing AB/RB and the series should
> >> be good?
> > 
> > Looks fine. Although we'll let it sit for a while in case anyone else
> > has any thoughts.
> 
> Fine by me.
> 
> > The merge window is currently open, so there is no rush to apply.
> 
> This is still 4.18 material ? Hum, OK.

You mean this could be added to v4.18?  If so, not a chance.  I
normally cut off accepting trivial patches at around -rc6(ish).  Large
sets like this require a longer soak in -next for all of the build
bots and testers to have their wicked way with them and for potential
merge conflicts to show.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
