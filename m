Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AE3C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B914208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emc.com header.i=@emc.com header.b="J2XjAQSu";
	dkim=pass (1024-bit key) header.d=emc.com header.i=@emc.com header.b="vO92ZhxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B914208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936355AbeFOTND (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:13:03 -0400
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:1945 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934701AbeFOTNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=emc.com; i=@emc.com; q=dns/txt; s=jan2013;
  t=1529089466; x=1560625466;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=QUdy+Vdq0We6cXLB1mzplCx2eAgHOLDH+LeZef0joE0=;
  b=J2XjAQSu5fr2ZQPetrJd2FJxjxCjDXXxgVTSlLIGGt5Ndiybx4ccwWGS
   /lv1xuy4AmzUXEP3V4xPgC+g5OOarKjACQPZde+sfxFaPcTL5hkCZlE34
   FbX+CF8cVJXQaYYJDiKAFMx4JNDCwVGyx/C1dqsKGmKHwoHjHSrGGzPBg
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HyAABpDiRbmMmZ6ERbHgEGDIJ1gSeBD?=
 =?us-ascii?q?SgKmEWWboE9OwsuhD4CglMhNBgBAgEBAQEBAQIBAQIQAQEBAQEICwsGKSMMgjU?=
 =?us-ascii?q?iEUshCDMBAQEBAQEBAQEBAQEBAQEBAQEXAkMTYR8bEQEaEFYXDwEEARqDGoIBA?=
 =?us-ascii?q?awvgniFUYFgCIhMgVU+gQ+HWyiDMIIkjDs3jB4DBAICnDYBkRoCBAIEBQIUgUF?=
 =?us-ascii?q?fgSxwgxOCIQ4Jg0WKUm+OEoEtgRoBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HyAABpDiRbmMmZ6ERbHgEGDIJ1gSeBDSgKmEWWboE9Ows?=
 =?us-ascii?q?uhD4CglMhNBgBAgEBAQEBAQIBAQIQAQEBAQEICwsGKSMMgjUiEUshCDMBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEXAkMTYR8bEQEaEFYXDwEEARqDGoIBAawvgniFUYFgCIh?=
 =?us-ascii?q?MgVU+gQ+HWyiDMIIkjDs3jB4DBAICnDYBkRoCBAIEBQIUgUFfgSxwgxOCIQ4Jg?=
 =?us-ascii?q?0WKUm+OEoEtgRoBAQ?=
Received: from esa1.dell-outbound2.iphmx.com ([68.232.153.201])
  by esa5.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 14:04:25 -0500
Received: from mailuogwdur.emc.com ([128.221.224.79])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2018 01:10:42 +0600
Received: from maildlpprd51.lss.emc.com (maildlpprd51.lss.emc.com [10.106.48.155])
        by mailuogwprd52.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id w5FJCwTC007948
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Jun 2018 15:12:59 -0400
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd52.lss.emc.com w5FJCwTC007948
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=emc.com; s=jan2013;
        t=1529089979; bh=DhgF1eMzSQJm6zudKTFbb7FDSPU=;
        h=From:To:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=vO92ZhxFmDoVv9Pu/Qh6jkTD3VbYboKsmJL46dTzGUD/RNSFAUBqtIQZPh51BW/Ia
         aWj1S0If6uzer/d/3z7SEu06tO9PhR7X855AWx6sMgfa31RH4XJyEj8EBnaIAn/yWW
         GC2A02rnefgUD2ToSHHc89/FamfZIxDsvQPvq1SI=
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd52.lss.emc.com w5FJCwTC007948
Received: from mailusrhubprd54.lss.emc.com (mailusrhubprd54.lss.emc.com [10.106.48.19]) by maildlpprd51.lss.emc.com (RSA Interceptor); Fri, 15 Jun 2018 15:12:37 -0400
Received: from MXHUB107.corp.emc.com (MXHUB107.corp.emc.com [10.253.50.23])
        by mailusrhubprd54.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id w5FJCbId022206
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 15 Jun 2018 15:12:38 -0400
Received: from MX202CL04.corp.emc.com ([fe80::2c45:625c:d914:779]) by
 MXHUB107.corp.emc.com ([10.253.50.23]) with mapi id 14.03.0382.000; Fri, 15
 Jun 2018 15:12:37 -0400
