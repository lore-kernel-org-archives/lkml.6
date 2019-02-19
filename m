Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D37C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CBF2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HjKnRwFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbfBSA21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:28:27 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:31874 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732177AbfBSA20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:28:26 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190219002824epoutp01e964626a44aa6e17d30fc05a653a9c84~EnF82NJjk2266522665epoutp01S
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 00:28:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190219002824epoutp01e964626a44aa6e17d30fc05a653a9c84~EnF82NJjk2266522665epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550536104;
        bh=l+jRIOnhBy1n7I7NtMxw0HLfsC2SBtfejVAtrW5T3GY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HjKnRwFkNWSqisN2QFgaXji/TPvpXttK0NEONlwmPvGHemeNhUecsySlWY1gfklNW
         NorE+79aoISWe5GzzuZAJb49nFId83pzYh23ClhRqG38HIUBqMJUK3PelUSg1/roJA
         ZovgtA6DVS10F25iGUodDKMWpVp7bM1t+w6nhOgg=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190219002821epcas1p27839f95f508e4b84d8c47d363d720009~EnF6GgeJR0573305733epcas1p29;
        Tue, 19 Feb 2019 00:28:21 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.8D.04069.5AD4B6C5; Tue, 19 Feb 2019 09:28:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190219002821epcas1p14486ed9c4a1fbb892ff03601fa109437~EnF5u5AgJ1685516855epcas1p11;
        Tue, 19 Feb 2019 00:28:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190219002821epsmtrp1a2bfd5b2b034f7e468f030377f00f1b3~EnF5tp2Be1032510325epsmtrp1N;
        Tue, 19 Feb 2019 00:28:21 +0000 (GMT)
