Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68510C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1693F20652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="C/3NMNi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1693F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbeIBRcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:02 -0400
Received: from mail-cys01nam02on0108.outbound.protection.outlook.com ([104.47.37.108]:46240
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729171AbeIBRcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+EzuxZ8UZjGLNoDgUVfhfOKZjnD40KzYnTYtFulDLU=;
 b=C/3NMNi7VJ20/plP4dSa0Z0O5VqHlr7wEaCb3zpxwkolUubaQSzhUDu8hFRDdLonXuxLiQxmyEPxxtZVLNkobHbgOxKVig90zMDjlTj5osXLsrEpbv/d2SP2SsnMLOdrInHW7HYhT0w3zda9DKGhQOfMUrI8hiRnyeL1O3eKat0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 52/62] ALSA: wss: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.9 52/62] ALSA: wss: Fix sparse warning wrt PCM
 format type
Thread-Index: AQHUQr74f3bAXaRD+0y2UbQFJLJN2Q==
Date:   Sun, 2 Sep 2018 13:15:07 +0000
Message-ID: <20180902131411.183978-42-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:ZcSguQGWsFHJNeIi9XfK7/bwL7mox/1PWMOU/Pnzv/Q4SN6+r4pkNze3dbOpOX2UWel8gKHeYtp1sOXLtedjPYndUQ2Gj0n9SKuMEYbrELL40Vzvz77G4muimmvlcmC0kGz6MykSrFxkuHSPEn9G6GGtG6nuIyWFhqvudDUSwKGSHDE9TQabKj4cLzyn8e5+eximE3P//BPfLixgxOs4F3GTNWc2un6Y4XnoHpQ4u2cDoRWGqie85fBPv9jN/yf6sepwGmcmoR0oByy1u0KHKawL6T1SlIsJFTP7Ilkc/B1a3XkHbStmwCTapqr79TIrxsZmIX4BHQ0vwYJIgiINRbV0C/qq9+WZqKqPKwmHMB04nbv+HXGSSL4Cy6Q7JZ9CIy3BQMDRm0EpaOYIYe+3mQaQ+pCs0+kQqtlD3Tx8+4y+MuDpOUMXqeIJwKZcFVVJ1ckE/Et5gp31nCUzV/+O0w==;5:iozKHc/qxJdMRs8nMpdkN4UHNt9eyrbKhCu9byinmzIQRbMS0tkNdGDWhK9DCJ7DAi5CPVgKxn2OyQh1XD2AVAE1z/imDo/pfjfqaAjWIX/M3qjQc01t1HbjJiexsXNCkkCLWB+7f76GpdaoAUBzefzrNy0a3nw7HlN3r95VERc=;7:BrvTpdzLDjtMYWjkPkOu6cq3GASHgBSBa/uukN0BMBIAQIX+zoNQu+r/x/2wNFvk7VpDjXyZp7iWBIklA3m9l5Qt2j/5YlX/t2pA6WL48pK/v6BOHRQVTEBnH2iUAl+mMdwUjjih+4AY6tn/cfmeMi3PM01CqXhSsxOOzSe65aMWThMrunPmILjhUacdFrFneNcdODLg0p3P1+b663Vdeg52vxswtOPg2UtKfRUyDugkzV93UUlXLcgDtO5jOPes
x-ms-office365-filtering-correlation-id: 35206820-0dbc-4bb4-8bab-08d610d628df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01845DE0D84B2216DBFB7F40FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(575784001)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(6666003)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pXxYddHnp4fmE+IeC96f8itHydD3mD7RSQA3+efA4ivTVhMd1qxSTO8fvU+Vt73ei+/jX18uJrwxWVMbPcFVjyLHmF6vumRD7zauJDB1/I4Q/PvH8mirBq4UoBRH/fGXVls3q67A7LvOabNFyXmYM/m9gTpXDsDrCI61Nu44k09FVazlmJSlDZNSXT3PVe8aeroJGUyrU6fjMhdksYbQSnGCupXNBFH7G1KT1+XcSG3xIeS0lJR0qIwFqyyMOUltKR2iIFOR6HhHJTtYfwaAVHaLCqhm6jDOpilq3FxoLuWa8pthLja6C89DSaZI7Qaofby+60kX2Pm7tJtpVKKf11vwnZrjhxXhiy+3zARsbY8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35206820-0dbc-4bb4-8bab-08d610d628df
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:07.6362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 6be9a60efb401487a4d658ef23d652a9e6860b34 ]

The PCM format type is with __bitwise, and it can't be converted from
integer implicitly.  Instead of an ugly cast, declare the function
argument of snd_wss_get_format() with the proper snd_pcm_format_t
type.

This fixes the sparse warnings like:
  sound/isa/wss/wss_lib.c:551:14: warning: restricted snd_pcm_format_t degr=
ades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/isa/wss/wss_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 913b731d2236..72b2cacc9e0e 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -541,7 +541,7 @@ static unsigned char snd_wss_get_rate(unsigned int rate=
)
 }
=20
 static unsigned char snd_wss_get_format(struct snd_wss *chip,
-					int format,
+					snd_pcm_format_t format,
 					int channels)
 {
 	unsigned char rformat;
--=20
2.17.1
