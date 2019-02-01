Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8617DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339252083B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="gEoetAFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfBAUs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:48:59 -0500
Received: from mail-eopbgr20048.outbound.protection.outlook.com ([40.107.2.48]:1120
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726608AbfBAUs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vUTqC71RfuyfujBTCWwy3bp/MuoWYJbaxj6xI4sG9I=;
 b=gEoetAFiNe3lAxiX0wGGx4mou4lAZ1/1j8J/t5end2mksfeszLRHNOGdN8Ox+IMPx28G8ULgROjSyE+skceN76Z0rWNTua2t2Y9uNSDuBcu4w3IcZGjbk+4MNupUbjsvXlzeRVgdeb74nvZphOZ+KBKVcEgw822mjaHGFhJb3Y0=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3270.eurprd05.prod.outlook.com (10.170.221.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 20:48:52 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320%2]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 20:48:52 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] platform/mellanox: Add bootctl driver for Mellanox
 BlueField Soc
Thread-Topic: [PATCH v1 1/1] platform/mellanox: Add bootctl driver for
 Mellanox BlueField Soc
Thread-Index: AQHUuBWSgorN9Oha0kyXFJVXsER32KXKancAgAEEG3A=
Date:   Fri, 1 Feb 2019 20:48:52 +0000
Message-ID: <DB6PR05MB3223E29FE34B600B86E83170A1920@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <201902011338.icDcSZPG%fengguang.wu@intel.com>
In-Reply-To: <201902011338.icDcSZPG%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR05MB3270;6:5WTulXA74hCWiMBKBqioDus+NTb5IsNt5I6aUByjrXxJbifWo1IedjD3W7kTJl5ZTESY9P+zXEvI52df9JkeGl5qHp9JB4aBfkiqDLWb1sV04gBbjr6ejZMBtQ5dCrTmhe9qQCO9pxhKcZlyEWW6vvD4F+hBG0z6awaMHW2DjSbgcYwpabsL2XYw1YOD2VdDXRXPgBM0Pfs8sst62MpDJw01pxVUGnN1tNC9BHsNBAyzOmDCWqunL/kJnnRQN1EA1LEQD3yFK0aYs6ZTTxMo9jxfY3nNCgGvaPzhyKoO2/hiQ5cwr5+GXBguSShjLPK5IQz3iKCWDisHcInMFHc/KIuvy/aPvAphuaMdyTODbWnUwU61lV810/iLnbXSRhL6RydclZTI3ba+bXx5GXo6Uep8BH5greaKAOZJNA9yAgBKxc7ZUollbDp+qJ3OOD1Yzw0fXdGIPn7JW+M8aE50KA==;5:Wg/wqmldC++3bnPCwQLMkKyfUXIou3SDHWUuL4sBA4lUQPKiELkJcPpU1SJVQjV7u0TSjJUmn6xk6fqWVukngEYbz9vAe9SCNUDlaf83El2xOJAe1e7Y42rVF2qxgLrMLPCrdDDPdbHqfHWs1GOaWTpkWNqQfQeoZ6BriknOurHaIMlNkT+4GNeq5S3xb20q7Tp13KfF26WP1gsvuhGF3w==;7:QZJxm9wYHACrh5zrqkGKIwyP+zcmi5oqGA9mr10Ec5W3Ym0YE3q93Jv1a69NjzJYJChZViDDxDNeh1AiDhbOaPBVjPYlvv1GAJVz7eIc9HQEfn2kJfhkE3v2pptvemTCVps/B70DfJ/aRCG0hJ/zhg==
x-ms-office365-filtering-correlation-id: 46960b46-e28d-4915-3743-08d68886ace6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3270;
x-ms-traffictypediagnostic: DB6PR05MB3270:
x-microsoft-antispam-prvs: <DB6PR05MB327072EA30827356CDCC16A6A1920@DB6PR05MB3270.eurprd05.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(39860400002)(136003)(13464003)(51914003)(189003)(199004)(71200400001)(8676002)(7736002)(66066001)(33656002)(345774005)(8936002)(6116002)(25786009)(81166006)(11346002)(3846002)(446003)(81156014)(76176011)(97736004)(476003)(74316002)(486006)(14454004)(4326008)(966005)(478600001)(7696005)(6916009)(26005)(305945005)(53936002)(102836004)(6246003)(6506007)(53546011)(6306002)(106356001)(9686003)(6436002)(105586002)(2906002)(186003)(55016002)(229853002)(71190400001)(256004)(86362001)(54906003)(14444005)(5024004)(316002)(99286004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3270;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U9hGJODBYUhsCc/eP13OYRsGLuxvuE6BKLq59Lj8dt97wmPohY07R4fMfppvjfxQKGwoJ+zeH2G+5pmKLWXmMUeoG2zOqPDabXBZLvJw0Zb/2yTRMiMkRWYi023Gq7fW88yARmjg5hCZExEWYUMYx5d4VLbjMDYC4sQsVOfv7rQTlvoMV2PwFNgrNR9ajThSy7ocByLh8hraWNS0Od/rPopBs2kOL0d3dduKxus8e32FGRBFso4G2Izydenbpnev5STO8roAe5BPlvwfy5dCBs4ODUPv55q8pk22l15RBsdPAsC5zxHVFJPx7MlwxgihFqw/0JNWVeIEzSZriZrGpkOrBr1CQE8tPbf68n5WJLI0tSFyZN2W1IPpyAnKn9ayLH9W38uPiHMelA5sZnoIt1GAjNMj4fNZH7uTzXxccwM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46960b46-e28d-4915-3743-08d68886ace6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 20:48:52.6156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3270
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the information!=20

Patch v4 1/1 has been posted to solve these issues.

Best regards,
Liming

> -----Original Message-----
> From: kbuild test robot <lkp@intel.com>
> Sent: Friday, February 1, 2019 12:17 AM
> To: Liming Sun <lsun@mellanox.com>
> Cc: kbuild-all@01.org; Andy Shevchenko <andy@infradead.org>; Darren Hart =
<dvhart@infradead.org>; Vadim Pasternak
> <vadimp@mellanox.com>; David Woods <dwoods@mellanox.com>; Liming Sun <lsu=
n@mellanox.com>; platform-driver-
> x86@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v1 1/1] platform/mellanox: Add bootctl driver for Mel=
lanox BlueField Soc
>=20
> Hi Liming,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.0-rc4 next-20190131]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Liming-Sun/platform-mell=
anox-Add-bootctl-driver-for-Mellanox-BlueField-
> Soc/20190201-104657
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D8.2.0 make.cross ARCH=3Darm64
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/platform/mellanox/mlxbf-bootctl.c:260:36: error: array type ha=
s incomplete element type 'struct acpi_device_id'
>     static const struct acpi_device_id mlxbf_bootctl_acpi_ids[] =3D {
>                                        ^~~~~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/module.h:18,
>                     from drivers/platform/mellanox/mlxbf-bootctl.c:12:
> >> drivers/platform/mellanox/mlxbf-bootctl.c:314:20: error: expected ',' =
or ';' before 'DRIVER_DESCRIPTION'
>     MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
>                        ^~~~~~~~~~~~~~~~~~
>    include/linux/moduleparam.h:24:26: note: in definition of macro '__MOD=
ULE_INFO'
>       =3D __stringify(tag) "=3D" info
>                              ^~~~
>    include/linux/module.h:208:42: note: in expansion of macro 'MODULE_INF=
O'
>     #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _de=
scription)
>                                              ^~~~~~~~~~~
>    drivers/platform/mellanox/mlxbf-bootctl.c:314:1: note: in expansion of=
 macro 'MODULE_DESCRIPTION'
