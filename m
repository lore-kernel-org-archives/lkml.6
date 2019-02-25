Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A08C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042AA2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="A3fRBfDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfBYTI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:08:59 -0500
Received: from mail-eopbgr820103.outbound.protection.outlook.com ([40.107.82.103]:36832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbfBYTIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45jfGpajWqKHmHBOv2WWQoGskOTCROp3q3poxet+y5w=;
 b=A3fRBfDPI4zQlwzr2a71y9S0pgEH2KWEwU/ivjgmkwLxQ3PQsaZUqJ++I7qAIlNMPQG/GMNtfmhmTfkE0o3LfbuAMt5+I04+jrsEEG/3xWE/FhPeOTZHyZOZV01IcCYQAE0NfamzBdL2uzMwGqEkfdAErT6K7ooCL9GuTFIaCLs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1343.namprd22.prod.outlook.com (10.174.162.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 19:08:38 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 19:08:38 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 05/10] MIPS: SGI-IP27: do boot CPU init later
Thread-Topic: [PATCH v2 05/10] MIPS: SGI-IP27: do boot CPU init later
Thread-Index: AQHUyiut5xL7saKrKkqJefMufCprZaXw5q6A
Date:   Mon, 25 Feb 2019 19:08:38 +0000
Message-ID: <MWHPR2201MB127794C84D61E4B3C301401DC17A0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190219155728.19163-6-tbogendoerfer@suse.de>
In-Reply-To: <20190219155728.19163-6-tbogendoerfer@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:40::23) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad6e8d20-6b1f-450c-8ba4-08d69b54a615
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1343;
x-ms-traffictypediagnostic: MWHPR2201MB1343:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1343;23:PDS11LGN+fviJj1f+F+E8SO5EzuEaSLGpQZWx?=
 =?iso-8859-1?Q?gqHdgrAnsORCVI+iNMhoSPQnQm0qfrg2a1lx3rUy17s0Pfey6vQUiW7Gy0?=
 =?iso-8859-1?Q?rCdTj702qDZDB9lwpIJvJ9OMXd3+YocQxEtcBHjXjI9pkLDvepCIyDNqBY?=
 =?iso-8859-1?Q?yPAnKil5Nb9+vAmJcTsdOUoPumtzwtj54m7pT5zfVh22mb+pdRrp7+N2py?=
 =?iso-8859-1?Q?vFzGAQR6jW0S+txFMBGDT2MeitVKtTd6O8DMLDzblk5Alfc6rVA8SO5+iw?=
 =?iso-8859-1?Q?3uTzOQHb3yllAf1y+eiCmENvaCAc84i/t087euUgBK1LT9f5KIV1U3VOtM?=
 =?iso-8859-1?Q?h8gWFfUYjCgtpBOHCXPf5qLB1l+JHq4FnkBtpdPpRD1/kPbYwj3zgLYECZ?=
 =?iso-8859-1?Q?Krnk0gdg98cvKzDfiHMxauQcYh5p5tdWN/w3B8Nq59MC/NzF4Z8nlvWT9C?=
 =?iso-8859-1?Q?fE/KUWnRQdxR+Kab7a527a6R/6PvhVYV1S5I40XB14XyIqfjquZNjl0pZx?=
 =?iso-8859-1?Q?6MWS7WP0grYrwxYs+le5bdJ/5dtEgRCM2xTN5R50ZwANd3z/J4HsVJ8nE3?=
 =?iso-8859-1?Q?wNuZUCl9De/MCiw6OVFKdBVg7keJY+QTrOCnCi8CSEu1viYh6BZkfJsJH1?=
 =?iso-8859-1?Q?9OEi3FhYVZo2Xh75Qw1fRPFJbp5Gf+rdVImuDSTskHaJvnVrDE7lrzG6x0?=
 =?iso-8859-1?Q?OhGXUt8i1ByP0oaryzbthM6BidGQs1VfROxJmX/O35wWqEOMPODk+2F5WE?=
 =?iso-8859-1?Q?yzyG+WT/OM1VbCm1KnOejRcEoBAaF5NgP95wjnJHEcp0BjdiwRrJYbgyJR?=
 =?iso-8859-1?Q?8IrIe1K+hj9VDVakiWUx/NkkCgaqZPUAp4QGCUuwhMrVuSmUiO43aSSPLo?=
 =?iso-8859-1?Q?z2Ae/DCA1mBO4B4QNyLw+8kDmdvkU1SDcT5ks2jDCiymADaJ6bqFVL4p2r?=
 =?iso-8859-1?Q?sEQOKROT7W5VGjAztpnpmT8O9fbPGOZrwfb+8psBLA3Cyo5j2UYA/YuOWJ?=
 =?iso-8859-1?Q?9HIH0yjPkLrP8uv4mM/u1JjMH8MssCJBGHXmzvuNrwl4gVOh8sZ3yHEfJD?=
 =?iso-8859-1?Q?fcrGuaBrEcoSEU++8fq6sX2S3L+qVv5rkRd0Cvt5zambuSxzQbJ8hZWQ2b?=
 =?iso-8859-1?Q?Gfid4zZQni7ylQ+zEKqLKPTmrAUW/uwvzzdQaB7skJVal6ndT/WbADclpW?=
 =?iso-8859-1?Q?1fjsx87X2rdtA0zIkgtgWRXG1HvDSY0ZPUOWbIPcovVDVwqYykVH2MGRzj?=
 =?iso-8859-1?Q?091JCaa03+Qodp7zx6P/C1B2fKijs93g+Au3N76i3DGw1zT0Z80qrW4wIz?=
 =?iso-8859-1?Q?NoF9KzVCLgBb+e85D5P5bVzKBoiD4iVtlX7SF9g+6YxbtDA=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB1343BAA7DB9E1285EBC75BCCC17A0@MWHPR2201MB1343.namprd22.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39840400004)(199004)(189003)(316002)(33656002)(26005)(6916009)(71190400001)(71200400001)(52116002)(256004)(42882007)(54906003)(55016002)(2906002)(76176011)(99286004)(7696005)(9686003)(6116002)(3846002)(186003)(7736002)(305945005)(102836004)(44832011)(386003)(6506007)(74316002)(486006)(11346002)(476003)(53936002)(446003)(8676002)(106356001)(8936002)(81156014)(81166006)(6246003)(105586002)(66066001)(4744005)(68736007)(25786009)(4326008)(97736004)(229853002)(14454004)(5660300002)(478600001)(52536013)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1343;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fCj7RFJdr3SCMhjYwV/mFYot4vfycxXCCUO4F8Z3sqcEHj+IAv/V2B/UsOMXqq/z15pyAd0hNGaLUH0iQlQwfZgp9xXRGsMD6CUY0TwkpI/ADqS/E07tsSB/ZRUv655t0XpSM+diNHukKjS4qQDMLbDKRwFPiEhR8rRB/zInaEzL2AiMEgtSWEmFcOdqXSpR67yLT+usvbihhbn9ELX1PLz4ezixKfnUDh9uTpIUCXCblzAQCYSChRRs/KuIwuIWf1Ou7dspT/cWRJZ+4TmTpbYr+s6O5mBOudMMaak7FOVMEdwMBCjILRU6g00oh21bUtW1WKFOuGylxCLubjHakCFt5PEJx2El5889jxyq3vres5S9n9Up9VUhTRb7LiyZaweJBb28lhE6WYi4hWRVoOMsSUb5i0lgtQcA+DFihaw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6e8d20-6b1f-450c-8ba4-08d69b54a615
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 19:08:38.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thomas Bogendoerfer wrote:
> To make use of per_cpu variables in interrupt code per_cpu_init() must
> be done after setup_per_cpu_areas(). This is achieved by calling it
> in smp_prepare_boot_cpu() via a new smp_ops method.
>=20
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
