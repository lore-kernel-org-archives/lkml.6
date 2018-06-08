Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TwfEEyXNGVssJgAAmS7hNA
	; Fri, 08 Jun 2018 00:26:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7A78E6089E; Fri,  8 Jun 2018 00:26:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dDk3CvEN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D5855602FC;
	Fri,  8 Jun 2018 00:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5855602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeFHA05 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:26:57 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35034 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752626AbeFHA0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:26:55 -0400
Received: by mail-pl0-f67.google.com with SMTP id i5-v6so7164575plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 17:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lo7SKYbXqDmC1YEQCtWu9lkwtVcj6UT77iWGOUeGKTc=;
        b=dDk3CvENrNIBuW4K19sIdt0tqj9a0un5XwKXE10YpKZtGS8jBmnXUATHWaUIOXuosY
         jdqnq8rFEyUPvxBIYdMUoDkJu3uLyUQxnLl9Fz94TJ2AU+ZfsI6TYW4Y0mbEFjlib2My
         8Msn1vi1UdqRWMI5x346YONguvHGCjLPv2XiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lo7SKYbXqDmC1YEQCtWu9lkwtVcj6UT77iWGOUeGKTc=;
        b=DWSWlUgzTSZm7tuRCYcToP8tbxaZyUb0RUJWm6gMfSk3Yqq7HxTNOS8V/lmdHV+siX
         aDI6QmaS+gTWa2oIv5soFVN8xHmeppjSR8YLHNbIlMeAHoLAIDDA7uUl/7wp/UVGHSM7
         yb43OKA4ydq6YgF8Ig5zFp+wtUloU8okZRhqMQ1cID4a+IOxlrfiAVO+xKgbSKx8ZNOQ
         L9ZHxzeOgf5AzVckahDEfA1Ed7V4j1/q43IpiR1HyuSvHzSVGd/V9HEVs4WcQK+MrH5Y
         uiN8V4E6fpuzvQOkN/D1hF+mXMUBCzqP+4nkBlXijQ7j7BP+J/R1gOhyyMaRU5a7VclZ
         0qQA==
X-Gm-Message-State: APt69E2+wh6CWMTuQP+pUY17FRyYCqtZ3guzvSlJSHxCpU3HeArwqdqb
        SoUs9ixfbACdgWwHDapcs2Uv/A==
X-Google-Smtp-Source: ADUXVKJeN8kCUi+kT86Ln2ZQ3Fx+lWT3QFtSHfKp3GvqSJBdoth8Id89LmAgyFApSbo2RA+wgAAODg==
X-Received: by 2002:a17:902:e00a:: with SMTP id ca10-v6mr4072956plb.224.1528417614577;
        Thu, 07 Jun 2018 17:26:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id s28-v6sm62464744pfg.89.2018.06.07.17.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 17:26:53 -0700 (PDT)
