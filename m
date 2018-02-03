Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681015-2-4456745164799968445
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681014; b=dUdlHylNhjh8tmUdW6BQHr/Iz0FKJDLQjV8k1044eEhtRMp
    S83S57tkQ3bTTd2to7KLVrdT92DV5rkV7ZIibbC2t/87AsZ6SmfDIO4XxTpatFuz
    ndhqpjmIvN2qNcM0eXEM/yUk8CN+GGITUHJQPkhISc3n5I+NThaybUhY/Ukq1Gqs
    umhJlAgLT3YUhGoZ/+fUelkqAHYEkRjYPbVwpWhslyIhvhy97/vyPnNIQ1PBIbk2
    bEEDQpcyjPYrZS4SRTI/dfw37oF6U1WrUOHYcNAfDglf6m5iFmel/giRqHXgo1+s
    Hqa/jmRlB/s4vgxeEdMZ7YaytQk9sCc22EBGbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681014; bh=Uy6pEv
    IFO5lDSOY5o1H1u3sKBdpcZQrJ722PLL84Jq0=; b=ddPw5p10IINECpvhboGyWl
    PQkCQTl/X9Qt3dVRpEGU0zSXppU0vJv8PKhzSpHuxeZ68GedvQO62tEqaTZvzFNR
    CFVyGNfskF9I56mJPSdytp/Q4gHc0zTVSlLcFKqvwMfUXjCXeEy40E6K++PaeIm7
    teysnwPdmrdUWlM4cHGutD2Cktmd/1SzLwFpXrE4eZoBT0o9CA/wKLKCKGhMZgqP
    hLXLy/4KjVKP2CBdFaiwb/ZEnZ5F5uGWFf74mMuGGZLQ7RVZ93XkwLHtZwJSwna8
    b/r95Inn/7wUUNtdd8SPFiRuF0KHZFrnAhADF6F39QJnKkAqjikKXdli6KFLVMjg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kRMS4gue x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kRMS4gue x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeBCSD0 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:03:26 -0500
Received: from mail-dm3nam03on0129.outbound.protection.outlook.com ([104.47.41.129]:34880
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753006AbeBCSB7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 044/110] ASoC: rsnd: fixup ADG register mask
Thread-Topic: [PATCH AUTOSEL for 4.14 044/110] ASoC: rsnd: fixup ADG register
 mask
Thread-Index: AQHTnRjsyGlOT51Da06iE8BpIBZZkQ==
Date: Sat, 3 Feb 2018 18:00:49 +0000
Message-ID: <20180203180015.29073-44-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:psK2IlKZ4oYSc8zC/ESjfnw5+k2gAe26P1sSZDNY/o50SSW7SGTJb2/xzPx1sONVsYsJq9caivfEHMSR8vDBKcpBkAyPMWDpC97nIP6vpfEDE2v7i6SHwFDYB8QtwcFHyKXMUlYoqZgCDQ6K91M31apVpUE0naOBLXmJqVo+Ke4Ak8zodpIviZGgxaie3ZDMqBB1Tog2Cpf5vI60BafYSdCFc5AR63GrxU+PdOyukUD5wx4liWuI9SMfxSzkZgCK
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51634185-ff13-471d-5197-08d56b30236a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB109285E4674B2DBF92E79E78FBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(6506007)(76176011)(6346003)(10090500001)(575784001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: vNpN1VsxxEtsX8Wlcwm1TgZKqRYeGJriydwhLDSTK2L4Uhjhn848pI2OyUdRiYAna71vhblJxArPX0sDU4V3KQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51634185-ff13-471d-5197-08d56b30236a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:49.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit d5aa24825da5711f8cb829f873160ddf1a29b19c ]

BRGCKR should use 0x80770000, instead of 0x80FF0000.

R-Car Gen2 xxx_TIMSEL should use 0x0F1F,
R-Car Gen3 xxx_TIMSEL should use 0x1F1F.
Here, Gen3 doesn't support AVD, thus, both case can use 0x0F1F.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/sh/rcar/adg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 938baff86ef2..2684a2ba33cd 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -216,7 +216,7 @@ int rsnd_adg_set_cmd_timsel_gen2(struct rsnd_mod *cmd_m=
od,
 				   NULL, &val, NULL);
=20
 	val  =3D val	<< shift;
-	mask =3D 0xffff	<< shift;
+	mask =3D 0x0f1f	<< shift;
=20
 	rsnd_mod_bset(adg_mod, CMDOUT_TIMSEL, mask, val);
=20
@@ -244,7 +244,7 @@ int rsnd_adg_set_src_timesel_gen2(struct rsnd_mod *src_=
mod,
=20
 	in   =3D in	<< shift;
 	out  =3D out	<< shift;
-	mask =3D 0xffff	<< shift;
+	mask =3D 0x0f1f	<< shift;
=20
 	switch (id / 2) {
 	case 0:
@@ -374,7 +374,7 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod=
, unsigned int rate)
 			ckr =3D 0x80000000;
 	}
=20
-	rsnd_mod_bset(adg_mod, BRGCKR, 0x80FF0000, adg->ckr | ckr);
+	rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr | ckr);
 	rsnd_mod_write(adg_mod, BRRA,  adg->rbga);
 	rsnd_mod_write(adg_mod, BRRB,  adg->rbgb);
=20
--=20
2.11.0
