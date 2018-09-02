Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE0C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D6F204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="S8q/NkSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D6F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeIBRYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:23 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:1728
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727729AbeIBRYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFnFLdPzqn9OY5R68mNLUS+UwLkpvHprAoEiAREG5qc=;
 b=S8q/NkSG/rW79AmnW3smipIVqTcVJmyKTnQnokoZ3oCNjH+nWo/ReIZz/S2spA+zlbG7xwKYpNiD+JV+iwgGH2cvc/1EYN9c3CyuoKPFiXiFRRflfgPPbCSoOGKi/LXslH6ApVrU5Tcg8U+6Ph99K1KCGAJrf2ty7MhmjOMR45Y=
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
Subject: [PATCH AUTOSEL 4.14 79/89] ALSA: wss: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.14 79/89] ALSA: wss: Fix sparse warning wrt PCM
 format type
Thread-Index: AQHUQr3xrArO54zKYkKGndZRUruozw==
Date:   Sun, 2 Sep 2018 13:07:46 +0000
Message-ID: <20180902064918.183387-79-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:9M5DAzO9odo9JXJ4jMh00TQSIYWSyt2UUPpOccFDuEynHbOR2FRGRSgn0xUa1GRGIufCfwrviy5lWdcz+uAGd0SSRqCZXAx6+TEUeitXSeN+8zHJoZane9/yEO1wfgNCGyxmhzsKcKYvJCbTY5R3zHOYZvhGhbHnLPfH+9wDi/7IvumUxNYe2wuumLu+kxy9TSIvVdC8qrJShPQ8RNYzO15942ospydHpruIPvYODhz05kUMYwVUvf1STDzfSUM8KSW2F1FsVKaNGyJV3VAsCpJ8iKlYYDWBNnjqlIcZUlNxZ9ZwEn7Bk0mfrMY3mT6NNunaAXkgMbam2GdGSDglaIQa36/bcKndRdZwFfM2IQzvfn/3ic8XG4YVvKYbPprGxGEVOmbw/8+vu0VsIrqIDWEQS4TZlhrFlICKxY/yOHw+8jE1mDZMT0FIW+gDyv79l2wADeV4HLz0EcD2iI2j2A==;5:3p9DQFWqlTplTNxJCfQAw9whFoPNFHMxGyaahy2KWxzaDEHunfinWY9BeOlBEFUdGj5OK7qnDtkUYEccuICKz+pmGvrn0tKX0uDTIu0XRTx30dF7AZD1pxN/1rWvOMe0lRBCpmVqezPgYCV+ergxAgS9sgskpMu/Dx4NUZT/fyQ=;7:9x/tTh/2OLbe201ZiMjQqfJtUe6QjeSu97WTAvyL5XnrtO1qOzw0AMBJiJtj5hwibOpYEG5ytOIgGZclcXgx2kEE6skHuaNkLb/0dJyZKBvx5vregpih3BPvGn79cjfWYiWEZyxZZhllZr/T/r8lppQ00seT7bXdlPOL6U8uoLEym9p0FJ25zTYwDeP400RxzWySnGwa8mKr2xmjkkJj3v9ZPn6Myr93V1zwThpF1dFMQHG3ZVWHwi7F+NYQEHef
x-ms-office365-filtering-correlation-id: 68e8c329-a400-45d9-e1ab-08d610d523df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0149DAFE13733D55553E662BFB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(14444005)(217873002)(36756003)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VO+61wvdGanELWCJM5C89r61WQUYLWu+Qdk0wkSxmyiReNAjEvnqI90UUx1gVgWtNnoR5oHdTKNp25aluJD1pd9ppnlflUENaBNH9x72dyP4WhaSj8c9GUGtN6ZtC7MVzcjYrqDxUsWdThFF07GrBxfCXp+WYW0EkO7vVSt3eq+qcshbDOJoczsBs4dqN0iTyJtK2GN8m1wYvhh5SofYly3EJjrLQpweRf0C0jUn96rTMxp799/ktJFobGjuXFMnPCcEO+vtuIBQCmVdnwUjECZGBrMMlQ5RbQtVIO5SGgvFycO4qUlnrktQ7hSV/+t0f+jQB0L77lpped+doFTT2W9RZx0eyu/CJ72NBcq+Yu8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e8c329-a400-45d9-e1ab-08d610d523df
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:46.3326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
index 8a852042a066..d23cc8abe1ef 100644
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