Date: Thu, 7 Jun 2018 17:26:53 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: David Collins <collinsd@codeaurora.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        sboyd@kernel.org, dianders@chromium.org
Subject: Re: [PATCH v6 2/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180608002653.GD88063@google.com>
References: <cover.1528138319.git.collinsd@codeaurora.org>
 <6d7abf248493cf81d62eb17ecb5030783aa85f72.1528138319.git.collinsd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d7abf248493cf81d62eb17ecb5030783aa85f72.1528138319.git.collinsd@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, Jun 04, 2018 at 12:15:12PM -0700, David Collins wrote:
> Add the QCOM RPMh regulator driver to manage PMIC regulators
> which are controlled via RPMh on some Qualcomm Technologies, Inc.
> SoCs.  RPMh is a hardware block which contains several
> accelerators which are used to manage various hardware resources
> that are shared between the processors of the SoC.  The final
> hardware state of a regulator is determined within RPMh by
> performing max aggregation of the requests made by all of the
> processors.
> 
> Add support for PMIC regulator control via the voltage regulator
> manager (VRM) and oscillator buffer (XOB) RPMh accelerators.
> VRM supports manipulation of enable state, voltage, and mode.
> XOB supports manipulation of enable state.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> ---
>  drivers/regulator/Kconfig               |   9 +
>  drivers/regulator/Makefile              |   1 +
>  drivers/regulator/qcom-rpmh-regulator.c | 767 ++++++++++++++++++++++++++++++++
>  3 files changed, 777 insertions(+)
>  create mode 100644 drivers/regulator/qcom-rpmh-regulator.c
>
> ...
>
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> new file mode 100644
> index 0000000..a7fffb6
> --- /dev/null
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
>
> ...
> static int rpmh_regulator_send_request(struct rpmh_vreg *vreg,
> +                       struct tcs_cmd *cmd, int count, bool wait_for_ack)
>

nit: as of now this is only called with a single command. If you
anticipate that this is unlikely to change consider removing 'count',
not having it in the calls slightly improves readability.

> ...
> +static int _rpmh_regulator_vrm_set_voltage_sel(struct regulator_dev *rdev,
> +				unsigned int selector, bool wait_for_ack)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
> +	};
> +	int ret;
> +
> +	/* VRM voltage control register is set with voltage in millivolts. */
> +	cmd.data = DIV_ROUND_UP(regulator_list_voltage_linear_range(rdev,
> +							selector), 1000);
> +
> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, wait_for_ack);
> +	if (!ret)
> +		vreg->voltage_selector = selector;
> +
> +	return 0;

Shouldn't this return 'ret'?

> +static int rpmh_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
> +		.data = 1,
> +	};
> +	int ret;
> +
> +	if (vreg->enabled == -EINVAL &&
> +	    vreg->voltage_selector != -ENOTRECOVERABLE) {
> +		ret = _rpmh_regulator_vrm_set_voltage_sel(rdev,
> +						vreg->voltage_selector, true);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, true);
> +	if (!ret)
> +		vreg->enabled = true;
> +
> +	return ret;
> +}
> +
> +static int rpmh_regulator_disable(struct regulator_dev *rdev)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
> +		.data = 0,
> +	};
> +	int ret;
> +
> +	if (vreg->enabled == -EINVAL &&
> +	    vreg->voltage_selector != -ENOTRECOVERABLE) {
> +		ret = _rpmh_regulator_vrm_set_voltage_sel(rdev,
> +						vreg->voltage_selector, true);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, false);
> +	if (!ret)
> +		vreg->enabled = false;
> +
> +	return ret;
> +}

nit: rpmh_regulator_enable() and rpmh_regulator_disable() are
essentially the same code, consider introducing a helper like
_rpmh_regulator_enable(struct regulator_dev *rdev, bool enable).

> +/**
> + * rpmh_regulator_init_vreg() - initialize all attributes of an rpmh-regulator
> + * vreg:		Pointer to the individual rpmh-regulator resource
> + * dev:			Pointer to the top level rpmh-regulator PMIC device
> + * node:		Pointer to the individual rpmh-regulator resource
> + *			device node
> + * pmic_id:		String used to identify the top level rpmh-regulator
> + *			PMIC device on the board
> + * rpmh_data:		Pointer to a null-terminated array of rpmh-regulator
> + *			resources defined for the top level PMIC device
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
> +				struct device_node *node, const char *pmic_id,
> +				const struct rpmh_vreg_init_data *rpmh_data)
> +{
> +	struct regulator_config reg_config = {};
> +	char rpmh_resource_name[20] = "";
> +	struct regulator_dev *rdev;
> +	struct regulator_init_data *init_data;
> +	int ret;
> +
> +	vreg->dev = dev;
> +
> +	for (; rpmh_data->name; rpmh_data++)
> +		if (!strcmp(rpmh_data->name, node->name))
> +			break;

nit: it's a bit odd to use the parameter itself for iteration, but I
guess it's a matter of preferences.

Thanks

Matthias
