Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41216C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA5F2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BhfrFS4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA5F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbeIGFTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:37 -0400
Received: from mail-cys01nam02on0119.outbound.protection.outlook.com ([104.47.37.119]:49833
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730939AbeIGFTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6A5mE1qeiSKUHgv4ox9tjNzwLAs+0hUfzO8DhZ2GhY=;
 b=BhfrFS4DM5pbGqwvUCZyS9IDoHNvWcLxMAowdgXo5m4Qw/9QLJyjxNH8GNUtnbZG5mCr5ryqJKmGMw5Y3gekfOj/Um1TjYWTRrsWnPTvAyCYJCP4023bUFSpBNW13KO0QRcVi4JRkJNJ26UGgbDJo/89p3selsZp1Auck6FG2EI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0853.namprd21.prod.outlook.com (10.173.192.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 03/30] ALSA: msnd: Fix the default sample sizes
Thread-Topic: [PATCH AUTOSEL 4.4 03/30] ALSA: msnd: Fix the default sample
 sizes
Thread-Index: AQHURkMqtu6P7PG2VkqAT6vbmWwenA==
Date:   Fri, 7 Sep 2018 00:38:58 +0000
Message-ID: <20180907003853.57942-3-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0853;6:dpnBEstSDvGo5WzILm95vxVdhyqCo54OrzG3S8R08+MSxQQ/pS/dmWaJEfU6Qts6d1rWYZyx6aQVei6L6HuKCmfr0bIbc6gWuDmL8r03fGx5YHsq1srei8PCMWDtJg81XYgrnFOLqg+os3oY6AObhayRnTseoFnB17IX4uqFogcCM2TXyVdiekSJWZ4KTb2QTGZy7GiE9/YfaUhsyRnY0sBbDbpxcbQEZy0Ol+eFnHMfQyhxpw41PQ61zOiK8LW1uAsc9HsicMmQl98CZfUkEODVpxpEvxMM8cgtUJOSusFxfx0B186V4TJo56ogYN9l2wBmX4q7JhyZSwSI7mDwMj+bm538AW/QAiVgCb0MjK+/HgAtGChZU7QYNT3RxKysPfDKvCG+JT7Vn5k3H9loMfMkQ+zk8z8IJMW9ITHAFf24zVGtMNPzrqoDAkcfok5IGtxnG7nbmdpt+QFVghn6ug==;5:wWg9u1WiVZccRvS8pGjxn176PLdtu/g3HCrd8DWuzWyyDOJghb4Gb/hZHr2NlJP5sotfspDZelg2Rbtodju1hE2+fLCGR1+eo9xPVbjM2L3v9A7ZVDiuD1ZFiF6gUBlf3Bdi11zG7/HAnW5Jj60O1ljn8GiFJ6oXLOhjngaNsi0=;7:xMpEVARwraJzE3K7jq6VBIopSX32HMdlM/PgFhj1cqXtnH2Nc6n4UiCd06kfbHabb8ZrMjeMJ7frEMP49gT4wLug98NiLo5iG8SE0HscV/9Iop8cjx3bEOLpfwewBtX9RCAAC9bSSedm2N4gILbP5vLoySVajaSIKPrChIXf94KHIoO+38+Wo3D9MKR2xaQ58LSz3F9v8OrKIskGC2zR5+EvMrcOFRJdIySGbMLZzpwVkbDp21qh+IqioyoJGIus
x-ms-office365-filtering-correlation-id: 7f502763-2c41-40fc-c494-08d6145aa49e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0853;
x-ms-traffictypediagnostic: CY4PR21MB0853:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB085394B5655D6AAE4608674FFB000@CY4PR21MB0853.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0853;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0853;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(217873002)(105586002)(106356001)(256004)(1076002)(66066001)(3846002)(6116002)(4326008)(25786009)(107886003)(486006)(6436002)(6512007)(6666003)(53936002)(5660300001)(68736007)(102836004)(10290500003)(186003)(2906002)(2616005)(11346002)(476003)(2501003)(5250100002)(6506007)(446003)(110136005)(8936002)(36756003)(54906003)(76176011)(99286004)(26005)(2900100001)(81166006)(7736002)(81156014)(8676002)(14454004)(305945005)(6486002)(97736004)(72206003)(478600001)(86362001)(10090500001)(316002)(22452003)(575784001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0853;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X7/yTbtUt9DVwMsbmt2viiCazuSRPkRELrTCvhAyxp9MNzfY8tvoFQNJNq4pWSrGq2WpF0z8mEFMZUqLykE9v7RtLcLzx1AZ9cKEhxYNKKs0Y9qa9zeHmpjs5XEEiOg1jXpLPCm1jaPbm0Vx3tY0qUXq15R9U52MBotKfzLmU89M5QVAtO+0h/yPp5smHrcY6rmKCHzoCVrIlcwDXjKdX6gu3BkqqMk+XY/yiWFGd/8yjQ4yetvl9gRuqGixsf8yDfqccd03GNQXbU6Fl0Wko+iMzB7I6jrdr/aUL7M7/jV+1ZySv84r8h7oT3bBSRtaTpho5Na1UGLi70WtteL2+FC29Z8zUdFl7fSX8F38n6s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f502763-2c41-40fc-c494-08d6145aa49e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:58.2815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7c500f9ea139d0c9b80fdea5a9c911db3166ea54 ]

The default sample sizes set by msnd driver are bogus; it sets ALSA
PCM format, not the actual bit width.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/isa/msnd/msnd_pinnacle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.=
c
index a31ea6c22d19..2d7379dec1f0 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -82,10 +82,10 @@
=20
 static void set_default_audio_parameters(struct snd_msnd *chip)
 {
-	chip->play_sample_size =3D DEFSAMPLESIZE;
+	chip->play_sample_size =3D snd_pcm_format_width(DEFSAMPLESIZE);
 	chip->play_sample_rate =3D DEFSAMPLERATE;
 	chip->play_channels =3D DEFCHANNELS;
-	chip->capture_sample_size =3D DEFSAMPLESIZE;
+	chip->capture_sample_size =3D snd_pcm_format_width(DEFSAMPLESIZE);
 	chip->capture_sample_rate =3D DEFSAMPLERATE;
 	chip->capture_channels =3D DEFCHANNELS;
 }
--=20
2.17.1
