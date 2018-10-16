Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00D8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3A22083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3A22083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJPRdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:33:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40194 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJPRdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:33:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 74076260B5F
Subject: Re: [PATCH] drm/bridge: analogix_dp: Fix misleading indentation
 reported by smatch
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        zain wang <wzz@rock-chips.com>,
        dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
References: <20181013111844.22183-1-enric.balletbo@collabora.com>
 <3089039.JAYFEciPKB@avalon>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2f21f4ab-cd03-3286-084b-24b51502d6ba@collabora.com>
Date:   Tue, 16 Oct 2018 11:43:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3089039.JAYFEciPKB@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ho Laurent,

On 16/10/18 01:11, Laurent Pinchart wrote:
> Hi Enric,
> 
> Thank you for the patch.
> 
> On Saturday, 13 October 2018 14:18:44 EEST Enric Balletbo i Serra wrote:
>> This patch avoids that building the bridge/analogix source code with
>> smatch triggers complaints about inconsistent indenting.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c index
>> d68986cea132..75e2649d7515 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -1219,12 +1219,12 @@ static int analogix_dp_bridge_attach(struct
>> drm_bridge *bridge) * plat_data->attch return, that's why we record the
>> connector
>>  	 * point after plat attached.
>>  	 */
>> -	 if (dp->plat_data->attach) {
>> -		 ret = dp->plat_data->attach(dp->plat_data, bridge, connector);
>> -		 if (ret) {
>> -			 DRM_ERROR("Failed at platform attch func\n");
>> -			 return ret;
>> -		 }
>> +	if (dp->plat_data->attach) {
>> +		ret = dp->plat_data->attach(dp->plat_data, bridge, connector);
>> +		if (ret) {
>> +			DRM_ERROR("Failed at platform attch func\n");
>> +			return ret;
>> +		}
>>  	}
> 
> This looks good to me. While at it, could you s/attch/attach/ ? With that 
> fixed,

Sure, will do now, just preparing v2.

> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>>  	if (dp->plat_data->panel) {
> 
