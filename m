Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35E4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835D820862
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EDANtsQ0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V9XWGRgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835D820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932621AbeGIKqy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:46:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49898 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932431AbeGIKqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:46:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C2236078C; Mon,  9 Jul 2018 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531133212;
        bh=og8oMO6+oCwQ3krCxE1vHOmdqgiB8qyPGDCYXxo1bKI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EDANtsQ0amkOzccCOJhCv8MJexws/ySj4KHIgHAsTrTdsMygFt+wu2v1jgxdGBbF/
         ctHNMStNXDYb+mSWmZbSivwz1RjAW1GhAoyCCIrbGsW5yTBg5To6IFzCMXEQyLsuRi
         OkALjpmZKnPfCMLTmUOFOSHrFozXNsYJWbNQ8L+k=
Received: from [10.204.110.156] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B69DD6063F;
        Mon,  9 Jul 2018 10:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531133211;
        bh=og8oMO6+oCwQ3krCxE1vHOmdqgiB8qyPGDCYXxo1bKI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V9XWGRghHpdt1nj2pmVDMSvaipip+dEiT0Hj9hvhumJMxvOqeplUGblrqy9KNRYba
         yrsO0riuLeTgb3Hh8N5RUpMyjsXSvs70z3UYUgD1JbKVA4egwj4/pd2lnm89JvbRfF
         jbeAhCHZ9G2EXxOdbwNuUK83UOmTRNulDBqgTsb4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B69DD6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card
 support
To:     Vinod <vkoul@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709074835.GB22377@vkoul-mobl>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <c1766ce9-060f-32d8-46fa-b0a6ac42538b@codeaurora.org>
Date:   Mon, 9 Jul 2018 16:16:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180709074835.GB22377@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vinod for reviewing.


On 7/9/2018 1:18 PM, Vinod wrote:
> On 06-07-18, 15:13, Rohit kumar wrote:
>
>> +static void sdm845_init_supplies(struct device *dev)
>> +{
>> +	struct snd_soc_card *card = dev_get_drvdata(dev);
>> +	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
>> +
>> +	data->vdd_supply = regulator_get(dev, "cdc-vdd");
>> +	if (IS_ERR(data->vdd_supply)) {
>> +		dev_err(dev, "Unable to get regulator supplies\n");
>> +		data->vdd_supply = NULL;
>> +		return;
>> +	}
>> +
>> +	if (regulator_enable(data->vdd_supply))
>> +		dev_err(dev, "Unable to enable vdd supply\n");
>> +}
>> +
>> +static void sdm845_deinit_supplies(struct device *dev)
>> +{
>> +	struct snd_soc_card *card = dev_get_drvdata(dev);
>> +	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
>> +
>> +	if (!data->vdd_supply)
>> +		return;
>> +
>> +	regulator_disable(data->vdd_supply);
>> +	regulator_put(data->vdd_supply);
>> +}
> these two can be made generic, cant we make these common when we have
> supplies present?

Actually we  need to move it to codec driver as suggested by Rob in v2 
patchset.
I will remove this in next spin.

>> +static int sdm845_bind(struct device *dev)
>> +{
>> +	struct snd_soc_card *card;
>> +	struct sdm845_snd_data *data;
>> +	int ret;
>> +
>> +	card = kzalloc(sizeof(*card), GFP_KERNEL);
>> +	if (!card)
>> +		return -ENOMEM;
>> +
>> +	/* Allocate the private data */
>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	ret = component_bind_all(dev, card);
>> +	if (ret) {
>> +		dev_err(dev, "Audio components bind failed: %d\n", ret);
>> +		goto bind_fail;
>> +	}
>> +
>> +	dev_set_drvdata(dev, card);
>> +	card->dev = dev;
>> +	ret = qcom_snd_parse_of(card);
>> +	if (ret) {
>> +		dev_err(dev, "Error parsing OF data\n");
>> +		goto parse_dt_fail;
>> +	}
>> +
>> +	data->card = card;
>> +	snd_soc_card_set_drvdata(card, data);
>> +
>> +	sdm845_add_be_ops(card);
>> +
>> +	sdm845_init_supplies(dev);
>> +
>> +	ret = snd_soc_register_card(card);
>> +	if (ret) {
>> +		dev_err(dev, "Sound card registration failed\n");
>> +		goto register_card_fail;
>> +	}
>> +	return ret;
>> +
>> +register_card_fail:
>> +	sdm845_deinit_supplies(dev);
>> +	kfree(card->dai_link);
>> +parse_dt_fail:
>> +	component_unbind_all(dev, card);
>> +bind_fail:
>> +	kfree(data);
>> +	kfree(card);
>> +	return ret;
>> +}
> I would make a case for this to be moved into common too :)

There are few platform specific APIs and structs here like struct 
sdm845_snd_data,
sdm845_add_be_ops() which needs to be initialized and assigned before 
soundcard
registration. Moving this complete API to common will restrict it. 
Please suggest.

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

