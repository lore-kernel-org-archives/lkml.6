Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9D9C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726842084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="RTarcGso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfASTSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:18:50 -0500
Received: from mail-eopbgr760120.outbound.protection.outlook.com ([40.107.76.120]:5046
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728926AbfASTSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQI5uj4tFklvMIaGH3oXMoReZ68YagHoXT+2DSqhNmM=;
 b=RTarcGso+74aGBU2cy19krQV/HfkKfmiohx7DPpC+SryBF8hl5eQX96m82g56rRck2O0Yap8a+LMlGWsPYDlmrJMo7K59P9QRWxpQtJjQpvErh7LhjNNlSisuDH7VeXoZTMhmGlyYu/rKQPQyT+XZGJeeof0gcLdenjPhuN96V8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1152.namprd22.prod.outlook.com (10.174.167.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Sat, 19 Jan 2019 19:18:34 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1537.028; Sat, 19 Jan 2019
 19:18:34 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MIPS fixes
Thread-Topic: [GIT PULL] MIPS fixes
Thread-Index: AQHUsCvFCjte+isbQE6efyH3bK4G8Q==
Date:   Sat, 19 Jan 2019 19:18:34 +0000
Message-ID: <20190119191831.7vx5kfjtkyji55zr@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::30) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.64.207.177]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1152;6:ulIfPaVRpM812uYU0WHc4IkI1QFDf6alpOAL5nHMPc0LsVTSXzDCVkKYCzGpYy0tW/ltuAEcTyw20XMS7Yggiq9470LSsYKkZM+rUv4wmd9o28c10pOSLcxMpfFuWh7JSnUx5WqDTBBxxgGgVWo+SM2stvDr3ADnytUkLX3w0gqTGdwpl3d6WWWrSpXe57ToF0atEuYURqVN1080UfaTSEmzxd8jNdDzEJW0KenB1vMBbYEjQr2fpWIF/t10PcfSDMn8MXkFjS/AACBT1I/IOE8lYm09WHa58AhC2Mxr05WBEH/MQD3M/L3wfb7K19zhHl3i2/Wq18vCLA5W6aJKAGbGnAMsXvaKk3iQRkMlo/4BCcpwMYwMFfzcrK2ui8gGdFG78KCNiJa/vAQwucph/eUMb73xmS41lC1IT6qG6XW4FbzAW1LKeT9nlHDc6eAmuBUUjKVmD5r7Bc9i8xL/EA==;5:11guQ6lU7TiRYapqjgDttdZhoaDtUvVDxkUmApO9EUsHKTjohiYl2cPa0/pE6NMDK2zEj/EV3SHKoxf8toDN/Xeru3g+6G28QElCsrLTyMRdWNPxZB8zF5QH6kJxP/j6ze54FGm24uEkIMJtorjtEKcm/06fKSgdYdYQBtGyPokDFKhePpLqWOdSXttOQr4YgT9qYjrBHOPMi6pgCugb2g==;7:Uh70/PQWY/wKW6X/EQPDtWRbNNi7JiFpfira0YtBH9OaoDiHNAjHrOuIGj8f77ettkqKf968HrrVJpReRojYkFnTDTmW0xe/V3j5OCWsQA5dkeGzYdgmHybZiEzIYRT8RsKrgmzK0JtlgVxp+FyD3A==
x-ms-office365-filtering-correlation-id: c2c85d50-6345-457f-b057-08d67e42e782
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:MWHPR2201MB1152;
x-ms-traffictypediagnostic: MWHPR2201MB1152:
x-microsoft-antispam-prvs: <MWHPR2201MB1152535F31971739AF90971CC19D0@MWHPR2201MB1152.namprd22.prod.outlook.com>
x-forefront-prvs: 09222B39F5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(39840400004)(136003)(396003)(346002)(189003)(199004)(14454004)(8936002)(386003)(66574012)(97736004)(68736007)(106356001)(105586002)(2906002)(4326008)(44832011)(6486002)(53936002)(1076003)(6436002)(486006)(25786009)(33716001)(6116002)(8676002)(81156014)(99936001)(305945005)(7736002)(3846002)(478600001)(81166006)(9686003)(6512007)(42882007)(99286004)(71200400001)(71190400001)(58126008)(256004)(66066001)(316002)(14444005)(102836004)(186003)(6916009)(6506007)(26005)(54906003)(52116002)(476003)(33896004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1152;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GGrKQZlGx+F0or0yVJ2O9hDuSUrWlw8wsSge6IJNmHGNTkTQIpnaSSLTSpecVY4tXmlaDcxpQDew+WbO/ieObyC8DYUOiv91JdG86bD2mfKqBY4MoHh8l3f9RH0arghq7P4qV2Eqi7RQvz7j5pchzH0CXy1+B15bgrAzjrsRgB0XffNO/rXhv2TYcD3yZ1sl+yWQxyEWyWCmOxBUkV5Up9yXCdRzZiVsK/qZG0lRdjOuAnYM+stwcQ3olPspC6mgnVkm7gENuB/u9gXHLUjK4KP8vqdHDQj1G8YksuwgkhSmLbUfJWGdEaJzwhNbjA6teLpRC+dN4tqgLsE3TxmqzhLr7df88mDccdZxrb4X13W3WS7zB3Sro/lVEjhHrEZXphCfMAB5LGfrtn/SV6wzXQ2ctBZHytFZJI8R+NvnaZA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="snn3ke2hqneivoqi"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c85d50-6345-457f-b057-08d67e42e782
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2019 19:18:33.5335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--snn3ke2hqneivoqi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here's a batch of MIPS fixes for 5.0 - please pull.

Thanks,
    Paul


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tag=
s/mips_fixes_5.0_2

for you to fetch changes up to 8a644c64a9f1aefb99fdc4413e6b7fee17809e38:

  MIPS: OCTEON: fix kexec support (2019-01-14 13:51:03 -0800)

----------------------------------------------------------------
A few MIPS fixes for 5.0:

- Fix IPI handling for Lantiq SoCs, which was broken by changes made
  back in v4.12.

- Enable OF/DT serial support in ath79_defconfig to give us working
  serial by default.

- Fix 64b builds for the Jazz platform.

- Set up a struct device for the BCM47xx SoC to allow BCM47xx drivers to
  perform DMA again following the major DMA mapping changes made in
  v4.19.

- Disable MSI on Cavium Octeon systems when the pcie_disable command
  line parameter introduced in v3.3 is used, in order to avoid
  inadvetently accessing PCIe controller registers despite the command
  line.

- Fix a build failure for Cavium Octeon kernels with kexec enabled,
  introduced in v4.20.

- Fix a regression in the behaviour of semctl/shmctl/msgctl IPC syscalls
  for kernels including n32 support but not o32 support caused by some
  cleanup in v3.19.

----------------------------------------------------------------
Alban Bedel (1):
      MIPS: ath79: Enable OF serial ports in the default config

Arnd Bergmann (1):
      mips: fix n32 compat_ipc_parse_version

Aurelien Jarno (1):
      MIPS: OCTEON: fix kexec support

Hauke Mehrtens (2):
      MIPS: lantiq: Fix IPI interrupt handling
      MIPS: lantiq: Use CP0_LEGACY_COMPARE_IRQ

Rafa=C5=82 Mi=C5=82ecki (1):
      MIPS: BCM47XX: Setup struct device for the SoC

Thomas Bogendoerfer (1):
      MIPS: jazz: fix 64bit build

YunQiang Su (1):
      Disable MSI also when pcie-octeon.pcie_disable on

 arch/mips/Kconfig                                  |  1 +
 arch/mips/bcm47xx/setup.c                          | 31 +++++++++
 arch/mips/cavium-octeon/setup.c                    |  2 +-
 arch/mips/configs/ath79_defconfig                  |  1 +
 .../include/asm/mach-lantiq/falcon/falcon_irq.h    |  2 -
 .../mips/include/asm/mach-lantiq/xway/lantiq_irq.h |  2 -
 arch/mips/jazz/jazzdma.c                           |  5 +-
 arch/mips/lantiq/irq.c                             | 77 ++----------------=
----
 arch/mips/pci/msi-octeon.c                         |  4 +-
 include/linux/bcma/bcma_soc.h                      |  1 +
 10 files changed, 47 insertions(+), 79 deletions(-)

--snn3ke2hqneivoqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCXEN4BwAKCRA+p5+stXUA
3V84AP9t/OzptfaO9d3u6AyxY+a0DJB7WWdND4WW7kRE88RjAAD3ZhZq80p21coS
d/aApDRxvqZDsbXNnfm0+DrdQW1fDA==
=31ZA
-----END PGP SIGNATURE-----

--snn3ke2hqneivoqi--
