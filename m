Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246773-2-13887450762596948776
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246773; b=G+hR9GP5E2Zv5gah7PYmlcY7kgK3hqgmkFQYJiGuLIrw4268df
    a90FZFdeH9tb+59o0kwGABV7ZXpz3b38INNDne8DB0fAf+1jgRN7rPMVOCbhnZS7
    0/1MLzv3AeQUuaqKQ4kBW12hpy3+X95nda3vimeNI+SE5iOgWAiuRrOpT1WgCMuQ
    66w0T4RnGOWLNs19sFmhmIv9KYz/3NmNEo6vMjed4YNPPhOwhDcuFERQXcut+XBP
    es4mi9vfMdaXsaOvziecp/IKLiyENRVFvd5srDq4+ANLAK8F4D6oQ5kbSyRd9cgj
    bb5rwXmp24HWWPkQzCmy+WsHWFdFDR6AzveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246773; bh=unMcAlAJOm
    Qwhsy3rt9qy3UzCxYEXJVdipahEm0BawI=; b=cvD7zb7t6QfhjNpcCX9q4OpOve
    0ylnrgvbC1SVFvrXejrDLER/e3NhXlKJcamr4DSyh8EbPA56+wVkD4eawcFqmzzd
    lKGshsqrjl2bFa8YuyG178Bngsnl6Q85w/c+pkUNNYWJmlk2iYuvBOoiJ812pTBj
    MJ50KmYGPjb0Xy6DNk3dFv40fhPgL+YySJwmNwZjiMQqJYWB8Ivsz4NiVMHz2gBM
    53huQ5+EBbYiXTRpS3dSEICiB31RxE5Y/nfu154D2ZKf1Yf/rx/rCu2sRHmTUbNr
    bXUhigidDmAQ7+FJg8zWuLkMlzPaD65QmEe9Uki9BHV/Yh6jagj1zyTbgeEA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R1oWLkjj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R1oWLkjj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBaUIB60K5fO8eJbd/zLQqtx/XozLUIPhE5fxxMKnx/WTEV3jSjmbl6/Q1EBIs98jtLyiuILMGk4N5bI/3bo6OLOHRM2i6LZi5uJvtkaiQySl/iUteqR
    8ka+YkzGnrN63wtVLWvwhS880l+0IqwJbBme41opV0nT5AgykIF7Z2HRLWW7WhGEMqOL87I+CzNbVNQlVBVK5ih2nP66OLvdb1Yc+cPlp2Yak4QkIV+3KGlt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=EDLF81dCAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=85Njf5GAFo06vSX2ljMA:9 a=wPNLvfGTeEIA:10 a=Q3gGPzbJhzamX8w4ir7p:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeDIEF3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:05:29 -0400
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:51875
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753271AbeDIARy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 044/189] ASoC: bcm2835: fix hw_params error
 when device is in prepared state
Thread-Topic: [PATCH AUTOSEL for 4.15 044/189] ASoC: bcm2835: fix hw_params
 error when device is in prepared state
