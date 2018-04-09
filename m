Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237535-2-16977572404165008803
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
    1523237535; b=JOdzcLKJO5fp/IsiG82p0AmRiOQ4QKBhW6a9o0jGA3UZv0mEnU
    UmbIsDHoyObnDrSd3xk3xkxnlEZEp4aXZTWlIeYhxbnLZBgzc0Lm6RE//8bpfImZ
    ftwPZiIZJ+9HhhzORxf0ZfehtlqrqcfhSQbP8jIFEoxSgKM07l2huwpng5cTnutb
    VlVPy1cfMxPXtqMktubNk2vDLwQeE/UBZo9cdRAxYVVP0u1aZsLZEJhR9NYA9D82
    ZABoGbAOIpcCk2WugH9L+6C5zZt3JYCj5wDFC+S6CTeP+OnhNMUwBxtqtc3QJuz7
    3K10Qj8UY3LYqYZ6tIpJmsdCxgMEZzKMQi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237535; bh=LhgDMcyASg
    oIhIh9f9KMXBuv0pcPadmFb0LXuTcs7/Q=; b=CpGNNZ9tOxp8GIrbZnYIGSLKV6
    OGtLthxkq3j5+wAcNThrVdadEdiBzwRglLY8xyR1/do22FMi/BxSa8FgmO0yBHdL
    5opS9Mc+t+4V6SF0EvxXXs49iZQeyYiZTD5T8+RWy1zwyjH6VrFUJgsXv0A8GOvP
    cYdOnW+vI3wdYcoh7gQ6sdYCO4XBlsQA2XENevkzr65OmFg3DRdJnIWfsEAm9tYU
    LvO6iSsHUTXPc4AbA87unnPBv7JBkgHXXFekOeiSfXHFMfxxyxxyu5s2XxsvdJQn
    yta1Mb8aePTM3ShHTWk1bf+oTmuIPZRBzwMpu7HGIBv+ANzI12go2AwevYMA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wf42+jCW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wf42+jCW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHKosPkeFGT3dHUN/kWD9dgukrfuP3u4I/6jeUvwfH0dj4sRoLyWybxaDgjppO6UM32/qcAdo+iuy9Qugw/7XdWa7J2VMr04XZwysXUtm8TIlQnbiP6i
    oTaZhpKTP4/eHv89IRuS7p33FSYwgMtAfmSettn9D4oWn76wW90+utnMzkvMjQ+wPy2U3PaO8U3adBWVR2QkgzgLpaN3shlgVP4C1k1NIUj//2RBdgFtv9z3
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=t7UcQ3b8EIM5L76Z2osA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932693AbeDIBbe (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:31:34 -0400
Received: from mail-sn1nam02on0132.outbound.protection.outlook.com ([104.47.36.132]:23728
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756608AbeDIAfw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jean Delvare <jdelvare@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 039/162] firmware: dmi_scan: Look for SMBIOS 3
 entry point first
Thread-Topic: [PATCH AUTOSEL for 4.4 039/162] firmware: dmi_scan: Look for
 SMBIOS 3 entry point first
Thread-Index: AQHTz5mj22jjL0ZvXEudKeYVveElPw==
Date: Mon, 9 Apr 2018 00:28:11 +0000
Message-ID: <20180409002738.163941-39-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:kFs05iw6Ks0JJSIO3lmAO64kFH1i4ecrvVLwvR8fbRJUoR2gYErGFCd+SJMkRg07GeYfmCAMP3ofrt0c1jpq/xM3FX5OK9yOWwf2S3sddZARyDjbkhS+ZlKBqTDVOsggWzUnzxN8yWlbT/cV7jejM36sMNAg6Me8c4uq6YaTTNE+VjqgDSa6w7Ll7EuFo8gQaFMDeUNEM+LEc03X4ehU6gjEy80btMXCgHg1UYCTHnbGKTFgeVBbD3eJjmefk1ha;20:6qDBTsZhCAbGVvwQLUODEMmV3x86zru7SXHeoL/kRififbjB8hSR2isyiAiN2S03exRb8eKs6ZwNw6MK2DSZppnQmv44yx3xW5NLfX+YL82BwplGOgJclW5GYD4LdU8ijjCW0UThi3v7g8CGsJki7+2+fYazmVypwXqClNoC+nw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: cdaca739-6a9d-4923-ad3a-08d59db1d7e0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07252C3D9D0101854622E9EEFBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: V1qW7pQIwOvEHqgqgnjPNQXdB8Ljywust7/20vUliDuT/EVkgE7u0/WXNXJzVDCztehAozSx9G4iogru7+2Egzy7Tnazsrnw22OtoQ6zRUVPnPBC4Z3Qz+1pdTcAC24Eh1mqeF3T5WAbxFlrTQEo1R5YI3s8uKdu5/wH4KANWBYZVqFyGBbEbhssK6ywHGQCur+ajvR1sOr+d4CbfDC6PeaZ2V3tfMUkKqGuNxOpnD0iFkgwhf6es8Ft1MTRVptjENi2u/xSB1L2Wjlgu8LaP9SylSTKiV0muuiDJkS2oQ8C91nq2Awakx6DM5zKsRuzHzbw4310kFTpctfbr1DiyodfuZavk129Ov71vyBvLpbLZXnDV1TXjlibnptgS0c+olm7lSS68r6VyMNuJRyVAngxvjZPwTleL91hnL8jK04=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaca739-6a9d-4923-ad3a-08d59db1d7e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:11.1455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jean Delvare <jdelvare@suse.de>

[ Upstream commit c9aba14362a6eec583819ec8f4b872c1816f5cbe ]

Since version 3.0.0 of the SMBIOS specification, there can be
multiple entry points in memory, pointing to one or two DMI tables.
If both a 32-bit ("_SM_") entry point and a 64-bit ("_SM3_") entry
point are present, the specification requires that the latter points
to a table which is a super-set of the table pointed to by the
former. Therefore we should give preference to the 64-bit ("_SM3_")
entry point.

However, currently the code is picking the first valid entry point
it finds. Per specification, we should look for a 64-bit ("_SM3_")
entry point first, and if we can't find any, look for a 32-bit
("_SM_" or "_DMI_") entry point. Modify the code to do that.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/firmware/dmi_scan.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 0e08e665f715..f1d4881dd2fc 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -626,6 +626,21 @@ void __init dmi_scan_machine(void)
 		if (p =3D=3D NULL)
 			goto error;
=20
+		/*
+		 * Same logic as above, look for a 64-bit entry point
+		 * first, and if not found, fall back to 32-bit entry point.
+		 */
+		memcpy_fromio(buf, p, 16);
+		for (q =3D p + 16; q < p + 0x10000; q +=3D 16) {
+			memcpy_fromio(buf + 16, q, 16);
+			if (!dmi_smbios3_present(buf)) {
+				dmi_available =3D 1;
+				dmi_early_unmap(p, 0x10000);
+				goto out;
+			}
+			memcpy(buf, buf + 16, 16);
+		}
+
 		/*
 		 * Iterate over all possible DMI header addresses q.
 		 * Maintain the 32 bytes around q in buf.  On the
@@ -636,7 +651,7 @@ void __init dmi_scan_machine(void)
 		memset(buf, 0, 16);
 		for (q =3D p; q < p + 0x10000; q +=3D 16) {
 			memcpy_fromio(buf + 16, q, 16);
-			if (!dmi_smbios3_present(buf) || !dmi_present(buf)) {
+			if (!dmi_present(buf)) {
 				dmi_available =3D 1;
 				dmi_early_unmap(p, 0x10000);
 				goto out;
--=20
2.15.1
