Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233664-2-16393442522118947028
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233663; b=O2t7Bp3P5I/LH/aRIrhjtDYUVQ19sGbJAhI+czxevoQ18i01+p
    NWEOELUCbNOVp3avV2Re1/LJ0y8EpzaDfuQGCmXb1Wy03z8DBp3buUF9FR39Ka3X
    5rwRsyn8SXF1720PVU31mRQN/78udR4kGJATtOPSOjLa9j3CNc23kypKv70Eg9F9
    GrJ8YZk0PA8ZXy/koD1bQlBAxbOKHVd9NZwnelQX3cIDZ/y6qOB22ZcqUsKSioWh
    gKxLfjX4Was87gSS05dkeSX0bL20pS0+OnrKwDhIGGIuoIzqH/5gl00mvgp+Oxmp
    HK8TXXJomsnHPlJbWMF1QNbh0hwRCQd85DVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233663; bh=33F7UhTrLa
    64sWgI74z8jthpFO+4mb6hizAoLESI2Lg=; b=LnHB5ZO/aWJ4+c5/aUj95ArF6w
    CgjFyQ21e80TfLcXQzPIJRRWZ5SOjzUkT2HL3AVxnnPKWlSjlI5BDOkKPzsvKHEI
    TVdaO4KpLaxTfra/dkDnRhJqoLr9RBx0f9v9CNwLTTQTXp7VsQx1BoZl65v2k+9x
    fGNFWXnl/fbhvqcYytyWiuQXajSizrB2+f+E1pU+VB+j/2vueKAApF/u9qkH6Kl6
    vM4GqypPdMlcKXkU48Tb/D/yOhrsHk3J4i/Wjf9Q6i+iqeTPstMwdY3FukqG9ool
    WmJaS/zZRpFX+UrplGqOU0a/pMhSUIBwVIB7Ss6nLlOBQQhrB3iTXcimp6OQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lJcKo9LD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lJcKo9LD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFTtPn/92knsUpx4hM+oIjFb3ZgEDtdhkU+GK0K/cU0xEh1cORi/aI5g33uo7KRgqDe+2wDMQ2q0NvFo+Oovfl+vaEbLFky9HTslE6xug45A174D7f6a
    ylY1DsKWmOYQJSPCgJUDJNkcTfSQJc3HRnCXTvEmacyagw0ZIUNd0udsvbODKJcQBQBBRY8cBBmr5/ZMfXHcrPa8U2UEbd26CDwC0VBZiPMOXGDXjIwMF8Zl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=uep1uxCoZj0QLMhyj48A:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755636AbeDIA1h (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:27:37 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755602AbeDIA1b (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Stefan Haberland <sth@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 044/293] s390/dasd: fix hanging safe offline
Thread-Topic: [PATCH AUTOSEL for 4.9 044/293] s390/dasd: fix hanging safe
 offline
Thread-Index: AQHTz5j4baBCat6xFkGW1ax+rBeeAw==
Date: Mon, 9 Apr 2018 00:23:24 +0000
Message-ID: <20180409002239.163177-44-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:KpfXdopvo3HhHz/SXEQJbq0SsxxM1sZWC0hAZOl25Z+lt8n5OcPED1BZHYVan6d7HP8gl2S+DQP0jmV4Wkp9DC7JFbbOGz1hIiHAVSnwbL5xx9WQgfUiub6rsGWE9jocBhFuH202D45k465W1nAuu++WaCCuj8ju6WquuHfic6dpVq5LeHLFliE3B2acuSx3p/xFxTh4yMYcx+bX9rgIeBwm7zAZg8Vii9pqrvxjtwk0lpSrb1JXUP/SNh//rjZS;20:X6O54qD95BKSEiz3sL/absWhkFtV4MEBZqWdQS+zO7MFGiGtlYYPE8tCxtaII/7R+hBFWQZoWJ6aeVJvSpoLse/2kp77zLS0NaDknfcGwrnF3ySU3cWFD2az335UN3BtdiSgDaK8/ouRmUB0sPfkGf89cnMPK+vr2vYy4OLdZ1c=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32a00091-88ba-4e6c-23d9-08d59db0ab2a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031F3B7613BB9D775F16E2CFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(43544003)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: jJm9bfsP6gW+5W7yu8B+ESiZCSd0yCHSy63Ae43qv0cwycy6eThZoL+WZ30MYkPBmsqf7BhYDi1fIZZx9HzBx790+R+YThm+qGx07ExR44ZV1FkULFqUrNZhlwEIdPJsQayuv2p9mSia0INxIO122cZO+hpPEp3aAHtA+iiA82dMG9UIjZ0uHrBSNSxKMA0FDmG5X2AvkFYZU2cGiU4X0rW/lzrv7Ps5GwncYP2wfaaTGdHumi38/abR6KJk+MjenpUYOExvGWcOMs57SBUEUiuk91x40c8Uty1HiYWM6J7g2x35Eij7mWjvxdmZ0T5BuB/AQgV90jBKNzslVzybmTgYmu3QNpnCqgugsLp/JMzFsa7Bmdko+1HomHQIOIP+lyAqv0FkvIYfeMoD31mMK7vKss2Yhf6KNwXv1p7xXrI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a00091-88ba-4e6c-23d9-08d59db0ab2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:24.1748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stefan Haberland <sth@linux.vnet.ibm.com>

[ Upstream commit e8ac01555d9e464249e8bb122337d6d6e5589ccc ]

The safe offline processing may hang forever because it waits for I/O
which can not be started because of the offline flag that prevents new
I/O from being started.

Allow I/O to be started during safe offline processing because in this
special case we take care that the queues are empty before throwing away
the device.

Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/s390/block/dasd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 5ecd40884f01..0da246505f70 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1950,8 +1950,12 @@ static int __dasd_device_is_unusable(struct dasd_dev=
ice *device,
 {
 	int mask =3D ~(DASD_STOPPED_DC_WAIT | DASD_UNRESUMED_PM);
=20
-	if (test_bit(DASD_FLAG_OFFLINE, &device->flags)) {
-		/* dasd is being set offline. */
+	if (test_bit(DASD_FLAG_OFFLINE, &device->flags) &&
+	    !test_bit(DASD_FLAG_SAFE_OFFLINE_RUNNING, &device->flags)) {
+		/*
+		 * dasd is being set offline
+		 * but it is no safe offline where we have to allow I/O
+		 */
 		return 1;
 	}
 	if (device->stopped) {
--=20
2.15.1
