Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 139BDC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B996C208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k4aaXpGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B996C208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755537AbeFOAw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:52:28 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:44751 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753485AbeFOAwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:52:25 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180615005223epoutp031287a91ab3128b492557e4b469a95b5b~4LyzwWvjm2001320013epoutp03b;
        Fri, 15 Jun 2018 00:52:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180615005223epoutp031287a91ab3128b492557e4b469a95b5b~4LyzwWvjm2001320013epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529023943;
        bh=CrLOYoyR+Fzw5i+4E3qnHn7DcyJvRSrX90nd8CNqC20=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=k4aaXpGu6Jejcc83MkMm8PDEGEsM4Twt4HVNobDdqoGylbBQZzXXtMGdFwS3tuXXW
         iYSxAcrIymd3PJzOxZNcizyCcDP5olSJpDj8SjkEER76zbbrRjk1Z3VnvKK98H0BiX
         gB8drsye2ejwxdsf72gnA65c9FiJsCQax+PpWtXE=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180615005220epcas1p3f113eadeecf1252313eb4e53e43b450a~4LywimFgB2131921319epcas1p3B;
        Fri, 15 Jun 2018 00:52:20 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.69.04068.1CD032B5; Fri, 15 Jun 2018 09:52:17 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180615005217epcas1p1cd4b4263c886653644da34e664e381d5~4LyuZrwbZ0341203412epcas1p1B;
        Fri, 15 Jun 2018 00:52:17 +0000 (GMT)
X-AuditID: b6c32a36-bd1ff70000000fe4-92-5b230dc10b89
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id C8.B2.03915.1CD032B5; Fri, 15 Jun
        2018 09:52:17 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PAC0014JAF5MM80@mmp2.samsung.com>; Fri, 15 Jun 2018 09:52:17 +0900 (KST)
Message-id: <5B230DC0.3050000@samsung.com>
Date:   Fri, 15 Jun 2018 09:52:16 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Roger Quadros <rogerq@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        stable <stable@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Giaccone <tony@giaccone.org>
Subject: Re: [PATCH] extcon: Release locking when sending the notification
 of connector state
In-reply-to: <764C1A35-7D06-48AD-8809-0F6BB3526A23@goldelico.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmnu5BXuVogx/3rS0m3rjCYvFj21cm
        iwtPe9gsLu+aw2Zxu3EFm0XPIy2LBRsfMVrcOv6W0YHD49j8E0wea96fYvbYtKqTzaNvyypG
        j+M3tjN5fN4kF8AWlWqTkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
        4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKdrQ0EjP0MBcz8gISBvHWhmZ
        ApUkpGb8Wr6EuaBVpOLFs82sDYy7BboYOTkkBEwkGjbcZO9i5OIQEtjBKNF6u4EJwvnOKHH2
        2HdGmKo3v1uhqjYwSsye08EOkuAVEJT4MfkeSxcjBwezgLzEkUvZIGFmAU2JF18msUDU32WU
        OPqvnQ2iXkvi6Ya9rCD1LAKqEtNvi4CE2YDC+1/cACvhF1CUuPrjMdheUYEIiZ3zv7GDlIsI
        +Es0PCgGGckscIdR4svXOWA1wgLxEg0f1oH1cgo4SrQdW84IUiQhcJtN4uzbI2wQD7hIfLz+
        hAnCFpZ4dXwL2FAJAWmJS0dtIerbgYa+aGaFcCYwSnw4tRmqwVji2cIuJojP+CTefe1hhWjm
        lehoE4Io8ZD4OOMm1MMrmCQO/7/KOoFRdhZSGM1ChNEspDBawMi8ilEstaA4Nz212LDASK84
        Mbe4NC9dLzk/dxMjONVpme1gXHTO5xCjAAejEg+vQYFStBBrYllxZe4hRgkOZiUR3t4SoBBv
        SmJlVWpRfnxRaU5q8SFGU2AQT2SWEk3OB6bhvJJ4Q1MjY2NjCxNDM1NDQyVx3oqbAtFCAumJ
        JanZqakFqUUwfUwcnFINjEHbPziLHOFcKfdtU48fR/XN3Zlrbd6ue3DBZIt4lc/O0jP3duTe
        7t7eaXE8Yt7eH9FG9/0zjqo965J9fv8+79rGTMmLs45Okgko23dR/Wd54E0D49S3aQwHc097
        b5p/KupInFvx/w2TvXfZXr9dd3/elBtpL2c/Mqq5seZAjYjaSwbBGEf+eWVKLMUZiYZazEXF
        iQDXyzEeiwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t9jQd2DvMrRBj+W6FhMvHGFxeLHtq9M
        Fhee9rBZXN41h83iduMKNoueR1oWCzY+YrS4dfwtowOHx7H5J5g81rw/xeyxaVUnm0ffllWM
        HsdvbGfy+LxJLoAtissmJTUnsyy1SN8ugSvj1/IlzAWtIhUvnm1mbWDcLdDFyMkhIWAi8eZ3
        K3sXIxeHkMA6RolFW7exgyR4BQQlfky+x9LFyMHBLCAvceRSNoSpLjFlSi5E+X1Giak99xkh
        yrUknm7YywpSwyKgKjH9tghImA0ovP/FDTYQm19AUeLqj8eMICWiAhES3ScqQcIiAr4SP1/t
        YgYZySxwi1Fi/r8JrCAJYYF4iak7t7BB7FrFJLH2Tg/YIE4BR4m2Y8sZJzAKzEJy6SyES2ch
        XLqAkXkVo2RqQXFuem6xUYFhXmq5XnFibnFpXrpecn7uJkZg4G87rNW3g/H+kvhDjAIcjEo8
        vAYFStFCrIllxZW5hxglOJiVRHh7S4BCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW/nHYsUEkhP
        LEnNTk0tSC2CyTJxcEo1MOp5W7+q/r+S8fNZZf1Vfe+XhVtarCmXy50ksVz0fF9MUP4H4eja
        EzNuffX0E/g7LfL6LUHZl5KCHGavBaJm6AWvcF+VkK7tfsBCm8Xg/ZO25FKnvAWzNFYv26Cq
        2vrx4ldnUcNFrJvOe3X9bnx47HYZq/GptxybRCdnr1vTfmvOSpHJmoYhT5RYijMSDbWYi4oT
        AScfG/J4AgAA
