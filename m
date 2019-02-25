Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFCDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3D72087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Pfus9xvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBYLSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 06:18:36 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:5270
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726701AbfBYLSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 06:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saeA9/dKV6FKt+mH/fWif/0eYyTAEzQk3Mpo0jEiEX0=;
 b=Pfus9xvYgW9T4/sAPmv7YUnBUQiW+uDpVs8U9QulvF4iwl2p/nGU/RNdFFDtcHAeguBFbqymXfiVwakQRx/bebiurQunuoijzKNvc4iWcqT+VibLiwXe8TlMl4rzefR4fKI93douVfWieTw+34HQd73OWBsD+OK1tIyjfX53BSo=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB4408.eurprd05.prod.outlook.com (52.135.162.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 11:18:31 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 11:18:31 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     Jiri Pirko <jiri@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] mlxsw: spectrum: remove set but not used
 variable 'autoneg_status'
Thread-Topic: [PATCH net-next] mlxsw: spectrum: remove set but not used
 variable 'autoneg_status'
Thread-Index: AQHUzKx2uk7umoRJ/kmNrzSiEMrMkaXwXlAA
Date:   Mon, 25 Feb 2019 11:18:30 +0000
Message-ID: <20190225111828.GA17457@splinter>
References: <20190225020328.42510-1-yuehaibing@huawei.com>
In-Reply-To: <20190225020328.42510-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0402CA0007.eurprd04.prod.outlook.com
 (2603:10a6:209::20) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d260ab8-767c-415d-2705-08d69b12f8ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4408;
x-ms-traffictypediagnostic: AM6PR05MB4408:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB4408;23:TecDUAI+hga0laAceMiEJHX1Ttr1S000j0xSay9V7?=
 =?us-ascii?Q?OcsqNIScCfZinVdtNRNoTZtKN5eTMwWX2WaTLfSANucn4VjSD38zj3jDhz3C?=
 =?us-ascii?Q?nkSKNszdl0m5BtPPZlPgkMDBjHIAIK++ZfyGPH+wbSZzG0ivotcwYvkKnwyM?=
 =?us-ascii?Q?EpuhkrRMTKRYDQEr9EKMB6W9Iq4eGUBDNv+9b2mcAsWfz8bhU9qyg8y9eUFV?=
 =?us-ascii?Q?d4RbyVphtxfYpInHY/jLzJU8ZVRUtCUikEmRkZoGbz8ig2mAiGm6BRMIJlwX?=
 =?us-ascii?Q?Ez4Xbxvei/0CQf7Ezly6ovyCU0GiVAJQVUSdnexqCP9iUKJJG1zW4Kw4i94P?=
 =?us-ascii?Q?f4e5laPrmL9VU8UToHjkFC8gm+kskUlv710g1foJvkVD3FCpIlgJ1I92XiZr?=
 =?us-ascii?Q?wQlYDOAeiTo1x/4Tujlj0zHCkpycBOLjD/Q8eZ1ltUK60F3kwvDGh0BKm32D?=
 =?us-ascii?Q?RNXva23SePvEgMQefUVumWX9WLTaBxgB4ib4XCvAbJ70YQWde5jqkz1sgyIb?=
 =?us-ascii?Q?YXO3OSJv2DrFe6zHgownFlbakYD/j3LlmL1E73ixtJO4gQL5s4gt81OfgY+Z?=
 =?us-ascii?Q?9v2kkzC9jnQdfvnSj7fCFvS28Dievam6qFLjqFn1eDdqcmNzSqOLUe2vSvaS?=
 =?us-ascii?Q?LrGP7Ul/A5wSmp9QUXzN/zuxFMfleMoXfy5QHEqPoZ3DZS99NeQqjBiJSXsW?=
 =?us-ascii?Q?jUw6Cv/o45/OLDgNoYSqYlKqwXCBZb+MZXJFfSCnki2xygEgCDPfMyODjRze?=
 =?us-ascii?Q?QbQb8vWHwAOjGjiz4L5FKaap66YthzmdnsAnBt7+7wdRGBY9nBuj9Ze6X3n2?=
 =?us-ascii?Q?+CPzQz3GPIPQZHgd4vaGvFSw4wU0Mlj37/glwjYg/jLQP1pU+FVrBd6kI0J9?=
 =?us-ascii?Q?sTgT3W44cXKcfFfDMBC13lo7W/HPqS5c/bete3snXJrNW2F9J0KWADgK8k+R?=
 =?us-ascii?Q?tRVvrnK1Awvjfi51Gpep9aH9GraGiVitYJU7xTIToHxY1qBvFGbBuxucVAmF?=
 =?us-ascii?Q?Za7urQvlwQxvXSW1NSaVzh5r3q8wkmhvxIIpTL82FVDFhSz4h8mEwcaii4hM?=
 =?us-ascii?Q?oiJrdDCTSOTQTadfXKWMcK/AfotoTzp059Rs9XLibimgG345eD2sAEFXmJJR?=
 =?us-ascii?Q?EuyAMy8uJdtL27wvn/eX8oy4cWRZnQ9gGD5kc/1BW5ao0L+0WqU+aFb71Shw?=
 =?us-ascii?Q?W85DOYwVHRsdFg1NTZ5gbrgwjv/OoLTC9xyMyn3JSsB13BF53+Wspt9riA9n?=
 =?us-ascii?Q?MLjcvzVyhVpMrra7AaKBwaE2vOjGJ6z98VM8RlG96kIewex0eL84ISRq7OJV?=
 =?us-ascii?B?Zz09?=
