Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5400DC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F250821700
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VaLL3dWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F250821700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbeHCChJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:37:09 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:55535 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbeHCChI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:37:08 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180803004326epoutp0350fa9a600c57c2f74454e2ab41755ade~HOR-RjCfh1779817798epoutp033;
        Fri,  3 Aug 2018 00:43:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180803004326epoutp0350fa9a600c57c2f74454e2ab41755ade~HOR-RjCfh1779817798epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533257007;
        bh=C8y6OUU5rEaYzDDpnfe/rBjOekEXS0XVQUDvCbGkSQk=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=VaLL3dWUosb0oDBe2i1jHLLhVFfF70YaMdfowGzv5LRrmsR71igcLAQo4ia6CwpBy
         ms48uNfOBs/aw3dGObqlUr1Qr387Q+zlZI5qEKVHVzdD38O/RscqdLkMN0isAQ7C3I
         x28PPYEOgo4KBurcfCVtOeHWDF23yDV0JGjapS78=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.158]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180803004324epcas1p4ffda2e66cee17f32c8f356f4c523533c~HOR81CWi91335713357epcas1p4s;
        Fri,  3 Aug 2018 00:43:24 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.30.04412.C25A36B5; Fri,  3 Aug 2018 09:43:24 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20180803004323epcas2p30e6a2ce60ccd34e3c1b744117b81fde4~HOR8c5Oca0914209142epcas2p3c;
        Fri,  3 Aug 2018 00:43:23 +0000 (GMT)
X-AuditID: b6c32a47-289ff7000000113c-66-5b63a52c461a
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 65.13.03824.B25A36B5; Fri,  3 Aug
        2018 09:43:23 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCV007QA0OBD370@mmp2.samsung.com>; Fri, 03 Aug 2018 09:43:23 +0900 (KST)
Message-id: <5B63A52B.8010706@samsung.com>
Date:   Fri, 03 Aug 2018 09:43:23 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 03/12] PM / devfreq: Don't adjust to user limits in
 governors
In-reply-to: <20180803002452.GV68975@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmua7O0uRog5bDQhZ/Jx1jt5j+5DKL
        xaaP71kt5h85x2pxdtlBNos1tw8xWjQvXs9mcbbpDbvF/a9HGS0u75rDZvG59wijxdLrF5ks
        Pm94zGhxu3EFm8Wp65/ZLM6cvsRq0br3CLvFxq8eDkIea+atYfT4/WsSo8fshossHjvuLmH0
        2LSqk83jzrU9bB77565h97hyoonVY8vVdhaPvi2rGD0+b5IL4I5KtclITUxJLVJIzUvOT8nM
        S7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBek1JoSwxpxQoFJBYXKykb2dTlF9a
        kqqQkV9cYqsUbWhopGdoYK5nZASkjWOtjEyBShJSM5pPX2AueCZYsXbDHcYGxi6+LkZODgkB
        E4mHi58ydTFycQgJ7GCUOPznHJTznVHi9qx7rDBVB+58ZYRIbGCUmH6onQUkwSsgKPFj8j0g
        m4ODWUBe4silbJAws4CmxIsvk1gg6u8yStz8sIsVol5L4uDda+wgNouAqsTB6VuZQWw2oPj+
        FzfYQGx+AUWJqz8eM4LYogIREjvnfwOrFxHQkHjy+zzYEcwC01gluqf9B2sQFgiTuLL3OpjN
        KWAg8fztamaQIgmBU+wSq2cfBLtOQsBFovkuG8Q3whKvjm9hh7ClJZ6t2sgIUd/OKPHlRTMr
        hDOBUeLDqc1MEFXGEs8WdjFB/MYn0XH4LzvEUF6JjjYhiBIPiW+/v7NDvLyISeLmw8+sExhl
        ZyGF0ixEKM1CCqUFjMyrGMVSC4pz01OLjQqM9YoTc4tL89L1kvNzNzGCk7CW+w7Gbed8DjEK
        cDAq8fBeUE2OFmJNLCuuzD3EKMHBrCTC+7YTKMSbklhZlVqUH19UmpNafIjRFBjIE5mlRJPz
        gRkiryTe0NTI2NjYwtTc0tjAUkmct8ovOFpIID2xJDU7NbUgtQimj4mDU6qB8aDvqzU5Njwv
        FZi6brOqxL1MaJXTuKUgdDej57Omtke8jNF59QvcrKGWgsufahQfU+fyrb6t8OZWxqmjkatW
        pTlOmPDp7reba1eebjm9kfe6e3yuI4vW8+9G2rpJXtKm85qik1imK6eafNVs4L5zuStA+PKT
        6Z4MffGBL3hsWpWEUt3873xUYinOSDTUYi4qTgQAuC51ktgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t9jQV3tpcnRBjeWGFv8nXSM3WL6k8ss
        Fps+vme1mH/kHKvF2WUH2SzW3D7EaNG8eD2bxdmmN+wW978eZbS4vGsOm8Xn3iOMFkuvX2Sy
        +LzhMaPF7cYVbBanrn9mszhz+hKrReveI+wWG796OAh5rJm3htHj969JjB6zGy6yeOy4u4TR
        Y9OqTjaPO9f2sHnsn7uG3ePKiSZWjy1X21k8+rasYvT4vEkugDuKyyYlNSezLLVI3y6BK6P5
        9AXmgmeCFWs33GFsYOzi62Lk5JAQMJE4cOcrYxcjF4eQwDpGiQ+HlrKAJHgFBCV+TL4HZHNw
        MAvISxy5lA1hqktMmZILUX6fUaLhTwc7RLmWxMG718BsFgFViYPTtzKD2GxA8f0vbrCB2PwC
        ihJXfzxmBJkjKhAh0X2iEiQsIqAh8eT3eUYQm1lgBqvExgsxILawQJjElb3X2SB2LWKSePV6
        DxNIglPAQOL529XMExgFZiG5dBbCpbMQLl3AyLyKUTK1oDg3PbfYqMAoL7Vcrzgxt7g0L10v
        OT93EyMwHrcd1urfwfh4SfwhRgEORiUe3guqydFCrIllxZW5hxglOJiVRHjfdgKFeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MBqW9R2dn6q585rDS+/k
        KPdu/cD/jzp3MPBvubL93/7ilcfrXnF2PL66gl3luqkNt3exj1zMjZ+eSvc2Gv/7GcaU/EQ2
        NWKH38U3U5Yuj592VjCsfKclU5Bm+cdH75Iskk4s+/TeYcNxdlNXe9GpO2oc6y6sM7a+biZ7
        QvFP01Km+5ffKE8+uF+JpTgj0VCLuag4EQBd2VddwwIAAA==
