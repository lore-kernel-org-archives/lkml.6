Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA34C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA71120841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YERRbSTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA71120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeIBRUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:07 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:20160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728020AbeIBRUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xecxz8JL2Fo02/qDd8SBh/AXVKZ37+boFjbR/MCHzs=;
 b=YERRbSTrGGHwpQp8kvrLhiVS8xm8Z+dYNRR0JiHivMtns/TD5oiR0grAHBX1shp1TdLie0cPt7XTlKaEU4TD1TZ31/IspOql5m/Lrc1sLdKb73RR3smRECvguUi/z/X2F30DINUXdzky632yw+8aKa8ftTI519jt2MK/hQpuGBA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Zimmermann <tzimmermann@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 048/131] fbdev/core: Disable console-lock
 warnings when fb.lockless_register_fb is set
Thread-Topic: [PATCH AUTOSEL 4.18 048/131] fbdev/core: Disable console-lock
 warnings when fb.lockless_register_fb is set
Thread-Index: AQHUQr1rw+LzDBi1WU6/REZunTtCOg==
Date:   Sun, 2 Sep 2018 13:04:01 +0000
Message-ID: <20180902064601.183036-48-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:3BNJj9Wvu0FRdyeVT9MmAZ0KMs3ugu5mXITYX3UxvHLpa2oSGuVI2xiHRDg8qPABQlSkV+x0BhVpJfN4j6Wu9xTu0o7IY8z1uLMWZnEz1njnxEeytQnNgcOWrxtqFF8EA6pIfvCHQ4hnnB9SDhpI/R4cGEB1zLLVAB3eh+rZ/E627QNrDVBfDYD4NDLGD6Fy+3O9pchFIJUrPoZNvnOTFV6Idz4suYwBDdUiAK4B3NGMgdMrorjhigeiXesWgXdFB4S7vPIaN8/BZYzBBfxxuXn2tVZY40mwb/mPkwCgs18dai2WBp69eUeX5p62eQJCD8l8aJaCSmrHuoEvfnKkMLm+RRHBeX7oWIsOmY0a2PYre2OASiXoqSIzyCtTWjLZdIrmILkrP5AIuVZCQ89Cd7xN6Xo0hntCbfkeSDdSTpIUe3exoYdXOO2LUl9GaZD+e9KH26AUMeS96KxkCF/1Dw==;5:Aafl+lZoxZSmwbk/EQr6+7AiF5xMqCiTNw4c/CwgMKxpeIsYRywy9bUbOM3hP+bKsol82f2itp2Nbh4R8dCVy0SMQoyfeZ1n3OGbiymFAHydLpLbpLdYBpF2EBXlgFhbUHPM31eMNtLVD5mw1jaGu9URDfBGOZ75DtftCXhYzN0=;7:5hcx2737RCsI2uz4hWTamYjF9L2Sn/EZZxYYieZhViA5+7SXkQTkzzlombrrX3DBTtnzjlscgYD7ggIdOdgnrEYybrqF3jrJ0zypgwMZXithmBeZnKE7WzJ7d1rlsIcXDXDkbpNgcCSjm7P4bNhm/DYtcpJ4Py0FGSuzOQaOxkHg+Erue0O/ONkUBiFtVqkppP1kMRWSljTYs/Y+DMOc6B29WtE0NB+sJO71ynT0obtThv4BupCJxAyPK7DgkrDT
x-ms-office365-filtering-correlation-id: 7fe7db2e-9a61-4877-f43e-08d610d494e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01358ADDB9B435B6632EE2E0FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002)(6606295002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MXJfZVfB0FqKMVyNMB0hJLan0nIGEtIX3bvjxnUArjdMIYqjgUUknOdnHNWmN058iw7YqeZWRa+wm5ZS66NOIpb6ERAMK0i3D/wnDyH5FZuIt9JHssjwZfBAbjcpPiPo/6/806ykrmbxNdjhf+fK69o88QanfrwrrZECTRJIGRgdTmZVFuEufTy1vdkrdSDVelYldXh0UNQroScekk8OBghbauLApdeesLwpnyxKPqMV5YvTknHgwlklACkvF7GnFQRn55o2HaAS2phNuID+Ck/0Jhqt/b9MsfbJxB0qxLr3XYKAJyuKSMCsIsgyoiyahZLK0+OLZALGHW3F71O3JlxTnKzPI7ZPxjsiWCTdHi4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe7db2e-9a61-4877-f43e-08d610d494e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:01.6322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 3f2ce54284a60500eb6dca1dca6fd615df8f9aa3 ]

If the console is unlocked during registration, the console subsystem
generates significant amounts of warnings, which obfuscate actual
debugging messages. Setting ignore_console_lock_warning while debugging
console registration avoid the noise.

v3:
	- manipulate ignore_console_lock_warning with atomic_{inc,dec}
v2:
	- restore ignore_console_lock_warning if lock_fb_info() fails

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/core/fbmem.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fb=
mem.c
index 609438d2465b..0b6a2d1eb5bb 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1691,17 +1691,22 @@ static int do_register_framebuffer(struct fb_info *=
fb_info)
 	event.info =3D fb_info;
 	if (!lockless_register_fb)
 		console_lock();
+	else
+		atomic_inc(&ignore_console_lock_warning);
 	if (!lock_fb_info(fb_info)) {
-		if (!lockless_register_fb)
-			console_unlock();
-		return -ENODEV;
+		ret =3D -ENODEV;
+		goto unlock_console;
 	}
+	ret =3D 0;
=20
 	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
 	unlock_fb_info(fb_info);
+unlock_console:
 	if (!lockless_register_fb)
 		console_unlock();
-	return 0;
+	else
+		atomic_dec(&ignore_console_lock_warning);
+	return ret;
 }
=20
 static int do_unregister_framebuffer(struct fb_info *fb_info)
--=20
2.17.1
