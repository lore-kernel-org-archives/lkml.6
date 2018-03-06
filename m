Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbeCFKZG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:25:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46208 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbeCFKZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:25:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EE93601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic
 Meson GX SoCs
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: airlied@linux.ie, a.hajda@samsung.com, Jose.Abreu@synopsys.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1519386277-25902-1-git-send-email-narmstrong@baylibre.com>
 <d0ecb49f-f2bd-0a0d-fa18-c7cb178ca17a@baylibre.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <be7cad05-ab4a-572b-1535-fbd85ea7c386@codeaurora.org>
Date: Tue, 6 Mar 2018 15:54:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d0ecb49f-f2bd-0a0d-fa18-c7cb178ca17a@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 06 March 2018 03:23 PM, Neil Armstrong wrote:
> Hi Architt,
> 
> On 23/02/2018 12:44, Neil Armstrong wrote:
>> The Amlogic Meson GX SoCs, embedded the v2.01a controller, has been also
>> identified needing this workaround.
>> This patch adds the corresponding version to enable a single iteration for
>> this specific version.
>>
>> Fixes: be41fc55f1aa ("drm: bridge: dw-hdmi: Handle overflow workaround based on device version")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index a38db40..f5018f9 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -1637,6 +1637,8 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>>   	 * (and possibly on the platform). So far only i.MX6Q (v1.30a) and
>>   	 * i.MX6DL (v1.31a) have been identified as needing the workaround, with
>>   	 * 4 and 1 iterations respectively.
>> +	 * The Amlogic Meson GX SoCs (v2.01a) have been identifies as needing
>> +	 * the workaround with a single iteration.

s/identifies/identified

>>   	 */
>>   
>>   	switch (hdmi->version) {
>> @@ -1644,6 +1646,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>>   		count = 4;
>>   		break;
>>   	case 0x131a:
>> +	case 0x201a:
>>   		count = 1;
>>   		break;
>>   	default:
>>
> 
> This fixes a long time issue on Amlogic SoCs, is it ok for you ?

Looks good to me. Feel free to queue it to drm-misc-next.

Thanks,
Archit

> 
> Thanks,
> Neil
> 
