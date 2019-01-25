Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF69C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9C6218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="EtUGg1V+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfAYTRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:17:19 -0500
Received: from mail-eopbgr730120.outbound.protection.outlook.com ([40.107.73.120]:54562
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbfAYTRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgDNkab9o5zSZchFV6J8+RFrfL4PrOIrFTKkK0M+8Bc=;
 b=EtUGg1V+l3ZQAbJvIS5R3gcLEbJ4wH627ikOIVgbM6hu+F4AKg7XLYnFfjJU83Ku0x/uFzN768ZloRHGYRYZI0EXI2vcqW6ItimgdfIxRvgo6EU2fpz0QW2D7OPggYi90tr9RDBG3m2GmLntYy7fFHGkY1NxgPf1K4Lyph3PLy8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1310.namprd22.prod.outlook.com (10.174.162.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Fri, 25 Jan 2019 19:17:15 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 19:17:15 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: DTS: jz4740: Correct interrupt number of DMA core
Thread-Topic: [PATCH] MIPS: DTS: jz4740: Correct interrupt number of DMA core
Thread-Index: AQHUtNmbp2nZQk2iQES0PqaDbTbeeKXAW3QA
Date:   Fri, 25 Jan 2019 19:17:15 +0000
Message-ID: <MWHPR2201MB1277416043C4C087210F10B1C19B0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190125181245.9966-1-paul@crapouillou.net>
In-Reply-To: <20190125181245.9966-1-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:300:ad::13) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1310;6:ushhZHRl9UbmtjmW47nSAtBCv20iB0UKqX87Y0gYXdmwXVKoslgPMhA1+XJ3iTiGwk2W1YUNW13nFMbK1YqDTEev6GGvzB6xp+yB+FHrB3TzZbHUC8bp5doqH2JUdXk+rQdPcwENti2Ztz8nvSwtOneksalySJcDluGYBfVA1kzu3KCqNk+Z+pMBqV7w3Oe99nAmsUqNAl9QHO+ZsVF0mx3a9U5wpe2zNTESMo7Fd0uNTVWgTPBFzUbYkWdFLd+b320Kj22FmRk7xPemmYnSGAdy1JPpt+c2rd03iVQGBA47GfqijbrK4n1iQTA62iEuKAMeQ5Yrwqe4iJ7RRVC48jtKWjZmOhrNQuCJEwvMz1bGtwTaS90d+oGpzNKv+qo6L8UYTH3Bq6UnkCCG66FcCzUQqhn7DqhEa48pkSQnLA5ezdI/FUg43LInYxt5hzwtPhr2GUfQxG7rGIEdA6Sbsg==;5:O7CoY6ts4MgrH6ooKN8mXpzg2vkMYusC6VfEUdUXY7V9aIeJKgS7VxdoD8FqIKG1V1f2FjiNYF8Vyp92S8IJ5DTwmVb+Icy8OtrvcEZWCbGO+Zjmzn1dqlP32B1RB6PMIKZXZFXaj2Dgc8sgfXTUhbjxYGH32KMGp7O3Gvu7tocUBirwGiXanPsOt2tCfj/n0sd0SJ8/MR8Z5zvqjbjTZw==;7:ofqKzLGXA2oecsrVZEqkSXtqS0AxLY5hMcZJ5bT4PtKmUiC9cX+rw4MM5pGU2u7Q48P+W634rLTouJakkKG+90dxhI4ziV2OfcCsQ1pSrVbQDIQHwmFKxPxWsW0P8tc3LvoFItQLu4r+RL6HGJjjcg==
x-ms-office365-filtering-correlation-id: 5f4f4826-ea2a-459e-5e8a-08d682f9b73a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1310;
x-ms-traffictypediagnostic: MWHPR2201MB1310:
x-microsoft-antispam-prvs: <MWHPR2201MB13105DED083F89857CAF453CC19B0@MWHPR2201MB1310.namprd22.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39840400004)(346002)(136003)(189003)(199004)(7696005)(55016002)(52116002)(97736004)(76176011)(4744005)(6116002)(99286004)(9686003)(3846002)(71190400001)(71200400001)(25786009)(14454004)(4326008)(106356001)(105586002)(53936002)(478600001)(6246003)(6436002)(229853002)(476003)(486006)(44832011)(11346002)(446003)(6916009)(2906002)(68736007)(316002)(54906003)(66066001)(33656002)(256004)(8936002)(186003)(81166006)(81156014)(8676002)(42882007)(386003)(102836004)(6506007)(74316002)(7736002)(26005)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1310;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7VgVsU9zE7WqW5ofdKK2FThW57szRJFweGiaPP6kdN6iAnPXP08BwdiTsdqiQDtVgZbyq1Obk8c7Xysuwe9dMBruhHvFyLBc125rgg2TNkK/kENKxrnuE+Des0NM7JwDxNmANIzcgtN5mgLDlG4tmGfwQYJxKQL5GzceU7i8nWx8jGsD8IHqVozizKUaHBlWyerZvrMcgDJtZQ1za1i07gXCRkmaUhSoOQqpj4NVb0d7EH6ueRiHuJWRhInQDfkQ4MZHJazT/MGAt1WL4dhlQ0FX61FxRcdB+CmWpVwfRM1Hmj+VM5dowSwGsZj4Hf8RGHM9UdqaaV5xAaOJHLP7I8038H9vRPL1oRtAXT1z+8G9R/tvxwN92vwMbknxB4/O6+tD+XLaCieU8wq3wx3WJtmkA5JHGRB6p2iueFZlsxo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4f4826-ea2a-459e-5e8a-08d682f9b73a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 19:17:15.1246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1310
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Paul Cercueil wrote:
> The interrupt number set in the devicetree node of the DMA driver was
> wrong.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
