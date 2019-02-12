Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FCBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1625A214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Khae+qna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfBLCCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:02:54 -0500
Received: from mail-eopbgr740110.outbound.protection.outlook.com ([40.107.74.110]:4612
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbfBLCCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ko3u7AbITI3PXQfMPviTKYv28S80u3ZNuvzbqnXFfw0=;
 b=Khae+qnaUo8lC0WpjR6TuQviCo8MBeneU5ey2OLYol2VNU1nmJCS+onfGN8X4vDbDGy3Xurvl8jACYLPEOJnqA7wmBH9K8Npi4g4pMRkV4yWijkYulnHyss6pkfOGAaZ0DXbtG/ONw3Bijq0z66rvUrZsyQzaHMjFi2WXEMB6uQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1328.namprd22.prod.outlook.com (10.174.162.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 02:02:48 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 02:02:48 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dma-mapping: add a kconfig symbol for
 arch_setup_dma_ops availability
Thread-Topic: [PATCH 1/2] dma-mapping: add a kconfig symbol for
 arch_setup_dma_ops availability
Thread-Index: AQHUvGGrfD9q1BPhjUaX7rLQQjZd+aXbdVQA
Date:   Tue, 12 Feb 2019 02:02:48 +0000
Message-ID: <20190212020246.pnxg2tlwejvu45ze@pburton-laptop>
References: <20190204081420.15083-1-hch@lst.de>
 <20190204081420.15083-2-hch@lst.de>
In-Reply-To: <20190204081420.15083-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:40::37) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 908efb06-c86a-4692-a691-08d6908e2fa2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1328;
x-ms-traffictypediagnostic: MWHPR2201MB1328:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1328;23:D4hhrUvzN1PFKdjkHNADyi5AJa8E1FXG809i/8v?=
 =?us-ascii?Q?WR8mhml2/ghGwWXIgqj7HaABu8hlyEEDwbxr57YIPM8k+e65aPmhp4Gw512o?=
 =?us-ascii?Q?UPP4lnyUerVh78qFRkKCvHVRTuhrN/O0COay+0umrZOiKuuy6qPGt+8/NYFo?=
 =?us-ascii?Q?LQrAfcJNMfUEfcvsrfjzFEu8UQ/G89AH9QivUCAFQ3f14uvy3C22C4FfNpHj?=
 =?us-ascii?Q?HkH06B4PavAvr4JJ2zCaf1idkzJj82pr47s+vBy6fIiBKjC0O2mJj5oog3FN?=
 =?us-ascii?Q?ITpLbgbcnmsmFIZGlKmQNuMoYggYqJbG7GDeuU+DMKPI5992ExvSFtjFcKGS?=
 =?us-ascii?Q?iFVJS+Yjx8/8TiYwvij3WDKCUdaxea5o153dKG+SbIGplKZKp5Fo8Jx6n8eh?=
 =?us-ascii?Q?DZbv7s8UUjgpqvGb2ED4YI5HxaELPhuc5LymlPLoOFrcOehF1amnjcX91SC4?=
 =?us-ascii?Q?Ng41Mc3qHDa3cOEFkhHK75qomecRnsuhkv2xXB+IgCWPvQXzk8/MlQ3sk0Wb?=
 =?us-ascii?Q?Rx0nSQUlKvuodqHlobkKIXjntgvEXlm4EFNSAsTYrXYAOGnsS0kN9D33T4Ic?=
 =?us-ascii?Q?MEgEVRH77AJbofNdDyvcnzRc0/1A4DL49/QGVpDoPWsOEZpjBG2NacYyoteb?=
 =?us-ascii?Q?Jz1U2qk0z50TcWq5X7AEfEYQG2FiCut8ZqpF6V68kXlsW60N1+6yFUBTyfCU?=
 =?us-ascii?Q?qeElj6nAKyV4QcrOHJ2DLNWXm/Z4OiOJWnolUF2K+KNh8xOO8mVBlXwTjc5s?=
 =?us-ascii?Q?CvwsJuug4sHMvImmwOK2v8dfkq0N2+W7w0c/c2rIHvWOJh6+WM/CCi1jAevW?=
 =?us-ascii?Q?LFw4vLmr43Q6LnhkUoKjaWP0RWkSCLxFrFFWgg5ttE2h1cQogSXQrNR0jFow?=
 =?us-ascii?Q?wyglBZJmX7duyHkvXGB2x5J74yrGIRZlqaBpXLseY8DzSLSudntS786VvJWB?=
 =?us-ascii?Q?8kMjrVXAVwAdRLSW/Xi0U0UX/akjcm+IBHA77zIPGV9F50PjrTZRf0lK7jjO?=
 =?us-ascii?Q?JNN+mnFaNpWnlucD90ETRFcfo6Hpvq8aqETYIQDwPyhP8gcML5sKB7N9sDrD?=
 =?us-ascii?Q?c3HILyQ6q7BUvbemTvCTb8iNAbzHu895v2hlUBgDeVQjXCE6OStoT8Q7WySQ?=
 =?us-ascii?Q?vCceQiSkEI/rQj/rIv50HucNdGaBhCFEQoGEydWIYMt4O1vAjzRb8ah+qMvV?=
 =?us-ascii?Q?w88/3cffxHIrLhkdq84wJCjKff+z4lgHxpyQ3iaICleQXRnnWSd6DKcVGyyw?=
 =?us-ascii?Q?vSMjrk9PsBiBVqs/qH8MeESNlLaR6hd8+IitEQKvXeSRMF1RWLERku7YPw5S?=
 =?us-ascii?Q?qMwEnAZ3dcrnq7mAjeDkp6Xo=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB13281C706CB3B6CD9ABE6348C1650@MWHPR2201MB1328.namprd22.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(376002)(346002)(39840400004)(366004)(136003)(199004)(189003)(81166006)(52116002)(4326008)(76176011)(6246003)(6116002)(14454004)(3846002)(99286004)(33716001)(33896004)(8936002)(8676002)(305945005)(106356001)(7416002)(105586002)(7736002)(81156014)(25786009)(478600001)(58126008)(54906003)(476003)(316002)(26005)(68736007)(446003)(6436002)(11346002)(6916009)(186003)(4744005)(66066001)(2906002)(6506007)(53936002)(386003)(6486002)(71190400001)(44832011)(486006)(9686003)(6512007)(71200400001)(1076003)(97736004)(42882007)(256004)(229853002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1328;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3J3jOrF5ZV0/e+aCiAn7AjK4hZ6DJsAjQaKbDClrx6HMjCxjmsFt55kUYIpGr9K3NDg5pM0S51kEH6AOIxDoG6CBZujGtGOa9YLXSWGhtRFURZ9cEW8hAF7WNRQgjPj6tiFw8cjOm3f7W5Bi64vGnnDYEQvbbwbI9MiSXnIALRSognH57wB+cd0i4w/4fE7wVZcv67uREW18Cj3oSYwzoS/jFpIaZRaFVp0CrYIOAC1C+qByK8BUjUBbkT88n5vtMz9z74vVgELuJLmxtp/WxagSZ//eaE/f03Sp/quZ8ZHGgvCsnlE4ib8LAzp7K0oOVPtHBXzWrJmaBJEEKIRRgP/ed99n18PNtahTL4dUCeGzImG8Gs/VntQlmbxWmwm0d2IWaQ0YCWrIEAWfDSJdAdox4U2aTTjYttb/yvPcmJY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C4D58356C472DE43A87A2CDF3A97D97A@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908efb06-c86a-4692-a691-08d6908e2fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 02:02:47.7877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Feb 04, 2019 at 09:14:19AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig                     |  1 +
>  arch/arc/include/asm/Kbuild          |  1 +
>  arch/arc/include/asm/dma-mapping.h   | 13 -------------
>  arch/arm/Kconfig                     |  1 +
>  arch/arm/include/asm/dma-mapping.h   |  4 ----
>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/dma-mapping.h |  4 ----
>  arch/mips/Kconfig                    |  1 +
>  arch/mips/include/asm/dma-mapping.h  | 10 ----------
>  arch/mips/mm/dma-noncoherent.c       |  8 ++++++++

Acked-by: Paul Burton <paul.burton@mips.com> # MIPS

Thanks,
    Paul
