Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946365AbeCBKiy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:38:54 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57784 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426346AbeCBKVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:21:31 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180302102128euoutp01a68ab90d7e8908512048bae2ac23847d~YE0s9yMkP0667606676euoutp014
X-AuditID: cbfec7f2-1c1ff70000011644-85-5a9925a6d029
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: readl_poll_timeout return
 value clean up
To: Philippe CORNU <philippe.cornu@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, Heiko Stubner <heiko@sntech.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>
Cc: Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <290c749a-70bf-2b74-1fb9-2de26708d001@samsung.com>
Date: Fri, 2 Mar 2018 11:21:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <172e7f68-8f4b-7e5f-3e9f-7aaf10a51dc9@st.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzHfe/54aHOvk7lQ0auH1MWtbX1RFmttp6t1VKr1f1BJ89oOdk9
        UWrKzlVHpd/LHQpzkmby86RMXYukhGKYYsKspitSrB+6x6Plv9fn/Xl/v9/3e/syhGKS8mQO
        xR7ltbHqGCXtTFbVT75eWbDUqFpVMOXDXmxulLGlA02I1RlGKFZnfUGzo+8v0WzZVxvFvh23
        0exU/yeKzb6axKZeyXdkyz50UOybmiy7rW+KYPv0wxT7sv0xyZ5LPUNvxFxmcivJvUm/KOMe
        mN45cpkGI8X1dDyiOcv3PorrPd8g48rzT3O/TXUkZ+m4RXCDE7UEN1bmvXOuynl9JB9zKIHX
        BoYccI5+VtxOxtUuOF7d/AMlo07XNOTEAF4DRRUmKg05MwpciCCvsGJm+IbAXGiVScMYglTj
        Z/rfkUHdV1pa3EHw0XaBEBcKPIKgOD1cZDe8H678qiFF0zycTYFVbyPEgcDJCFIsGZToovFy
        +F3eZb+KYeQ4BJ7kzxdlEi8B3Wibo8jz8T7IvTGIRJZjV2g0DpAiO+EgGNO3TnsI7AMplZmE
        xO7QPXB7OjZgMwNV5sekFHsL2Ay5SGI3+NhQ4SixFzRduzDjOQldwzpSOmxA0Pvz3EznYHja
        0EqJQQl76JKaQEneAKnfcqZlwC7QOeIqZXCBq1U3CUmWg+GsQnL7Qu+rSkJidzC3jNOX0WLT
        rGamWW1Ms9qY/r+bg8gi5M7HC5ooXlgdyx8LENQaIT42KuDgEU0Zsn/Ipj8No9VovC3CijCD
        lHPl0bYMlYJSJwiJGisChlDOk+u/2CV5pDrxBK89Eq6Nj+EFK1rIkEp3eZjfKZUCR6mP8od5
        Po7X/tvKGCfPZLQ9SG9B61oDAu9zaVHGIZ+gyOB+lUPS2aH3YRGlz9OD6vzr/c1Jp31Dh7xC
        dxU1du9eG349p2TbVOkCzmNvFm7bam18YL7r/epkT8/mUW8v5uCJhdH34hy0GRl5m7q9XOdk
        twjNMR4F1I5FD99lhtg8lmlaPPs3R1iquT0TfiluSiUpRKtXryC0gvovAkEPh4wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42I5/e/4Xd2lqjOjDFa/5LXoPXeSyWLjk9OM
        Fk0db1ktmg6dYrP4dK+fzWLTx/esFle+vmez+P/oNavF3Em1Fp0Tl7BbbHp8jdXi8q45QGUP
        /jNbPGh5wWpx5uoBFov2zlY2BwGP2Q0XWTwu9/UyeeycdZfdY3bHTFaPO9f2sHls//aA1eN+
        93Emj81L6j3+ztrP4rH92jxmj6c/9jJ7fN4kF8ATpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdxdO1VloK9YhU7zn1nbGC8IdjFyMkhIWAi8bTp
        IxuILSSwlFGiY4UhRFxcYvf8t8wQtrDEn2tdQDVcQDWvGSU+nd8JlhAWiJSY1XaIBSQhIjCf
        VeLO2unsIA6zQBOjxK+Hj5khWvYxSvz5eY0dpIVNQFPi7+abQLM4OHgF7CQOLhEFCbMIqEg0
        fboEViIqECHRuXI+C4jNKyAocXLmEzCbU8BK4nPLRbAaZgF1iT/zLjFD2PISzVtnQ9niEree
        zGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgSth27Ofm
        HYyXNgYfYhTgYFTi4T3wcUaUEGtiWXFl7iFGCQ5mJRHelg9AId6UxMqq1KL8+KLSnNTiQ4ym
        QM9NZJYSTc4Hpqu8knhDU0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2M
        Cz4Yzt6b5BDF9fW13/70hYGrKrjMgm5f/Lf86/ETHezL5i/kKpKS+5kT5W9b88NUKdOnxVog
        2uzbnkYl29llF2zkhAs6vZrdj/13vekX9OFA7oPZByNMxXmjJN/88nAysX5UeLJcyeTGvTXN
        Apa//+yXyDbveyBwqHi9BUeVQ8cB9n9zUySUWIozEg21mIuKEwFJ9fm1HwMAAA==
