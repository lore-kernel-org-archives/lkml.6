Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76747C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191992064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hjuHNu9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191992064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJHSBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:01:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55896 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeJHSBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:01:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008105024euoutp0104f004c9cab5838e733baae31f414a1c~bnIxbevD-1892118921euoutp01N
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 10:50:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008105024euoutp0104f004c9cab5838e733baae31f414a1c~bnIxbevD-1892118921euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538995824;
        bh=S9CqCYVrjA8jBJ1nZ7y9g4sdfaZBx0Wh3OSuKwxwORw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hjuHNu9vD5eL/nucPTbYI9q7kziSD2tYQb3rqYFg/aSm4yzXtsPC2tNFSZElUfdJs
         Ig9QwBi3MjDWKxiFXTlTd8GmQ+K1M0deVqF++XR2bCPPSxuJuodyvpKjWedoGLn0DU
         TbyOlj0yuT9uvrcshmiq1ym3ue5Yy4VSN9IWAsDE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008105023eucas1p20bf711f9d0bd1573fd2927ee4ff4ff21~bnIw0mwp31725217252eucas1p26;
        Mon,  8 Oct 2018 10:50:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 51.DF.04441.F663BBB5; Mon,  8
        Oct 2018 11:50:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181008105022eucas1p1b747f75b0dbe07f781e5cfee83829773~bnIwD11nn2266022660eucas1p1o;
        Mon,  8 Oct 2018 10:50:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181008105022eusmtrp2233474beb5f42e221429b848d3b6fb79~bnIvy1_RO1727517275eusmtrp2W;
        Mon,  8 Oct 2018 10:50:22 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-4d-5bbb366f70f9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0F.27.04128.E663BBB5; Mon,  8
        Oct 2018 11:50:22 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181008105022eusmtip2ecd98666753c34c8731a2ff7ab824363~bnIvdgVLG2539325393eusmtip2c;
        Mon,  8 Oct 2018 10:50:22 +0000 (GMT)
Subject: Re: [PATCH v4] video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup
 table
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     linux-fbdev@lists.infradead.org, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 8 Oct 2018 12:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181003130326.10283-1-jmkrzyszt@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd18s93RBi8Oi1lc+fqezeLKtlnM
        Fg+/72CzuLxrDpvF7CX9LA6sHjtn3WX3uN99nMlj85J6j8+b5AJYorhsUlJzMstSi/TtErgy
        dj1fzFrQxl5xddYltgbGe6xdjBwcEgImEgu6M7oYuTiEBFYwSrR2HmCEcL4wSnRt/8gK4Xxm
        lDj/dgp7FyMnWMeX941QieWMEuv7LzBBOO8ZJTbe72AFqRIWCJGY+GonE4gtIqAj8XJPO1gR
        s0ADo0Tbnl5mkASbgJXExPZVjCCHsAioSHzodwExRQUiJPrPqINU8AoISpyc+YQFJMwpYCnR
        cMcYJMwsYCBxZNEcVghbXmL72znMINMlBPrZJfpvzWWE6C2T2HOgiwniTReJWTM9Ie4Xlnh1
        fAvULzIS/3fOZ4Lonc4o8ebXUhYIZz2jxJozx5ggqqwlDh+/yAphO0r8uHoKaiifxI23ghBH
        8ElM2jadGSLMK9HRJgRRrSaxYdkGNphdXTtXMkPYHhJ9i/6wTWBUnIXky1lIXpuF5LUFjMyr
        GMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAlPJ6X/HP+1g/Hop6RCjAAejEg/vyoBd0UKs
        iWXFlbmHGCU4mJVEeEW3A4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzLpu3MVpIID2xJDU7NbUg
        tQgmy8TBKdXAKKk/XX9XQI+px8dudVapmuk/WWwvSggYuTaleXGf3LR5nuSyBq/8W77dS66/
        VPa/slXmF0NOxTbRu4p1D5JWzZmW+Vt/Vq/O7sISRRlvwf3O5l1r085FK7tlVYllzI2/Jbhe
        q9UwWeDVg5yn9Zv1Nxxnl9h/tejS3ZqENfZp73sPrzOe4a+nxFKckWioxVxUnAgA7FI+/yED
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xe7p5ZrujDf6/k7a48vU9m8WVbbOY
        LR5+38FmcXnXHDaL2Uv6WRxYPXbOusvucb/7OJPH5iX1Hp83yQWwROnZFOWXlqQqZOQXl9gq
        RRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl7Hq+mLWgjb3i6qxLbA2M91i7
        GDk5JARMJL68bwSzhQSWMkrcXxzexcgBFJeROL6+DKJEWOLPtS62LkYuoJK3jBLfZs1lBkkI
        C4RITHy1kwnEFhHQkXi5p50Jomg3o8SVCWeYQRxmgQZGiT0r+tlAqtgErCQmtq9iBLF5Bewk
        pvxpYQPZxiKgIvGh3wUkLCoQIXHrYQcLRImgxMmZT1hASjgFLCUa7hiDhJkF9CR2XP/FCmHL
        S2x/O4d5AqPgLCQds5CUzUJStoCReRWjSGppcW56brGRXnFibnFpXrpecn7uJkZghGw79nPL
        Dsaud8GHGAU4GJV4eFcE7IoWYk0sK67MPcQowcGsJMIruh0oxJuSWFmVWpQfX1Sak1p8iNEU
        6IWJzFKiyfnA6M0riTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPHxMEp1cCo
        sn2xoPqLo7VRD301NYRjv20NL1n5R873vnpOyrriqQ1bgpJuh39Q0HDJYLhRmdq5+/mJpLxA
        3/PLLm3Z9d/m30GVxqrI8sq5QtWbl77X4digolN47PnfO9+mvDD9vTPP9+vWgL5MmT+Kweuv
        T50mLrN/6bf1L34n7vi8UyC3M7v3fdLW7wy3lFiKMxINtZiLihMBD1Tmj6YCAAA=
Message-Id: <20181008105022eucas1p1b747f75b0dbe07f781e5cfee83829773~bnIwD11nn2266022660eucas1p1o@eucas1p1.samsung.com>
X-CMS-MailID: 20181008105022eucas1p1b747f75b0dbe07f781e5cfee83829773
X-Msg-Generator: CA
X-RootMTR: 20181003130232epcas2p4eba2a06d977e2f23014c2a5d5256630f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181003130232epcas2p4eba2a06d977e2f23014c2a5d5256630f
References: <20180909225605.16463-2-jmkrzyszt@gmail.com>
        <CGME20181003130232epcas2p4eba2a06d977e2f23014c2a5d5256630f@epcas2p4.samsung.com>
        <20181003130326.10283-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/03/2018 03:03 PM, Janusz Krzysztofik wrote:
> Now as Amstrad Delta board - the only user of this driver - provides
> GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
> use the table to locate required GPIO pins.
> 
> Declare static variables for storing GPIO descriptors and replace
> gpio_ function calls with their gpiod_ equivalents. Move GPIO lookup
> to the driver probe function so device initialization can be deferred
> instead of aborted if a GPIO pin is not yet available.
> 
> Pin naming used by the driver should be followed while respective GPIO
> lookup table is initialized by a board init code.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
