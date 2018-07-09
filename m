Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21096C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CA32087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R5okUei2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CA32087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932858AbeGILR6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:17:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52640 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932638AbeGILR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:17:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180709111754euoutp01be269992049aaabe0c2cd17cb53f1a25~-rzz9NJIc1588315883euoutp01K
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 11:17:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180709111754euoutp01be269992049aaabe0c2cd17cb53f1a25~-rzz9NJIc1588315883euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531135074;
        bh=0IAq8Dz54plyNYwA5MiBHBzAPGU//JmBsb+n2HptJ8s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=R5okUei2Q/IeV+5El0cEXEWiVBl0R3BE6hHCDzfi1f6ElSQTKzlGDAOhiCelkjcvg
         dR/Ldz1tabv3qnq+u3R2uM/aon1VRGjTp9tjuoWSALtiqeRvNZLryCCY35lAbkmL3t
         qO7FU6Bk4WgoopLIP65EOx+4STRQnM4+kuqDa95U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180709111754eucas1p14f1641347a2370d36c17cb279687a2a2~-rzzQRULv3176131761eucas1p1Y;
        Mon,  9 Jul 2018 11:17:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 69.9F.05700.164434B5; Mon,  9
        Jul 2018 12:17:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180709111753eucas1p1f32e66fb2f7ea3216097cd72a132355d~-rzycA5Rg0378203782eucas1p1C;
        Mon,  9 Jul 2018 11:17:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180709111752eusmtrp16db6c54ddda9fce418669d7c4b591a54~-rzyNeu8P2291522915eusmtrp1P;
        Mon,  9 Jul 2018 11:17:52 +0000 (GMT)
X-AuditID: cbfec7f2-1c1ff70000011644-3b-5b434461ee86
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 56.CA.04178.064434B5; Mon,  9
        Jul 2018 12:17:52 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180709111752eusmtip2970bfd66be7950d11907c544933c2c9d~-rzxzo_2w0322003220eusmtip2T;
        Mon,  9 Jul 2018 11:17:52 +0000 (GMT)
Subject: Re: Applied "regulator: core: Link consumer with regulator driver"
 to the regulator tree
