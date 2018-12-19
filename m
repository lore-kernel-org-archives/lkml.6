Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED956C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB89F2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hnU8/Mq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeLSJNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:13:02 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59522 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbeLSJNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:13:02 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181219091300euoutp019a3bb9e673d24385cb6b168b0abe178a~xsQSFT_la0431404314euoutp01i
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:13:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181219091300euoutp019a3bb9e673d24385cb6b168b0abe178a~xsQSFT_la0431404314euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545210780;
        bh=2lkYoipPSUJKiuFwDDbB5eIRRvwO4ZPZA6EexHLEDv0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hnU8/Mq1xAlaapMcF6STcJwMEyPebvlnDrqrwjuED5Q8boRyZpIhdjHTYmisD/T+j
         w1RXf3SWccQR2SX5HrtxohVxEeoBL/pAgu/zrBPN8pyjGiBkbSidEQbIlPoigZvBrY
         bUBqE+LwuWjL76vM+zUQdgkiG6OWHOrf4/xQ/H6M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181219091259eucas1p225d2db7829f7ad1556258611ca2a62ac~xsQRVp0RJ1321513215eucas1p2z;
        Wed, 19 Dec 2018 09:12:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 66.5E.04806.B9B0A1C5; Wed, 19
        Dec 2018 09:12:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181219091258eucas1p299f117f6533b48d4e3e3684baf5fcf2f~xsQQhkmgb2315123151eucas1p2T;
        Wed, 19 Dec 2018 09:12:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181219091258eusmtrp22d1bc1ced8873c95219c06300e83807c~xsQQS5jlc0073900739eusmtrp2R;
        Wed, 19 Dec 2018 09:12:58 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-fe-5c1a0b9b5a49
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AB.BA.04128.A9B0A1C5; Wed, 19
        Dec 2018 09:12:58 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181219091257eusmtip1f49dd698dd04c5d1d3a3ce371bffab8c~xsQP4L6IE0506005060eusmtip1L;
        Wed, 19 Dec 2018 09:12:57 +0000 (GMT)
Subject: Re: [PATCH 2/3] dt-bindings: display: bridge: lvds-transmitter: add
 pwdn-gpios
To:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <f0686eeb-14af-6525-6c55-9cc8bdc5730e@samsung.com>
Date:   Wed, 19 Dec 2018 10:12:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218231850.3572-3-peda@axentia.se>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djP87qzuaViDBYfZrboPXeSyaKp4y2r
        xfwj51gtrnx9z2bROXEJu8XlXXPYLJZev8hksffQfEaL1r1H2B04PdbMW8PoMe3AbHaPy329
        TB6zO2ayemxa1cnmsf3bA1aP+93HmTw+b5IL4IjisklJzcksSy3St0vgylj85yVbwSPOihNT
        brM3ME7m6GLk5JAQMJG4P7eXsYuRi0NIYAWjxLJdS5khnC+MEsc23WWBcD4zSnyb8ooZpmXh
        m0VsEInljBKTb96H6n/LKHH28jEWkCphgUiJD6v/sYPYIgJJEivvP2ACKWIWuMAk8WNnGxtI
        gk1AU+Lv5ptgNq+AnUT37QlgK1gEVCXa7+wGs0UFIiQ67q+GqhGUODnzCdgCTqAz5j46zgpi
        MwvIS2x/O4cZwhaXuPVkPtgyCYFr7BJLP+5hgrjbReL827mMELawxKvjW9ghbBmJ/zvnQ9XU
        SzTNvMIM0dzBKHFi8XI2iIS1xOHjF4G2cQBt0JRYv0sfIuwosXjJL0aQsIQAn8SNt4IQN/BJ
        TNo2nRkizCvR0SYEUa0ocf/sVmgoikssvfCVbQKj0iwkn81C8s0sJN/MQti7gJFlFaN4amlx
        bnpqsXFearlecWJucWleul5yfu4mRmDiOv3v+NcdjPv+JB1iFOBgVOLhfaAkGSPEmlhWXJl7
        iFGCg1lJhPdSNFCINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs1NSC1CKYLBMH
        p1QD45INATmJ+h8OsSZdlc0+xyUR23HiVrJr75XTvTM6SytecSfubW9Pe38yakrw/7laG9a+
        vndo2dOjxz981TV3/vPawsdc4/ef+yYTf+16VbAvfHka/wGnDTOfPbl4pjb7i8yD2a/z1+px
        Ta+buy7B4LHK5ktMSpt17irIe2664XwqjCXy3AEjMUUlluKMREMt5qLiRAA+itvmWAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7qzuKViDJbM57ToPXeSyaKp4y2r
        xfwj51gtrnx9z2bROXEJu8XlXXPYLJZev8hksffQfEaL1r1H2B04PdbMW8PoMe3AbHaPy329
        TB6zO2ayemxa1cnmsf3bA1aP+93HmTw+b5IL4IjSsynKLy1JVcjILy6xVYo2tDDSM7S00DMy
        sdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy1j85yVbwSPOihNTbrM3ME7m6GLk5JAQMJFY+GYR
        WxcjF4eQwFJGia93VrFAJMQlds9/ywxhC0v8udYFVfSaUeL2iUdsIAlhgUiJD6v/sYPYIgJJ
        Ekdmb2YGKWIWuMAkcX5dAwtEx0ZGiStPNrOCVLEJaEr83XwTrJtXwE6i+/YEsBUsAqoS7Xd2
        g9miAhESZ1+uY4SoEZQ4OfMJ2EmcQLfOfXQcbA6zgLrEn3mXmCFseYntb+dA2eISt57MZ5rA
        KDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmCsbjv2c8sOxq53
        wYcYBTgYlXh4uxQkY4RYE8uKK3MPMUpwMCuJ8F6KBgrxpiRWVqUW5ccXleakFh9iNAV6biKz
        lGhyPjCN5JXEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYMz8s3pN
        eaSW9In/39zzV3lsNF5av+HkmU1zZ7h/d2I8bi1s8+dMT1a7qK/Vh6DKu14sGV81rJ0n6+5J
        WRXbLvdaIoNrrVbPzL3plucK/77eEsZwpydj5yf/vHXuE6VKd65pj/o94+GFFbIXwtg/hx4/
        r7Nnz48L82VW+jxgOPl8S9OZAo/IAGclluKMREMt5qLiRACcoPTA6wIAAA==
X-CMS-MailID: 20181219091258eucas1p299f117f6533b48d4e3e3684baf5fcf2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181218231950epcas3p4d5bc243137aa464b0424365dfde9d238
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181218231950epcas3p4d5bc243137aa464b0424365dfde9d238
References: <20181218231850.3572-1-peda@axentia.se>
        <CGME20181218231950epcas3p4d5bc243137aa464b0424365dfde9d238@epcas3p4.samsung.com>
        <20181218231850.3572-3-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.12.2018 00:19, Peter Rosin wrote:
> Add optional property to specify a power-down GPIO.
> The pwdn-gpios name is already in use by the thine,thc63lvdm83d
> binding, so go with that.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> index f9e7dd666f58..47941d39f92f 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> @@ -31,6 +31,9 @@ Required properties:
>    device-specific version corresponding to the device first
>    followed by the generic version.
>  
> +Optional properties:
> +- pwdn-gpios: Power-down control GPIO
> +


Since naming is not enforced by any datasheet I would propose something
more popular with less twisted logic. Maybe:

- enable-gpios: ... (active high).


Regards

Andrzej


>  Required nodes:
>  
>  This device has two video ports. Their connections are modeled using the OF


