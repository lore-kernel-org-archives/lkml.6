Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF796C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732E820844
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="IuyxlNRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfBITml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 14:42:41 -0500
Received: from mail-eopbgr810129.outbound.protection.outlook.com ([40.107.81.129]:26537
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727175AbfBITmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 14:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vq9juTtM88sxOCuNQY6Fdxv2vwGqqXH4SpM1+3wepgU=;
 b=IuyxlNREOWLt58QwbVhstghPG998ChlDXsrJVJvdh+GJv7M0I5L8r6ZKViM2RKqqWW5CpHq8afWQJC6qwsxR7jiQcssw0UXLNRiV8MQca4CowhCg+PqCWDmetyBpsufk2mNAc9PUYxxjpz9ApSrpKw9rS2xrAXalAztefqvT6tc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1728.namprd22.prod.outlook.com (10.164.206.158) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Sat, 9 Feb 2019 19:42:37 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1601.016; Sat, 9 Feb 2019
 19:42:37 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MIPS fixes for 5.0
Thread-Topic: [GIT PULL] MIPS fixes for 5.0
Thread-Index: AQHUwK+c6CkVyqiX+0+u5fbDcUYOSQ==
Date:   Sat, 9 Feb 2019 19:42:37 +0000
Message-ID: <20190209194236.lbdhzionhq6qxc5d@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0094.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::35) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1728;6:RB1jZXB4bXRqE4/IA1X0L0TP1vkw9v6YvVQtrVMvEap5jt4XjQHkgvEH1DVFzdWAQ9xOeZ1MqcWtAYg3s8R1lKuXt3q4SshtWuDyqIOMaSOGeXiJ99HUnDhz4oZkUosA1ro2sNqD4NKOlRS7MXCNk5Jk3EfIBu8uNeEAVA9Q7CZ3llFP4Pm+bQPodHzzl1MwREeSlsdoUX05htHH3cW8XPP/vRr8UptTA3j0qF4iWyTlcT7VG52uasAQgPX3/Ik+Da08BViQSjIupYsm8AeHu2jD2NUAlnw3/Uk4bvufnaS297o9LEvBbd14gBajTlndG8fN7zrS9uup7HghWGHctUo0OZX8A8teqD9J/YvqSy9fPUgOi8FtNW6kUEWC8ytBiBVNPywOLtFFMFgySNGNBDma+pS3tPVT4kqWuyxfp8sWNn5GK2f4euRX1j5V8eBw9wAwH+1qMiqVhQrvOZlwGA==;5:xO9ldKCaa2E9CewlBl4bYT6T1vYRe5bNl9DCWP/zV6/OiRMD2JVqb/iEmENfzo/BfR/lERKmMsHoHFLvxMDxtLWoaTW19D61pkLwaVX8/FLVxk3gzAkNljFQaBxUWH9sjtgf9TdDN8MQID5CCn4zQqir/06lT2IbdRjHLXb0bD1HtcTiAhOs7orrl8scUS6Wk1MXQ5/poRRoWw7RscTZbw==;7:lcJAxGKNkDEb4KbZTteqWh1XP2ZFKBauGnMjn0pya4Kja8wHrsIj54rEgWcr2CpW374PpZL1SeQWoPqRbUuDkrCv+ziULXSg4hfeSZXAcZOhMmXSOlnBg88ac0i1O4UXg4Cxs0J+mwt1BSRCJtMQfA==
x-ms-office365-filtering-correlation-id: 1ba12311-65a5-48f3-af1c-08d68ec6beaa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(49563074)(7193020);SRVR:MWHPR2201MB1728;
x-ms-traffictypediagnostic: MWHPR2201MB1728:
x-microsoft-antispam-prvs: <MWHPR2201MB1728E63E666D744A2459DA7BC16A0@MWHPR2201MB1728.namprd22.prod.outlook.com>
x-forefront-prvs: 09435FCA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(346002)(136003)(376002)(39840400004)(396003)(189003)(199004)(71200400001)(1076003)(105586002)(71190400001)(476003)(6116002)(106356001)(3846002)(42882007)(102836004)(486006)(6916009)(68736007)(99286004)(97736004)(44832011)(14444005)(53936002)(99936001)(33896004)(256004)(52116002)(186003)(478600001)(33716001)(14454004)(25786009)(6486002)(66066001)(7736002)(305945005)(81156014)(54906003)(2906002)(6506007)(8676002)(26005)(81166006)(9686003)(6512007)(386003)(58126008)(4326008)(8936002)(6436002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1728;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jISmFYRZICn6cRjxDT1FvTk3u/kaapbt3Y1y75f7wDtnGmNRf34YD/XJ1HkDDUc0es1rEgQdwDj/7NW8ic/fDNKioZ069pOxq09DX9ZfpBuipVnW42cM/5JESZztIET38HgYGddIsq9C2JBHZqNg+euGN8QVCulo/iBk2tmjwDuSMabZYqvnV52Gdzozr7UUhQp1+gr4CcOkbTr4t18+Su592jJpzcuxdyWL4RH6gBm7e5nfnrXM6tiajgAJ3CEmgiVinRdR5Z+auGJUeXtIWenCQNJgXoVKRNIsrkrpcrM35YcNEiVtWckQSC1mAjmU0RHXDGxZoJm+fn00K79nXqoQQ+9CJtTebvmFo9rVuotwcwI/8rWV8FzNhPYQB8OwQDTNBKglD1QKRXiQ941v5VyqHZSVkZ5C6KXdkiLZ+Dc=
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sbki4nh2kb2ugcjp"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba12311-65a5-48f3-af1c-08d68ec6beaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2019 19:42:37.2489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--sbki4nh2kb2ugcjp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here's a batch of MIPS fixes for 5.0; my apologies that these have built
up over a few busy weeks. Please pull.

Thanks,
    Paul

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.0_3

for you to fetch changes up to 05dc6001af0630e200ad5ea08707187fe5537e6d:

  mips: cm: reprime error cause (2019-02-07 11:55:24 -0800)

----------------------------------------------------------------
A batch of MIPS fixes for 5.0, nothing too scary.

 - A workaround for a Loongson 3 CPU bug is the biggest change, but
   still fairly straightforward. It adds extra memory barriers (sync
   instructions) around atomics to avoid a CPU bug that can break
   atomicity.

 - Loongson64 also sees a fix for powering off some systems which would
   incorrectly reboot rather than waiting for the power down sequence to
   complete.

 - We have DT fixes for the Ingenic JZ4740 SoC & the JZ4780-based Ci20
   board, and a DT warning fix for the Nexsys4/MIPSfpga board.

 - The Cavium Octeon platform sees a further fix to the behaviour of the
   pcie_disable command line argument that was introduced in v3.3.

 - The VDSO, introduced in v4.4, sees build fixes for configurations of
   GCC that were built using the --with-fp-32= flag to specify a default
   32-bit floating point ABI.

 - get_frame_info() sees a fix for configurations with
   CONFIG_KALLSYMS=n, for which it previously always returned an error.

 - If the MIPS Coherence Manager (CM) reports an error then we'll now
   clear that error correctly so that the GCR_ERROR_CAUSE register will
   be updated with information about any future errors.

----------------------------------------------------------------
Aaro Koskinen (1):
      MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled

Huacai Chen (1):
      MIPS: Loongson: Introduce and use loongson_llsc_mb()

Jun-Ru Chang (1):
      MIPS: Remove function size check in get_frame_info()

Paul Burton (3):
      MIPS: VDSO: Use same -m%-float cflag as the kernel proper
      MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds builds
      MIPS: Use lower case for addresses in nexys4ddr.dts

Paul Cercueil (1):
      MIPS: DTS: jz4740: Correct interrupt number of DMA core

Vladimir Kondratiev (1):
      mips: cm: reprime error cause

Yifeng Li (1):
      mips: loongson64: remove unreachable(), fix loongson_poweroff().

Zhou Yanjie (1):
      DTS: CI20: Fix bugs in ci20's device tree.

 arch/mips/Kconfig                        | 15 +++++++++++++
 arch/mips/boot/dts/ingenic/ci20.dts      |  8 +++----
 arch/mips/boot/dts/ingenic/jz4740.dtsi   |  2 +-
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts |  8 +++----
 arch/mips/include/asm/atomic.h           |  6 ++++++
 arch/mips/include/asm/barrier.h          | 36 ++++++++++++++++++++++++++++++++
 arch/mips/include/asm/bitops.h           |  5 +++++
 arch/mips/include/asm/futex.h            |  3 +++
 arch/mips/include/asm/pgtable.h          |  2 ++
 arch/mips/kernel/mips-cm.c               |  2 +-
 arch/mips/kernel/process.c               |  7 +++----
 arch/mips/loongson64/Platform            | 23 ++++++++++++++++++++
 arch/mips/loongson64/common/reset.c      |  7 ++++++-
 arch/mips/mm/tlbex.c                     | 10 +++++++++
 arch/mips/pci/pci-octeon.c               | 10 ++++-----
 arch/mips/vdso/Makefile                  |  5 +++--
 16 files changed, 127 insertions(+), 22 deletions(-)

--sbki4nh2kb2ugcjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCXF8tKwAKCRA+p5+stXUA
3RFZAQCs7ygV1K7ymH4XuoQDEa/FgCyEcqCQVLuSTh/1fI3TSAEAgpL7bqtWbY0b
KHzLwH06PGfo80zDtzdLllIqpxbqaAY=
=KE3O
-----END PGP SIGNATURE-----

--sbki4nh2kb2ugcjp--
