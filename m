Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99782C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430522083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YbkB30F1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430522083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbeIGFdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:33:01 -0400
Received: from mail-eopbgr710122.outbound.protection.outlook.com ([40.107.71.122]:40960
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729753AbeIGFQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxDU/jXaEaRzht0/Z6TEX3KPmfi6PMwpayjp/MtL5Eg=;
 b=YbkB30F1ybMhnnXal9lL0mNTSPmheZELGlZese2/nwQJoL979sl0BrZJesPohPLX0hyAWzMxvDhNKTyAjWRd9zS8jEcOOCEVhmfKHniFiV9sZn5dOidPR82U96GHusbmc24Z6UAI/KQ4oCPcSWxvqIEsbM+uFq+XBolaOGkaZ3k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 06/67] ALSA: pcm: Add __force to cast in
 snd_pcm_lib_read/write()
Thread-Topic: [PATCH AUTOSEL 4.14 06/67] ALSA: pcm: Add __force to cast in
 snd_pcm_lib_read/write()
Thread-Index: AQHURkLyT3cRENeoqkOoTK9DROhqFg==
Date:   Fri, 7 Sep 2018 00:37:24 +0000
Message-ID: <20180907003716.57737-6-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:RZ5eAjWnDuVmNaFeXFbn1h1tpJeWFK+J3S6P8ivdF2+HIX/IaQvuL2VIz2Q5GlxY0p2m9PhCpyhQKtSOEEiJeB8UI4IT2YPX10uUGs1zr5dxfzPtna7cFeTnMdhRIqPLZo5YEDAjfp6ISHhra/K++6JgrrY3olncE0mYXur95yPrYaGXU+RHxFwjUdICvq8GKdboDdZI6DmQ7/wP3OxrxqKJ0s/krzURHoYe9HyJtUJ/+8nt9uHRUp277MAiIqNV783v3UEvcXsN7ez4j1LAOJbqdZCI0BYBoGvrpDtZP9q+H7dEUYVJtFAgxn1gOIBJP3jOfdk1TIgi51VVDwunwJlEpe0M9jCmVdVDrqi4L6S0HJv6C+d5hs97gbt1Lk0wy50k2nAoaD9V/QlGgcZPi+kjnE8mlzxKiARi8sHXiiSo636k+QgVxqj1jE+N5inVZOQYiqvraJE7Duy7lY4OOQ==;5:mwLySxTPzLhnuFPV7hqFiGG+GHa+6fx30VINXOJOeKbk0S1M3OSYuVWGZpJBJmwk2KsLcSeETwOiuXrX8hV7ZtUfmG/F9jHg/qEQ1wssDe1na1DAqH4qfMT7p7x3xKiTfSJFXUFNWr9GnHM8XWdP9WpXuA2K+64kNe6EB1R4GSg=;7:VkKOXrhrGZuErpRvFSrfoYSD3Teja4ZiVnm8Pnz8KC7o6ZitlpNXv71NawGukEgCCk4mSSqmZAKiQfP1HHopGn7b0s4hb0P2RGtjC44cp4M7NA1nhSL25KWeanOwsIY+vAq6Bidd8ilmONL/ZCvEp3rAxAdNdkj19kiH+8w2zr2gXfmWogCWdod3FZ1/KKoKnOGzt8bzj78GTQjZIxqqiItgLL+s+bXlLGm2nNc+jBrdJ7nm9GBgLhs3q5H/88Hj
x-ms-office365-filtering-correlation-id: b672b653-ba71-4917-1b30-08d6145a3274
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB083917533EDCE479E3FE1E5DFB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 8w0+VqHtd3YMbuwXrI0Kkc8Cx6weGt5Ma4fkhyXZDuvdtRJYxhwsuBV6M350+qdjKJgPdcvLU3u2Y0r4S6zqQSy92udP338I7WseUBidYunk3G7itpNdV+0fXw8txcI8Kplzm0Yo1aN8L0T/eAAZ4+zr/Hh5qDPm/al0cHFZCmJg0z5/UwFVI/J+JwX66YeFX0DHQRvtrzvzwdYFkBOo+AL/4Iped2VXPAB7dYcGeLPfowKsYWSjY7koeo8K0ETJ9BdRrCWEI5ouNr5Vo0w0Z7nJdqznptK1dpsKEHyEKVUeuH7QJyyORbLx3eAruq5i7eGAULkEvBJHq1YjGirKWkSTro1NrpnIqsIOc8n7M/g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b672b653-ba71-4917-1b30-08d6145a3274
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:24.6539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 95a48b7d4459948b6bacf809809cf01a7dc06d1d ]

The snd_pcm_lib_read() and snd_pcm_lib_write() inline functions have
the explicit cast from a user pointer to a kernel pointer, but they
lacks of __force prefix.

This fixes sparse warnings like:
  ./include/sound/pcm.h:1093:47: warning: cast removes address space of exp=
ression

Fixes: 68541213720d ("ALSA: pcm: Direct in-kernel read/write support")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/sound/pcm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 24febf9e177c..5087200599f1 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1081,14 +1081,14 @@ static inline snd_pcm_sframes_t
 snd_pcm_lib_write(struct snd_pcm_substream *substream,
 		  const void __user *buf, snd_pcm_uframes_t frames)
 {
-	return __snd_pcm_lib_xfer(substream, (void *)buf, true, frames, false);
+	return __snd_pcm_lib_xfer(substream, (void __force *)buf, true, frames, f=
alse);
 }
=20
 static inline snd_pcm_sframes_t
 snd_pcm_lib_read(struct snd_pcm_substream *substream,
 		 void __user *buf, snd_pcm_uframes_t frames)
 {
-	return __snd_pcm_lib_xfer(substream, (void *)buf, true, frames, false);
+	return __snd_pcm_lib_xfer(substream, (void __force *)buf, true, frames, f=
alse);
 }
=20
 static inline snd_pcm_sframes_t
--=20
2.17.1
