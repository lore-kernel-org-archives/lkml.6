Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeA3OKB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:10:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42202 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbeA3OKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:10:00 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5EB816053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v2 1/2] drm/bridge/synopsys: dsi: Add a warning msg on dsi
 read requests
To: Brian Norris <briannorris@chromium.org>,
        Philippe Cornu <philippe.cornu@st.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Mickael Reulier <mickael.reulier@st.com>
References: <20180125103800.1999-1-philippe.cornu@st.com>
 <20180125103800.1999-2-philippe.cornu@st.com>
 <20180126004441.k4pymmsr6brcdzmq@ban.mtv.corp.google.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <18888350-d764-f6bd-5285-a7fac3d300e0@codeaurora.org>
Date: Tue, 30 Jan 2018 19:39:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180126004441.k4pymmsr6brcdzmq@ban.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/26/2018 06:14 AM, Brian Norris wrote:
> On Thu, Jan 25, 2018 at 11:37:59AM +0100, Philippe Cornu wrote:
>> The dcs/generic dsi read feature is not yet implemented so it
>> is important to warn the host_transfer() caller in case of
>> read operation requests.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> 
> Awesome, thanks.
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 

Queued to drm-misc-next.

Thanks,
Archit

>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> index daec7881be6d..72ecaeb40822 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -405,6 +405,12 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>>   	struct mipi_dsi_packet packet;
>>   	int ret;
>>   
>> +	if (msg->rx_buf || msg->rx_len) {
>> +		/* TODO dw drv improvements: implement read feature */
>> +		dev_warn(dsi->dev, "read operations not yet implemented\n");
>> +		return -EINVAL;
>> +	}
>> +
>>   	ret = mipi_dsi_create_packet(&packet, msg);
>>   	if (ret) {
>>   		dev_err(dsi->dev, "failed to create packet: %d\n", ret);
>> -- 
>> 2.15.1
>>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
