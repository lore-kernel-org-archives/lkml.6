Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310CCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81C6214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BTHDQUQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfAJRrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:47:22 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:13075 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfAJRrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:47:21 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190110174719epoutp03f0e5fd2bef0778aa5f997345e35fa94b~4jdnztz_-1621016210epoutp034;
        Thu, 10 Jan 2019 17:47:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190110174719epoutp03f0e5fd2bef0778aa5f997345e35fa94b~4jdnztz_-1621016210epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547142439;
        bh=LNLKliPqqbdQ7yDDQDuVE6HuhFZ9/AtdFy837tOQyGU=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=BTHDQUQys774cXZ3/v7mYXQvpNg6sBdhYBr/sAL+5pQZXnZ4t5OcAN0ViNp/ptdj9
         /oEkHsFw8FbkeQDM9pu/5iZnc/U5OA16Tu7AoBKBRnS351WmOP4ZEE2U4g0HEic0QE
         B6Or+hcPIGKMJ5NOPvBtrXJ3goC8NfjeWf5hNOio=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190110174718epcas2p14f13c48a67624dd93c4df805a56c92d6~4jdnh96Z40871708717epcas2p1_;
        Thu, 10 Jan 2019 17:47:18 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.D7.04055.625873C5; Fri, 11 Jan 2019 02:47:18 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190110174716epcas2p263397b69517d4c588c24750bb0b71937~4jdlsycWN2752927529epcas2p29;
        Thu, 10 Jan 2019 17:47:16 +0000 (GMT)
X-AuditID: b6c32a48-3a9ff70000000fd7-83-5c3785263e39
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id C1.3B.03627.425873C5; Fri, 11 Jan
        2019 02:47:16 +0900 (KST)
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PL400GOMMQOTQ80@mmp2.samsung.com>; Fri, 11 Jan 2019 02:47:16 +0900 (KST)
Subject: Re: [PATCH 4/4] dt-bindings: mfd: max8998: Add charger subnode
 binding
To:     =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <5765349a-c94d-49c1-45b5-ab7ac09f9923@samsung.com>
Date:   Thu, 10 Jan 2019 18:47:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
In-reply-to: <2089055.mctyXeETjz@acerlaptop>
Content-language: en-GB
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7bCmqa5aq3mMQUOPscXUh0/YLOYfOcdq
        cf/rUUaLb1c6mCwu75rDZvG59wijxdLrF5ksfhzvY7Zo3XuE3eL07hIHLo8189YweuycdZfd
        Y9OqTjaPO9f2sHl83iQXwBrFZZOSmpNZllqkb5fAlXG4aR1jwR+JigdPVjE3MPaKdDFyckgI
        mEj8vfWSsYuRi0NIYAejxOJHrawQzndGidvzm4AyHGBVqzcXQcQ3ABU9OckI0s0rICjxY/I9
        FhCbWUBT4sWXSSwQRfcZJRY9m8MG0iwsECjxY2sySI2IQIbEoc5vTCA1zAKHGSXeHTzABJJg
        EzCU6D3aBzXUTuLSuSXsIDaLgKrEr4Z3zCC2qECERMf91WwgNqeAjsSsOcuYIRaLSxy7f5MR
        wpaXOHjlOdgREgKv2SQatixggvjTRWLTwslQtrDEq+Nb2CFsaYlnqzYyQtjVEru2dzNDNHcw
        SrRc2M4MkbCWOHz8IivEBj6JjsN/2SHBwivR0SYEUeIh0X2+mx3i+11MEm37DzFNYJSdhRRK
        s5BCaRaSw2chOXwBI8sqRrHUguLc9NRiowITveLE3OLSvHS95PzcTYzg1KLlsYPxwDmfQ4wC
        HIxKPLwdvuYxQqyJZcWVuYcYJTiYlUR47yw3ixHiTUmsrEotyo8vKs1JLT7EKM3BoiTO+1B6
        brSQQHpiSWp2ampBahFMlomDU6qBUUeLJfJ+qKTc/wnfhSISph85/tbDYhnTysr5vxrm3Hvw
        cc38Ods27lrBo+nTaSqWPnkCe+vksgMML/R6Fjc+8n+/vDkr4/WUrTHSXy88/6/db2onzLk5
        SeeRxJ9PXulHOXrfa79M5nq7J/j6gXWrepl1fWu/fHzW/eDPpZ1v4ozT442PT1y0qliJpTgj
        0VCLuag4EQCfPOrHKQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t9jQV2VVvMYg6WrTSymPnzCZjH/yDlW
        i/tfjzJafLvSwWRxedccNovPvUcYLZZev8hk8eN4H7NF694j7Band5c4cHmsmbeG0WPnrLvs
        HptWdbJ53Lm2h83j8ya5ANYoLpuU1JzMstQifbsErozDTesYC/5IVDx4soq5gbFXpIuRg0NC
        wERi9eaiLkYuDiGBdYwS65/8YOxi5OTgFRCU+DH5HgtIDbOAusSUKbkQNQ8ZJQ7OO80CUiMs
        4C8xbWofE4gtIpAhsXvCCiaQImaBw4wSa85cZYfo2MUkMfXVUrCpbAKGEr1H+6A22ElcOreE
        HcRmEVCV+NXwjhnEFhWIkDj7ch1YDaeAjsSsOcvA4swC4hLH7t9khLDlJQ5eec4ygVFgFpJj
        ZyEcOwtJxywkHQsYWVYxSqYWFOem5xYbFRjlpZbrFSfmFpfmpesl5+duYgRGyLbDWv07GB8v
        iT/EKMDBqMTD2+FrHiPEmlhWXJl7iFGCg1lJhPfOcrMYId6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4rz8+ccihQTSE0tSs1NTC1KLYLJMHJxSDYxxTIwOvKX5r9a33/aXOTS7r4Gnjq3i/s3oPP3/
        YSUV4dlxB+8qhlw8tSt/Z4H4Evvbx+7n8N0+zOwgpu14MyZbL8Alu3HO+V+eE5mP5jHecj5x
        RlRgyaG095Ue587LTfr7TJ0h7GqOcm/5bPfOx1duL5vlcDc5T+oH00Nfq3PL49YuWbxynY4S
        S3FGoqEWc1FxIgBfTG9xjAIAAA==
