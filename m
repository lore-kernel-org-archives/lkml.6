Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66931C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B155213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="WYYwd0xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfB0MdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:33:19 -0500
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]:28587
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfB0MdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swq/S8DcM57qPexRzKGchyQ5CBiRTzg6l93s6myU0D4=;
 b=WYYwd0xhJwpVKVqa58Mit2X0z981tpVGRDibJxXh1SVUGkfG0i32IUcK2BHIvXfKqF6WpPe8ZdogrA+7Qwh946XqHJ00cNxf+ywVzcCFKmsVo2RSrCRrlURU/y8QOQB7mk7cMvzAed/M7GJK37ajlkl93/6NwmLJuBpWWXO2gBU=
Received: from DB7PR05MB5243.eurprd05.prod.outlook.com (20.178.42.15) by
 DB7PR05MB5512.eurprd05.prod.outlook.com (20.177.192.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 27 Feb 2019 12:32:35 +0000
Received: from DB7PR05MB5243.eurprd05.prod.outlook.com
 ([fe80::2df1:2e11:a3f7:ef23]) by DB7PR05MB5243.eurprd05.prod.outlook.com
 ([fe80::2df1:2e11:a3f7:ef23%6]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 12:32:35 +0000
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
Subject: Re: [PATCH net-next 7/8] net: switchdev: Replace port attr set SDO
 with a notification
Thread-Topic: [PATCH net-next 7/8] net: switchdev: Replace port attr set SDO
 with a notification
Thread-Index: AQHUywrdkdsT/LOBwUG+oBo6MXUQTqXtL/eAgAH7MoCAAR2bAIAApvMAgAKrOAA=
Date:   Wed, 27 Feb 2019 12:32:34 +0000
Message-ID: <20190227123232.GE13567@splinter>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
 <20190222235927.10295-8-f.fainelli@gmail.com>
 <20190223103207.GA13070@splinter>
 <daaa3bb6-78b1-7c19-e2fd-6ec03d56201d@gmail.com>
 <20190225094940.GA15128@splinter>
 <2e91b708-a092-3839-4979-2712145a9951@gmail.com>
In-Reply-To: <2e91b708-a092-3839-4979-2712145a9951@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:209:1::37) To DB7PR05MB5243.eurprd05.prod.outlook.com
 (2603:10a6:10:68::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 569c2647-7260-47c8-590b-08d69cafa683
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB5512;
x-ms-traffictypediagnostic: DB7PR05MB5512:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB7PR05MB5512;23:B7Yh07MQFYD7kYmA58/kd+kcGYEowD3C8P6yGyI?=
 =?iso-8859-1?Q?c3uLAbK6L/EfZLolGsnXPGYllExXFIWVXfdYkoeSzPpr8yrZz9964/iq+T?=
 =?iso-8859-1?Q?S3OExAOK7+vjG96PtSaPdznhAjLTfyhvbqCbpzkLRKCjknJTaX6Gq1HTVP?=
 =?iso-8859-1?Q?/a0h/Yj3evh4dbAlxSQ0qCQVjY1bWczgaCEVwgxLe8j619DPc6B64pX1lZ?=
 =?iso-8859-1?Q?dKsEKkgaTxf+5zeam+5lUD7w+Wy+JIXPl0Z43XqU74fyd5ImsSI5YRLRwp?=
 =?iso-8859-1?Q?KoGpCUSd/4lgaLCgQePGnXMj8GzOtHUGkUuQOw/m2OGL04idXiTvyyQem5?=
 =?iso-8859-1?Q?ocxZsXUN+zxioZdulfYRIE5OvFgDuL9yDdt865ZBx5hx0VSwD9Qcy0xsvJ?=
 =?iso-8859-1?Q?jnjBrMLo+4824kWia5BYrg/Qjz+VZZbjV38U/Qcq+yg+vbpFsZY6DkxcRR?=
 =?iso-8859-1?Q?NHFa2CjEk1u4JqTiDMYPcpvJICv2oMYiZcxn5HxQPTufGm3kiMt8L9tad0?=
 =?iso-8859-1?Q?BKJdp0s3HpIWamqB5DV4fwRmENRP+Gj8AwM11aukC/qSC7O6xxcUukPeNB?=
 =?iso-8859-1?Q?S2mFIMtXSbKXAJpf+uQnS2GcbOHlyybSR/0zsjgrZGYwVIX9TGdTxsTrcd?=
 =?iso-8859-1?Q?xE2vgQLGBHlypbN1ghU1ng8suW6SlO9cXef65PlcnJASqCXNkP0zKUouGP?=
 =?iso-8859-1?Q?bbXeEyD4i7fZ4yh4NOG3s3yByup+vGYF5uGdVxBi31pf4gMMkX+hnhyoBf?=
 =?iso-8859-1?Q?nH/4u2OmloBgNXZoFCd2EGnrmiBYDfQCKT9COkIWWcfjeVU9Gr0HCIaPsS?=
 =?iso-8859-1?Q?I6xzZo3Ddmh5dQiMpC+qEE7aorQLI1IgpkshXASn5OKuD6kXJW6Gu8Nia5?=
 =?iso-8859-1?Q?ZrYfeqSR5rQwfwk78CwS1ygWRYfhEsi2mDR9TlYSYkAo9AmkMmPODIL023?=
 =?iso-8859-1?Q?NGTbE/V90O3llrp4Yip+87RfG7Tq6ycqhH9TjPIh/CLscvudmqfjsc5uee?=
 =?iso-8859-1?Q?OS+VSzlX1hYhsRJ216DHTfGbop/4wnykHSVg8vkHG79UesWcVJNP6A1JA6?=
 =?iso-8859-1?Q?zkTLiS3V0CHhi1QghFRRJDVFitcd/kRF0uQmhDeXlbBSr7ngcWfoEVMyiX?=
 =?iso-8859-1?Q?l1sh/B7ilu5Yu6flnyNrQ9wKnG566UX9JmHxKRqtBr8eFAtlqNfpbcX+AK?=
 =?iso-8859-1?Q?ukydQovgX+qNsoXtJHZuMxKZ995zCcKOPKwbrTUDOFDAkB4KrIgtNE0GRG?=
 =?iso-8859-1?Q?IoRquGUWmvBTf+2AVgoYMfGWYJDWep0iZK6zqWg0G23FB3/PkWE+fxVIoS?=
 =?iso-8859-1?Q?Fy5Y5yGpdRV8iVd1/YckVfbHIfvLtbklhIvGVNfDUjB2hC0hKBs+0TIwXG?=
 =?iso-8859-1?Q?rZl6pbZmF7jtsUxpTjfKEWYOSAki32lPFUnqBmFXIsxJOTopO7RbNuepfD?=
 =?iso-8859-1?Q?vokvEpqVzr+4gM=3D?=
x-microsoft-antispam-prvs: <DB7PR05MB5512F9521E3F8BF9568CB45FBF740@DB7PR05MB5512.eurprd05.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(39860400002)(366004)(136003)(376002)(396003)(199004)(189003)(86362001)(93886005)(14444005)(6916009)(256004)(8676002)(446003)(7736002)(99286004)(52116002)(11346002)(6116002)(3846002)(81166006)(14454004)(6486002)(81156014)(6436002)(15650500001)(33656002)(229853002)(2906002)(5660300002)(26005)(54906003)(186003)(316002)(305945005)(486006)(106356001)(105586002)(66574012)(1076003)(68736007)(66066001)(25786009)(71190400001)(8936002)(4326008)(476003)(97736004)(102836004)(53936002)(76176011)(53546011)(6512007)(478600001)(6506007)(386003)(9686003)(6246003)(33716001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5512;H:DB7PR05MB5243.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uUQnh+zXovLeBERgqxyJrxpzjzcbxjC96wg4JhES4iyrccATPfoRqhluUKW8w/T9gUUXRJKEjlWvXHc5CMCNyv+/doYpSSypdPycWE3mbHgZS2mj+nWay+W9z1T2VU/b8vOasNHqFi754y4sWDnX4abSNLHpCsFiGX3WmwBRIQVFCWjdKB1ZA2G+VlUtFHs4uiS7QZCYxn9QhiK4YlydDLzm0UTvUdBKerPymewLgvq7UN7U2AcYLYStb+vc/AhdbncsrI3e6ZCz8J1JLlbDwWkf4YLiyV/nNBn2Sgg09o8cW7sJSMKPgVaKLJsDb5zQpMo4MlBqsSdoaNLjf6t4FD2gztVRQXVKs4igweumEk8DezevqhzQ9vRDJSw95g8GKbHGNWBleJUAa1E7mSxc+X9GyQsxxUZ7eUSg406pM84=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <915DA04E3989804892AF568544A38635@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569c2647-7260-47c8-590b-08d69cafa683
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 12:32:34.4067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 11:47:12AM -0800, Florian Fainelli wrote:
> On 2/25/19 1:49 AM, Ido Schimmel wrote:
> > On Sun, Feb 24, 2019 at 08:47:27AM -0800, Florian Fainelli wrote:
> >> Le 2/23/19 =E0 2:32 AM, Ido Schimmel a =E9crit=A0:
> >>> On Fri, Feb 22, 2019 at 03:59:25PM -0800, Florian Fainelli wrote:
> >>>> -	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
> >>>> +	if (attr & SWITCHDEV_F_DEFER)
> >>>> +		rc =3D call_switchdev_blocking_notifiers(nt, dev,
> >>>> +						       &attr_info.info, NULL);
> >>>> +	else
> >>>> +		rc =3D call_switchdev_notifiers(nt, dev, &attr_info.info, NULL);
> >>>
> >>> I don't believe this is needed. You're calling this function from
> >>> switchdev_port_attr_set_now() which is always called from process
> >>> context. switchdev_port_attr_set() takes care of that. Similar to
> >>> switchdev_port_obj_add().
> >>
> >> Except for net/bridge/br_switchdev.c when we check the bridge port's
> >> flags support with PRE_BRIDGE_FLAGS. In that case we are executing fro=
m
> >> the caller (atomic) context and we can't defer otherwise that trumps t=
he
> >> whole idea of being able to do a quick check and return that to the
> >> caller that we cannot support specific flags. How would you recommend
> >> approaching that?
> >=20
> > In this case you can invoke call_switchdev_notifiers() directly from
> > br_switchdev_set_port_flag(). Eventually switchdev_port_attr_set() will
> > be gone and bridge code will invoke the notifiers directly.
>=20
> That can be done, but it still requires the target driver (mlxsw,
> ocelot, dsa, etc.) to support attribute notification from blocking and
> non-blocking context. Are you fine with that?

Yes. Sorry for the latency. I was away yesterday. Reviewed your v2 and
only found one problem. Will run some tests now.

Thanks!