From:   "Veluthakkal, Sreeram" <Sreeram.Veluthakkal@emc.com>
To:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: PROBLEM: JFFS2 Empty summary info causes OOPS
Thread-Topic: PROBLEM: JFFS2 Empty summary info causes OOPS
Thread-Index: AdQE3M/RiorCtr0MSpWcP8pS9Zw+Kw==
Date:   Fri, 15 Jun 2018 19:12:36 +0000
Message-ID: <CD71A13FD89021478C0F0D323D55243A015AF0F9@MX202CL04.corp.emc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.168.21.26]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Sentrion-Hostname: mailusrhubprd54.lss.emc.com
X-RSA-Classifications: public
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[1.] Summary: JFFS2 Empty summary node info causes OOPS
[2.] Description: Under stress situations on the filesystem, OOPs are obser=
ved. The OOPs points to empty summary node info bug. Confirmed that the fil=
esystem is not full, not corrupted and is accessible.
[3.] Keywords (i.e., modules, networking, kernel): filesystem
[4.] Kernel information
[4.1.] Kernel version (from /proc/version): 4.1.12
Driver version:=A0 jffs2: version 2.2. (NAND) (SUMMARY)=A0 =A9 2001-2006 Re=
d Hat, Inc.
[6.] Output of Oops..=20

