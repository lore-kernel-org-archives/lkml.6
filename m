Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E5C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0C4206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="bQ6YLNvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0C4206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJDXRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:17:47 -0400
Received: from mail-eopbgr690076.outbound.protection.outlook.com ([40.107.69.76]:40647
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbeJDXRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuST2pLpbrVWLlB0rSn4yaAC7ArCfHoZ+iK/Gp09pYI=;
 b=bQ6YLNvHouvfz5fnsmGsgFAaLzaJvJkghVWZa+3X8MjjrAIDJ4bXz/n2M0nbJ8/6ZmxXD1mVvoN2x1BgEZbt4V50N8U8nGPrtTJCrk0U088TtFLXdpn6amGUyx/vqHg30NfKfePEx0iFtxPbJvHeuMHBqEGLY5mUViN4wUFvStg=
Received: from CY1PR07MB2554.namprd07.prod.outlook.com (10.167.16.21) by
 CY1PR07MB2444.namprd07.prod.outlook.com (10.166.195.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Thu, 4 Oct 2018 16:23:44 +0000
Received: from CY1PR07MB2554.namprd07.prod.outlook.com
 ([fe80::d38:17f1:bc0c:5643]) by CY1PR07MB2554.namprd07.prod.outlook.com
 ([fe80::d38:17f1:bc0c:5643%4]) with mapi id 15.20.1185.026; Thu, 4 Oct 2018
 16:23:44 +0000
From:   "Tayar, Tomer" <Tomer.Tayar@cavium.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: RE: [PATCH] qed: Remove unneeded enumerated type core_tx_dest
Thread-Topic: [PATCH] qed: Remove unneeded enumerated type core_tx_dest
Thread-Index: AQHUW3aEsdm7HfxStUagpdorBQLnFaUPJEFg
Date:   Thu, 4 Oct 2018 16:23:43 +0000
Message-ID: <CY1PR07MB2554AFA55E8084990E14D55780EA0@CY1PR07MB2554.namprd07.prod.outlook.com>
References: <20181004000912.22242-1-natechancellor@gmail.com>
In-Reply-To: <20181004000912.22242-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tomer.Tayar@cavium.com; 
x-originating-ip: [31.168.140.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR07MB2444;6:ty1WAPW0sWOxZm6lhpSHgfU8qPs4MB3LmNg/BCkR2SZggGbHrvXlsib9ZZTZNwo8l+G3exSvUdMm+e/ae4+8sHickZal0o2sqaPGft2d4GJsvltOqWBze0Rcc0SId48viNWwq5HMQDK8jGmGlBtBtXJkQ37JafBSiWEx5R3WS6uXkDy1Bmt9pf5RW+ynhzTxEVbksNyjSTw/011L9FNZzTN5tL/PqbVNGiaozD1F1ySX9jWzqki7xNVCZq+qDu9/hl5wzxz/nl5SeCQjH3j/Mk7IHzK6zEvFMGEF2R7ywyte5tpH5wyvrRrvKCo7KXbAQ2Lz7Th6/X6EVozrsrpgaaG3c2AaYrNd+JEyXLSyvK4vrQpn//GUVOthWmje3pQwTVmV4+cD8YSCPUbDPQZmENHgw+77mJ+N9STR/n+gWWWf9yV4EcfcJR28DiXlM+GWzudAktgDoxkL+UMtqwDf+A==;5:UD/IndSOsbyFltlXkfXQAl4IJ7rNlOKgl03SLfjwB253cowSXbcogqE4kIWnyDTeilyDF/oysyYblw99C+c5/mkRIz7TKDOGeW4dJd38SnNN4Yo6bg1UvTH8Z4+4w+hHl+rhigg6JkJvx47TxfFvea2RqzaQU5TGByg8up7pV9A=;7:tg8NJFf8hJWkzy2tQJbUPqLqbBzwTagP6xgSLBq3JLyBNDcsLkOzFLsCRzHE1pDH0IoZ3lWGeKNncy4SDHH5TAtmiLOJt21wXw5FCIGivyfSjU+kQX9qmhwii5mdzr7Z+gPywEg+T/QArzE/BMbFJugkJT9x0+nSHPf+KAOCwsKnsVdKBgFtuslSBIJBU4pUbKfGNvqqiOMenTo8v/Pl9qlOL1XtqgS8mSRu+kkJkJUp3DHb9ZXDEO56GjxgXVq0
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 8505f417-ccff-48ad-11c8-08d62a15c107
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR07MB2444;
x-ms-traffictypediagnostic: CY1PR07MB2444:
x-microsoft-antispam-prvs: <CY1PR07MB244496D1D046CD6545B516A880EA0@CY1PR07MB2444.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302088)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:CY1PR07MB2444;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2444;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(486006)(76176011)(305945005)(8676002)(476003)(99286004)(7696005)(186003)(11346002)(478600001)(86362001)(446003)(54906003)(14444005)(6506007)(2900100001)(7736002)(256004)(5660300001)(71190400001)(74316002)(71200400001)(68736007)(72206003)(8936002)(966005)(81156014)(81166006)(25786009)(5250100002)(14454004)(6306002)(105586002)(4326008)(229853002)(110136005)(39060400002)(66066001)(2906002)(9686003)(6246003)(6116002)(3846002)(53936002)(55016002)(26005)(33656002)(102836004)(6436002)(316002)(106356001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2444;H:CY1PR07MB2554.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3bAMxfoiC/K2iKfFWzB8qGEr6D3a7SJjjk9dNahP16TOdJv+QuJRV6cX6zONdPQRXDRaHG7x3QkfnnIP0suXm4wpgX5TTNutN5GjC1avqiMcqV3MVuEh5SHGSQoAhIyMpnpEz2A5LJQnuGEeoz3JpgdA02jZMj7cAR5NjqEKlmkUPK1cvnPP0EIbk89KXQxdBfcaS1GS/RG+qVh3xSRGjgaOOKVxjgdPKcWkj8JVP8p9NVGv86BrJX+xaoAW4+dUtb71uzLUBIR+n0Lv8gaRrszhz3jQve6jORtIND6ZgrF6M0GHeT/7FGYqm/Y3DPfdIKABnWqXSC4plVmGD1wWWANvMm2sgzugDi6UHpgF5gg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8505f417-ccff-48ad-11c8-08d62a15c107
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 16:23:43.9555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2444
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Sent: Thursday, October 04, 2018 3:09 AM
=20
> Clang warns when one enumerated type is implicitly converted to another.
>=20
> drivers/net/ethernet/qlogic/qed/qed_ll2.c:799:32: warning: implicit
> conversion from enumeration type 'enum core_tx_dest' to different
> enumeration type 'enum qed_ll2_tx_dest' [-Wenum-conversion]
>                 tx_pkt.tx_dest =3D p_ll2_conn->tx_dest;
>                                ~ ~~~~~~~~~~~~^~~~~~~
> 1 warning generated.
>=20
> These enumerated types are not 1 to 1:
>=20
> /* Light L2 TX Destination */
> enum core_tx_dest {
>     CORE_TX_DEST_NW,
>     CORE_TX_DEST_LB,
>     CORE_TX_DEST_RESERVED,
>     CORE_TX_DEST_DROP,
>     MAX_CORE_TX_DEST
> };
>=20
> enum qed_ll2_tx_dest {
>     QED_LL2_TX_DEST_NW, /* Light L2 TX Destination to the Network */
>     QED_LL2_TX_DEST_LB, /* Light L2 TX Destination to the Loopback */
>     QED_LL2_TX_DEST_DROP, /* Light L2 Drop the TX packet */
>     QED_LL2_TX_DEST_MAX
> };
>=20
> Fix this conversion warning by adding CORE_TX_DEST_DROP to
> qed_ll2_tx_dest and converting all values of core_tx_dest to
> the equivalent value in qed_ll2_tx_dest so that there is no
> conversion warning or functional change.
>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/125
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

[...]

> -/* Light L2 TX Destination */
> -enum core_tx_dest {
> -       CORE_TX_DEST_NW,
> -       CORE_TX_DEST_LB,
> -       CORE_TX_DEST_RESERVED,
> -       CORE_TX_DEST_DROP,
> -       MAX_CORE_TX_DEST
> -};

[...]

>         QED_LL2_TX_DEST_NW, /* Light L2 TX Destination to the Network */
>         QED_LL2_TX_DEST_LB, /* Light L2 TX Destination to the Loopback */
>         QED_LL2_TX_DEST_DROP, /* Light L2 Drop the TX packet */
> +       QED_LL2_TX_DEST_DROP_CORE, /* CORE_TX_DEST_DROP value */
>         QED_LL2_TX_DEST_MAX
>  };

Thanks Nathan for finding this issue.
"enum core_tx_dest" is for the interface with the device FW, while "enum qe=
d_ll2_tx_dest" is for the interface with other qed* kernel modules.
The distinction is on purpose, so "enum core_tx_dest" shouldn't be deleted.
Maybe an explicit switch/case would be better as a fix?
E.g. -
-		tx_pkt.tx_dest =3D p_ll2_conn->tx_dest;
+		switch (p_ll2_conn->tx_dest) {
+		case CORE_TX_DEST_NW:
+			tx_pkt.tx_dest =3D QED_LL2_TX_DEST_NW;
+			break;
+		case CORE_TX_DEST_LB:
+			tx_pkt.tx_dest =3D QED_LL2_TX_DEST_LB;
+			break;
+		case CORE_TX_DEST_DROP:
+			tx_pkt.tx_dest =3D QED_LL2_TX_DEST_DROP;
+			break;
+		default:
+			tx_pkt.tx_dest =3D QED_LL2_TX_DEST_DROP;
+		}

