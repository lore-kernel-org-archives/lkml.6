Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A43BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36162177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dxzhxSZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfBRLlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:41:18 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:29506 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbfBRLlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:41:18 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190218114115epoutp03590fd2b30df543e81223d8089def0434~EcoJTW7000436104361epoutp03x;
        Mon, 18 Feb 2019 11:41:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190218114115epoutp03590fd2b30df543e81223d8089def0434~EcoJTW7000436104361epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550490075;
        bh=yAaAmkhk5uFRoRLMh2WtIY0QGkdAat5WP7bQm9Sn+m4=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=dxzhxSZPtqHVNb7bPEVwTvUvdYD0+ZLkaauALP/NnCtRu2uqk8YNnjwYa7mdqC7Nr
         yJb7NpO8pcyFBO6jKetowZcWv3WOn8j43rZkl+bRvqiu9DDnGRwJ1+MRM5eNexnmPC
         uK1MVccFOBjKF3qbtjQPfDvKnKJRO6PBxDpnqB+s=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190218114115epcas2p3203cb75ea766cf3533a7b08d1a454724~EcoI4qSkd0373503735epcas2p3i;
        Mon, 18 Feb 2019 11:41:15 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.B2.04134.BD99A6C5; Mon, 18 Feb 2019 20:41:15 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190218114114epcas2p20068b24af925322184b30de79f427f18~EcoIYUGG72259322593epcas2p2B;
        Mon, 18 Feb 2019 11:41:14 +0000 (GMT)
X-AuditID: b6c32a47-8c3ff70000001026-3c-5c6a99db986a
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 51.53.03689.AD99A6C5; Mon, 18 Feb
        2019 20:41:14 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PN400IP0DSMFE30@mmp2.samsung.com>; Mon, 18 Feb 2019 20:41:14 +0900 (KST)
