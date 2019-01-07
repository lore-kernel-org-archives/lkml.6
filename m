Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C6FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78A92183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cgVkd/MR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CAybn0iB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfAGSsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:48:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfAGSsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:48:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 247BD602A8; Mon,  7 Jan 2019 18:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546886918;
        bh=dG1j9M8MTRIMLXjdmta6E/q+9B/L0qaKEE+Jx5Ma8WY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cgVkd/MRGblUXuEYKvEGmI7XlxDw+uPq+N4h+CdssDcnteU7IOr5Nojue+RkKvyuE
         37p06/CmDur/2UIkazPz4OlhpjN/plYD1hBgI/uuYuz3abKAwUyODD+zisA76PSw9/
         9bozvGw41526Ah/dclsSX9vVjMTnrNZOv1vgUbQ0=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F690602A8;
        Mon,  7 Jan 2019 18:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546886917;
        bh=dG1j9M8MTRIMLXjdmta6E/q+9B/L0qaKEE+Jx5Ma8WY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAybn0iBES2xizAm3dOF7p1PvnLS3cFAIq7rkgvX9JiOFFryQvP0TAz/VR7t0qI7Z
         Vpqlkom0zvFviSeUlMvkVx1iLoG7FCxNILbHdYcXjSTv2I3rRARfhB0pa5V7n/O7zu
         YMTJiAAtIYoV7XLxBCVTt12Mkq4No5g70QaPMgwU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F690602A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 7 Jan 2019 11:48:36 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH 3/7] drivers: irqchip: add PDC irqdomain for wakeup
 capable GPIOs
Message-ID: <20190107184836.GG14960@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org>
 <20181219221105.3004-4-ilina@codeaurora.org>
 <154533717951.79149.1309452983166815703@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <154533717951.79149.1309452983166815703@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20 2018 at 13:19 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-12-19 14:11:01)
>> diff --git a/drivers/irqchip/qcom-pdc-data.c b/drivers/irqchip/qcom-pdc-data.c
>> new file mode 100644
>> index 000000000000..99b4be0af5db
>> --- /dev/null
>> +++ b/drivers/irqchip/qcom-pdc-data.c
>> @@ -0,0 +1,94 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include "qcom-pdc.h"
>> +
[...]

>> +static const struct pdc_gpio_pin_data sdm845_gpio_data = {
>> +       .size = ARRAY_SIZE(sdm845_gpio_pdc_map),
>> +       .map = sdm845_gpio_pdc_map,
>> +};
>> +
>> +const struct of_device_id pdc_gpio_match_table[] = {
>> +       { .compatible = "qcom,845-pdc", .data = &sdm845_gpio_data },
>
>Why not qcom,sdm845-pdc?
>
The compatible matches the compatible specified in the PDC driver. Not
sure why the 'sdm' was left out at that time.

>> +       { },
>> +};
>
>I wonder why we wouldn't just put this all into the qcom-pdc.c file at
>the bottom and then have that IRQCHIP_DECLARE() macros call small
>functions that pass the pdc to gpio mapping table to qcom_pdc_init()
>that takes a third argument?
>
We could. I feel we would be adding tables like this and it just
clutters up the driver file. May be in the future we could move to
target specific data file like the gpios, but that could be excessive
too. Thought this might be a compromise. I am open to change.

>I really hope that in the future all the gpios can be wakeup capable so
>that we don't need to have the table at all!
>
I doubt there are plans to support that in hardware. We should plan for
supporting tables like this for other chipsets based on the PDC
architecture.

Thanks,
Lina