X-CMS-MailID: 20180302102125eucas1p2d4575a6ae86c9c287e1c3eedde1c1f20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180302102125eucas1p2d4575a6ae86c9c287e1c3eedde1c1f20
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180301090106epcas2p3c47f4436b0c8a31ce71cfd3909dc77ae
X-RootMTR: 20180301090106epcas2p3c47f4436b0c8a31ce71cfd3909dc77ae
References: <20180204213624.18288-1-philippe.cornu@st.com>
        <CGME20180301090106epcas2p3c47f4436b0c8a31ce71cfd3909dc77ae@epcas2p3.samsung.com>
        <172e7f68-8f4b-7e5f-3e9f-7aaf10a51dc9@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.2018 10:00, Philippe CORNU wrote:
> Hi Archit, Andrzej & Laurent,
>
> May I ask you please your feedback on this small patch?
> Many thanks,
>
> Philippe :-)
>
> On 02/04/2018 10:36 PM, Philippe Cornu wrote:
>> The readl_poll_timeout() return value is 0 in case of success
>> so it is better to detect errors without taking care of the
>> return value sign.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>

The patch is of course correct. However I am not sure if necessary. For
sure functionally it does not change anything.
AFAIK kernel CodingStyle says nothing about it, so I suppose it is
matter of personal taste.
Anyway I can give it:
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> index 65aeb3f78b48..4d0e8471a15c 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -342,7 +342,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>>   	ret = qq(dsi->base + DSI_CMD_PKT_STATUS,
>>   				 val, !(val & GEN_CMD_FULL), 1000,
>>   				 CMD_PKT_STATUS_TIMEOUT_US);
>> -	if (ret < 0) {
>> +	if (ret) {
>>   		dev_err(dsi->dev, "failed to get available command FIFO\n");
>>   		return ret;
>>   	}
>> @@ -353,7 +353,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>>   	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>>   				 val, (val & mask) == mask,
>>   				 1000, CMD_PKT_STATUS_TIMEOUT_US);
>> -	if (ret < 0) {
>> +	if (ret) {
>>   		dev_err(dsi->dev, "failed to write command FIFO\n");
>>   		return ret;
>>   	}
>> @@ -385,7 +385,7 @@ static int dw_mipi_dsi_write(struct dw_mipi_dsi *dsi,
>>   		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>>   					 val, !(val & GEN_PLD_W_FULL), 1000,
>>   					 CMD_PKT_STATUS_TIMEOUT_US);
>> -		if (ret < 0) {
>> +		if (ret) {
>>   			dev_err(dsi->dev,
>>   				"failed to get available write payload FIFO\n");
>>   			return ret;
>> @@ -716,13 +716,13 @@ static void dw_mipi_dsi_dphy_enable(struct dw_mipi_dsi *dsi)
>>   
>>   	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS, val,
>>   				 val & PHY_LOCK, 1000, PHY_STATUS_TIMEOUT_US);
>> -	if (ret < 0)
>> +	if (ret)
>>   		DRM_DEBUG_DRIVER("failed to wait phy lock state\n");
>>   
>>   	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
>>   				 val, val & PHY_STOP_STATE_CLK_LANE, 1000,
>>   				 PHY_STATUS_TIMEOUT_US);
>> -	if (ret < 0)
>> +	if (ret)
>>   		DRM_DEBUG_DRIVER("failed to wait phy clk lane stop state\n");
>>   }
>>   
