Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2B5C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5967820855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="czijT5IC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5967820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeGCK5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:57:32 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:43730 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeGCK52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:57:28 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180703105726epoutp016732e95671bc26ff4fcc1177a5bbb5ea~91qOI1rJy2787727877epoutp01P
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 10:57:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180703105726epoutp016732e95671bc26ff4fcc1177a5bbb5ea~91qOI1rJy2787727877epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530615446;
        bh=WiJqUAFl3oSAToOO83sxfI+jbK7Q2QaqeSGmpl7Y/9g=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=czijT5ICMwauRv7tkyycJOgkEonJMFu4gzNMO33vDt8MCXSG1neK5HOu9NDB4rB7N
         CjONEmhzSxNzMkLgrccOyobtOHzFrsfFDr3jXRHeGGxIAUvRG0Vt1UtqZlATZv8yzy
         5TyeyBnUF4P45OlBPshvItwQhZwShbpW3rlp9lWo=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180703105723epcas1p26fa4bb2a2322ac1fd48acd6ac0739329~91qL0vUWq2279622796epcas1p2r;
        Tue,  3 Jul 2018 10:57:23 +0000 (GMT)
X-AuditID: b6c32a35-ba1ff70000000fe2-e6-5b3b569306b7
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.D7.04066.3965B3B5; Tue,  3 Jul 2018 19:57:23 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kernel@collabora.com" <kernel@collabora.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180621220430.25644-1-enric.balletbo@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180703105723epcms1p63bd7b3cf49722b204d7ca0dfd98d5d15@epcms1p6>
Date:   Tue, 03 Jul 2018 19:57:23 +0900
X-CMS-MailID: 20180703105723epcms1p63bd7b3cf49722b204d7ca0dfd98d5d15
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA12Se0hTURzHObt7XK3JaWoeVuS8YeRim3drdiuNKImFBUYQ1Yp1mZdN2ovd
        TbSIZmGaVFhKxeydEGWhZlsjyWANGZTmsxKprCxRXAr2IExqT4r+Oh++5/v7fc/vx8ExUSVf
        jJdaHIzdQpsIfjLX+zRHLqvftV6be6xNSk34c6hXX8d51N0RP6Dae07xqO5jUwJq4NElPjV7
        OgA2CjS+N01Ac+bBHaCZvb+sGNvL5BsZuoSxSxiL3lpSajEUEEU7dZt16rxcUkaupdYQEgtt
        ZgqIwm3Fsi2lpnA2ISmjTc6wVEyzLKHYkG+3Oh2MxGhlHQWEliSVcjJ3jVypDJ+q/euU6rDl
        AGOcH28X2Hr55e2/lrhAC68WJOEIrkbBwBC3FiTjIugDqL57LnyB40K4CM37UiOYCvXoR/++
        iF0ECeQa7sQinAoVqGbUCyLMhzLkaX3DjXAaPIRmPk5FW2LwMUBB92ssliVEF6s/cWO8BD28
        5YkWJ8FNqLrmW9yTjoabQ4IET3ddBTFOQ1Vvu+OeRWj0Z0dcF6Ox0PW4/yh6NXuDEwlGsA6g
        ude/4xcK9GGwkR+bazsaazwckbkwG3nnT8T7FKKfk++jO8FgJnoYuoRF7BjMQS2PFInnu9rm
        BP8zBlPQl2+neAndd2WME+MVyN/RFPcvRc8uXI8/X4MaAxOcOpDl/rto9z/B7r/B1wB2Byxm
        bKzZwLCkjZSztJl1WgxyvdV8H0S/n1TtAw092/wA4oBYKCzPXKcV8egytsLsBwjHiDShNzss
        CUvoikOM3aqzO00M6wfq8PxnMXG63hr+zBaHjlQrVSoVtZrMU5MkkSEsH4ZaETTQDuYgw9gY
        e6KOgyeJXUDSkzLhNnqet4TOBRWKxu+3NaKTDfc4tf0nKgdGlstqVq1sW9C0supa10zGHlFI
        CpKzgi8rL9/YMdJvHB864mkt7u1Tvkgnpqsluz0ZgWxHYNPnIkX9jD0lq14F8xz02sl8Td/g
        1hrRAy8YUo++67zp9tfuaz5+1Py9Knj+CYfgskaalGJ2lv4DzuiZlJQDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180621220442epcas2p14960cff4b08825aceb9d0e7ff810aeae
References: <20180621220430.25644-1-enric.balletbo@collabora.com>
        <CGME20180621220442epcas2p14960cff4b08825aceb9d0e7ff810aeae@epcms1p6>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>@@ -988,12 +1030,13 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
> 	if (ret != 1)
> 		return -EINVAL;
> 
>-	mutex_lock(&devfreq_list_lock);
>-	governor = find_devfreq_governor(str_governor);
>+	governor = try_then_request_governor(str_governor);
> 	if (IS_ERR(governor)) {
>-		ret = PTR_ERR(governor);
>-		goto out;
>+		return PTR_ERR(governor);
> 	}
>+
>+	mutex_lock(&devfreq_list_lock);
>+
> 	if (df->governor == governor) {
> 		ret = 0;
> 		goto out;
>-- 

The possibility that the result of try_then_request_governor is
not kept protected until the line of
"if (df->governor == governor)" is itching.

Can you make it kept "locked" from the return of
find_devfreq_governor() (either in try_then... or in this function)
to the unlock of governor_store()?


Cheers,
MyungJoo
