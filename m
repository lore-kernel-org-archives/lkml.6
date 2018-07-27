Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E42DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3D52088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="lrOTK8cW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3D52088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeG0G1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:27:12 -0400
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:53952
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbeG0G1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 02:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFHTp5TSqQKUu//gJLbzQv/eCxEeK9xvIElzgd7FKu8=;
 b=lrOTK8cWKmvyqnVjTwotREOO8d1bHPGqFWiZBaxIs/pMBMvDuWLPAcPeks2ZqOEfGBPwM+kriSy4WmwO9haasAeC++nlG80mqeS8UnzOwvzO3OYOdvO1re1buP6hoUtwlFMrko946dxgTQNlKJL7L95FSZd02AKjrfXqASM/nkU=
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com (10.175.21.22) by
 VI1PR0502MB3631.eurprd05.prod.outlook.com (52.134.7.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Fri, 27 Jul 2018 05:03:10 +0000
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786]) by VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786%7]) with mapi id 15.20.0995.019; Fri, 27 Jul 2018
 05:03:10 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: linux-next: manual merge of the net-next tree with the rdma tree
Thread-Topic: linux-next: manual merge of the net-next tree with the rdma tree
Thread-Index: AQHUJVRUTB8GmjpwI0+ZUp6KP0x+UKSiaTKAgAAEpQCAABSUgA==
Date:   Fri, 27 Jul 2018 05:03:10 +0000
Message-ID: <VI1PR0502MB3008C7EE53D450B68FB212E3D12A0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180727123301.3ac97ddc@canb.auug.org.au>
        <20180727024832.GA30023@mellanox.com>
        <20180727132847.2be8563b@canb.auug.org.au>
 <20180727134524.366e9425@canb.auug.org.au>
