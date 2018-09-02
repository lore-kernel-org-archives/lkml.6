Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914F2C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4101520841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WjB9+9lH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4101520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeIBRUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:02 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:39552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727487AbeIBRUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3EoLeOQ2MNYPqyAo6OF9xV8frEFgIaPfpzKXs5Q8HE=;
 b=WjB9+9lH9kIqnlHKJ0SzhI6cAg21apyVpb694LX9aSYGxux3gbqdCf/OxDs+SoSA/hwnrZO+l8cdYwcdPyIcswar8bidbfOJRds9ibyH5D5qlkWloX3q2UJ7hnkh0Moqu0/sQWdN1DJ9bXnVqcJwSNw3rXY0feCCzVOtlrdpOEg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 043/131] ASoC: soc-pcm: Use delay set in
 component pointer function
Thread-Topic: [PATCH AUTOSEL 4.18 043/131] ASoC: soc-pcm: Use delay set in
 component pointer function
Thread-Index: AQHUQr1niRue9d/Q7kWN0UvpHCdMtQ==
Date:   Sun, 2 Sep 2018 13:03:55 +0000
Message-ID: <20180902064601.183036-43-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:6Ct6jXJ3jL5vDEluYaTEBssME5b2hppOL7rLd+BGjO/fnIgcx6bzSVuWNGkXPbURTYsGaj5x4r/UEu9JW5DE55HzLy3lpEFiUQ9ZAlzCJ2SqA0PVWaZ5Aw9A/LKtGH6SthO2+xfSyfDdIgpVPuXe69vVBEwgddj/aJ6FgxYqwyxQ5q4xb1DTk/dAbbtONfFFUlw7MQlD86mj0H5sHcjTBItx4k8B3A6dUKMM+TH5ELA9uIYr7fPhSwpANY2sbILDEd5Rd13LAQvmyfcXj0P3wGpc/G8Ty0RgZyykhGjKLAie2xVjxzOavl0rJ3O91QVk+IQcTa7WJeo8SPflxo8KLEO0/2uq0A9AOHXdfcnzruXWSJiE7tiO3YeEaUDci5x3qcyYZzTMUtsYlrfnIdvNVgILqDICMsIB+efxSscqq8tsla2K1KgUm5C18ziKCW5zQfhwa+7hAfH1k7TkZ+pRpQ==;5:jrN9vjy/73DhHXLvPS5hJdOGHVHxbp5hMUw8SR2GIGunI517wZDMjXrIEiAeXDW+/SiV0F1xYjls67TlLccpXElRLrlzRHk1IsqGBa4WsrlVlBFmrJLZARF09vp8+dOG2sYipN/Q7i9uiuE+2SZybfECTnVhq54Pwx267pDLTlE=;7:Qf3YCEDQ4p37sO1P07iQ1c3HjzLaZoqiUgZBo7hGWjP1UOJIJMeJfJLFUn9FQKi/hw6lLAG30GHvyXjBiKVWiu11pN2MMPNBPWsxIPmSj4NMHu6DsT7xdtWBATxaNaTrICO7ekZGi9XxMukZvKEZ5nl0GkRjIoRDmEslMCIQ/qDzaBeY1/m/f8wouxeM7xdut1VLpus4VZsLG2q05Jhar6UQdLlQxaPe2c1zAeqqWyhiaVtasrftT7efxdCMcaQd
x-ms-office365-filtering-correlation-id: 0735c17a-19dd-4adf-324a-08d610d493a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB013532EAD9272667638B374FFB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rJnBWwfFxMuWDx9LZ6lFH9Xo30hZLuW7JxCmtDW6C8SrjcTDGfFtWPfvuMmf0ruRCthVqDBXSttFxxI1cl16F4hEojs990ViP3Z13mBY77z6GURgp/yVdk+2kKD5o/8b7ANoKFv+P7msBsqhPQazpjqlytPilgvOoIAu4D1QOIWX/gKBznkUMo4zroUmlds6ec2t5fnEz2wTxvWEQSkUYG6B6DY2f41+3yHtoio1xYaZJxAZ7nbbPHVjRJrF6oKNWiRWaR8szDxL1n3Po6uklxhiiD1RFmyJVKxaWwBRAxHRl4ZlztyKWP2ZSZLrWpZAEhkmHqRvfvxHnOUU9t+w35660Yo0syEowIfEEnXyKVw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0735c17a-19dd-4adf-324a-08d610d493a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:55.2859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

[ Upstream commit 9fb4c2bf130b922c77c16a8368732699799c40de ]

Take into account the base delay set in pointer callback.

There are cases where a pointer function populates
runtime->delay, such as:
./sound/pci/hda/hda_controller.c
./sound/soc/intel/atom/sst-mfld-platform-pcm.c

This delay was getting lost and was overwritten by delays
from codec or cpu dai delay function if exposed.

Now,
Total delay =3D base delay + cpu_dai delay + codec_dai delay

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/soc-pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 5e7ae47a9658..1cdd21f6827e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1165,6 +1165,9 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_p=
cm_substream *substream)
 	snd_pcm_sframes_t codec_delay =3D 0;
 	int i;
=20
+	/* clearing the previous total delay */
+	runtime->delay =3D 0;
+
 	for_each_rtdcom(rtd, rtdcom) {
 		component =3D rtdcom->component;
=20
@@ -1176,6 +1179,8 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_p=
cm_substream *substream)
 		offset =3D component->driver->ops->pointer(substream);
 		break;
 	}
+	/* base delay if assigned in pointer callback */
+	delay =3D runtime->delay;
=20
 	if (cpu_dai->driver->ops->delay)
 		delay +=3D cpu_dai->driver->ops->delay(substream, cpu_dai);
--=20
2.17.1
