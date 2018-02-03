Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682503-2-5627446263502786372
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682503; b=Jw/+8l/PQAFcSiVCv2rynYYJkr5pbwK/Ej7+Ha4SoduiLDJ
    zOyNs+jbMrS/kKfQtjsrq3jvEq2GKNet/x3HKEAYscX/MQmGLpDcv5GGlEeZq/T4
    Pe8F5N7wgJCnmg60iqMB/YNbKabfsOc6m+OGnzeQBh7Iuq89k7A9710Yo94LvfFk
    uIln8isRzDG1JfebeS+YP+9AUdHLVdKlCFwg/wr60rte+Go785Hk8yb166e9QqNW
    9tsO+M1F+S9RJl/x3BK+1wLT7B3vnpofzGurBqKz5qYJ1caHRuwx7YSda/XcABw+
    A6G2XGjcHF4P7dnT8im2x8VIUZjDNrQIkIevKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682503; bh=Te85Yk
    R9FTYBA+BjfFoMRX5ScJPe1zreBKjOyHN8Gbw=; b=JZOe9zwRoRL4+i5I4KIo2k
    JJ8mYRS6kHjnSpDN39J57gULf5OV3hfippoTR9Zj6FK9S7nNQA1ngt2GC6tqbFm4
    dvm7SrlFmLD+XFt2LEOZlTmE0RqxR+neqdOZeKBCJzQzrX2WC+xyYssitZNZ+UbK
    CTIrqp/WtnFNYdrRgM0BNWfl5J/IzSLolbpjv13UmhN0JEQ3W6Q/UNRz5ddswZTR
    1XBqbdHp8HAQ8iojoVn+k6G2ZBJhcYC1B2mvDp8RGmDWkwG05qGzXROSxISZ9Gvq
    txEaqEBKMN5XveD5b4KbfsAEW9tYthNzYPTS7D0uTNX18zUkQRadfUDCazMMvEWQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HQpAr2Zp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HQpAr2Zp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeBCS2S (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:28:18 -0500
Received: from mail-bl2nam02on0122.outbound.protection.outlook.com ([104.47.38.122]:14996
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752989AbeBCSE7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Abhijeet Kumar <abhijeet.kumar@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 15/52] ASoC: nau8825: fix issue that pop noise
 when start capture
Thread-Topic: [PATCH AUTOSEL for 4.9 15/52] ASoC: nau8825: fix issue that pop
 noise when start capture
Thread-Index: AQHTnRlSOT0g0dr8HESJQPcXVKrmvQ==
Date: Sat, 3 Feb 2018 18:03:41 +0000
Message-ID: <20180203180303.8490-15-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;6:f0UJkSMBYJU1QEtgQok/hvaZZK0X4BXnnPfPNGa6jEmy92y04uj3yJzHCAJQKp1T3u+xpwpjCVh0bW6BbYLU10m53ALeFtuZnttoA1POEzzRixIHvIqyERM9BTOQptzjmfdygwl/+LNBf/f8PQbcTvRghADCR9nRSPORglwGrTvdsC+I4PSZaShUeon74sMg5GTxLaph7avDs+gSZJCEoOOsjqyoDRlnkOG6z+i3MVqwpC0Sgy+Ln7jTfQFdUUQfv9e4E2qwNDGCDmvz7m/bH6OL8kiNmxq5Ggz8OhbCp515S/sAu+mhqfFjb7J9/nq5w5rL0UGd0OWTiLn4W6IW0sRKm7sDDIqxkuxyVzPvNQv2VpRQRtB+v0CGWylCt3BX;5:tfTV1vVGUuv4l4iBtOpT6mtWGO4kFFF3rXkgPAWuQKjcnOK4LBFTTcEtUKmjkS28z2XexdEq1uqEmQwlic29oXGB81I1tHfSrHVyE5KLXgcXLaLp/neajz+ozGytO8zor1BLRRohVO9cRVUvC8/BdCyvo0lITA1r+e4LLRoGpwM=;24:T3uywb3BG/RNwXulxYa0HNXuQ/05EOffqAZuzM+EdQIOof65Peo3Z8LtP/o8BSzj/HdIWqFXCCVonLsc4DFsdfFbaoh/afKmkdbd4qoKQ6o=;7:OgShXZzyODZhy4pdFrh+uEEoz/gj8kByqQRjKrlw3bQAFXf1j/cpizqzYvWbDG2YxpflZD9QbJvF13ZOUzfnZXrWtwt+HDNrjr5ZxNd3FsXpXsBhRcMmHu8Ym32/7CD84Pjg/SlD3gzByQdQwW1qECANBHdQN3q8IyuzYdaffTHXqqCMCHI4HVsfvr1riMFsOquLqwYOHsvswYE87cNo5TLijPPsA8kroPaiVjHG2w0kwma7NKTKS8GSN1zu7aFU
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1bb5194-9056-4046-cd03-08d56b307582
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
x-microsoft-antispam-prvs: <BL0PR2101MB10910AACEE36D010334F0AB7FBF80@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(366004)(39860400002)(199004)(189003)(86362001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(102836004)(1076002)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(14454004)(186003)(6486002)(59450400001)(6436002)(53936002)(72206003)(7736002)(316002)(305945005)(99286004)(110136005)(54906003)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: HoGii6hQtCQ5rLgceseNarFca93tM3eRa9uJM2W5poEGe17m8dFr/xZW7Bl9v2cbN4zAmTTI1Od1XUWLPiDxjA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bb5194-9056-4046-cd03-08d56b307582
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:41.5495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Abhijeet Kumar <abhijeet.kumar@intel.com>

[ Upstream commit d070f7c703ef26e3db613f24206823f916272fc6 ]

In skylake platform, we hear a loud pop noise(0 dB) at start of
audio capture power up sequence. This patch removes the pop noise
from the recording by adding a delay before enabling ADC.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/nau8825.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index f9f2737c4ad2..a4871c4adcb0 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -882,6 +882,7 @@ static int nau8825_adc_event(struct snd_soc_dapm_widget=
 *w,
=20
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
+		msleep(125);
 		regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
 			NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
 		break;
--=20
2.11.0
