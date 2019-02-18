Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDC4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD48217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="naGD/9Qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbfBRLEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:04:53 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:18874 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfBRLEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:04:51 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190218110447epoutp037f4ed96021d8194f345ae470c216b1a0~EcITpvP9n0656906569epoutp03F;
        Mon, 18 Feb 2019 11:04:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190218110447epoutp037f4ed96021d8194f345ae470c216b1a0~EcITpvP9n0656906569epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550487887;
        bh=y+TjUa0geiKsmNniajN4tyv6+rYIitTLV7otTeuaBS8=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=naGD/9QbTef7TIqQlVli8c7zR1oV0Zo8tahi0Toa5UUOuowyayBB2VmRPKeh9kxO5
         if3TSbkeveNHiAvY2+DSGJTfLMqGlbDWPwQkzlIhTnEW44VwU0E/vydbMzHLDfTBVE
         Kj1MUeHJ6o2wStD2kDyjLbwi3NLms89DhtqWjoNQ=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190218110447epcas1p1ef4770b00250d7300b898a2423127e66~EcITU7e3K2822228222epcas1p1e;
        Mon, 18 Feb 2019 11:04:47 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.70.04069.F419A6C5; Mon, 18 Feb 2019 20:04:47 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190218110447epcas1p3bb248ada6447551c1ca19f2d6af40bc4~EcITBEQFR1571615716epcas1p3E;
        Mon, 18 Feb 2019 11:04:47 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-58-5c6a914ff4ff
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id DF.14.04015.E419A6C5; Mon, 18 Feb
        2019 20:04:47 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PN40065RC3QW5B0@mmp2.samsung.com>; Mon, 18 Feb 2019 20:04:46 +0900 (KST)
Subject: Re: [PATCH -next] ASoC: samsung: i2s: Fix return value check in
 i2s_create_secondary_device()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <282ae8b4-f86f-2254-0956-3cc3b4915bbf@samsung.com>
Date:   Mon, 18 Feb 2019 12:04:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <20190216012055.79622-1-weiyongjun1@huawei.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7bCmvq7/xKwYgwvP5CyuXDzEZDH14RM2
        i623pC3On9/AbvHtSgeTxeVdc9gsOnf1s1pcXPGFyWLD97WMFoe/7GJz4PLY8LmJzWPnrLvs
        Hi1H3rJ6bFrVyeax7+0yNo++LasYPdZvucri8XmTXABHFJdNSmpOZllqkb5dAlfGpN03GQv6
        WSq+XPrC3sC4g7mLkZNDQsBEYu2KGWwgtpDADkaJF/+zuhi5gOzvjBLH599hgym6/3EyE0Ri
        A6PEhI5dLBDOfUaJD4enMIJUCQtkSKx8uY8JxBYR0JDYcvkOI0gRs8AOJokHR76wgyTYBAwl
        eo/2gTXwCthJbPzXzQpiswioSuz/+w4sLioQIXG49x1UjaDEj8n3WEBsTgEbiUdbesFsZgFN
        iRdfJkHZ4hLH7t9khLDlJTavecsMslhC4D+bxN/HN4F+4AByXCSenOGCMKUlLh21hfisWmLX
        9m6o8g5GiZYL26HhYi1x+PhFVoiZfBLvvvawQvTySnS0CUGYHhL7d3hAwqGfUeLTmyaWCYwy
        s5BcPQvJpbOQXDoLyaULGFlWMYqlFhTnpqcWGxYY6xUn5haX5qXrJefnbmIEJxct8x2MG875
        HGIU4GBU4uH9UJYZI8SaWFZcmXuIUYKDWUmENyg2K0aINyWxsiq1KD++qDQntfgQozQHi5I4
        73oH5xghgfTEktTs1NSC1CKYLBMHp1QDI9vaBq/2vzbvfh6/8OsSU0XaJT+tT4+ll6vN6V9n
        cFj6jFaF6NNkdjXnC/PMex/859thzJFkxfm9qvJylVfE9ZTe2Vpv7v9u23V9f45z0pFA9wtv
        Mzmi1djjjauu77o7Z7XE0SkFvS+f+qRfC+g4m3f++FRHaeG6jHUuvdXHJHoYHhiHeDPsUWIp
        zkg01GIuKk4EALQaq6EqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e+xoK7/xKwYgx0zWSyuXDzEZDH14RM2
        i623pC3On9/AbvHtSgeTxeVdc9gsOnf1s1pcXPGFyWLD97WMFoe/7GJz4PLY8LmJzWPnrLvs
        Hi1H3rJ6bFrVyeax7+0yNo++LasYPdZvucri8XmTXABHFJdNSmpOZllqkb5dAlfGpN03GQv6
        WSq+XPrC3sC4g7mLkZNDQsBE4v7HyUxdjFwcQgLrGCXOTF3DCuE8ZJT4drWFEaRKWCBDYuXL
        fUwgtoiAhsSWy3cYQYqYBXYwSSy5sgSogwOow1ri30Z7kBo2AUOJ3qN9YL28AnYSG/91s4LY
        LAKqEvv/vgOLiwpESHx8CjGTV0BQ4sfkeywgNqeAjcSjLb0sICOZBdQlpkzJBQkzC4hLHLt/
        kxHClpfYvOYt8wRGgVlIumchdMxC0jELSccCRpZVjJKpBcW56bnFRgWGeanlesWJucWleel6
        yfm5mxiB0bPtsFbfDsb7S+IPMQpwMCrx8H4oy4wRYk0sK67MPcQowcGsJMIbFJsVI8SbklhZ
        lVqUH19UmpNafIhRmoNFSZz3dt6xSCGB9MSS1OzU1ILUIpgsEwenVAPjVAbFpvzlJ/8sDfkw
        e5mfkrfhWpkXvr2aD47rXPrVcHwz22n1pW5z/k7imHvq2FR7r0LRHhYxs9nVB/rXlYg87D4s
        kRcitlHBv3x9zsJTe9T/ppdzMv5nzVosJMfg+zojSzxBL1VtbpySJ+OyVjaHh5N420v29Vma
        Nvw5GBz8Lcn99lXFG8FKLMUZiYZazEXFiQABiKe1mgIAAA==
X-CMS-MailID: 20190218110447epcas1p3bb248ada6447551c1ca19f2d6af40bc4
CMS-TYPE: 101P
X-CMS-RootMailID: 20190218110447epcas1p3bb248ada6447551c1ca19f2d6af40bc4
References: <20190216012055.79622-1-weiyongjun1@huawei.com>
        <CGME20190218110447epcas1p3bb248ada6447551c1ca19f2d6af40bc4@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/19 02:20, Wei Yongjun wrote:
> In case of error, the function platform_device_register_simple() returns
> ERR_PTR() and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().

Thanks for the patch, it looks good but I have already prepared other
fix that removes the platform_device_register_simple() call entirely: 

"ASoC: samsung: i2s: Fix multiple "IIS multi" devices initialization"
https://www.spinics.net/lists/kernel/msg3045092.html

-- 
Thanks,
Sylwester
