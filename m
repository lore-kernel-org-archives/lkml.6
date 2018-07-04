Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DE9C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8122824633
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HsGRPbe5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ey2lpgjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8122824633
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933101AbeGDHQb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:16:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932648AbeGDHQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:16:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 26125606AC; Wed,  4 Jul 2018 07:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530688588;
        bh=KHE9utq9sTTBxasmMa+SVtzu9aALCwlOe4ym/Sk6ZZo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HsGRPbe5YoiO8AyDfvMlv/qujrtLPG6t37WrbkGlWMFOUtQy1MCGuY+KQpaf3zzTJ
         zGIn12kK7F49e+PvdfF+lKkzDQ93d1wVAZMubD0tjgrReeS09mLW6ttacr31cnAdT2
         bFvUCG/s6Ue+r0je9S8gp+DYeiVjY4Y9q3pa7Lr4=
Received: from [10.79.40.41] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4295F60274;
        Wed,  4 Jul 2018 07:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530688587;
        bh=KHE9utq9sTTBxasmMa+SVtzu9aALCwlOe4ym/Sk6ZZo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ey2lpgjP6RfFnIZDHz4pYzTHTCGBmeUeCWnhhFjyXFrBQy2C9/aVt6d2U72yZEhAV
         rJ7dhxIV+Ptdis27UM5l44LehgWSePcpmPOxAmvUdzcg8PvNAV7AfSHHk2NM4BY6Rb
         3fb9XcxnxzuE9mqUszdB/f+mjUcyso2pCKAs4pIE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4295F60274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 2/2] device core: Add flag to autoremove device link on
 supplier unbind
To:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org>
 <20180627125056.12851-2-vivek.gautam@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <5b2d17e8-2224-512c-e01c-212828ecf74b@codeaurora.org>
Date:   Wed, 4 Jul 2018 12:46:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627125056.12851-2-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Ulf and Marek.

On 6/27/2018 6:20 PM, Vivek Gautam wrote:
> Add a flag to autoremove the device links on supplier driver
> unbind. This obviates the need to explicitly delete the link
> in the remove path.
> We remove these links only when the supplier's link to its
> consumers has gone to DL_STATE_SUPPLIER_UNBIND state.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> ---

Hi Rafael, et al.

Gentle ping.
Do you have comments on this series. I would really like to conclude these
device link additions sooner, and get things moving on the long awaited
arm-smmu clock/runtime support series.

Thanks again for reviewing these patches.

Best regards
Vivek
>   Documentation/driver-api/device_link.rst |  4 ++++
>   drivers/base/core.c                      | 10 ++++++++++
>   include/linux/device.h                   |  2 ++
>   3 files changed, 16 insertions(+)
>
> diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
> index a005b904a264..d6763272e747 100644
> --- a/Documentation/driver-api/device_link.rst
> +++ b/Documentation/driver-api/device_link.rst
> @@ -86,6 +86,10 @@ automatically purged when the consumer fails to probe or later unbinds.
>   This obviates the need to explicitly delete the link in the ``->remove``
>   callback or in the error path of the ``->probe`` callback.
>   
> +Similarly, when the device link is added from supplier's ``->probe`` callback,
> +``DL_FLAG_AUTOREMOVE_SUPPLIER`` causes the device link to be automatically
> +purged when the supplier fails to probe or later unbinds.
> +
>   Limitations
>   ===========
>   
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 14c1e3151e08..e721218bf352 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -518,6 +518,16 @@ void device_links_driver_cleanup(struct device *dev)
>   
>   		WARN_ON(link->flags & DL_FLAG_AUTOREMOVE_CONSUMER);
>   		WARN_ON(link->status != DL_STATE_SUPPLIER_UNBIND);
> +
> +		/*
> +		 * autoremove the links between this @dev and its consumer
> +		 * devices that are not active, i.e. where the link state
> +		 * has moved to DL_STATE_SUPPLIER_UNBIND.
> +		 */
> +		if (link->status == DL_STATE_SUPPLIER_UNBIND &&
> +		    link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
> +			kref_put(&link->kref, __device_link_del);
> +
>   		WRITE_ONCE(link->status, DL_STATE_DORMANT);
>   	}
>   
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 3929805cdd59..e80920452b49 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -787,11 +787,13 @@ enum device_link_state {
>    * AUTOREMOVE_CONSUMER: Remove the link automatically on consumer driver unbind.
>    * PM_RUNTIME: If set, the runtime PM framework will use this link.
>    * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
> + * AUTOREMOVE_SUPPLIER: Remove the link automatically on supplier driver unbind.
>    */
>   #define DL_FLAG_STATELESS		BIT(0)
>   #define DL_FLAG_AUTOREMOVE_CONSUMER	BIT(1)
>   #define DL_FLAG_PM_RUNTIME		BIT(2)
>   #define DL_FLAG_RPM_ACTIVE		BIT(3)
> +#define DL_FLAG_AUTOREMOVE_SUPPLIER	BIT(4)
>   
>   /**
>    * struct device_link - Device link representation.

