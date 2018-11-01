Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B3EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DA22081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=scalemp.com header.i=@scalemp.com header.b="b0Q+sgfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DA22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ScaleMP.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeKATmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:42:00 -0400
Received: from mail-eopbgr730052.outbound.protection.outlook.com ([40.107.73.52]:14416
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbeKATmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scalemp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud4H0E+j+xxnqlUquiXfWxPAUdy+qrb/TpNTyjHEfuA=;
 b=b0Q+sgfWxUrvegxIqDSvh0/8dNG0T4Ax8kBXo0r1GOSKrojHQf0Ss6csfOyL9cqBWpLWZQ4EbdQpc+6OzFswmDLCB7li4oqiRk/+qEy8rciQSBP/WA6gm+Ek+m8gaJsVFS6mv4UQAiwg7zh21FHDI/Of2NeJ18LiouU/GW2PAy4=
Received: from SN6PR15MB2366.namprd15.prod.outlook.com (52.135.65.138) by
 SN6PR15MB2302.namprd15.prod.outlook.com (52.135.65.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Thu, 1 Nov 2018 10:39:32 +0000
Received: from SN6PR15MB2366.namprd15.prod.outlook.com
 ([fe80::c073:aa0d:f9e3:d795]) by SN6PR15MB2366.namprd15.prod.outlook.com
 ([fe80::c073:aa0d:f9e3:d795%4]) with mapi id 15.20.1273.028; Thu, 1 Nov 2018
 10:39:32 +0000
From:   "Shai Fultheim (Shai@ScaleMP.com)" <Shai@ScaleMP.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mhocko@suse.cz" <mhocko@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        Ravikiran Thirumalai <kiran@scalemp.com>,
        X86 ML <x86@kernel.org>,
        "'Eial Czerwacki (eial@scalemp.com)'" <eial@scalemp.com>,
        'Oren Twaig' <oren@scalemp.com>
Subject: RE: [PATCH] x86/build: Build VSMP support only if selected
Thread-Topic: [PATCH] x86/build: Build VSMP support only if selected
Thread-Index: AQHUccajbE8IAQT1EUWHnd0mzn9MGaU6s43w
Date:   Thu, 1 Nov 2018 10:39:32 +0000
Message-ID: <SN6PR15MB2366D7688B41535AF0A331F9C3CE0@SN6PR15MB2366.namprd15.prod.outlook.com>
References: <20181030230905.xHZmM%akpm@linux-foundation.org>
 <9e14d183-55a4-8299-7a18-0404e50bf004@infradead.org>
 <alpine.DEB.2.21.1811011032190.1642@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811011032190.1642@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shai@ScaleMP.com; 
x-originating-ip: [82.80.45.146]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR15MB2302;6:h6T1w4fVAQRb7QctokYd5XWdp3PobRdzJVbaKhuXEBUkMxgyZmWICPOCTx2gTtWgl75Kt20u6cgPfguThJmwyISIFEdo046S9HvvxaWLjOlRK9JmCPChoweiCAVUSFkppx2/HXxxL1oHpbxHNSw6zfpFMiPWIKZewf7ES5cyIYv37VJZnl1sRNigkdotFch4/FUlPLJKT622qbuJ7XcqaIjt9yCTgHPpU5CQotzIJeaZYzkjtuLEHrZVfCeFPFpZ4fmjpFgv6nXb0cicC+PEKCr4c5VtrZ/LUxIuMC655mkBOX1Fz1Tyglod+Z0Sy8ettpvjYUinNbHyNdjAIYMyAyyDNBr9yg2EEOfsp+xF9OkrV3+tUtEUi3cVvPEq4ZvMiL4Gt2o/S+xr6HdCGJCkPk2nzySXHwwl2XQNn/keVicxaeGZgkgAIXy3kgIjZFhikizfhDTwWSUYkRjxNWRirQ==;5:xOnTcFEYzygDZjgz8d91MPyqTWxKIDoFyuegpaY4Yq8HD8cfnfE7FYu1POKYbdxpIm9ON040CETAajOKf4ZQBhbiFEAoA6o8XnvYF1AQYNmlZbz7kqSFSzINO71jsl0mhE+VxEqc40paBCAwGhVhv6rRVJc5JSkcwA/cYZnGP/8=;7:j+6aHQ19wtCS7VurDmzCp6/S5VAKTEVPtrniqqco649kb0S03qsWGOnhmVBKOyxkuMRWdyev04HTYoMCcmvclz2iCViGB0+EJopmOeMNGMcdFoVhOG/NdnhI/hZkdyGn4LJ/8WJ/HiOhsVsEMpMieg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 63aa6aaf-d2d4-4493-a2fd-08d63fe64f79
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR15MB2302;
x-ms-traffictypediagnostic: SN6PR15MB2302:
x-microsoft-antispam-prvs: <SN6PR15MB23023D758C2D6BF134B6C4FCC3CE0@SN6PR15MB2302.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:SN6PR15MB2302;BCL:0;PCL:0;RULEID:;SRVR:SN6PR15MB2302;
x-forefront-prvs: 0843C17679
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39830400003)(136003)(189003)(199004)(86362001)(66066001)(72206003)(575784001)(99286004)(508600001)(14444005)(256004)(7416002)(5250100002)(26005)(33656002)(7736002)(81156014)(6116002)(81166006)(8676002)(3846002)(4326008)(74316002)(14454004)(305945005)(186003)(446003)(2906002)(486006)(476003)(11346002)(25786009)(8936002)(71200400001)(76176011)(71190400001)(7696005)(68736007)(229853002)(80792005)(6246003)(107886003)(110136005)(54906003)(316002)(2900100001)(106356001)(9686003)(97736004)(55016002)(6506007)(53546011)(102836004)(105586002)(5660300001)(6436002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR15MB2302;H:SN6PR15MB2366.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ScaleMP.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oP24rD0oXNhlH5WxxKnhHhSRIXGagkVdbYGryd+Du+0JaL+fsICQheJ+y0duAnFYWE5i3lTjpWVLl9BJXw/aNsBNLqlHjcoFKK7Vqa/TKqs7M5esYjG5Es4v1NrWauff+dUkIHN730A2z24JNdioO/Z2Aw4/Vka5CqgmfGgEihm1NSllBTB07uMX3RVdUkSo1TrBwOkJ7iBZpmme5HD1n9RuJIMDBGpuiK5xkR1GwOklzZXI3LbcU1XBthSNUwZ8UiPA02JK4uijXK8eMDv00vBQ6ahB0z+qQmh8QVn07avqflvXDgWLEv2L1bR/iC78Od2D/+BS6USydQ7DVd/QYctYl/l9gahgyCSR5TKOz/c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: scalemp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63aa6aaf-d2d4-4493-a2fd-08d63fe64f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2018 10:39:32.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a60757ae-8e1a-437b-b61a-75f96e2fad93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/18 11:37, Thomas Gleixner wrote:

> VSMP support is built even if CONFIG_X86_VSMP is not set. This leads to a=
 build
> breakage when CONFIG_PCI is disabled as well.
>=20
> Build VSMP code only when selected.

This patch disables detect_vsmp_box() on systems without CONFIG_X86_VSMP, d=
ue to
the recent 6da63eb241a05b0e676d68975e793c0521387141.  This is significant
regression that will affect significant number of deployments.

We will reply shortly with an updated patch that fix the dependency on pv_i=
rq_ops,
and revert to CONFIG_PARAVIRT, with proper protection for CONFIG_PCI.
