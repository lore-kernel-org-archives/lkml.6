Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DB7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDBF222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="E+sbEZrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfBLRld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:41:33 -0500
Received: from mail-eopbgr710126.outbound.protection.outlook.com ([40.107.71.126]:31724
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfBLRld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzHri6CLot8P0aoDr2YWXhFBeBcNIkmWwnUxAzEnLSg=;
 b=E+sbEZrhBgMyXJZSp0QxTvkzAobUG5qTTag5ULBZI9dXOxXON+RRG9tXWH3OrAaeGkfq0BQzIdd4ilyyoEJ1tdmg87sFVetsBR5B1SrOBK1ogtrLVrexjMpF3GebMA2opOR0dKSOdS6fMpp0AhQZkfGuF7NnmO1A++mM2DSYE4A=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1310.namprd22.prod.outlook.com (10.174.162.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 17:41:28 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 17:41:28 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 01/18] MIPS: lantiq: pass struct device to DMA API
 functions
Thread-Topic: [PATCH 01/18] MIPS: lantiq: pass struct device to DMA API
 functions
Thread-Index: AQHUugtMSEi4XkuS4UKpOJkg4WEy1aXcgEOA
Date:   Tue, 12 Feb 2019 17:41:27 +0000
Message-ID: <MWHPR2201MB12775A18B8F8F034F44D61BAC1650@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190201084801.10983-2-hch@lst.de>
In-Reply-To: <20190201084801.10983-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:a03:60::23) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bcf1dab-6dc1-45dc-3d80-08d6911150ac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1310;
x-ms-traffictypediagnostic: MWHPR2201MB1310:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1310;23:QP+EYlsHeR091078ttrQ7IO9Q0xF+m93S+82Z?=
 =?iso-8859-1?Q?t0gbh8nPK27K6BFCqAuk/T0lGj9LH3zntRlKnOrB2L6WffDn4CZsLjXv7r?=
 =?iso-8859-1?Q?EB69PM6xqc1FzEVpOday5SrEQ99fQNSufUlw0laDw2c0iKpHIATULbVe0d?=
 =?iso-8859-1?Q?DtvWT8+UZ7wJZ34awbKeeBXjvSUaoTSmAwNHDWXtQzw1RPVsWppUbId/St?=
 =?iso-8859-1?Q?19flm326sRLtRDAPckfISdzDfo0tG4dQ2R7bo7C0ZRq/IXHIWvvOd30Q15?=
 =?iso-8859-1?Q?hIGWJcidYgAPuFPtdkxtFuWyFRJk8JJirvtSHgd+htjGnuF28PSzfUyLGs?=
 =?iso-8859-1?Q?bFOHCSWI1P+UCMOyH/hmeBXP4S8xuASkkauCgqQ/Z5jTIPYho8NlO2kM6t?=
 =?iso-8859-1?Q?I2WUt2T7YZ6lOuYiIhElo8C8TMnPe/3eyU/dwkUDyrofD6Ko/IzMMZKV27?=
 =?iso-8859-1?Q?UrnsUyqr3v9oxmUaVUgGj1F74Xxnbc+sNyQFgIq+XMIdaGGiQAS4Zb661/?=
 =?iso-8859-1?Q?dUGrGHU0xE89OgfD8RvN/H2MxCANfrYPXjulmWb7Q/v2qlFFUa/dWX0Uf6?=
 =?iso-8859-1?Q?KkE8FvXc/rFR90q6t/nrgpI2EsHYrWSETBHxgRiy3Y12kU42o6NtG9eFSz?=
 =?iso-8859-1?Q?VE47sBOm+Ne7PMb39oDHqSBfNfh/ETUM7+Y5fjUPmvEMPHW4KLxNOcZ9U6?=
 =?iso-8859-1?Q?Qkt643Hq3iv634I4T5x5hJa7JTZJ46mzV6cCR293utf1SaVcaWeaogkAbm?=
 =?iso-8859-1?Q?abRMnLyvdShitQgBFetnnA5K3SGcQIEUypmS5A3JqTuza3sPuwwUKosqbV?=
 =?iso-8859-1?Q?Ts4ui7oW4JDH1p01L+EjH0D+8PogBunFyM9WJzEfIQukscNOIHkFrTg0VD?=
 =?iso-8859-1?Q?XkJ/dN/18SLy1omJmN1wmHENJCZScynE1qHMYRf36C8BSwUz4/syepX+I+?=
 =?iso-8859-1?Q?NAR83BIb6kLIsYnqRHG9HrFADl9DQAEmrAonAZEdEU5/RmZEmJ8/zfQSW1?=
 =?iso-8859-1?Q?sDAxXTwJizT71V9rAqsLThVsHieEqIYn9SyaR/IV/vFr0rXMxbv2FuNiq5?=
 =?iso-8859-1?Q?6jPIczPZHt1SQWoC4t/faY5V11dy8KGroeIwbf4PA533ilJupi3PH5ioG2?=
 =?iso-8859-1?Q?RAh07rat5ianAm3tzb/ti/PZ2MLSBqkNV++hsCd7KT5kvRCXfxsuai4iUA?=
 =?iso-8859-1?Q?5aF3DLVERQ6mzTsk3YPbXWOHXXqtNjMiPGihEn+/9NLCKSgW0wDF2hIL6j?=
 =?iso-8859-1?Q?ozSe+3O3HiSyKBmdRlCBhyS4raUv6lPOTkwFNiOi7TeYxNdBohFt8YEuY/?=
 =?iso-8859-1?Q?dtC0/zv7mx3JqEPNK1fSCHyQc+fIIPWQRG2DsTmueAec7tg=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB1310C4425C2B57E4BD644464C1650@MWHPR2201MB1310.namprd22.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(366004)(376002)(39840400004)(199004)(189003)(97736004)(6506007)(486006)(42882007)(386003)(2906002)(217873002)(6916009)(81156014)(26005)(66066001)(8676002)(102836004)(81166006)(44832011)(7736002)(305945005)(256004)(186003)(68736007)(14444005)(8936002)(74316002)(229853002)(316002)(55016002)(6246003)(71190400001)(4744005)(53936002)(6436002)(9686003)(14454004)(54906003)(106356001)(33656002)(105586002)(71200400001)(478600001)(25786009)(3846002)(7416002)(11346002)(476003)(6116002)(7696005)(446003)(99286004)(52116002)(76176011)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1310;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ihiOkelFhYgx9ZNXxh0GRQ67FNNLb5y1Pg/x3TkjtU2QOVEaDFFMv36KCAc0O05q23qe1FcoRXi+d4/YVRoUEp9bf5fFGaWqldAd9c8om3BUd0ptzrvfA+C1o44+2+mgvqU7qbnmFGAC0YmHPsO8iymQjn8cLaPy3u41pSdnf52Hft+ZccchAj5VxdEm+9c+ZEG/sMHw8KD8SM9tP25c44m/26eCLfw9gvb36PeKaOEFQr7mI6z/xPlNGas598Eh1l3gBW745BfHm3gFVnRPj5tmPMYUEZ3JJKkOHfM6Ea1/P/hfbiFTHz0TRs+wXOWLVQdqE5zmyMNliJ5p3U6cWPukF3a/HRlndvk6Q0h+8E5ROjSkSeqseYBSv+LikMR8Pmr9wyTCbALrWQOEw+Xe6yg8ZUoKHgjrN4GDxYbwEg4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcf1dab-6dc1-45dc-3d80-08d6911150ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 17:41:27.2880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1310
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Christoph Hellwig wrote:
> The DMA API generally relies on a struct device to work properly, and
> only barely works without one for legacy reasons.  Pass the easily
> available struct device from the platform_device to remedy this.
>=20
> Also use GFP_KERNEL instead of GFP_ATOMIC as the gfp_t for the memory
> allocation, as we aren't in interrupt context or under a lock.
>=20
> Note that this whole function looks somewhat bogus given that we never
> even look at the returned dma address, and the CPHYSADDR magic on
> a returned noncached mapping looks "interesting".  But I'll leave
> that to people more familiar with the code to sort out.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
