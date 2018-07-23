Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D18EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4F820647
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="K2tLeXR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4F820647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbeGWJew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:34:52 -0400
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]:23721
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387977AbeGWJew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WYvCH+12KeO+EHqII1u/UM2a1gFyRkBH2K3aVKHo7s=;
 b=K2tLeXR6F7lq1WwDJkLlVYx8CdhkidHex0AFuyCLlhU7w1lBkoXM/mVb5suEttARRt3FDSpYIXK+m3noLNxPG+sAR3q/LGaDKwSNgkjfsLClEd6eA4OmcWt4M2jIbeMPgVHpvurRoIay1J/ROXtaHyl+AupZT7H28MVrPLW1PBI=
Received: from DB6PR05MB4597.eurprd05.prod.outlook.com (10.168.20.138) by
 DB6PR05MB4727.eurprd05.prod.outlook.com (10.168.21.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Mon, 23 Jul 2018 08:34:42 +0000
Received: from DB6PR05MB4597.eurprd05.prod.outlook.com
 ([fe80::2478:8e36:f777:8a84]) by DB6PR05MB4597.eurprd05.prod.outlook.com
 ([fe80::2478:8e36:f777:8a84%2]) with mapi id 15.20.0973.022; Mon, 23 Jul 2018
 08:34:42 +0000
From:   "Ofer Levi(SW)" <oferle@mellanox.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Meir Lichtinger <meirl@mellanox.com>
Subject: RE: arch/arc/ allmodconfig
Thread-Topic: arch/arc/ allmodconfig
Thread-Index: AQHUHyKW1M3GsAcZr0iuL832AquqnKSXtOGggAS8umA=
Date:   Mon, 23 Jul 2018 08:34:42 +0000
Message-ID: <DB6PR05MB4597A63819F227B17652B5B2B2560@DB6PR05MB4597.eurprd05.prod.outlook.com>
References: <e074d0ae-6d79-d21a-2278-15d516bb943e@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075012B0724EB@US01WEMBX2.internal.synopsys.com>
 <AM0PR05MB42600653CF591791731CCCD8DA510@AM0PR05MB4260.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB42600653CF591791731CCCD8DA510@AM0PR05MB4260.eurprd05.prod.outlook.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oferle@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR05MB4727;6:v4cfr/FEIBmbZpuKcOHClxcFv1jrUo+Xv9QBEJVJLSl6193ErcctNM7y5WkOLflZ/GaQc+PJZ/1bgcgcAaVUjkeBwl2gzMkP504SGT1uG+cW1ZUS5/j6fpnIjpQ3D9KWvTUkPa5psFokQwq9F+W925KYz7U+jm9CZtZPN4YjxELyKraX2/ZnQMSUZKMbdi8oJlEqVoOh4P0c6Z37IvEqdmNxV9TpKYujOpFZf8I8OcElMGiAOG0sSmM+S8YFKpUai1+DfBJZjzpnV5V+rpZ0fK5l/rXO7E7GF0HZucoYIfzWnXA2QDQzeVCmy868S/oWgnFTfARrHAnwPoZO8REapIddtAvkg/i7kqURlL5TadNg8d01hr+LcmkYbOlRuzs5yfw4RlWNdXOjBX7tth7WPtBqpIkdcyXCapBMx2opSShjGVZxRh91lbeczDsp5dZQXuGtI4eSyNE1JKJJg/vV0w==;5:AMmjoAMWhooQ/lKFPINr1aDFE3iDIvsJbo+f1kmeCZrhMCq/G5QM95uctJAQ34n+Zg+QppmiOhVtyZsO0SGJyMWLORv+1zSqIuZAX1HLZc+f55gaWQmUCHyg/a5guc9DM3l1FBHFNxLeyLJFVbMypeYdLr9pzU8fi68vmfJM23U=;7:6zRtnTNdyviQ/iw8LHXZPhNcfcLik71RHew3/dIkbn1Sb9HKCCnfSZumsp+vdQVtdievfK7ofqJQojb9t5ELBlV4prp83vByzScdcFj4yXr0nF1KgDpLt/O3tRDKJZOArbIaVRZ0KuvNznxU+cXD/ASK8HRebynRYCjL8O95aUH5vz2eix367DAimCSxoOnX4qUGkdHILVoIWtQS82R0ry5AbtSmriTkY07q82QGFq4RyxoE0umkyssyH9CuInf5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: da947d71-6270-489f-6f10-08d5f0772337
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB4727;
x-ms-traffictypediagnostic: DB6PR05MB4727:
x-microsoft-antispam-prvs: <DB6PR05MB4727BE2FB7099EBCEC9464EAB2560@DB6PR05MB4727.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR05MB4727;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB4727;
x-forefront-prvs: 0742443479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39860400002)(346002)(43544003)(13464003)(189003)(199004)(86362001)(66066001)(81156014)(81166006)(14454004)(8676002)(6246003)(5250100002)(107886003)(4326008)(2501003)(478600001)(5660300001)(110136005)(3846002)(6116002)(105586002)(8936002)(256004)(14444005)(106356001)(54906003)(316002)(97736004)(229853002)(74316002)(53936002)(55016002)(9686003)(446003)(68736007)(11346002)(53546011)(6506007)(102836004)(486006)(7736002)(26005)(305945005)(6436002)(33656002)(2900100001)(186003)(476003)(25786009)(7696005)(76176011)(99286004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4727;H:DB6PR05MB4597.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: psQ3Z3fhbpIaeaMCx5HfjYQ+N6mE+SLWSNRPCWEzZ5pIKtPReVyyjrtI8D9kUBQqGHP05i+qYnOHjCsGPENj1biK9N1KLyL/0preV9YIB4hm0+s1EffPI4M2NesE8f4WiC+sJm30zLLX1a4yqe5S8sNWO6oHfDAfbxSJtTmABfKiDSG/nmVHZGEb6lCySWSzjCHfA3fmxLVsVL87POG5jkwGSK13BaMJaUNocR/ysUJdiVrgefYCiwhp5zVT8ETY0tvgIpMiSxvrCv+24OFtmKSsWA3MCUcd/p83LwgLazwYb3eLESceUzD/PzrC224IW4igUIPFtLYgF42KuFEMn6f4RQmLQpQfGh8ivRKZR6E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da947d71-6270-489f-6f10-08d5f0772337
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 08:34:42.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4727
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet, randy

Indeed this structure is missing, following is a patch based on linux-4.17.=
9.
Sorry about that.

Thanks


diff -uprN linux-4.17.9.org/arch/arc/plat-eznps/include/plat/ctop.h linux-4=
.17.9/arch/arc/plat-eznps/include/plat/ctop.h
--- linux-4.17.9.org/arch/arc/plat-eznps/include/plat/ctop.h    2018-07-22 =
16:16:09.000000000 +0300
+++ linux-4.17.9/arch/arc/plat-eznps/include/plat/ctop.h        2018-07-23 =
11:18:12.179402620 +0300
@@ -143,6 +143,15 @@ struct nps_host_reg_gim_p_int_dst {
 };
=20
 /* AUX registers definition */
+struct nps_host_reg_aux_dpc {
+       union {
+               struct {
+                       u32 ien:1, men:1, hen:1, reserved:29;
+               };
+               u32 value;
+       };
+};
+
 struct nps_host_reg_aux_udmc {
        union {
                struct {




> -----Original Message-----
> From: Meir Lichtinger
> Sent: Friday, July 20, 2018 10:19
> To: Vineet Gupta <Vineet.Gupta1@synopsys.com>; Randy Dunlap
> <rdunlap@infradead.org>; LKML <linux-kernel@vger.kernel.org>; linux-
> snps-arc@lists.infradead.org; Ofer Levi(SW) <oferle@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Subject: RE: arch/arc/ allmodconfig
>=20
> Hi Vineet,
> Ofer Levi is now the maintainer of arch/arc/plat-eznps
>=20
> Ofer,
> Please take care of the issue below
>=20
> Thanks
>=20
>=20
> -----Original Message-----
> From: Vineet Gupta [mailto:Vineet.Gupta1@synopsys.com]
> Sent: Thursday, July 19, 2018 19:22
> To: Randy Dunlap <rdunlap@infradead.org>; LKML <linux-
> kernel@vger.kernel.org>; Vineet Gupta <Vineet.Gupta1@synopsys.com>;
> linux-snps-arc@lists.infradead.org
> Cc: Elad Kanfi <eladkan@mellanox.com>; Leon Romanovsky
> <leonro@mellanox.com>
> Subject: Re: arch/arc/ allmodconfig
>=20
> +CC some folks from Mellanox
>=20
> On 07/18/2018 10:37 PM, Randy Dunlap wrote:
> > Hi,
> >
> > When I try to (cross-)build arch/arc/ allmodconfig, I get a syntax erro=
r here:
> >
> > ./arch/arc/plat-eznps/mtm.c: In function 'mtm_enable_core':
> > ../arch/arc/plat-eznps/mtm.c:113:30: error: storage size of 'dpc' isn't=
 known
> >   struct nps_host_reg_aux_dpc dpc;
> >                               ^~~
> >
> > There is no struct nps_host_reg_aux_dpc in the kernel tree.
> >
> > Can you do something about this, please?
>=20
> Thx for the report Randy. I'm calling out Mellanox folks to see if they c=
an
> provide a fixup, else we will revert the corresponding change.
>=20
> @Elad, upstream commit 3f9cd874dcc8705 "ARC: [plat-eznps] avoid toggling
> of DPC register" added reference to struct nps_host_reg_aux_dpc but the
> definition is missing. Can you please provide a fixup as I have no idea o=
f that
> platform specific struct.
>=20
> @ Leon, reaching our to you, since it seems you removed Elad from
> MAINTAINERS file, so I'm not sure if he is still at Mellanox.
> The two folks I worked with on EZCHiip Linux port Noam Camus and Gilad
> have left Mellanox.
> If you or someone from Mellanox are interested in maintaining this platfo=
rm,
> please update the arch/arc/plat-eznps section of MAINTAINERS file.
>=20
>=20
> Thx,
> -Vineet
