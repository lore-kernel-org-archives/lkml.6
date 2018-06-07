Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +eA/OQwoGVsKewAAmS7hNA
	; Thu, 07 Jun 2018 12:42:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 54643608BA; Thu,  7 Jun 2018 12:42:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0+QsOI+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 24770607DC;
	Thu,  7 Jun 2018 12:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24770607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932637AbeFGMmI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:42:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51251 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932456AbeFGMmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:42:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id r15-v6so17809238wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 05:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JITfRUA35l09IgWVHykUbsr1yeW+qAmwu9QC7+6b6i8=;
        b=W0+QsOI+tiZKKyGiNQc/TsM+fibNwdkuPnvxKvqiHkvrKdX4HJeneprnm3cHyzNZjH
         htZPmbPB9fBurLsOEqZMJ+sZTFJhMsmWtN3LtZ+jRq90evvbcJAIA4ojZDFJ5dzpz4ON
         S991SzMGYIVWPMUiE4AQuO1bclqFtm2yUz+c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JITfRUA35l09IgWVHykUbsr1yeW+qAmwu9QC7+6b6i8=;
        b=TDMTJGteBqI1x7n5FhsbwZvpIQiM25CMsVtgFO9E6xtBQhmuPWvIxFlKd/KR7woZkg
         jdyd8+Ih+ziPTZgFlMGJzfU1FGXMteu4fW85pmeKwpvhTb9RYmATMASROAym4T8ItX//
         H6rCuEhCK7/+SDJix4lgtCrK4CYZOTX67RqM+7/jgtL1nWobpNLuae7mj3A5G7sOPxEg
         zyzpnACbgCuX5kvrwa8rUEGyJXdqWDkRwwfcGRtzuZ7eAZGPEBX5M7NB9r9siG/TbMqP
         /K+2bE7JonjXaRtNMJW7UkIXjQ/9Yw6SJFNnHwrzR7mf4R/TURf/N7wgmUTfWSMbefKW
         rVsw==
X-Gm-Message-State: APt69E1eSzf+mhU4VdXyHs8TfZqq6U36pnaNy2fYT88jpNd3W2czpZs+
        m5Ep4ziRNmEwvvdRUGoXGzW9ZA==
X-Google-Smtp-Source: ADUXVKJ2+nez1L+SRptf/MsBtDKt/m8Vxcj2+AV8D79pKobxjEuTQGOGx7MXUnBV+M7BodmQATFs/w==
X-Received: by 2002:adf:f98a:: with SMTP id f10-v6mr1596321wrr.105.1528375322811;
        Thu, 07 Jun 2018 05:42:02 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id j4-v6sm1898410wrr.47.2018.06.07.05.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 05:42:01 -0700 (PDT)
Date: Thu, 7 Jun 2018 13:41:59 +0100
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
Message-ID: <20180607124159.GD22841@dell>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
 <019675f0-13ff-d381-87d1-891316cbfd83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <019675f0-13ff-d381-87d1-891316cbfd83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jun 2018, Marek Vasut wrote:

> On 06/06/2018 11:59 AM, Marek Vasut wrote:
> > Use devm_regmap_add_irq_chip() instead of plain regmap_add_irq_chip(),
> > which removes the need for da9063_irq_exit() altogether and also
> > fixes a bug in da9063_device_init() where the da9063_irq_exit() was
> > not called in a failpath.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> 
> So it's just this one patch that's missing AB/RB and the series should
> be good?

Looks fine. Although we'll let it sit for a while in case anyone else
has any thoughts.

The merge window is currently open, so there is no rush to apply.

> > ---
> > V5: New patch
> > ---
> >  drivers/mfd/da9063-core.c       | 1 -
> >  drivers/mfd/da9063-irq.c        | 8 ++------
> >  include/linux/mfd/da9063/core.h | 1 -
> >  3 files changed, 2 insertions(+), 8 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
