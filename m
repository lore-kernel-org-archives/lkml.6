Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C168C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C61B208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="eYVQSrxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C61B208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbeG0R1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:27:49 -0400
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:27443
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388156AbeG0R1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3EHuJ7v5QjK/Je6kJBYQ6rzLUzCF4xrKA6PMPqWBKY=;
 b=eYVQSrxvJybjqYT5XHE+pTfF4GaQkI1FuSg4sLm+wvEjdNgxrcNmrVqQ//8pjWw7emHRzHFwNR8RkLy04QvNLZTkUchw8GaL7VkUYvfZu0dKJ8NSVT/zcr9mIZuJlttKRWtXVY59RaX9cWPGH4Yhm/sq8GGQtSU4Kqo+iCe6/p8=
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com (10.175.21.22) by
 VI1PR0502MB3680.eurprd05.prod.outlook.com (52.134.8.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Fri, 27 Jul 2018 16:04:33 +0000
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786]) by VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786%7]) with mapi id 15.20.0995.019; Fri, 27 Jul 2018
 16:04:33 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma] IB/cache: Restore compatibility for ib_query_gid
Thread-Topic: [PATCH rdma] IB/cache: Restore compatibility for ib_query_gid
Thread-Index: AQHUJcIPCAEQUI0qvk+qMYqSwf1nDqSjOscA
Date:   Fri, 27 Jul 2018 16:04:33 +0000
Message-ID: <VI1PR0502MB3008B0D78AB418E263819EE7D12A0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180727155402.GA15253@ziepe.ca>
In-Reply-To: <20180727155402.GA15253@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0502MB3680;6:w3RJAP3UffDrZOcBmqpEJ3B9/tRx4t8JlsVLhx+Gl9T6tL2Qla55ki/0ZqHsGqfvBYX4j2ihrATUTq5SK8WKbL+xg/Ge2IL5IPbSrJtvkX884/KlJx9EatdVWqIW2x5Rc1G5BO49utggv4sC6daT4uzIFPil1uUDHv3e3ytQEgCGpvopSFCjzjNLVCByB7b/qE7O5Q94mehjoOGK0y5mvBA94FiGSPvHaNCRcnQdqZXA6y58ioqgylvuKw3WsD2R2dBWnDtPGU1uu2womJdpZvcNO6w0mTCv51gGZih/ngjEIK7gZ1r8bY/A9FnTzHmwFYkfm1ZgkFFy1HDmd6qOvph9JjxS0jHbOG3M9wYr34qkiR2gznN61pz39meR5wcArmmPmKp0Y24S9oou26MRsQaiaX2Fs8Eeg2qHKGhUI/PVcTZhsJSjjTLfaljLrJL5jlHU73ZEDzDy0w3rIiMNsw==;5:XRvh9IgsFWyoCx4wAKxB+JteI2s/vcjxcZQONFVDPAgLOj2lBDcyV32ZBWti4hzrzfD/OpfY0WkryCyqHi6dMTMLUHYA/zX/zMAM7A8w14n307isGQ4n/hQtD9N3TM7Qr4WqRBobatESE4FzlrWhq5Cd1rLPqjL1aut7k7THT0w=;7:HZqWGFvxuBP0xkecx5lOxI+biVorQN0gymRwxH9hj6xy9CSmZU3EDuIypZoO0LSuMQjHNGb73qO2CA3boUIcAAgpYdctvMEJXoYaSHo/Xo5uX/U0E20Hfi2Uq3fcAUfI74lmm39HaAcuGP/FOQMyklN/Fj6cZWfo2tOraaJGchaPN9k/WqAEGXs5EtCu7UXG9cVJ4klU8u21HcdIGxJDyq2+gXMMX7y7K63p2T8UmLyswc1aywCOGkNQecUWIIYs
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 56e39976-0297-480b-5975-08d5f3daa48e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB3680;
x-ms-traffictypediagnostic: VI1PR0502MB3680:
x-microsoft-antispam-prvs: <VI1PR0502MB36800ED6D4BE465B59328B6BD12A0@VI1PR0502MB3680.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(84791874153150)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0502MB3680;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3680;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(13464003)(6246003)(14444005)(5660300001)(7696005)(11346002)(446003)(53546011)(66066001)(53936002)(55016002)(105586002)(106356001)(256004)(9686003)(6306002)(6436002)(7736002)(6506007)(110136005)(2906002)(99286004)(54906003)(26005)(6116002)(3846002)(2900100001)(86362001)(486006)(476003)(305945005)(14454004)(229853002)(76176011)(316002)(5250100002)(2501003)(966005)(74316002)(478600001)(68736007)(97736004)(25786009)(102836004)(4326008)(33656002)(81156014)(81166006)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3680;H:VI1PR0502MB3008.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q1IjgrylWIJ19yjIP2QIThJMecCWvRsVLc+JDtOfv+rfP+oGExhuaAYc7xCAsi42hpOR5TIc2jqYqZlRNLbSBjJPxPRC1sWt9XDVudsKAROv/6Qo+myANCjL6AeLhxf5lQ/C5KTJOOlHXH0KVornRQ0kI9Q1VsgNzY6FHsBhs6m/NfV3BTu8iJYvt07HusQGQVZSUbEHKS7MeWzWZAOVFGgorZQfvBuseKEmF1HIvtV7lIsm4HC+qZHUDH8T33//5PHraqS8niL/n5dN+frCH+6E9FHc/m5760ghtg4cJoQjBFfFx4y7G5/28UFueXru7FBXbc2DbXhuu2Ga8Df8TPIu7vUp/PbDqiibhchVF2k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e39976-0297-480b-5975-08d5f3daa48e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 16:04:33.0854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe
> Sent: Friday, July 27, 2018 10:54 AM
> To: linux-rdma@vger.kernel.org; Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: David Miller <davem@davemloft.net>; Networking
> <netdev@vger.kernel.org>; Doug Ledford <dledford@redhat.com>; Linux-Next
> Mailing List <linux-next@vger.kernel.org>; Linux Kernel Mailing List <lin=
ux-
> kernel@vger.kernel.org>; Parav Pandit <parav@mellanox.com>; Ursula Braun
> <ubraun@linux.ibm.com>; Leon Romanovsky <leonro@mellanox.com>; linux-
> rdma@vger.kernel.org
> Subject: [PATCH rdma] IB/cache: Restore compatibility for ib_query_gid
>=20
> Code changes in smc have become so complicated this cycle that the RDMA
> patches to remove ib_query_gid in smc create too complex merge conflicts.
> Allow those conflicts to be resolved by using the net/smc hunks by provid=
ing a
> compatibility wrapper. During the second phase of the merge window this
> wrapper will be deleted and smc updated to use the new API.
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  include/rdma/ib_cache.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> The resolution Stephen had to make is too complicated, I think we should =
go this
> way instead. Parav can send a patch to DaveM during the 2nd half of the m=
erge
> window to safely update SMC and delete this wrapper.
>=20
Last night Stephen send the changes, if Ursula can test it, its preferred b=
ut if that is not possible,=20
I am with below approach too.

