Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904B0C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D15E2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SyZHIlon";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N/v0/wKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D15E2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeLEHBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:01:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeLEHBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:01:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8602D60807; Wed,  5 Dec 2018 07:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543993304;
        bh=fFfA1sGn7Yh9NDHnhin/Gryz0Dba2ncriChXL0YPbH8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SyZHIlonfqjLr0kO74kT2Ej4erJadNUhW0PK+slbL3z9mSmWHc7BpHLpQCGW6gegl
         4Z4GgIvA9fqUZvg5YprB0hwsAqxWouOSF/F44FOc/Mdh9jAhjDzms2igxQIkueuoEK
         BORgsRtVDQFr1sptW1QL2yfnIBGhmBaL4Og/OrtE=
Received: from [10.79.128.218] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D0ED60224;
        Wed,  5 Dec 2018 07:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543993303;
        bh=fFfA1sGn7Yh9NDHnhin/Gryz0Dba2ncriChXL0YPbH8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N/v0/wKwA8T2VlYKZO0zEsRHuQC02fo/gFRlls9NuzMOM+rmpJXebbSF30eM+8XHB
         +niDZC9smqHepVqVrBe8uQJn4KCsJdxfr290CoO4nVrTfPRS2ddQBPjpf/oxkYgcu7
         e1RTavP2UEPSVbedzKxO9bIIZ7r4HVwlsfDc21Ls=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D0ED60224
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v5 3/8] soc: qcom: rpmpd: Add a Power domain driver to
 model corners
To:     Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181204052119.806-1-rnayak@codeaurora.org>
 <20181204052119.806-4-rnayak@codeaurora.org>
 <154396516737.88331.4646719751490719649@swboyd.mtv.corp.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <21ef1c26-216f-583b-7ce3-c322f40b400e@codeaurora.org>
Date:   Wed, 5 Dec 2018 12:31:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154396516737.88331.4646719751490719649@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/5/2018 4:42 AM, Stephen Boyd wrote:
> Overall looks good to me, just some nitpicks around modules and
> includes.

Thanks for the review, I will fix up all your concerns below and respin soon.

