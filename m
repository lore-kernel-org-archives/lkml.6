Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2637FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C446120833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C446120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeIZAlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:41:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43426 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeIZAlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:41:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id s69-v6so2357651oie.10;
        Tue, 25 Sep 2018 11:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ye47JgaO2TqN+EivFgNvZuYZmFHgW6zdnJSGAS9zKOI=;
        b=ggJJ6yW8v4zdSY2PxSZoRxGqQoVfl6rF3u4f6RmJ+hd/R4qTqf5Y0U9QqN26cClJWC
         D5QscHMuOpQwAyqJ1wUCzlF0CvuhArwjy5vQVEnpCSDm6A7rTXMPFKQWBab5wOvEHV5l
         vHAJnMX1utRU3ZsXM9/kfCEDx/iTikIF2b2SHLqZDrDq47P7aouHv+66v6zLifkfLwVX
         ggGwaq0bDpPIygLNgYxLdWn9YP1h76MyINSBW7QtnXnRpQW2q+9wr2TfZJYr+VaE6Y7y
         9/5bfpd3siqYx8YqzkTrnblF6aU0XnMN6lLxm3sXWD1TGSKFWJXXZRHTF81m32V+1hrX
         ng/Q==
X-Gm-Message-State: ABuFfog5msGUSJ20Ka4RHHhgLUmJf+0upEkQ5+ILHUzDbtqg3V0LCcdo
        E8e+WnyMYpXU7w8j9DydYw==
X-Google-Smtp-Source: ACcGV61pf8NMBS0+T9rAFgT8CiAGACE6bnIf9PpkRcDdVhdLzhp3AOEOcHaSnGpyT4BjeQ7bvGNTyQ==
X-Received: by 2002:aca:3254:: with SMTP id y81-v6mr1449821oiy.317.1537900373438;
        Tue, 25 Sep 2018 11:32:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f15-v6sm1011837otf.34.2018.09.25.11.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 11:32:52 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:32:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 34/34] ARM: tegra: apalis_t30: support v1.1 hardware
 revision
Message-ID: <20180925183250.GA25639@bogus>
References: <20180831163817.23970-1-marcel@ziswiler.com>
 <20180831163817.23970-35-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831163817.23970-35-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 06:38:16PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Support the V1.1 hardware revisions with the following change:
> 
> Changed power rail for MMC1 interface to a 3.3V/1.8V switchable rail in
> order to be able to run UHS SD cards in ultra high speed 1.8V mode.
> 
> [  207.502011] mmc2: host does not support reading read-only switch,
>  assuming write-enable
> [  207.517011] mmc2: new ultra high speed SDR104 SDHC card at address
>  aaaa
> [  207.534190] mmcblk2: mmc2:aaaa SE32G 29.7 GiB
> [  207.545096]  mmcblk2: p1
> 
> root@apalis-t30:~# cat /sys/kernel/debug/mmc2/ios
> clock:          208000000 Hz
> actual clock:   204000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      2 (4 bits)
> timing spec:    6 (sd uhs SDR104)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> root@apalis-t30:~# hdparm -t /dev/mmcblk2
> 
> /dev/mmcblk2:
>  Timing buffered disk reads: 256 MB in  3.02 seconds =  84.71 MB/sec
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---

> +	panel: panel {
> +		/*
> +		 * edt,et057090dhu: EDT 5.7" LCD TFT
> +		 * edt,et070080dh6: EDT 7.0" LCD TFT
> +		 */
> +		compatible = "edt,et057090dhu", "simple-panel";

"simple-panel" is not a valid compatible string.

> +		backlight = <&backlight>;
> +		power-supply = <&reg_3v3>;
> +	};

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
