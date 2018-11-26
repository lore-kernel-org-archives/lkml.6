Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD21C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC8B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="W+kLTkCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC8B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeK0IxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:53:19 -0500
Received: from mail-eopbgr20135.outbound.protection.outlook.com ([40.107.2.135]:43568
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727238AbeK0IxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6Hpmk4LRAYzUo5Np3ya94OUU74tZJ4IWLmmaSNhy9U=;
 b=W+kLTkCJ7TMjYUrMmzJYrJZ1UuNLD6q13GAvgsxS077SUIXiX7Jjcq4dFXQoLJh6heh2h+Munm9hQZHcNkIye0v7xapj1OJ7wzDqard7gvyU5a0ap15c7KCgl7+2IJKgjWwaYlHxe58fVb0FtaljvkJ9q3aLGD1DAKcxg3pO5pM=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2414.eurprd02.prod.outlook.com (10.168.64.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Mon, 26 Nov 2018 21:57:39 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::8de8:73c4:92c8:6c22]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::8de8:73c4:92c8:6c22%8]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 21:57:39 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Subject: [PATCH 1/2] fbdev: fbmem: make fb_show_logo_line return the end
 instead of the height
Thread-Topic: [PATCH 1/2] fbdev: fbmem: make fb_show_logo_line return the end
 instead of the height
Thread-Index: AQHUhdMM+TVHeC1vN0aLroJG64FWzg==
Date:   Mon, 26 Nov 2018 21:57:39 +0000
Message-ID: <20181126215725.2548-2-peda@axentia.se>
References: <20181126215725.2548-1-peda@axentia.se>
In-Reply-To: <20181126215725.2548-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0275.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::27) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2414;6:RnHi2mdLpVvltwVbZ94TK6Y21eGK8A9coNRkhTAf11GcCC42QTj67zWYPJAGkbkX6XgA3ObfFS20YwiaIvutZ6f5NiBJyCKX+cIq0GBLVRAFZqsAI35EVpbE8Jqoelbdl8ngXw3xwCKRGY1Qkmuie6L9gcdrFg39ZD2XH6ZnFkPPNC0JWoeTNqSAi7yDcvNtuAZKRy1Xgl0k54ZHsazDigM5kA4xrZBpLhvYxbdVwfUSrAWpRLTMErkHdUbVDRq0uQN6lqiUhVt/ABT/o436wh0K2vgU6ziwF6eAwA6llBY6Tpz11GKnQr9UImNRIAR1iRYi76TbXUC35Fi6LL2cljsokDExxkHFKBMh9gvzobvDKgyylzQFF8LP/rhytnXLgZEd8BxflcPwi7AA9bU5fAANjQVl9gGFpGjnSdDeaS4zHrDWMtC5HEzZaQU7sqrf5xUiAW2MGuQnvJrFHzaopg==;5:1etE7M3WsqKDHhHbkDXOpzStubrc9BWK3tmhyUjA9GwpeVdJNjykDtEaL7e1K7i6tme5tihPJGqcXNodMxL4fmg+7XGUdq8SeJNwRHlsoW6nELt3Pm7nYYqNJd1o5dNUtEkxIdzXeTkRwhyckhuOwN8MbiU6qTqYtG93wyjfuqI=;7:AR+JGZFYwWxHA8tcLoYLhxquLwNuBmg/ZsasnoRUYRmB8MfIFhdhwKKNzf22sutYdgUIG3t/pAoZhFfx9v6GseZ18Z33Pq/LP3THmudoMG3qPwOqqPC8XcyeVHVmjz7hGeAOmp9lK9dI+GNRKAQ5Ew==
x-ms-office365-filtering-correlation-id: c1dae98c-03cf-4f2d-d1d7-08d653ea2eaf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2414;
x-ms-traffictypediagnostic: VI1PR0201MB2414:
x-microsoft-antispam-prvs: <VI1PR0201MB24143DC616C4AD6236E0B7D5BCD70@VI1PR0201MB2414.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231443)(944501410)(52105112)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0201MB2414;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2414;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(396003)(346002)(136003)(366004)(199004)(189003)(6506007)(386003)(7736002)(68736007)(99286004)(305945005)(102836004)(5660300001)(3846002)(6116002)(71190400001)(71200400001)(76176011)(86362001)(36756003)(476003)(66066001)(2501003)(52116002)(1076002)(2906002)(74482002)(2351001)(316002)(6916009)(6436002)(14454004)(54906003)(4326008)(6486002)(6512007)(256004)(5640700003)(508600001)(53936002)(446003)(11346002)(2616005)(8936002)(97736004)(8676002)(486006)(186003)(25786009)(106356001)(26005)(105586002)(81156014)(81166006)(50226002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2414;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l8lEiyATCZS3theZuqiz5qH/0oSsouPcYoKYuGx78N57IDpINe1OoU4c7CMru4S8k9jsFxDAlSQTOUM19aXZ1r+jPSb4fsxxM0KYrDK14GCuiVym4jbzqLFYNfCwsMD/U3XM4LmJMkhoxIZe15+gEFZI/VopFEj5J71sX6qwiMfhrBnD/FUomQM5wKbbhfIwvAtC+9u7bbDLhj5Mn9QiJ2xwGceGHe9UAy9q4vof4luD/ziubBztfjcy+DFWR5w2O+QR4Z11ulEtmpQhfJrH97Qik/zecZzE/JjmGAy3h5AKYPbrmfDkJCxTZj2KwJeO7qQEMrZOrINWHbBGakv4TJFKCFQnPdqmARg6R9vckOU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dae98c-03cf-4f2d-d1d7-08d653ea2eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 21:57:39.4114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing centering of the bootup logo, make
fb_show_logo_line return where the next free framebuffer line is,
instead of returning the height of the shown logo.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/video/fbdev/core/fbmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fb=
mem.c
index 861bf8081619..43d4047f472a 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -521,7 +521,7 @@ static int fb_show_logo_line(struct fb_info *info, int =
rotate,
 		info->pseudo_palette =3D saved_pseudo_palette;
 	kfree(logo_new);
 	kfree(logo_rotate);
-	return logo->height;
+	return image.dy + logo->height;
 }
=20
=20
@@ -573,8 +573,8 @@ static int fb_show_extra_logos(struct fb_info *info, in=
t y, int rotate)
 	unsigned int i;
=20
 	for (i =3D 0; i < fb_logo_ex_num; i++)
-		y +=3D fb_show_logo_line(info, rotate,
-				       fb_logo_ex[i].logo, y, fb_logo_ex[i].n);
+		y =3D fb_show_logo_line(info, rotate,
+				      fb_logo_ex[i].logo, y, fb_logo_ex[i].n);
=20
 	return y;
 }
--=20
2.11.0

