Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240199-2-317768443681080205
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
    1523240198; b=R40jTgkUhmB0IK3LJDbvDuw13bgRoMhotRIt3+FHkTVtm0bNYZ
    oD14BcKrNq+zfoGUwYM9UnHaVJaMseaHKEKlQ/23FWHYPQdFVEVOKEE/nsV1DUIY
    sohKPQPOajQcfsAutXigTJHqPEoLL3OiYZQzJCjf+FM5DjzkKDxeMgy2IwffG/AK
    p9R5belm6fwczvwbkI0FqP0MOcDL8IjsT7K9MC96MLGqdxGEy0kEUPGNYVeCdshD
    WCYuCpy+4ztr6Tok0xciR8JbgjTwAYPTVfSZjKHCC6mZsuMZ9f9vYepZoEKS/cfR
    nRPbjWc+rjdwLMWV0nxtx26QAsiwljcJ8ViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240198; bh=hIuzdwoX62
    3vBV2hcw2yQwELBT9grYXWIKjk2orQQlM=; b=W3uiHwa+B/4r2v3+SrQCcGUP36
    6c+BqxP4t/kDamsdpzvFwIjSklv+llBhNjcuEZ5OmmN80IGG0FiiKThzIZj2ulnh
    wuHJ6ejO7gsfH1lHqFpazJ0qud6L5tBX6LTOkz0y9cW+kaT7oBqnCymKVqkriyc7
    cJlHhbs8ZPlIb7WpQLtk607FGVtc+M8SENAetjtyVDKmNVnCWFR1DIw3aPGWsSFH
    CHZVcssV8jfITvr30EDBkj+kKOyWL1XVCOM/P/27Ga85hdonDGLU8bgSx7cqEjn/
    1Ko9xY6iO8IDEHiYLeMQy0rgXEoOx3s+tFIpkzUsOwzD99jhceHsa0fUtstg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZRWD33Wj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZRWD33Wj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA5Zb2hYILYRdCMHBINKJOuQZg9KBBbJSKYrlvH3t0AKA4+IiplHYxVXVT+rfA4/TapIs15K0KcZmQkxchSvo8DRamlPViv3+nTo1hQPU157LNVlNMpo
    spuiNS5hTLc5qqHdqiXks6vKv19QRQKZHLpFTuvT46hN6ZFd2LmmfDpIckxJ/lwIF8j5FUyBYXhNjtEu+alTxAvsgRDBsp9lyH9kcXqRJw0Uf5Ej4MfsUWxx
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=BxgfbMJPAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=2xX3KNe6OE4n46X_9UkA:9 a=wPNLvfGTeEIA:10
    a=-j4ASRGczZqhCHD74e4j:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756089AbeDIAae (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:30:34 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:17478
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756080AbeDIAa2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: John Hsu <supercraig0719@gmail.com>, John Hsu <KCHSU0@nuvoton.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 134/293] ASoC: nau8825: fix jack type
 detection issue after resume
Thread-Topic: [PATCH AUTOSEL for 4.9 134/293] ASoC: nau8825: fix jack type
 detection issue after resume
Thread-Index: AQHTz5kkWQ3I7JwLFkyqfkLhZpSplA==
Date: Mon, 9 Apr 2018 00:24:37 +0000
Message-ID: <20180409002239.163177-134-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:Z2IzJa2L1JGgvkkqqBYmYb7gGtnaSsH76GlR3WyEqbevC7a+iZ9ZG0/cercMkCUej/A1ywSAw/EgQ8szPnDcsHCo1uXz/foucSPSFwh3h2S7ZvynyjTJKtXGmhUC+0ApmccwVgBR4Sx9BxoybcYyMtN6pL54C/4B9mlr/CH9N72mUOF07dD0qf3ZH3Ru2SGW5Gv0sm5/ip/DxnjziYBkMjT6vMsyYGqVsKRR9yUR3Phe9yN3mWWKPvkDZzuUapKN;20:iq4GOFTUpnOlfLpcYUxhz2uNMuyQ6Nshdd5KkQqVD3kBwcJhXPAmQkD2V4jcwI2GHPE70wfSLIsWJ4OvfDI4rvr/p+Khwc+zYrY66Fr/DpVfv+nmQLMvYUgoXu81FL7fCFMX+wyqiEvHZqIrLZEO89B0JqLyZlF8/6Ex/7xh5v0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76c6050f-ff8f-47bd-aa85-08d59db11521
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08077317033DE9B62D4D4886FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(39060400002)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gmRL3ST5/4tUKBvmN5g/1MAErftqSqGYd5QHzjAVQgiwBSPgxlKgRWOw++Zan5MgE0zPSNL7wBxKh2qcLz1W8lmtb4IiqV8/l9sPiKisKclaOL40LGVVZLCUVyCRrauDW+fAXfbYvA6Phtq6TndOpmO8hTCRFZQ+4Kb5VJguNkcN06PFdVWRAoVYgrIjsZZdjabE/Jn+i0WDZeqx0Ts+N+DXk/JkvbZlQdkG7DON2f9GhVfbiwXriA0czBMge1AUOgTtqS8SVb3k2RQAAPxhfm0WzAyIhnFmoyzDleu478dQc7gRvBSFUvEYN5cTXrO9QuLcJor2BlBKvtEqkNpIGLQNGiNtnQFy38Vvm8jt5zJVUC55TZ1haYGGsTzrFmBwyrnnD6pNwtRZusfM4bvrdmVDDIjcaC/QDeBTELAQWw4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c6050f-ff8f-47bd-aa85-08d59db11521
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:37.4250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John Hsu <supercraig0719@gmail.com>