Subject: Re: [PATCH 1/2] ASoC: samsung: i2s: Fix the secondary platform
 device registration
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <36e84820-f75a-4dbb-e148-1aebad0d26ba@samsung.com>
Date:   Mon, 18 Feb 2019 12:41:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <CAJKOXPdViVjS9ZzbBy94+UPK6-DEbCdPx-vsAa-SvrntyNunAA@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7bCmme7tmVkxBut/C1lcuXiIyWLqwyds
        FufPb2C3+Halg8ni8q45bBZrj9xlt7i44guTA7vHhs9NbB47Z91l99i0qpPNo2/LKkaPz5vk
        AlijuGxSUnMyy1KL9O0SuDJ2rX7JWnCKs+L934+MDYy32LsYOTkkBEwkOr6tBLK5OIQEdjBK
        3DiwE8r5zijxtaGVEabqx+kprBCJDYwSW5ecg3LuM0pc3T4PbJawQKxEw7V3YLaIgKbE9b/f
        WUFsZoE1jBKNbzlAbDYBQ4neo31gU3kF7CSm3drODGKzCKhKzDl7HqxXVCBC4nDvO6gaQYkf
        k++xgNicAsESE09sYYOYqSnx4sskFghbXOLY/ZuMELa8xOY1b5khrr7MJtG9zLaLkQPIdpHY
        tMUVIiwt8WzVRqjHqiV2be9mBvlFQqCDUaLlwnaoXmuJw8cvQt3PJ9Fx+C87xBxeiY42IYgS
        D4lFDdtZIOFwjVFiytSLzBMYZWYhOXsWklNnITl1FpJTFzCyrGIUSy0ozk1PLTYqMNYrTswt
        Ls1L10vOz93ECE4SWu47GLed8znEKMDBqMTD+6EsM0aINbGsuDL3EKMEB7OSCG9QbFaMEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd6H0nOjhQTSE0tSs1NTC1KLYLJMHJxSDYzLpZYYVV3fwL3q
        c+qF3os38zse6xrMCWpM2cyisvae0nRDEfP/p1fk18u2up05eHeFdX5f35Qf4t8dzBgz3Nx7
        Xgis//p2Vv9bYRF/3cu2Zirh7jXbOjZrHIo9y5ewZN0u06bzy7+kCLz5FrPESSr4XGj+it7b
        j0sZ13lKLdnZr9QcHBm19YcSS3FGoqEWc1FxIgCkMNAeDgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsVy+t9jQd1bM7NiDP71aFlcuXiIyWLqwyds
        FufPb2C3+Halg8ni8q45bBZrj9xlt7i44guTA7vHhs9NbB47Z91l99i0qpPNo2/LKkaPz5vk
        AlijuGxSUnMyy1KL9O0SuDJ2rX7JWnCKs+L934+MDYy32LsYOTkkBEwkfpyewtrFyMUhJLCO
        UeLXi83sEM5DRol1+66DVQkLxEq8O3IWzBYR0JS4/vc7WAezwBpGiZ3bu1kgOm4wSjQcf8AG
        UsUmYCjRe7SPEcTmFbCTmHZrOzOIzSKgKjHn7HmwSaICERIfn+5jgqgRlPgx+R4LiM0pECxx
        fcFDoHoOoA3qElOm5IKEmQXEJY7dv8kIYctLbF7zlnkCo8AsJN2zEDpmIemYhaRjASPLKkbJ
        1ILi3PTcYqMCo7zUcr3ixNzi0rx0veT83E2MwDjYdlirfwfj4yXxhxgFOBiVeHg/lGXGCLEm
        lhVX5h5ilOBgVhLhDYrNihHiTUmsrEotyo8vKs1JLT7EKM3BoiTOy59/LFJIID2xJDU7NbUg
        tQgmy8TBKdXAOLtCy+e6ZfTByWcKT1WeTI5PcGMNm2Q9+dXyBYZTc9u/L9Dg40w0aPKQcXfR
        dOCep6d7V3vpmvKDRwN3T5zg9WqRiCbHzq+MW5pb4peeTnyrWy4xO+7omSlvzi7fkSShlBrS
        P+N/tb2uYGLMrKR6YYH2wwufX5e8u23DMo1vqf/iFx5un7bosRJLcUaioRZzUXEiAB/a/cV/
        AgAA
X-CMS-MailID: 20190218114114epcas2p20068b24af925322184b30de79f427f18
CMS-TYPE: 102P
X-CMS-RootMailID: 20190215144822epcas2p4a6187a4e4d45c7ac3ea067ac428b3678
References: <CGME20190215144822epcas2p4a6187a4e4d45c7ac3ea067ac428b3678@epcas2p4.samsung.com>
        <20190215144809.28007-1-s.nawrocki@samsung.com>
        <CAJKOXPdViVjS9ZzbBy94+UPK6-DEbCdPx-vsAa-SvrntyNunAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 09:31, Krzysztof Kozlowski wrote:
> On Fri, 15 Feb 2019 at 15:48, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:

>> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
>> index 6bf0f55d1e51..e36c44e2f1bb 100644
>> --- a/sound/soc/samsung/i2s.c
>> +++ b/sound/soc/samsung/i2s.c
>> @@ -1359,11 +1359,10 @@ static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
>>
>>  static void i2s_delete_secondary_device(struct samsung_i2s_priv *priv)
>>  {
>> -       if (priv->pdev_sec) {
>> -               platform_device_del(priv->pdev_sec);
>> -               priv->pdev_sec = NULL;
>> -       }
>> +       platform_device_unregister(priv->pdev_sec);
>> +       priv->pdev_sec = NULL;
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Although I think that you might need to re-order calls in
> samsung_i2s_remove(). In general they should be in exact reverse order
> of probe(). In this case, clk_disable_unprepare(priv->clk) should be
> after unregistering secondary device. If order has to be different
> because of some reasons - could you document them in comment?

Makes sense, I will change the order and resend both patches.

Thanks,
Sylwester
