Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1050C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735952147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aVJnfS1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391518AbfBMKnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:43:07 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:12196 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfBMKnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:43:06 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190213104303epoutp04957829285a3ae5d73967933ca8011a17~C5m5Yi8py2489724897epoutp04l
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 10:43:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190213104303epoutp04957829285a3ae5d73967933ca8011a17~C5m5Yi8py2489724897epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550054583;
        bh=yDpf9/nYmxXdKqzh3nl0n/2UoaaoboIaBEiS2MxYyYA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aVJnfS1dYTO5TLZXXEQHuMMd7dtonAcdLyf+8aJsljp8PUitNerH5CiPyorq87J5y
         pJFoYfusP7wzJvGVgoBJFB+qqOt0Xy7/VdAxziH+fDEuovXdN+0OcEHVxyh0A2O6kE
         LtdoBlqaRFYaletF+VmMN1R+UDLeGnjYZpZBCcRo=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190213104302epcas5p3896a282b2322b616d69c7846b869493e~C5m4r2H032282322823epcas5p3D;
        Wed, 13 Feb 2019 10:43:02 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.78.04135.6B4F36C5; Wed, 13 Feb 2019 19:43:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20190213104301epcas5p230e5b9582c88753725b7ed4aa91fe144~C5m3vOsfc2754327543epcas5p2N;
        Wed, 13 Feb 2019 10:43:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190213104301epsmtrp2be987dff232413b2b98e54f08fa29a00~C5m3sxY8Y2728727287epsmtrp2R;
        Wed, 13 Feb 2019 10:43:01 +0000 (GMT)
