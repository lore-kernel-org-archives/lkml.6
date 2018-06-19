Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9CFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7142083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NUZCMOQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7142083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965013AbeFSETR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:19:17 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:25759 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeFSETD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:19:03 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180619041900epoutp03029f08709d7fcb88f62ff43a568b4b7e~5dMWI4hMq2245922459epoutp034;
        Tue, 19 Jun 2018 04:19:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180619041900epoutp03029f08709d7fcb88f62ff43a568b4b7e~5dMWI4hMq2245922459epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529381940;
        bh=bY0jhJPjon8+x5HE3spbf3h7Km2Zr4AfJmV3sSskobE=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=NUZCMOQqmzK/HO5wupifACiOW2+3xIzIYSxZ+376VSqj7J5v9gIyOkayLXWF8Hb7Q
         taHAAmISoueJj1DHZxy7TQzWW0OSl3QbqDvwF0PnY47ZLGVyw7FUpS5mr32SI9VCxL
         SYeZIF85qQnvW7ns+AMA51UhDVeQJKrfEjGMqAO0=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.152]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180619041857epcas1p3d7178b74483e21466cade6952db280fa~5dMTtlYek2913829138epcas1p3n;
        Tue, 19 Jun 2018 04:18:57 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.05.04217.134882B5; Tue, 19 Jun 2018 13:18:57 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20180619041857epcas2p47c45471787365849472e56ebc045d36c~5dMTd4SvV2603126031epcas2p4u;
        Tue, 19 Jun 2018 04:18:57 +0000 (GMT)
X-AuditID: b6c32a45-441ff70000001079-31-5b288431e4ed
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id B1.85.04192.134882B5; Tue, 19 Jun
        2018 13:18:57 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PAJ00A2NYNKAH10@mmp2.samsung.com>; Tue, 19 Jun 2018 13:18:57 +0900 (KST)
Message-id: <5B288430.2040600@samsung.com>
Date:   Tue, 19 Jun 2018 13:18:56 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Enric Balletbo Serra <eballetbo@gmail.com>, cwchoi00@gmail.com
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] devfreq: rk3399_dmc: Fix duplicated opp table on
 reload.
In-reply-to: <CAFqH_51ptafw-Z_8-FqtxbTH9LU560cHoM5TFiF01ZwG_jW3VQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmua5hi0a0weW3ShbPjmpbXPi9ks1i
        ze1DjBabz/WwWpxtesNucXnXHDaLz71HGC1uN65gc+Dw2HF3CaPHzll32T36tqxi9Pi8SS6A
        JSrVJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVK0oaGRnqGBuZ6REZA2jrUyMgUqSUjN+L2vhamg
        QaWi8fAcpgbGa1JdjJwcEgImEguPTWHuYuTiEBLYwSjRt+oSK4TznVGi5+pnNpiqL1POM0Ek
        NjBKXO5dzQqS4BUQlPgx+R5LFyMHB7OAvMSRS9kgYWYBTYkXXyaxQNTfZZSY3HaBHaJeS2Ld
        9jZmEJtFQFVi9c9pYHE2oPj+FzfAlvELKEpc/fGYEcQWFYiQ2Dn/G1iNiICTxM4pm8FOZRZo
        YJJ49v8v2BHCAv4Sh5+9BRvKKRAs8XHXdLDNEgJn2CQ2vjjLAvGCi8STZdOgbGGJV8e3sEPY
        0hLPVm1khGhoZ5T48qKZFcKZwCjx4dRmJogqY4lnC7uYIJ7jk+g4/Jcd5GcJAV6JjjYhiBIP
        ifmz90HDaDGTxNGHf9gnMMrOQgqmWYhgmoUUTAsYmVcxiqUWFOempxYbFRjqFSfmFpfmpesl
        5+duYgQnNy3XHYwzzvkcYhTgYFTi4dVYrx4txJpYVlyZe4hRgoNZSYT3WLVGtBBvSmJlVWpR
        fnxRaU5q8SFGU2AoT2SWEk3OBybevJJ4Q1MjY2NjC1NzS2MDSyVxXsabAtFCAumJJanZqakF
        qUUwfUwcnFINjGc3+Z/O+r48bUaOz1XPcN9NNjMKa9fLvkhv8HIo6am1X/dqeu+rVdZn1H1V
        rv/7dpBRK8yv21apeC/btQX9OvO1sr7uWXK36NiKwxYT5E7Nb3++4dO0U79OpJgkbTJ89f77
        7a8sm9sfWM38M/eksv/zVIuO+6/jWoRu+Dgs/G2+v3+/g1uqfLcSS3FGoqEWc1FxIgCvaJW8
        hAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsVy+t9jQV3DFo1ogz87+C2eHdW2uPB7JZvF
        mtuHGC02n+thtTjb9Ibd4vKuOWwWn3uPMFrcblzB5sDhsePuEkaPnbPusnv0bVnF6PF5k1wA
        SxSXTUpqTmZZapG+XQJXxu99LUwFDSoVjYfnMDUwXpPqYuTkkBAwkfgy5TxTFyMXh5DAOkaJ
        pp7vrCAJXgFBiR+T77F0MXJwMAvISxy5lA1hqktMmZILUX6fUaLt3wIWiHItiXXb25hBbBYB
        VYnVP6exg9hsQPH9L26wgdj8AooSV388ZgSZIyoQIdF9ohIkLCLgJLFzymZmkJnMAk1MEqc/
        zAE7QVjAV+Lbi0dgtpDAYiaJSd84QWxOgWCJudf2ME9gFJiF5NJZCJfOQrh0ASPzKkbJ1ILi
        3PTcYqMCo7zUcr3ixNzi0rx0veT83E2MwCDfdlirfwfj4yXxhxgFOBiVeHg11qtHC7EmlhVX
        5h5ilOBgVhLhPVatES3Em5JYWZValB9fVJqTWnyIUZqDRUmclz//WKSQQHpiSWp2ampBahFM
        lomDU6qBUTLaycd5RWV6OfOGD/6iRQeLimrnH5nz2uZ7w+Jp22xW+19eemmyVM7OC59PhSe8
        U58rwzLRbLNzUxDvDenN+b1hdf1dHTMzSgViVZbvD05NOLGcb+6CuFaG+BWehXpfLIpmWQar
        OzOp7bIU2M61a3eA9ZuIv4enrN0lvmmRBJvenQszpDc8VGIpzkg01GIuKk4EAO3ZtNVuAgAA
