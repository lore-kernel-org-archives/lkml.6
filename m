Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1C7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B76F2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="decQ0ZtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389143AbfBNJN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:13:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53849 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfBNJN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:13:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so5442003wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f7e3kTZ/h37QMmqsr6zq1fomaVECBSv/YeeeOVLCxjc=;
        b=decQ0ZtU1AuDmPsSeb/Btky4HOIU3Fsuz8ubE3BsncHneQonWJMfMS5ub5ebMmau5D
         afs9ZKt/nFOdS+DnXX1OrZ+MPRsGAMa51bzgK0cXwfUBRF0QcqPiQKv3HseZIbuiFlD/
         Da5E5n6a+IqVfMSJEJx7WiVi88/q5J6DkeTMog7BhB6xq2fUhyX7fJ/z1TFlbr4GFdAI
         ftR8TqGxgbr0SsneDaUq06Lk8jiM4Amqv9vz4aQXY9G+3CCvbYS5tqeEtBskp2w8cZqM
         rillOItSLG64vQ1gmvBALeYaBSg5BR8qEQcuKhwMjAFE+uIbaMVAAYOH46KEBSZhHiNL
         8W6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f7e3kTZ/h37QMmqsr6zq1fomaVECBSv/YeeeOVLCxjc=;
        b=UIgpfTpLw2D4utsfc3f9GIOs5ond9gGOgqMeHda+dsQWthpEH2NKQcjKaEj3AlG3GS
         jDu8kRjQDs+3KAiZSm9qizQsX697hcS1Y6fd0PObDa5YMzGQkzkpv3k1e/c4oiyzSIrA
         fg1OTkkgJQg4MWpm/LXsJjH21y+uQ/BFrZ7iqdj2fzwAjiLpecUnmRNBZuQXZ2udl3gt
         x8g7ZgC84Vg+6epb/1FeHGYr6JXTIL53ky3q04zDwZf7/uCBNK1pc/FIljvGKl4H91x5
         vpAjzfaxsHgT7StfmPmhYlGWfDTO2hmzttpEpENYyhyqilrNx0UKd2dttsN/0ov2tfck
         SmJw==
X-Gm-Message-State: AHQUAubdKy7FI7770AHZjcw9lu4d3hVAvenwcXPml+OWFPDWgBpy6DkO
        SrEbwqeS67wt6spHNBlxR8roF6diegQ=
X-Google-Smtp-Source: AHgI3IZ3xTqf6hlNByM2OQeFTZV0Cs2atfmCJ4VliuVfqhDo9otdAHBLgy2YZ33NUUWMQpa6HbvUuQ==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr1729150wmh.119.1550135635611;
        Thu, 14 Feb 2019 01:13:55 -0800 (PST)
Received: from dell ([2a01:4c8:c:28c9:4c60:37da:d7a:230])
        by smtp.gmail.com with ESMTPSA id x8sm956546wmj.26.2019.02.14.01.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:13:54 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:13:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org,
        Emeric Dupont <emeric.dupont@zii.aero>
Subject: Re: [PATCH v6] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20190214091351.GA13737@dell>
References: <20190208230622.15181-1-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208230622.15181-1-andrew@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Feb 2019, Andrew Lunn wrote:

> The QMX86 is a PLD present on some TQ-Systems ComExpress modules. It
> provides 1 or 2 I2C bus masters, 8 GPIOs and a watchdog timer. Add an
> MFD which will instantiate the individual drivers.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/mfd/Kconfig  |   8 ++
>  drivers/mfd/Makefile |   1 +
>  drivers/mfd/tqmx86.c | 281 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 290 insertions(+)
>  create mode 100644 drivers/mfd/tqmx86.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
