Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5E8C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5026720693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hxK+vgol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5026720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754063AbeFTAud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:50:33 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:24524 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeFTAua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:50:30 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180620005028epoutp04af7922bda2e10879a5b2e83291605048~5t-jqsHNc2720627206epoutp04N;
        Wed, 20 Jun 2018 00:50:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180620005028epoutp04af7922bda2e10879a5b2e83291605048~5t-jqsHNc2720627206epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529455828;
        bh=LLHl3aZOMcRVPRQKbE8JmV6+g+dCDTxZb/cZYbBSiNs=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=hxK+vgolFhoourK8XAZfAxAj71t1J87ype9g5B2/lxy1udemL62df/xoP2FtP5ntw
         HkiuYcbyGr4Wk5cAzlzMdVuZN2Q0V01fk8EgoURRs3Y4CC/6iwpPVVUckx08/0z+6J
         JwJgU4sgL9/EggiIzZGr/r6aZZedsxjQndDOnSj4=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180620005023epcas1p4ba67418513fec0f8458501aff31775ca~5t-fHTf441573715737epcas1p4u;
        Wed, 20 Jun 2018 00:50:23 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.1A.04066.EC4A92B5; Wed, 20 Jun 2018 09:50:22 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180620005022epcas1p24383a255876b51612299b6fae173ae4e~5t-eRrhAK0613906139epcas1p2l;
        Wed, 20 Jun 2018 00:50:22 +0000 (GMT)
X-AuditID: b6c32a35-0066c9c000000fe2-fe-5b29a4ce1fb8
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.DD.03915.EC4A92B5; Wed, 20 Jun 2018 09:50:22 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PAL007D6JNYVW40@mmp1.samsung.com>; Wed, 20 Jun 2018 09:50:22 +0900 (KST)
Message-id: <5B29A4CE.9060009@samsung.com>
Date:   Wed, 20 Jun 2018 09:50:22 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        cwchoi00@gmail.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] devfreq: rk3399_dmc: Fix duplicated opp table on
 reload.
In-reply-to: <65546a48-3291-9836-cb0c-1e65ff7c9d41@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmnu65JZrRBq8atSyeHdW2uPB7JZvF
        mtuHGC02n+thtTjb9Ibd4vKuOWwWn3uPMFrcblzB5sDhsePuEkaPnbPusnv0bVnF6PF5k1wA
        S1SqTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
        ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoQ0MjPUMDcz0jIyBtHGtlZApUkpCaMXX9feaC
        GfoVr3rfMzUwblTuYuTkkBAwkeibtJa1i5GLQ0hgB6PEsU0HGCGc74wSD7rnMcFUnd0whxnE
        FhLYzSixcYYPiM0rICjxY/I9li5GDg5mAXmJI5eyQcLMApoSL75MYoGYc5dRYteqL8wQ9VoS
        B262sIHYLAKqEmv+bwSz2YDi+1/cALP5BRQlrv54zAhiiwpESOyc/40dxBYRqJa48Pk+E8hQ
        ZoHjjBJdP3+CDRUW8Jc4/OwtM8gRnAKOEnsP+YHUSAicYJO4smcbM8QDLhJfr85kh7CFJV4d
        38IOUi8hIC1x6agtRH07o8SXF82sEM4ERokPpzZDfW8s8WxhFxPEa3wS7772sEI080p0tAlB
        lHhIzJ+9jwni499MEj/O32abwCg7CymQZiECaRZSIC1gZF7FKJZaUJybnlpsWGCoV5yYW1ya
        l66XnJ+7iRGc1rRMdzBOOedziFGAg1GJh5eBWTNaiDWxrLgy9xCjBAezkggvwymNaCHelMTK
        qtSi/Pii0pzU4kOMpsAwnsgsJZqcD0y5eSXxhqZGxsbGFiaGZqaGhkrivBU3BaKFBNITS1Kz
        U1MLUotg+pg4OKUaGBnnMmzfu/Ss+eLg3IjtSc4ROXzXq0y5PdZOLmPm/Vi2rPyhQPzug2Yh
        3NxpCd3R2+23T4myintcfoxVduXCuGVdU6MWunitSqgoXm5uPLVq/6T3ER9WKHHNT/tbsqj1
        pEXD019xAQzcoRp/T78NPLhF69HGrBJnXR4em8QHm8t6Ttq9ipj0VImlOCPRUIu5qDgRABjL
        1byBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsVy+t9jAd1zSzSjDTq6xCyeHdW2uPB7JZvF
        mtuHGC02n+thtTjb9Ibd4vKuOWwWn3uPMFrcblzB5sDhsePuEkaPnbPusnv0bVnF6PF5k1wA
        SxSXTUpqTmZZapG+XQJXxtT195kLZuhXvOp9z9TAuFG5i5GTQ0LAROLshjnMXYxcHEICOxkl
        /pxoZgNJ8AoISvyYfI+li5GDg1lAXuLIpWwIU11iypRciPL7jBIfvq6CKteSOHCzBcxmEVCV
        WPN/I5jNBhTf/+IGmM0voChx9cdjRpA5ogIREt0nKkHCIgLVEsdvnGcCmckscJJR4tiCZkaQ
        hLCAr8S3F49YIZb9ZpJ4d/UVK0gzp4CjxN5DfhMYBWYhuXQWwqWzEC5dwMi8ilEytaA4Nz23
        2KjAMC+1XK84Mbe4NC9dLzk/dxMjMMi3Hdbq28F4f0n8IUYBDkYlHl4GZs1oIdbEsuLK3EOM
        EhzMSiK8DKc0ooV4UxIrq1KL8uOLSnNSiw8xSnOwKInz3s47FikkkJ5YkpqdmlqQWgSTZeLg
        lGpgZGgpXD/tyrzLUe0vCw8/E/s6K6WxkW1aZ2ZW5OoV4VsmNoUaaKrs3MhuMCEpONHjZY1c
        1NKtc/KD+epild9ei+B/PTeMK5Fj3f+HE4NrtD8mxjUVJUiyJKT8kPHatuqNfpjTpxlLJ7J5
        BQRLeB97sbcxz9w7lGNDXd3pWT9/TJPtrrh0VfewEktxRqKhFnNRcSIASuzJ4G4CAAA=
