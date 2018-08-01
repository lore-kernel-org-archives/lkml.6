Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4828DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2BC208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nO3qBraU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H4KXFraH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2BC208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeHAVve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:51:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36294 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeHAVvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:51:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 195B360275; Wed,  1 Aug 2018 20:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533153847;
        bh=AycGWAS9RfsyqyoQJcC6qknLtu6knsJAxQ3hmDs39o4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nO3qBraUgWsVYI5CAmIw6BCvIanrwpAyfVVNlI6nX/dDqWXv5H22UH1GqIEdpIg1U
         s4TGd8mPhQaGnBQwMekh+FmfmKBLiE+U3JZRoC1NMcx8B5eh2vN8+XBVSXJ4arr2cE
         QWx/xuAtwWE0C3mQi9aaXs9YOy8ybG/VcJ5zF0mE=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B57E60264;
        Wed,  1 Aug 2018 20:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533153846;
        bh=AycGWAS9RfsyqyoQJcC6qknLtu6knsJAxQ3hmDs39o4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4KXFraHQ4RDa8Sa62xu7lIqLuXPPuNGlaEcuWQP9Bm6C4NB2OlnzcqR6LTeCRSf7
         LiehGn5uzhWhMdIiYmlSZI6LWfw8uffIuBGoLAd4MUU5Ew2hbFBTIHiIKM6glRJTM7
         CaH477ySmsH/Q5DtIJ+EG6TxAhnXd7xIO8iKCq5g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B57E60264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 1 Aug 2018 14:04:05 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     swboyd@chromium.org, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND RFC 2/4] drivers: pinctrl: qcom: add wakeup gpio
 map for sdm845
Message-ID: <20180801200405.GB6422@codeaurora.org>
References: <20180801020021.9782-1-ilina@codeaurora.org>
 <20180801020021.9782-3-ilina@codeaurora.org>
 <8636vyxyub.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8636vyxyub.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01 2018 at 02:42 -0600, Marc Zyngier wrote:
>On Wed, 01 Aug 2018 03:00:19 +0100,
>Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> Add GPIO to PDC pin map for the SDM845 SoC.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  drivers/pinctrl/qcom/pinctrl-sdm845.c | 76 +++++++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
>> index 2ab7a8885757..e93660922dc2 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
>> @@ -1277,6 +1277,80 @@ static const struct msm_pingroup sdm845_groups[] = {
>>  	UFS_RESET(ufs_reset, 0x99f000),
>>  };
>>
>> +static struct msm_pinctrl_pdc_map sdm845_wakeup_gpios[] = {
>
>[huge array]
>
>> +};
>
>Why isn't that array part of the DT? I'd expect other SoCs to
>eventually use a similar mechanism, no?
>
I agree and it should be.

One place I am thinking is to add it to the DT definition of PDC
controller as a data argument -

	tlmm: pinctrl@000000{
	[...]
		interrupts-extended = <&pdc 30 IRQ_TYPE_LEVEL_HIGH 1>,
                      <&pdc 31 IRQ_TYPE_LEVEL_HIGH 3>,
		      <&pdc 32 IRQ_TYPE_LEVEL_HIGH 5>,
						   ^
						   |--- Provide the GPIO
						   for the PDC pin here.
	};

	pdc: interrupt-controller@b220000 {
		compatible = "qcom,sdm845-pdc";
		reg = <0xb220000 0x30000>;
		qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
		#interrupt-cells = <3>; <-------- Increase this from 2 ?
		interrupt-parent = <&intc>;
		interrupt-controller;
	};

Would that be acceptable?

Thanks,
Lina
