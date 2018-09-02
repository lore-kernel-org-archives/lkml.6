Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF8AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7597E205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="m7+izb/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7597E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbeIBRb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:28 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729302AbeIBRb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEoAPmUsNs9NDO1LUuyJZiiVFh45Y3LdNbuLFoWWZwk=;
 b=m7+izb/KQUj5eAgoLEMDxI0ik8V3HB6NlwaR4Ex+euGJtaC5XbkEWNBif03d0CvhqbFUJlRCn2vp+hUmZlto0DRKZ3DDhC8nx1DqD7feqVS3dXLtG3buBGkXCjv/PmyoxjLOHcHa/tirVd9cbZr9A+htOzm0r9rEhe8dk1r6Kd4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 55/62] ALSA: ad1816a: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.9 55/62] ALSA: ad1816a: Fix sparse warning wrt
 PCM format type
Thread-Index: AQHUQr75gdqqIV0r/Ua7TVbenD8FAA==
Date:   Sun, 2 Sep 2018 13:15:10 +0000
Message-ID: <20180902131411.183978-45-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:LjsB4bluTuWAltB3gPMwTX5NQZcrAYfdH0kKgo2uhFxgOAasG04XSNlHmNEz6RXG5yDpwNXHHr2HuK6uT5yJKTl3BO81Akijukg9dKWWx9VIIX1ikhwWbPCrpeDLf2zqAvtGHsqTiKeKwe427q1MpOJYP1lFYjNjYVwgw6f03WaL46rdzpbOoFmfJEiUEObmVnWoz/Zq764HohxVUNfRetP7KgRKgZvD2jw9CKKImM8ehlR7HdOxZcxo249VZRvkVjLvXgyOFYM0pSY7RChTvUQ0h6zjybmqXBufe8UUIxby2zC6uEMx92QWYHWQOhRfdVi7pvTaVM7UD+7AJcIDXsFfOfkVyJ0K2Za4SEeYMWXMHhdX6JKdBAb571IIFCiIZRcFiamTbhobBoLAsrIPSmWQFMJDR+cfDhcimi8v5R7iRoP+uoN+MBDiOp787NIVIc+ovRVaXex4ESZbKYvvgA==;5:/Run6gB3fPDaeMuXHAWUZhQcA98FLfrB2MyUtuRxR8xkDF6yO+D1ShpEwJUJQE7MnqxPWt2SW0TKV/o3fJaITFtEXV84ONvmfWJMo0Mh0y+i7rIm7BqdZsFRLw6nzaGduHj7jVGBmQ+31zUIxKapTNJn++6hhcEwWKTixzjpFiM=;7:IgExRL9ZrVON/V1ujJxznI0H7nZC/CQRyc8AlKAXNop0fixH0T9t8AxXcTC/FBIecdMoH8pVAl3bSr2w/tO8g2+k4ePDiTFk/ZP4Mtu03P77Ao6/mcvhO6y65BoWO0osEkjShlWGh8TRtAQACwdCxONIzTu+wSvS2eOPvx6EnoHPtUu/3QVRmP6IDs0REXHRruSTrqevIbHTPNgZ4d+DLiM/Ux1VX74EmFiCJ/+q4AkGcpBFBzPMXuHdTnzVAD5v
x-ms-office365-filtering-correlation-id: 0b20ad33-7d19-4c94-2d26-08d610d62998
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018460BC843B2193631091ADFB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(6666003)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l5mCf/YFXgzyrvTg4X0wxO4uHsHFzos0GlkS9bUAYFB2Eeun5NWJyegLU99ujR6xyOgw6F95HBcDANs2drW+aamL48UWqxiz52w8zNxJ98WOKvpZZ27N+IIUxfm5kZOyj0HcT/9cJXWEFGUDmcT1MuaWd8/yRNxHQL5SkRcxnddnfmaZsMimJVg5xHA/a+eMEPa+1WQOievnh9vUaPY/O6eBFvAyTmHozy/G6+wOPzAjjURVS2D8/XRe+j+4NtHQPjax3n0bjO8rgMv4i9SGXIMz7kh6cWr1D8yjWMsX5nHcZRsD1tNE4UqtX+C+iKdshaJuTAieUOt5fHD3XRzGqkk06EJTUb40GkcP+u2uWWY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b20ad33-7d19-4c94-2d26-08d610d62998
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:10.5406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit d63f33d3f083bdb3a7c2dfd623f4d811b2a8d772 ]

The PCM format type is with __bitwise, and it can't be converted from
integer implicitly.  Instead of an ugly cast, declare the function
argument of snd_ad1816a_get_format() with the proper snd_pcm_format_t
type.

This fixes the sparse warning like:
  sound/isa/ad1816a/ad1816a_lib.c:93:14: warning: restricted snd_pcm_format=
_t degrades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/isa/ad1816a/ad1816a_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_li=
b.c
index 5c815f5fb044..099480afa6b9 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -85,7 +85,8 @@ static void snd_ad1816a_write_mask(struct snd_ad1816a *ch=
ip, unsigned char reg,
=20
=20
 static unsigned char snd_ad1816a_get_format(struct snd_ad1816a *chip,
-					    unsigned int format, int channels)
+					    snd_pcm_format_t format,
+					    int channels)
 {
 	unsigned char retval =3D AD1816A_FMT_LINEAR_8;
=20
--=20
2.17.1