Thread-Index: AQHTz5gg98iVAtp40EeyV2UGyYPEUw==
Date: Mon, 9 Apr 2018 00:17:20 +0000
Message-ID: <20180409001637.162453-44-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:20pkr8FceiKdJMYAKcYUi+SbCSmuIdWrVXopAOSxWGbps/tcW54OqjcLCeNZY3DwtuzzfdU0ErFt6K/CZwb6yUh4/cdYmUH7ebPIf19kmZIR+/if1PQrMP1XyVME4j7sQvL83Uq/ACDLZQB+NThJm+2o4cmmP0sl/IO9uXpXrr/Ps4U/C4JJMmjSszWj6w2quOdRpXgIaaX0ncLHuaCcSP0qL6BT3PZq+ELcSbZhn4YMFqzPk2xssfLSpf79I0ag;20:iiI5wf4l4qQDIhBFFMZdleyC+BcS6m/OCPhJMl6bHm8YfoT5ljj6Z5/I7tYkMsL8sDnZt5vm5pNhGjKEMiZvzSxdDiZVBdAsCB43tX/LDOHZNwebOk1AG0B9iKACU1wQKiwYUvSvqmqoX5L+RGAFzSNddOjzKi1QlefAb4PDSqA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b869fad5-1044-477f-c547-08d59daf52f0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048B2A18F1D6A36CA26091BFBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(86612001)(25786009)(2900100001)(14454004)(97736004)(53936002)(107886003)(68736007)(102836004)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 15U2jFlivHTWS4eRWVk10rg03DE2LB7+bihaKejOCFXAJhBEjSTZ5yFcqQX8vpzCM1sZmzmEBF1cuEHdIdpnwiOXf7I+fygvWIwqbDGCfn8+EyDD5cNMrj0BmSaYupWclx6K7U4c04a3yTNzR9GH33eScXMzehdw8uN2WsdfGntzd646PjqnbIwwOok5SbuSgMThGQkGNeUmyxkaobHtqXu+G5KuUegA49cOU/dTsgEVwTm4wgCpV+uJAEOMb7+kpq2XIEjOAKk4p3b2qPvOP+gq6L/GSRV5+OdXppi9Dn9IbIBhjk6M8lmCvapJo9AKfQvTCGQVjrOf+KYrYn92zF3rCvvGlnpjSTNkvCvXUfnddoFM+7D+jvqcN7aQtvpUgXj5qdqUcpgW3hxFBfoj1QCQS1AE9XfugDap03YeqKw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b869fad5-1044-477f-c547-08d59daf52f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:20.6666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Reichl <hias@horus.com>

[ Upstream commit 8d5737a5f53902a916ee1e1cb248c9b8b883b2ea ]

If bcm2835 is configured as bitclock master calling hw_params()
after prepare() fails with EBUSY. This also makes it impossible to
use bcm2835 in full duplex mode.

The error is caused by the split clock setup: clk_set_rate
is called in hw_params, clk_prepare_enable in prepare. As hw_params
doesn't check if the clock was already enabled clk_set_rate
fails with EBUSY.

Fix this by moving clock startup from prepare to hw_params and
let hw_params properly deal with an already set up or enabled
clock.

Signed-off-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/bcm/bcm2835-i2s.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 2e449d7173fc..d5f73a8ab893 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -130,6 +130,7 @@ struct bcm2835_i2s_dev {
 	struct regmap				*i2s_regmap;
 	struct clk				*clk;
 	bool					clk_prepared;
+	int					clk_rate;
 };
=20
 static void bcm2835_i2s_start_clock(struct bcm2835_i2s_dev *dev)
@@ -419,10 +420,19 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_subst=
ream *substream,
 	}
=20
 	/* Clock should only be set up here if CPU is clock master */
-	if (bit_clock_master) {
-		ret =3D clk_set_rate(dev->clk, bclk_rate);
-		if (ret)
-			return ret;
+	if (bit_clock_master &&
+	    (!dev->clk_prepared || dev->clk_rate !=3D bclk_rate)) {
+		if (dev->clk_prepared)
+			bcm2835_i2s_stop_clock(dev);
+
+		if (dev->clk_rate !=3D bclk_rate) {
+			ret =3D clk_set_rate(dev->clk, bclk_rate);
+			if (ret)
+				return ret;
+			dev->clk_rate =3D bclk_rate;
+		}
+
+		bcm2835_i2s_start_clock(dev);
 	}
=20
 	/* Setup the frame format */
@@ -618,8 +628,6 @@ static int bcm2835_i2s_prepare(struct snd_pcm_substream=
 *substream,
 	struct bcm2835_i2s_dev *dev =3D snd_soc_dai_get_drvdata(dai);
 	uint32_t cs_reg;
=20
-	bcm2835_i2s_start_clock(dev);
-
 	/*
 	 * Clear both FIFOs if the one that should be started
 	 * is not empty at the moment. This should only happen
--=20
2.15.1