X-CMS-MailID: 20180620005022epcas1p24383a255876b51612299b6fae173ae4e
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180618091029epcas3p498708535c8f8df019bf3785a199d58b4
References: <20180615151217.29872-1-enric.balletbo@collabora.com>
        <CAGTfZH16O6u_3QJ2u1eecUnGptSBf1ho47RPefOTmrw+Syxr0w@mail.gmail.com>
        <CGME20180618091029epcas3p498708535c8f8df019bf3785a199d58b4@epcas3p4.samsung.com>
        <CAFqH_51ptafw-Z_8-FqtxbTH9LU560cHoM5TFiF01ZwG_jW3VQ@mail.gmail.com>
        <5B288430.2040600@samsung.com>
        <65546a48-3291-9836-cb0c-1e65ff7c9d41@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 2018년 06월 19일 17:07, Enric Balletbo i Serra wrote:
> Hi Chanwoo,
> 
> On 19/06/18 06:18, Chanwoo Choi wrote:
>> Hi Enric,
>>
>> On 2018년 06월 18일 18:10, Enric Balletbo Serra wrote:
>>> Hi Chanwoo,
>>>
>>> Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de juny
>>> 2018 a les 5:23:
>>>>
>>>> Hi Enric,
>>>>
>>>> 2018-06-16 0:12 GMT+09:00 Enric Balletbo i Serra <enric.balletbo@collabora.com>:
>>>>> The opp table is not removed when the driver is unloaded neither when
>>>>> there is an error within probe, so if the driver is reloaded the opp
>>>>> core shows the following warning:
>>>>>
>>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>>>                200000000, volt: 900000, enabled: 1. New: freq: 200000000,
>>>>>                volt: 900000, enabled: 1
>>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>>>                400000000, volt: 900000, enabled: 1. New: freq: 400000000,
>>>>>                volt: 900000, enabled: 1
>>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>>>                666000000, volt: 900000, enabled: 1. New: freq: 666000000,
>>>>>                volt: 900000, enabled: 1
>>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>>>                800000000, volt: 900000, enabled: 1. New: freq: 800000000,
>>>>>                volt: 900000, enabled: 1
>>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>>>                928000000, volt: 900000, enabled: 1. New: freq: 928000000,
>>>>>                volt: 900000, enabled: 1
>>>>>
>>>>> This patch fixes the error path in the probe function and adds a .remove
>>>>> function to properly cleanup the opp table on unloading.
>>>>>
>>>>> Fixes: 5a893e31a636c (PM / devfreq: rockchip: add devfreq driver for rk3399 dmc)
>>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>>> ---
>>>>>
>>>>>  drivers/devfreq/rk3399_dmc.c | 31 +++++++++++++++++++++++++++----
>>>>>  1 file changed, 27 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>>>>> index d5c03e5abe13..e795ad2b3f6b 100644
>>>>> --- a/drivers/devfreq/rk3399_dmc.c
>>>>> +++ b/drivers/devfreq/rk3399_dmc.c
>>>>> @@ -375,8 +375,10 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>>>>>         data->rate = clk_get_rate(data->dmc_clk);
>>>>>
>>>>>         opp = devfreq_recommended_opp(dev, &data->rate, 0);
>>>>> -       if (IS_ERR(opp))
>>>>> -               return PTR_ERR(opp);
>>>>> +       if (IS_ERR(opp)) {
>>>>> +               ret = PTR_ERR(opp);
>>>>> +               goto err_free_opp;
>>>>> +       }
>>>>>
>>>>>         data->rate = dev_pm_opp_get_freq(opp);
>>>>>         data->volt = dev_pm_opp_get_voltage(opp);
>>>>> @@ -388,13 +390,33 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>>>>>                                            &rk3399_devfreq_dmc_profile,
>>>>>                                            DEVFREQ_GOV_SIMPLE_ONDEMAND,
>>>>>                                            &data->ondemand_data);
>>>>> -       if (IS_ERR(data->devfreq))
>>>>> -               return PTR_ERR(data->devfreq);
>>>>> +       if (IS_ERR(data->devfreq)) {
>>>>> +               ret = PTR_ERR(data->devfreq);
>>>>> +               goto err_free_opp;
>>>>> +       }
>>>>> +
>>>>>         devm_devfreq_register_opp_notifier(dev, data->devfreq);
>>>>>
>>>>>         data->dev = dev;
>>>>>         platform_set_drvdata(pdev, data);
>>>>>
>>>>> +       return 0;
>>>>
>>>> It looks strange. Because rk3399_dmcfreq_probe() already include
>>>> 'return 0' when success.
>>>> What is the base commit of this patch?
>>>>
>>>
>>> Sorry, I am not sure I understand your question, If I am not answering
>>> below could you rephrase?
>>
>> When I check the rk3399_dmcfreq_probe()[1], as I commented,
>> rk3399_dmcfreq_probe() already 'return 0' after platform_set_drvdata().
>> You can check it on link[1].
>> [1] https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/devfreq/rk3399_dmc.c#L443
>>
>> But, this patch add new '+       return 0;' line again in rk3399_dmcfreq_probe().
>> So, just I asked what is base commit of this patch.
>>
> 
> I think that this is just how git did the diff and if you only look at the diff
> is a bit confusing, if you apply the patch on top of mainline you will see that
> there is only one return 0 in the probe function.

