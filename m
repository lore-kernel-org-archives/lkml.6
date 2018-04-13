Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbeDMBNG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 21:13:06 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:58046 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeDMBNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 21:13:04 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180413011302epoutp03c8da9f6ccead028e5313d894d63b9575~k2b240cDa0774707747epoutp03W
X-AuditID: b6c32a45-6ebff70000000fe4-94-5ad0041ec6eb
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AD0041D.2050506@samsung.com>
Date: Fri, 13 Apr 2018 10:13:01 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: use put_device() instead of kfree()
In-reply-to: <5AD001C5.2040406@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7bCmma4cy4Uog7/LxSyu9S5ktjjb9Ibd
        4vKuOWwWn3uPMFrcblzB5sDqsXPWXXaPvi2rGD0+b5ILYI5KtclITUxJLVJIzUvOT8nMS7dV
        8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWqmkUJaYUwoUCkgsLlbSt7Mpyi8tSVXI
        yC8usVWKNjQ00jM0MNczMjLSMzGOtTIyBSpJSM2YNbmVrWAPT0XL162MDYxNXF2MnBwSAiYS
        d7Y/Zu1i5OIQEtjBKHG/7z8jhPOdUWLx9E9AGQ6wqvVH5SHiGxglXp45ygLSzSsgKPFj8j0W
        kBpmAXmJI5eyQcLMApoSL75MYoGov8so0d6ymgmkhldAS+LLNPEuRnYOFgFVifYUkGo2oOD+
        FzfYQGx+AUWJqz8eM4LYogIREjvnf2MHaRQRSJZom6UJMdxKYtejPrASYQE3iR93e8FaOQW0
        Jfov72GE+GoDm8SENYIQtovE3d+7oeLCEq+Ob2GHsKUlnq3aCPashEA70JF75zFDOFMYJc5d
        v8cEUWUs8WxhFxPEZj6JjsN/2SEhwivR0SYEUeIh8WzeHWYI21GiYe1CdojPrzBK3Lm2h3UC
        o9wspMCahQisWUiBtYCReRWjWGpBcW56arFRgaFecWJucWleul5yfu4mRnAC03LdwTjjnM8h
        RgEORiUe3orq81FCrIllxZW5hxglOJiVRHinPwYK8aYkVlalFuXHF5XmpBYfYjQFBvZEZinR
        5Hxgcs0riTc0sTQwMTMzMjezACYucd4G3zNRQgLpiSWp2ampBalFMH1MHJxSDYzbzh9abxWw
        /57szc8rFErK/RY1NLT90O97IKIvyvPg5Pq0OA32eVEdrPN3Vv3ZeJ9dqO061524180d7AfK
        e4Wv9z1c9W9ayuUHL+85icmfL1q7SyQ3a+bTlY9a+x0+qz17X73rnsg/e73/Ibr1c23DlN8k
        L/67w/v9cuODOV+P3Vow/X1M/zRPJZbijERDLeai4kQAWUaLH3YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t9jQV1ZlgtRBud26Vhc613IbHG26Q27
        xeVdc9gsPvceYbS43biCzYHVY+esu+wefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlTFrcitb
        wR6eipavWxkbGJu4uhg5OCQETCTWH5XvYuTiEBJYxygx/8svxi5GTg5eAUGJH5PvsYDUMAvI
        Sxy5lA1hqktMmZILUX6fUeLr28nMIHFeAS2JL9PEuxjZOVgEVCXaU0BmsAEF97+4wQZi8wso
        Slz98ZgRpFhUIEKi+0QlSFhEIFliyvZudhCbWcBKYtejPrD1wgJuEj/u9rJBLLrGKDH75ikm
        kASngLZE/+U9jBMYBWYhOXMWwpmzEM5cwMi8ilEytaA4Nz232KjAKC+1XK84Mbe4NC9dLzk/
        dxMjMGy3Hdbq38H4eEn8IUYBDkYlHl6FyvNRQqyJZcWVuYcYJTiYlUR4pz8GCvGmJFZWpRbl
        xxeV5qQWH2KU5mBREuflzz8WKSSQnliSmp2aWpBaBJNl4uCUamDkdaperXBy0mPP1zcyfLsX
        XEn5Ouvsxj8XepdnzX1Uayty/3CgueT3pZO+RqbmNOrfPDlfXmG3/8IbIsv/neA3vv9p+cEV
        +nmH3X0bVrA7S67ofZ+kldf/x2jqyqLXKQI7Fh6ZO2uGesIEY21lxkq7PV9mmWva/j9TOeNc
        mfOMqXJz6natk1NzVmIpzkg01GIuKk4EAJ/kRldXAgAA
X-CMS-MailID: 20180413011301epcas2p1bce5cd878c247970bf3b7b6096d239de
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be
X-RootMTR: 20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be
References: <CGME20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be@epcas5p1.samsung.com>
        <d8d8708d2283349c2c4f3e9f3c9fd5f47126d2bc.1522410143.git.arvind.yadav.cs@gmail.com>
        <5AD001C5.2040406@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 04월 13일 10:03, Chanwoo Choi wrote:
> Hi,
> 
> I'm sorry for the late reply.
> 
> On 2018년 03월 30일 20:44, Arvind Yadav wrote:
>> Never directly free @dev after calling device_register() or
>> device_unregister(), even if device_register() returned an error.
>> Always use put_device() to give up the reference initialized.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>  drivers/devfreq/devfreq.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index fe2af6a..a225b94 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -625,7 +625,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	err = device_register(&devfreq->dev);
>>  	if (err) {
>>  		mutex_unlock(&devfreq->lock);
>> -		goto err_dev;
>> +		put_device(&devfreq->dev);
>> +		goto err_out;
> 
> why do you change the goto postion?
> err_out is correct to free the memory of devfreq instance.

Sorry. err_dev is correct instead of err_out.

> 
>>  	}
>>  
>>  	devfreq->trans_table =	devm_kzalloc(&devfreq->dev,
>> @@ -671,6 +672,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	mutex_unlock(&devfreq_list_lock);
>>  
>>  	device_unregister(&devfreq->dev);
>> +	devfreq = NULL;
> 
> It is wrong. If you initialize the devfreq as NULL,
> never free the 'devfreq' instance.
> 
>>  err_dev:
>>  	if (devfreq)
>>  		kfree(devfreq);
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