In-Reply-To: <20180727134524.366e9425@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec80:6500:907e:1cf7:6ccd:3aee]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0502MB3631;6:6fTS9ysQC9Xt7K4bDRFpQ19NFTcbIwQNkLzO118Wl2r/j5mX5ns7cEHkRIAene/fv/6UFbanmWcL5MdetMKI6Ne404wAyqWdiuQ9KG+al9Z1Ss6z9N2O7zfsV79PCng/AEj7mxykfgGbPTab0PUdcRRT0O13C+4jt8ZT5U48XKpmUU+I9iBaABgrwnoyyBBwPeoq2PgCZGS6MvCsY+7ADF5wuA7Qua+BfyZdnMteNVtZEYqBzbvny4jO+oc9OBnsH35aH5ZpiYB3/2ZrcS1RYhtDy8w1iq3OgDxqfvyWDtEC8DqIk9poOHgjNgqiryovtdrt/gwT0jLXxgixEwpttk/5Tp6splZhYTA/OJcAu0snX2Dy1d/MEEC5VkOmRQks/0Jws683BRhfeJbnTctegSEtoDxbfnKir6JoAByTY+FOw4TMW7gC1+cRUSiP/hYiJ/mPNyHJSYGUICcp1mzh6Q==;5:Hodema4s6JtpT42ZANfgSLbaARrPDrk8NKVZA6yeA+sATX3yUs5G8n0TVfp72tiKvPSNQgm0F9ThJZi5YzYsMoyty/DIq7UPAok9D4SjOn7hrouwrdi++Aq6PYs2wsR2N8vMiyoPR1Xbk3hDd/DIKlYo/+XSo5rLcb6Tja0De4Q=;7:e375FkU8ic/3oYyWsaW2WmvNw1O1OiBeKuty655EXpFzVb+T7uUSgQZImW795AVJNhU7jzRVePAZUIPpOcoCx8WgwHGFGVdYUjcz1oaJ0HPGNgN6JpNOoGYNmRTV3oc5c2uejKUMN8ClJqYrpIW02VNm79ydADD/YjNQAoLC1zf2z2QEGJI94Ickv1HSMDoJBvutccdOj9uzUVAeJ8pniE/fdWqXXVt5+xTUusi4MUKbnpsZImCH7P2PsLZFAeCh
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3d0ac36d-c0ae-4454-e466-08d5f37e3fe8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB3631;
x-ms-traffictypediagnostic: VI1PR0502MB3631:
x-microsoft-antispam-prvs: <VI1PR0502MB363186C8A191042EF10C352ED12A0@VI1PR0502MB3631.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0502MB3631;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3631;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(366004)(39860400002)(53754006)(13464003)(189003)(199004)(46003)(11346002)(186003)(446003)(7696005)(256004)(102836004)(6116002)(86362001)(476003)(486006)(93886005)(97736004)(14454004)(33656002)(53936002)(81166006)(81156014)(8676002)(8936002)(478600001)(7736002)(305945005)(74316002)(6246003)(229853002)(4326008)(54906003)(110136005)(6636002)(2900100001)(25786009)(55016002)(6436002)(5660300001)(2906002)(6506007)(53546011)(5250100002)(68736007)(99286004)(9686003)(106356001)(76176011)(105586002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3631;H:VI1PR0502MB3008.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5Clwy++4X3krXM9j48JwVXNvZr2J/D7rZVDCvHme/BEOmPtExR1Yn8kEpGOWkctubkaAY/RNKdl0jfA31SRsnzLEzPAVXf7C/oEfrojBf+0VzxZuSbEJPVcXifxw748D6Ff6CVM8DuAnqgbvZskt66PR8BOz8JhpR+DwiyM0xrL3XaqHRGPGooTuKFb0jtTQEOp4XXrwTeOnVInLlyW2RZtv6lfBq9qCRjsfKaUzrPVPf/vqP++qy2L6kR4scBcWN8SIlDQ6wz6Vmm67Ns+s6lb0qkNFb4bCITBE85eL+am0U/FHqeUDsnFnOYQ+ISIq4R1ZgLNaam64DlhFG/zs7/Fs+/mlWbiWch4RfYXs534=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0ac36d-c0ae-4454-e466-08d5f37e3fe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 05:03:10.4457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-owner@vger.kernel.org>
> On Behalf Of Stephen Rothwell
> Sent: Thursday, July 26, 2018 10:45 PM
> To: Jason Gunthorpe <jgg@mellanox.com>
> Cc: David Miller <davem@davemloft.net>; Networking
> <netdev@vger.kernel.org>; Doug Ledford <dledford@redhat.com>; Linux-Next
> Mailing List <linux-next@vger.kernel.org>; Linux Kernel Mailing List <lin=
ux-
> kernel@vger.kernel.org>; Parav Pandit <parav@mellanox.com>; Ursula Braun
> <ubraun@linux.ibm.com>; Leon Romanovsky <leonro@mellanox.com>; linux-
> rdma@vger.kernel.org
> Subject: Re: linux-next: manual merge of the net-next tree with the rdma =
tree
>=20
> Hi all,
>=20
> On Fri, 27 Jul 2018 13:28:47 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
>
> wrote:
> >
> > I applied this merge fix patch:
>=20
> The final conflict resolution actually looks like this:
>=20
> (the rdma tree changes to net/smc/smc_core.c are dropped)
>=20
> c1d4bb2af93573ee4a21538a1a97b568a2344499
> diff --cc net/smc/smc_ib.c
> index 74f29f814ec1,2cc64bc8ae20..debc6e44f738
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@@ -144,6 -142,93 +143,95 @@@ out
>   	return rc;
>   }
>=20
> + static int smc_ib_fill_mac(struct smc_ib_device *smcibdev, u8 ibport)
> + {
>  -	struct ib_gid_attr gattr;
>  -	union ib_gid gid;
>  -	int rc;
> ++	const struct ib_gid_attr *gattr;
> ++	int rc =3D 0;
> +
>  -	rc =3D ib_query_gid(smcibdev->ibdev, ibport, 0, &gid, &gattr);
>  -	if (rc || !gattr.ndev)
>  -		return -ENODEV;
> ++	gattr =3D rdma_get_gid_attr(smcibdev->ibdev, ibport, 0);
> ++	if (IS_ERR(gattr))
> ++		return PTR_ERR(gattr);
> ++	if (!gattr->ndev) {
> ++		rc =3D -ENODEV;
> ++		goto done;
> ++	}
> +
>  -	memcpy(smcibdev->mac[ibport - 1], gattr.ndev->dev_addr, ETH_ALEN);
>  -	dev_put(gattr.ndev);
>  -	return 0;
> ++	memcpy(smcibdev->mac[ibport - 1], gattr->ndev->dev_addr,
> ETH_ALEN);
> ++done:
> ++	rdma_put_gid_attr(gattr);
> ++	return rc;
> + }
> +
> + /* Create an identifier unique for this instance of SMC-R.
> +  * The MAC-address of the first active registered IB device
> +  * plus a random 2-byte number is used to create this identifier.
> +  * This name is delivered to the peer during connection initialization.
> +  */
> + static inline void smc_ib_define_local_systemid(struct smc_ib_device
> *smcibdev,
> + 						u8 ibport)
> + {
> + 	memcpy(&local_systemid[2], &smcibdev->mac[ibport - 1],
> + 	       sizeof(smcibdev->mac[ibport - 1]));
> + 	get_random_bytes(&local_systemid[0], 2); }
> +
> + bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport) {
> + 	return smcibdev->pattr[ibport - 1].state =3D=3D IB_PORT_ACTIVE; }
> +
> + /* determine the gid for an ib-device port and vlan id */ int
> + smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
> + 			 unsigned short vlan_id, u8 gid[], u8 *sgid_index) {
>  -	struct ib_gid_attr gattr;
>  -	union ib_gid _gid;
> ++	const struct ib_gid_attr *gattr;
> + 	int i;
> +
> + 	for (i =3D 0; i < smcibdev->pattr[ibport - 1].gid_tbl_len; i++) {
>  -		memset(&_gid, 0, SMC_GID_SIZE);
>  -		memset(&gattr, 0, sizeof(gattr));
>  -		if (ib_query_gid(smcibdev->ibdev, ibport, i, &_gid, &gattr))
> ++		gattr =3D rdma_get_gid_attr(smcibdev->ibdev, ibport, i);
> ++		if (IS_ERR(gattr))
> + 			continue;
>  -		if (!gattr.ndev)
> ++		if (!gattr->ndev)
> + 			continue;
Seeing this updated patch, so for completeness same reply as the previous e=
mail.

If (!gattr->ndev) {
	rdma_put_gid_attr(gattr);
	continue;
}
Rest changes above and below looks fine to me.
Thanks for doing it, I am not part of netdev mailing list so didn't see the=
 compile error until this patch came up.

>  -		if (((!vlan_id && !is_vlan_dev(gattr.ndev)) ||
>  -		     (vlan_id && is_vlan_dev(gattr.ndev) &&
>  -		      vlan_dev_vlan_id(gattr.ndev) =3D=3D vlan_id)) &&
>  -		    gattr.gid_type =3D=3D IB_GID_TYPE_IB) {
> ++		if (((!vlan_id && !is_vlan_dev(gattr->ndev)) ||
> ++		     (vlan_id && is_vlan_dev(gattr->ndev) &&
> ++		      vlan_dev_vlan_id(gattr->ndev) =3D=3D vlan_id)) &&
> ++		    gattr->gid_type =3D=3D IB_GID_TYPE_IB) {
> + 			if (gid)
>  -				memcpy(gid, &_gid, SMC_GID_SIZE);
> ++				memcpy(gid, &gattr->gid, SMC_GID_SIZE);
> + 			if (sgid_index)
> + 				*sgid_index =3D i;
>  -			dev_put(gattr.ndev);
> ++			rdma_put_gid_attr(gattr);
> + 			return 0;
> + 		}
>  -		dev_put(gattr.ndev);
> ++		rdma_put_gid_attr(gattr);
> + 	}
> + 	return -ENODEV;
> + }
> +
> + static int smc_ib_remember_port_attr(struct smc_ib_device *smcibdev,
> + u8 ibport) {
> + 	int rc;
> +
> + 	memset(&smcibdev->pattr[ibport - 1], 0,
> + 	       sizeof(smcibdev->pattr[ibport - 1]));
> + 	rc =3D ib_query_port(smcibdev->ibdev, ibport,
> + 			   &smcibdev->pattr[ibport - 1]);
> + 	if (rc)
> + 		goto out;
> + 	/* the SMC protocol requires specification of the RoCE MAC address */
> + 	rc =3D smc_ib_fill_mac(smcibdev, ibport);
> + 	if (rc)
> + 		goto out;
> + 	if (!strncmp(local_systemid, SMC_LOCAL_SYSTEMID_RESET,
> + 		     sizeof(local_systemid)) &&
> + 	    smc_ib_port_active(smcibdev, ibport))
> + 		/* create unique system identifier */
> + 		smc_ib_define_local_systemid(smcibdev, ibport);
> + out:
> + 	return rc;
> + }
> +
>   /* process context wrapper for might_sleep smc_ib_remember_port_attr */
>   static void smc_ib_port_event_work(struct work_struct *work)
>   {
>=20
> --
> Cheers,
> Stephen Rothwell
