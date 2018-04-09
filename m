Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243657-2-3494731914925487393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243657; b=XS2YF/XTnZeAqBto3Tkwwy1Lcl/eTkBFTEyDDEuJckc8uhS0fk
    A3aYJYLIlPbNI5/tUTSOLnzPoTmFSSNUtX/DtR/rSOVdKERt4KJ09J6u5jVW/a2y
    94N6tTZsDdhUmVpug5fHYcD5vEH7XVHt0TCmzRbVFUFtenslhd4whV8eZWq10vzN
    iGd/Y+PwW+5Ctlz9xZlalCgqvNIqevFiKlT4AKrXeijbHYNRdPJt5ksn25nzd3MM
    fj5XJYRJgPoHEFCjtnN3wGAbO7vncls/jC3P5JgGFzvInuDCI1tVfKuHGkrmjZAt
    eYUH3yM5GJRoxCapexuzG+DVfoUQmEBcyHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243657; bh=pYWKt32cm2
    9WzImpo06kYtmxh8E07mv3PmM1qLwsHFE=; b=OSKh9seeXus/W2GiaTEFtl5Mdd
    U7Eu3B7HuIJKvsQbYS7MtT7QaYUyPvXM2NhLQfMDU1pAlcdLemOWMk31t91hHdA0
    +giwoMsDVt3rTP9XfsN+GvtpH7K1No0i3n8+lakVQRRJAgfP4eC/lCekB4D8ROaB
    48q7HV74iSW/kmmhMF8ycNWd+hGs9GtrRzdXXOgzpyJtLinkJRuqQbdV8OwaLROF
    8jfWfC2zwirgqOAMOrk5bo8NhpGI/6zLgycDj0hHCs+Fk1nvMZWlOSrxkIcvAUTd
    tT6VIPNiMlC+BDI9+q98FEi0rXtioUhTa9wqrwEhaTzFYF1BIZXKsR3kJHfw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fYE8YpNw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fYE8YpNw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPKsxu96pkr0GYiEAdz7C3BuI1VcDGVfZLA+vpZNL77WROuTCk5UoqgcG5g9SD+zO4U6E74jSA21NPad0tydMkP3UKsAZhlUokDpvLTYEwJYGluXDHTo
    +YcpRS+yfTRCVVSY/uXZF4wz3oOwXgJ+kq42kiCjepVUPozaZdIdmAuFchwlUNIBzm/mjRBsARXnS0TlaBYrMNd3k+tzu6iVAoMWJcPBMhNBOG/KVYHIaUED
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=s8YR1HE3AAAA:8 a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=dOWJWV5Flkr-bMFZBqYA:9 a=wPNLvfGTeEIA:10
    a=jGH_LyMDp9YhSvY-UuyI:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeDIDN5 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:13:57 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754947AbeDIAXu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 071/161] ASoC: rockchip: Use dummy_dai for
 rt5514 dsp dailink
Thread-Topic: [PATCH AUTOSEL for 4.14 071/161] ASoC: rockchip: Use dummy_dai
 for rt5514 dsp dailink
