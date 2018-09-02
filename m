Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B68EC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4F7204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KlyreC0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4F7204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbeIBRWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:08 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:24667
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728614AbeIBRWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFnFLdPzqn9OY5R68mNLUS+UwLkpvHprAoEiAREG5qc=;
 b=KlyreC0eSn7o9kvisEMOzSQ4jV6tezKRJMur5RdXEzQzr3JYTPiM88dwPej/l4kh9LOkxfnyt945FJCkY6qxb+S76hkiiEXmMJWN3XcaEXN9PAE+FJgDHjL5ckVOh4LqaHAXu9CRtjx20zbTQueNUn1PzjJ4J+mhEdKotZyjs10=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:05:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 115/131] ALSA: wss: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.18 115/131] ALSA: wss: Fix sparse warning wrt
 PCM format type
Thread-Index: AQHUQr2d8ZgFITc1P0W2AxSfEXp8AQ==
Date:   Sun, 2 Sep 2018 13:05:26 +0000
Message-ID: <20180902064601.183036-115-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:F+kE4bHbDhZD4iUsqbfFfMDQYyILDJbIL+yWRU3y0yziVZIfxThjRH5BOprbs3HTFRDrtmPFrQMnEiHvBic8Ryn4Gjo4FFUpv2z6UlBc/q8ksobT8gVrzZ4lH2I575NFb94gZTkJRukS55UqZrViRu0VHe+MuLY3IAKQyfPehORrLR8Ai+3qej03zTn2Jrclb0jLYxgR5SQ+7hzbNZIvUD2P2xjDP0ZVAy37sCUx3eZ77xPmJIPH9gfFcLjYDB5/H88Evk0XrmIFDTRS25F8zUG/CkIdCaS0y5fF8VOH95Z2q55dnVRpjwNMpl9isrT9fEKjIIgOa502pDoMf89Gh8qhU/bCjm4Ku2q8cWpQLIT2GI+Mbygjaft56tLS6dQY6sIBmoZ5A7zwHlNk1sGwWg9Q0h6/Ub/s1AB96zP25evJ9aIWd9rDUdMFC0lB8kkeHEjNib1RnhW+vKpo/M5gWQ==;5:SQ2/bTfWT1R+sgry1SAAu9VVjNq4q1uaslcT31CyK8evZcUlJ0RlnLzyQ/P1BD2Ma2sAxShv7YUWh5fFU9I44Orvj0S0YFgRFdatjLeBOVLaFLYAvd0eQj7QGBv5UII1Bzd31JbDyKrI1wvcHWlAuDIyUptC74jAxtfeJtxqUPc=;7:jjlXyOfGmJ9Ioz12kkxnnlp3Ujqx/0SANXzg0V1BGQ5LDAz3rqpepOe0Iv0jndad7AcrmLbV5xJ8RunNW+jgmT0L+gI/0JDXwrIFrtz7b8tr8oXAiiHU9LHD1UGXjlislnwN1CTg1eiJ2bzCuZ85Rkn07vq2RzIONTtFQA4VWcmDfPv3sn6xrg+RQSKmrSPrY+P/+1XTXbuximKlNaUmZYVpm/7O+aU5d01goBbPgdhurWVQm2jNqGROxh742m3k
x-ms-office365-filtering-correlation-id: 210191e1-a6d5-44a7-773d-08d610d4c8cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629498FE0DB76BBCE6DF933FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: aGdS0ae+zv65vjHFTYgIbqWnrqSAGtSjHVi+DIw7PZXv4SFTk/QWv/pF/LGi6418iVo9mgtw/3b9LzShYWKKz7JFnOMmZDW+LGdO/3jF7MoekMIwdf7ALnZM1c3U7Pq8EkgaHjMIYPWlQ0l3+bUsc6VsO/63eXx9kjPJhRNMraEooCqb+mnujLpjcPDXmWGgJAlrd+HAI8Wpzrj5ThRVTQyEEYe4K2s+Nunl5BgrU3LArWM9dgGlb1NRzanldo10mExEf9aEibGy05S3OIUGg0f0UHU9K3ydf3EPiesclTmOpLP8Kt++EjwixnJi+2grKx6MWPK533fMVmyOr8T9r5BqWuw6VJLiBe8ST5sdyCg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210191e1-a6d5-44a7-773d-08d610d4c8cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:26.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
