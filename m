Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5E1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DF721720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mTt3IAuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbeLTRDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:03:10 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39720 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387498AbeLTRDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:03:10 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181220170308euoutp01e9fb27b83c870a89dd933ebad76a12e9~yGUDankdJ0643706437euoutp01S
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 17:03:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181220170308euoutp01e9fb27b83c870a89dd933ebad76a12e9~yGUDankdJ0643706437euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545325388;
        bh=sSbIDJAyUq7ja3SxaN22CPZl0CaSfI0l64XQhnCQg6c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mTt3IAuks9dhSQgNLSLwnXnoBrPisowmtJ9XKIKf+2eyNlwtsXY9OqI4ZB6Qc6mfB
         l7OU9S0/LHGN1bSsBnDXeOydobbWeOVQ6qgu01xhhBUt1yg1J4BdAva5Tip9RyJee4
         hJ73GNVJMp29bTTY7l0OxwvgBWheuFbdb6GWzTTg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220170307eucas1p2d96c50a3dfd59cb0eeaf29e32f54a80b~yGUCHNl4Q2069420694eucas1p25;
        Thu, 20 Dec 2018 17:03:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 83.C8.04806.A4BCB1C5; Thu, 20
        Dec 2018 17:03:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181220170306eucas1p209bc1ce6de6e12fba9323007e164fc7f~yGUBN-D5U2467624676eucas1p2W;
        Thu, 20 Dec 2018 17:03:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181220170305eusmtrp222052cef2878780e05e972cbea09f86c~yGUA-w9H00315403154eusmtrp2J;
        Thu, 20 Dec 2018 17:03:05 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-d6-5c1bcb4ab76c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C2.4D.04128.94BCB1C5; Thu, 20
        Dec 2018 17:03:05 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181220170305eusmtip2ee12fc51b0ae7a9b3db551796d5dcc6a~yGUAvT2gP1053310533eusmtip2D;
        Thu, 20 Dec 2018 17:03:05 +0000 (GMT)
Subject: Re: [PATCH] ata: pata_macio: add of_node_put()
To:     Yangtao Li <tiny.windzz@gmail.com>, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <b3331d3f-3bfd-f3ce-cea1-30c4b13e6374@samsung.com>
Date:   Thu, 20 Dec 2018 18:03:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181121130439.22255-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzneV2v09IxBisea1usvtvPZnFsxyMm
        i8u75rBZzP09gc2BxWPnrLvsHpfPlnp83iQXwBzFZZOSmpNZllqkb5fAlfF96QX2goscFUfm
        X2NsYGxh72Lk5JAQMJH4e+shYxcjF4eQwApGiZUL10A5Xxgl+pbuZYNwPjNK9PS/Y4Jpufp1
        FStEYjmjxL85z6Cc94wSP2bvYAOpEhYwl/i0cQojiC0CZDevOMYKYjMLWEtsbZ0GtpxNwEpi
        YvsqsBpeATuJfW1PmbsYOThYBFQl1h+xAjFFBSIk+s+oQ1QISpyc+YQFxOYEmvLk5RJmiIkG
        EkcWzYGaLi+x/e0cZpBzJAS+s0k8aL/OBnG0i8T/48+gbGGJV8e3QP0vI/F/53wmiIbpjBJv
        fi1lgXDWM0qsOXMM6mVricPHL7JC2I4S22ZMYgS5TkKAT+LGW0GIzXwSk7ZNZ4YI80p0tAlB
        VKtJbFi2gQ1mV9fOlcwQtofEr4svGCcwKs5C8tssJP/MQvLPAkbmVYziqaXFuempxcZ5qeV6
        xYm5xaV56XrJ+bmbGIGp4/S/4193MO77k3SIUYCDUYmHV2OXdIwQa2JZcWXuIUYJDmYlEd71
        h4BCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGOMNH9Sr
        ZnHK66ZYWa3/la9oq1DKdqKoc3GLX/XNVMfFGuZ3eGf03ZOpObZTVoznWPWTzXO6640OxIjZ
        X9IIiovS/LnO1/Tk0tnRktkTt+6M2pl25WGurl7kzE8mB2ecKlt71qedS/j+mVyGG5PefhFO
        fxpa0rj5gE/QoSfH5xgVOqT73nnipsRSnJFoqMVcVJwIAOmL5rsZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4PV3P09IxBh8XGFmsvtvPZnFsxyMm
        i8u75rBZzP09gc2BxWPnrLvsHpfPlnp83iQXwBylZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdk
        YqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/F96QX2goscFUfmX2NsYGxh72Lk5JAQMJG4+nUV
        K4gtJLCUUeLDJvEuRg6guIzE8fVlECXCEn+udbF1MXIBlbxllDj59jQjSEJYwFzi08YpYLYI
        kN284hgrRFEfo8TqBZ9YQBLMAtYSW1ungS1jE7CSmNi+CqyBV8BOYl/bU2aQZSwCqhLrj1iB
        hEUFIiRuPexggSgRlDg58wmYzQk05snLJcwQI/Ukdlz/xQphy0tsfzuHeQKj4CwkLbOQlM1C
        UraAkXkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYDRsO/Zzyw7GrnfBhxgFOBiVeHg1dknH
        CLEmlhVX5h5ilOBgVhLhXX8IKMSbklhZlVqUH19UmpNafIjRFOiHicxSosn5wEjNK4k3NDU0
        t7A0NDc2NzazUBLnPW9QGSUkkJ5YkpqdmlqQWgTTx8TBKdXAuOOFQ8WS9Ry7Ja8cmNS0a6vj
        n4P6K8z2eG16KfXq/eE1HiHSKyLPS628eU7ZQuSwVEB8dvB3Xr2dpUX7kvx5Mp/r/e64s6gv
        x2Ft4JMdbedrHn2KE3JIedKy+9/3ZtvYuiNen3WqLjzVruCcbTsx4fX803qqH6dwOLOK3a48
        LvVcs2F3amCgqBJLcUaioRZzUXEiAIq21XWcAgAA
X-CMS-MailID: 20181220170306eucas1p209bc1ce6de6e12fba9323007e164fc7f
X-Msg-Generator: CA
X-RootMTR: 20181121130510epcas3p4498edc67a02f61a6aa8e55efa9349681
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121130510epcas3p4498edc67a02f61a6aa8e55efa9349681
References: <CGME20181121130510epcas3p4498edc67a02f61a6aa8e55efa9349681@epcas3p4.samsung.com>
        <20181121130439.22255-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/21/2018 02:04 PM, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

>  drivers/ata/pata_macio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
> index 9588e685d994..8cc9c429ad95 100644
> --- a/drivers/ata/pata_macio.c
> +++ b/drivers/ata/pata_macio.c
> @@ -483,6 +483,8 @@ static int pata_macio_cable_detect(struct ata_port *ap)
>  		struct device_node *root = of_find_node_by_path("/");
>  		const char *model = of_get_property(root, "model", NULL);
>  
> +		of_node_put(root);
> +
>  		if (cable && !strncmp(cable, "80-", 3)) {
>  			/* Some drives fail to detect 80c cable in PowerBook
>  			 * These machine use proprietary short IDE cable
> 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
