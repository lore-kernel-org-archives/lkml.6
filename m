Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA788C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573962083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IDm6FjmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573962083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbeIGFfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:35:45 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:30237
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729362AbeIGFPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUCUx//y9jagVWTTcWH/slHF9MGVZuna2GNA7NQKpBk=;
 b=IDm6FjmRhRLRhqZds4aEB4nTHp1VpAIXZlL0FiyDOYREW+R4UetqkVEJ+8l8zZBuyO09I7GneAcUm5GH0KlCPi46K9Ytf9i0W2t4gZdt1+BKzWdaaDlRw9k2cSu0kcYDwHGEQ+r5rLEP+bDxlrebkMzKpkNLHyhBLNa5uxYZ9e4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yue Wang <yuleopen@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 67/88] ALSA: usb-audio: Generic DSD detection for
 Thesycon-based implementations
Thread-Topic: [PATCH AUTOSEL 4.18 67/88] ALSA: usb-audio: Generic DSD
 detection for Thesycon-based implementations
Thread-Index: AQHURkLXfe8WkU7/a0OFf/Jupuvz0A==
Date:   Fri, 7 Sep 2018 00:36:40 +0000
Message-ID: <20180907003547.57567-67-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:VW1cm4JbyFIaVDbNsEldLR9i+8NPCjCj987y6M5mIJLoT0BiVw4kQGXW4OBN4Af/wf0GIRqQd13NdAGnMC8wm5wsPAEfYXdy1T8GySPhTJwfNXDmu2d8mXrjBb1euzRXhWtxPFv/rEhgtWuRo+nsiEKbDi2rXYUBlG/bmOWx/lGWV9Z/C1wpUqknJ1J0HxUe0IFXBDgXxT10cFP999CxFiofF9dx3Y+5T/tScaF8wR7DdiNxRfkkhb1ff/45L0VX+uIMCN92NiOA7prFfEK1RgIEkBBXvBVnwrHnJfE6h+otG0V96nCIWAX41cF8mzYYAdIGltBTiLJgYJCFbOkPmQVYrN1mn5yJwIYDkwWSLotDUVBjI04ubrMZdtKyxIFbbEcRjNTTXj1tjaQexWWXnxmqJJXZQetUKex2bKksW8Srxr0Afz9ktDUM5nL04hIr9a7bOtb6MGfxfNz4IfZi2A==;5:RAZaZ26oF8lU5LIUycSLgOjBFbnTREaRM8fLP72feJuVJuPKhuU1wrM8+/iDyvPCuuw2sb+eHXok1e6whP9+7/dFNFiBjUNbprGDbmdn3O/Cigb1VC4ztXXUSlPlhXyDBnJCcOsSVcRDOncttObZMtkjfIEzM0gGbOmhM59OsiI=;7:kp0oGNiQAfBK1Qd5/aIjNQSgE8gKS3yCECC9zypd/BBIaOoxDU1Ek0uJMpZkkLORH5iwsDN02+WMn/0yBSRPGn7LCp1Yk21dfksWSvszHKVXl7bFqWJ8HSWCW/N3oB+nhTyJ2Gkb85XPl4yWuIbX5acB5VfRzbcMGHii9ttCMBCvDxG85bag8tfl3/jQbeEbj2AMfJtx7rcgb5UhbVIhj57hN7pp0jjDje0ykR18EEfwA7P2MeUbjOpm9fTGk1GE
x-ms-office365-filtering-correlation-id: 1d7f77c6-d853-4b1e-1a6d-08d6145a19a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01182D690FCBCEF6700A9803FB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(39060400002)(86612001)(25786009)(86362001)(575784001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(14444005)(446003)(6666003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wMOr5VcUVzUI6tmU0OpnzeoXxDpYozgpgy1K0nMc9IKaAmLKbW15bXvnIlQ3c+3fKjr1EW0R0feTywDXrSbK4oWFejumwSOreDxI/PAsQ05VcUbOe05uhPRX5s3OoDO+r+hTav14STSiNEKoHVTbTrb9v+EUqE8iJRKaF4KaySnK0gicxOTjeACTJgbpSAHDMdM9LeNYtNXZ+qgNgRNITxhBSOQifa26p88Gl7s6el9x9pq0Sdy1QiPX0RiSZKtgxnqho9G9f6uqFZOgeGWvNJ7qlGjOHgadb4Q0i66eOmNRiqg73u8kwMbKSOUxsF75xO2T8O80q1iCcm4Z6xctLuEidxtAaGH00TnUvMBqdaA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7f77c6-d853-4b1e-1a6d-08d6145a19a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:40.0473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Wang <yuleopen@gmail.com>

[ Upstream commit 1ea0358ecb848058b35b6da13d7f4c08610a73a8 ]

Thesycon provides solutions to XMOS chips, and has its own device
vendor id.

In this patch, we use generic method to detect DSD capability of
Thesycon-based UAC2 implementations in order to support a wide range
of current and future devices.

The patch will enable the SNDRV_PCM_FMTBIT_DSD_U32_BE bit for the DAC
hence enable native DSD playback up to DSD512 format.

Signed-off-by: Yue Wang <yuleopen@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 6fbafce0aa6b..dde87d64bc32 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1444,6 +1444,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_us=
b_audio *chip,
 	 */
 	switch (USB_ID_VENDOR(chip->usb_id)) {
 	case 0x20b1:  /* XMOS based devices */
+	case 0x152a:  /* Thesycon devices */
 	case 0x25ce:  /* Mytek devices */
 		if (fp->dsd_raw)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
--=20
2.17.1
