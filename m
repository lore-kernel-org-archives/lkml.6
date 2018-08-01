Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946A6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A2620894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cTh/WZTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A2620894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbeHAKMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:12:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:59292 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388600AbeHAKMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:12:38 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180801082802epoutp03a7e0538fec5a7f7970f3d4abdac11820~GtVDqc0qb1979419794epoutp03V;
        Wed,  1 Aug 2018 08:28:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180801082802epoutp03a7e0538fec5a7f7970f3d4abdac11820~GtVDqc0qb1979419794epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533112082;
        bh=Wmv/aY9J30d2WDUQmvFSRZfOv8W0HFmnJKnfZCvDIRA=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=cTh/WZTCSGed7rzc0QrgusIcfI6CSdSnm8djPHwVqgFE934/hgs3+jSFTBXBtf7+Z
         bmU/IjaTs7thn64ej/wjsd9toztY5eScXPd1ZsmcEy8MGDH+KUJSr2iLX7oIfV2pab
         Mr7CeZFsqYq/GkBC1lZDpwYGN2thuYPO8zOP7kkM=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180801082758epcas1p1558efbeda71aa7fa6de47e782b985227~GtVAW-yBS2589725897epcas1p1u;
        Wed,  1 Aug 2018 08:27:58 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.BC.04292.E0F616B5; Wed,  1 Aug 2018 17:27:58 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180801082758epcas1p1ffe9bf5863877d30bad448f411ae5843~GtVAGe8K_2592725927epcas1p1a;
        Wed,  1 Aug 2018 08:27:58 +0000 (GMT)
X-AuditID: b6c32a38-d53ff700000010c4-ce-5b616f0e03ad
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id EA.A2.03704.E0F616B5; Wed,  1 Aug
        2018 17:27:58 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCR001NOWULTLA0@mmp2.samsung.com>; Wed, 01 Aug 2018 17:27:58 +0900 (KST)