X-CMS-MailID: 20180615005217epcas1p1cd4b4263c886653644da34e664e381d5
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180614041448epcas2p400dad902581dc6875461d4c3dd3a231d
References: <CGME20180614041448epcas2p400dad902581dc6875461d4c3dd3a231d@epcas2p4.samsung.com>
        <1528949687-32002-1-git-send-email-cw00.choi@samsung.com>
        <5B22410C.9080002@samsung.com>
        <9AEF5153-4234-4C30-984A-8A3D51D04623@goldelico.com>
        <764C1A35-7D06-48AD-8809-0F6BB3526A23@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

If possible, Could you please review this patch? 

Regards,
Chanwoo Choi

On 2018년 06월 14일 20:33, H. Nikolaus Schaller wrote:
> 
>> Am 14.06.2018 um 12:39 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
>>
>> Hi Roger and Chanwoo,
>>
>>> Am 14.06.2018 um 12:18 schrieb Chanwoo Choi <cw00.choi@samsung.com>:
>>>
>>> + H. Nikolaus Schaller <hns@goldelico.com>
>>>
>>> On 2018년 06월 14일 13:14, Chanwoo Choi wrote:
>>>> Previously, extcon used the spinlock before calling the notifier_call_chain
>>>> to prevent the scheduled out of task and to prevent the notification delay.
>>>> When spinlock is locked for sending the notification, deadlock issue
>>>> occured on the side of extcon consumer device. To fix this issue,
>>>> extcon consumer device should always use the work. it is always not
>>>> reasonable to use work.
>>>>
>>>> To fix this issue on extcon consumer device, release locking when sending
>>>> the notification of connector state.
>>>>
>>>> Fixes: ab11af049f88 ("extcon: Add the synchronization extcon APIs to support the notification")
>>>> Cc: stable@vger.kernel.org
>>>> Cc: Roger Quadros <rogerq@ti.com>
>>>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>> drivers/extcon/extcon.c | 3 ++-
>>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
>>>> index 8bff5fd18185..f75b08a45d4e 100644
>>>> --- a/drivers/extcon/extcon.c
>>>> +++ b/drivers/extcon/extcon.c
>>>> @@ -433,8 +433,8 @@ int extcon_sync(struct extcon_dev *edev, unsigned int id)
>>>> 		return index;
>>>>
>>>> 	spin_lock_irqsave(&edev->lock, flags);
>>>> -
>>>> 	state = !!(edev->state & BIT(index));
>>>> +	spin_unlock_irqrestore(&edev->lock, flags);
>>>>
>>>> 	/*
>>>> 	 * Call functions in a raw notifier chain for the specific one
>>>> @@ -448,6 +448,7 @@ int extcon_sync(struct extcon_dev *edev, unsigned int id)
>>>> 	 */
>>>> 	raw_notifier_call_chain(&edev->nh_all, state, edev);
>>>>
>>>> +	spin_lock_irqsave(&edev->lock, flags);
>>>> 	/* This could be in interrupt handler */
>>>> 	prop_buf = (char *)get_zeroed_page(GFP_ATOMIC);
>>>> 	if (!prop_buf) {
>>>>
>>
>> I have tested on the Pyra handheld prototype and now it works. Plugging in an OTG cable
>> enables/disables OTG power as expected and there are no kernel oops any more.
> 
> I did take some minutes to check and it now also works again on the OMAP5EVM.
> 
> BR,
> Nikolaus
> 
> 

