Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75682C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C98218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="j6uQL3xM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfBITi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 14:38:57 -0500
Received: from mail-eopbgr770127.outbound.protection.outlook.com ([40.107.77.127]:20293
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727221AbfBITi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 14:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Tz7CXDIlSGB7/AnH8t17YYw/2pXaByp79DvCkSqaHo=;
 b=j6uQL3xMR4MA486zfkyTW0ki4Tj7Q4jjYcnHMWMJdL0T/qUYbeOjEDeB8+tdLkOAvz31lRhVKMWlS06wL+buVxaFzv5GN3B23XLNFxkIQl86Ppxc3cREuDEGqvLrsSGifwFV0I94DwONlNmGbjk6kafQtymUhx2HEZg2jqa0zc8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1728.namprd22.prod.outlook.com (10.164.206.158) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Sat, 9 Feb 2019 19:38:51 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1601.016; Sat, 9 Feb 2019
 19:38:51 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Tom Li <tomli@tomli.me>
CC:     James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Oliva <lxoliva@fsfla.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform
 Drivers
Thread-Topic: [RFC] On the Current Troubles of Mainlining Loongson Platform
 Drivers
Thread-Index: AQHUv4iaADGqjKpPI06v8WRtTh6JiaXWVScAgADrcYCAAJ6AAA==
Date:   Sat, 9 Feb 2019 19:38:51 +0000
Message-ID: <20190209193850.tcg46ckwz4q22dwg@pburton-laptop>
References: <20190208083038.GA1433@localhost.localdomain>
 <20190208200852.wcywd7yfcq7zwzve@pburton-laptop>
 <20190209101132.GA3901@localhost.localdomain>
In-Reply-To: <20190209101132.GA3901@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::26) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1728;6:65cvtQgmsgUWTye8FsjhxR/qOt9yK8xwThYD+GCsKhUGFbxQsxxTQuLsK2YTWnGwhtc9ALFXE729JREpBbXmcKOeLNXQrfCjcOY4hDBpTgMrAwtlCMM/1fa3811j7ueDklEBEPJC5d8Rmhloz89BXwPxuB/udlQp+nedlmeOwVeKeBVsVd2mH0tFF6SwdiATh+nCpeqGqbjDGDulI/KiUJl662yGx1T/fxaYlG9I/Cjlv2jczlSFdJQrVadSjc1L55gsB8Cx4roXal4ziYvJ2hVSjb00Reztcm6L2xEZ9iJv/Q4/WZR3Fxor9VE8PcuqXXD8vLKia8cbg4XwyUYc1uu5eOpTqj7PI9h6IYrb1iNrb7rQFgarYQypjYeaiVUlsukMRfaUwM9NNNKMnMaZH3Yp0qXmaewP8S80aORiyGTAKjMsiAIXjc94DDKVXSYkQboHc0zUKT1gY/U6VZTmLA==;5:15/Ty3xhHdG0BHGsLrmdxvMaXBsrQECTJ/jXAlSOVG8VrDKSO5msY1u3mxU8F09WJvbVzy1QAMrmbjYHAfO5zqMp4FCbQWYBE+eFOr8rGFzFKZFSf8Coa9DM4toc2nFBo4thxQPOZuZOTIAmoFAx1zZLfbX0ejs4O0TF1zw1PHPYv5klkPYQHZ+xJKEdd9E8/JUHPkEdMLur93fecDqDeg==;7:59OJMIB656iuj9dM5Dswk6gR1g3pbY4MJ+RkBUHoy0T5OXZDIezLIdIGuBJomnC0RQJZrBurTWIAGjj97GpGZt45nwaQv6tyG57vj+P6UBUtB1MKUg34cWXTr/S9385hjFJFoW+rFf9EbRr+l6nJqw==
x-ms-office365-filtering-correlation-id: 92cc1fa4-2d35-4982-9d01-08d68ec63806
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1728;
x-ms-traffictypediagnostic: MWHPR2201MB1728:
x-microsoft-antispam-prvs: <MWHPR2201MB1728C774574DAB6F541A9E98C16A0@MWHPR2201MB1728.namprd22.prod.outlook.com>
x-forefront-prvs: 09435FCA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(346002)(136003)(376002)(39840400004)(396003)(189003)(199004)(71200400001)(1076003)(105586002)(71190400001)(476003)(6116002)(106356001)(3846002)(6246003)(42882007)(102836004)(486006)(6916009)(68736007)(99286004)(97736004)(44832011)(14444005)(76176011)(53936002)(33896004)(256004)(52116002)(186003)(478600001)(33716001)(14454004)(25786009)(6486002)(66066001)(7736002)(305945005)(81156014)(54906003)(2906002)(6506007)(8676002)(26005)(81166006)(446003)(9686003)(6512007)(386003)(229853002)(58126008)(4326008)(11346002)(8936002)(6436002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1728;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fPH+Q1UU09Azn2QE3yxUVZbK3Q4HXnYIADpJNsp7IVTpqwFOeVPHZM/B9lXIQrpvnyauaekSRI9BNWrmE/LujnEZBbdAEYmKhtMdnleBmQPBHhBawr5ZZ+nrZ8wA/BV3kZdXtaeKPQA7+8miz2f10sjvwKsS4r18738sQU7/kWVGlI5FpYhCOhnF4mYYSf1IYjiNNdbLRktNhs3N3QM5cLql/5s85KnaW2sjX2fcC0CKS+GH3G7wO0xwT5moGlHw2ADeopa67XNOG6JK0+MIVYJDHk3XtA9UP+gkO4X7EOV6YGa5UssbWanFd5CGpimTtbMot++stuoPlanq+v/ixrVm7Spz7G7hCkOCG1CjRgIX7I0drDuLbPhC1Pk7tHVh86diCHHCdhqUS677MMDXoXPCyOoottXmBeQ/kMsRYos=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1BAF5B3B13981418BA21C22B598EDF9@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cc1fa4-2d35-4982-9d01-08d68ec63806
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2019 19:38:51.3579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Sat, Feb 09, 2019 at 06:11:33PM +0800, Tom Li wrote:
> > To address the particular quote you give from Dmitry Torokhov on the
> > yeeloong_hotkey driver - just because the driver as-is includes a bunch
> > of non-input related things doesn't mean that it should or has to. From
> > a look at the 2009 submission it seems to mix a bunch of policy into th=
e
> > kernel which really ought to be elsewhere. Generally the input driver
> > reports that a key was pressed & something in userland decides what to
> > do with it, whereas this driver seems to attempt to bypass that & prod
> > at unrelated hardware all by itself.
>=20
> Sure, the hotkey driver has some problems in its current shape. I think
> the existing code makes some hotkeys on the keyboard behave like a hardwa=
re
> switch to order to implement rfkill hardblock, and also controls the vide=
o
> output switch. I think I need to investigate it further.
>%
> I find reorganization of the current Yeeloong platform driver is relative=
ly
> easy, since it only involves one machine, I'm already working on it.
>=20
> If future developers find it's difficult to support new machines, we can =
simply
> have more discussion, reorganize the existing hierarchy further, and make
> incremental changes.

Thanks for working on it, I look forward to seeing your patches :)

Paul
