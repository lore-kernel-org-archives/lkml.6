Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3CEC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDAC204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AhzG9fZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDAC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeIBRYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:47 -0400
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:32952
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729682AbeIBRYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBx1hdJXEybgf3fJE3dGtTlTsC2IGV3nPU6DVZqL0Y0=;
 b=AhzG9fZQWUr+6tvPphFkYb9o2Ms1SaduYPmm0Cmxe6Yt4qtw3SvoqjC+vjtNii2Y5rIDWSpGPAFJzCK8N6dlPzpuh9/jWdp6hCbPJxWEXb0986Dx5D5MUpRI6XyFihOrDx1w3asNIFMqvOyVJImGTdzGwaS+xdvJRQLbWd+57GM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 84/89] ALSA: au88x0: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.14 84/89] ALSA: au88x0: Fix sparse warning wrt
 PCM format type
Thread-Index: AQHUQr30nNvYehUjb0Wg0ZUbAiKr2w==
Date:   Sun, 2 Sep 2018 13:07:51 +0000
Message-ID: <20180902064918.183387-84-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:goaDV7opxpGaBaujzXR624StdRXzXdNuAou4mS9Gg5Fy58XTBmsLGH6BPrlarnBD0vzIV/ZfokSkL8whpc5mW/W3GtWpH78rTRsIl6Iuwv8LX+OIcOatkeA+RP6YUeJ3FBtRzhKupE5qVF4a+YEqGuOOmV0zYOQi8CRcMOSGDfkG8lAVEnUKNdUKoSFpMoPuW3A3Y74QE0qP4Qlfd6XKKXV37cOKcSNnNbHkTqdb6CpclGI/igurl3OdYdkAD0MGjn7qA+xLMjflPxIM9NAdgHz/A1APDCj9+4pKLQ0/bg6K433jvQ79jzK2FTM+iXBO/fC9WyI0UWC1Si/E6KSRHycyAqJIK3hWNYpo68ASERiPpmYopOUY3Hdlh4iZOiUnZJffEYOGPVZw3apU2mLSASj1cDOSLmnqmndKn2qtwkPN9MjEt+XqPbw0saUs4ZNo5jX9yq1JJJrMu/5FfNQZbw==;5:tJaUepTPwe6oCvVFxGV+sLgqkt9DizN4fV+q+4LxY/7rrNebX+fgpPpliu2xeXXZfmt+oWmG+SraHdl6g6ZfLpWjD+mYF0wGnvwz0ow7gSlirxCAPEjfHP9yqxj42nvvrZqK4s8Dy4c261YVvotyMkmIe/7HvLX48v7ZO7Y8T9E=;7:tQLwaa0ZMAGHeBM8D++tWxMgHEDsMdXbDW1yxiZfxJcDcOfR6hb94TK2z+hwUV91K+d/ZmDACYykVbw4c8q761Pb7tFQozsPcQdovRIaIe1WOii5cLZRZxsz8311LwnpLLfSk+yH9HFUUhG4z4bfFROlmknOXhiGKhGOXbxTNioGshtRHLgB0A4omeykQKZdhJTFXixv+/W6clobdJiuE6j/Dt7Nr64LmqrvPNa4xQwBBKk09tiirydjwP+ovPJr
x-ms-office365-filtering-correlation-id: c8cd7200-24b9-4ea8-eaf5-08d610d53a2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04699BD5928A6084FF2D8B51FB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xhIl0Aw0+ffcM38Jmjhnf8e5LjO1L/9XLdn4Pv1wWgpL/xq2UBNCC/wd8Os8K+0tEJbGWlF3hUnID0EjFJcpCuRPHYZV6pNLfXwP64/gC5y2YAiiX4avAkjVtzeOXgnVKv6u5wnC9oodlAqNgNKwGsXb8KJZNSgK6eXHto/c2a0kI8FaYyn9fAQ5kKVeLR3YIG9vvuadS8k9lSQ6x3qloZ0RroqvXk1IQtK3CmTxEc1IieK++gHvXzSfXfVaZxPjKwRBrZMJd141kbyEkmJwkxa3HNW5IUdlucaehvFBy1D9viRqOJIQV7JH1vgDYJUPI3S5hbqcuChiEXvs5OfgDUY+56tXryq7nIgZo/Scyng=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cd7200-24b9-4ea8-eaf5-08d610d53a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:51.5619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 10d3d91e3bc4e152a580bf523e4fd6bf279ae532 ]

The PCM format type is with __bitwise, and it can't be converted from
integer implicitly.  Instead of an ugly cast, declare the function
argument of vortex_alsafmt_aspfmt() with the proper snd_pcm_format_t
type.

This fixes the sparse warning like:
  sound/pci/au88x0/au88x0_core.c:2778:14: warning: restricted snd_pcm_forma=
t_t degrades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/pci/au88x0/au88x0.h      | 2 +-
 sound/pci/au88x0/au88x0_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/au88x0/au88x0.h b/sound/pci/au88x0/au88x0.h
index bcc648bf6478..e3e31f07d766 100644
--- a/sound/pci/au88x0/au88x0.h
+++ b/sound/pci/au88x0/au88x0.h
@@ -241,7 +241,7 @@ static int vortex_core_init(vortex_t * card);
 static int vortex_core_shutdown(vortex_t * card);
 static void vortex_enable_int(vortex_t * card);
 static irqreturn_t vortex_interrupt(int irq, void *dev_id);
-static int vortex_alsafmt_aspfmt(int alsafmt, vortex_t *v);
+static int vortex_alsafmt_aspfmt(snd_pcm_format_t alsafmt, vortex_t *v);
=20
 /* Connection  stuff. */
 static void vortex_connect_default(vortex_t * vortex, int en);
diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.=
c
index c308a4f70550..d3dabbd9b1f4 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -2770,7 +2770,7 @@ static int vortex_core_shutdown(vortex_t * vortex)
=20
 /* Alsa support. */
=20
-static int vortex_alsafmt_aspfmt(int alsafmt, vortex_t *v)
+static int vortex_alsafmt_aspfmt(snd_pcm_format_t alsafmt, vortex_t *v)
 {
 	int fmt;
=20
--=20
2.17.1