X-CMS-MailID: 20190110174716epcas2p263397b69517d4c588c24750bb0b71937
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180501144322epcas2p39f8413a212ad5d3ec7b06f0a164d0908
References: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
        <1524844982-4714-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
        <20180501124540.3icpjevaxp44ew2e@earth.universe>
        <CGME20180501144322epcas2p39f8413a212ad5d3ec7b06f0a164d0908@epcas2p3.samsung.com>
        <2089055.mctyXeETjz@acerlaptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/1/18 16:43, Paweł Chmiel wrote:
> On Tuesday, May 1, 2018 2:45:40 PM CEST Sebastian Reichel wrote:
>> On Fri, Apr 27, 2018 at 06:03:02PM +0200, Paweł Chmiel wrote:
>>> This patch adds devicetree bindings documentation for
>>> battery charging controller as the subnode of MAX8998 PMIC.
>>> It's based on current behavior of driver.
>>>
>>> Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
>>> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/mfd/max8998.txt | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)

>>> --- a/Documentation/devicetree/bindings/mfd/max8998.txt
>>> +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
>>> @@ -50,6 +50,21 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
>>>  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
>>>    for buck2 regulator that can be selected using dvs gpio.
>>>  
>>> +Charger: Configuration for battery charging controller should be added
>>> +inside a child node named 'charger'.
>>> +  Required properties:
>>> +  - max8998,charge-eoc: Setup "End of Charge". If value equals 0,
>>> +    remain value set from bootloader or default value will be used.
>>> +    Valid values: 0, 10 - 45
>>> +
>>> +  - max8998,charge-restart: Setup "Charge Restart Level". If value equals 0,
>>> +    remain value set from bootloader or default value will be used.
>>> +    Valid values: -1, 0, 100, 150, 200

Perhaps change the property name to max8998,charge-restart-threshold, 
in include/linux/mfd/max8998.h we have:

 * @restart: Restart Level in mV: 100, 150, 200, and -1 for disable.
 *   If it equals 0, leave it unchanged.

Then we could make it an optional property:

 - max8998,charge-restart-threshold: Charge restart threshold in millivolts. 
   Valid values are: 0, 100, 150, 200. If the value equals 0 the charger 
   restart will be disabled.

If the property is missing the charger restart threshold configuration would
be left unchanged.

>>> +  - max8998,charge-timeout: Setup "Charge Full Timeout". If value equals 0,
>>> +    remain value set from bootloader or default value will be used.
>>> +    Valid values: -1, 0, 5, 6, 7
>>
>> What are those values? seconds?
>>
> Honestly i don't know. I've just documented values accepted currently 
> by charger driver, so we can use it from devicetree.
> I couldn't find any max8998 datasheet with this information (units, possible 
> values etc for those properties).

The charge timeout is in hours, as described in include/linux/mfd/max8998.h:


"* @timeout: Full Timeout in hours: 5, 6, 7, and -1 for disable.
 *   If it equals 0, leave it unchanged.
 *   Otherwise, leave it unchanged."

We could change description of the property to something along the lines of:

Optional properties:

  - max8998,charge-timeout: Charge timeout in hours. Valid values are:
    0, 5, 6, 7. If the value is 0 the charge timer will be disabled.

Then if the property is missing the driver will leave charge timer configuration
unchanged.

-- 
Regards,
Sylwester
