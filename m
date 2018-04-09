Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236621-2-1676511984984242533
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
    1523236621; b=djhogowCCbNKWxqgD33PqwYEBZT8BLrp8vNT0wtB0J455WE3Sk
    u6//4+Kas2q29diIm2w/7vTPeZugBpcEw2wrtZXBrlnvFlz4rgjrFccp6SzNgsjH
    YwxhdyqoFAD2SD9tKW1ZS4p1uFbgfqY9O2cjjCOVrMBdfrJ+s30+5Cq5sZLdjHQB
    U1ZUEFJ/TFw6h98vBqzHk60NlVtDSieZqKCvOZfisL8AzVKtUJsMBhFdlNHXjwhD
    6Ey/fiYnZ7P+Lx5CYhG+HuxsscNG44oWTerKzDZp2X6f5yXeWKUi9Nv2C5IwjYzR
    uGqq9fZSCVT3m7saQKRwg1nhFRs2TMdp+PCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236621; bh=c8+/r+pD+9
    a5kiQbSCvrJ+H/zMVyve8q4gS9Jy4WSvE=; b=l/yCy23A7/dU7MgYZDjzzCmpJf
    qdjcEaWjRhZUfQ1XWu5eJeLxFGPxbl9Gd1f740bZ8dBnlugnGE5EUcLxYvf8ai85
    4UhR+vGQq9kg8ZdLomMYQJ/BCGeV+/tSssgKEj+0sJvTb0EMCPICiGGvvfupOxXc
    8Qo70jeJmbNdgKXlT0DfNzYFvvMCQJ5hAQj2gpQp8tYwhVWhrM8vC6cnJ3WLvHq3
    XiRxZjQsbEGxlySIhA2LBPFImAkUvQqbNnSq9H63M41QV7hH0ZDXOQ/ODvL1D0Ak
    gPSx2ZkX8USNcheENOwRdzHpVCvwNNsVjUwHSqThcGJfo1vZxSfiP1KXRvRg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZFGMzxdI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZFGMzxdI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFGeiQivN2462ArU8Uwq+pCU6eGGseWbRiJh+Q5yfDrGrN2engB7a+VaV/cwCUoCHi3duumR12/YgvEm+zXg6JNBAUlhUE2fG4pxIIziRh8hNlvJUelq
    kamkNrY37nMr1y87ROS32kaNnLuhp+vjpCw9E3CLdqANLkkQZ3KAk0/yh/sMey/Zpqi/ccHsl7Av3iYCc/m+D4+FI9aKZbNE9nag2MXvF+4UrsXu3MYdYM20
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=TCZwIYwWp4WjhJQ2Fw4A:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeDIBQq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:16:46 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:3232
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932860AbeDIAhw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 108/162] ASoC: au1x: Fix timeout tests in
 au1xac97c_ac97_read()
Thread-Topic: [PATCH AUTOSEL for 4.4 108/162] ASoC: au1x: Fix timeout tests in
 au1xac97c_ac97_read()
Thread-Index: AQHTz5nE7B387SrFtkiiP1fYLFcQvQ==
Date: Mon, 9 Apr 2018 00:29:06 +0000
Message-ID: <20180409002738.163941-108-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:0SNvKYfg2ffYHtm8T5cs6UzIhymZaod4ORahgsXqLNRxDWq1kfwXNPGUwI0lwPFXH3RCWOThdzYJW7Vmd4vzKAMxWv6tnqhFhzPCeNmwUqjfrn2t71IP2NC2cDZUoiUOZJZMMtZl5azrc9Mx1g4EpKiLsVxWOAX0wRKF+Jc49XIfK6A/JiAndDgV/Z1JdPY+adOkp/xgZqbQmvslZNRW2x2TZBkiiTC20wa4uwoi9X7fZBU7A+O8B7i/tycA3zEW;20:97SC4DY1eynDXFmqEkU987hq+luCQp8eoxaGFQ0Gs16Hc6CHwN4H37+bUJnG/q195rpPj7FUfzj1L3dYicktdunGwAK0ADlljQnI0cLxSGMm/hDMZmdghR+KcXLk4G6mrG+SlByDX2l17SbzqiUmUG2WmAOctHnLD9n61IPVRgY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbccc602-2d28-48e2-7e81-08d59db21e6a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110331EEBE5525FCB9FFFB6FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(15760500003)(186003)(5250100002)(105586002)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: PCkyhaCbwtEEAft6gdxNIT5RmYsr8X/oAC2fgBETnthx8Cw2didn+hwC/XWH+xF8PHgwe/B7VaXuxgXplbBXBNN2uJsG43f43qhsOcdWDLyAOKEn6FRLD/ranumAF4oy1gIJMFiYLfDFSvP9pV7pFrh/aNlNb1fn17L9IP/47pkdwxm246y5hpV83o8tNWfZjqTKA33j5/dNUBmMk8vRMDKn1zTzdgrijdXUJ/wSX5K9zBAkU3x2JvllfkwJkpI2G9oYOlm5XCitiKHEeggVqoEBkVVYaIChY30OU2UG/vlKxyx0E9I3yOCIxjtVJOePSfBAXbm+BgTI8X8FeUHpVxb+3ovK2UX7kiXIaSyDAEY9+5A//Syn+vEwWBYhwo0ukj1c6DOzt7HGKWjoCz/YrroPIU43uAmu+RflZ4RfXWg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbccc602-2d28-48e2-7e81-08d59db21e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:06.5210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 123af9043e93cb6f235207d260d50f832cdb5439 ]

The loop timeout doesn't work because it's a post op and ends with "tmo"
set to -1.  I changed it from a post-op to a pre-op and I changed the
initial the starting value from 5 to 6 so we still iterate 5 times.  I
left the other as it was because it's a large number.

Fixes: b3c70c9ea62a ("ASoC: Alchemy AC97C/I2SC audio support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/au1x/ac97c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index 29a97d52e8ad..66d6c52e7761 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -91,8 +91,8 @@ static unsigned short au1xac97c_ac97_read(struct snd_ac97=
 *ac97,
 	do {
 		mutex_lock(&ctx->lock);
=20
-		tmo =3D 5;
-		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+		tmo =3D 6;
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && --tmo)
 			udelay(21);	/* wait an ac97 frame time */
 		if (!tmo) {
 			pr_debug("ac97rd timeout #1\n");
@@ -105,7 +105,7 @@ static unsigned short au1xac97c_ac97_read(struct snd_ac=
97 *ac97,
 		 * poll, Forrest, poll...
 		 */
 		tmo =3D 0x10000;
-		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && --tmo)
 			asm volatile ("nop");
 		data =3D RD(ctx, AC97_CMDRESP);
=20
--=20
2.15.1