X-CMS-MailID: 20180619041857epcas2p47c45471787365849472e56ebc045d36c
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180618091029epcas3p498708535c8f8df019bf3785a199d58b4
References: <20180615151217.29872-1-enric.balletbo@collabora.com>
        <CAGTfZH16O6u_3QJ2u1eecUnGptSBf1ho47RPefOTmrw+Syxr0w@mail.gmail.com>
        <CGME20180618091029epcas3p498708535c8f8df019bf3785a199d58b4@epcas3p4.samsung.com>
        <CAFqH_51ptafw-Z_8-FqtxbTH9LU560cHoM5TFiF01ZwG_jW3VQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 2018년 06월 18일 18:10, Enric Balletbo Serra wrote:
> Hi Chanwoo,
> 
> Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de juny
> 2018 a les 5:23:
>>
>> Hi Enric,
>>
>> 2018-06-16 0:12 GMT+09:00 Enric Balletbo i Serra <enric.balletbo@collabora.com>:
>>> The opp table is not removed when the driver is unloaded neither when
>>> there is an error within probe, so if the driver is reloaded the opp
>>> core shows the following warning:
>>>
>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>                200000000, volt: 900000, enabled: 1. New: freq: 200000000,
>>>                volt: 900000, enabled: 1
>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>                400000000, volt: 900000, enabled: 1. New: freq: 400000000,
>>>                volt: 900000, enabled: 1
>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>                666000000, volt: 900000, enabled: 1. New: freq: 666000000,
>>>                volt: 900000, enabled: 1
>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>                800000000, volt: 900000, enabled: 1. New: freq: 800000000,
>>>                volt: 900000, enabled: 1
>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>                928000000, volt: 900000, enabled: 1. New: freq: 928000000,
>>>                volt: 900000, enabled: 1
>>>
>>> This patch fixes the error path in the probe function and adds a .remove
>>> function to properly cleanup the opp table on unloading.
>>>
>>> Fixes: 5a893e31a636c (PM / devfreq: rockchip: add devfreq driver for rk3399 dmc)
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>
>>>  drivers/devfreq/rk3399_dmc.c | 31 +++++++++++++++++++++++++++----
>>>  1 file changed, 27 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>>> index d5c03e5abe13..e795ad2b3f6b 100644
>>> --- a/drivers/devfreq/rk3399_dmc.c
>>> +++ b/drivers/devfreq/rk3399_dmc.c
>>> @@ -375,8 +375,10 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>>>         data->rate = clk_get_rate(data->dmc_clk);
>>>
>>>         opp = devfreq_recommended_opp(dev, &data->rate, 0);
>>> -       if (IS_ERR(opp))
>>> -               return PTR_ERR(opp);
>>> +       if (IS_ERR(opp)) {
>>> +               ret = PTR_ERR(opp);
>>> +               goto err_free_opp;
>>> +       }
>>>
>>>         data->rate = dev_pm_opp_get_freq(opp);
>>>         data->volt = dev_pm_opp_get_voltage(opp);
>>> @@ -388,13 +390,33 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>>>                                            &rk3399_devfreq_dmc_profile,
>>>                                            DEVFREQ_GOV_SIMPLE_ONDEMAND,
>>>                                            &data->ondemand_data);
>>> -       if (IS_ERR(data->devfreq))
>>> -               return PTR_ERR(data->devfreq);
>>> +       if (IS_ERR(data->devfreq)) {
>>> +               ret = PTR_ERR(data->devfreq);
>>> +               goto err_free_opp;
>>> +       }
>>> +
>>>         devm_devfreq_register_opp_notifier(dev, data->devfreq);
>>>
>>>         data->dev = dev;
>>>         platform_set_drvdata(pdev, data);
>>>
>>> +       return 0;
>>
>> It looks strange. Because rk3399_dmcfreq_probe() already include
>> 'return 0' when success.
>> What is the base commit of this patch?
>>
> 
> Sorry, I am not sure I understand your question, If I am not answering
> below could you rephrase?

When I check the rk3399_dmcfreq_probe()[1], as I commented,
rk3399_dmcfreq_probe() already 'return 0' after platform_set_drvdata().
You can check it on link[1].
[1] https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/devfreq/rk3399_dmc.c#L443

But, this patch add new '+       return 0;' line again in rk3399_dmcfreq_probe().
So, just I asked what is base commit of this patch.

> 
> So, once the opp table is added we need an error path to free it if an
> error occurs later. When the probe returns 0, we need to free the opp
> table when we remove the module.
> 
>> [snip]
>>
>> Anyway, if probe fail, device driver have to remove registered OPP table.
>> Looks good to me.
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
> 
> Thanks,
>  Enric
> 
>> --
>> Best Regards,
>> Chanwoo Choi
>> Samsung Electronics
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