Message-id: <5B616F0D.1050901@samsung.com>
Date:   Wed, 01 Aug 2018 17:27:57 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
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
Subject: Re: [PATCH v5 09/12] dt-bindings: misc: add bindings for throttler
In-reply-to: <20180703234705.227473-10-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmni5ffmK0wao/2hZ/Jx1jt5j+5DKL
        xaaP71kt5h85x2pxdtlBNos1tw8xWjQvXs9mcbbpDbvF/a9HGS0u75rDZvG59wijxdLrF5ks
        Pm94zGhxu3EFm8Wp65/ZLM6cvsRq0br3CLvFxq8eDkIea+atYfT4/WsSo8fshossHjvuLmH0
        2LSqk83jzrU9bB77565h97hyoonVY8vVdhaPvi2rGD0+b5IL4I5KtclITUxJLVJIzUvOT8nM
        S7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBek1JoSwxpxQoFJBYXKykb2dTlF9a
        kqqQkV9cYqsUbWhopGdoYK5nZASkjWOtjEyBShJSM66fP8JYsI6n4tSlj0wNjL1cXYycHBIC
        JhJTP1xlAbGFBHYwSsw+K9/FyAVkf2eUWD15ORNMUePWO+wQiQ2MEpf+TGYHSfAKCEr8mHwP
        qJuDg1lAXuLIpWyQMLOApsTW3euh6u8ySnw51sQMUa8l8efhBbChLAKqEkcmbgKLswHF97+4
        wQZi8wsoSlz98ZgRxBYViJDYOf8b2C4RgWCJBT/Ps4AMZRZ4zSKxsOU3K0hCWMBb4uGpRmaQ
        IzgFLCRmLw8EqZEQOMcu8eHVQhaID1wkmhaeZYWwhSVeHd/CDlIvISAtcemoLUR9O9ChL5pZ
        IZwJjBIfTm2Get9Y4tnCLiaI1/gk3n3tYYVo5pXoaBOCKPGQ+Lp7OSvEx8BgXNp4mG0Co+ws
        pECahQikWUiBtICReRWjWGpBcW56arFhgYlecWJucWleul5yfu4mRnAC1rLYwbjnnM8hRgEO
        RiUe3oLKhGgh1sSy4srcQ4wSHMxKIrw2MvHRQrwpiZVVqUX58UWlOanFhxhNgWE8kVlKNDkf
        mB3ySuINTY2MjY0tTAzNTA0NlcR5jfyCo4UE0hNLUrNTUwtSi2D6mDg4pRoYzdpPf/MNkxb+
        yLFlvqPRrw/q92WfKpfvdNTqKPx8wshW2LL1g9fB7Xbzrjj03ndkzVu0YO/lkO2T2/v5A1fX
        b62cuPrCXEWWY1sqfzxwrVLNnu4aFWz81ud47ZH/TB+9jwfwhYW4pHw+pbRv4cqgK6x7LnxJ
        POm5cOHDSofI7Svk6s7/PCz1XomlOCPRUIu5qDgRAJY+95vWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t9jQV2+/MRogzl9khZ/Jx1jt5j+5DKL
        xaaP71kt5h85x2pxdtlBNos1tw8xWjQvXs9mcbbpDbvF/a9HGS0u75rDZvG59wijxdLrF5ks
        Pm94zGhxu3EFm8Wp65/ZLM6cvsRq0br3CLvFxq8eDkIea+atYfT4/WsSo8fshossHjvuLmH0
        2LSqk83jzrU9bB77565h97hyoonVY8vVdhaPvi2rGD0+b5IL4I7isklJzcksSy3St0vgyrh+
        /ghjwTqeilOXPjI1MPZydTFyckgImEg0br3D3sXIxSEksI5RYt7aZcwgCV4BQYkfk++xdDFy
        cDALyEscuZQNEmYWUJeYNG8RM0T9fUaJW7s/QdVrSfx5eIEJxGYRUJU4MnETWJwNKL7/xQ02
        EJtfQFHi6o/HjCAzRQUiJLpPVIKERQSCJT4097CBzGQWeMsisfTbf0aQhLCAt8TDU41gc4QE
        djBKfP+sBtLLKWAhMXt54ARGgVlILp2FcOksJJcuYGRexSiZWlCcm55bbFRgmJdarlecmFtc
        mpeul5yfu4kRGJHbDmv17WC8vyT+EKMAB6MSD++J6oRoIdbEsuLK3EOMEhzMSiK8NjLx0UK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5b+cdixQSSE8sSc1OTS1ILYLJMnFwSjUw6id67IwNv27D
        ddGdre/IXfPDAolHFBnvirOIZQT76mTMO5nQbnSFT5g9INWrMzqg28b95EUxkc1bm3oKV59s
        3S6z58dZw4XSobf/p+RFzA1rtFriv3zbgrxvL674yexsbxH6urYxy9TPVt7lScV/Hz2hed+5
        9x+8k5gsZpd9hPVqx2lltR1KLMUZiYZazEXFiQB0glHnxAIAAA==
X-CMS-MailID: 20180801082758epcas1p1ffe9bf5863877d30bad448f411ae5843
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703234851epcas2p366dcf068db0a7761d7cdccabc4f1fb6e
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703234851epcas2p366dcf068db0a7761d7cdccabc4f1fb6e@epcas2p3.samsung.com>
        <20180703234705.227473-10-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 07월 04일 08:47, Matthias Kaehlcke wrote:
> The Throttler is used for non-thermal throttling of system components
> like CPUs or devfreq devices.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> --
> Changes in v5:
> - patch added to the series (replacing "dt-bindings: PM / OPP: add
>   opp-throttlers property")
> ---
>  .../devicetree/bindings/misc/throttler.txt          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/throttler.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/throttler.txt b/Documentation/devicetree/bindings/misc/throttler.txt
> new file mode 100644
> index 000000000000..2ea80c62dbe1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/throttler.txt
> @@ -0,0 +1,13 @@
> +Throttler driver
> +
> +The Throttler is used for non-thermal throttling of system components like
> +CPUs or devfreq devices.
> +
> +Required properties:
> +- throttler-opps	Array of OPP-v2 phandles with the OPPs used for
> +			throttling.
> +
> +Example:
> +	throttler {
> +		 throttler-opps = <&cpu0_opp03, &cpu1_opp02, &gpu_opp03>;
> +	};
> 

If possible, I hope the more detailed example for "cpu0_opp03, &cpu1_opp02, &gpu_opp03"
because I'm confusing the meaning of 'cpu0_opp03' phandle.

cpu0_opp03 indicates the only one specific OPP entry among set of OPP entries of CPU0 cpufreq? or
cpu0_opp03 indicates the set of OPP entries for CPU0 cpufreq ?


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
