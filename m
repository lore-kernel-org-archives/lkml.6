Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97227C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7D220865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncMp3oMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7D220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeKXWKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 17:10:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38596 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeKXWKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 17:10:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so12607409lja.5;
        Sat, 24 Nov 2018 03:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8BCTsIeg29xg+ETx6XEKOtqowjQ2HP+AXy8qQTcJspA=;
        b=ncMp3oMs1R1nkcsPCeOWCkr0j+TB1YxSpCGP0JNw5n87wlPhY7Yw/8Cf8AX1AqlCU6
         A8OpPNWniEg3jnfveRcU7J0I+w1G23XppNB18k7sDxPuwEwS9M3a3meHgPEc3wFr4m3D
         8Z9l/E7k+jUx30LEA+19CeVuuy220OjFApTd6X27kNHANKLC7Bb4ctjcGwAYvFvg7vdE
         LJlzneI2RZD3pQH/586NShmFpWG7zO7EMUt1DCRMqt/z0H6lB94PxQP3uDplSrt+8nOR
         ANDBWmjS5lxg2Y5gdwlp0uRefGnIkZZt0/BiZ1jD01mOS8UC3HqG7QSrTUtu52llfZ9M
         eFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8BCTsIeg29xg+ETx6XEKOtqowjQ2HP+AXy8qQTcJspA=;
        b=ZTQ9w3xAEUuSZF7U1jHIbJppSfVXM8sLMUDOT+WWWUX0g2sCL8qjKbjGplKQvjQiPJ
         l++8DHZcpVcLrKwKKv0YipwDKY3RpUVvDnhrppW3fT5QJpF/t70p3oXvi7rgvSH9/Oq8
         W0YSO+oN951Lm0GwGz42Lcj08JwvzQgXVICqGYnVHxc95yIPhRYJ5ksdvFFDFx35DiGi
         igH/yC4igv0XnLG4NYPuHcVvXqhfc5tJQOUXlwENCFdZPyi9XocAgN70dh5DKDFd7HzJ
         T39E2cjRRusEHL6/+IyMz+FliVMk0XugZT9+eExh1CVZgDXaJaaKvyc/E0mggQzAUImG
         oNGw==
X-Gm-Message-State: AA+aEWZrQRONBpVdxZYDpY5fB8FPqO7tthL4egRZlBPMXVdQ0a3DgVAs
        ieRgMOVTcNjw2vyPfaCgK58=
X-Google-Smtp-Source: AFSGD/XgnlG64joDquuyrP5PaL1UYoZVeUNUi/A7NB8Vq0fNRTHFzsAFI8vYwN9VgTtMngbUPC8eMA==
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr12129380ljc.66.1543058528241;
        Sat, 24 Nov 2018 03:22:08 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id b21sm8134341lfi.7.2018.11.24.03.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 03:22:07 -0800 (PST)
Subject: Re: [PATCH v3 4/4] ARM: dts: Add stmpe-adc driver to relevant
 devicetrees
To:     Philippe Schenker <dev@pschenker.ch>, jic23@kernel.org,
        marcel.ziswiler@toradex.com, stefan@agner.ch
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181123142411.8921-4-dev@pschenker.ch>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2c7d4caa-4a6e-cea1-d394-51790227d968@gmail.com>
Date:   Sat, 24 Nov 2018 14:20:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181123142411.8921-4-dev@pschenker.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.2018 17:24, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Activate the stmpe-adc driver as found on Apalis/Colibri iMX6/T30 modules
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Hello Philippe,

Just a very minor comment.. device trees are not for drivers, but for HW description. It will be better to s/driver/DT node/ in both commit name and description.