Thread-Index: AQHTz5iZ8tg2VOe/dE6Uq93DXbxxeA==
Date: Mon, 9 Apr 2018 00:20:44 +0000
Message-ID: <20180409001936.162706-71-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:NX03Mag7FsL1PmLD9ORbAbmNm9mHAO+pslEzGP/pdU/swwvc4kAisK/qluIhm1s3St3rIkLQJRxW7lxb3iI1GMCD/fUxd9VZhGWGbFI765PR5QJVC+zvnsvULtQVrs3fBod+nOCxzKj0rEEditZmy+zGWG3JoKhZiR62ajc/Bf+UtwpQ82TazqUmtdSHh7hO28pPoIZN4J6aYmBIXAmRu+ff0hWJ+B/qW5aOEmMnNZYCFAUCWcjMScOm6Iw6r83t;20:AfjxbN0T/qaYgOLoYagJfKBgY6Ei2bhDQ+SHP4HjkpXb1ebGLmyzW8pCTnF135p1++bhNDNoo/4lpF/X/thlRaou+koRNNU/IKAlx3FXaSdrFLd0YxsNVqtK3o/a0nsjpcGYzvsU7eLuubgF7WbSioN5oOuKAGJ87HVElu/FPeM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2dd8053d-e3c2-4503-50c9-08d59db028e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080C7CB729D957D9002C6BDFBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(575784001)(76176011)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jPVmWaQM/pnbQOKqVxGijE5BFG22xsNGlytXsSWcC6L0qExt5Td0CzXkyP88J6bDnyBaHB4U8aybd4KY38GrO2mWbCKz/xaRtv2rp4XPn1kpZt5YPosKDSkhuiUYj90TdI1UxxR8yPTMxgz1unyFrV+SgGY9nY9c/RdoQ+bc2I5oqMuwXX+ZiMhIKVDCxsfGEeOWXgBlMjRc32Jk1WZts7Sxt63Eu7vd3+evPbyyFS2H0TZf2v/mIY6YZVULXUPbWDe2PH7RYnPbTvb4hJHkUGEDnMXYiY0JyrynwtAcj1TkZ0haCavY+UayAZoKGJISBeJILyIBTFv/4IBuF7pb29g04D9kA/KKuz5x3qIPZKq2JHaILujzn1IwIYZE7Md2JtFR4HAvZhz1gqNdsIhl2xqH2uhtA5TqX2aaxTSjP4k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd8053d-e3c2-4503-50c9-08d59db028e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:44.0660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeffy Chen <jeffy.chen@rock-chips.com>

[ Upstream commit fde7f9dbc71365230eeb8c8ea97ce9b552c8e5bd ]

The rt5514 dsp captures pcm data through spi directly, so we should not
use rockchip-i2s as it's cpu dai like other codecs.

Use dummy_dai for rt5514 dsp dailink to make voice wakeup work again.

Reported-by: Jimmy Cheng-Yi Chiang <cychiang@google.com>
Fixes: (72cfb0f20c75 ASoC: rockchip: Use codec of_node and dai_name for rt5=
514 dsp)
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Tested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3=
399_gru_sound.c
index 0513fe480353..21ac8d6cce3a 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -387,7 +387,8 @@ static const struct snd_soc_dai_link rockchip_dais[] =
=3D {
 	[DAILINK_RT5514_DSP] =3D {
 		.name =3D "RT5514 DSP",
 		.stream_name =3D "Wake on Voice",
-		.codec_dai_name =3D "rt5514-dsp-cpu-dai",
+		.codec_name =3D "snd-soc-dummy",
+		.codec_dai_name =3D "snd-soc-dummy-dai",
 	},
 };
=20
@@ -432,7 +433,18 @@ static int rockchip_sound_of_parse_dais(struct device =
*dev,
 		if (index < 0)
 			continue;
=20
-		np_cpu =3D (index =3D=3D DAILINK_CDNDP) ? np_cpu1 : np_cpu0;
+		switch (index) {
+		case DAILINK_CDNDP:
+			np_cpu =3D np_cpu1;
+			break;
+		case DAILINK_RT5514_DSP:
+			np_cpu =3D np_codec;
+			break;
+		default:
+			np_cpu =3D np_cpu0;
+			break;
+		}
+
 		if (!np_cpu) {
 			dev_err(dev, "Missing 'rockchip,cpu' for %s\n",
 				rockchip_dais[index].name);
@@ -442,7 +454,8 @@ static int rockchip_sound_of_parse_dais(struct device *=
dev,
 		dai =3D &card->dai_link[card->num_links++];
 		*dai =3D rockchip_dais[index];
=20
-		dai->codec_of_node =3D np_codec;
+		if (!dai->codec_name)
+			dai->codec_of_node =3D np_codec;
 		dai->platform_of_node =3D np_cpu;
 		dai->cpu_of_node =3D np_cpu;
 	}
--=20
2.15.1