[ Upstream commit 8fe19795da1b9dea2353f016622842a2f163039e ]

Fix the issue that mic type detection error after resume.
The microphone type detection procedure will recognize
testing signal on JKSLV pin, but before the procedure,
JKSLV already had supply voltage, that results in the failure.
Therefore, the patch turns off the power and reset the jack type
configuration before suspend. Then redo the jack detection
procedure after resume.

The patch help to fix the issue as follows:
Google issue 37973093: CTIA/OMTP jack type detection failure after resume
Reported Issue
Chrome OS Version  :  ChromeOS R59-9460.13.0
Type of hardware   :  DVT sample

What steps will reproduce the problem?
(1 Play a music
(2 Insert a headphones
(3 Close laptop lid 3 sec then open it
What is the expected output?
The music is normal in the headphones.
What do you see instead?
Singer voice in the music is not clear.

How frequently does this problem reproduce?
Always

What is the impact to the user, and is there a workaround?
If so, what is it?
Re-insert the headset or close the laptop lid and
then open it again can be repaired.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/nau8825.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index a4871c4adcb0..1285923650fc 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1523,7 +1523,6 @@ static int nau8825_jack_insert(struct nau8825 *nau882=
5)
 		snd_soc_dapm_sync(dapm);
 		break;
 	case 2:
-	case 3:
 		dev_dbg(nau8825->dev, "CTIA (micgnd2) mic connected\n");
 		type =3D SND_JACK_HEADSET;
=20
@@ -1543,6 +1542,11 @@ static int nau8825_jack_insert(struct nau8825 *nau88=
25)
 		snd_soc_dapm_force_enable_pin(dapm, "SAR");
 		snd_soc_dapm_sync(dapm);
 		break;
+	case 3:
+		/* detect error case */
+		dev_err(nau8825->dev, "detection error; disable mic function\n");
+		type =3D SND_JACK_HEADPHONE;
+		break;
 	}
=20
 	/* Leaving HPOL/R grounded after jack insert by default. They will be
@@ -2203,6 +2207,13 @@ static int nau8825_set_bias_level(struct snd_soc_cod=
ec *codec,
 		break;
=20
 	case SND_SOC_BIAS_OFF:
+		/* Reset the configuration of jack type for detection */
+		/* Detach 2kOhm Resistors from MICBIAS to MICGND1/2 */
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_MIC_BIAS,
+			NAU8825_MICBIAS_JKSLV | NAU8825_MICBIAS_JKR2, 0);
+		/* ground HPL/HPR, MICGRND1/2 */
+		regmap_update_bits(nau8825->regmap,
+			NAU8825_REG_HSD_CTRL, 0xf, 0xf);
 		/* Cancel and reset cross talk detection funciton */
 		nau8825_xtalk_cancel(nau8825);
 		/* Turn off all interruptions before system shutdown. Keep the
@@ -2226,6 +2237,10 @@ static int __maybe_unused nau8825_suspend(struct snd=
_soc_codec *codec)
=20
 	disable_irq(nau8825->irq);
 	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
+	/* Power down codec power; don't suppoet button wakeup */
+	snd_soc_dapm_disable_pin(nau8825->dapm, "SAR");
+	snd_soc_dapm_disable_pin(nau8825->dapm, "MICBIAS");
+	snd_soc_dapm_sync(nau8825->dapm);
 	regcache_cache_only(nau8825->regmap, true);
 	regcache_mark_dirty(nau8825->regmap);
=20
--=20
2.15.1
