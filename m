Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6544DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293C92086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FfOWG/Bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfAROe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:34:26 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57017 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfAROeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:34:25 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190118143423euoutp01b613a3e793d2857b192744ffb49f57f8~69-c70qVV2812628126euoutp01V
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:34:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190118143423euoutp01b613a3e793d2857b192744ffb49f57f8~69-c70qVV2812628126euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547822063;
        bh=ufuwoIbKl1Zxgc5EsIyyv/AgH9b8Mu7sFow8Lo+Gq9A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FfOWG/BwnmXGo9jgwJQSYVck4Xh9bAfzUigpfi2DHoZlBkyNsNXVlhLp5vhaQMtnG
         Hzn2j6zInNz2aJQW3ea/Y+LnGMyqRQkFfrOPy91Zw9me4WyKwK1JbCkLebGTtaUOSH
         9QlX/OCEQhRXXEQHpBVdzw+LeCFrbvBYmsuzNRTo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190118143422eucas1p20562d2f7d8129e2d74907fd11393613e~69-b1x2ks0222302223eucas1p2h;
        Fri, 18 Jan 2019 14:34:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DC.E9.04806.DE3E14C5; Fri, 18
        Jan 2019 14:34:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190118143420eucas1p11495282b806a7ca85bdbafaec46ac3b4~69-awO-_m3080730807eucas1p1Q;
        Fri, 18 Jan 2019 14:34:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190118143420eusmtrp2085312f9013703813b4e5d470cd16879~69-auNGlc1571915719eusmtrp2-;
        Fri, 18 Jan 2019 14:34:20 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-7a-5c41e3ed609f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 39.79.04284.CE3E14C5; Fri, 18
        Jan 2019 14:34:20 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190118143420eusmtip1c2d65852a9c8f718e8d46eeb0340fe09~69-aAE6gl1082410824eusmtip1T;
        Fri, 18 Jan 2019 14:34:20 +0000 (GMT)
Subject: Re: [PATCH 1/6] include/drm: color_mgmt: Add enum labels
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Christoph Manszewski <c.manszewski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        'Hans Verkuil' <hans.verkuil@cisco.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b9cfbae1-b24e-96bf-f3b0-ff6d25cd16bb@samsung.com>
Date:   Fri, 18 Jan 2019 15:34:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117194722.GJ20097@intel.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGe3c/Xc2uU9uhomiQpJXLMnwhqQSJSxAoEUQJtfSikq7cUjMp
        yyKs9WFqpCv8zIplqPMjW6Wm4lJRsyRNCAWF0twszZWklre7yP9+zznnOe954GUJ5Ti1ko3V
        nRL0Om2cmpaTta0z3ZvtwyERW+aNvvh6V5sMV+aWU9j2vBTh3ukJGt+fscrwzeEvBO7urmBw
        Z/o4gy3D7yn8znqPxrnd9TL8pOUjg4dGGxD+mN2CcG72KI1/zBfJdnN8flkqn/OrkuIt5is0
        /9Q5RPH5beH8oNEm46vup/E26wDD36g2I37KsiZMfkgeHCXExSYJes3Oo/KY3sv7TmZxpy2j
        /cx5VKC4itxY4AIhPdPIXEVyVsk9QtBX9YGQxHcExrEuShJTCDovvEX/LH3NdpflIYKxhnKX
        sCO40pdJiVOeXAhc65/76/DikmH8npMQmeAekOC8GSkyzfnCXNUHWmQFtxMqSqYZkUluPeRN
        lpEie3MHIWPwsWvGA9ryRv7W3TgNNObccu1cCxdr7rpYBQMjBTLxIOBusTDkGF0wsAsiFG7b
        t0sJPGHMVs1IvBp+PxPnRU6D9LxeQvJmIHhd8pCWGjug2dZDiXuIhaPLrRqpHAIvW7sYab07
        9Ns9pBPcIav2DiGVFZBxWSlNr4PBzhpCYhWUvpmmM5HatCiYaVEY06Iwpv/vFiLSjFRCoiE+
        WjBs0wnJ/gZtvCFRF+0feSLeghb+YMe8bboO1c8ea0Ici9TLFJ9rd0coKW2SISW+CQFLqL0U
        8kchEUpFlDbljKA/cUSfGCcYmtAqllSrFKlLhg4ruWjtKeG4IJwU9P+6MtZt5Xm0aSJ66pVP
        o7Fol7n4mmOwtMD7rmM/WbjPoe7pSKpz4vam2U9cS0JPT8fMwKesAwHIHLBRXuQdaHoR1BqY
        4EdsJX0zNc2hvZOnVcEtazrScgIPLfcJKtaER12adLb6fKsMy/95LqogZ8/eKvfrS7+u2PHe
        rz51CV0mJK3a0H420ltNGmK0AX6E3qD9A15eyCh/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42I5/e/4Xd03jx1jDP7e0rLoPXeSyWLjjPWs
        Fsd3L2W0uPL1PZvFkp+7mCz6H79mtjh/fgO7xdmmN+wWmx5fY7W4vGsOm8WM8/uYLNYeuctu
        8eDlfkaLu5OPMFrMmPySzeL7v4VMDgIe89ZUe0z5vZHVY9OqTjaP7d8esHrMOxnocb/7OJPH
        5iX1Hsd33WL36NuyitHj8ya5AK4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsj
        UyV9O5uU1JzMstQifbsEvYwrbb4FkwQqNr28wd7AOJ+3i5GTQ0LAROL64bfsXYxcHEICSxkl
        fk77xwyREJfYPf8tlC0s8edaFxtE0WtGiUdH57CBJIQFHCV6bvxlBLFFBMoldm9vApvELLCK
        ReLGvjMsEB3/GCXe/FwD1sEmoCnxd/NNMJtXwE5iw+Kv7CA2i4CqxMxPa1hAbFGBCImzL9cx
        QtQISpyc+QQszimgL3FgykSwk5gF1CX+zLsEZctLNG+dDWWLS9x6Mp9pAqPQLCTts5C0zELS
        MgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiB0b/t2M/NOxgvbQw+xCjAwajEw/ti
        m0OMEGtiWXFl7iFGCQ5mJRFerhWOMUK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0xMeSXx
        hqaG5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGDs9njMd3zxtXsv/5ZEW
        uQGJNefLFZnyfixdpNKXYTvJUciCfYV1ToyAjYycs8/dBJ2/87t5t5RYfdD4vyjJ70cft5n7
        ZYW7Lg6K94QYDm9IumW4SGHmLI0XJ6TLBMJbt5b6Ox2pjXftmiQQ8fvlbSteXwuGYzcibonl
        X5aSc/NJPLXg6JbvSizFGYmGWsxFxYkAh3k2HRQDAAA=
