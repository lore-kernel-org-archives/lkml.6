Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120941-2-4546679619755952787
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120940; b=IKLrJQj3kD6rvxjCqWJBAm7zTKFPJYEyHbDW+NWmTviJpR1
    6c9ZsJcRGR5RBlnZhfoJPq1HYC2q2UGbqj836SAiKwAKjs2AySmYoOSR5+/jZ4WB
    ACZmpEIeU/WCqy0JoVSp/Hy1SG0RdjnUS0va306Sm3m0r2J6+CwvdPadnrmTaPDc
    xrg1ek2n5d7yDW0+7QzbLJMA60ediddJNYEUdOuWOX5achaJJebXsX4PEU3QBRlD
    9e8FsOS1YGDDt7M5jKdCD9pxMCjNwYbPYVcpMPXSrZ7T+9+KTh/KnEkR7dafFtcl
    qHVJnF0sJx4RILysu4R47tLHrTWD0gDq3Etl7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120940; bh=Ut7aNm
    Vd9aI3QvDz2y5zuQSsnPulLCOfuuPvcZx3Tzs=; b=vFCXhKG/P74mZ9cIYbKlGO
    XE2t4M9jj2GsoHyOt+eabDpbvJ5x7pZk7Mt6C+Mz8M9f8fDjb/vOFaIW99bAKro+
    nCLwqLLoQK88A6rEoSkXIQ4qQdqr0zcZplFRbzCUD9N2yqcbKVIkpc0jRsKeBBEo
    Yha+jffiKtgFI3fFIx4ju1zrmZrM7m6uJ/RBHRHoWzCR76ZZa2Pug64aPPzCeh+l
    1fhcKBFKX0peGIh54JkwnE42M0lrTc+IJNGwKa8OXq+VKFw7BaLt8uwDP5Q2103d
    LbmlbCGXSqVoi4x1dqhGX0ch8YuYq6acBiFBN58kgM3s+Dzwky2HmUNiXVjCwzBA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ae6KApF1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ae6KApF1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934088AbeCCWeA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:34:00 -0500
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:3173
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934072AbeCCWd4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tobias Klauser <tklauser@distanz.ch>,
        Vincent Cuissard <cuissard@marvell.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 093/219] NFC: nfcmrvl: Include unaligned.h
 instead of access_ok.h
Thread-Topic: [PATCH AUTOSEL for 4.9 093/219] NFC: nfcmrvl: Include
 unaligned.h instead of access_ok.h