To:     Mark Brown <broonie@kernel.org>, pascal paillet <p.paillet@st.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 9 Jul 2018 13:17:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <E1fb8Ti-00026e-NU@debutante>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djPc7qJLs7RBotn6FhsnLGe1aLp0Ck2
        i6kPn7BZNC9ez2Zx/vwGdotvVzqYLC7vmsNm8e7MU3YHDo+ds+6ye2xa1cnmcefaHjaP/XPX
        sHv0bVnF6PH0x15mj8+b5ALYo7hsUlJzMstSi/TtErgytr37y17wRbvi9PktLA2Mb1W6GDk5
        JARMJI5PfsDSxcjFISSwglGi4eVhZgjnC6PEqpuNbBDOZ0aJlU9eMcK0zJh1igkisZxRYu2S
        iVBV7xkleqd3gVUJCyRLzDi0kw3EFhFwkzi5YBKYzSxwlkni60I5EJtNwFCi620XWJxFQEVi
        1e8+FhBbVCBGYt6iv2A2r4CgxMmZT8BsTgEtifcXe5gh5shLbH87B8oWl7j1ZD7YRRICx9gl
        9s9cxQ7RXCaxonEy1NkuEpdmdrFD2MISr45vgbJlJE5P7mGBaG5mlGifMYsdwulhlNg6Zwcb
        RJW1xOHjF1m7GDmA1mlKrN+lDxF2lPj48hAbSFhCgE/ixltBiIP4JCZtm84MEeaV6GgTgqhW
        k5h1fB3c2oMXLjFPYFSaheTNWUhem4XktVkIexcwsqxiFE8tLc5NTy02zEst1ytOzC0uzUvX
        S87P3cQITFKn/x3/tIPx66WkQ4wCHIxKPLwfCp2ihVgTy4orcw8xSnAwK4nwJloBhXhTEiur
        Uovy44tKc1KLDzFKc7AoifPGadRFCQmkJ5akZqemFqQWwWSZODilGhgZktuDvjcnWLcalgon
        tAsERRwIUUtX83NW91/MPXvSIXmxWTH2uuwKXyVyTV82e109fFfbkjXAvMRk1e03pikLVK/c
        Pj1Nb9dZjoKf8cpzzr9ueL+6I9N0fvGv5i3xkcEM826+TLbv861l8dnpfPHrU4nonFO6Gtc+
        LJt6e0K3mWbP6i7PA0osxRmJhlrMRcWJAMERgG1OAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7oJLs7RBheOm1lsnLGe1aLp0Ck2
        i6kPn7BZNC9ez2Zx/vwGdotvVzqYLC7vmsNm8e7MU3YHDo+ds+6ye2xa1cnmcefaHjaP/XPX
        sHv0bVnF6PH0x15mj8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV
        9O1sUlJzMstSi/TtEvQytr37y17wRbvi9PktLA2Mb1W6GDk5JARMJGbMOsXUxcjFISSwlFFi
        ycd7LBAJGYmT0xpYIWxhiT/Xutggit4ySjxau58NJCEskCzxfNEiMFtEwE3i5IJJYEXMAueZ
        JH7/eAzWLSSgKfF46QawIjYBQ4mutyCTODh4Bewkrj0vAQmzCKhIrPrdB7ZYVCBGYuXm12Dl
        vAKCEidnPgGLcwpoSby/2MMMYjMLmEnM2/wQypaX2P52DpQtLnHryXymCYxCs5C0z0LSMgtJ
        yywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIExuS2Yz8372C8tDH4EKMAB6MSD++H
        QqdoIdbEsuLK3EOMEhzMSiK8iVZAId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4Hpou8knhD
        U0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2MWqmbnvFsVv42I0Z+c9jz
        mZrPw2+fvGymsvpV8vu/d9JXzimJn+ZV4l5/dP+UUq7r2jYp30tD7l4vElssvXyK6ud5ORoc
        RTd/7LzXGxzwdo+xi/oiS+aCkzl7BUv2HD5XHxEms/NML0c81+vdPdvYnThmVl5X3s5u6btb
        5NH+cwk/C3VOsug+UGIpzkg01GIuKk4EADjvu//fAgAA
Message-Id: <20180709111753eucas1p1f32e66fb2f7ea3216097cd72a132355d~-rzycA5Rg0378203782eucas1p1C@eucas1p1.samsung.com>
X-CMS-MailID: 20180709111753eucas1p1f32e66fb2f7ea3216097cd72a132355d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180709111753eucas1p1f32e66fb2f7ea3216097cd72a132355d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180709111753eucas1p1f32e66fb2f7ea3216097cd72a132355d
References: <E1fb8Ti-00026e-NU@debutante>
        <CGME20180709111753eucas1p1f32e66fb2f7ea3216097cd72a132355d@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

On 2018-07-05 19:55, Mark Brown wrote:
> The patch
>
>     regulator: core: Link consumer with regulator driver
>
> has been applied to the regulator tree at
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
> >From ed1ae2dd9f242c7a36e8e39100f6a7f6bcdfdd89 Mon Sep 17 00:00:00 2001
> From: pascal paillet <p.paillet@st.com>
> Date: Thu, 5 Jul 2018 14:25:56 +0000
> Subject: [PATCH] regulator: core: Link consumer with regulator driver
>
> Add a device link between the consumer and the driver so that
> the consumer is not suspended before the driver. The goal is to avoid
> implementing suspend_late ops in regulator drivers.
>
> Signed-off-by: pascal paillet <p.paillet@st.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