X-CMS-MailID: 20190118143420eucas1p11495282b806a7ca85bdbafaec46ac3b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6
References: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6@eucas1p2.samsung.com>
        <1544789421-5265-2-git-send-email-c.manszewski@samsung.com>
        <20190117194722.GJ20097@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC: Hans

On 17.01.2019 20:47, Ville Syrjälä wrote:
> On Fri, Dec 14, 2018 at 01:10:16PM +0100, Christoph Manszewski wrote:
>> Range setting makes sense for YCbCr and RGB buffers. Current
>> drm_color_range enum labels suggest use with YCbCr buffers.
>> Create enum labels without colorspace specification.
>>
>> Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
>> ---
>>  include/drm/drm_color_mgmt.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
>> index 90ef9996d9a4..52f6d5221a0d 100644
>> --- a/include/drm/drm_color_mgmt.h
>> +++ b/include/drm/drm_color_mgmt.h
>> @@ -62,6 +62,8 @@ enum drm_color_range {
>>  	DRM_COLOR_YCBCR_LIMITED_RANGE,
>>  	DRM_COLOR_YCBCR_FULL_RANGE,
>>  	DRM_COLOR_RANGE_MAX,
>> +	DRM_COLOR_LIMITED_RANGE = DRM_COLOR_YCBCR_LIMITED_RANGE,
>> +	DRM_COLOR_FULL_RANGE = DRM_COLOR_YCBCR_FULL_RANGE,
> These enum values don't mean anything really. The strings are what
> matter for the uapi.
>
> The default for YCbCr needs to be limited range, the default for RGB
> needs to be full range. So I think this would really require a separate
> prop for each.
>
> But is there an actual usecase for this stuff?


Yes, for example HDMI path (Display Controller and HDMI encoder) in
Exynos5433 works on RGB buffers and do not perform any conversion if the
output is also RGB, on the other side CEA861 specs says that in case of
CEA modes output RGB should be in limited range, in case of non CEA
modes it should be full range.

The idea was to allow userspace to check (atomic_check) which ranges are
acceptable in given mode and to set desired one if possible.

Any better solution is welcome?


Regards

Andrzej



>
>>  };
>>  
>>  int drm_plane_create_color_properties(struct drm_plane *plane,
>> -- 
>> 2.7.4
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel


