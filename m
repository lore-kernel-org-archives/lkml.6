Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0511DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C27206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="uIiUuimy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfBWKdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:33:53 -0500
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:43769
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfBWKdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJdUX5TVkw2YUqFe6Nabrlkt7RTF8zxyqMMO3IV+3H8=;
 b=uIiUuimyAKCDSQb+kEFdn4QUjkw0d7md9nlTH1qwHCMAKVQLHrNxjmH7wzyGMMaWzX+KqwPXQd7NHAyf5TOes39znUXhO5Zbn37uAOCZUqmiUgyslwQkOaBp3/+jFN/KthHgtHhM0a2UPgef3TlGLGQv2Doq7A6sK6Se1shfIDo=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB4392.eurprd05.prod.outlook.com (52.135.164.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Sat, 23 Feb 2019 10:33:48 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1643.014; Sat, 23 Feb 2019
 10:33:48 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>
Subject: Re: [PATCH net-next 1/8] switchdev: Add SWITCHDEV_PORT_ATTR_SET
Thread-Topic: [PATCH net-next 1/8] switchdev: Add SWITCHDEV_PORT_ATTR_SET
Thread-Index: AQHUywrMZ8R9SsxL80GeRl7GH2mZyaXtMFoA
Date:   Sat, 23 Feb 2019 10:33:48 +0000
Message-ID: <20190223103330.GB13070@splinter>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
 <20190222235927.10295-2-f.fainelli@gmail.com>
In-Reply-To: <20190222235927.10295-2-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0601CA0026.eurprd06.prod.outlook.com
 (2603:10a6:203:68::12) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [79.176.7.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41130a83-b74d-4c4f-42ea-08d6997a651b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4392;
x-ms-traffictypediagnostic: AM6PR05MB4392:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB4392;23:+q6E+SdzDL3fUDlr4evTpfCT4rFY1huVE+mBVahER?=
 =?us-ascii?Q?ZTWodWmjN/F0fKRCTdUOWjHrFppj+SWTrOwZgWkSheLgwZuOZ4viFKxQAfo9?=
 =?us-ascii?Q?SBPUnTLrp6h846JWAGMEabPqaYhkmsJ7E70dCdbnagbO3vT/GFSejV0EWZ84?=
 =?us-ascii?Q?zP8MGRxJNgBAizRQTtI7Dm8BEhtsIqAasA1DUQ1fsNm5/QolodTuv5uSzizU?=
 =?us-ascii?Q?XgeaKuOsQVKj89DDGEHBeCRQe9PqzVHVKrLGst+0zQRmjLoTskEu8irpo2LD?=
 =?us-ascii?Q?MmatNQEfp4xcll1D49kKxqA1QPD6ARJdc/Tu+ifDuQ8/R4zGn60K9ri2fRx1?=
 =?us-ascii?Q?/1mcWp51woIXiXzDmuVuZpJnKEsfYDeyieQwnSpGC5YyUsFI6ECIHBY9lewK?=
 =?us-ascii?Q?JQ6ydfVs4noFdZCBTXVAHOmFjrrC2TRhedkUhtX/q19q1iQuwzXX86yTfuqK?=
 =?us-ascii?Q?tBDvZ2wSS+6gWdEDFM2CFKjKLdEdA9kdzDmZFJjljuGWABEJGvzy7QRtzk5I?=
 =?us-ascii?Q?xkQovxEm10s4gz5LbQIJdqaJjvd8f+XRm/hqrNlzsAtR1Nk8Bp44yK0k8qpi?=
 =?us-ascii?Q?yt30Pv6iF2T5FBUCRNgF+nv+fxoPkVVe4A3q4irPRDkFIXjdZUmc/wfoWQqb?=
 =?us-ascii?Q?jDnZpV8BTrTPJ5Gb7QK+iQJnXWZa877h15ZnRzNdKTdi/bGcAy0o55o6kkAJ?=
 =?us-ascii?Q?gmGDpanuqsIV9V09eFb2BROMHIDc+Amxjb0WL3PTVr/HZISyfETI/Hy0IlBQ?=
 =?us-ascii?Q?JAS86lhsgtjfYu9npHczSQd7jIRXNqR6yQS8Uhrv841YqhKBIWqgdIvdZMw2?=
 =?us-ascii?Q?4ss9YorPET40nNIazeBoV2opcIJL/EC79tpAYVmsw0d2Hi42nxkA4e3WqrK6?=
 =?us-ascii?Q?JYPLD/FgC5bl7bep42vQyn9yjeH9OxUYzckP+VwX5+23u4lq1W8MnZih9ft9?=
 =?us-ascii?Q?m0Wu4sEg5Vq7Bzz+18MdGpAcnMCuUu6b/QgXdlp6kSek+wKgCm5X38zpbuJJ?=
 =?us-ascii?Q?BEVIcnsAQK7tsPlO0TkkguuSqPnmSspx1WvM8EP0tooiXFmjyzWxsoWqRMJV?=
 =?us-ascii?Q?AdmZv+gg5Sa+W3fzodyYwItRTwKzS396tZ0/iPaY7KcqzdYML4tvbz3Nvoun?=
 =?us-ascii?Q?nDm6NLeNA3RG5YyRqUwpkphkpQNHc94QJ+7wx8wC9iPAY7amTrNdLZwo5yim?=
 =?us-ascii?Q?VQRGoMqhpAcyNMglkpYhCL9k9L4afRGszrsZ3EnnAO2OeRoOeyH5RtVTf5r8?=
 =?us-ascii?Q?J5aRR0xTb61iqJ/Im1fDtBXMNU2lu6opZc4pWngkM1+lYDwwPd0HX1VL9Hou?=
 =?us-ascii?B?dz09?=
x-microsoft-antispam-prvs: <AM6PR05MB4392C6F909BFD8F8298BFEA0BF780@AM6PR05MB4392.eurprd05.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(76176011)(25786009)(316002)(99286004)(4326008)(81166006)(8676002)(66066001)(5660300002)(2906002)(486006)(8936002)(81156014)(86362001)(53936002)(6436002)(6486002)(9686003)(14454004)(6512007)(54906003)(14444005)(256004)(229853002)(52116002)(6246003)(478600001)(305945005)(33656002)(476003)(6506007)(386003)(97736004)(102836004)(33716001)(186003)(1076003)(26005)(6916009)(3846002)(7736002)(6116002)(68736007)(71200400001)(71190400001)(106356001)(446003)(11346002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4392;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I/0vQm4VUdyy+JHm+532JfrY3FBOf8ZMDt5jg104IVz/5p2HOBAxKDhY4V1dKlCUxSwLGIuFQrTDQJQ4bWqy7ijmVWJBsJkPFMkVxqJj28XHt6Joxgc+Xs/g55KeCEBZr5MS4xob41/WgU4ivGsXF8+LR2Mhp+q3Vx3mkK/Y+enQSB9cjU6E+x+BIZZIL1qiKw2H4rqP+rsiCHRSRQf/XfOswqNEiAzG0XLACD7lzYUA8at1/SfNTqMcsGowgO1EruvcFdv2Qs47Ouasz1TljI8JJBgiJMVwkNAVpqleUHQB+OkWd1qjBpqa8s6VWI3BxKFo2PxnWhyVmFc1XhIMIiMjKK6xYq2zpv8on5UUmwFx9JRFxnDIr2+TyKuAs4OzcnQC7tLaCv0O3zo4quRAezubh2AocTDafqAbEhv7i00=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2D13F15B9E02A449ED35A1516F3DD1D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41130a83-b74d-4c4f-42ea-08d6997a651b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 10:33:47.7476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 03:59:19PM -0800, Florian Fainelli wrote:
> In preparation for allowing switchdev enabled drivers to veto specific
> attribute settings from within the context of the caller, introduce a
> new switchdev notifier type for port attributes.
>=20
> Suggested-by: Ido Schimmel <idosch@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  include/net/switchdev.h   | 27 +++++++++++++++++++++
>  net/switchdev/switchdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>=20
> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index 45310ddf2d7e..ca56b7487540 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -136,6 +136,7 @@ enum switchdev_notifier_type {
> =20
>  	SWITCHDEV_PORT_OBJ_ADD, /* Blocking. */
>  	SWITCHDEV_PORT_OBJ_DEL, /* Blocking. */
> +	SWITCHDEV_PORT_ATTR_SET, /* May be blocking . */

See my comment on 7/8. IIUC, this is always blocking, so comment needs to
be changed.

> =20
>  	SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE,
>  	SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE,
> @@ -164,6 +165,13 @@ struct switchdev_notifier_port_obj_info {
>  	bool handled;
>  };
> =20
> +struct switchdev_notifier_port_attr_info {
> +	struct switchdev_notifier_info info; /* must be first */
> +	const struct switchdev_attr *attr;
> +	struct switchdev_trans *trans;
> +	bool handled;
> +};
> +
>  static inline struct net_device *
>  switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *inf=
o)
>  {
> @@ -216,7 +224,15 @@ int switchdev_handle_port_obj_del(struct net_device =
*dev,
>  			int (*del_cb)(struct net_device *dev,
>  				      const struct switchdev_obj *obj));
> =20
> +int switchdev_handle_port_attr_set(struct net_device *dev,
> +			struct switchdev_notifier_port_attr_info *port_attr_info,
> +			bool (*check_cb)(const struct net_device *dev),
> +			int (*set_cb)(struct net_device *dev,
> +				      const struct switchdev_attr *attr,
> +				      struct switchdev_trans *trans));
> +
>  #define SWITCHDEV_SET_OPS(netdev, ops) ((netdev)->switchdev_ops =3D (ops=
))
> +
>  #else
> =20
>  static inline void switchdev_deferred_process(void)
> @@ -303,6 +319,17 @@ switchdev_handle_port_obj_del(struct net_device *dev=
,
>  	return 0;
>  }
> =20
> +static inline int
> +switchdev_handle_port_attr_set(struct net_device *dev,
> +			struct switchdev_notifier_port_attr_info *port_attr_info,
> +			bool (*check_cb)(const struct net_device *dev),
> +			int (*set_cb)(struct net_device *dev,
> +				      const struct switchdev_attr *attr,
> +				      struct switchdev_trans *trans))
> +{
> +	return 0;
> +}
> +
>  #define SWITCHDEV_SET_OPS(netdev, ops) do {} while (0)
> =20
>  #endif
> diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
> index 7e1357db33d7..94400f5b8e07 100644
> --- a/net/switchdev/switchdev.c
> +++ b/net/switchdev/switchdev.c
> @@ -697,3 +697,54 @@ int switchdev_handle_port_obj_del(struct net_device =
*dev,
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(switchdev_handle_port_obj_del);
> +
> +static int __switchdev_handle_port_attr_set(struct net_device *dev,
> +			struct switchdev_notifier_port_attr_info *port_attr_info,
> +			bool (*check_cb)(const struct net_device *dev),
> +			int (*set_cb)(struct net_device *dev,
> +				      const struct switchdev_attr *attr,
> +				      struct switchdev_trans *trans))
> +{
> +	struct net_device *lower_dev;
> +	struct list_head *iter;
> +	int err =3D -EOPNOTSUPP;
> +
> +	if (check_cb(dev)) {
> +		port_attr_info->handled =3D true;
> +		return set_cb(dev, port_attr_info->attr,
> +			      port_attr_info->trans);
> +	}
> +
> +	/* Switch ports might be stacked under e.g. a LAG. Ignore the
> +	 * unsupported devices, another driver might be able to handle them. Bu=
t
> +	 * propagate to the callers any hard errors.
> +	 *
> +	 * If the driver does its own bookkeeping of stacked ports, it's not
> +	 * necessary to go through this helper.
> +	 */
> +	netdev_for_each_lower_dev(dev, lower_dev, iter) {
> +		err =3D __switchdev_handle_port_attr_set(lower_dev, port_attr_info,
> +						       check_cb, set_cb);
> +		if (err && err !=3D -EOPNOTSUPP)
> +			return err;
> +	}
> +
> +	return err;
> +}
> +
> +int switchdev_handle_port_attr_set(struct net_device *dev,
> +			struct switchdev_notifier_port_attr_info *port_attr_info,
> +			bool (*check_cb)(const struct net_device *dev),
> +			int (*set_cb)(struct net_device *dev,
> +				      const struct switchdev_attr *attr,
> +				      struct switchdev_trans *trans))
> +{
> +	int err;
> +
> +	err =3D __switchdev_handle_port_attr_set(dev, port_attr_info, check_cb,
> +					       set_cb);
> +	if (err =3D=3D -EOPNOTSUPP)
> +		err =3D 0;
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(switchdev_handle_port_attr_set);
> --=20
> 2.17.1
>=20
