Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeENKd7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:33:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50805 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeENKd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:33:57 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180514103354euoutp01471b52cad956559837cf055076535c2a~ufFZzCc9b1813918139euoutp01Q
X-AuditID: cbfec7f2-1dbff70000011644-98-5af9661045ae
Subject: Re: [PATCH v2 2/2] drm/bridge: sii902x: add optional power supplies
To: Philippe CORNU <philippe.cornu@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <69a9da79-63df-6d0a-52e3-729ec8937484@samsung.com>
Date: Mon, 14 May 2018 12:33:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f299c615-d884-341c-e1da-2fe030e411ba@st.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7djP87oCaT+jDG5e4LDoPXeSyWLjk9OM
        Fk0db1ktmg6dYrOYf+Qcq8WVr+/ZLDonLmG3uLxrDpvF0usXmSwetLxgtWjde4Tdor2zlc2B
        x2PNvDWMHpf7epk8ZnfMZPXYtKqTzePOtT1sHtu/PWD1uN99nMnj6Y+9zB6fN8kFcEZx2aSk
        5mSWpRbp2yVwZUy5nlPwTb7i8Lw7jA2MUyW7GDk5JARMJJ4fO8LaxcjFISSwglGi4fhxKOcL
        o8SSzqtsEM5nRol3He/ZYVo+/D0EVbWcUeLrtUfsEM5bRokJpy4xg1QJC/hILOm9zAiSEBHY
        zSyx+OEcFhCHWaCLUeLbsXlgVWwCmhJ/N99kA7F5Bewknv9dywhiswioSnSsXc4EYosKREg0
        Pf/JDlEjKHFy5hMWEJtTwEpi/vMpYL3MAvIS29/OYYawxSVuPZnPBLJMQuAnu0T/lV3MEIe7
        SKx+sg/KFpZ4dXwL1EMyEv93zmeCsKslbr5oYoFo7mCUuP+7nQ0iYS1x+PhFoK85gDZoSqzf
        pQ8RtpXofLSPHSQsIcAnceOtIMQNfBKTtk1nhgjzSnS0CUFUK0rcP7sV6gJxiaUXvrJNYFSe
        heSzWUi+mYXkm1kIexcwsqxiFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITHCn/x3/tIPx
        66WkQ4wCHIxKPLwMa35ECbEmlhVX5h5ilOBgVhLh3W30M0qINyWxsiq1KD++qDQntfgQozQH
        i5I4b5xGXZSQQHpiSWp2ampBahFMlomDUwqYcFiXB/Ds+J1jkaTEaJHwq63w3ccPDlXblzv/
        WdKSqGCcMbd6nfB+trKXhTsZ9J/t+7dRxcxH8pfZFZH9bnlHDHX12FiP7Z8U0aj0c6qpuWec
        491pbjx8G523GCi2y5vJJgQYRTOdmfpQ5Eh8iIXse0GRvGdpGoJCR3MPKme0fFtwk1WAcZkS
        S3FGoqEWc1FxIgAof5yDbAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xe7p8aT+jDD5sV7XoPXeSyWLjk9OM
        Fk0db1ktmg6dYrOYf+Qcq8WVr+/ZLDonLmG3uLxrDpvF0usXmSwetLxgtWjde4Tdor2zlc2B
        x2PNvDWMHpf7epk8ZnfMZPXYtKqTzePOtT1sHtu/PWD1uN99nMnj6Y+9zB6fN8kFcEbp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZUy5nlPwTb7i
        8Lw7jA2MUyW7GDk5JARMJD78PcTaxcjFISSwlFGis+EUM0RCXGL3/LdQtrDEn2tdbCC2kMBr
        RonF6xRBbGEBH4klvZcZQZpFBPYyS8y4+JIZxGEW6GGUWHPqKRvE2PeMEpsbL4GNYhPQlPi7
        +SbYKF4BO4nnf9cygtgsAqoSHWuXM4HYogIREvfOf4KqEZQ4OfMJC4jNKWAlMf/5FLA4s4C6
        xJ95EDOZBeQltr+dA2WLS9x6Mp9pAqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJ
        ucWleel6yfm5mxiBEb3t2M8tOxi73gUfYhTgYFTi4V2x8keUEGtiWXFl7iFGCQ5mJRHe3UY/
        o4R4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5hs8kriDU0NzS0sDc2NzY3NLJTEec8bVEYJ
        CaQnlqRmp6YWpBbB9DFxcEo1MCZd///J/MWGyw9y31nZpb2Tm9d/7UlccVp97txleXacZ7b+
        fflaf+FvJ+NlP72spKb2mhcftefi2Lh7f2XN7euZiz9On7Zb9t+24jd19U4n2v12niksYNXL
        zfijMunkJzt5o+CcvQuN2Uumxqneu7po5/HDSZv05yxqnGRenXmq8kqRwJ+PmySUWIozEg21
        mIuKEwEAY+43/gIAAA==
