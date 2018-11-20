Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D044C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C16214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="E3IJN2YH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C16214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbeKUIWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:22:02 -0500
Received: from mail-eopbgr700133.outbound.protection.outlook.com ([40.107.70.133]:17684
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbeKUIWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn6xrC9GcRVJajB4Kg1bgjEyuqy37T14RCvhtt9ucIs=;
 b=E3IJN2YH4u0YvnWgBkUPzHfSTt0x7auYXlzrp/7Q457Wp41tW6sYfIv9Q+MRLPUCSI4Ycj3qoRuQ5/AWiG+h8RfUbwj/HaBCOG/wvjiIDcZ9duEaBBlcvaxpdTzwgSlb9+GBkcGWdd8mOSjtCHvj9T0M46yA4ayCRGxIhCiV7TQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1373.namprd22.prod.outlook.com (10.172.60.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Tue, 20 Nov 2018 21:50:42 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 21:50:42 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MIPS fixes for v4.20-rc4
Thread-Topic: [GIT PULL] MIPS fixes for v4.20-rc4
Thread-Index: AQHUgRsVE2kwmU6CIUCvv1+iXq0ZIw==
Date:   Tue, 20 Nov 2018 21:50:42 +0000
Message-ID: <20181120215040.dlip2rzl334fw7bc@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:301:3b::41) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1373;6:SsRlr8io8HFhC/43VQax1QHMQ2ysFIEVT/kSisXxu92VogAHTslwDpXgWq9e03xk4o/QS8uwU+h7ArXBg5RbKW92y9Bo1UTamga+Zf/AqKszXmHMB4sKcB/QXLMV08n+M3E3m7hjn1BZ2GuuSgYIaw97HiFqUePot+s58R+19JBIG0nY4fSfkKDj6L5JlzVerpgHHq02n8HOJqxR6ty6jVN1PYdHW4fxr3j+I7SJrO+8fANwAlwRYyg0LSoYKXwE4P3KaU/DKF2GbNmMu8Up1EoaqTWEd9J1KwhDj13burh9Rw7Exk+Q5c5B3ZglXdCRu4lEdk+5nx9w2ljdXq1pLndUXuzBjwG1dxBxBT3cFEDFkppAl8/HayyQvcOW8A0MFPnN8yB7AYvGDInTjO8p2H5OiSvaXPRpDjJAplb7Wdj5lPmlAZ2Phu8yg5FtXC+zJsN3Se7H649frssYMPkzAA==;5:i7oftNWmvWgCrnKFrQHWSxubM7+85SFs6SduvQPW7Ews168SA0m3K6Zb/41mcBfMgm2UfqZhja989fHb8+rmvPHiUUS/jnYcGp9fuvEAoQFPMYsmWB6Z3mg+sVutd8TdjZSRRHGs/QmAAB7qsYC+WaZhDk+ZydX9kOEUsz++0xk=;7:NblSGX1PSbZVzBF+ed6gLPTe89lrDGVla+4ggLD1mbsJJh77Y1cYFxe99ihcDViTabHtAuuowssO1FcuoiwiTqSnjAWHhKy1m7qhNqE5LhCjpgH1WIgayJ52olZ6Ss5WHisHpiLwIceNk0kXhV+FCg==
x-ms-office365-filtering-correlation-id: f11cf1e4-ee77-4c17-d486-08d64f32378f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:MWHPR2201MB1373;
x-ms-traffictypediagnostic: MWHPR2201MB1373:
x-microsoft-antispam-prvs: <MWHPR2201MB137320F6BBFC4EB1534C59F5C1D90@MWHPR2201MB1373.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(5005006)(8121501046)(93006095)(3231442)(944501410)(4983020)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1373;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1373;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39840400004)(366004)(346002)(396003)(376002)(189003)(199004)(2906002)(54906003)(6916009)(58126008)(5660300001)(508600001)(3846002)(6116002)(256004)(66066001)(71200400001)(71190400001)(14454004)(1076002)(53936002)(6436002)(316002)(25786009)(9686003)(105586002)(6512007)(106356001)(186003)(2900100001)(26005)(99936001)(6486002)(42882007)(102836004)(4326008)(97736004)(4001150100001)(305945005)(6506007)(386003)(7736002)(8676002)(44832011)(476003)(81156014)(81166006)(486006)(68736007)(8936002)(33716001)(33896004)(52116002)(575784001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1373;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: O950NGKKzv9AqXvy7eZIlP9VNMWd6EMeODYf1pXPe9+8Byk2EUrhY3j1+kf4j0nwmg8HL4JX2R4azH8yQTv6F7ymyO8dP2KtgBQUJARedQcv6nN2CjnVqoTN70+uWg8HU76GL//uPD7cjFZiWtKxJ3e0SaDVbP1RFAL/k3ZRGF0V26PuzEjdb7E1SwYxVGibs7/yEEgFaA/iVhIDSrJ4uibP2t8DbRDd3rbO7gqI9ec0DzA2r2hxmAgKQbO+la90RrhGUK2hfUn0wJFNgZ8P0IfSCIlvSM90HJrbuWhnjHcH410dfp3FQ2x4vmLIRrqHQOBl//QivPiZMR/ooDbcSDUlNZn5Rjv+qxhnYN8Qcug=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jfe26injwrctlltr"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11cf1e4-ee77-4c17-d486-08d64f32378f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 21:50:42.3609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--jfe26injwrctlltr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here are a few MIPS fixes for v4.20-rc4, please pull.

Thanks,
    Paul

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.20_3

for you to fetch changes up to 1229ace4a4a2e2c982a32fb075dc1bf95423924f:

  MIPS: Loongson3,SGI-IP27: Simplify max_low_pfn calculation (2018-11-15 15:42:15 -0800)

----------------------------------------------------------------
A few MIPS fixes for 4.20:

  - Re-enable the Cavium Octeon USB driver in its defconfig after it was
    accidentally removed back in 4.14.

  - Have early memblock allocations be performed bottom-up to more
    closely match the behaviour we used to have with bootmem, which
    seems a safer choice since we've seen fallout from the change made
    in the 4.20 merge window.

  - Simplify max_low_pfn calculation in the NUMA code for the Loongson3
    & SGI IP27 platforms to both clean up the code & ensure max_low_pfn
    has been set appropriately before it is used.

----------------------------------------------------------------
Aaro Koskinen (1):
      MIPS: OCTEON: cavium_octeon_defconfig: re-enable OCTEON USB driver

Huacai Chen (1):
      MIPS: Let early memblock_alloc*() allocate memories bottom-up

Paul Burton (1):
      MIPS: Loongson3,SGI-IP27: Simplify max_low_pfn calculation

 arch/mips/configs/cavium_octeon_defconfig |  1 +
 arch/mips/kernel/setup.c                  |  1 +
 arch/mips/kernel/traps.c                  |  3 +--
 arch/mips/loongson64/loongson-3/numa.c    | 12 ++----------
 arch/mips/sgi-ip27/ip27-memory.c          | 11 +----------
 5 files changed, 6 insertions(+), 22 deletions(-)

--jfe26injwrctlltr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCW/SBrgAKCRA+p5+stXUA
3f19AP0V65UeChH9iLr97EUX9prH+3dE+OsJ0f+7YIwXGcCKwgEA5sncstTziKrD
7PNp9axKlUMWNQo/s3Il8+CFjCPjeAo=
=DhFz
-----END PGP SIGNATURE-----

--jfe26injwrctlltr--
