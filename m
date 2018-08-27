Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B46C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEF120858
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEF120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeH0QFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:05:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34662 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeH0QFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:05:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so12190090ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 05:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8C/uEZtd0jxqqt90hw7rrVdqdKNtjxlJxUFzfovqi2o=;
        b=Lo5IKOlXATLLt/q/7oH38WCg74xdoFpLXVMqiXG+MshqWqZWf7Xh99fN5lBTWzDasw
         mjsPxeXeVf+kF7RF0MnbossRU1iaxCnxt1Oj+qK3J5CC4vSJa8yH4Rg48JVnLFfaT83L
         vnshinNzG5o/DnPGSRsRK0NgFwkWAwwKok1T5WAt/RbEwDw355ygIa60nuxOvEBEc9wQ
         hY8bhOsQmZfMUorGAN0V12Eyn24I7/OlFTGAgK1KQ08Z/L/aqF7GDb5OoC6xCx4WqvIM
         VDQ97gEeXFoDrvXY/s7unXzTwp3umgAG8/VSYj6ythXYBgHDp67qR/p0XDRIf1w9hKo+
         DD4Q==
X-Gm-Message-State: APzg51AqumFc8Nvni44iAp2BLI7gYhcKHp5aZ9SffHxoAG7B1nV8+ks+
        3DHiw0ly8ZrcJLOovgQwhP8c7+IF
X-Google-Smtp-Source: ANB0VdaPmzE2nBcJeK9petqMloyCpWzBKser3ArLOa6Hd7ZmlRyWW7OutG5h1dWkmh/84CBX+nQH5A==
X-Received: by 2002:a2e:55dd:: with SMTP id g90-v6mr8283625lje.4.1535372353636;
        Mon, 27 Aug 2018 05:19:13 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id m187-v6sm2875227lfe.45.2018.08.27.05.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 05:19:12 -0700 (PDT)
Date:   Mon, 27 Aug 2018 15:19:10 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com
Cc:     mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] regulator: Support regulators where voltage ranges
 are selectable
Message-ID: <20180827121910.GB2448@localhost.localdomain>
References: <20180822110507.GA6177@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822110507.GA6177@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 02:05:07PM +0300, Matti Vaittinen wrote:
> For example ROHM BD71837 and ROHM BD71847 Power management ICs have
> regulators which provide multiple linear ranges. Ranges can be
> selected by individual non contagious bit in vsel register. Add
> regmap helper functions for selecting ranges.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
[Snip...]
>  
> +static int regulator_range_selector_to_index(struct regulator_dev *rdev,
> +					     unsigned int rval)
> +{
> +	int i;
> +
> +	if (!rdev->desc->linear_range_selectors)
> +		return -EINVAL;
> +
> +	rval &= rdev->desc->vsel_range_mask;
> +
> +	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
> +		if (rdev->desc->linear_range_selectors[i] == rval)
> +			return i;
> +	}
> +	return -EINVAL;
> +}
> +
> +/**
> + * regulator_get_voltage_sel_pickable_regmap - pickable range get_voltage_sel
> + *
> + * @rdev: regulator to operate on
> + *
> + * Regulators that use regmap for their register I/O and use pickable
> + * ranges can set the vsel_reg, vsel_mask, vsel_range_reg and vsel_range_mask
> + * fields in their descriptor and then use this as their get_voltage_vsel
> + * operation, saving some code.
> + */
> +int regulator_get_voltage_sel_pickable_regmap(struct regulator_dev *rdev)
> +{
> +	unsigned int r_val;
> +	unsigned int range;
> +	unsigned int val;
> +	int ret, i;
> +	unsigned int voltages_in_range = 0;
> +
> +	if (!rdev->desc->linear_ranges)
> +		return -EINVAL;
> +
> +	ret = regmap_read(rdev->regmap, rdev->desc->vsel_reg, &val);
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = regmap_read(rdev->regmap, rdev->desc->vsel_range_reg, &r_val);
> +	if (ret != 0)
> +		return ret;
> +
> +	val &= rdev->desc->vsel_mask;
> +	val >>= ffs(rdev->desc->vsel_mask) - 1;
> +
> +	range = regulator_range_selector_to_index(rdev, r_val);
> +	if (range < 0)
> +		return -EINVAL;

Got buildbot warning for checking whether unsigned int is negative.
I'll fix this one.

Other than that - I have BD71847 support almost finished - should I
send this change as part of that patch set as these helpers would be
used by the BD71847 patch series?

Br,
	Matti Vaittinen

