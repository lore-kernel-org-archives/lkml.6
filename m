Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbeBINY3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 08:24:29 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39235 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeBINY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 08:24:26 -0500
X-Google-Smtp-Source: AH8x226oM88Kf4j09y+qYSf1ICuowM1Ug8hdjwe28+EeuTVdcjuOH4IamvAJ8gjeQwK7ftsDKCQGuQ==
Subject: Re: [PATCH v2 2/5] clk: mediatek: modify MT7622 audsys to adapt MFD
 device
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Garlic Tseng <garlic.tseng@mediatek.com>
References: <cover.1515639336.git.ryder.lee@mediatek.com>
 <d6669277f5232446b4798a6b724074b18d5c21aa.1515639336.git.ryder.lee@mediatek.com>
 <72058f8d-c83d-d0e6-dc07-83c9f5fc2710@gmail.com>
 <1517803655.1173.12.camel@mtkswgap22>
 <0e0e703c-0ac9-06ad-91c5-abdf16de1ee9@gmail.com>
 <1518069447.28878.4.camel@mtkswgap22>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6fc674ba-a540-ef25-932d-afdc9d8e7fbe@gmail.com>
Date: Fri, 9 Feb 2018 14:24:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518069447.28878.4.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2018 06:57 AM, Ryder Lee wrote:
> On Wed, 2018-02-07 at 16:18 +0100, Matthias Brugger wrote:
>>
>> On 02/05/2018 05:07 AM, Ryder Lee wrote:
>>> On Sat, 2018-02-03 at 15:26 +0100, Matthias Brugger wrote:
>>>>
>>>> On 01/31/2018 08:42 AM, Ryder Lee wrote:
>>>>> As the new MFD parent is in place, switch probing method to adapt it.
>>>>>
>>>>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>>>>> ---
>>>>>  drivers/clk/mediatek/clk-mt7622-aud.c | 3 ++-
>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
>>>>> index 13f752d..8c18536 100644
>>>>> --- a/drivers/clk/mediatek/clk-mt7622-aud.c
>>>>> +++ b/drivers/clk/mediatek/clk-mt7622-aud.c
>>>>> @@ -142,11 +142,12 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
>>>>>  {
>>>>>  	struct clk_onecell_data *clk_data;
>>>>>  	struct device_node *node = pdev->dev.of_node;
>>>>> +	struct device_node *pnode = pdev->dev.parent->of_node;
>>>>>  	int r;
>>>>>  
>>>>>  	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
>>>>>  
>>>>> -	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
>>>>> +	mtk_clk_register_gates(pnode, audio_clks, ARRAY_SIZE(audio_clks),
>>>>
>>>> We will need a fallback here for older device tree bindings.
>>>>
>>>> Regards,
>>>> Matthias
>>>
>>> Up to now, I didn't see both driver and bindings are used anywhere.
>>> Should I still care about that?
>>>
>>
>> Yes please, we have to ensure that newer kernel work with older bindings and
>> vice-versa.
> 
> OKay. An unrelated question - is it possible to change the compatible
> string (*-audsys-clk) without breaking backward compatible?
> 

You can't change the compatible string, but you can add a new one, if the DT
maintainer are ok with that. Beware that you won't be able to re-use the old one
in a different driver.

Regards,
Matthias