x-microsoft-antispam-prvs: <AM6PR05MB440869A8E4F4002C89BB968BBF7A0@AM6PR05MB4408.eurprd05.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(376002)(39860400002)(366004)(136003)(346002)(189003)(199004)(1076003)(53936002)(6486002)(305945005)(229853002)(33656002)(99286004)(4744005)(6512007)(14444005)(33716001)(97736004)(6436002)(9686003)(256004)(106356001)(86362001)(7736002)(105586002)(316002)(8676002)(102836004)(81156014)(81166006)(71190400001)(8936002)(6916009)(486006)(54906003)(2906002)(478600001)(26005)(4326008)(446003)(68736007)(25786009)(11346002)(3846002)(476003)(6116002)(76176011)(6246003)(52116002)(5660300002)(71200400001)(186003)(14454004)(66066001)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4408;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pTLigvcDqZTul6oJ7nMKLnIAW5eMHaeQTGgw06CXkBEuweHjdqTLqmx14X8aFyQ1msQP2dhqx8fcMzcb0vNGnasQR2W42neooBxWV4/1l03vEypaizzAFuayFENz0NKRf1WFal0/bMpd64y5DMcsiqA+utweSR8cWab7GRIVQkUuwp6JAjhkrtpxErNvE0Vz8xsF/SThIzdMyyg+9Gw5fL0l9YuBGk+9PXCZH8YbDX3uFimNF633g6tUAFbx/vjfQx4ZQ0BQjwEKaW3ERAl+oH1fR4+y6eW/7vZPqZDoH17du7SAhmHqZikxuOk33kHxFZb5y4jf9L+ccJHO8lcR9QMfhPLBmq5IqeZjU4kQwpHWFDnwEFkbe/G5Rf6Aa4ZJ1VdT9W0EtRhqYaVyLTNVNBtPWbOAUJOrAfqT7BqaH1Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E021043AF05AB42891321C79770CE0C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d260ab8-767c-415d-2705-08d69b12f8ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 11:18:30.3519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4408
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 02:03:28AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/net/ethernet/mellanox/mlxsw/spectrum.c: In function 'mlxsw_sp_por=
t_get_link_ksettings':
> drivers/net/ethernet/mellanox/mlxsw/spectrum.c:3062:5: warning:
>  variable 'autoneg_status' set but not used [-Wunused-but-set-variable]
>=20
> It's not used since commit 475b33cb66c9 ("mlxsw: spectrum: Remove unsuppo=
rted
> eth_proto_lp_advertise field in PTYS")
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>

Thanks!
