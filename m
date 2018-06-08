Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6zQGLYzFGltOLwAAmS7hNA
	; Fri, 08 Jun 2018 18:06:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9D5F36089E; Fri,  8 Jun 2018 18:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528481164;
	bh=kszkeunWta6zxz614dZqYkn/kWzazXQO8VnGAezWIE4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=MTFeuKANfV4uuL6OnL6m71gbqKYrquFf2UP9c4ulY9Hha19OclKxJ9GMfltBAZ8al
	 fxbJ2VIIQwF+tuBBGnaGfL91K+azT1f316P2Dt/JxDRwKoGvGVS5LD1A0ZzRtMWebB
	 hQXsWE1iaL8hc38PI1sa647vPKjwYmyf1MZCtVI0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EABCB605A5;
	Fri,  8 Jun 2018 18:06:03 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OPurBDqa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NewkWiTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EABCB605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeFHSF7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:05:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752660AbeFHSF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:05:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A4755607E4; Fri,  8 Jun 2018 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528481156;
        bh=kszkeunWta6zxz614dZqYkn/kWzazXQO8VnGAezWIE4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OPurBDqacmAJAPlLvTM5weTSyauy3d8i5KVMETpqDHins8KGLClBCzdaWDV+S15+1
         vuILRpgKfJI827AahsijulB0iivuI+7DiuXQJAEnJtnhhAk3glVzq54Rp2Ka5CFZYk
         MYlstnKujJL7t0J0ZnCqdOkPbzaojT2B414B4Z+c=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A854601B4;
        Fri,  8 Jun 2018 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528481154;
        bh=kszkeunWta6zxz614dZqYkn/kWzazXQO8VnGAezWIE4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NewkWiTr9uXLxuX5VKTj030FlPnu7bwNJjowgwKUm6CLJ/EuzJbbzq1RhSyqakthd
         4oQq4XikSoprb+gycLI8njnNEOCskASfR/XBOnBHpsR/mW4DVAmcHWbB6XSEz90/JP
         gO71GUtYV2jiEOKReTIyi7mdVwKZVbpzEG6b1jHo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A854601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v6 2/2] regulator: add QCOM RPMh regulator driver
To: Matthias Kaehlcke <mka@chromium.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        sboyd@kernel.org, dianders@chromium.org
References: <cover.1528138319.git.collinsd@codeaurora.org>
 <6d7abf248493cf81d62eb17ecb5030783aa85f72.1528138319.git.collinsd@codeaurora.org>
 <20180608002653.GD88063@google.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <a062ede9-20de-22e3-24a5-1aba8cf3740d@codeaurora.org>
Date: Fri, 8 Jun 2018 11:05:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180608002653.GD88063@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthias,

On 06/07/2018 05:26 PM, Matthias Kaehlcke wrote:
> On Mon, Jun 04, 2018 at 12:15:12PM -0700, David Collins wrote:
>> static int rpmh_regulator_send_request(struct rpmh_vreg *vreg,
>> +                       struct tcs_cmd *cmd, int count, bool wait_for_ack)
>>
> 
> nit: as of now this is only called with a single command. If you
> anticipate that this is unlikely to change consider removing 'count',
> not having it in the calls slightly improves readability.

The count parameter was needed in the original version of the patch.  That
need is no longer present after removing features in subsequent versions.

I'll remove this parameter.


>> +static int _rpmh_regulator_vrm_set_voltage_sel(struct regulator_dev *rdev,
>> +				unsigned int selector, bool wait_for_ack)
>> +{
>> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +	struct tcs_cmd cmd = {
>> +		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
>> +	};
>> +	int ret;
>> +
>> +	/* VRM voltage control register is set with voltage in millivolts. */
>> +	cmd.data = DIV_ROUND_UP(regulator_list_voltage_linear_range(rdev,
>> +							selector), 1000);
>> +
>> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, wait_for_ack);
>> +	if (!ret)
>> +		vreg->voltage_selector = selector;
>> +
>> +	return 0;
> 
> Shouldn't this return 'ret'?

Yes; good catch.  I'll fix it.


>> +static int rpmh_regulator_enable(struct regulator_dev *rdev)
>> +{
>> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +	struct tcs_cmd cmd = {
>> +		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
>> +		.data = 1,
>> +	};
>> +	int ret;
>> +
>> +	if (vreg->enabled == -EINVAL &&
>> +	    vreg->voltage_selector != -ENOTRECOVERABLE) {
>> +		ret = _rpmh_regulator_vrm_set_voltage_sel(rdev,
>> +						vreg->voltage_selector, true);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, true);
>> +	if (!ret)
>> +		vreg->enabled = true;
>> +
>> +	return ret;
>> +}
>> +
>> +static int rpmh_regulator_disable(struct regulator_dev *rdev)
>> +{
>> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +	struct tcs_cmd cmd = {
>> +		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
>> +		.data = 0,
>> +	};
>> +	int ret;
>> +
>> +	if (vreg->enabled == -EINVAL &&
>> +	    vreg->voltage_selector != -ENOTRECOVERABLE) {
>> +		ret = _rpmh_regulator_vrm_set_voltage_sel(rdev,
>> +						vreg->voltage_selector, true);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, false);
>> +	if (!ret)
>> +		vreg->enabled = false;
>> +
>> +	return ret;
>> +}
> 
> nit: rpmh_regulator_enable() and rpmh_regulator_disable() are
> essentially the same code, consider introducing a helper like
> _rpmh_regulator_enable(struct regulator_dev *rdev, bool enable).

Sure, I'll add a helper function.


>> +static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
>> +				struct device_node *node, const char *pmic_id,
>> +				const struct rpmh_vreg_init_data *rpmh_data)
>> +{
>> +	struct regulator_config reg_config = {};
>> +	char rpmh_resource_name[20] = "";
>> +	struct regulator_dev *rdev;
>> +	struct regulator_init_data *init_data;
>> +	int ret;
>> +
>> +	vreg->dev = dev;
>> +
>> +	for (; rpmh_data->name; rpmh_data++)
>> +		if (!strcmp(rpmh_data->name, node->name))
>> +			break;
> 
> nit: it's a bit odd to use the parameter itself for iteration, but I
> guess it's a matter of preferences.

I'll change this to add a specific iterator so that it is less surprising.

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