> Parav, can you check this?
>=20
> Ursula, this is only for SMC, are you able to test SMC with it? You will =
need to
> apply it to the RDMA tree here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=3Dfo=
r-next
>=20
> Thanks,
> Jason
>=20
> diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h index
> 1108d422027696..c7e9b42b96e5b8 100644
> --- a/include/rdma/ib_cache.h
> +++ b/include/rdma/ib_cache.h
> @@ -132,4 +132,28 @@ const struct ib_gid_attr *rdma_get_gid_attr(struct
> ib_device *device,
>  					    u8 port_num, int index);
>  void rdma_put_gid_attr(const struct ib_gid_attr *attr);  void
> rdma_hold_gid_attr(const struct ib_gid_attr *attr);
> +
> +/*
> + * This is to be removed. It only exists to make merging rdma and smc si=
mpler.
> + */
> +static inline __deprecated int ib_query_gid(struct ib_device *device,
> +					    u8 port_num, int index,
> +					    union ib_gid *gid,
> +					    struct ib_gid_attr *attr_out)
> +{
> +	const struct ib_gid_attr *attr;
> +
> +	attr =3D rdma_get_gid_attr(device,port_num,index);
White space after each variable is needed to avoid warnings.

> +	if (IS_ERR(attr))
> +		return PTR_ERR(attr);
> +
> +	if (attr->ndev)
> +		dev_hold(attr->ndev);
> +	*attr_out =3D *attr;
> +
> +	rdma_put_gid_attr(attr);
> +
> +	return 0;
> +}
> +
>  #endif /* _IB_CACHE_H */

Rest looks fine.
RB: parav@mellanox.com