Anyway, when I applied it to git, there is no problem. 
Just I have never seen such a case and asked a question.
Don't care about this anymore. Thanks.

> 
> +       return 0; (this new return ...)
> +
> +err_free_opp:
> +       dev_pm_opp_of_remove_table(&pdev->dev);
> +       return ret;
> +}
> +
> +static int rk3399_dmcfreq_remove(struct platform_device *pdev)
> +{
> +       struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(&pdev->dev);
> +
> +       /*
> +        * Before remove the opp table we need to unregister the opp notifier.
> +        */
> +       devm_devfreq_unregister_opp_notifier(dmcfreq->dev, dmcfreq->devfreq);
> +       dev_pm_opp_of_remove_table(dmcfreq->dev);
> +
>         return 0; (was this before the patch, but now is in another function)
> 
> Cheers,
>  Enric
> 
>>>
>>> So, once the opp table is added we need an error path to free it if an
>>> error occurs later. When the probe returns 0, we need to free the opp
>>> table when we remove the module.
>>>
>>>> [snip]
>>>>
>>>> Anyway, if probe fail, device driver have to remove registered OPP table.
>>>> Looks good to me.
>>>>
>>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>
>>>
>>> Thanks,
>>>  Enric
>>>
>>>> --
>>>> Best Regards,
>>>> Chanwoo Choi
>>>> Samsung Electronics
>>>
>>>
>>>
>>
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
