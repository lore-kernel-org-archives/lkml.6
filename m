Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D87C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24972082C
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="JBjnFYDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24972082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeI2JYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 05:24:05 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:16424
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727301AbeI2JYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 05:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR90a2AwwzHsaVUaVDAAf7vunJ1PrxoP2EKMgwvGyOU=;
 b=JBjnFYDEpW6K6Jmdw9CL1ZGjD4Hj3I6Xs9jZrP5nvi7Gw0X+uIZttclwT5W4UMuRA8rATF+kRj1nZrxebyaj7+4tMtZwbDUi5z0IuR31Am+80g60LfRG+J35dL5ANJhsqBIMJF/ew/OhxqRaI/KbhVNqOG2yL8gu0JIjnhzXmhc=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2368.eurprd05.prod.outlook.com (10.169.135.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Sat, 29 Sep 2018 02:57:21 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::e4c2:d0a4:ae7c:7d29]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::e4c2:d0a4:ae7c:7d29%9]) with mapi id 15.20.1164.024; Sat, 29 Sep 2018
 02:57:21 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: linux-next: manual merge of the rdma tree with Linus' tree
Thread-Topic: linux-next: manual merge of the rdma tree with Linus' tree
Thread-Index: AQHUV5yUxrLtp8uTDEe7CW9qj+S2AKUGjuFA
Date:   Sat, 29 Sep 2018 02:57:21 +0000
Message-ID: <VI1PR0501MB227163173354F5F3D7BE298CD1ED0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <20180928100125.61d3e9b6@canb.auug.org.au>
In-Reply-To: <20180928100125.61d3e9b6@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec80:6500:88be:6e8b:cf1e:aea4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2368;6:cQuv8fMRs5N5iOgf+zUTmLYtmg+lyLiYz1QuliMPBLXcoYA3ZeGRgiv8cOeT+KQecEvftzW7jYN7u0sA1qSZC1Sk3gw6OGxJ94v6LcuZsYBxTJBh6jwyUsqXIxhSwDgXS8Ekco8hu+XKOAcCtTp9ok39sIoMEizxXVEniAsBFyhs4RXNgyxOdtYuaezOXhgBmu+feA5owGH5ossPLvYDljSN4CMCbhX4179zA+N7azK5tf544FHnLFi37IJmTk6ZkYcnzNytGA8qMJmPJIUPZXRsU2niYw7cxKa8dJm7X76vIk2ronbXVb8Hm+Buf53EKE9R+oxHvTXsw/jAQX/KB8CDaEB14aXK9uCsFQdM5oFWXbsTA9c002zN+Rp/2UE6AfrsloYSRI+3JVaNG35d/PEnIC81DpORMtojCwHjfJhrg82A4LPxg5/C27fujjZ8UedyQY7Wiq6zGtMpjW2w3w==;5:+Xb+Xk/6pS9ydNCyN7DIorBMrzpdiCwRaOCm4n1+beA8SWyXmqeKzRLEIyEXSPWbNdcks6/c9RFNDWC5pHfgNQ3UMLz1a2cT3CRnJ6qMhQ/GVneGy2tiYMqDlJepnz0sFzsDBSsbSth7AAp8N1pEjpnAQtBiLbncyGFsXmENgFw=;7:yjkZ7A11ksSANqyINPsSYjkv7b3VDLseWOgw/qa2KmYVp7s+qBJ781iEvvwqmo4KMAONdJoaYiIgKtdh/ztBxyovLrL2858wo0NUW13dCOUKzBjtYU1cfuym342AQOTiDuBZJVoDSpozkH2OY//bciWLEEljZLq2wVzIHAegmkHxluvPLeplCHEuiNfAwnfdOp5cSKSuAOmYN67lm9KiAeomllm98M/aqnO8KLztwvUQj/ezKJdpAGeEqWe3yrny
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 52fae86f-22d6-4ede-6ef5-08d625b746b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2368;
x-ms-traffictypediagnostic: VI1PR0501MB2368:
x-microsoft-antispam-prvs: <VI1PR0501MB2368B2A3BD83EB3EB4DA5BACD1ED0@VI1PR0501MB2368.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:VI1PR0501MB2368;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2368;
x-forefront-prvs: 0810818DA0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(13464003)(53754006)(53546011)(6506007)(53936002)(33656002)(97736004)(102836004)(9686003)(6436002)(55016002)(478600001)(229853002)(316002)(2900100001)(6246003)(54906003)(6636002)(110136005)(4326008)(4006002)(5660300001)(74316002)(8676002)(6116002)(305945005)(7736002)(25786009)(106356001)(7696005)(99286004)(476003)(446003)(11346002)(486006)(105586002)(46003)(76176011)(14444005)(256004)(2906002)(68736007)(8936002)(81166006)(34290500001)(186003)(71200400001)(81156014)(86362001)(14454004)(5250100002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2368;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8u5DxG61UnMtn+9TtCV1OqrXnuqRk6i0FH5TkDXZn4vx08YR3bTqVPd4GILNDk51zgScwizxl41AoVzue1DKBTnAmApOQk+f3Wg8w1LwsbDyRUKgjST2VYnlzmzXKqivCPB4+fkwTuHdVSYU3vJAnJmALkWgOl/MMrKcUIQEkDN68VFxZI+/lEejK/U753j2E+kaORN9d3jkj0Wam0idNdmah+AcGa5GDbn8Hf70OWXPY7RVh55eIu/Ziw4X1DInnqPTTSxOVhrbCSyYLVKwUP/sd5/gsz4c1kGwqUp2zd3ePjc/U257CSJFOjgBCIGQ2o9HoHFh/Bh3QNk4Rf4vfKBdSxy27ebr5txI8pF0KjE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fae86f-22d6-4ede-6ef5-08d625b746b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2018 02:57:21.3530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Thursday, September 27, 2018 7:01 PM
> To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe
> <jgg@mellanox.com>
> Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel
> Mailing List <linux-kernel@vger.kernel.org>; Parav Pandit
> <parav@mellanox.com>
> Subject: linux-next: manual merge of the rdma tree with Linus' tree
>=20
> Hi all,
>=20
> Today's linux-next merge of the rdma tree got a conflict in:
>=20
>   drivers/infiniband/core/cache.c
>=20
> between commit:
>=20
>   5c5702e259dc ("RDMA/core: Set right entry state before releasing
> reference")
>=20
> from Linus' tree and commit:
>=20
>   43c7c851b9bc ("RDMA/core: Use dev_err/dbg/etc instead of pr_* + ibdev-
> >name")
>=20
> from the rdma tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This is now=
 fixed
> as far as linux-next is concerned, but any non trivial conflicts should b=
e
> mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer o=
f
> the conflicting tree to minimise any particularly complex conflicts.
>=20

Sorry for the late reply. For some reason mail ended up in spam folder whic=
h I noticed now.
I should have watched the device naming series.
My fix went to for-rc and I guess it wasn't applied to for-next which resul=
ted into this merge conflict.
My understanding is, maintainers usually try to avoid merge conflict betwee=
n for-next and for-rc branches before sending pull request from rdma tree.
I will try to be more careful in future to notify maintainer about it.

Your changes below looks good. Thanks.
Reviewed-by: Parav Pandit <parav@mellanox.com>=20
> --
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/infiniband/core/cache.c index
> 3208ad6ad540,ebc64418d809..000000000000
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@@ -337,39 -335,6 +335,38 @@@ static int add_roce_gid(struct ib_gid_t
>   	return 0;
>   }
>=20
>  +/**
>  + * del_gid - Delete GID table entry
>  + *
>  + * @ib_dev:	IB device whose GID entry to be deleted
>  + * @port:	Port number of the IB device
>  + * @table:	GID table of the IB device for a port
>  + * @ix:		GID entry index to delete
>  + *
>  + */
>  +static void del_gid(struct ib_device *ib_dev, u8 port,
>  +		    struct ib_gid_table *table, int ix)
>  +{
>  +	struct ib_gid_table_entry *entry;
>  +
>  +	lockdep_assert_held(&table->lock);
>  +
> - 	pr_debug("%s device=3D%s port=3D%d index=3D%d gid %pI6\n", __func__,
> - 		 ib_dev->name, port, ix,
> - 		 table->data_vec[ix]->attr.gid.raw);
> ++	dev_dbg(&ib_dev->dev, "%s port=3D%d index=3D%d gid %pI6\n",
>__func__, port,
> ++		ix, table->data_vec[ix]->attr.gid.raw);
>  +
>  +	write_lock_irq(&table->rwlock);
>  +	entry =3D table->data_vec[ix];
>  +	entry->state =3D GID_TABLE_ENTRY_PENDING_DEL;
>  +	/*
>  +	 * For non RoCE protocol, GID entry slot is ready to use.
>  +	 */
>  +	if (!rdma_protocol_roce(ib_dev, port))
>  +		table->data_vec[ix] =3D NULL;
>  +	write_unlock_irq(&table->rwlock);
>  +
>  +	put_gid_entry_locked(entry);
>  +}
>  +
>   /**
>    * add_modify_gid - Add or modify GID table entry
>    *
