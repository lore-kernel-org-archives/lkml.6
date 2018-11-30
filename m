Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4208DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD7620834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="aqTP/RuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD7620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeLAK6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:58:50 -0500
Received: from mail-eopbgr790108.outbound.protection.outlook.com ([40.107.79.108]:42850
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725749AbeLAK6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooEyNUCp78l1T8SH+rmZHDTd/Bd4xD6RnkkCa64TBJs=;
 b=aqTP/RuItTrNHE+bqa+5QZNwEJJ0ST/XWXTCJy3uSagl47+MyiyxBAZzGyVtxxcYQ3wVmfvvg+9Cc/ch3UgiEHonxnQjtkORmTBA5xFrl+SmlIfTSGUSU8UGO/RErBXUKsWWrWhbzljsp2XTGFYLDAqX6sKzCvB0gwGuuww9vFw=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1079.namprd22.prod.outlook.com (10.171.222.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 23:47:44 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::5c0a:2e64:7595:eeff]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::5c0a:2e64:7595:eeff%9]) with mapi id 15.20.1382.020; Fri, 30 Nov 2018
 23:47:44 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MIPS fixes for 4.20
Thread-Topic: [GIT PULL] MIPS fixes for 4.20
Thread-Index: AQHUiQcXmi7k1C1oP0amISb/BgylaQ==
Date:   Fri, 30 Nov 2018 23:47:44 +0000
Message-ID: <20181130234743.aorz7mcxz4gygqhl@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:300:115::32) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1079;6:gpTWcp3/df5iP406JRhEfXP0AhvuIUEa7brdigwvXBKicOgkM5Nxw/UW2l8HwtP6UmYqrGmJ38XrbJyr3XY9U0Y0dbuK7JRD8BX0mtKhrEYXsAw611QojzYGD2ngxjr/x63JFGMIqGXVamD8HPBuuGTK6A9A8DYWQiupOWWSMyoQzpCwXIxSxKCY1Y4Byq38kFPrbblXe+S5x85fTxEu2TZBOq4G06TO+W/UyecCtMpkS7lsuX1HR13FP20axqOU9DLaURshKcFGtftVDyOVRUbTUbLlMsVI3xcaXBUDicNw7rUSClQKjJfU76p9WYmP8Wfs8wr4DUVYuTcX0YLPgoj6KAbAPo3qXjTjO+ocSKOdwD/eYDGZouBUnuhDEhQyg9KcC8oyZ17vtNXaLDFjEyQReW0pTn3wu4XWDCnP7fD906Weh8wroYVnSiYsGchagpDNXuipWpf8IymdLOVnJA==;5:+zKgANV015dMrSssFBD+BEm2ReKB/penH+TG6doQQtbQlyJ+v+ZbvQPbpx2TciDWN6WSESOdUKeol2ZxqOw+62gS0BN5LYPUOmOupRsazyWj3u6y0cdIlibOZpp8o7b2YHlgBv2QOeAskQdwgE98jwcLdBh61GEa4pTaZCH9HRc=;7:R6pamIBmZOeKWFO+eykaVKWGJXeXNrIYPSC3RMDfJBHCkRuvB8FTcMWLFjA7ZmyMzjy7CXObCYOw7TLO2emI6SQvO6fQtwz3WT7LxI91EPBazyaSS03Mm9+ttg7FedDnKCVLfzXyuSimNqD5yzH+7A==
x-ms-office365-filtering-correlation-id: d69db58b-5b13-499d-5a82-08d6571e3991
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(49563074)(7193020);SRVR:CY4PR2201MB1079;
x-ms-traffictypediagnostic: CY4PR2201MB1079:
x-microsoft-antispam-prvs: <CY4PR2201MB1079186DAC8ED8F70D8D4D86C1D30@CY4PR2201MB1079.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231453)(999002)(944501470)(4983020)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(2016111802025)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1079;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1079;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39850400004)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(5660300001)(486006)(3846002)(33716001)(2906002)(6512007)(42882007)(71190400001)(71200400001)(66066001)(26005)(6436002)(44832011)(186003)(58126008)(316002)(508600001)(6116002)(1076002)(7736002)(6486002)(68736007)(54906003)(4326008)(6916009)(476003)(33896004)(102836004)(106356001)(53936002)(386003)(14454004)(99286004)(305945005)(99936001)(8936002)(81166006)(81156014)(8676002)(52116002)(97736004)(256004)(14444005)(25786009)(4001150100001)(105586002)(6506007)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1079;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VOvAfCE5RTAW4TRZJJ2OCDf5FEvCYlD78YBvD+UnO2kPHbtSmZDAS7dttj18RWb+6Sy2O3KMfL9am2d5lMWmt8drO4ICnigUMEoKkZUkIjK3Etz+MdpEc3Ek5qCBXDRp/pGQ5bNdkOIgP0PBhqFbLVEfqvgv3XLPQzWKUlzeUiFZKKTLHP0teQ80cJOriZOS3JVBsDybjXF/iNUvOvhyYuRpkzNeCP1odIK6dEb2njzSrP2wGK91SlhEjDaFcJF6+xSpO3MHIEqOW59MbDu2V0I6ykufanWcoHV4UvlnLfO+Oj0cKts4bD0wvCPPTuughbUD3V867ej7TY0LkgIBtPEhbYlWqRaAK3EqlO7ZhK4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="haieizvcxkbfv5tx"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69db58b-5b13-499d-5a82-08d6571e3991
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 23:47:44.7697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--haieizvcxkbfv5tx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here are a few more MIPS fixes for 4.20, please pull.

Thanks,
    Paul

The following changes since commit 1229ace4a4a2e2c982a32fb075dc1bf95423924f:

  MIPS: Loongson3,SGI-IP27: Simplify max_low_pfn calculation (2018-11-15 15:42:15 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.20_4

for you to fetch changes up to 6584297b78b66acb80917b664084f303317fcff1:

  MAINTAINERS: Update linux-mips mailing list address (2018-11-30 15:19:36 -0800)

----------------------------------------------------------------
A few more MIPS fixes for 4.20:

 - Fix mips_get_syscall_arg() to operate on the task specified when
   detecting o32 tasks running on MIPS64 kernels.

 - Fix some incorrect GPIO pin muxing for the MT7620 SoC.

 - Update the linux-mips mailing list address.

----------------------------------------------------------------
Dmitry V. Levin (1):
      mips: fix mips_get_syscall_arg o32 check

Mathias Kresin (1):
      MIPS: ralink: Fix mt7620 nd_sd pinmux

Paul Burton (1):
      MAINTAINERS: Update linux-mips mailing list address

 MAINTAINERS                     | 46 ++++++++++++++++++++---------------------
 arch/mips/include/asm/syscall.h |  2 +-
 arch/mips/ralink/mt7620.c       |  2 +-
 3 files changed, 25 insertions(+), 25 deletions(-)

--haieizvcxkbfv5tx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCXAHMHQAKCRA+p5+stXUA
3dBPAPwLM7IhjJKGyDsECwbukHZgKriN1nmIVNNxOr+oSqwFSgD/UTJ0bt9OXG78
zLojvciH6FDJiWXJ371V4ODWdwdC8gU=
=Vesi
-----END PGP SIGNATURE-----

--haieizvcxkbfv5tx--
