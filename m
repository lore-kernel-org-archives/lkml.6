Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8015CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078752147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="XOWSaRea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfBZIsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:48:37 -0500
Received: from mail-eopbgr00134.outbound.protection.outlook.com ([40.107.0.134]:17634
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfBZIsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RyKvrXorC8XSlRLKJn2N8YqPHpRS28rGpdu7YDyObA=;
 b=XOWSaRea4Gd7nFd7fgc9LLgWY3kWlSuAmJm4crXg4txFFmsNttWxAttMLRrxJez9IuUMIjdTdnjQMzw/4u1G/2TVKZAhzDdnnJl4RVvKkutJG/BMl13kGKH+WLtg7h69NQc3ASTWQveQIaCxHeAsrHxs0t2yihq3ipFqjfUt7nU=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2189.EURPRD10.PROD.OUTLOOK.COM (20.177.60.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 08:48:28 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 08:48:28 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [RFC PATCH] soc/fsl/qe: support MPC8309
Thread-Topic: [RFC PATCH] soc/fsl/qe: support MPC8309
Thread-Index: AQHUzbALXjDeDpgRFU++rfaOQW65Lg==
Date:   Tue, 26 Feb 2019 08:48:28 +0000
Message-ID: <20190226084816.20535-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0041.eurprd07.prod.outlook.com
 (2603:10a6:7:66::27) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd54a2ab-d4d4-4a5d-7bfb-08d69bc72d74
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2189;
x-ms-traffictypediagnostic: VI1PR10MB2189:
x-microsoft-antispam-prvs: <VI1PR10MB21897B74499948C5B945165F8A7B0@VI1PR10MB2189.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(396003)(39850400004)(366004)(189003)(199004)(51234002)(54906003)(2906002)(110136005)(316002)(45080400002)(50226002)(6486002)(107886003)(486006)(25786009)(6116002)(3846002)(4326008)(44832011)(42882007)(6512007)(186003)(53936002)(106356001)(476003)(81166006)(81156014)(72206003)(6436002)(8976002)(256004)(8676002)(14444005)(478600001)(7736002)(14454004)(26005)(105586002)(2616005)(6506007)(36756003)(386003)(71200400001)(1076003)(6346003)(71190400001)(5660300002)(97736004)(102836004)(66066001)(305945005)(74482002)(99286004)(68736007)(52116002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2189;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR10MB2189;23:o4zKqS1ol1QKaNO8gVrbLpzzce7ACY75o7JpzVc?=
 =?iso-8859-1?Q?NnCcykf5DJ8EzQSA7Fz9CnT5faW6Na9jqJpiAGHovN1q3Nwixvzw1FvmvS?=
 =?iso-8859-1?Q?VLsxYM70z9IssyyynLIzn2hjZ+EBy71Lzz57mv5p6CyZ9dlrf/5OMDX+9u?=
 =?iso-8859-1?Q?iKRcox61aK1v5A1bnuY/lyAz6HyLUsP4myGengaDnIjxi2VRIBYZtl2RfU?=
 =?iso-8859-1?Q?WoJdL1w5mv2/SwZChp2tR3KC4x2/DSOLusE8w+PLKr4eW2eY4qbuEJxinS?=
 =?iso-8859-1?Q?CzL23n3L58eHA2LPXDKfikFhl4nDWKyPV6eEE7GxmPo0DwSjTpeayk3hdf?=
 =?iso-8859-1?Q?KKwRNRW6Qw+UTA/faUFgB3mb2N+WdM5YEMyAVL8Ib7WmkyDDjVx/VGEjsr?=
 =?iso-8859-1?Q?+qTAR6nF0IUtzJCSodsSM8QJfqtQv4exDZbNMPTUvkqZGAip2mYpI474gs?=
 =?iso-8859-1?Q?DSVjkDvsL+DctOxkkaEIjaHo/WPCeqb6cpQUZl+dNLukIoxTiGZ7Tj09cI?=
 =?iso-8859-1?Q?EAZGGItMDLlE7fkb7A+TV1bUXWzags/7/Iv7d6c4TZJK4Ab3UTFY79yCnG?=
 =?iso-8859-1?Q?9i7r6NavVgLOQNuvse02ZkOirzFFo7JZM/twNO01J71HPCmBfNaVfEEGig?=
 =?iso-8859-1?Q?nG+AsP77IMHFBiyQ94WzvTXjZNiFSSvwF/jiHYW3sRS+LTcpWPSNuhjcZ1?=
 =?iso-8859-1?Q?m5ONbvBB+hO10ONkfO9GcB0pfky9scY6nqjmcGweGm/q6wo9AU8E6vwfWm?=
 =?iso-8859-1?Q?UXFbw/KmWC079IzsfUidovLZniW1UDslcKCzdHxFr0OlGADxoCbA9krYdO?=
 =?iso-8859-1?Q?0UduWfVUZEHQimlPuc7D2Su1Xn4iBt2qhQcaBGcXIvROfjTePSQ2tvzJHX?=
 =?iso-8859-1?Q?DjgFMRdT1ya9IXIVAkdM1FGf38YF26iF3THDzexcRSB9x6RIVCO33p9PxJ?=
 =?iso-8859-1?Q?Y1rayx+v1/ldwlVUdxlu/jsy24X39BT5q9fY4k9C0mwQdaOtnsPa13hWck?=
 =?iso-8859-1?Q?e0TQ7SsVi1XnERVCL8qA2V80xferLgpS/s/zVp8AM7mlu/W09eN9KiPu1v?=
 =?iso-8859-1?Q?221uQ/FRYLYBqY0OiPY2RlxIU5zcybQcaJTP8U1hTYsWzlooXTFjwzJnlf?=
 =?iso-8859-1?Q?0yYO78JRWof2Yy7q8TrVFc7Ag2wcE6DCDi2P/L8Amkrbc8tBemJbHhznRW?=
 =?iso-8859-1?Q?EoMUZ2iD1gMonJJ8Y8OQfZa6owp4nZfaqQ1ixjdbfrvD119NUMt/J9IdHZ?=
 =?iso-8859-1?Q?aXGj1AjhjQ8QwxgzXrWVtTDeJ9GdIBj8zAS5rGk9y3dpw/1xhUlm8SArJ3?=
 =?iso-8859-1?Q?csRoMqVhwPlmld6UZL/61rwmfypEFDdqnM4OL36/gX+ceGnNOBswGK92/k?=
 =?iso-8859-1?Q?JjWAH2eTbFi4xigmGpMflmOY7lc4xSViovZRR1ENsGA+ntXDzRA=3D=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0GFdNxNhGj2oidpO1lUcP9/BTgeh4cUNlGGcKfu7zlyFQ5Cy0g+SnQsRWblSSawGO/IaU0AScL+Bze3vZCqrcuJYXVqdjfRK9t8CRc+HWa13iguISNvOlIW8UzDpQ3AFt7ToAedUDtS/QL/c4BHqtjWqR7hCx4eUgFwH1RIaWdyYrHmB8POWpP5bQT/b8MofOxibUr1whUvZTsF0NmKikb/L/i37n/9gD62tH3buqy2A7hYYpK92GxR4cFYqUVXNDDkC/gkZBTwxqCQ1BOH735N3s7NdKuSkWyy4dtPgIx15Y05zbm5Uo1aVZe4r/bDpOODgijxc2RCQEK0InDDYnuC3oL0b0Zagv8bSvpXmXiXG/Sw378S0/7zWUcJ2UX0DACzBOVrL3nByezmvQOPUjBN2aHVb+uXxdh9X8jsZbAo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: dd54a2ab-d4d4-4a5d-7bfb-08d69bc72d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 08:48:27.7315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when device tree specifies fsl,qe-num-snums =3D 28 (which a
number of in-tree .dts files do, and which is the default when that
property is missing), qe_snums_init() ends up using the first 28
elements of the snum_init_46[] array.

The situation is quite messy. This patch may break existing setups
that for some reason work with specifying fsl,qe-num-snums =3D 28 and
using the existing snum_init_46 array. OTOH, the current code
certainly does not work for the MPC8309-based board we're working on,
since the first 14 of the elements in snum_init_46 are "Not available
on MPC8306/MPC8306S/MPC8309" according to the QUICC Engine Reference
Manual (Table 4-30) - and indeed, without this patch (or something to
the same effect), we get

[    8.895758] ------------[ cut here ]------------
[    8.895778] NETDEV WATCHDOG: eth0 (ucc_geth): transmit queue 0 timed out
[    8.895971] WARNING: CPU: 0 PID: 8 at net/sched/sch_generic.c:461 dev_wa=
tchdog+0x23c/0x244
[    8.895977] Modules linked in:
[    8.895998] CPU: 0 PID: 8 Comm: kworker/u2:1 Not tainted 4.19.18-00012-g=
d47efbb0119d #183
[    8.896017] Workqueue: events_unbound call_usermodehelper_exec_work
[    8.896030] NIP:  c037b18c LR: c037b18c CTR: 00000000
[    8.896042] REGS: cf853b00 TRAP: 0700   Not tainted  (4.19.18-00012-gd47=
efbb0119d)
[    8.896047] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 42022428  XER: 00000000
[    8.896080]
[    8.896080] GPR00: c037b18c cf853bb0 cf82e4c0 0000003c c05f7bc4 000000c4=
 0000004c 000038dc
[    8.896080] GPR08: 00000007 00000007 00000001 00000000 22022424 00000000=
 00000100 c05f3d78
[    8.896080] GPR16: c05f3d7c 00000001 00000004 cf852000 00000000 c05e0000=
 fffee3a9 c0496618
[    8.896080] GPR24: c05241c8 0000000a c05c0000 c05db0f4 cf82b800 c05e0000=
 00000000 cf82ba74
[    8.896229] NIP [c037b18c] dev_watchdog+0x23c/0x244
[    8.896240] LR [c037b18c] dev_watchdog+0x23c/0x244
[    8.896244] Call Trace:
[    8.896257] [cf853bb0] [c037b18c] dev_watchdog+0x23c/0x244 (unreliable)
[    8.896285] [cf853bd0] [c0054eb0] call_timer_fn+0x24/0x84
[    8.896304] [cf853bf0] [c0055228] expire_timers.isra.4+0x98/0xa8
[    8.896322] [cf853c10] [c00552cc] run_timer_softirq+0x94/0x190
[    8.896341] [cf853c60] [c0494738] __do_softirq+0xe0/0x258
[    8.896357] [cf853cc0] [c001db68] irq_exit+0xfc/0x100
[    8.896375] [cf853cd0] [c000a2e8] timer_interrupt+0xdc/0x1c0
[    8.896399] [cf853cf0] [c000f460] ret_from_except+0x0/0x14
[    8.896432] --- interrupt: 901 at copy_process.isra.8.part.9+0x60c/0x133=
4
[    8.896432]     LR =3D copy_process.isra.8.part.9+0x864/0x1334
[    8.896446] [cf853db0] [c0018fc8] copy_process.isra.8.part.9+0x7d0/0x133=
4 (unreliable)
[    8.896466] [cf853e40] [c0019fc0] _do_fork+0xa8/0x2ac
[    8.896486] [cf853e80] [c002b7e0] call_usermodehelper_exec_work+0x74/0xe=
c
[    8.896506] [cf853ea0] [c002e520] process_one_work+0x168/0x38c
[    8.896523] [cf853ec0] [c002e87c] worker_thread+0x138/0x488
[    8.896541] [cf853f10] [c0033824] kthread+0xe0/0x10c
[    8.896560] [cf853f40] [c000f1c4] ret_from_kernel_thread+0x14/0x1c
[    8.896568] Instruction dump:
[    8.896577] 811ffffc 4bffff70 39200001 7f83e378 9928af9f 4bfd82d5 7fc6f3=
78 7f84e378
[    8.896615] 7c651b78 3c60c056 3863be98 4bc9f681 <0fe00000> 4bffffb8 9421=
ffe0 7d800026
[    8.896655] ---[ end trace cfd3ddfe80d72be2 ]---

along with an endless sequence of

[  115.716012] ucc_geth e0102000.ethernet eth1: Link is Up - 100Mbps/Full -=
 flow control off
[  117.744010] ucc_geth e0103000.ethernet eth0: Link is Up - 100Mbps/Full -=
 flow control off
[  119.295955] ucc_geth e0102000.ethernet eth1: Link is Down
[  119.712177] ucc_geth e0102000.ethernet eth1: Link is Up - 100Mbps/Full -=
 flow control off
[  123.295801] ucc_geth e0102000.ethernet eth1: Link is Down
[  123.295843] ucc_geth e0103000.ethernet eth0: Link is Down
[  123.712022] ucc_geth e0102000.ethernet eth1: Link is Up - 100Mbps/Full -=
 flow control off
[  125.744167] ucc_geth e0103000.ethernet eth0: Link is Up - 100Mbps/Full -=
 flow control off

It would seem to make much more sense of the table of snums was either
decided based on some compatible string, or alternatively, if the
array of snums was simply a byte array read directly from DT.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/soc/fsl/qe/qe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 2ef6fc6487c1..185da4be3509 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -306,12 +306,21 @@ static void qe_snums_init(void)
 		0x28, 0x29, 0x38, 0x39, 0x48, 0x49, 0x58, 0x59,
 		0x68, 0x69, 0x78, 0x79, 0x80, 0x81,
 	};
+	static const u8 snum_init_28[] =3D {
+		0x88, 0x89, 0x98, 0x99, 0xa8, 0xa9, 0xb8, 0xb9,
+		0xc8, 0xc9, 0xd8, 0xd9, 0xe8, 0xe9,
+		0x08, 0x09, 0x18, 0x19, 0x28, 0x29, 0x38, 0x39,
+		0x48, 0x49, 0x58, 0x59, 0x68, 0x69,
+	};
+
 	static const u8 *snum_init;
=20
 	qe_num_of_snum =3D qe_get_num_of_snums();
=20
 	if (qe_num_of_snum =3D=3D 76)
 		snum_init =3D snum_init_76;
+	else if (qe_num_of_snum =3D=3D 28)
+		snum_init =3D snum_init_28;
 	else
 		snum_init =3D snum_init_46;
=20
--=20
2.20.1