This patch triggers the following warning on several Exynos SoC based 
boards:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at drivers/base/core.c:108 
device_is_dependent+0xa4/0xb4
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc3-next-20180706 #112
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c0113200>] (unwind_backtrace) from [<c010edd0>] (show_stack+0x10/0x14)
[<c010edd0>] (show_stack) from [<c0a4b6e8>] (dump_stack+0x98/0xc4)
[<c0a4b6e8>] (dump_stack) from [<c0127b90>] (__warn+0x10c/0x124)
[<c0127b90>] (__warn) from [<c0127cbc>] (warn_slowpath_null+0x40/0x48)
[<c0127cbc>] (warn_slowpath_null) from [<c0580464>] 
(device_is_dependent+0xa4/0xb4)
[<c0580464>] (device_is_dependent) from [<c058037c>] 
(device_for_each_child+0x50/0x94)
[<c058037c>] (device_for_each_child) from [<c05803e0>] 
(device_is_dependent+0x20/0xb4)
[<c05803e0>] (device_is_dependent) from [<c0581bcc>] 
(device_link_add+0x70/0x2a8)
[<c0581bcc>] (device_link_add) from [<c04e4134>] (_regulator_get+0xbc/0x270)
[<c04e4134>] (_regulator_get) from [<c04e4350>] 
(regulator_bulk_get+0x60/0xcc)
[<c04e4350>] (regulator_bulk_get) from [<c05b4e40>] 
(wm8994_i2c_probe+0x334/0x8ec)
[<c05b4e40>] (wm8994_i2c_probe) from [<c06d8d98>] 
(i2c_device_probe+0x240/0x2b8)
[<c06d8d98>] (i2c_device_probe) from [<c05857d8>] 
(driver_probe_device+0x2dc/0x4ac)
[<c05857d8>] (driver_probe_device) from [<c0585ad0>] 
(__driver_attach+0x128/0x144)
[<c0585ad0>] (__driver_attach) from [<c0583668>] 
(bus_for_each_dev+0x68/0xb4)
[<c0583668>] (bus_for_each_dev) from [<c0584968>] 
(bus_add_driver+0x1a8/0x268)
[<c0584968>] (bus_add_driver) from [<c0586c48>] (driver_register+0x78/0x10c)
[<c0586c48>] (driver_register) from [<c06d9ca4>] 
(i2c_register_driver+0x3c/0xa8)
[<c06d9ca4>] (i2c_register_driver) from [<c0103188>] 
(do_one_initcall+0x8c/0x4b0)
[<c0103188>] (do_one_initcall) from [<c0f01268>] 
(kernel_init_freeable+0x3e4/0x570)
[<c0f01268>] (kernel_init_freeable) from [<c0a6503c>] 
(kernel_init+0x8/0x10c)
[<c0a6503c>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xee8c9fb0 to 0xee8c9ff8)
...
---[ end trace 4ed89cca1d70ea82 ]---

The above stack comes from Exynos5250 Arndale board
(arch/arm/boot/dts/exynos5250-arndale.dts), where wm8994 codec tries to get
regulator, which is provided by its parent mfd device. Similar issue can be
observed on Exynos4412-based Trats2 and Exynos5433 TM2(e) boards.

It looks that some more checks have to be done before adding a link between
regulator consumer and regulator driver, because it is not that uncommon 
that
regulator consumer shares the parent device with regulator provider.

> ---
>   drivers/regulator/core.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index da9b0fed8330..bb1324f93143 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -1740,6 +1740,8 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
>   			rdev->use_count = 0;
>   	}
>   
> +	device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
> +
>   	return regulator;
>   }
>   
> @@ -1829,9 +1831,21 @@ static void _regulator_put(struct regulator *regulator)
>   
>   	debugfs_remove_recursive(regulator->debugfs);
>   
> -	/* remove any sysfs entries */
> -	if (regulator->dev)
> +	if (regulator->dev) {
> +		int count = 0;
> +		struct regulator *r;
> +
> +		list_for_each_entry(r, &rdev->consumer_list, list)
> +			if (r->dev == regulator->dev)
> +				count++;
> +
> +		if (count == 1)
> +			device_link_remove(regulator->dev, &rdev->dev);
> +
> +		/* remove any sysfs entries */
>   		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
> +	}
> +
>   	regulator_lock(rdev);
>   	list_del(&regulator->list);
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

