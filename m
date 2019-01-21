Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789E4C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF3B2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="QHbt5jbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfAUMT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:19:56 -0500
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:61600
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727971AbfAUMTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48xiolcjYioWRo/c20hoHtKvA19tH89CwFz1/aPxvRY=;
 b=QHbt5jbL1TaB9aO+Y3jIXm1447T2NJF6ZPxcCGLyMEOdpM5HiImhscK96X1s13c0HUIOxFgYHf/G32kSJcQZ8bLJhxoOwyIHLD2iib1MbOQtLkVsAziB+TmJwj9/b9EOAqi0KIxC+8lWU1JM2sIrD4xsUFeb1INbzqNQDoKFcGc=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB3364.eurprd08.prod.outlook.com (20.177.109.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Mon, 21 Jan 2019 12:19:08 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 12:19:08 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Liam Mark <lmark@codeaurora.org>
CC:     "labbott@redhat.com" <labbott@redhat.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "tkjos@android.com" <tkjos@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "afd@ti.com" <afd@ti.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "arve@android.com" <arve@android.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "maco@android.com" <maco@android.com>,
        "christian@brauner.io" <christian@brauner.io>, nd <nd@arm.com>
Subject: Re: [PATCH 4/4] staging: android: ion: Support for mapping with dma
 mapping attributes
Thread-Topic: [PATCH 4/4] staging: android: ion: Support for mapping with dma
 mapping attributes
Thread-Index: AQHUsYOCfRfOk8fxG0a4t6CoqOChVA==
Date:   Mon, 21 Jan 2019 12:19:08 +0000
Message-ID: <20190121121907.f3dxhpdavklgb46c@DESKTOP-E1NTVVP.localdomain>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-5-git-send-email-lmark@codeaurora.org>
In-Reply-To: <1547836667-13695-5-git-send-email-lmark@codeaurora.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.49]
x-clientproxiedby: CWLP265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:25::13) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3364;6:Z4eOk2FWq4zYd2Cc+Q1e8Sjs8t8tJFHeH73xSZlb8RbBKcas1qF5bWlZElZlTm7DGYMSMkGB07JfjqsX6ckq51QBPDx18cPPoQ58PNp4aQ4uNwIj6IuYVxOdi1xyxLxdaxt+l/IYcc08rgoQxyq/DZpCvpmUaWDkOZoy5GaHtVGdV37IpgmnFDY1hd9oBXiQQoQFswvVPl9k+PWzan2leg1fp4yzaqbWtW8PknJStn5vm2+XN06Ef5st4kx9KVzeZMhb6G3JcNRkLjJk+p1oIRgQdXFo368raH+37cikIr+IEVOmr+mXbqq8SPYHfvhmVkn9vT3pJSNAJbE8e3QMNrdU0aXuuwZfnevVwHkAMSTUEgISqmZ9A0fFdSwsO+NnGTLFPSbYY36orXPJIo74l6oixYLVqY63yp9/id2qvEv/Woa1yQG2YRL15gF4nMD81e3NQ0dkzq68UspD91M+WA==;5:FLCbZSDcaQUJ8AUeXcqpOZxZ2RavSKZAST/SahvM0DDGAS+z5P5wIeB4A123CPZ1aJ1Ej+unIrxG4jKmnuAZgyf/oq4DFOIn2EoC28z5N7GCemZOeur4MGHv+5nPEzXsAxqbl+bwxgGn5zRtQIHJa1K1G/CEWmZ+4Lpk3K8+J+38Rg0LEEOb2ceBIn+3tC3zBp0dUTz6R9a4v7gcCvDstg==;7:n3VLWRDr97V5f+j5qeYG+LvF0A3sZyaswQc+suEEMV6PXLQ7dLuupKG2N3p8MXVIfvWXr0w1mhSj0lDO0HELhzPRbbpanmB6EMUJyBewkNiuY/5GayXur8o1SMmqH4Pe4o/Iu29KoIH+5j5o6C3yZg==
x-ms-office365-filtering-correlation-id: e4597cb1-cabd-4c1e-43fc-08d67f9aa49f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3364;
x-ms-traffictypediagnostic: AM0PR08MB3364:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB33640A0F0F9940315B53818DF09F0@AM0PR08MB3364.eurprd08.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39860400002)(396003)(189003)(199004)(7416002)(106356001)(58126008)(102836004)(386003)(33896004)(52116002)(316002)(66066001)(97736004)(6306002)(99286004)(8676002)(76176011)(6512007)(9686003)(68736007)(305945005)(7736002)(14454004)(2906002)(54906003)(6506007)(105586002)(966005)(478600001)(6916009)(229853002)(72206003)(3846002)(6116002)(6436002)(6486002)(5024004)(476003)(86362001)(486006)(44832011)(26005)(81156014)(11346002)(1076003)(8936002)(71200400001)(71190400001)(25786009)(6246003)(4326008)(81166006)(446003)(256004)(14444005)(186003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3364;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gR+K+rNRh67KKO0+HbqBo2i/kGHndJ1KfXfjqe24iBmP/RXNuGfGie7x4cV1RmyC4QgI2nuX/5yjPKiOnSKep5o+9oA4vfi7MNoCxN/YaYDGZBIrH7vXioP+Sni3pH/jVsOSCYsrT/SdVNXl4sRaQ6MjFuvzjV+OY+brB2wt8F/c4YAzkeBTrNWDl9lJJlC3ul4mh928k12joIz4DcHTsk6U2MdZWAU+SzKYz+/FZVI/Ju16X7xuQqRFfrIcxRc1BeZ1ToFVl/HqsOHwesjCdDnhEZP7NjJf5Oz/CDRyEBSIJpuZsTIn1MhfzxI374UTdHjdeaIv9TTWoGOr0KSPKfBLXJBc5UOBAfq/Vk+gh7EYg/BxLllxlGpDNLL74TtyppkjzVf065mz+EuyglNAs/yMZrJB2f8MecDwZNK8aM0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <227BB9D72BD0A34FABCC480893BC74DA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4597cb1-cabd-4c1e-43fc-08d67f9aa49f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 12:19:07.9502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3364
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Fri, Jan 18, 2019 at 10:37:47AM -0800, Liam Mark wrote:
> Add support for configuring dma mapping attributes when mapping
> and unmapping memory through dma_buf_map_attachment and
> dma_buf_unmap_attachment.
>=20
> For example this will allow ION clients to skip cache maintenance, by
> using DMA_ATTR_SKIP_CPU_SYNC, for buffers which are clean and haven't bee=
n
> accessed by the CPU.

How can a client know that the buffer won't be accessed by the CPU in
the future though?

I don't think we can push this decision to clients, because they are
lacking information about what else is going on with the buffer. It
needs to be done by the exporter, IMO.

Thanks,
-Brian

>=20
> Signed-off-by: Liam Mark <lmark@codeaurora.org>
> ---
>  drivers/staging/android/ion/ion.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/=
ion/ion.c
> index 1fe633a7fdba..0aae845b20ba 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -268,8 +268,8 @@ static struct sg_table *ion_map_dma_buf(struct dma_bu=
f_attachment *attachment,
>  	table =3D a->table;
> =20
>  	mutex_lock(&buffer->lock);
> -	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> -			direction)) {
> +	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
> +			      direction, attachment->dma_map_attrs)) {
>  		mutex_unlock(&buffer->lock);
>  		return ERR_PTR(-ENOMEM);
>  	}
> @@ -287,7 +287,8 @@ static void ion_unmap_dma_buf(struct dma_buf_attachme=
nt *attachment,
>  	struct ion_buffer *buffer =3D attachment->dmabuf->priv;
> =20
>  	mutex_lock(&buffer->lock);
> -	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
> +	dma_unmap_sg_attrs(attachment->dev, table->sgl, table->nents, direction=
,
> +			   attachment->dma_map_attrs);
>  	a->dma_mapped =3D false;
>  	mutex_unlock(&buffer->lock);
>  }
> --=20
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,=20
> a Linux Foundation Collaborative Project
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
