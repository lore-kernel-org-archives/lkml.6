Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C902BC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860F2204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GpiEm0KZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860F2204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbeIBRYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:44 -0400
Received: from mail-bn3nam01on0091.outbound.protection.outlook.com ([104.47.33.91]:56192
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727733AbeIBRYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLzouzqwIIrEx6HhAL6t9/kiCDd9n94YF0XWwPMf5Rk=;
 b=GpiEm0KZiBso+wwnpbLYwJK1CsogecKKGB0kpu7haBE25ovHecRzQisQ1xzuIuczw4QNUhfDyNX4AJzEnGTrWBskV2oJdf40T3kyoDvp69Hgn9v2LAk/RBq0YA4YmwKn/2hR6+00nNKNbk53Sgr0KzuI6nspDZNhbJQgfaDJaCg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 82/89] ALSA: ad1816a: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.14 82/89] ALSA: ad1816a: Fix sparse warning wrt
 PCM format type
Thread-Index: AQHUQr3zVrarHuBeA02nB0XmGwkaTw==
Date:   Sun, 2 Sep 2018 13:07:49 +0000
Message-ID: <20180902064918.183387-82-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:+EEnjQ4JD9Z+VaS7blhA02RLrBU4c3jj9lv877+94EHGIH2wXmGpbgehaTC6Xqq6/hic+g5nNekfR+tX07oaiE/AFGkAzRKDZIduFN4yLL64I2V6khCk4KUhj1/MQe9QiyPj+VdDecgyTR2YMjxONnKft8vTReCOKchRu5+DfKVYY325fnF2ujG8GNeVrv4lbRnfZWAolLCWWddF/AuxVLh7s0Re8gQLo5pfMcrFzdnfIRl6hjPTc3cd84EFnNhSGRIerq/6wbHmmQJViQTUNTiVwuPKs6cF26HM6aMFJoPhrFCwgvZHH5e+g7cqxl61mcmL8rLlT91F6As/oV/+hzqQcsGb7ehBBi0kGlymLEQXiEtfzy0MtyVmpm2Cr6HeL3L4NRWp6sMgOxxQYY3iKMafTubwv6tFtRptp0eY8xrafHj4TuP/W0wGuMeUhjyvdrnhHS2kHY3O/g22Mk713Q==;5:JDptUSuJI6sfR+OphRQ6mCB93Dv0ielxgZ2W7XQMp+1/2MMVZnbWO9OlKdImeK0jpivtKkvLTJJKEU81ES3PavS9U1Bi9fKXiVqidKkaqXnKhDjxm/AXJik+7Ef+qhsdrPK8tES+V6Y/2pL/UMLmmG13DhUO3doxRJbSmaTjGHw=;7:fI8owXUFk5R4LNnR3Wj8kzqKTn5DM9Bkg3g55Qv2PktRmaTfWJ+kv1opbBgVFUMaoYnoAOQLpMJXh0xCgU72CQC2Ej54mfxdyQOmDOVsG/vmuIyZDqHz9ATfalmOq+y5V4yiZNhtmdxRNCPVjKRzySzRzKDpt7SMcKBeqTods/4mJP1uws/58bBJdk6ILgWMVLXTSHwVumOSin93aMXBA/4WCFthTkrWw/ivCe59a85j5guTbzUUimcRo7hStEEV
x-ms-office365-filtering-correlation-id: 6f6e73dc-aeac-4e3c-1285-08d610d5383d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB046986D0D46426D6B42ECACBFB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p7aFQ3S+u5/R4HSbtfytrlT0cYc5GUFOKlSSEn+8cuHMExtxVqHgJc2lPSXgklNSgmBwn1QtuKP8DOunJ7RpK7guKlJTPYiBzawrSfplBTaEDs2iYFX97ZRA2AotDbS125DfZZvjDAILgJk5EJR2bc1tFrf9mUMJTlWTrC5ddVGpkPpPuXnNKdthAJp5v6KiImfFfbwl9qtecMqVRgBQ1qOgAxTQs79ntU27awWTklFXrimez+Cjzge7oBL2zhR0I6X9/vS+qrT0Q+MCsPDdnqqr/XeKb2fd1ETYOlfDzLzeNGgoKUM5xu6KvmPcY8bn1bUPNN+4cCZpirYxAO7ZeoRI8sfi9ApeUPmFYFosRKk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6e73dc-aeac-4e3c-1285-08d610d5383d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:49.5563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 923201414469..fba6d22f7f4b 100644
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