X-AuditID: b6c32a37-989ff70000000fe5-c0-5c6b4da5a8b7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.15.03971.4AD4B6C5; Tue, 19 Feb 2019 09:28:20 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190219002820epsmtip20a66b7f1508ba1b2253bbdd4a8d282e8~EnF5dyhbC3134931349epsmtip2V;
        Tue, 19 Feb 2019 00:28:20 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] drivers: devfreq: add tracing for scheduling
 work
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, mka@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2bc86822-9861-66d5-0a7e-d3d45494772c@samsung.com>
Date:   Tue, 19 Feb 2019 09:28:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550514069-9237-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmvu5S3+wYg9fvJSw2zljPanG26Q27
        xa0GGYvLu+awWXzuPcJosfbIXXaLSwcWMFl83vCY0eJ24wo2i30dD5gsDr9pZ3Xg9pjdcJHF
        o2XfLXaPg+/2MHm833eVzaNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403N
        DAx1DS0tzJUU8hJzU22VXHwCdN0yc4DOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUW
        pOQUWBboFSfmFpfmpesl5+daGRoYGJkCFSZkZ+w5toSx4C1Hxdqpp9gaGGexdzFyckgImEis
        fbyWtYuRi0NIYAejxN7Fc5kgnE+MEu8Wv4JyvjFK3Lg9jQ2m5cyjw4wQib2MEkvnLYNy3jNK
        3GyfxQhSJSzgL3Hw8FewDhGBNIm37XfBRjELHGCUeLRyBdh2NgEtif0vboAV8QsoSlz98Ris
        mVfATmJ+2w/mLkYODhYBVYlZP91AwqICERKHe99BlQhKnJz5hAXE5hTwknjc84QJxGYWEJe4
        9WQ+lC0v0bx1NjPIXgmBfnaJtSdfMUK84CKx+cAkZghbWOLV8S3Q0JCSeNnfBmVXS6w8eYQN
        ormDUWLL/gusEAljif1LJzOBHMcsoCmxfpc+xDI+iXdfe1hBwhICvBIdbUIQ1coSlx/cZYKw
        JSUWt3dCQ9FD4vrpJ4wTGBVnIXlnFpIXZiF5YRbCsgWMLKsYxVILinPTU4sNC4yRo3sTIzjt
        apnvYNxwzucQowAHoxIP74LlWTFCrIllxZW5hxglOJiVRHgXeWbHCPGmJFZWpRblxxeV5qQW
        H2I0BQb2RGYp0eR8YE7IK4k3NDUyNja2MDE0MzU0VBLnXe/gHCMkkJ5YkpqdmlqQWgTTx8TB
        KdXAKMcm93LZ1LUXQw743v2S+sakfWlg4pLH3LZFDmlXOXY2FnKseXasKXLrF+utB7b4xH8J
        OjqB9cYnt8qFyvMSVyzfdzM7iOdl0WMvpTr/a30qWmcT+NgiNqfOmDb5Y+rBdSou70umKopM
        uvNo6vR76QKblxjJlEluiPIIWnj8x4X9mvz1VvO3sCqxFGckGmoxFxUnAgBvognd0QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvO4S3+wYg993bSw2zljPanG26Q27
        xa0GGYvLu+awWXzuPcJosfbIXXaLSwcWMFl83vCY0eJ24wo2i30dD5gsDr9pZ3Xg9pjdcJHF
        o2XfLXaPg+/2MHm833eVzaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgy9hxbwljwlqNi7dRT
        bA2Ms9i7GDk5JARMJM48OszYxcjFISSwm1Gi8eNZZoiEpMS0i0eBbA4gW1ji8OFiiJq3jBIb
        1i1hB4kLC/hK/PhfA1IuIpAmcajhNthMZoEDjBLNN30g6u8ySnz79JoNJMEmoCWx/8UNMJtf
        QFHi6o/HjCA2r4CdxPy2H2C7WARUJWb9dAMJiwpESHx8uo8JokRQ4uTMJywgNqeAl8TjnidM
        ELvUJf7Mu8QMYYtL3HoyHyouL9G8dTbzBEbhWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sN
        CwzzUsv1ihNzi0vz0vWS83M3MYJjT0tzB+PlJfGHGAU4GJV4eBcsz4oRYk0sK67MPcQowcGs
        JMK7yDM7Rog3JbGyKrUoP76oNCe1+BCjNAeLkjjv07xjkUIC6YklqdmpqQWpRTBZJg5OqQbG
        2VG9PyMWZvrPemZysuRaMycbj07pi1kqvhtned1be0ih7n3Qn3zhz16X2t91n8u4tLVo4ZP2
        P8p8aZM+nxA/u/c1t+eLaqZZC7sD910pt/BULJe9PzWjSHeBJHtlFmutksv9nG+ck2+t6dCd
        l7jY5SbLtL6QL1OMuo7rtp7yCvjCzHS2JnWJEktxRqKhFnNRcSIApKYYHrkCAAA=
X-CMS-MailID: 20190219002821epcas1p14486ed9c4a1fbb892ff03601fa109437
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190218182129eucas1p1804530445570fc73af89ed46b9a448b9
References: <1550514069-9237-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190218182129eucas1p1804530445570fc73af89ed46b9a448b9@eucas1p1.samsung.com>
        <1550514069-9237-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 2. 19. 오전 3:21, Lukasz Luba wrote:
> This patch add basic tracing of the devfreq workqueue and delayed work.
> It aims to capture changes of the polling intervals and device state.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de7..660365a 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -29,6 +29,9 @@
>  #include <linux/of.h>
>  #include "governor.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/devfreq.h>
> +
>  static struct class *devfreq_class;
>  
>  /*
> @@ -394,6 +397,8 @@ static void devfreq_monitor(struct work_struct *work)
>  	queue_delayed_work(devfreq_wq, &devfreq->work,
>  				msecs_to_jiffies(devfreq->profile->polling_ms));
>  	mutex_unlock(&devfreq->lock);
> +
> +	trace_devfreq_monitor(devfreq);
>  }
>  
>  /**
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
