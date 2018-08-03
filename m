Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12B5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F7721707
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F7721707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeHCNBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:01:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36990 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeHCNBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:01:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id v9-v6so4598492ljk.4;
        Fri, 03 Aug 2018 04:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BFK7V571sAD6ojSsEzFD37otbcZCMFymq8tTipVQz5Q=;
        b=PFLwZdUPEzPSvRcsyASON9EatugMXYQhJwNpPN4VLl3tQH5hSOFn2qNbjnn/okPJor
         G6ryor3mJ55SYgm6OSkxP1hyH1QFxMRBNv5VPwKvheld74ymyhlhxYVvJppDZZcwMQ8Z
         SVHSL2Pvtb2JIKSSzfrSyxQ0EIzvyONJnzvOcIbrfIV9uFt/0ymTaIZOC2x7E9PwLZxC
         0sfzqV5lNkVIuk1rRJd1VrMDJ5tJu883EYJTKqi8fPiT/3Ri3b0dwZCgauwEmrvTq89D
         AhOrQ2zxBKD3U5OzyLtMn5K2af7A/m5MgALPwvewUVhRdCppNj/S0CoNnzd6dvc+YTMS
         SgsA==
X-Gm-Message-State: AOUpUlH/DCJbALerJWRmkIdYEunBgvEK9BnyMbEtpcZaO2XtCr7uW++Y
        PaJMzjwLtDJO9hFD/zWulrw=
X-Google-Smtp-Source: AAOMgpfD9+ZylN1wJkuuSee8YaR8fDsesw9EA/JW7C4OgruB6s/B0OhVcA8y93imd0ool+o8QiqjUQ==
X-Received: by 2002:a2e:944:: with SMTP id 65-v6mr5143711ljj.30.1533294315016;
        Fri, 03 Aug 2018 04:05:15 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d73-v6sm859029ljd.70.2018.08.03.04.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 04:05:14 -0700 (PDT)
Date:   Fri, 3 Aug 2018 14:05:11 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     kbuild-all@01.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, eballetbo@gmail.com,
        linus.walleij@linaro.org, mazziesaccount@gmail.com,
        dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, broonie@kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v11 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180803110511.GB20907@localhost.localdomain>
References: <77184f651e5cefb112f1061bc682b759f88144c6.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
 <201808031831.TJYSQ80i%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201808031831.TJYSQ80i%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 06:10:21PM +0800, kbuild test robot wrote:
> smatch warnings:
> drivers/mfd/rohm-bd718x7.c:163 bd71837_i2c_probe() warn: unsigned 'button.irq' is never less than zero.
> 
>    160		button.irq = regmap_irq_get_virq(bd71837->irq_data,
>    161						  BD71837_INT_PWRBTN_S);
>    162	
>  > 163		if (button.irq < 0) {
>    164			dev_err(&i2c->dev, "Failed to get the IRQ\n");
>    165			return button.irq;
>    166		}

Comparing unsiged to smaller-than-zero. These tools are handy! I'll fix
the errno check and send v12 in a minute... (or a bit more - but soonish
in any case =])

Br,
	Matti Vaittinen
