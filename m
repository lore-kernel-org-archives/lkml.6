Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53122C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179C32081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179C32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeK1XjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:39:21 -0500
Received: from mail-eopbgr820070.outbound.protection.outlook.com ([40.107.82.70]:8865
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727811AbeK1XjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFoqCGHj5DGT/3Uyfy33WcRquZb1JYZ7TkPTyR6EuUo=;
 b=VXMuz03O0w+Wb3bNWQIDROieKA4iuoyoZMUkuTUcgcGOLZ4f9Na24nqvcs589Hh2XeP1vRn71wfeDYM0teOi8pdZ9MQ/5rthzBb3WqkeQ2iCNxxDpDX6sxvea8z2zgFtGonFZyiM+eVAGM3WCku0bgKH5EzzFCNJ2p9vd2gw78g=
Received: from BYAPR07MB5511.namprd07.prod.outlook.com (20.177.231.145) by
 BYAPR07MB4230.namprd07.prod.outlook.com (52.135.223.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Wed, 28 Nov 2018 12:37:44 +0000
Received: from BYAPR07MB5511.namprd07.prod.outlook.com
 ([fe80::d0eb:2ff3:2492:413a]) by BYAPR07MB5511.namprd07.prod.outlook.com
 ([fe80::d0eb:2ff3:2492:413a%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 12:37:44 +0000
From:   "Shaikh, Shahed" <Shahed.Shaikh@cavium.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Chopra, Manish" <Manish.Chopra@cavium.com>,
        Dept-GE Linux NIC Dev <Dept-GELinuxNICDev@cavium.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next] qlcnic: remove set but not used variables
 'cur_rings, max_hw_rings, tx_desc_info'
Thread-Topic: [PATCH net-next] qlcnic: remove set but not used variables
 'cur_rings, max_hw_rings, tx_desc_info'
Thread-Index: AQHUhxYbuUqLIG/m/ky/zM5ivWonx6VlH3VQ
Date:   Wed, 28 Nov 2018 12:37:44 +0000
Message-ID: <BYAPR07MB551128CCBFF263E29BF98F829DD10@BYAPR07MB5511.namprd07.prod.outlook.com>
References: <20181128122939.28132-1-yuehaibing@huawei.com>
In-Reply-To: <20181128122939.28132-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shahed.Shaikh@cavium.com; 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4230;6:5jnPlHqUY7OgqoIc49AAhapdzHST2Q8J2513S+XJ4E5VWrFmJTHSkuBktPEhpG/APcoh8E0ypKfjqewY8pdVTQqcNGlLsNi+CraLg568uW4gXxRDZU/+u+8oWzfs5rSQ4WlahuXDCDBoQgEjPPo/QN2SmLikaNR/fnrWtblhP8a5ezWtuRksG8TlYXTRVUdkQiCNOIesVJs5JczaJ2XCgxNGryf+Ta54IdKm2V5K8LN1Mv5Wkc3qDL+UBKXFv5+WWcLcaVoauNdZ+w3LTM+CDWeAF25IBTmCKNWRf3+3wf9uBnCRyGXgsqRbPaY1MUU8nXfMswvRuXkjtxEFELZTr1G1jUdblxFwg7V4bQ6sCDwLMGTwY8Lvas8ZbSwSxBufxGKsz/OqZnQjKVzp2ESlwPZgQK6+/lzOGmLCenYxizt1eV/n6u8jxr1iQw6NMr3fdY23A3MZG68vrUfA0d18Rw==;5:cahev1YsSIhw0wzFmtGjIG/VEKGSxxMVZmFfO/+fczAB0M0qTUOl2PWGfLh3nQ8K57WCk8EzG7KxeJ0rrnY2VPLQvBoO+wMPNBgKNSvx376wM+fp90yA1Yt2ow28ChQ++EDerURJIkRshVu6qeWtE+1x7L9Tf5y0+oAMKVPZYjw=;7:8urRkB9U9SDj9/ckYELKYpcctOF+DdOPlaJ0OJX5TgusCutimNYUKJ4M7X7ZNf+vBWCpnzrC2Ggv7v3pG/CFB/R4DB/BNmYNB/exeWdUJcIOzf6jeQ3T/3aVLcepIpurqxSyRONS3yeccKGEDtinDw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: e1005a57-1456-49eb-a28b-08d6552e4bba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4230;
x-ms-traffictypediagnostic: BYAPR07MB4230:
x-microsoft-antispam-prvs: <BYAPR07MB42304649DA8A41A72C274DAA9DD10@BYAPR07MB4230.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4230;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4230;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(13464003)(189003)(199004)(4326008)(7696005)(3846002)(6116002)(55016002)(53936002)(71190400001)(71200400001)(6246003)(9686003)(26005)(14454004)(25786009)(186003)(72206003)(53546011)(102836004)(6506007)(97736004)(86362001)(76176011)(6436002)(478600001)(8936002)(305945005)(106356001)(8676002)(66066001)(316002)(7736002)(74316002)(54906003)(110136005)(5660300001)(33656002)(81166006)(81156014)(2906002)(229853002)(68736007)(446003)(476003)(11346002)(14444005)(256004)(486006)(2501003)(99286004)(105586002)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4230;H:BYAPR07MB5511.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M5Uax4ymS+ud08JVUQh15hlhibbVGYqHwJPqHdqzDjYFwdcT4zci3pVcMI5swnIYAx5fNoZw/w/a4/F8rK+6sH2Au0jNu+SXc2IYNKqQVqN7LEi36a838N7Ctik+qC4SNDLYpInQN6Xcjz/3mts+EkBfGpUWn5I06JHNKrBrO5hRhkynq3lwkKlWAHFHAfkfggHwfVReLyUjI4S/rINDEkgrD14FBO1qVy0he4Sqq3wXAY8MidMCvjjSG3w5L1zop5Yq3YEucivv1veL43LMx65GK43bj4q763Wio82tzYndiETXU6QQRpTCdaPuIf8MlWe/1uOmEQOvpnr40oGjI9Nw5SxF42SoASaIWMCVjt4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1005a57-1456-49eb-a28b-08d6552e4bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 12:37:44.4651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: YueHaibing <yuehaibing@huawei.com>
> Sent: Wednesday, November 28, 2018 6:00 PM
> To: davem@davemloft.net; Shaikh, Shahed <Shahed.Shaikh@cavium.com>;
> Chopra, Manish <Manish.Chopra@cavium.com>; Dept-GE Linux NIC Dev
> <Dept-GELinuxNICDev@cavium.com>
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; YueHaibing
> <yuehaibing@huawei.com>
> Subject: [PATCH net-next] qlcnic: remove set but not used variables
> 'cur_rings, max_hw_rings, tx_desc_info'
>=20
>=20
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:4011:5:
>  warning: variable 'max_hw_rings' set but not used [-Wunused-but-set-
> variable]
> drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:4013:6:
>  warning: variable 'cur_rings' set but not used [-Wunused-but-set-variabl=
e]
> drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:2996:25:
>  warning: variable 'tx_desc_info' set but not used [-Wunused-but-set-
> variable]
>=20
> 'cur_rings, max_hw_rings' never used since introduction in commit
> 34e8c406fda5 ("qlcnic: refactor Tx/SDS ring calculation and validation in
> driver.")
> 'tx_desc_info' never used since commit
> 95b3890ae39f ("qlcnic: Enhance Tx timeout debugging.")
> Also 'queue_type' only can be QLCNIC_RX_QUEUE/QLCNIC_TX_QUEUE,
> so make a trival cleanup on if statement.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
> b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
> index d42ba22..16d0479 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
> @@ -2993,10 +2993,8 @@ int qlcnic_check_temp(struct qlcnic_adapter
> *adapter)
>  static inline void dump_tx_ring_desc(struct qlcnic_host_tx_ring *tx_ring=
)
>  {
>         int i;
> -       struct cmd_desc_type0 *tx_desc_info;
>=20
>         for (i =3D 0; i < tx_ring->num_desc; i++) {
> -               tx_desc_info =3D &tx_ring->desc_head[i];
>                 pr_info("TX Desc: %d\n", i);
>                 print_hex_dump(KERN_INFO, "TX: ", DUMP_PREFIX_OFFSET, 16,=
 1,
>                                &tx_ring->desc_head[i],
> @@ -4008,19 +4006,12 @@ int qlcnic_validate_rings(struct qlcnic_adapter
> *adapter, __u32 ring_cnt,
>                           int queue_type)
>  {
>         struct net_device *netdev =3D adapter->netdev;
> -       u8 max_hw_rings =3D 0;
>         char buf[8];
> -       int cur_rings;
>=20
> -       if (queue_type =3D=3D QLCNIC_RX_QUEUE) {
> -               max_hw_rings =3D adapter->max_sds_rings;
> -               cur_rings =3D adapter->drv_sds_rings;
> +       if (queue_type =3D=3D QLCNIC_RX_QUEUE)
>                 strcpy(buf, "SDS");
> -       } else if (queue_type =3D=3D QLCNIC_TX_QUEUE) {
> -               max_hw_rings =3D adapter->max_tx_rings;
> -               cur_rings =3D adapter->drv_tx_rings;
> +       else
>                 strcpy(buf, "Tx");
> -       }
>=20
>         if (!is_power_of_2(ring_cnt)) {
>                 netdev_err(netdev, "%s rings value should be a power of 2=
\n",
> --
> 2.7.0
>=20

Looks good.

Acked-by: Shahed Shaikh <shahed.shaikh@cavium.com>

Thanks,
Shahed
