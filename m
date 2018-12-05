Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4DDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E11206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="mGcxBaxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E11206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeLEH6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:58:43 -0500
Received: from mail-eopbgr1410094.outbound.protection.outlook.com ([40.107.141.94]:49696
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbeLEH6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8ZTaG7jj954NHXXdkRErz/++VZVD32/+70Agc5YmDI=;
 b=mGcxBaxufpmru0XSe9eB2259neEAGikrBR3+unldLYBf5AocWGeYQGiU6xVA1y9SGCmV4xN1gG2C05HbFGO/+GS7/qmNAAvjeuzpKju1TxXaWqnhxBEiKjN9/QsFV/F/b0kM00wkjpuk0Kbll9m0ck/fV8tZQ/jT9Kb72mqP/m8=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB2430.jpnprd01.prod.outlook.com (20.177.103.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.18; Wed, 5 Dec 2018 07:58:31 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 07:58:31 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>
CC:     "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH resend 00/13] sh: convert to SPDX identifiers
Thread-Topic: [PATCH resend 00/13] sh: convert to SPDX identifiers
Thread-Index: AQHUjHBQa+haocNx3EGC4dMK+g7ynA==
Date:   Wed, 5 Dec 2018 07:58:31 +0000
Message-ID: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:404:14::20) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2430;20:SNmSsM6k374xbzabCPUtucdXne1PKsiOVtYObvTLOoJ9z3Hn5Mg1p/6kPI6B/L0wkRvPDudBpFt9mLQSHQLh2fk96gMjnS9tLcs1AUiOyFYq8MERU+pYvF/Na3162X31GY1PVRbtSFUr22WaODBLhS4KenU4zbYdZG4rWPlc49Y=
x-ms-office365-filtering-correlation-id: d84894ab-68e4-475f-dce6-08d65a87726d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2430;
x-ms-traffictypediagnostic: TYAPR01MB2430:
x-microsoft-antispam-prvs: <TYAPR01MB24306356AF0E1F026D86C659D4A80@TYAPR01MB2430.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB2430;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2430;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(396003)(376002)(39860400002)(366004)(136003)(199004)(189003)(3846002)(6506007)(97736004)(476003)(386003)(5660300001)(8936002)(81156014)(81166006)(52116002)(6116002)(19627235002)(8676002)(36756003)(2616005)(4326008)(86362001)(256004)(575784001)(99286004)(316002)(2906002)(25786009)(110136005)(54906003)(186003)(14454004)(478600001)(6512007)(6486002)(7736002)(105586002)(53946003)(486006)(106356001)(6436002)(53936002)(305945005)(66066001)(71200400001)(71190400001)(4744004)(68736007)(102836004)(26005)(579004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2430;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RrN00lN7flpaggUj5deQFOberVD+WDSUnK/j3F3MixqfvFGpInEmIYHTMmngchOjIJTacFOhQQc8FV3XqcCJIfV0CHgQuvMqDaIo5sy0yBKln9EvV05Acsw8wKD3MTgft9uS4Upf6Qpez1gjRHsBfIEmjaaIqiCTm1uzDF+ScwJebDAtmzsXToKi1drTkNAyZsZ1noGbtPo7qFuxUHiRJrCzBUMrsNmghPGpGxvRY0XfzMja3QNeXr32tuCd7DlbJuAJd7rAuCA94+PTawRnQVyWlU3M9KsK/5jOLqYLmw4lIaoDeF5IE75mVN+P+5CzmGE1nIN8nBUF4BK7WN37Abf+pD8ue205O2TAgyPKFZw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F1A78BE9B24F5544949CE3929AA5FB41@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84894ab-68e4-475f-dce6-08d65a87726d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 07:58:31.4136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2430
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew Morton.
Cc SH ML

I'm posting these patches to SH ML from few month ago,
but, nothing happen.
SH Maintainer seems not working anymore ?
I'm not sure...

So now, I added Andrew in To: field.
I'm happy if some maintainer can handle these

Kuninori Morimoto (13):
  sh: boards: convert to SPDX identifiers
  sh: drivers: convert to SPDX identifiers
  sh: include: convert to SPDX identifiers
  sh: sh2: convert to SPDX identifiers
  sh: sh2a: convert to SPDX identifiers
  sh: sh3: convert to SPDX identifiers
  sh: sh4: convert to SPDX identifiers
  sh: sh4a: convert to SPDX identifiers
  sh: sh5: convert to SPDX identifiers
  sh: shmobile: convert to SPDX identifiers
  sh: cpu: convert to SPDX identifiers
  sh: kernel: convert to SPDX identifiers
  sh: lib: convert to SPDX identifiers

 arch/sh/boards/board-apsh4a3a.c                    |  5 +---
 arch/sh/boards/board-apsh4ad0a.c                   |  5 +---
 arch/sh/boards/board-edosk7760.c                   | 15 +----------
 arch/sh/boards/board-espt.c                        |  5 +---
 arch/sh/boards/board-magicpanelr2.c                |  5 +---
 arch/sh/boards/board-sh7757lcr.c                   |  5 +---
 arch/sh/boards/board-sh7785lcr.c                   |  5 +---
 arch/sh/boards/board-titan.c                       |  5 +---
 arch/sh/boards/board-urquell.c                     |  5 +---
 arch/sh/boards/mach-ap325rxa/Makefile              |  1 +
 arch/sh/boards/mach-ap325rxa/sdram.S               |  7 ++----
 arch/sh/boards/mach-cayman/Makefile                |  1 +
 arch/sh/boards/mach-cayman/irq.c                   |  5 +---
 arch/sh/boards/mach-cayman/panic.c                 |  5 +---
 arch/sh/boards/mach-cayman/setup.c                 |  5 +---
 arch/sh/boards/mach-dreamcast/Makefile             |  1 +
 arch/sh/boards/mach-dreamcast/irq.c                |  2 +-
 arch/sh/boards/mach-dreamcast/rtc.c                |  4 +--
 arch/sh/boards/mach-dreamcast/setup.c              |  3 +--
 arch/sh/boards/mach-ecovec24/Makefile              |  3 ++-
 arch/sh/boards/mach-ecovec24/sdram.S               |  7 ++----
 arch/sh/boards/mach-ecovec24/setup.c               |  5 +---
 arch/sh/boards/mach-highlander/irq-r7780mp.c       |  5 +---
 arch/sh/boards/mach-highlander/irq-r7780rp.c       |  5 +---
 arch/sh/boards/mach-highlander/irq-r7785rp.c       |  5 +---
 arch/sh/boards/mach-highlander/pinmux-r7785rp.c    |  5 +---
 arch/sh/boards/mach-highlander/psw.c               |  5 +---
 arch/sh/boards/mach-highlander/setup.c             |  5 +---
 arch/sh/boards/mach-hp6xx/Makefile                 |  1 +
 arch/sh/boards/mach-hp6xx/hp6xx_apm.c              |  4 +--
 arch/sh/boards/mach-hp6xx/pm.c                     |  4 +--
 arch/sh/boards/mach-hp6xx/pm_wakeup.S              |  8 ++----
 arch/sh/boards/mach-hp6xx/setup.c                  |  4 +--
 arch/sh/boards/mach-kfr2r09/Makefile               |  1 +
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c            |  5 +---
 arch/sh/boards/mach-kfr2r09/sdram.S                |  7 ++----
 arch/sh/boards/mach-landisk/Makefile               |  1 +
 arch/sh/boards/mach-landisk/gio.c                  |  6 +----
 arch/sh/boards/mach-landisk/irq.c                  |  5 +---
 arch/sh/boards/mach-landisk/psw.c                  |  5 +---
 arch/sh/boards/mach-landisk/setup.c                |  5 +---
 arch/sh/boards/mach-lboxre2/Makefile               |  1 +
 arch/sh/boards/mach-lboxre2/irq.c                  |  6 +----
 arch/sh/boards/mach-lboxre2/setup.c                |  6 +----
 arch/sh/boards/mach-microdev/Makefile              |  1 +
 arch/sh/boards/mach-microdev/fdc37c93xapm.c        |  5 +---
 arch/sh/boards/mach-microdev/io.c                  |  4 +--
 arch/sh/boards/mach-microdev/irq.c                 |  4 +--
 arch/sh/boards/mach-microdev/setup.c               |  4 +--
 arch/sh/boards/mach-migor/Makefile                 |  1 +
 arch/sh/boards/mach-migor/lcd_qvga.c               |  5 +---
 arch/sh/boards/mach-migor/sdram.S                  |  7 ++----
 arch/sh/boards/mach-r2d/Makefile                   |  1 +
 arch/sh/boards/mach-r2d/setup.c                    |  5 +---
 arch/sh/boards/mach-rsk/Makefile                   |  1 +
 arch/sh/boards/mach-rsk/devices-rsk7203.c          |  5 +---
 arch/sh/boards/mach-rsk/devices-rsk7264.c          |  5 +---
 arch/sh/boards/mach-rsk/devices-rsk7269.c          |  5 +---
 arch/sh/boards/mach-rsk/setup.c                    |  5 +---
 arch/sh/boards/mach-sdk7780/Makefile               |  1 +
 arch/sh/boards/mach-sdk7780/irq.c                  |  5 +---
 arch/sh/boards/mach-sdk7780/setup.c                |  5 +---
 arch/sh/boards/mach-sdk7786/Makefile               |  1 +
 arch/sh/boards/mach-sdk7786/fpga.c                 |  5 +---
 arch/sh/boards/mach-sdk7786/gpio.c                 |  5 +---
 arch/sh/boards/mach-sdk7786/irq.c                  |  5 +---
 arch/sh/boards/mach-sdk7786/nmi.c                  |  5 +---
 arch/sh/boards/mach-sdk7786/setup.c                |  5 +---
 arch/sh/boards/mach-sdk7786/sram.c                 |  5 +---
 arch/sh/boards/mach-se/7206/Makefile               |  1 +
 arch/sh/boards/mach-se/7343/Makefile               |  1 +
 arch/sh/boards/mach-se/7343/irq.c                  |  5 +---
 arch/sh/boards/mach-se/770x/Makefile               |  1 +
 arch/sh/boards/mach-se/7721/Makefile               |  1 +
 arch/sh/boards/mach-se/7721/irq.c                  |  5 +---
 arch/sh/boards/mach-se/7721/setup.c                |  6 +----
 arch/sh/boards/mach-se/7722/Makefile               |  1 +
 arch/sh/boards/mach-se/7722/irq.c                  |  5 +---
 arch/sh/boards/mach-se/7722/setup.c                |  6 +----
 arch/sh/boards/mach-se/7724/Makefile               |  1 +
 arch/sh/boards/mach-se/7724/irq.c                  |  5 +---
 arch/sh/boards/mach-se/7724/sdram.S                |  7 ++----
 arch/sh/boards/mach-se/7751/Makefile               |  1 +
 arch/sh/boards/mach-se/7780/Makefile               |  1 +
 arch/sh/boards/mach-se/7780/irq.c                  |  5 +---
 arch/sh/boards/mach-se/7780/setup.c                |  5 +---
 arch/sh/boards/mach-sh03/Makefile                  |  1 +
 arch/sh/boards/mach-sh7763rdp/Makefile             |  1 +
 arch/sh/boards/mach-sh7763rdp/irq.c                |  5 +---
 arch/sh/boards/mach-sh7763rdp/setup.c              |  5 +---
 arch/sh/boards/mach-x3proto/Makefile               |  1 +
 arch/sh/boards/mach-x3proto/gpio.c                 |  5 +---
 arch/sh/boards/mach-x3proto/ilsel.c                |  5 +---
 arch/sh/boards/mach-x3proto/setup.c                |  5 +---
 arch/sh/boards/of-generic.c                        |  5 +---
 arch/sh/drivers/dma/Makefile                       |  1 +
 arch/sh/drivers/dma/dma-api.c                      |  7 ++----
 arch/sh/drivers/dma/dma-g2.c                       |  7 ++----
 arch/sh/drivers/dma/dma-pvr2.c                     |  7 ++----
 arch/sh/drivers/dma/dma-sh.c                       |  7 ++----
 arch/sh/drivers/dma/dma-sysfs.c                    |  5 +---
 arch/sh/drivers/dma/dmabrg.c                       |  3 +--
 arch/sh/drivers/heartbeat.c                        |  5 +---
 arch/sh/drivers/pci/fixups-dreamcast.c             |  5 +---
 arch/sh/drivers/pci/fixups-landisk.c               |  4 +--
 arch/sh/drivers/pci/fixups-r7780rp.c               |  5 +---
 arch/sh/drivers/pci/fixups-rts7751r2d.c            |  5 +---
 arch/sh/drivers/pci/fixups-sdk7780.c               |  5 +---
 arch/sh/drivers/pci/fixups-sdk7786.c               |  5 +---
 arch/sh/drivers/pci/fixups-snapgear.c              |  4 +--
 arch/sh/drivers/pci/fixups-titan.c                 |  4 +--
 arch/sh/drivers/pci/ops-dreamcast.c                |  5 +---
 arch/sh/drivers/pci/ops-sh4.c                      |  5 +---
 arch/sh/drivers/pci/ops-sh5.c                      |  4 +--
 arch/sh/drivers/pci/ops-sh7786.c                   |  5 +---
 arch/sh/drivers/pci/pci-dreamcast.c                |  5 +---
 arch/sh/drivers/pci/pci-sh5.c                      |  4 +--
 arch/sh/drivers/pci/pci-sh5.h                      |  6 ++---
 arch/sh/drivers/pci/pci-sh7751.c                   |  5 +---
 arch/sh/drivers/pci/pci-sh7751.h                   |  7 ++----
 arch/sh/drivers/pci/pci-sh7780.c                   |  5 +---
 arch/sh/drivers/pci/pci-sh7780.h                   |  7 ++----
 arch/sh/drivers/pci/pci.c                          |  5 +---
 arch/sh/drivers/pci/pcie-sh7786.c                  |  5 +---
 arch/sh/drivers/pci/pcie-sh7786.h                  |  7 ++----
 arch/sh/drivers/push-switch.c                      |  5 +---
 arch/sh/drivers/superhyway/Makefile                |  1 +
 arch/sh/drivers/superhyway/ops-sh4-202.c           |  5 +---
 arch/sh/include/asm/Kbuild                         |  1 +
 arch/sh/include/asm/addrspace.h                    |  5 +---
 arch/sh/include/asm/asm-offsets.h                  |  1 +
 arch/sh/include/asm/bl_bit_64.h                    |  7 ++----
 arch/sh/include/asm/cache_insns_64.h               |  7 ++----
 arch/sh/include/asm/checksum_32.h                  |  5 +---
 arch/sh/include/asm/cmpxchg-xchg.h                 |  4 +--
 arch/sh/include/asm/device.h                       |  5 ++--
 arch/sh/include/asm/dma-register.h                 |  7 ++----
 arch/sh/include/asm/dma.h                          |  7 ++----
 arch/sh/include/asm/dwarf.h                        |  8 ++----
 arch/sh/include/asm/fb.h                           |  1 +
 arch/sh/include/asm/fixmap.h                       |  7 ++----
 arch/sh/include/asm/flat.h                         |  7 ++----
 arch/sh/include/asm/freq.h                         |  8 ++----
 arch/sh/include/asm/gpio.h                         |  7 ++----
 arch/sh/include/asm/machvec.h                      |  6 ++---
 arch/sh/include/asm/mmu_context_64.h               |  5 +---
 arch/sh/include/asm/pgtable.h                      |  7 ++----
 arch/sh/include/asm/pgtable_64.h                   |  5 +---
 arch/sh/include/asm/processor_64.h                 |  5 +---
 arch/sh/include/asm/sfp-machine.h                  | 20 +++------------
 arch/sh/include/asm/shmparam.h                     |  7 ++----
 arch/sh/include/asm/siu.h                          |  7 ++----
 arch/sh/include/asm/spinlock-cas.h                 |  7 ++----
 arch/sh/include/asm/spinlock-llsc.h                |  7 ++----
 arch/sh/include/asm/spinlock.h                     |  7 ++----
 arch/sh/include/asm/string_32.h                    |  1 +
 arch/sh/include/asm/switch_to.h                    |  7 ++----
 arch/sh/include/asm/switch_to_64.h                 |  7 ++----
 arch/sh/include/asm/tlb_64.h                       |  7 ++----
 arch/sh/include/asm/traps_64.h                     |  7 ++----
 arch/sh/include/asm/uaccess_64.h                   |  5 +---
 arch/sh/include/asm/vga.h                          |  1 +
 arch/sh/include/asm/watchdog.h                     |  8 ++----
 arch/sh/include/cpu-common/cpu/addrspace.h         |  7 ++----
 arch/sh/include/cpu-common/cpu/mmu_context.h       |  7 ++----
 arch/sh/include/cpu-common/cpu/pfc.h               | 12 ++-------
 arch/sh/include/cpu-common/cpu/timer.h             |  1 +
 arch/sh/include/cpu-sh2/cpu/cache.h                |  7 ++----
 arch/sh/include/cpu-sh2/cpu/freq.h                 |  7 ++----
 arch/sh/include/cpu-sh2/cpu/watchdog.h             |  7 ++----
 arch/sh/include/cpu-sh2a/cpu/cache.h               |  7 ++----
 arch/sh/include/cpu-sh2a/cpu/freq.h                |  7 ++----
 arch/sh/include/cpu-sh2a/cpu/watchdog.h            |  1 +
 arch/sh/include/cpu-sh3/cpu/cache.h                |  7 ++----
 arch/sh/include/cpu-sh3/cpu/dma-register.h         |  7 ++----
 arch/sh/include/cpu-sh3/cpu/freq.h                 |  7 ++----
 arch/sh/include/cpu-sh3/cpu/gpio.h                 |  7 ++----
 arch/sh/include/cpu-sh3/cpu/mmu_context.h          |  7 ++----
 arch/sh/include/cpu-sh3/cpu/watchdog.h             |  7 ++----
 arch/sh/include/cpu-sh4/cpu/addrspace.h            |  5 +---
 arch/sh/include/cpu-sh4/cpu/cache.h                |  7 ++----
 arch/sh/include/cpu-sh4/cpu/dma-register.h         |  7 ++----
 arch/sh/include/cpu-sh4/cpu/fpu.h                  |  6 ++---
 arch/sh/include/cpu-sh4/cpu/freq.h                 |  7 ++----
 arch/sh/include/cpu-sh4/cpu/mmu_context.h          |  7 ++----
 arch/sh/include/cpu-sh4/cpu/sh7786.h               |  7 ++----
 arch/sh/include/cpu-sh4/cpu/sq.h                   |  7 ++----
 arch/sh/include/cpu-sh4/cpu/watchdog.h             |  7 ++----
 arch/sh/include/cpu-sh5/cpu/cache.h                |  5 +---
 arch/sh/include/cpu-sh5/cpu/irq.h                  |  5 +---
 arch/sh/include/cpu-sh5/cpu/registers.h            |  5 +---
 arch/sh/include/mach-common/mach/hp6xx.h           | 12 +++------
 arch/sh/include/mach-common/mach/lboxre2.h         |  6 +----
 arch/sh/include/mach-common/mach/magicpanelr2.h    |  7 ++----
 arch/sh/include/mach-common/mach/mangle-port.h     |  7 ++----
 arch/sh/include/mach-common/mach/microdev.h        |  6 ++---
 arch/sh/include/mach-common/mach/sdk7780.h         |  5 +---
 arch/sh/include/mach-common/mach/secureedge5410.h  |  6 ++---
 arch/sh/include/mach-common/mach/sh7763rdp.h       |  6 +----
 arch/sh/include/mach-dreamcast/mach/dma.h          |  7 ++----
 arch/sh/include/mach-dreamcast/mach/pci.h          |  7 ++----
 arch/sh/include/mach-dreamcast/mach/sysasic.h      |  7 +++---
 .../mach-ecovec24/mach/partner-jet-setup.txt       |  1 +
 .../mach-kfr2r09/mach/partner-jet-setup.txt        |  1 +
 arch/sh/include/mach-se/mach/se7721.h              |  8 ++----
 arch/sh/include/mach-se/mach/se7722.h              |  6 +----
 arch/sh/include/mach-se/mach/se7724.h              |  6 +----
 arch/sh/include/mach-se/mach/se7780.h              |  5 +---
 arch/sh/include/uapi/asm/Kbuild                    |  1 +
 arch/sh/include/uapi/asm/setup.h                   |  1 +
 arch/sh/include/uapi/asm/types.h                   |  1 +
 arch/sh/kernel/cpu/clock.c                         |  5 +---
 arch/sh/kernel/cpu/init.c                          |  5 +---
 arch/sh/kernel/cpu/irq/Makefile                    |  1 +
 arch/sh/kernel/cpu/irq/intc-sh5.c                  |  5 +---
 arch/sh/kernel/cpu/irq/ipr.c                       |  5 +---
 arch/sh/kernel/cpu/pfc.c                           | 10 +-------
 arch/sh/kernel/cpu/sh2/Makefile                    |  1 +
 arch/sh/kernel/cpu/sh2/clock-sh7619.c              |  5 +---
 arch/sh/kernel/cpu/sh2/entry.S                     |  7 ++----
 arch/sh/kernel/cpu/sh2/ex.S                        |  7 ++----
 arch/sh/kernel/cpu/sh2/probe.c                     |  5 +---
 arch/sh/kernel/cpu/sh2/setup-sh7619.c              |  5 +---
 arch/sh/kernel/cpu/sh2/smp-j2.c                    |  5 +---
 arch/sh/kernel/cpu/sh2a/clock-sh7201.c             |  5 +---
 arch/sh/kernel/cpu/sh2a/clock-sh7203.c             |  5 +---
 arch/sh/kernel/cpu/sh2a/clock-sh7206.c             |  5 +---
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c             |  5 +---
 arch/sh/kernel/cpu/sh2a/clock-sh7269.c             |  5 +---
 arch/sh/kernel/cpu/sh2a/entry.S                    |  7 ++----
 arch/sh/kernel/cpu/sh2a/ex.S                       |  7 ++----
 arch/sh/kernel/cpu/sh2a/fpu.c                      |  5 +---
 arch/sh/kernel/cpu/sh2a/opcode_helper.c            |  5 +---
 arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c            |  5 +---
 arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c            |  5 +---
 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c            |  5 +---
 arch/sh/kernel/cpu/sh2a/probe.c                    |  5 +---
 arch/sh/kernel/cpu/sh2a/setup-mxg.c                |  5 +---
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c             |  5 +---
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c             |  5 +---
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c             |  5 +---
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c             |  5 +---
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c             |  5 +---
 arch/sh/kernel/cpu/sh3/clock-sh3.c                 |  5 +---
 arch/sh/kernel/cpu/sh3/clock-sh7705.c              |  5 +---
 arch/sh/kernel/cpu/sh3/clock-sh7706.c              |  5 +---
 arch/sh/kernel/cpu/sh3/clock-sh7709.c              |  5 +---
 arch/sh/kernel/cpu/sh3/clock-sh7710.c              |  5 +---
 arch/sh/kernel/cpu/sh3/clock-sh7712.c              |  5 +---
 arch/sh/kernel/cpu/sh3/entry.S                     |  7 ++----
 arch/sh/kernel/cpu/sh3/ex.S                        |  9 +++----
 arch/sh/kernel/cpu/sh3/pinmux-sh7720.c             |  5 +---
 arch/sh/kernel/cpu/sh3/probe.c                     |  5 +---
 arch/sh/kernel/cpu/sh3/setup-sh3.c                 |  5 +---
 arch/sh/kernel/cpu/sh3/setup-sh7705.c              |  5 +---
 arch/sh/kernel/cpu/sh3/setup-sh770x.c              |  5 +---
 arch/sh/kernel/cpu/sh3/setup-sh7710.c              |  5 +---
 arch/sh/kernel/cpu/sh3/setup-sh7720.c              |  5 +---
 arch/sh/kernel/cpu/sh3/swsusp.S                    |  7 ++----
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c             |  5 +---
 arch/sh/kernel/cpu/sh4/clock-sh4.c                 |  5 +---
 arch/sh/kernel/cpu/sh4/fpu.c                       |  5 +---
 arch/sh/kernel/cpu/sh4/perf_event.c                |  5 +---
 arch/sh/kernel/cpu/sh4/probe.c                     |  5 +---
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c             |  5 +---
 arch/sh/kernel/cpu/sh4/setup-sh7750.c              |  5 +---
 arch/sh/kernel/cpu/sh4/setup-sh7760.c              |  5 +---
 arch/sh/kernel/cpu/sh4/sq.c                        |  5 +---
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c             | 14 +----------
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c             | 14 +----------
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c             | 14 +----------
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c             | 14 +----------
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c             | 14 +----------
 arch/sh/kernel/cpu/sh4a/clock-sh7734.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/clock-sh7763.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/clock-sh7770.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/clock-sh7780.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/clock-shx3.c               |  5 +---
 arch/sh/kernel/cpu/sh4a/intc-shx3.c                |  5 +---
 arch/sh/kernel/cpu/sh4a/perf_event.c               |  5 +---
 arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c            |  5 +---
 arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c            |  5 +---
 arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c            |  5 +---
 arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c            |  5 +---
 arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c            |  5 +---
 arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c            |  5 +---
 arch/sh/kernel/cpu/sh4a/pinmux-shx3.c              |  5 +---
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c             |  7 ++----
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c             |  5 +---
 arch/sh/kernel/cpu/sh4a/setup-shx3.c               |  5 +---
 arch/sh/kernel/cpu/sh4a/smp-shx3.c                 |  5 +---
 arch/sh/kernel/cpu/sh4a/ubc.c                      |  5 +---
 arch/sh/kernel/cpu/sh5/clock-sh5.c                 |  5 +---
 arch/sh/kernel/cpu/sh5/entry.S                     |  7 ++----
 arch/sh/kernel/cpu/sh5/fpu.c                       |  5 +---
 arch/sh/kernel/cpu/sh5/probe.c                     |  5 +---
 arch/sh/kernel/cpu/sh5/setup-sh5.c                 |  5 +---
 arch/sh/kernel/cpu/sh5/switchto.S                  |  7 ++----
 arch/sh/kernel/cpu/sh5/unwind.c                    |  5 +---
 arch/sh/kernel/cpu/shmobile/Makefile               |  1 +
 arch/sh/kernel/cpu/shmobile/cpuidle.c              |  5 +---
 arch/sh/kernel/cpu/shmobile/pm.c                   |  5 +---
 arch/sh/kernel/cpu/shmobile/sleep.S                |  7 ++----
 arch/sh/kernel/debugtraps.S                        |  7 ++----
 arch/sh/kernel/disassemble.c                       |  5 +---
 arch/sh/kernel/dma-coherent.c                      |  5 +---
 arch/sh/kernel/dumpstack.c                         |  5 +---
 arch/sh/kernel/dwarf.c                             |  5 +---
 arch/sh/kernel/entry-common.S                      |  8 ++----
 arch/sh/kernel/head_32.S                           |  7 ++----
 arch/sh/kernel/head_64.S                           |  7 ++----
 arch/sh/kernel/hw_breakpoint.c                     |  5 +---
 arch/sh/kernel/idle.c                              |  5 +---
 arch/sh/kernel/io.c                                |  5 +---
 arch/sh/kernel/io_trapped.c                        |  5 +---
 arch/sh/kernel/iomap.c                             |  5 +---
 arch/sh/kernel/ioport.c                            |  5 +---
 arch/sh/kernel/irq_32.c                            |  5 +---
 arch/sh/kernel/irq_64.c                            |  5 +---
 arch/sh/kernel/kgdb.c                              |  5 +---
 arch/sh/kernel/kprobes.c                           |  5 +---
 arch/sh/kernel/machine_kexec.c                     |  4 +--
 arch/sh/kernel/machvec.c                           |  5 +---
 arch/sh/kernel/module.c                            | 15 +----------
 arch/sh/kernel/nmi_debug.c                         |  5 +---
 arch/sh/kernel/perf_callchain.c                    |  5 +---
 arch/sh/kernel/perf_event.c                        |  5 +---
 arch/sh/kernel/process_32.c                        |  5 +---
 arch/sh/kernel/process_64.c                        |  5 +---
 arch/sh/kernel/ptrace_32.c                         |  5 +---
 arch/sh/kernel/ptrace_64.c                         |  5 +---
 arch/sh/kernel/relocate_kernel.S                   |  6 ++---
 arch/sh/kernel/return_address.c                    |  5 +---
 arch/sh/kernel/sh_bios.c                           |  5 +---
 arch/sh/kernel/sh_ksyms_64.c                       |  5 +---
 arch/sh/kernel/signal_64.c                         |  5 +---
 arch/sh/kernel/smp.c                               |  5 +---
 arch/sh/kernel/stacktrace.c                        |  5 +---
 arch/sh/kernel/swsusp.c                            |  5 +---
 arch/sh/kernel/syscalls_32.S                       |  8 ++----
 arch/sh/kernel/syscalls_64.S                       |  7 ++----
 arch/sh/kernel/time.c                              |  5 +---
 arch/sh/kernel/topology.c                          |  5 +---
 arch/sh/kernel/traps_32.c                          |  5 +---
 arch/sh/kernel/traps_64.c                          |  5 +---
 arch/sh/kernel/unwinder.c                          |  1 +
 arch/sh/kernel/vsyscall/vsyscall.c                 |  5 +---
 arch/sh/lib/ashiftrt.S                             | 29 +++---------------=
----
 arch/sh/lib/ashlsi3.S                              | 29 +++---------------=
----
 arch/sh/lib/ashrsi3.S                              | 29 +++---------------=
----
 arch/sh/lib/checksum.S                             |  9 +++----
 arch/sh/lib/io.c                                   |  5 +---
 arch/sh/lib/libgcc.h                               |  2 ++
 arch/sh/lib/lshrsi3.S                              | 29 +++---------------=
----
 arch/sh/lib/mcount.S                               |  7 ++----
 arch/sh/lib/movmem.S                               | 29 +++---------------=
----
 arch/sh/lib/udiv_qrnnd.S                           | 29 +++---------------=
----
 arch/sh/lib/udivsi3.S                              | 29 +++---------------=
----
 arch/sh/lib/udivsi3_i4i-Os.S                       | 29 +++---------------=
----
 arch/sh/lib/udivsi3_i4i.S                          | 29 +++---------------=
----
 373 files changed, 497 insertions(+), 1671 deletions(-)

--=20
2.7.4