Thread-Index: AQHTsz8A4rR6qPwT9E6hfVCDYXsYhA==
Date: Sat, 3 Mar 2018 22:28:49 +0000
Message-ID: <20180303222716.26640-93-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;6:KFwJ0W+iI6hoeOat0Rhtv52oGUIneReeMGo1UL9cSVAyjuFPuNBju4Rx0o88ErzpKvuoG/MAVwrQcmmVi92T6QtxnQcllHVlzlrhvApy4vVbpqQ+pnEpcv2FnMYbNa0bRzSH1kg1lCE7/UPaHLixj1POMmJrs18KDWD8knFPSJ+S/DHdTaHd0iaT0/zRuf6iuD8KnThUVrxf9EzDKm5c4cRk9q80aR4BnO4m8ccUef8HuzuvpEmVgwZGCOaLUh7DIgaju76RrRkqMpYLNrYgd1MLQy51R9Z/o5Gt4tTMGdfZN9NFOwl2MoTIXV9fjb39jbczopQ+nGLdjf0poBONHZwBoTYGJUqPVt8kf/Yl6gJqT7vk2eF2/uazyQMzXASs;5:JOMXvCQtkWRzRv5BYZ8Uz0fIdmFzLoA0MgSse2pRhGlhHDa4UnzHDOMM9gnvKKNxTeyFAnmWjlSRrKt+2TI7Pl8iHCHEDTEkhcR2fbHvc66GsyvTlZyeGisn2LvH6v4zTAs6pmQstcRMSsSjPTTw3IrnHmi+CexezNiv5vjHIOM=;24:AiHRME1jUvyvM3Bo5+LCq5/lS9GvRojp3jFNDedMuce1E9cHBZLeUlZv3Du93vpK1Bl9AGPSubaWor3EZ/sjQvuxgn5C4cyEbeNru1DyCgU=;7:qxFDxOFLcgGllaWGZ2Q70DeI+knOoNlC4+LVN7TKk3dD3wPMJ9e0/49S52scOGu9VywBwUx6zZDGSCaiJa7EdoTmDMyKs9YeEtdov0bP8mFweuARaH6hCOhIPGuNXjFziVckKFgk8eIW6oSSpBTBtF3Bmjbr+Hoqw5piaesbDDDn6avaQ0SVGNPBr2exrB0YkRtoa28P720femtu92pmhEbgqy0ZoAr8ClBRFEgg+UQy6aVBdnY1rmqqD4HBLJOW
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9dd0cfc9-9dee-45be-3bf9-08d58156d6ff
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065A702233AA00D8EA80663FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(6306002)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(966005)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(133343001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: MxF6TB4am6RAxR4nlN6rmVi5gU4FlbsO1drf4xy6SiI4X/j9QwsJJDu3Iq/okPSG2GdDrJYEci+eDecjqeUyar8/0S768G/mKf8L9TApRnpHzbxZGNs9359nTlZbdJ+TkMECcupiNkrnUdC0VTk4INPSpJh7llwgeMbN5ay1I2k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd0cfc9-9dee-45be-3bf9-08d58156d6ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:49.7444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tobias Klauser <tklauser@distanz.ch>

[ Upstream commit d916d923724d59cde99ee588f15eec59dd863bbd ]

Including linux/unaligned/access_ok.h causes the allmodconfig build on
ia64 (and maybe others) to fail with the following warnings:

include/linux/unaligned/access_ok.h:7:19: error: redefinition of 'get_unali=
gned_le16'
include/linux/unaligned/access_ok.h:12:19: error: redefinition of 'get_unal=
igned_le32'
include/linux/unaligned/access_ok.h:17:19: error: redefinition of 'get_unal=
igned_le64'
include/linux/unaligned/access_ok.h:22:19: error: redefinition of 'get_unal=
igned_be16'
include/linux/unaligned/access_ok.h:27:19: error: redefinition of 'get_unal=
igned_be32'
include/linux/unaligned/access_ok.h:32:19: error: redefinition of 'get_unal=
igned_be64'
include/linux/unaligned/access_ok.h:37:20: error: redefinition of 'put_unal=
igned_le16'
include/linux/unaligned/access_ok.h:42:20: error: redefinition of 'put_unal=
igned_le32'
include/linux/unaligned/access_ok.h:42:20: error: redefinition of 'put_unal=
igned_le64'
include/linux/unaligned/access_ok.h:42:20: error: redefinition of 'put_unal=
igned_be16'
include/linux/unaligned/access_ok.h:42:20: error: redefinition of 'put_unal=
igned_be32'
include/linux/unaligned/access_ok.h:42:20: error: redefinition of 'put_unal=
igned_be64'

Fix these by including asm/unaligned.h instead and leave it up to the
architecture to decide how to implement unaligned accesses.

Fixes: 3194c6870158 ("NFC: nfcmrvl: add firmware download support")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Link: https://lkml.org/lkml/2016/10/22/247
Cc: Vincent Cuissard <cuissard@marvell.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nfc/nfcmrvl/fw_dnld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
index af62c4c854f3..b4f31dad40d6 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.c
+++ b/drivers/nfc/nfcmrvl/fw_dnld.c
@@ -17,7 +17,7 @@
  */
=20
 #include <linux/module.h>
-#include <linux/unaligned/access_ok.h>
+#include <asm/unaligned.h>
 #include <linux/firmware.h>
 #include <linux/nfc.h>
 #include <net/nfc/nci.h>
--=20
2.14.1
