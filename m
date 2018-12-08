Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE47C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA4720857
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CM3umZ3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA4720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeLHAYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:24:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34693 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLHAYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:24:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so5363610wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 16:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=p655Kdv/MluYf2R6eaK9+3+MencH2RGfdHwCht7aC0c=;
        b=CM3umZ3AttvbKgRx9vF4ArjwU9qzfWr29pwCZYaT1CGOja5EnvLHKjAmEEiFe1jYzw
         5K8rWyOqHbYSRJzY0q9yvu8XjiT/itexuK/zKib9/4WG6pvJ+K1NjwEqd9ajItpPwAMv
         p4LEQDgj9f7Fkmz0UK4VWfKPX7KdXK4554Oqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p655Kdv/MluYf2R6eaK9+3+MencH2RGfdHwCht7aC0c=;
        b=hjj7gsBk/x8GxOtEMhzu/WNkkLzhqItkMuj3fBGB+SkTtpLwDrINY2roa7CcVFcWI1
         XCOw0+oW0VF99WlTxFXyCBJDAtqPgnowOi8jY9OIq0tt63EWrB7pbv3bJPgfl7/c3e9P
         x0vWAdt3qUeJ0QweLqVgyQA9GOf/FJ8KR1K4J6byJuUIkexwcqjFsh3vm8idmtpXOGaj
         Jhc9JldHwqFcThERSfzDDnXM2tJUoxhNd9tJ8DlUzDcCERnT1UWCrI9dLNhzIrHjPDtz
         4ktk/M/AX8Vq2Ru/cT/ESMtB9O9N79LsDYARb1Az1XqszVJK+Gu/nlxNzBXwGhHC37Nj
         TX1g==
X-Gm-Message-State: AA+aEWYiM5jWbiL6c8e0Q2KMrdobJ7PEL93eT202//93IRH5Mqpzu96T
        uyiYMfP/a3MK9ceJjjWbo+yiAA==
X-Google-Smtp-Source: AFSGD/W0hWuj6k0F+bdX01LntbzwRNg1+d/f77bHtmNKh5ae81PAQyxuE2cFdM2oRxPY78G2Xy/mHA==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr3294428wrt.63.1544228648130;
        Fri, 07 Dec 2018 16:24:08 -0800 (PST)
Received: from macbook.djakov.com ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y34sm12622668wrd.68.2018.12.07.16.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 16:24:07 -0800 (PST)
Subject: Re: [PATCH v11 5/8] interconnect: qcom: Add sdm845 interconnect
 provider driver
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     gregkh@linuxfoundation.org, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
 <20181207152917.4862-6-georgi.djakov@linaro.org>
 <20181207233010.GE14307@google.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <ee392578-2dbc-7e60-be37-483729e922d1@linaro.org>
Date:   Sat, 8 Dec 2018 02:24:03 +0200
MIME-Version: 1.0
In-Reply-To: <20181207233010.GE14307@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thanks for looking into this.

On 8.12.18 1:30, Matthias Kaehlcke wrote:
> Hi Georgi,
> 
> not a full review, only one thing I just stumbled across:
> 
> On Fri, Dec 07, 2018 at 05:29:14PM +0200, Georgi Djakov wrote:
>> From: David Dai <daidavid1@codeaurora.org>
>>
>> Introduce Qualcomm SDM845 specific provider driver using the
>> interconnect framework.
>>
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  .../bindings/interconnect/qcom,sdm845.txt     |  24 +
>>  drivers/interconnect/Kconfig                  |   5 +
>>  drivers/interconnect/Makefile                 |   1 +
>>  drivers/interconnect/qcom/Kconfig             |  13 +
>>  drivers/interconnect/qcom/Makefile            |   5 +
>>  drivers/interconnect/qcom/sdm845.c            | 836 ++++++++++++++++++
>>  .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
>>  7 files changed, 1027 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>>  create mode 100644 drivers/interconnect/qcom/Kconfig
>>  create mode 100644 drivers/interconnect/qcom/Makefile
>>  create mode 100644 drivers/interconnect/qcom/sdm845.c
>>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
>>
>> ...
>>
>> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
>> new file mode 100644
>> index 000000000000..f594dd6f500f
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/sdm845.c
>>
>> ...
>>
>> +static int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
>> +{
>> +	struct qcom_icc_node *qn;
>> +	int ret, i;
>> +
>> +	bcm->addr = cmd_db_read_addr(bcm->name);
>> +	if (!bcm->addr) {
>> +		dev_err(dev, "%s could not find RPMh address\n",
>> +			bcm->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (cmd_db_read_aux_data_len(bcm->name) < sizeof(struct bcm_db)) {
>> +		dev_err(dev, "%s command db missing or partial aux data\n",
>> +			bcm->name);
>> +		return -EINVAL;
>> +	}
> 
> cmd_db_read_aux_data_len() is in the process of being removed, see
> ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in
> cmd_db_read_aux_data()") in arm-soc/for-next
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?h=for-next&id=ed3cafa79ea756be653d22087c017af95ea78a49

Yes, exactly. I have a fix that lives as a separate patch [8/8] and will squash it here.

BR,
Georgi

