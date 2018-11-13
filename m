Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1E4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA362175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="e9AxOo32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA362175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbeKNIUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:20:21 -0500
Received: from mail-eopbgr680111.outbound.protection.outlook.com ([40.107.68.111]:45210
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbeKNIUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWMzH0J25zyaHj9BWZVELDeyM72SPIbtSQB12AQLCV4=;
 b=e9AxOo323PKcnkFGL5l/11cMcoIjj+k0958Ica8r/lVoXmGrOUYNCIJrjeEN049TLFWXo2lurSHZnX5iIa04nvjGxvdcb5PPdQh+U3wpcNcsYXr+Y0jLMtpnL8vYJRd93AvoqEfVgKTCKMOLuB7ZljEhd26a0lTMyibY0axYKr0=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1750.namprd22.prod.outlook.com (10.165.89.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 13 Nov 2018 22:20:03 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:20:03 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: OCTEON: cavium_octeon_defconfig: re-enable OCTEON
 USB  driver
Thread-Topic: [PATCH] MIPS: OCTEON: cavium_octeon_defconfig: re-enable OCTEON
 USB  driver
Thread-Index: AQHUe58GYDZPXRiN70OPUIh2L4Z2fg==
Date:   Tue, 13 Nov 2018 22:20:03 +0000
Message-ID: <CY4PR2201MB127275FE7D86A50AFFB1F082C1C20@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20181110220612.21653-1-aaro.koskinen@iki.fi>
In-Reply-To: <20181110220612.21653-1-aaro.koskinen@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0091.namprd19.prod.outlook.com
 (2603:10b6:320:1f::29) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1750;6:6C/fvb6rnQxlEK4THXIwEiAlxG374eyz15NdguEM1GTkWWzvZW7MnFtcwIQCrNmYDyWQsOWLXT7IYlVxmZGZRBZeep2Q+IKPpjXSMKOqzAVo5oAFqfwAx25q++5JODxVlbKW42JUfKlEvU1YCR3Jy9wedrtYGAzyd8qmcdqkzmNVRZo2fCIzXfNL+3Px+qETTGwfTr35XOOyY6OPZlElbhwEkG5Y8JoPSyoCPAANXUuX9hfVbWFUkFYnMrYfjtVL9crsy8SEfAGWj/426fAkvJYjpSowBB29cB2IBr7GPAKSW+75XNB3hB4DEPVfE6XidYSOeWRTW6XB6yjtrPMBr1qSLHwKMCsvWODvX1nvpqo1+MBt68eJJu8Ib4XIINqlJikaY64CzwmNChNfX+zhcokm4YptuOB65cMhFL2wgecZvugFF6dVcvq7A0D/YessS3C3YgnNPvmUo6dgvrgjFw==;5:SwfiqmUqCFOh5U28TPvRb2udKZIzEhRLAwwygCueoCcYgni4HDFkqEO5uYKKHULyTjpgWnoEiEoYlpVnpNoHEeBUpUTv/VCk9a55dWLT62dyBV1hLjzz5GEgcUzE1e+eLhGihGAVjrcdcl3leYzrb8IIvIw5yfuWEH7RDjiECLk=;7:rvMlwy2fq4J7Krx32LqL4bgr4JLykNzqk/l7/ivzDeQVWsqLSnkmJFP37o5YJbgaG7aOZBV9wQg8hkDAeGk+uelC1aRt0rAY921ol3CMcVG19UigqqeredZYZKCu7ru/94AAFPX5Xo3DPWhBBJGmsw==
x-ms-office365-filtering-correlation-id: 8ffa6b69-5cc1-44f2-cdf0-08d649b628a8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1750;
x-ms-traffictypediagnostic: CY4PR2201MB1750:
x-microsoft-antispam-prvs: <CY4PR2201MB17504966DE6BCEF547B43EEBC1C20@CY4PR2201MB1750.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(3231410)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1750;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1750;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39840400004)(136003)(396003)(346002)(366004)(199004)(189003)(71190400001)(97736004)(6246003)(55016002)(305945005)(71200400001)(7736002)(2900100001)(14444005)(256004)(217873002)(54906003)(102836004)(9686003)(386003)(6506007)(508600001)(14454004)(42882007)(74316002)(53936002)(4326008)(6436002)(575784001)(186003)(26005)(316002)(81166006)(5660300001)(8936002)(229853002)(105586002)(6916009)(2906002)(486006)(25786009)(81156014)(6116002)(8676002)(106356001)(66066001)(446003)(68736007)(3846002)(476003)(11346002)(76176011)(44832011)(33656002)(99286004)(52116002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1750;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mQ5JMJfdkOZoPxftXCF3ZWlCWR7qJsqLbXpUt3SLZ1lWtNLWHfO/jXh82KoZ78KEdP3BDQLd9JCiwPNBQ8c06ez7ljJoC7hVa2Lz8Kcx/Q2DSOl/F2bO+IgQhMyMhNM0KXo7IKBNyjeZO8fDh2RTZDeXA7xTduvKlo+Rq8NjacXOkD8VbiRfrB2jAmPgGaiMaMAidbkG2FGszV2QH1amaVLz7MDaeJnU/ZyEPz5fcpsrU6q1pYMM2Qebti/OBGZQbpce7JntAV5UakTyrCFdsFsT5fn4WS6tj304p4wqgzLEyxDj9UjuIfa2yUa5clMtzJ4kFIL0YQ7hi2akq2t5mvGKhGjIR+rpDREmc3OHJsc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffa6b69-5cc1-44f2-cdf0-08d649b628a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:20:03.7543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Aaro Koskinen wrote:
> Re-enable OCTEON USB driver which is needed on older hardware
> (e.g. EdgeRouter Lite) for mass storage etc. This got accidentally
> deleted when config options were changed for OCTEON2/3 USB.
>=20
> Fixes: f922bc0ad08b ("MIPS: Octeon: cavium_octeon_defconfig: Enable more =
drivers")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
