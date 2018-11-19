Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A4AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E9420851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="DvJKXGcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E9420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbeKTFbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:31:45 -0500
Received: from mail-eopbgr810120.outbound.protection.outlook.com ([40.107.81.120]:5184
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbeKTFbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaPfdPPEPJC3jLimx/iMNqSSW5uoAHmIRE+x0pcuXbk=;
 b=DvJKXGcAMPtFg2MVQ7IiXo7Y1nGe0NPCNtJ17wCJywNpHY66w02lF/0S9MVK5pozHGAg45LwrRTuwtSs9VEWrPq3UgO6Usv2tCHdEwEAPraDyxSvLYB2bJrnET5uqPR36LB1qezvEe9jNZNVEYIwPdAQXp4bRNy3IY3nXLS+l6Y=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1726.namprd22.prod.outlook.com (10.164.206.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 19 Nov 2018 19:06:43 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 19:06:43 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Rob Herring <robh@kernel.org>
CC:     James Hogan <jhogan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Use device_type helpers to access the node type
Thread-Topic: [PATCH] MIPS: Use device_type helpers to access the node type
Thread-Index: AQHUfflIdVEiIPAxNEGMNd/eIEjpmqVXehAA
Date:   Mon, 19 Nov 2018 19:06:43 +0000
Message-ID: <MWHPR2201MB1277675B043F1E9F2F78479DC1D80@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181116221104.23024-2-robh@kernel.org>
In-Reply-To: <20181116221104.23024-2-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0092.namprd02.prod.outlook.com
 (2603:10b6:301:75::33) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1726;6:sjA2jfNICO89jPyFDXPicCcn7kkXG43WMROSaZ9a4aeP2Mu8a87nMTogq1Ni/Z9OO4AM41gdK6ktwGv8ClghuiiRVgYg07zy5wd5wq3WivIfty72JH4+94QRqslpmcYegX8B4pFMSmBjPUf+1enq7rY1Wi/k4H6FYXj0C2/Mj9qnN2d0leM3+PkZ7kn0047w7vaW1GdF7n8lStdsqDHvgqhXTiSnTZPgSsFTXbmhz31EpVjATao3HKs7Bi7VnBPSfOh7Ji887brK3CORiyOycEnsZ+QkLJoyacqksw8pJq+O/SgKlCYdfnUnSpDoCk4EzglvlH18+UjW7L4lZHDqQSdEy3iwfIngtNQ1sGeHZsOOftyldj1iejEOwY0h+BNlOwh0o4Qe17Ur8+8NXxWhMnCs+kkR21+Nl1z6w/GkGwwZcVNAsjIwJ+BPgtjrGMU3/SAE271nepzxB0MikBzwyg==;5:dxX2/5c2F08SVNbJcXylJx06MzJg4dkXHO1PrTTfVyoi/FLYNxPZU4r+3AxLCX1maLSi9OWG5dpZRFcmPduny71V70Yufn++ia+5c2kHmnx7CD302yD9/N1b88r00xp5t66Pvx5ZGdTrYyevvjiD1qc5LaJmnukAoiazpyq0pp4=;7:oS8WZUlMl5O4fD/xVPh1dHAF98ELwO/ophucs8bdNAoM/kIEVPAqh4RP+cof1H4T2kjGy6YMeKcY4UBHnGii6rv7SSfYsRGITX5NDp1HqlTZ6M+W6VjbPMkZSqlLI7ddLU5J+f3ozXEZkCrPWHUSZA==
x-ms-office365-filtering-correlation-id: c1a26f0b-1e13-41a7-5712-08d64e52250f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1726;
x-ms-traffictypediagnostic: MWHPR2201MB1726:
x-microsoft-antispam-prvs: <MWHPR2201MB1726F794CE6636047257B4B8C1D80@MWHPR2201MB1726.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1726;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1726;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(366004)(346002)(39840400004)(189003)(199004)(44832011)(71200400001)(508600001)(486006)(14454004)(97736004)(4326008)(71190400001)(316002)(256004)(2906002)(2900100001)(25786009)(476003)(11346002)(68736007)(3846002)(42882007)(186003)(6116002)(8936002)(6436002)(5660300001)(7736002)(26005)(229853002)(76176011)(99286004)(446003)(81166006)(305945005)(55016002)(9686003)(8676002)(74316002)(81156014)(33656002)(53936002)(6246003)(386003)(106356001)(6506007)(105586002)(54906003)(66066001)(102836004)(52116002)(6916009)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1726;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ms7jdsqsvaGF7nJwRuzy/bMtvzxJdum8lf3TA5aoeUg3ABQQuZFFx9XR2KAwBkwpwkKFkyFN72nmN3QM+/0Z8VToLfL4GLoXPJoekIMIqDTNiugekTpdIP4mBEgYJd+cnyQ/zhJUnHSX82j0w/axXR+w3CcMgCAgXbmL85jZ8PyPU60HeM6NoxftK2p48LQccFepuKjUHEtrifmW+ouy3TZLX4QpR5UQniXHNUpjWgNKQPxjUKVIxFAtzEAKVs8CaYanzWoqiJN2Wonq1/L0+XyOdT8yFQNFIatF27HZRnsMfHRG5NxAeR6IcP7JBd22gmWhDxbo1kKgWcRdiLOAd69zQEpzBHaxNCfAYQYdLSA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a26f0b-1e13-41a7-5712-08d64e52250f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 19:06:43.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Rob Herring wrote:
> Remove directly accessing device_node.type pointer and use the accessors
> instead. This will eventually allow removing the type pointer.
>=20
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
