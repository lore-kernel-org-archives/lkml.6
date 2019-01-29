Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957D82177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfA2J2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:28:12 -0500
Received: from foss.arm.com ([217.140.101.70]:60876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfA2J2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:28:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E782E80D;
        Tue, 29 Jan 2019 01:28:10 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 030493F7A6;
        Tue, 29 Jan 2019 01:28:04 -0800 (PST)
Subject: Re: [PATCHv5 5/7] coresight: etm4x: Add ETM PIDs for SDM845 and
 MSM8996
To:     saiprakash.ranjan@codeaurora.org, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        vivek.gautam@codeaurora.org, jhugo@codeaurora.org,
        dianders@chromium.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, marc.w.gonzalez@free.fr
Cc:     rnayak@codeaurora.org, sibis@codeaurora.org,
        tingwei@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <cb7d3e715f154942fba1597b91d5b13c25f607e7.1548419933.git.saiprakash.ranjan@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <bf0337b0-2b1c-f296-8a1d-e8a8f993c274@arm.com>
Date:   Tue, 29 Jan 2019 09:28:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cb7d3e715f154942fba1597b91d5b13c25f607e7.1548419933.git.saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2019 19:14, Sai Prakash Ranjan wrote:
> Instead of overriding the peripheral id(PID) check in AMBA
> by hardcoding them in DT, add the PIDs to the ETM4x driver.
> Here we use Unique Component Identifier(UCI) for MSM8996
> since the ETM and CPU debug module shares the same PIDs.
> SDM845 does not support CPU debug module.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> ---
> This patch depends on UCI support by Mike Leach in below link:
>   https://lore.kernel.org/lkml/20190121233151.13363-2-mike.leach@linaro.org/
> ---
>   drivers/hwtracing/coresight/coresight-etm4x.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index fe76b176974a..17731a8ae787 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1080,6 +1080,10 @@ static const struct amba_id etm4_ids[] = {
>   	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
>   	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
>   	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
> +	ETM4x_AMBA_UCI_ID(0x000f0205),		/* Qualcomm Kryo */
> +	ETM4x_AMBA_UCI_ID(0x000f0211),		/* Qualcomm Kryo */
> +	ETM4x_AMBA_ID(0x000bb802),		/* Qualcomm Kryo 385 Cortex-A55 */
> +	ETM4x_AMBA_ID(0x000bb803),		/* Qualcomm Kryo 385 Cortex-A75 */
>   	{},
>   };
>   

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
