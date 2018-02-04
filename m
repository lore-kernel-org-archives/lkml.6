Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeBDX2c (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 18:28:32 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:27264 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeBDX2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 18:28:23 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180204232820epoutp013969e68e8245164b1e9c02a85b127565~QQyUTW7J31795717957epoutp01b
X-AuditID: b6c32a37-433ff70000001029-56-5a7797145a93
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A779715.7000709@samsung.com>
Date: Mon, 05 Feb 2018 08:28:21 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: int3496: process id-pin first so that we start
 with the right status
In-reply-to: <9060e517-c67b-b04a-ba40-bc9e17bf2b4e@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7bCmnq7I9PIogzOT1C3eHJ/OZHF51xw2
        i9uNK9gcmD3e77vK5tG3ZRWjx+dNcgHMUak2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2StGGhkZ6
        hgbmekZGRnomxrFWRqZAJQmpGYd/XmAr+CxQ8eDTXKYGxn28XYycHBICJhLLnv9k62Lk4hAS
        2MEoceX8ahYI5zujxJk/59lhqmZeXARVtZtRYvm2U4wgCV4BQYkfk+8BdXBwMAvISxy5lA0S
        ZhbQlHjxZRLUoHuMEr8fLWODqNeS2P97ASuIzSKgKnFwykqwOBtI/MUNMJtfQFHi6o/HYPNF
        BSIkds7/BnaEiECQxI3vK1ghFihI/Lq3CcwWFkiW6Hu+DqyXU8BOovHQZmaQxRICc9gkFt5/
        xwbxgYvEkyWnWSBsYYlXx7ewgxwtISAtcemoLUR9O6NE+955UM1TGCXOXb/HBNFgLPFsYRcT
        xGY+iXdfe1ghmnklOtqEIEwPiQtdChDVjhLb1jSywj1/+0UD0wRGuVlI4TULEV6zkMJrASPz
        Kkax1ILi3PTUYsMCY73ixNzi0rx0veT83E2M4KSlZb6DccM5n0OMAhyMSjy8ExLLo4RYE8uK
        K3MPMUpwMCuJ8M6YVBYlxJuSWFmVWpQfX1Sak1p8iNEUGNwTmaVEk/OBCTWvJN7QxNLAxMwI
        mLwsDQ2VxHkDAlyihATSE0tSs1NTC1KLYPqYODilGhg7o380/Q9RTJHyVTSLf/NjxoI3Jbas
        TUyL/LbFnGec/pbhr9FhSXmPPydcf69o8f3Mzrzo5K6lM3Z/3MPbONln1RXh/1cluvTkD/Ge
        Y8lYsTHe9LZAsPL3qIy4jIaVInOSjtgr2YQ9iym2f3Its/ZN+XKFVudjKyOmnpL8Pf3qZb+i
        9uunIvcrsRRnJBpqMRcVJwIAABrti3ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsVy+t9jAV3h6eVRBn+uKlu8OT6dyeLyrjls
        FrcbV7A5MHu833eVzaNvyypGj8+b5AKYo7hsUlJzMstSi/TtErgyDv+8wFbwWaDiwae5TA2M
        +3i7GDk5JARMJGZeXMTWxcjFISSwk1Fi5v63LCAJXgFBiR+T7wHZHBzMAvISRy5lQ5jqElOm
        5EKUP2CUaGp5wQRRriWx//cCVhCbRUBV4uCUlWwgNhtI/MUNMJtfQFHi6o/HjCBzRAUiJLpP
        VIKERQQCJH6e6mcHsZkFFCR+3dsENkZYIFmi7/k6NrhdO2ZfBktwCthJNB7azDyBUWAWkktn
        IVw6C+HSBYzMqxglUwuKc9Nzi40KDPNSy/WKE3OLS/PS9ZLzczcxAkN122Gtvh2M95fEH2IU
        4GBU4uGdkFgeJcSaWFZcmXuIUYKDWUmEd8aksigh3pTEyqrUovz4otKc1OJDjNIcLErivLfz
        jkUKCaQnlqRmp6YWpBbBZJk4OKUaGFde7IzKVFj6UdRAPGzqokWnP6w4ZvMqKN9oa9jtranR
        f/cuLPnc+lUo9zfnxUVePprVb3y+lXXa107k8Npkbmj17saseNPnXRfOZBddSd62VnbZ5WcZ
        ToKzdvSXPnqw6lEKq94UYfaFic5lE++Xdew6Vzn/6MOzhxdWfb5yz+pGRtP8WGEjqVVKLMUZ
        iYZazEXFiQCr+9b9UQIAAA==
X-CMS-MailID: 20180204232819epcas1p376ad2dd9466d1decb779387054218c12
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180125193924epcas1p2d31c10f1552df00e572fe66ff9768591
X-RootMTR: 20180125193924epcas1p2d31c10f1552df00e572fe66ff9768591
References: <CGME20180125193924epcas1p2d31c10f1552df00e572fe66ff9768591@epcas1p2.samsung.com>
        <20180125193919.1084-1-hdegoede@redhat.com> <5A73B1A5.5000907@samsung.com>
        <9060e517-c67b-b04a-ba40-bc9e17bf2b4e@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 02월 02일 17:10, Hans de Goede wrote:
> Hi,
> 
> On 02-02-18 01:32, Chanwoo Choi wrote:
>> On 2018년 01월 26일 04:39, Hans de Goede wrote:
>>> Some other drivers may be waiting for our extcon to show-up (exiting their
>>> probe methods with -EPROBE_DEFER until we show up).
>>>
>>> These drivers will typically get the cable state directly after getting
>>> the extcon, this commit changes the int3496 code to process the id-pin
>>> before registering the extcon, so that other drivers see the correct state
>>> right away.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>   drivers/extcon/extcon-intel-int3496.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
>>> index c8691b5a9cb0..b23ee9d993a3 100644
>>> --- a/drivers/extcon/extcon-intel-int3496.c
>>> +++ b/drivers/extcon/extcon-intel-int3496.c
>>> @@ -131,6 +131,10 @@ static int int3496_probe(struct platform_device *pdev)
>>>       if (IS_ERR(data->gpio_usb_mux))
>>>           dev_info(dev, "can't request USB MUX GPIO\n");
>>>   +    /* process id-pin first so that we start with the right status */
>>> +    queue_delayed_work(system_wq, &data->work, 0);
>>> +    flush_delayed_work(&data->work);
>>> +
>>>       /* register extcon device */
>>>       data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
>>>       if (IS_ERR(data->edev))
>>> @@ -153,9 +157,6 @@ static int int3496_probe(struct platform_device *pdev)
>>>           return ret;
>>>       }
>>>   -    /* queue initial processing of id-pin */
>>> -    queue_delayed_work(system_wq, &data->work, 0);
>>> -
>>>       platform_set_drvdata(pdev, data);
>>>         return 0;
>>>
>>
>> Looks good to me.
>> How about adding the 'Fixes' commit id on patch description?
> 
> Right, this could use a:
> 
> Fixes: 2f556bdb9f2e ("extcon: int3496: Add Intel INT3496 ACPI device extcon driver")
>

Please resend this patch Because you need to send the Linux stable mailing list.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
