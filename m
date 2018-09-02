Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F441C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024F220837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WdFMLH6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024F220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbeIBRcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:52 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:9515
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728145AbeIBRcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEoAPmUsNs9NDO1LUuyJZiiVFh45Y3LdNbuLFoWWZwk=;
 b=WdFMLH6OjN2YEo+9rYtdxmwIpVQnGT+i/CMZ/iWzzETwy2MABRYPBO3JJrUrw075bU+Rnw+i5PJmqO9NfglusYCp2mSrVW2Ds/ezn784znj/eZ8rdzPhsio5DW9z2vu3La0zIzSPN8N+99lKcQYj3bKkc/0mXGODuMN+tn0zbBM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:17:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:17:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 41/47] ALSA: ad1816a: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.4 41/47] ALSA: ad1816a: Fix sparse warning wrt
 PCM format type
Thread-Index: AQHUQr8o/CJNvwH0GkOqCJugZnr8tg==
Date:   Sun, 2 Sep 2018 13:16:28 +0000
Message-ID: <20180902131533.184092-41-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:3coJ1Y9V8abt/kZMSpKavrHok5BqAaGX9XlJIbVr6kOgQmbBqoRDHMGb5nZ86LW9UY3VGsfyEmYImW+D+Vfl5IBPx4LIpYU0Gi5tpHvSYqdxp4ynUa6+HyfsLAoLBDYQPdQmHOC5lBDitylxd7Ac0x0dW/HSb2RuIHAe+Kk6Cs17j4F0DMstMv04AiQRMqX3/FYmBg61G+x2Zjd5UITOh+1sgr66B8saBV9RDCTdxETL7P73agXqGPeUwkluYS6T8GTeAo6D3cvTMa1MhEpE8ftlsEiov5RZBqxersO3Btc/yDBLLkZJ6DiEXP8NsssJRDKqtyPGB/bHtGwmQVdBj/HOR+5h7M0P9n3xSqbFr44duz35aIVzuHRZL355MmlONgjIwzbbqd03Gr7DTY4nizFCwUvPWRrH8LKoC/l4YwU611Zxpl2GMO1pPDjO/nlyvrZfMcseBaSsG1I8MmAOjQ==;5:tqRe5vcUGVmV9EODCf6vyenCuXzN2oNPIMSZUZUxgUZtsVoDTdvSKMTr6KjySIyHqSEbM9M7iBSM/wtDt7p0kiMoF3JqQNnGnbK4zs0BhNsVB1nGsJKt5tmKmBjt8gvkO1ES0HguSNvWJL8WT7pveZt+afVDP3HDpZTqRwSTyjE=;7:BCs5zli7O75K1+bhdoFNboCV+WTgla23NWi0CoYmVHEYBu6KN3UAQmOp2GOV75YOTs9CAZo66+Mv3aJtFXlLTZCMCdxeAycfgvKAdU9PVQS6QRDSd9Mdj728lYnHhnK2LmdfRsMJpkTVWusNYMOMiLJMommApgWOVvhUlp4SFSDI3q/4TT5AG8g3pen5wwNLaTOMr3bJN9Vr5uai9AeH+zsqZxYaiK/6iDQjtFpx42CQHCMBHxjHKQldvAaJ2/h8
x-ms-office365-filtering-correlation-id: 7f5d7bf1-cff2-45db-0479-08d610d65ecd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167FC228ED9EA239F55E240FB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(86362001)(107886003)(72206003)(14454004)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0nrmIE7AyAR7ex+Gm8Z5NV2vUwwD/Pn60aBKDtdWvCRHfJLhp7E0HCysTV+oei+sgaNshnzrvyVQQYGOHnisCpytQDkZ4sa/LeaGluLgMkEar+zzH8NUSIoRENJg6FG7N3QiYhTctUjS3bKSNg9elZ+O+VQbdO8pKSz+sGvnW9BBP/DifSYhHtLqxfaOXZwnuSSVY2HVvnj2JQFxrPfc96jPDMOck5Aes4Hg5Izkw2xH/kMRGZ16BDnEa/Cm5r9SXy9JuYnTu3BF8Djes4G8K7AJ/5QaA4xmjEZ7a2S0LVT4wvLj5BA776TT0TL5CHQq5U2XccMgcTgi3Ws4OLHqAsVXGXSaYaPwsOt9rEwtBvY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5d7bf1-cff2-45db-0479-08d610d65ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:28.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
