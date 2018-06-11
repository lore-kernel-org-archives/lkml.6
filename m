Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IKoFJSczHltzAwAAmS7hNA
	; Mon, 11 Jun 2018 08:30:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7DFD560792; Mon, 11 Jun 2018 08:30:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIlT50x1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C7219605A5;
	Mon, 11 Jun 2018 08:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7219605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754153AbeFKIa2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:30:28 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35167 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbeFKIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:30:27 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so3498064plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rKsH6h21S4Av4ek6tF4A1+SPdgBgmki2gHW1VJeUlgU=;
        b=MIlT50x1RYKTQ9QNGxQmdrmm7pZdHZ+ioV78+nbDnyuTorQ2tNBHHNFwMeCVP6P0Nd
         6pLbAdXTw5T54iYKY2HTSlN3Hh6AGp9NjRFpSNwYX/mJvNP+WyRc3+ls0udCkoHUdmY4
         3yZw4SNoI2K70rVkstBI+OvHhbAnMiTrq3UAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rKsH6h21S4Av4ek6tF4A1+SPdgBgmki2gHW1VJeUlgU=;
        b=AohY1WOTi3YEO4Lw30N0Xd2X4BtW7kTWbSsxToM6W6Jiqhi5RWJq4eTH2Mp6+rw5b1
         aNRevrjMTtfIlDChe7Kngihi6BcoyCT/RpWslw/DpU7bTR6AQPNh1QEu5Eo2Cj6n2IdI
         7XwzojhdF8WqW0zPnHHHD/73SGSyXU3XH1xmbuuNDcLVC0y0ssck76QI8n6uFWs1+qWp
         beJ6ue3lDMgVs2Gv6N6Kx2nFFCR5mbL+/1tB5554kewjfTxNL92ueES0hngnd99dXYR8
         BffS+XH36KjX/cOV6wUU1kVJ2gGFQ+RwWOUX0IuNscII25rz7s2YPgy7tYbTJYopsZql
         sRmw==
X-Gm-Message-State: APt69E2EQFOcKx8uXybwjmMzMxLVQVOnQw3wCyPZDJyRAEMqPG0unppx
        SrDbxfqqICNSmAUhxm7+wSoi8Q==
X-Google-Smtp-Source: ADUXVKJ9faFM1HFAmRvX5kEl3WsD+lS7OmmC3RRDwAO8QlBDA9JyxomtjVsNY97xOdjuZ05/k5TEVw==
X-Received: by 2002:a17:902:bd05:: with SMTP id p5-v6mr6415261pls.32.1528705826602;
        Mon, 11 Jun 2018 01:30:26 -0700 (PDT)
Received: from localhost ([223.226.91.101])
        by smtp.gmail.com with ESMTPSA id b5-v6sm83992340pgc.16.2018.06.11.01.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 01:30:25 -0700 (PDT)
Date: Mon, 11 Jun 2018 14:00:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@linaro.org>, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>,
        Bryan ODonoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH] MAINTAINERS: update two greybus sections
Message-ID: <20180611083023.rc3diriib6v3er5q@vireshk-i7>
References: <20180611074202.10668-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611074202.10668-1-johan@kernel.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-18, 09:42, Johan Hovold wrote:
> Fix a file entry typo and drop the obsolete timesync entries, which were
> all caught by:
> 
> 	scripts/get_maintainer.pl --self-test=patterns
> 
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
> 
> This has been reported and at least partially fixed in the past, but due
> to various other clean-up work that was going on in MAINTAINERS at the
> time, was never applied.
> 
> Johan
> 
> 
>  MAINTAINERS | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9c125f705f78..09d7f9eb5c13 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6065,7 +6065,7 @@ F:	drivers/staging/greybus/bootrom.c
>  F:	drivers/staging/greybus/firmware.h
>  F:	drivers/staging/greybus/fw-core.c
>  F:	drivers/staging/greybus/fw-download.c
> -F:	drivers/staging/greybus/fw-managament.c
> +F:	drivers/staging/greybus/fw-management.c
>  F:	drivers/staging/greybus/greybus_authentication.h
>  F:	drivers/staging/greybus/greybus_firmware.h
>  F:	drivers/staging/greybus/hid.c
> @@ -6074,12 +6074,10 @@ F:	drivers/staging/greybus/spi.c
>  F:	drivers/staging/greybus/spilib.c
>  F:	drivers/staging/greybus/spilib.h
>  
> -GREYBUS LOOPBACK/TIME PROTOCOLS DRIVERS
> +GREYBUS LOOPBACK DRIVER
>  M:	Bryan O'Donoghue <pure.logic@nexus-software.ie>
>  S:	Maintained
>  F:	drivers/staging/greybus/loopback.c
> -F:	drivers/staging/greybus/timesync.c
> -F:	drivers/staging/greybus/timesync_platform.c
>  
>  GREYBUS PLATFORM DRIVERS
>  M:	Vaibhav Hiremath <hvaibhav.linux@gmail.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
