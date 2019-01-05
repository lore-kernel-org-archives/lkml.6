Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB57C43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472B2222FE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="rGWn89kN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfAEUmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:42:04 -0500
Received: from mail-eopbgr740113.outbound.protection.outlook.com ([40.107.74.113]:52065
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbfAEUmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E5fTGAm164ST3vjZe0xlirICWFZgovFwT3sZmc0xcA=;
 b=rGWn89kNXiB5BBvNi79mtAkPqqhRbLSR0txllJxi6Zj42Ro8XizPDebokF1UoUQPe5fE/cD80XUn7AIANIANeNoJTxpGUa+Dx8kSRll9K+F/AUGM6CwkKIjZZW+EtfvELwJDb+HhmeaZeTdWNdQuFI+yodmG4fx2DQg+XoOU0ow=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1328.namprd22.prod.outlook.com (10.174.162.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Sat, 5 Jan 2019 20:41:58 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1495.005; Sat, 5 Jan 2019
 20:41:58 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MIPS fixes for 4.21
Thread-Topic: [GIT PULL] MIPS fixes for 4.21
Thread-Index: AQHUpTcar0Dsa7NMYkWdGXKe7CIu4Q==
Date:   Sat, 5 Jan 2019 20:41:57 +0000
Message-ID: <20190105204153.e6unrbyttycye3wu@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0109.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::25) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a02:c7f:5e43:2c00:50fd:bec4:fe7e:44e7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1328;6:bXLy7rmQOj1ctYBY8ZUSH6SEVOiI/isA8D5qz39CpJo5LYERTb7B+ACy8GGWSn3lmMCE7hnjhELrYS018giEXcguVps0GZRBpy0/b6Q8ZHrfjwI12iUYknd/flotEA/ADYNYRExXCwmxt6BRwCkdxX6UkDgdnQy8JylwxS0BlIhGyybl6meLsuJkaPvZzX3qnugp7JIOcGDtV1J5GPcwbUXPx0hvDZkDjhDJ2ttw7R/8SIxaFAJxMzg844AA/lDIReyKppDUv11dzIWmT0RKuox32L6ASK3m0bEeueMhF77Nlk0nGgX7bCEMovYPB8N6E8Cu56zYXCRZWvKGWpsF8bPo3iP2uH5eqrEKLppdEccYiP7DDKgnkdstXkLs4l5wH2IGzhgjwP9JVpmoPWxhxFIXxIGlghgPCJEoZBCP/d9vWB5T08RkMQWCLT2r+pyIPP9Uu0VoyOr/8hJcXDKeIQ==;5:Asq83zohwP4RYhOraGfTKhBby/5gUtVjiBV75hqy/MearE88vfxdRHVTLljgON6MxW+s1JpB9hNkHYWNHCsJ9sHOZnw9vnbsMTftaDFMzp463TyexvMTJtev4Nb1ApTPbnxU1YTeQ06vUbWG20tjkVbMBW3Flqq2nmIZjf+bV861UkUNYvVqsJORfnkiizUwmk2crSX7p6PAYjKTa24vzQ==;7:jFv2OPd6ct50+6RWWCCNicYZv3zeslccKZA5w9yjez5QQ+crp55DQRz6RONGkdP6FfWKsd5q5vmjTBs7O6AXpuVjbkVu0mJ4nHZVzSH8CWManOVmLCLCfUxoStwE1F/PZGVSfZS1F7TCFkV6dcObnQ==
x-ms-office365-filtering-correlation-id: 766bbbee-6404-45c1-8a7e-08d6734e3c60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:MWHPR2201MB1328;
x-ms-traffictypediagnostic: MWHPR2201MB1328:
x-microsoft-antispam-prvs: <MWHPR2201MB1328D3DC57542AAD167181C3C18F0@MWHPR2201MB1328.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(102415395)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(3231475)(944501520)(4983020)(52105112)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1328;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1328;
x-forefront-prvs: 09086FB5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(39840400004)(136003)(396003)(366004)(199004)(189003)(8676002)(52116002)(81166006)(6436002)(81156014)(33896004)(316002)(99286004)(54906003)(305945005)(6486002)(58126008)(6916009)(6116002)(8936002)(14454004)(44832011)(5660300001)(7736002)(476003)(2906002)(486006)(53936002)(42882007)(106356001)(105586002)(46003)(4326008)(25786009)(99936001)(478600001)(71190400001)(71200400001)(9686003)(6512007)(386003)(102836004)(33716001)(97736004)(4001150100001)(256004)(1076003)(68736007)(14444005)(186003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1328;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SP4EdsikJOBhMsu43gsTXSpF64kUEqBR/2cygkwkbFiWVMSY2gJXJOwan+z+bd7BLS8EOfX8cohudtN0UK+xyBvITVZH6oh1hglxtSDIR8/eihPZk5VF/Cbk4fptv8AeL7+GLjF5Cz8BIDVVz7pR3J3Gik2Q1kkNZ0HYJun+gbKR0MyOfLVjyqlJh+rwLKsdA65XXvaOrK1DMF4zHrQFNdVnIZzmQtujELNff+r+jkm5OIB/ydFKW56vAQotywWXqdgrqUFsLGUFEbqrnXpnf9Ei9I3gerfISYkIw05q0SxREyN1hqk+XzrBtmQd8YsK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cvdzjabht6mn7dht"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766bbbee-6404-45c1-8a7e-08d6734e3c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2019 20:41:58.1013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--cvdzjabht6mn7dht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Below is a smattering of early MIPS fixes for 4.21, please pull.

Thanks,
    Paul

The following changes since commit adcc81f148d733b7e8e641300c5590a2cdc13bf3:

  MIPS: math-emu: Write-protect delay slot emulation pages (2018-12-20 10:00:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.21_1

for you to fetch changes up to edefae94b7b9f10d5efe32dece5a36e9d9ecc29e:

  MIPS: OCTEON: mark RGMII interface disabled on OCTEON III (2019-01-02 14:17:24 -0800)

----------------------------------------------------------------
A few early MIPS fixes for 4.21:

- The Broadcom BCM63xx platform sees a fix for resetting the BCM6368
  ethernet switch, and the removal of a platform device we've never had
  a driver for.

- The Alchemy platform sees a few fixes for bitrot that occurred within
  the past few cycles.

- We now enable vectored interrupt support for the MediaTek MT7620 SoC,
  which makes sense since they're supported by the SoC but in this case
  also works around a bug relating to the location of exception vectors
  when using a recent version of U-Boot.

- The atomic64_fetch_*_relaxed() family of functions see a fix for a
  regression in MIPS64 kernels since v4.19.

- Cavium Octeon III CN7xxx systems will now disable their RGMII
  interfaces rather than attempt to enable them & warn about the lack of
  support for doing so, as they did since initial CN7xxx ethernet
  support was added in v4.7.

- The Microsemi/Microchip MSCC SoCs gain a MAINTAINERS entry.

- .mailmap now provides consistency for Dengcheng Zhu's name & current
  email address.

----------------------------------------------------------------
Aaro Koskinen (1):
      MIPS: OCTEON: mark RGMII interface disabled on OCTEON III

Alexandre Belloni (1):
      MAINTAINERS: Add a maintainer for MSCC MIPS SoCs

Dengcheng Zhu (1):
      mailmap: Update name spelling and email for Dengcheng Zhu

Huacai Chen (1):
      MIPS: Fix a R10000_LLSC_WAR logic in atomic.h

Jonas Gorski (2):
      MIPS: BCM63XX: fix switch core reset on BCM6368
      MIPS: BCM63XX: drop unused and broken DSP platform device

Manuel Lauss (4):
      MIPS: alchemy: cpu_all_mask is forbidden for clock event devices
      MIPS: Alchemy: drop DB1000 IrDA support bits
      MIPS: Alchemy: update cpu-feature-overrides
      MIPS: Alchemy: update dma masks for devboard devices

Stefan Roese (1):
      MIPS: ralink: Select CONFIG_CPU_MIPSR2_IRQ_VI on MT7620/8

 .mailmap                                           |  5 +-
 MAINTAINERS                                        |  3 +-
 arch/mips/alchemy/common/time.c                    |  2 +-
 arch/mips/alchemy/devboards/db1000.c               | 76 ++++------------------
 arch/mips/alchemy/devboards/db1200.c               | 24 ++++---
 arch/mips/alchemy/devboards/db1300.c               | 23 +++++--
 arch/mips/alchemy/devboards/db1550.c               | 13 +++-
 arch/mips/bcm63xx/Makefile                         |  6 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          | 20 ------
 arch/mips/bcm63xx/dev-dsp.c                        | 56 ----------------
 arch/mips/bcm63xx/reset.c                          |  2 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |  3 +-
 arch/mips/include/asm/atomic.h                     |  2 +-
 .../asm/mach-au1x00/cpu-feature-overrides.h        |  3 +
 .../include/asm/mach-bcm63xx/bcm63xx_dev_dsp.h     | 14 ----
 .../mips/include/asm/mach-bcm63xx/board_bcm963xx.h |  5 --
 arch/mips/ralink/Kconfig                           |  1 +
 17 files changed, 70 insertions(+), 188 deletions(-)
 delete mode 100644 arch/mips/bcm63xx/dev-dsp.c
 delete mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_dsp.h

--cvdzjabht6mn7dht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCXDEWkQAKCRA+p5+stXUA
3UH0AP90vsjmzq1UFNtsALX5IEE2uRr0ywRLCEw+hsbyEfj51AD/a498Zjl1B1Lh
i92s16k0xShOZfMA/PEoZaLw+RctzA8=
=zkK9
-----END PGP SIGNATURE-----

--cvdzjabht6mn7dht--
