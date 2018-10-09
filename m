Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE2ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259E420835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Ap50zMde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259E420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeJJBSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:18:11 -0400
Received: from mail-eopbgr730121.outbound.protection.outlook.com ([40.107.73.121]:53814
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbeJJBSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoyJzHoQjAyWLVtmSMXMCGYUpm+9zV9Pd4sQByZUQos=;
 b=Ap50zMde1+DXseaUpIOD3PTBsctTcjHXzjk1BKvY+EcP9yPPK2Kj+7ckTZ8YZjX0Zco0IeYnqetiD1fe30NDW37+ENpeGurYhkOA/9gvvtQLI5ih9t0dqtlwUVtb71MNkbVaAOAWdiFdsNEvJDdp4g9e1TLXV+xhxKyyFRf0L2s=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1175.namprd22.prod.outlook.com (10.171.240.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Tue, 9 Oct 2018 17:59:56 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::149c:90e9:9414:1330]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::149c:90e9:9414:1330%5]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 17:59:56 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
CC:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "allan.nielsen@microchip.com" <allan.nielsen@microchip.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>
Subject: Re: [RESEND PATCH v2 0/5] net: phy: mscc: add support for VSC8584 and
 VSC8574 Microsemi quad-port PHYs
Thread-Topic: [RESEND PATCH v2 0/5] net: phy: mscc: add support for VSC8584
 and VSC8574 Microsemi quad-port PHYs
Thread-Index: AQHUXu/JQnRspSa340Se5a+sqepvm6UXNeEA
Date:   Tue, 9 Oct 2018 17:59:56 +0000
Message-ID: <20181009175952.sobaj4xedkpkjaqw@pburton-laptop>
References: <20181008101445.25946-1-quentin.schulz@bootlin.com>
In-Reply-To: <20181008101445.25946-1-quentin.schulz@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR03CA0089.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::49) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1175;6:tglw1IHLox0IfvaJa6zYVwzQSpS8u5w5PSFCTVys+oSu62h4p/nBRCFvt+II0MnuJ3OgMA2InjROTJBcQj+grCBrKI8ClDnFBojOm9yuSbyj8CmlmuPStfY5cM55yg4DBVI097uagI7VxULhh2vUHK0ZWSu9UJrqIxLwykTYwUYn+RLyZkQ3WAmiFl6CAbVBE1XIwXaouaRs3sHDzw/CGtVBKN3xQnMq+AMpjD7+H70xzEALlAJ0tpR+a3UwmhGIxLKLaxy2WdeCXWiIHlRlbKaMOMi8G2MVvLZ3qCXCOv0B+tfIfoI7Nt/J0jGGpOybDniOjR32lYzPszMd1gcTCL//CqQ12N8zdzpwuIHhu2XuXJvORx52t2+ZiZpYMN+W7MWuMgS9d2QjoAXmpkwVphbslRXmgHpkv661h+fZ26P4dwlN93R/AnBZVOoiOwu/n/oFcD3htPfF/BcN4VbERA==;5:HoNd4vtylO/qC5gX/NDg4tpii2mziJ0kJuyrCrmxrbPPT/MSxOxzmTgRYTbvC6k9d70A5EJnZWoiOsBEGlZ2REYL7J44WdK5Ys73DA66cx9jpFLccxToGvL3TMX0RbOjuSKS4SNHlPsmQfAHlq8x/1k3iCtN1TrZNYr9WHt89vw=;7:OXdHzHeBVpb9NEaiqDSOMkZx2HyIv/RD0JYiLnW0DUkz7hnQYF3BzqSl2H21CdgV5Dq5m5U0v3z6+ZvRJKHt5wUcFRAxsq4JmzYnvgEHuNzSTX2y8s/JXm73HmAoL26J+M5XNsol9JbooSqMTHqVtiJnI2oB4UUebIFPolNhJEnBTJmcrIujiAATh4d7D5nzzBKF2C4nxh6a5kugeF3EPcwmfO4J1fLPv8v2CKrKn8BhMtduYOKKMmxS8lC3MxLH
x-ms-office365-filtering-correlation-id: 5ae9bedb-52cd-4756-f54c-08d62e1104f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1175;
x-ms-traffictypediagnostic: CY4PR2201MB1175:
x-microsoft-antispam-prvs: <CY4PR2201MB11758DBC8C08112A8DC02A22C1E70@CY4PR2201MB1175.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051);SRVR:CY4PR2201MB1175;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1175;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(136003)(39850400004)(376002)(396003)(346002)(189003)(199004)(6506007)(33896004)(2906002)(386003)(446003)(6916009)(44832011)(7736002)(14454004)(11346002)(68736007)(186003)(508600001)(5250100002)(7416002)(229853002)(476003)(26005)(66066001)(305945005)(42882007)(106356001)(102836004)(105586002)(4326008)(5660300001)(52116002)(81156014)(99286004)(39060400002)(76176011)(8676002)(6486002)(6246003)(6436002)(81166006)(6512007)(9686003)(486006)(8936002)(54906003)(53936002)(256004)(71200400001)(71190400001)(25786009)(1076002)(316002)(6116002)(3846002)(97736004)(33716001)(217873002)(2900100001)(58126008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1175;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8UUTnPYli1c8dac9vOgSXxMO49LhQsRyWXRFk8dITPBUP2b9ZXX3yA3kepi4yyeDS9MVoiCSxXRW/w0SDMOFpd1rDq6ZFXjFqQN9Q0qEjdW+kL7tGfKA6EDS22U8QM40QTYjKwQ3GFI5kt1Ksyf1BEPO8UFRWKn4OCzvc/w87eg4Lg79F1y9l0Zn7++1jMqaT4iuQlwwbODM2LaVDNs3emDSEGKFQQNsy/79AsJm5KWFpwKTlTFhbSo3QB29b36EnR5XuLJ1zgIzY95QbbwuN3+KDy1/qKGLeI2QnS1wxFQXi4C0bMmzd0VPwTTKBZ+L9nIWZG//u781L5cSCO02ZJ35z93CCrdgFCHKE0z60aA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4599D8FCF11813488A788AE19D1C3179@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae9bedb-52cd-4756-f54c-08d62e1104f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 17:59:56.3165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Mon, Oct 08, 2018 at 12:14:40PM +0200, Quentin Schulz wrote:
> RESEND: rebased on top of latest net-next and on top of latest version of
> "net: phy: mscc: various improvements to Microsemi PHY driver" patch
> series.
>=20
>%
>=20
> I suggest patches 1 to 3 go through net tree and patches 4 and 5 go
> through MIPS tree. Patches going through net tree and those going through
> MIPS tree do not depend on one another.

Patches 4 & 5 applied to mips-next for 4.20, thanks!

Paul
