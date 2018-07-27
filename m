Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05855C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9265220842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="BOXQkYOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9265220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbeG0GRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:17:52 -0400
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:42528
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbeG0GRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 02:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGKLV8SFpHJpz/RRcgdxda7MgMzEEvg2pt3xkpFG3sA=;
 b=BOXQkYOa/lvcTG04xFStWr8dd3r7cAGC7XEGUMGkwnPDwJKxVM28fXHgErAqc4jnrmyeEoPSPb/ice6a5T9QKsg36xM94/ug/5mu3ISi1vADJvDzZ0WL/1LvMEePT37xBRKJeW4TgopXxiLBB1EtOZBnu0re8j60iFebjWlpJYE=
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com (10.175.21.22) by
 VI1PR0502MB3631.eurprd05.prod.outlook.com (52.134.7.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Fri, 27 Jul 2018 04:57:42 +0000
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786]) by VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786%7]) with mapi id 15.20.0995.019; Fri, 27 Jul 2018
 04:57:42 +0000
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
Thread-Index: AQHUJVRUTB8GmjpwI0+ZUp6KP0x+UKSiaTKAgAAYRAA=
Date:   Fri, 27 Jul 2018 04:57:41 +0000
Message-ID: <VI1PR0502MB3008702AFA64F44DE57DC9F5D12A0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180727123301.3ac97ddc@canb.auug.org.au>
        <20180727024832.GA30023@mellanox.com>
 <20180727132847.2be8563b@canb.auug.org.au>