X-AuditID: b6c32a49-bafff70000001027-94-5c63f4b65890
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.DF.03971.5B4F36C5; Wed, 13 Feb 2019 19:43:01 +0900 (KST)
Received: from [107.108.73.28] (unknown [107.108.73.28]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190213104258epsmtip29a81c48d21461693142061fb7bb61d3a~C5m0c_vY51385513855epsmtip2s;
        Wed, 13 Feb 2019 10:42:57 +0000 (GMT)
Subject: Re: [PATCH v5 0/2] Clean up UFSHC driver
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Gilad Broner <gbroner@codeaurora.org>,
        Raviv Shvili <rshvili@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, Kyuho Choi <kyuho.choi@sk.com>,
        Martin Petersen <martin.petersen@oracle.com>
From:   Alim Akhtar <alim.akhtar@samsung.com>
Message-ID: <7ce5a14a-56a7-22bb-b16e-fc898c0ea6e8@samsung.com>
Date:   Wed, 13 Feb 2019 15:55:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTQRTHnd3tdGmsrgvGBwY1jUdEBYmajMGoMX5YExOMJMYDoxVWJFxN
        Cx7gBzxQpLYVDCJLvfAGxQSxQEujgIJHSsQiKIhERQhEiFIEjYpaFiPffm/m9583bzIszRfi
        ADY2MVnUJ2rjNVjF2GrnBy2yDUZFLm6zzibNJRGk5/tLTF78HETk2f1+huS+68TEda0ak4yO
        PIrcelRAkarCHIo0fYghr29ewaQuz86QoaZMirjtVkyMLRWY2DwumlyvH6FI+RUPJkfrvjIk
        w/lQSTIbrDSp7C2myKvLlZhI9V8w+eUyKVf7CwXpjYzgNpsowVLiUQiVUrtSKC06gYU3zVVY
        +PKxlRGG2gTh7rM0oey+Bwme0hnC8QdGasPEraoV0WJ87F5RH7Jyp2qPrXmjrpvdf8n5hE5H
        v3AW8mGBWwoN7hFlFlKxPOdAYO7qouRiAEH1hUMKr8VzQwi62nz+JRzZZ8cSTgTPm+8q5KIP
        QcflLOS1fLlQMH87rfSyH5cCTy3Do0xznzE4pfVextwCaM8ro7ys5laCe8BJe5nh5kDV7+ej
        /lRuM9Sa+pHsTIEn+Z2Ml324MLDUnKDkM6dBa+eFMZ4J5X1WWr5pNgufjGkyr4WWrz2UzL7Q
        W1+mlDkAPP3Ov2/B/uU4OGlfIi8fhKvn6xiZV8GDJivjVWhuPtyxh8idJoHpRyclJ9WQeYyX
        7TlwpP/lWHI6ZBuNClkRoPvwKvmhzAiO53TQp9Asadxc0rhZpHGzSP8bX0RMEfIXdYaEGNGw
        TBeaKO4LNmgTDCmJMcFRSQmlaPTnBq2rQFLD+hrEsUgzUX3j0a5IXqHdaziQUIOApTV+6lcD
        UZG8Olp7IFXUJ+3Qp8SLhho0nWU009TnAs9t47kYbbIYJ4o6Uf9vl2J9AtLR1uSuXLu2vdC1
        0Bh45ve64Xy1TQqc63bx6bsHzFUuvHpkkH8aNmuHoIpou5dxtvz68NTbtTpH69ukGWmWw8Xh
        juWPkya0vLdsFmarILb99droBkdYYOiuxp7qyBC3ZfKSa9vCTQGbFLWNqSVxtFSwPSJnjbX6
        VIhyi79GmofyNYxhjzY0iNYbtH8A3Y/gtrUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7bCSvO7WL8kxBhvvylpcWxds8fLnVTaL
        S3++MFqc3v+OxWLqwydsFmeXHWSzaL0/nclizdHZTBZ7Fk1isrjyON3i5solbBbHpu9isfh2
        pYPJ4vKuOWwW3dd3sFls+3yW2WL58X9MFtuXfGazaDn2lcWide8RdouOc3OYLXa+Ws1kcWPx
        TjaLWcc/sln8PdvL7iDpMbvhIovH5b5eJo/+dZ9ZPXbOusvusWlVJ5vHnWt72Dw+Pr3F4vHt
        tofH5tPVHlv2f2b0+LxJzqP9QDdTAE8Ul01Kak5mWWqRvl0CV8a2a0EFzzkqFu49ydzA+Jet
        i5GTQ0LARGL3xBnsXYxcHEICuxklOud1skIkpCWub5zADmELS6z89xyq6DWjxIKnl1lAEsIC
        hhJ9PyaDFYkIlEpM/vaKGaSIWeALm0T/vi5miI4+RollT1eBjWUT0Ja4O30LE4jNK2AncfnT
        XmYQm0VAVWLP/wtgk0QFIiQ+Pt0HVSMocXLmE7BtnALWEv2HOsHizAJmEvM2P2SGsMUlbj2Z
        DxWXl9j+dg7zBEahWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS
        83M3MYJThZbmDsbLS+IPMQpwMCrx8K44mhQjxJpYVlyZe4hRgoNZSYT3xqfkGCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoY/SXaf3LnP9/jxLHsDnOB
        4aWG78rfL2gH/0+KzG0t31RjnXvl7lGuzVNO8ztF5i+JOH0rOu7my/KgpVv4F6epRRe383qb
        zeWvnRe0U6vOskPxwt8lggdaFlpoxi52tLnfXXZ4C8Ncj0luM/O/GMWeWaK+o5end25NdMG2
        6JCHJvGS9ZvWe8QosRRnJBpqMRcVJwIA1S8FCBEDAAA=
X-CMS-MailID: 20190213104301epcas5p230e5b9582c88753725b7ed4aa91fe144
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190211133457epcas3p2dc95fa2c93c3cf884a376f0282be8b8a
References: <CGME20190211133457epcas3p2dc95fa2c93c3cf884a376f0282be8b8a@epcas3p2.samsung.com>
        <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 11/02/19 7:01 PM, Marc Gonzalez wrote:
> Casting a wide net to get as many eyeballs on the subject as possible.
> 
> I'm splitting this mini series off from the main "UFS on APQ8098/MSM8998"
> as it's 1) ufs/scsi specific 2) controversial (to my surprise)
> 
> Please send all your Reviewed-by: tags if you agree with the patch,
> and/or voice your concerns ASAP.
> 
> This series removes the "disable-VCCQ-power-rail-for-some-Flash-chips" quirk,
> and cleans up after the dust settles.
> 
> Marc Gonzalez (2):
>    scsi: ufs: Do not disable vccq in UFSHC driver
>    scsi: ufs: Remove unused device quirks
> 
>   drivers/scsi/ufs/ufs.h        |  1 -
>   drivers/scsi/ufs/ufs_quirks.h | 29 ----------------
>   drivers/scsi/ufs/ufshcd.c     | 63 +++--------------------------------
>   3 files changed, 4 insertions(+), 89 deletions(-)
> 
For this series
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
As no other platform has claimed issues with this we can land this.
Others let us know if your opinion differs here.

Acked-by: Alim Akhtar <alim.akhtar@samsung.com>

Thanks!