> 
> Quoting Rajendra Nayak (2018-12-03 21:21:14)
>> The Power domains for corners just pass the performance state set by the
>> consumers to the RPM (Remote Power manager) which then takes care
>> of setting the appropriate voltage on the corresponding rails to
>> meet the performance needs.
>>
>> We add all Power domain data needed on msm8996 here. This driver can easily
>> be extended by adding data for other qualcomm SoCs as well.
>>
> 
> Why is "Power" capitalized in power domain?
> 
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index f25b54cd6cf8..f1b25fdcf2ad 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -21,3 +21,4 @@ obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
>>   obj-$(CONFIG_QCOM_APR) += apr.o
>>   obj-$(CONFIG_QCOM_LLCC) += llcc-slice.o
>>   obj-$(CONFIG_QCOM_SDM845_LLCC) += llcc-sdm845.o
>> +obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
>> new file mode 100644
>> index 000000000000..a0b9f122d793
>> --- /dev/null
>> +++ b/drivers/soc/qcom/rpmpd.c
>> @@ -0,0 +1,294 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2017-2018, The Linux Foundation. All rights reserved. */
>> +
>> +#include <linux/err.h>
>> +#include <linux/export.h>
> 
> And what is exported?
> 
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
> 
> Is it a module? It's only bool so I don't think so.
> 
>> +#include <linux/mutex.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/mfd/qcom_rpm.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/soc/qcom/smd-rpm.h>
>> +
>> +#include <dt-bindings/mfd/qcom-rpm.h>
>> +#include <dt-bindings/power/qcom-rpmpd.h>
>> +
>> +#define domain_to_rpmpd(domain) container_of(domain, struct rpmpd, pd)
>> +
>> +/* Resource types */
>> +#define RPMPD_SMPA 0x61706d73
>> +#define RPMPD_LDOA 0x616f646c
>> +
>> +/* Operation Keys */
>> +#define KEY_CORNER             0x6e726f63 /* corn */
>> +#define KEY_ENABLE             0x6e657773 /* swen */
>> +#define KEY_FLOOR_CORNER       0x636676   /* vfc */
>> +
>> +#define DEFINE_RPMPD_CORN_SMPA(_platform, _name, _active, r_id)                \
>> +       static struct rpmpd _platform##_##_active;                      \
>> +       static struct rpmpd _platform##_##_name = {                     \
>> +               .pd = { .name = #_name, },                              \
>> +               .peer = &_platform##_##_active,                         \
>> +               .res_type = RPMPD_SMPA,                                 \
>> +               .res_id = r_id,                                         \
>> +               .key = KEY_CORNER,                                      \
>> +       };                                                              \
>> +       static struct rpmpd _platform##_##_active = {                   \
>> +               .pd = { .name = #_active, },                            \
>> +               .peer = &_platform##_##_name,                           \
>> +               .active_only = true,                                    \
>> +               .res_type = RPMPD_SMPA,                                 \
>> +               .res_id = r_id,                                         \
>> +               .key = KEY_CORNER,                                      \
>> +       }
>> +
>> +#define DEFINE_RPMPD_CORN_LDOA(_platform, _name, r_id)                 \
>> +       static struct rpmpd _platform##_##_name = {                     \
>> +               .pd = { .name = #_name, },                              \
>> +               .res_type = RPMPD_LDOA,                                 \
>> +               .res_id = r_id,                                         \
>> +               .key = KEY_CORNER,                                      \
>> +       }
>> +
>> +#define DEFINE_RPMPD_VFC(_platform, _name, r_id, r_type)               \
>> +       static struct rpmpd _platform##_##_name = {                     \
>> +               .pd = { .name = #_name, },                              \
>> +               .res_type = r_type,                                     \
>> +               .res_id = r_id,                                         \
>> +               .key = KEY_FLOOR_CORNER,                                \
>> +       }
>> +
>> +#define DEFINE_RPMPD_VFC_SMPA(_platform, _name, r_id)                  \
>> +       DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_SMPA)
>> +
>> +#define DEFINE_RPMPD_VFC_LDOA(_platform, _name, r_id)                  \
>> +       DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_LDOA)
>> +
>> +struct rpmpd_req {
>> +       __le32 key;
>> +       __le32 nbytes;
>> +       __le32 value;
>> +};
>> +
>> +struct rpmpd {
>> +       struct generic_pm_domain pd;
>> +       struct rpmpd *peer;
>> +       const bool active_only;
>> +       unsigned int corner;
>> +       bool enabled;
>> +       const char *res_name;
>> +       const int res_type;
>> +       const int res_id;
>> +       struct qcom_smd_rpm *rpm;
>> +       __le32 key;
>> +};
>> +
>> +struct rpmpd_desc {
>> +       struct rpmpd **rpmpds;
>> +       size_t num_pds;
>> +};
>> +
>> +static DEFINE_MUTEX(rpmpd_lock);
>> +
>> +/* msm8996 RPM Power domains */
>> +DEFINE_RPMPD_CORN_SMPA(msm8996, vddcx, vddcx_ao, 1);
>> +DEFINE_RPMPD_CORN_SMPA(msm8996, vddmx, vddmx_ao, 2);
>> +DEFINE_RPMPD_CORN_LDOA(msm8996, vddsscx, 26);
> 
> Mmm.. CORN...
> 
>> +
>> +DEFINE_RPMPD_VFC_SMPA(msm8996, vddcx_vfc, 1);
>> +DEFINE_RPMPD_VFC_LDOA(msm8996, vddsscx_vfc, 26);
>> +
>> +static struct rpmpd *msm8996_rpmpds[] = {
>> +       [MSM8996_VDDCX] =       &msm8996_vddcx,
>> +       [MSM8996_VDDCX_AO] =    &msm8996_vddcx_ao,
>> +       [MSM8996_VDDCX_VFC] =   &msm8996_vddcx_vfc,
>> +       [MSM8996_VDDMX] =       &msm8996_vddmx,
>> +       [MSM8996_VDDMX_AO] =    &msm8996_vddmx_ao,
>> +       [MSM8996_VDDSSCX] =     &msm8996_vddsscx,
>> +       [MSM8996_VDDSSCX_VFC] = &msm8996_vddsscx_vfc,
>> +};
>> +
> [...]
>> +       }
>> +
>> +       return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
>> +}
>> +
>> +static struct platform_driver rpmpd_driver = {
>> +       .driver = {
>> +               .name = "qcom-rpmpd",
>> +               .of_match_table = rpmpd_match_table,
> 
> suppress bind attributes here?
> 
>> +       },
>> +       .probe = rpmpd_probe,
> 
> Because there isn't a remove function to tear down the genpds.
> 
>> +};
>> +
>> +static int __init rpmpd_init(void)
>> +{
>> +       return platform_driver_register(&rpmpd_driver);
>> +}
>> +core_initcall(rpmpd_init);
>> +
>> +static void __exit rpmpd_exit(void)
>> +{
>> +       platform_driver_unregister(&rpmpd_driver);
>> +}
>> +module_exit(rpmpd_exit);
>> +
>> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPM Power Domain Driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:qcom-rpmpd");
> 
> Is this MODULE_ALIAS required? I thought this wasn't useful because it's
> auto-generated or something like that. Also, this is bool so these can
> all go away unless it becomes tristate.
> 
