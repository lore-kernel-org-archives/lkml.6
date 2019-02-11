Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236F0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FFB206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SZcrI9XB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfBKJw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:52:57 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50261 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfBKJw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:52:57 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190211095255euoutp0155bbb5b6f9e41ad45edf1fa0c312014c~CRojq7B0K1209112091euoutp01P
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 09:52:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190211095255euoutp0155bbb5b6f9e41ad45edf1fa0c312014c~CRojq7B0K1209112091euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549878775;
        bh=gGKTWIFW6gmd+g2PUqeisnfCq8kZe7vjl30PpbUsu/s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SZcrI9XBnMgnJgKBvzOOXSKnF6z1lhQwZ8sCQVPKhG9S2ifYNELpcfrjVd/5iXi9Q
         iBg6ItQaRe40+HTTaXYBDBOVRq+xmlbk7WKpJu8zLdbRTBA0B03w6vVUDZpBe+0cGK
         dQ0eaRiymnGrXBdTRC5SfkLtezHPqGbM0NwfkgzQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190211095255eucas1p124026c329c0cb5f3d6d081f3c44efced~CRojIzySD2591525915eucas1p1b;
        Mon, 11 Feb 2019 09:52:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DA.E4.04441.6F5416C5; Mon, 11
        Feb 2019 09:52:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190211095254eucas1p2ee8031cdc81d143c5700480c982d301f~CRoiYijlM0113501135eucas1p2F;
        Mon, 11 Feb 2019 09:52:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190211095254eusmtrp2cdc7da2d8b6d405eec3905f702d512b7~CRoiJ7g4D1512615126eusmtrp2o;
        Mon, 11 Feb 2019 09:52:54 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-ec-5c6145f67fba
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 51.A6.04284.5F5416C5; Mon, 11
        Feb 2019 09:52:53 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190211095253eusmtip16e1e49443e0f2932636306ce4f73e084~CRohmSpdO2549225492eusmtip1A;
        Mon, 11 Feb 2019 09:52:53 +0000 (GMT)
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>, Sudeep.Holla@arm.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9b4a6c9a-93f9-474f-b8c0-4353a531e128@samsung.com>
Date:   Mon, 11 Feb 2019 10:52:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211084413.b53qyx6sgkxsjhdv@vireshk-i7>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtt3u3XVeTn8vYh0XBICGxx0jo2kOyFG5kLwyKHOW1blNTk00t
        i6KQUoeZlOUcZlJBOs3amG5lRU5x6rTHwrkyolICJWlllhZZXq+Z/53vnPM9DnwUoegSh1Ap
        GVmcLoNNU0lkZGPb+NPl32NZzaruUTVtMd4V069GC8T0ywcVEnrkQiuijc8ei+hPY90iusvt
        EdMTXgtJ3+50kLRllKFr2k3ExrlMXWUdYqzmQgnzxvtQwth68kmm2GZGTEfnAMm4fHYRM2Jd
        vJPaJ1t/iEtLyeF0K6MSZcmuy4VE5k3q+NUnv8gzyCcxoAAKcASUN1UTBiSjFLgaQY/l3HTx
        DcG7gS9SoRhB8NPXPtNifFwsEoTbk4KxH/GCAn9GMNQbw+P5OBY+5nVNdlNUMA6DwVcc7ydw
        nwhseX4R75FgNRiGDVND5TgKfjh8Uh6TeCkMn5+Y4hdgDZQ+bZUKniDoKB8g+ZkBOBLe3gnh
        aQIvAftwBSFgJbweuD51G+BBKfRN8H7+6Bh4NNYrFfB8GHLZpvEi+HP/X0MegnyjSSoURQga
        KhzTkddBi+uFmN9M4GVw98FKgY6GzpYaCU8DDgTfcJBwRCBcaiwjBFoOBecVgjsUTK76mbXN
        zz1ECVKZZiUzzYpjmhXH9H9vFSLNSMll69O1nF6dwR1boWfT9dkZ2hUHj6Zb0eSPuSdcXx1o
        1JPkRJhCqnlyP5uoUYjZHH1uuhMBRaiC5btjWI1CfojNPcHpjh7QZadxeidaSJEqpfzknHcJ
        Cqxls7gjHJfJ6f6pIiog5AzK6kv13/Ou2bPm973IoL2bDdurU+xnNftr++MbtITT+nDtqlv2
        a7bm8pHeA2XhB+N/my3JfS+vrFfGZfoH7Rffp34QVzX5/KWhG64WFOw+5kna5j3sjtya0Nym
        UpZ8P9Ww5dTqyqFaty+iyKW5EV2fsNEw7g0titu0qz3qtDm8p3qHitQns+owQqdn/wLfWtA1
        XwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xu7pfXRNjDCZetbHYOGM9q8XNrx2s
        Fpd3zWGz+Nx7hNFixvl9TBZvfpxlsjhz+hKrxb9rG1kslp/awWKx8auHxcoTs5gduD3WzFvD
        6LFpVSebx51re9g8tlxtZ/Ho27KK0ePkqScsHsdvbGfy+LxJLoAjSs+mKL+0JFUhI7+4xFYp
        2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j+ORO5oLFHBXTDvxmaWC8wdbF
        yMkhIWAiMWNfH1MXIxeHkMBSRolDF5qZIRIyEienNbBC2MISf651sUEUvWWUuDFnE1i3sICr
        xLPmM+xdjBwcIgJaEi9vpoLUMAvcZZJYPn0aM0TDAUaJL5OvsYM0sAkYSnS97QJr5hWwk/i+
        4wZYnEVAVeJt2z82kEGiAjESV88xQpQISpyc+YQFJMwpYClxb60USJhZQF3iz7xLzBC2vMT2
        t3OgbHGJW0/mM01gFJqFpHsWkpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cT
        IzButx37uXkH46WNwYcYBTgYlXh4PyQmxAixJpYVV+YeYpTgYFYS4Q1xSYwR4k1JrKxKLcqP
        LyrNSS0+xGgK9NpEZinR5HxgSskriTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBa
        BNPHxMEp1cC4wLjswIYbMY9eLCmuXNtp+eCHVcCyt+3O5lPLnq63mbEtsWl+yvRm6W/vZnJc
        zvwUcaa/6aDrRbmw/RGu/40SDnh8Ero3nfveUw1OjuqSRW/eZAhlVjLwz9qc/Ft5w5+l+8Se
        BQkvNNpgVn/jbtG68HKTEJ91y+TYDkXXzfPOsFhoenz2kW8RSizFGYmGWsxFxYkABXPdXPEC
        AAA=
X-CMS-MailID: 20190211095254eucas1p2ee8031cdc81d143c5700480c982d301f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
        <20190207122227.19873-1-m.szyprowski@samsung.com>
        <20190211084413.b53qyx6sgkxsjhdv@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 2019-02-11 09:44, Viresh Kumar wrote:
> On 07-02-19, 13:22, Marek Szyprowski wrote:
>> Dear All,
>>
>> Recent commit 9ac6cb5fbb17 ("i2c: add suspended flag and accessors for
>> i2c adapters") added a visible warning for an attempt to do i2c transfer
>> over a suspended i2c bus. This revealed a long standing issue in the
>> cpufreq-dt driver, which gives a following warning during system
>> suspend/resume cycle:
> Marek,
>
> I have sent a patchset which is not directly related to the problem
> you are facing, but it may solve your problem as a side effect. Can
> you please see if that works to solve this issue as well ?
>
> https://lore.kernel.org/lkml/cover.1549874368.git.viresh.kumar@linaro.org/T/#u

Thanks for the patch. It indeed solves the problem of the i2c transfer
in cpu hotplug procedure during system resume, although my resources
management rewrite is still valid as a way to fix remaining 'todos' in
the cpufreq-dt driver.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

