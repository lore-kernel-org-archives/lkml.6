Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220ACC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2EE204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="U30ocK7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2EE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbeIBRYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:11 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:20016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727480AbeIBRYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7jhNNcsZUDTaRkzDe/FaCeEVQiPsOc3B4lUU1h+Xa4=;
 b=U30ocK7xgnA0/OkpV0Tfd0b5wVKQGefLZdISKcT8XkTSEQZvVatNFXlQtXKI4ufKOaJrmZZyx+A9jR3o4IRMmnUzx4syRqS7Wyy6a6gXN/jyqV1vq13VvGAsgIwU2CtB2gZiaeH9RtfM8WvYqrvofSgaeQk8gDsmB4LGN+lAwaY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 78/89] ALSA: pcm: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.14 78/89] ALSA: pcm: Fix sparse warning wrt PCM
 format type
Thread-Index: AQHUQr3woRdepXryTESBm3dY2JnvRQ==
Date:   Sun, 2 Sep 2018 13:07:45 +0000
Message-ID: <20180902064918.183387-78-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:U2MLvjZuNJQEolQrlwBcY8Qgdvx8qYxKxOvgy9LK6PnecjyZGpdm49BF71XHTkz5vZRsMoxQN6LXjVvliP5KVhc0YPtr6dLIQs755XBzqntAUaB2lBIpT09fuNyeamRRy96/tSk3czLhRrii9PYTkaH65ZjCmxPJ/gQTQFoYKZfOwNNeVyuHxOeQZ0yBwYMr7Cd6HEYeSv5W8AHfLIuU/m/oVkEfIoOmmMaIZ9gu4fRpFyJaoshOP0IAw+DRMx1/dlJ17bOeeFBOgcCYva+61n8LtYk20ifQsCRPD+0msVaV4y4THmGngkTuxX1muBGqJNsexHuPQu6gmNRBtwyMOMau0ZvpxDG1VXSktpljXxyroxokw0suH8yvCilwZn80BgzrjRqtXIU1vT17lS2iU47eXvn55CRwPIiQXWSbavZ399DAdFQ8hE1il9bE+EpjpAGbEfB9UMnY6nEVVgbkhA==;5:uI8xdMzcgALz4gvlVkWr458Lg7DnxiIVBGXH/gRPnMCMOq+Qe5vejTk8MkngWM8GvqtfxM6PQEWcP3iXl2wbuOwN1mwXds+U1i3ncDVNs/wq1uLe730HB1VHlxEnow9XPBD4TNwsOYvSnOt0xTT9j47rlqrKTvGXE483QUg0Q3A=;7:k4Ca4CyXIDb5/IbAyC3UsEMOqwuyBU8nq4faEW9c3bVaIxveg7AlT/mRDvw6KquZTvQXU0GxTre1bk9wPel1t/V/K6ysexRvmRYyvwmTdBbzABY+6Yfo1xi/OG1wG+tXWhe6e+fl3AltGYFw3yK5bH+0NajhgE8JExBJxszx0zfI2LePhsjVwP3M98ZquCghY3zZ+hgpEf8UzHJ5OmloP7AVBpv10hbYeW5D1LY487jnlWgkx+5TIqzZhR6MCpqt
x-ms-office365-filtering-correlation-id: 7ebd5f90-8370-4a20-c6ac-08d610d523af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0149552F2B73C68132303074FB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(14444005)(217873002)(36756003)(575784001)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H9ZL1h1flQ5ckNBX364B5iLo8WqGDjUhDtHjcIYlptj9LrFlXM/Yys2VKWz6EFjmL+UjAYwlKxKE/ekL/1Uq5le0GqTWeDDgYSOjaMQaDLyWL7WCoXPftZ1uSWLYpF67qWSuFi/ZuVu51tjicU9LQjtTjb3XwwS2bXWv3da7cuB6T+cDZyRTMB/OuPUKUBbzpyKw8zdmtM4gs8Qrx7pmq5CmPscZXdV0Nc9VrsjI2St44vsafnY9KUWk7iGSxwDzYjY9mswbbt2YTihQcpJ/dK8hPUa2GiPO/EhwSWK7xGDLPWCcN+uAwsuzI27CSF1+ysuejdU6F1mkCZX1aKtgz/wJ50p5rsg3rnYEcVBZh3k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebd5f90-8370-4a20-c6ac-08d610d523af
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:45.3318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit f8b6c0cfbdd7359db9bb4da38dd54217296f9264 ]

The PCM format type is with __bitwise, hence it needs the explicit
cast with __force.  It's ugly, but there is a reason for that cost...

This fixes the sparse warning:
  sound/core/oss/pcm_oss.c:1854:55: warning: incorrect type in argument 1 (=
different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/core/oss/pcm_oss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index b4f954e6d2db..0d56ab55c731 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1851,7 +1851,7 @@ static int snd_pcm_oss_get_formats(struct snd_pcm_oss=
_file *pcm_oss_file)
 	format_mask =3D hw_param_mask_c(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	for (fmt =3D 0; fmt < 32; ++fmt) {
 		if (snd_mask_test(format_mask, fmt)) {
-			int f =3D snd_pcm_oss_format_to(fmt);
+			int f =3D snd_pcm_oss_format_to((__force snd_pcm_format_t)fmt);
 			if (f >=3D 0)
 				formats |=3D f;
 		}
--=20
2.17.1
