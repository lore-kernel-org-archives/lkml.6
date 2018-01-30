Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbeA3O3p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:29:45 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:19633 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751856AbeA3O3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:29:43 -0500
From: Philippe CORNU <philippe.cornu@st.com>
To: Archit Taneja <architt@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Yannick FERTRE" <yannick.fertre@st.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Ludovic BARRE <ludovic.barre@st.com>,
        Mickael REULIER <mickael.reulier@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH v2 1/2] drm/bridge/synopsys: dsi: Add a warning msg on dsi
 read requests
Thread-Topic: [PATCH v2 1/2] drm/bridge/synopsys: dsi: Add a warning msg on
 dsi read requests
Thread-Index: AQHTmdQIzFeMMEzU0kGM6fXU9VNaqaOMaPkA
Date: Tue, 30 Jan 2018 14:29:13 +0000
Message-ID: <75fe97b4-ff59-e7cf-3f0c-085b281ead80@st.com>
References: <20180125103800.1999-1-philippe.cornu@st.com>
 <20180125103800.1999-2-philippe.cornu@st.com>
 <20180126004441.k4pymmsr6brcdzmq@ban.mtv.corp.google.com>
 <18888350-d764-f6bd-5285-a7fac3d300e0@codeaurora.org>
In-Reply-To: <18888350-d764-f6bd-5285-a7fac3d300e0@codeaurora.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB24A99D0D1E8C408EFB8C663B84AB31@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0UETnHw009624

Hi Archit,

And many thanks,
Philippe :-)

On 01/30/2018 03:09 PM, Archit Taneja wrote:
> 
> 
> On 01/26/2018 06:14 AM, Brian Norris wrote:
>> On Thu, Jan 25, 2018 at 11:37:59AM +0100, Philippe Cornu wrote:
>>> The dcs/generic dsi read feature is not yet implemented so it
>>> is important to warn the host_transfer() caller in case of
>>> read operation requests.
>>>
>>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>>
>> Awesome, thanks.
>>
>> Reviewed-by: Brian Norris <briannorris@chromium.org>
>>
> 
> Queued to drm-misc-next.
> 
> Thanks,
> Archit
> 
>>> ---
>>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c 
>>> b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> index daec7881be6d..72ecaeb40822 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> @@ -405,6 +405,12 @@ static ssize_t dw_mipi_dsi_host_transfer(struct 
>>> mipi_dsi_host *host,
>>>       struct mipi_dsi_packet packet;
>>>       int ret;
>>> +    if (msg->rx_buf || msg->rx_len) {
>>> +        /* TODO dw drv improvements: implement read feature */
>>> +        dev_warn(dsi->dev, "read operations not yet implemented\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>>       ret = mipi_dsi_create_packet(&packet, msg);
>>>       if (ret) {
>>>           dev_err(dsi->dev, "failed to create packet: %d\n", ret);
>>> -- 
>>> 2.15.1
>>>
> 