>     MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
>     ^~~~~~~~~~~~~~~~~~
>=20
> vim +314 drivers/platform/mellanox/mlxbf-bootctl.c
>=20
>    259
>  > 260	static const struct acpi_device_id mlxbf_bootctl_acpi_ids[] =3D {
>    261		{"MLNXBF04", 0},
>    262		{},
>    263	};
>    264
>    265	MODULE_DEVICE_TABLE(acpi, mlxbf_bootctl_acpi_ids);
>    266
>    267	static int mlxbf_bootctl_probe(struct platform_device *pdev)
>    268	{
>    269		struct arm_smccc_res res;
>    270
>    271		/*
>    272		 * Ensure we have the UUID we expect for this service.
>    273		 * Note that the functionality we want is present in the first
>    274		 * released version of this service, so we don't check the versio=
n.
>    275		 */
>    276		arm_smccc_smc(MLXBF_BOOTCTL_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0, &re=
s);
>    277		if (res.a0 !=3D 0x89c036b4 || res.a1 !=3D 0x11e6e7d7 ||
>    278		    res.a2 !=3D 0x1a009787 || res.a3 !=3D 0xc4bf00ca)
>    279			return -ENODEV;
>    280
>    281		/*
>    282		 * When watchdog is used, it sets boot mode to MLXBF_BOOTCTL_SWAP=
_EMMC
>    283		 * in case of boot failures. However it doesn't clear the state i=
f there
>    284		 * is no failure. Restore the default boot mode here to avoid any
>    285		 * unnecessary boot partition swapping.
>    286		 */
>    287		if (mlxbf_bootctl_smc_call1(MLXBF_BOOTCTL_SET_RESET_ACTION,
>    288					    MLXBF_BOOTCTL_EMMC) < 0)
>    289			pr_err("Unable to reset the EMMC boot mode\n");
>    290
>    291		pr_info("%s (version %s)\n", MLXBF_BOOTCTL_DRIVER_DESCRIPTION,
>    292			MLXBF_BOOTCTL_DRIVER_VERSION);
>    293
>    294		return 0;
>    295	}
>    296
>    297	static int mlxbf_bootctl_remove(struct platform_device *pdev)
>    298	{
>    299		return 0;
>    300	}
>    301
>    302	static struct platform_driver mlxbf_bootctl_driver =3D {
>    303		.probe =3D mlxbf_bootctl_probe,
>    304		.remove =3D mlxbf_bootctl_remove,
>    305		.driver =3D {
>    306			.name =3D MLXBF_BOOTCTL_DRIVER_NAME,
>    307			.groups =3D mlxbf_bootctl_attr_groups,
>    308			.acpi_match_table =3D ACPI_PTR(mlxbf_bootctl_acpi_ids),
>    309		}
>    310	};
>    311
>    312	module_platform_driver(mlxbf_bootctl_driver);
>    313
>  > 314	MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion
