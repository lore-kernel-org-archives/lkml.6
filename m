Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF60C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DF22077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gwzDlMf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DF22077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbeIBRnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:43:07 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:51200
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728863AbeIBRWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9jGjExDT6vN0y31gUUeLMHPXMAo7qhZt1SiW7iYrw0=;
 b=gwzDlMf/7LCUonf38WLba47+Sfdt8fgOt/9CmQ9ec245a8Mm+D8bfs/aeFsf4qzPeILLOADPpCHYlpQaRvxEvHlWKVGsbZT9Eb3qu9HVdjNdBlOTCDLhHsRBynN36+vpLMCt1pSB+cSKeHlMyCEWPLY5DPs6v+me5CNwaDPyTZ8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 02/89] ALSA: hda/realtek - Add mute LED quirk for
 HP Spectre x360
Thread-Topic: [PATCH AUTOSEL 4.14 02/89] ALSA: hda/realtek - Add mute LED
 quirk for HP Spectre x360
Thread-Index: AQHUQr24qGTStRYYoka6jz1ROcPZZA==
Date:   Sun, 2 Sep 2018 13:06:12 +0000
Message-ID: <20180902064918.183387-2-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:elLZ39c2Ft+AoCHIYLdYCjQJ8IDyZ0/B0MRkr9L9rRDf3rQK9KUJaQ/5IXkr2tsGRA/M01A7gqO2NahMKEJ2PGtc88F/9uZvNSeiFDzBrUSCAuvwG1OoVPXvqPw3hublQyOEUrIU4nciMdB8wVgpYznC59WkaeKiIF1PTPKqzt6E5yYYQhFwyujflSwh9/3JcVFUzOlU5ENGzbiNf25yo8ZOOc3BHprzpHiT54UhopPKpVFIJmustCaakN+jkTx8r5piUI9ujEENrpCWm+Fq8ZatjiQVHInPUwMSIejmFRWwlqZoIThtuJkMqPs2sFaYIZYhfU9YyMxgvpEzwb7v8TuK9duIA5x15N5B/i9TCi1f9/J9N5N0A5ieHxhMMhp5mf35QzZQUz/WnD5ZQO+L6OlWLysfb2NC60ZIcg1QAH2SWIR9V6ahFuJG2swti8ab/vD9sMLf0l0r6MitriV77Q==;5:V8PcuSQzYQ7AhbVwEAubdVWrOcnn02BWtf+2FhyKHdJ5Xi5mcKL+1ZqmXGIpulXy6IMcrpbTm3XKT/alF/PImy9tqHvqkiLUROG5i78PtBQERMyAGzERpQq7H8xaRdCswV3+YVyI/lQG4K2Rjc/DvkJ5svNqysggUYCTvKlH22A=;7:vHg7yRW7UNSoy3lg7mF9FvvlOQIpQxOFjQeOyzKHruvdd+BrYJLtu4nerlJn+rLLs8iWZsodtjlZ6KYWoeo8Ups+h6iYk32nMtexHWOvXnVirfS+6R2MmayWvh2ekb5a4NtBnpRkvP24e/x7NWQGOwGSFQXy/4jzybB7bpOA+stVEU7QoQ1x+EHKZ6f5o31dHi5U64ZaXwWh67OOrfLQJm036SglgI9dY1AHA+pIjshiX0sTgG2SwonqLsXU+1kQ
x-ms-office365-filtering-correlation-id: 88a79275-af27-4b77-972a-08d610d4e09e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB08225FEE723DACF5C99B9B53FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(110136005)(86362001)(39060400002)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: pPefS9PiYtDD7BbSyp3b8RrERWZoFQfqhO3G5WowQFxIi7hLHBX7fp/8bIzjjHVnN0QIzlz26BHty5kuXNSLj7e6mzn6xn4JmTuI7m59JCKZD+MYeEiGui8GRcFwRqmVMcFIXRw0CVVHYK2qHPTdbmg+1wfAotLvUuiM1C1RBMIPQL0SaRB42fxFoLibk7y5zVv9rbub7chEDXYuZj1OEg+LJ7xUsP2Cq/qMXZnRmdnE9V6ohaA5q03DWx3XEtZN+cRbkyGEyejvI+DXGpO5JN9BZf6t77xdIbVAu2ZBRawWOIxYK2/ssl2TrTxLbKISptIgRjBKw8fZc8oqZnz7Z54XF6FGo1x2aFPNviFS0hw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a79275-af27-4b77-972a-08d610d4e09e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:12.0202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Gagniuc <mr.nuke.me@gmail.com>

[ Upstream commit 56e40eb6d656194e55ce2012fee9d5a496270aaa ]

This device has the same issues as the HP x360 wrt the MUTE LED and
the front speakers not working. This patch fixes the MUTE LED issue,
but doesn't touch the HDA verbs. The fix for the x360 does not work
on the Spectre.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dcc9e6551b51..c5364c384897 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6362,6 +6362,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =
=3D {
 	SND_PCI_QUIRK(0x103c, 0x8256, "HP", ALC221_FIXUP_HP_FRONT_MIC),
 	SND_PCI_QUIRK(0x103c, 0x82bf, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x82c0, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED=
_MIC3),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BO=
OST),
--=20
2.17.1