X-CMS-MailID: 20180803004323epcas2p30e6a2ce60ccd34e3c1b744117b81fde4
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180802233605epcas2p2fc6b1cef0dc773f6c7e59017721917bc
References: <20180703234705.227473-1-mka@chromium.org>
        <20180703234705.227473-4-mka@chromium.org>
        <CGME20180802233605epcas2p2fc6b1cef0dc773f6c7e59017721917bc@epcas2p2.samsung.com>
        <20180802233600.GT68975@google.com> <5B639BD2.5050008@samsung.com>
        <20180803002452.GV68975@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 08월 03일 09:24, Matthias Kaehlcke wrote:
> On Fri, Aug 03, 2018 at 09:03:30AM +0900, Chanwoo Choi wrote:
>> Hi Matthias,
>>
>> On 2018년 08월 03일 08:36, Matthias Kaehlcke wrote:
>>> Hi Chanwoo,
>>>
>>> this patch and "PM / devfreq: Fix handling of min/max_freq == 0"
>>> address issues not directly related with the throttler. It seems it
>>> could still take a while for the throttler to move forward, do you
>>> want me to spin out these two patches so that they can get merged
>>> independently from the rest of the series?
>>
>> How about resend the devfreq patches(patch1/2/3/4/6) which don't depend on
>> throttler core with my reviewed tag? Maybe, it is easy to merge them through Myungjoo.
> 
> Sure, I can do this if you think it is reasonable to merge all these
> patches without the throttler.

IMO, patch1/2/3/6 looks good. I replied with my reviewed-tag for them.

patch4 defines the 'struct devfreq_policy' and then patch5
send notification with 'struct devfreq_policy' on original patch.
But, when we discussed it on patch5, new devfreq notification
send 'struct devfreq_freq_limits' better than 'struct devfreq_policy'.
So, patch4 would be required with more discussion. If myungjoo agree
the current patch4, I'm okay.

> 
> These are the patches we are talking about and my interpretation of
> their status:
> 
> [01] PM / devfreq: Init user limits from OPP limits, not viceversa
>   landed in Rafaels tree
> 
> [02] PM / devfreq: Fix handling of min/max_freq == 0
>   independent fix, can land
> 
> [03] PM / devfreq: Don't adjust to user limits in governors
>   independent improvement, can land
> 
> [04] PM / devfreq: Add struct devfreq_policy
>   edge case, can land if devfreq maintainers think that factoring out
>   some fields to the policy struct is an improvement independently of
>   the throttler
> 
> [05] PM / devfreq: Add support for policy notifiers
>   under heavy discussion ;-), can't land
> 
> [06] PM / devfreq: Make update_devfreq() public
>   has no user without the throttler, not sure if it should be merged
>   without it. up to devfreq maintainers.
> 
> Please let me know what you think

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
