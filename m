Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A11C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90F9204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HnQ+qq3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90F9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeIBRVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:40 -0400
Received: from mail-eopbgr680092.outbound.protection.outlook.com ([40.107.68.92]:55808
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727707AbeIBRVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLzouzqwIIrEx6HhAL6t9/kiCDd9n94YF0XWwPMf5Rk=;
 b=HnQ+qq3F7IdlPyCAbZwaJujIS3WGzdM1tQSugLN9l5lvweDOX4NBhgGXYn6Dv9ryLeySqGzj3Z87T/DDMaB04bk4yaPe0LKNH9B/E6sMLi3pSIp6ry2MxtSsN0FSJDR5BSplRS8ERHe+NCwRs6ZJ7tNoK9vv7pHD0xVbaraIvC0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:05:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 119/131] ALSA: ad1816a: Fix sparse warning wrt
 PCM format type
Thread-Topic: [PATCH AUTOSEL 4.18 119/131] ALSA: ad1816a: Fix sparse warning
 wrt PCM format type
Thread-Index: AQHUQr2gKo8Daek4BkioV8z7uW1rlA==
Date:   Sun, 2 Sep 2018 13:05:30 +0000
Message-ID: <20180902064601.183036-119-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:2uCAp5CmRUJimo6B2qVuwkbAqT0Vttse01DSyiGWOd3XoAxUBITZcjCZxrUIbNZVoLyrIjvS6384x4UcrshGxzB2MnQiKx2wcasKINNmFyiRjX4g2/9Wc29omHxTwam6TWEDgOotYrJGK1Zc4Ny597vjKPSedC+rEZzK0rbM7M0Srg+GY1QOuchEy8oAmeJ5H6DhJe4RyEotrTNBLgvBHR2mbc2t8Gd4tvqXVjBQ9y44gPhrk1vIHnLQKFuLgtYPYcWKC0ReQB1scj66TU/6MOIWYWtF2SI/vSil41mS68c3EOedFSFqTFl7Rw0gy7tTmMSdNTwELsgjgIosFnq+UY2ycPAdVIKapK/RoeLkXy7035tthyIuBATltRlLTn2HRcK6oCm0MEaCy+K8G2z2chSsVQyhf1NNMNJooWWYlbvphArXJcBc/5WJB2ELyrHVR+cxJhu/xcFbogGtMDoGXQ==;5:bEUxUYax2gY0yEDa8+1V8763PDKmIxE1O/e3o465zvp16TJPnCJpB6RfwPW8aT3XukBH6irG1rcNXb6m22T3R0XMk9ROFTtIEcWobfWpY1fRWEHVQZW0MLg7Irh4qR++lnKOon/wdp4WkHPHA9mAacKsvlJaKPofJqraKwd4NzQ=;7:1OPDvUoF2AVZtTjp1xfx2DE+AzNOaMnO0EyE3A6E9sscbIxboxzh/dkqLIK7/cR05ISi88f2OultxzyyJBWZX8/3lerk4qS1X353KVgn1PQ4rF0V8ZOqdhxKyfn5gfokXfmIhLp5R/v5CUMz4dUTqlviYmrs8CxNoikF7fHzouuI+wjRVVMjxHRdXov7JBTczHY8XGjWUo1rHjXabJQ2FKMbONjAdf8jQ6wZgKz6wt3JMSn2lGzq25mhqnlBE/46
x-ms-office365-filtering-correlation-id: 1daafb0f-762e-4e1b-109f-08d610d4c9b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB062970C9CF3CD38CDF6E5E05FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 46++8lULFdxL0FxLVixalBfL1gnccyTGLfVd/tKDVPmfhJkQ4RNBP6F8I4w10bN5sLTyoZsKs8pNoJN0HefK0jz7yrvyBsePy6coCYfFXcq1dD83LDSU2t1To0IFMxWJAmOh6i7VREfa6CVwmWkrC7dnz2zDgDxJviYQWlS4j5cfnQyGkTy00MnEHx3ci811WyPt1A0is5KblV6Zlk1nqQZxASicAeJwb56ndM5xZGv7uzj7rHu4vbo5m3QS5HI1Oah2R+ZRQltfRwrFdFGoCGFZgttQ9SvWxwiA1qx1PZpsxrFHtw4x6EyMk/ZJVjQTBs4fEc8Jk/3i/yhXfmcHsnnMgzw907Fkjeui+2esOfY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daafb0f-762e-4e1b-109f-08d610d4c9b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:30.9951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
