Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051E9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A2C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfAaSCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:02:11 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49066 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbfAaSCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:02:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61B98A78;
        Thu, 31 Jan 2019 10:02:10 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D84C3F59C;
        Thu, 31 Jan 2019 10:02:00 -0800 (PST)
Subject: Re: [PATCHv6 6/6] coresight: debug: Add Unique Component Identifier
 (UCI) table
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
References: <cover.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <f724b28e5bfd7bca062aa5380cfd9328289559bf.1548943727.git.saiprakash.ranjan@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <304febd7-da9a-92d6-47bb-d9983d4bc5d4@arm.com>
Date:   Thu, 31 Jan 2019 18:01:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f724b28e5bfd7bca062aa5380cfd9328289559bf.1548943727.git.saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/01/2019 14:22, Sai Prakash Ranjan wrote:
> Add UCI table for coresight CPU debug module. This patch adds
> the UCI entries for Kryo CPUs found on MSM8996 which shares
> the same PIDs as ETMs.
> 
> Without this, below error is observed on MSM8996:

nit: Subject doesn't match the patch contents. You could simply say :

coresight: cpu-debug: Add support for Qualcomm Kryo


> 
> [    5.429867] OF: graph: no port node found in /soc/debug@3810000
> [    5.429938] coresight-etm4x: probe of 3810000.debug failed with error -22
> [    5.435415] coresight-cpu-debug 3810000.debug: Coresight debug-CPU0 initialized
> [    5.446474] OF: graph: no port node found in /soc/debug@3910000
> [    5.448927] coresight-etm4x: probe of 3910000.debug failed with error -22
> [    5.454681] coresight-cpu-debug 3910000.debug: Coresight debug-CPU1 initialized
> [    5.487765] OF: graph: no port node found in /soc/debug@3a10000
> [    5.488007] coresight-etm4x: probe of 3a10000.debug failed with error -22
> [    5.493024] coresight-cpu-debug 3a10000.debug: Coresight debug-CPU2 initialized
> [    5.501802] OF: graph: no port node found in /soc/debug@3b10000
> [    5.512901] coresight-etm4x: probe of 3b10000.debug failed with error -22
> [    5.513192] coresight-cpu-debug 3b10000.debug: Coresight debug-CPU3 initialized
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> ---
> For testing, all dependent patches are in below tree:
>   * https://github.com/saiprakash-ranjan/linux/tree/coresight-next
> 
> This patch depends on UCI support by Mike Leach in below link:
>   * https://lore.kernel.org/lkml/20190130234051.2294-1-mike.leach@linaro.org/
> ---
>   .../hwtracing/coresight/coresight-cpu-debug.c | 33 +++++++++----------
>   1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index e8819d750938..915d86a39cee 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -655,24 +655,23 @@ static int debug_remove(struct amba_device *adev)
>   	return 0;
>   }
>   
> +static struct amba_cs_uci_id uci_id_debug[] = {

As Stephen mentioned, this must be "const".

Rest looks fine.

Suzuki