In-Reply-To: <20180727132847.2be8563b@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec80:6500:907e:1cf7:6ccd:3aee]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0502MB3631;6:kcECNAEUVGMdNEqUkncI6EoKpEaJLp9Mm0eJFU3Aaa4MdZm0TGHjmEhEyAicebvmXlCpSNoiliVrmW5X6R6v5QvslIyo123DnB/2Yp2mGFA9z+FUkPb9yr/WfZ62hXB+dECX8cSX5rgMRoQ0fZWUQbpY0iRUvyGX3U/DjrlUZoLjoOoaNztoH20Pivs7lMm8IGzlSyldKO0l6WizPgjXJbBn0WlwrBbGrRbaqJSgw+ab/K7qOfoieoIc24C988YdjvkhMsa4WR9vUZFuAJu0AMWYssxl7CXnkiwCb+r0VCHcCIlYaPbWiLqV3XUfPpV6MUCH4bcwQfy162MXrGv8hDCntOxrwJMl7pVuPMG5GzBQZRcwCLZz465dKlDVKSIl4SY+WUn1QYFS9yvab4Rigrt5Co7zFXrnjNig5un01Ogf/xGbJpTm5N+D7qGoyZMXHB2nfW8MArn+l9VIBdnD1w==;5:v+bKf72bN7oOx5FQtlyDQzUXtRRsq+yR/TByE5qaDjI4PRx0e71jXkC2KYxBT/lB6JpuQ3GoDxXoBPtEOCFHXekDvMH4vVrjjeJOWk4GwwUKOO0dJDUqEJbmU8iaFsZeIH2yHo5bI+i8dG4G3Fjk0GOGg5HM493RpH5fJLEefc4=;7:WbIWGxl4F2fzjqcAHc9Gt79YdcJyX3KSHf2w5dmblgKWDuhnU3X5iJwVaLl+3vFPcB2lNOxzpbnr2aTtlvYYGTyp//X9sqfbkutNySOO4q9PndjR0paI/MlcVAz51HPeqJJ0DQ/BybPd5rOYTga5J5/U4Id4lqEPCrBhmVwmEYh0XB6hKYnKHAGCSK5aL5Z5IQgs4D8gHNPZor01uHfHMGEOczXSJR3ot9D2lDZuqdYCbPErKKLgi2kL/aYmKorV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 321fdc51-11e6-4bd8-355f-08d5f37d7c10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB3631;
x-ms-traffictypediagnostic: VI1PR0502MB3631:
x-microsoft-antispam-prvs: <VI1PR0502MB36318E03EFAE53DD216FCEFED12A0@VI1PR0502MB3631.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0502MB3631;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3631;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(366004)(39860400002)(13464003)(189003)(199004)(46003)(11346002)(186003)(446003)(7696005)(256004)(102836004)(6116002)(86362001)(476003)(486006)(97736004)(14454004)(33656002)(53936002)(81166006)(81156014)(8676002)(8936002)(478600001)(7736002)(305945005)(74316002)(6246003)(229853002)(4326008)(54906003)(110136005)(6636002)(2900100001)(25786009)(55016002)(6436002)(5660300001)(2906002)(6506007)(53546011)(5250100002)(68736007)(99286004)(9686003)(106356001)(76176011)(105586002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3631;H:VI1PR0502MB3008.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bmeN25sK0aeVRhP96hgIuqP8A+/YZmlf823cuWhLGzt6GrDAiplQ/lE1nedgPi22SDsuvvNYemIEAXHkEtpGZw3f+/iJ3zV34Nv5UjNwfYAUmNuVRCgsgDF55J7OHSoBfZ9HmeSTLrTVqefdoEP98SahxlZUVl/kHueIrbOb8NASYAmLP5D31v/izQnKXdZhVv4BtG46dt368+L8LGbT8i0FM7k9joxvJ6Lfvr82iFXT+ONtKsJzKkTEqoQ5ISs6SY20CLvq2s644IIWtBgJqmY8TNviUdlc+KGEgrU3SYfcrfeDcLu5lWk2kJx7VbSmuwMCiJW5CZAw+u/hn2RTp8YB1CslIa6wxfK9grsWPtY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321fdc51-11e6-4bd8-355f-08d5f37d7c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 04:57:41.9350
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
> Sent: Thursday, July 26, 2018 10:29 PM
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
> Hi Jason,
>=20
> On Thu, 26 Jul 2018 20:48:32 -0600 Jason Gunthorpe <jgg@mellanox.com>
> wrote:
> >
> > On Fri, Jul 27, 2018 at 12:33:01PM +1000, Stephen Rothwell wrote:
> >
> > > I fixed it up (I wasn't sure how to fix this up as so much has
> > > changed in the net-next tree and both modified functions had been
> > > (re)moved, so I effectively reverted the rdma tree commit) and can
> > > carry the fix as necessary.  Please come to some arrangement about th=
is.
> >
> > How does that still compile? We removed ib_query_gid() from the rdma
> > tree and replaced it with rdma_get_gid_attr()..
>=20
> Yeah, it doesn't :-(
>=20
> > I think the merge resolution is going to be a bit nasty to absorb that
> > much changing..
> >
> > Perhaps we should add a compatability ib_query_gid back to the RDMA
> > tree and then send DaveM a commit to fix SMC and remove it during the
> > next cycle? Linus can resolve smc_ib.c by using the net version
> >
> > Does someone else have a better idea?
>=20
> I applied this merge fix patch:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 27 Jul 2018 13:19:31 +1000
> Subject: [PATCH] net/smc: fixups for ip_query_gid API removal
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  net/smc/smc_ib.c | 47 +++++++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 22 deletions(-)
>=20
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c index
> 2cc64bc8ae20..debc6e44f738 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -16,6 +16,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/scatterlist.h>
>  #include <rdma/ib_verbs.h>
> +#include <rdma/ib_cache.h>
>=20
>  #include "smc_pnet.h"
>  #include "smc_ib.h"
> @@ -144,17 +145,21 @@ int smc_ib_ready_link(struct smc_link *lnk)
>=20
>  static int smc_ib_fill_mac(struct smc_ib_device *smcibdev, u8 ibport)  {
> -	struct ib_gid_attr gattr;
> -	union ib_gid gid;
> -	int rc;
> +	const struct ib_gid_attr *gattr;
> +	int rc =3D 0;
>=20
> -	rc =3D ib_query_gid(smcibdev->ibdev, ibport, 0, &gid, &gattr);
> -	if (rc || !gattr.ndev)
> -		return -ENODEV;
> +	gattr =3D rdma_get_gid_attr(smcibdev->ibdev, ibport, 0);
> +	if (IS_ERR(gattr))
> +		return PTR_ERR(gattr);
> +	if (!gattr->ndev) {
> +		rc =3D -ENODEV;
> +		goto done;
> +	}
>=20
> -	memcpy(smcibdev->mac[ibport - 1], gattr.ndev->dev_addr, ETH_ALEN);
> -	dev_put(gattr.ndev);
> -	return 0;
> +	memcpy(smcibdev->mac[ibport - 1], gattr->ndev->dev_addr,
> ETH_ALEN);
> +done:
> +	rdma_put_gid_attr(gattr);
> +	return rc;
>  }
>=20
>  /* Create an identifier unique for this instance of SMC-R.
> @@ -179,29 +184,27 @@ bool smc_ib_port_active(struct smc_ib_device
> *smcibdev, u8 ibport)  int smc_ib_determine_gid(struct smc_ib_device
> *smcibdev, u8 ibport,
>  			 unsigned short vlan_id, u8 gid[], u8 *sgid_index)  {
> -	struct ib_gid_attr gattr;
> -	union ib_gid _gid;
> +	const struct ib_gid_attr *gattr;
>  	int i;
>=20
>  	for (i =3D 0; i < smcibdev->pattr[ibport - 1].gid_tbl_len; i++) {
> -		memset(&_gid, 0, SMC_GID_SIZE);
> -		memset(&gattr, 0, sizeof(gattr));
> -		if (ib_query_gid(smcibdev->ibdev, ibport, i, &_gid, &gattr))
> +		gattr =3D rdma_get_gid_attr(smcibdev->ibdev, ibport, i);
> +		if (IS_ERR(gattr))
>  			continue;
> -		if (!gattr.ndev)
> +		if (!gattr->ndev)
>  			continue;
This requires a small fix.
If (!gattr->ndev {
	rdma_put_gid_attr(gattr);
	continue;
}


> -		if (((!vlan_id && !is_vlan_dev(gattr.ndev)) ||
> -		     (vlan_id && is_vlan_dev(gattr.ndev) &&
> -		      vlan_dev_vlan_id(gattr.ndev) =3D=3D vlan_id)) &&
> -		    gattr.gid_type =3D=3D IB_GID_TYPE_IB) {
> +		if (((!vlan_id && !is_vlan_dev(gattr->ndev)) ||
> +		     (vlan_id && is_vlan_dev(gattr->ndev) &&
> +		      vlan_dev_vlan_id(gattr->ndev) =3D=3D vlan_id)) &&
> +		    gattr->gid_type =3D=3D IB_GID_TYPE_IB) {
>  			if (gid)
> -				memcpy(gid, &_gid, SMC_GID_SIZE);
> +				memcpy(gid, &gattr->gid, SMC_GID_SIZE);
>  			if (sgid_index)
>  				*sgid_index =3D i;
> -			dev_put(gattr.ndev);
> +			rdma_put_gid_attr(gattr);
>  			return 0;
>  		}
> -		dev_put(gattr.ndev);
> +		rdma_put_gid_attr(gattr);
>  	}
>  	return -ENODEV;
>  }
> --
> 2.18.0
>=20
> --
> Cheers,
> Stephen Rothwell