Kernel BUG at c0268c78 [verbose debug info unavailable]
Internal error: Oops - BUG: 0 [#1] SMP ARM
Modules linked in: npcm750_rng dell_usbmuxdrv(O) g_edm_mass_storage3 vcd_de=
v(O)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 usb_storage sd_mod scsi_mod rng_core oprofile md4 g_edm_mass_s=
torage2 des_generi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 c dell_regmem_adds(O) dell_pmdrv(O) dell_oom_notify(O=
) dell_msgbox(O) g_edm_mass =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0_storage1 dell_fpdrv(O) dell_early_board(O=
) dell_ipmbdrv(O) dell_i2cdrv(O) dell_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0cplddrv(O) g_edm_mass_storage =
cifs bonding g_edm_kbdmouse usb_f_ecm g_ether_usb=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0arc4 aess_vkcsd=
rv(O) aess_smadrv(O) usb_f_rndis u_ether aess_pwmdrv(O) aess_pcim=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ailbo=
xdrv(O) aess_mtddrv_spi_nor(O) aess_memdrv(O) libcomposite aess_fansensordr=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 v(O) aess_dynairqdrv(O) aess_gpiodrv(O) aess_video(O) aess_biospostdrv(=
O) aess_k=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 csdrv(O) aess_eventhandlerdrv(O) aess_adcsensordrv(O)
CPU: 1 PID: 998 Comm: cfgmgrd Tainted: G=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 O=A0=
=A0=A0 4.1.12
Hardware name: NPCMX50 Chip family
task: d7ccd340 ti: d7c8a000 task.ti: d7c8a000
PC is at jffs2_sum_write_sumnode+0x508/0x518
LR is at jffs2_sum_write_sumnode+0x508/0x518
pc : [<c0268c78>]=A0=A0=A0 lr : [<c0268c78>]=A0=A0=A0 psr: 600b0013
sp : d7c8ba90=A0 ip : 00000000=A0 fp : d7c8bb80
r10: 000000c4=A0 r9 : d84510a8=A0 r8 : 00200200
r7 : 00000fa4=A0 r6 : d84510a8=A0 r5 : d9aac000=A0 r4 : d98ca5c0
r3 : 00000000=A0 r2 : dcba772c=A0 r1 : dcba52dc=A0 r0 : 00000044
Flags: nZCv=A0 IRQs on=A0 FIQs on=A0 Mode SVC_32=A0 ISA ARM=A0 Segment user
Control: 18c5387d=A0 Table: 17ea404a=A0 DAC: 00000015
Process cfgmgrd (pid: 998, stack limit =3D 0xd7c8a190)
Stack: (0xd7c8ba90 to 0xd7c8c000)
ba80:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00000000 d7c8ba88 c08a6080 c09159c0
baa0: 0000000a 0091ccfe d9aac11c d7c8bac0 bf074c4c bf072de0 c08a2ae8 de32a0=
00
bac0: 0c200319 b1000000 00e41eb0 00000000 bf074c4c 00000000 00000000 000000=
02
bae0: 001eb000 bf074c4c 00000000 d9aac000 00000fcc d84510a8 00000fa4 002002=
00
bb00: 00100100 000000c4 d7c8bb80 c0259678 bf074c58 d7c8bb47 00000001 000000=
00
bb20: d7c8bc38 d95f5958 d9aac11c 000000c4 d9aac000 00000fa4 d7c8bb80 db4aa4=
80
bb40: d845100c c0259c98 d95f5958 d9aac000 00000fa4 d9aac000 d85b3d80 d9be43=
f8
bb60: db4aa480 c0604dc8 00000000 c0124818 d95f5998 0019d7bf d9ad9400 c060b4=
4c
bb80: 000000c4 c060b44c d95f5998 d95f5958 d9aac000 00028000 d8626700 d85b3d=
80
bba0: d95f5980 d9be43f8 d845100c c0605688 0019d7bf 00000000 d9be43f8 d84510=
0c
bbc0: db4aa480 00029000 00000000 c00532a8 00000000 d9aac000 0003b000 c060b4=
64
bbe0: 200b0013 c060b464 0003b000 c025fee4 00000000 00000000 d7c8bc20 000000=
00
bc00: d7c8bc1c 00000001 d9aac0fc 00000000 c094fe90 00100100 00200200 d9aac0=
00
bc20: d9aac000 0019d7bf 00000000 c02614ec 0000000c e41eb0b1 d9aac000 d9aac0=
00
bc40: d9aac11c 0019d7bf d9aac04c d9be43f8 d845100c d95f5958 d9aac164 c025ed=
54
bc60: 00000000 c0029350 0000000c 00000001 00000048 c025960c ffffffff 000000=
01
bc80: d8496040 00000001 00000000 d9aac000 d9aac11c 00000014 d9aac04c d7c8a0=
00
bca0: 00000013 00000000 d7c8bd24 c0259acc d8496040 0000001c 800b0013 c060b4=
64
bcc0: d8496040 c002a158 d9aac000 800b0013 dab67208 00000000 dab67208 dab672=
08
bce0: c7b77954 d9aac2fc c0793f84 d9aac000 d9aac41c c0266228 00000006 c060b5=
c0
bd00: 00000000 c7b77940 c5f06c00 00000007 c7b77954 d7c8bd7c d9aac0c0 d7c8bd=
74
bd20: cc59aba8 00000fb8 d9575c98 d7c8bd74 cc59aba8 00000000 c0266aac cc59ab=
68
bd40: d9aac000 d9575c98 d96c4280 c0266b00 0000001e 00000000 c02ca360 000000=
00
bd60: cc59aba8 c02c2f74 d7c8bd78 d7c8bd7c d9575c98 c0793f84 c5f06c00 000000=
1e
bd80: 00000000 00000000 00000000 00000000 00000000 00000000 d9aac000 cc59ab=
a8
bda0: d85f07c0 d9aac000 d95a41d8 c0266c24 00000000 d85f07c0 d9aac000 c025c7=
fc
bdc0: 00000000 00000000 000081b4 00000058 cc59aba8 d95a4218 cc59ab68 d85f07=
c0
bde0: d96c4280 c0256f18 d96c4298 ffffffff 00000001 c0256e70 00000000 d95a42=
18
be00: 00000000 d96c4280 000081b4 c0118b24 00000301 c0116dcc d7c8bef0 d7c8bf=
74
be20: d9575c98 00020042 d7c8beb0 c01191b8 00000000 0000001b 00000000 c3fd87=
00
be40: 00000026 00000000 00000000 00000001 dbff4810 d9575c98 db42fc10 d95ca5=
78
be60: 00cfa5c8 c02c7fe8 c3fd8700 c3fd8700 d7c8bef0 00000000 d7c8bf74 c7aac0=
00
be80: d7c8beb0 00000000 47cfa5c8 c0119884 d7c8beac c7aac000 ffffff9c c02c5d=
d0
bea0: d7ccd340 c02c5dd0 dbff4810 00000001 3b3a2618 00000000 beacfef8 000000=
c3
bec0: c000a628 d7c8bf74 00000001 ffffff9c c7aac000 c000a628 d7c8a000 000000=
00
bee0: 47cfa5c8 c011ad94 00000041 00000001 dbff4810 d9575c98 00f359c0 000000=
1b
bf00: c7aac023 00000000 dbd83a10 dc1a1d30 d95a4218 00000301 00000002 000016=
32
bf20: 00000000 00000000 00000000 c060b44c dc1d3658 c0127630 c08b07d4 000a00=
42
bf40: 00000000 000a0042 ffffff9c c7aac000 00000005 00000022 ffffff9c c7aac0=
00
bf60: 00000005 c010b0ec 000003e4 00000000 00005000 00020042 390b81b4 000000=
26
bf80: 00000300 00000001 390d2ec2 000a0042 00064128 000001b4 00000005 c000a6=
28
bfa0: d7c8a000 c000a460 000a0042 00064128 00064128 000a0042 000001b4 000000=
00
bfc0: 000a0042 00064128 000001b4 00000005 00020042 000001b4 000003e5 47cfa5=
c8
bfe0: beacfdfc beacfe10 b6f0b4c0 473d0fec 800b0010 00064128 00000000 000000=
00
[<c0268c78>] (jffs2_sum_write_sumnode) from [<c0259678>] (jffs2_do_reserve_=
space=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0+0x138/0x41c)
[<c0259678>] (jffs2_do_reserve_space) from [<c0259c98>] (jffs2_reserve_spac=
e_gc+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0x48/0x80)
[<c0259c98>] (jffs2_reserve_space_gc) from [<c0604dc8>] (jffs2_garbage_coll=
ect_p=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ristine+0x50/0x3b8)
[<c0604dc8>] (jffs2_garbage_collect_pristine) from [<c0605688>] (jffs2_garb=
age_c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ollect_live+0x3f0/0xf44)
[<c0605688>] (jffs2_garbage_collect_live) from [<c025ed54>] (jffs2_garbage_=
colle=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ct_pass+0x42c/0x854)
[<c025ed54>] (jffs2_garbage_collect_pass) from [<c0259acc>] (jffs2_reserve_=
space=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0+0x170/0x2f4)
[<c0259acc>] (jffs2_reserve_space) from [<c0266228>] (do_jffs2_setxattr+0x4=
14/0x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0664)
[<c0266228>] (do_jffs2_setxattr) from [<c0266b00>] (jffs2_initxattrs+0x54/0=
x6c)
[<c0266b00>] (jffs2_initxattrs) from [<c02c2f74>] (security_inode_init_secu=
rity+=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A00xec/0x114)
[<c02c2f74>] (security_inode_init_security) from [<c0266c24>] (jffs2_init_s=
ecuri=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0ty+0x24/0x2c)
[<c0266c24>] (jffs2_init_security) from [<c025c7fc>] (jffs2_do_create+0xc8/=
0x270=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0)
[<c025c7fc>] (jffs2_do_create) from [<c0256f18>] (jffs2_create+0xa8/0x128)
[<c0256f18>] (jffs2_create) from [<c0118b24>] (vfs_create+0xb8/0xec)
[<c0118b24>] (vfs_create) from [<c01191b8>] (do_last+0x660/0xca4)
[<c01191b8>] (do_last) from [<c0119884>] (path_openat+0x88/0x614)
[<c0119884>] (path_openat) from [<c011ad94>] (do_filp_open+0x34/0x90)
[<c011ad94>] (do_filp_open) from [<c010b0ec>] (do_sys_open+0x110/0x1d4)
[<c010b0ec>] (do_sys_open) from [<c000a460>] (ret_fast_syscall+0x0/0x3c)
Code: e34c0078 e593300c e5931330 eb0e6d3f (e7f001f2)

[8.] Environment
[8.2.] Processor information (from /proc/cpuinfo):=20
processor=A0=A0=A0=A0=A0=A0 : 0
model name=A0=A0=A0=A0=A0 : ARMv7 Processor rev 1 (v7l)
BogoMIPS=A0=A0=A0=A0=A0=A0=A0 : 1594.16
Features=A0=A0=A0=A0=A0=A0 =A0: half thumb fastmult edsp tls
CPU implementer : 0x41
CPU architecture: 7
CPU variant=A0=A0=A0=A0 : 0x4
CPU part=A0=A0=A0=A0=A0=A0=A0 : 0xc09
CPU revision=A0=A0=A0 : 1

processor=A0=A0=A0=A0=A0=A0 : 1
model name=A0=A0=A0=A0=A0 : ARMv7 Processor rev 1 (v7l)
BogoMIPS=A0=A0=A0=A0=A0=A0=A0 : 1594.16
Features=A0=A0=A0=A0=A0=A0=A0 : half thumb fastmult edsp tls
CPU implementer : 0x41
CPU architecture: 7
CPU variant=A0=A0=A0=A0 : 0x4
CPU part=A0=A0=A0=A0=A0=A0=A0 : 0xc09
CPU revision=A0=A0=A0 : 1

Hardware=A0=A0=A0=A0=A0=A0=A0 : NPCMX50 Chip family
Revision=A0=A0=A0=A0=A0=A0=A0 : 0000
Serial=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 0000000000000000
[8.3.] Module information (from /proc/modules):
[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
00000000-1cffffff : System RAM
=A0 00008000-007f6d9f : Kernel code
=A0 0085e000-00938133 : Kernel data
1d000000-1e1fffff : aess_video
c0000000-c0000fff : fb000000.fiu
c0008000-c0008fff : shmem_sram
f0008000-f0008fff : f0008000.watchdog
f000b000-f000bfff : f000b000.rng
f0189000-f0189fff : f0189000.otp
f018a000-f018afff : f0189000.otp
f0802000-f0803fff : /ahb/eth@f0802000
f0806000-f0806fff : ehci_hcd
f0808000-f0808fff : aess_video
f0825000-f0825fff : f0825000.eth
f0826000-f0826fff : f0826000.eth
f0830000-f0830fff : /ahb/udc@f0830000
f0831000-f0831fff : /ahb/udc@f0831000
f0832000-f0832fff : /ahb/udc@f0832000
f0833000-f0833fff : /ahb/udc@f0833000
f0834000-f0834fff : /ahb/udc@f0834000
f0835000-f0835fff : /ahb/udc@f0835000
f0836000-f0836fff : /ahb/udc@f0836000
f0837000-f0837fff : /ahb/udc@f0837000
f0838000-f0838fff : /ahb/udc@f0838000
f0839000-f0839fff : /ahb/udc@f0839000
f0840000-f08401ff : /ahb/sdhci@f0840000
f0842000-f08421ff : /ahb/sdhci@f0842000
f0858000-f0858fff : f0858000.aes
fb000000-fb000fff : fb000000.fiu
fb001000-fb001fff : fb000000.fiu
fffe3000-fffeffff : fffe3000.trab

Thanks,
Sreeram