X-CMS-MailID: 20180514103351eucas1p1e8fcc7e4448f9b0c981f31bd4d1b2e30
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180514103351eucas1p1e8fcc7e4448f9b0c981f31bd4d1b2e30
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180514093922epcas2p4090c2d4819b470f2618ba4a333cecb2c
X-RootMTR: 20180514093922epcas2p4090c2d4819b470f2618ba4a333cecb2c
References: <20180425075314.19137-1-philippe.cornu@st.com>
        <20180425075314.19137-3-philippe.cornu@st.com>
        <CGME20180514093922epcas2p4090c2d4819b470f2618ba4a333cecb2c@epcas2p4.samsung.com>
        <f299c615-d884-341c-e1da-2fe030e411ba@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.2018 11:38, Philippe CORNU wrote:
> Hi Laurent, Archit, Andrzej & Yannick,
>
> Do you have any comments on this v2 driver part?
> (more details regarding v1/v2 differences in the cover letter 
> https://www.spinics.net/lists/dri-devel/msg174137.html)
>
> Thank you,
> Philippe :-)
>
>
> On 04/25/2018 09:53 AM, Philippe Cornu wrote:
>> Add the optional power supplies using the description found in
>> "SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".
>>
>> The sii902x input IOs are not "io safe" so it is important to
>> enable/disable voltage regulators during probe/remove phases to
>> avoid damages.

What exactly does it mean? Ie I understand that the chip has some
limitations, but why enabling/disabling regulators in probe/remove
should solve it?

Regards
Andrzej

>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>>   drivers/gpu/drm/bridge/sii902x.c | 38 ++++++++++++++++++++++++++++++++++----
>>   1 file changed, 34 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
>> index 60373d7eb220..c367d7b91ade 100644
>> --- a/drivers/gpu/drm/bridge/sii902x.c
>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/i2c.h>
>>   #include <linux/module.h>
>>   #include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>>   
>>   #include <drm/drmP.h>
>>   #include <drm/drm_atomic_helper.h>
>> @@ -86,6 +87,7 @@ struct sii902x {
>>   	struct drm_bridge bridge;
>>   	struct drm_connector connector;
>>   	struct gpio_desc *reset_gpio;
>> +	struct regulator_bulk_data supplies[2];
>>   };
>>   
>>   static inline struct sii902x *bridge_to_sii902x(struct drm_bridge *bridge)
>> @@ -392,23 +394,42 @@ static int sii902x_probe(struct i2c_client *client,
>>   		return PTR_ERR(sii902x->reset_gpio);
>>   	}
>>   
>> +	sii902x->supplies[0].supply = "iovcc";
>> +	sii902x->supplies[1].supply = "vcc12";
>> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(sii902x->supplies),
>> +				      sii902x->supplies);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to get power supplies: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = regulator_bulk_enable(ARRAY_SIZE(sii902x->supplies),
>> +				    sii902x->supplies);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable power supplies: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	usleep_range(10000, 20000);
>> +
>>   	sii902x_reset(sii902x);
>>   
>>   	ret = regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
>>   	if (ret)
>> -		return ret;
>> +		goto err_disable_regulator;
>>   
>>   	ret = regmap_bulk_read(sii902x->regmap, SII902X_REG_CHIPID(0),
>>   			       &chipid, 4);
>>   	if (ret) {
>>   		dev_err(dev, "regmap_read failed %d\n", ret);
>> -		return ret;
>> +		goto err_disable_regulator;
>>   	}
>>   
>>   	if (chipid[0] != 0xb0) {
>>   		dev_err(dev, "Invalid chipid: %02x (expecting 0xb0)\n",
>>   			chipid[0]);
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +		goto err_disable_regulator;
>>   	}
>>   
>>   	/* Clear all pending interrupts */
>> @@ -424,7 +445,7 @@ static int sii902x_probe(struct i2c_client *client,
>>   						IRQF_ONESHOT, dev_name(dev),
>>   						sii902x);
>>   		if (ret)
>> -			return ret;
>> +			goto err_disable_regulator;
>>   	}
>>   
>>   	sii902x->bridge.funcs = &sii902x_bridge_funcs;
>> @@ -434,6 +455,12 @@ static int sii902x_probe(struct i2c_client *client,
>>   	i2c_set_clientdata(client, sii902x);
>>   
>>   	return 0;
>> +
>> +err_disable_regulator:
>> +	regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
>> +			       sii902x->supplies);
>> +
>> +	return ret;
>>   }
>>   
>>   static int sii902x_remove(struct i2c_client *client)
>> @@ -443,6 +470,9 @@ static int sii902x_remove(struct i2c_client *client)
>>   
>>   	drm_bridge_remove(&sii902x->bridge);
>>   
>> +	regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
>> +			       sii902x->supplies);
>> +
>>   	return 0;
>>   }
>>   
