Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245522-2-6987548823869329689
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245521; b=f8TzGo90qiMl1UCAHnNUob4LL4d+jeZFmvE/FUFFbuAlCv1gsg
    MJJapVgLK097dbMgOqeqSfqoX1PEYD31bnuEtsehkfn7ScApTOlzvZwgXHrB3WCo
    yodo9kXX0iyY7+CpxcNhqAW3cVN9DDoNPIu7KNs6naky8FwgQjIAtmzF8wbIX5hM
    3Q3hPSaFaYWtNGq25xDJ1/q+zY4T8iltAhQ96JZ1pFaMiaVJOJXhmiieiubAawtg
    rZNuPZ3UBGNycKIDrflPdlrqOXCaBjI0mCfSY2cmKWgnKuCgQu9GZyCVfoTRuXGg
    7py/LHNHjQwJPQECzSFgWDDjwSEfMXHbYrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245521; bh=E4KuhBtCSi
    CllYd8KmLMLfcNLbxocbqyDrOnotZABsE=; b=j045fmJgaXo1ennw36J2DSr0WP
    jKKeUC/RuEW0OPQgMIGJYSc5xCs9A2Y0Qp/hK7MyXLJI7vBbCPMbPt8htfHpURtL
    YLwgT3CTrPL6p5u4B9P8w55nGMAbG+YkEhQXF2jhQ+tZCuBghttpt1+r2A3ofp+h
    RRgUR218gfXb38yRUoDav+I1UD3Ukqc2ArK2jKSB0vmYW/eRe0BzD7Pr+5ZlCziS
    fNblTPSs8B2pF4aFeDf2ri6q1UBdm+hS8tK1TT8XvvlHCVptvh/ISSbqOlK9C/zS
    ZdfjdrJDX8u+PN2ZoZbmKlworUwjaN2IZiTuJOcy2cXyQ7ooAIk9qtvA1Lzw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C3bk/S38 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C3bk/S38 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP35wsTgFZou+OqkVX4tBnI6kfRVM8Qj5Kfu92Qk8WM6G7FRK9GDJORhudqVyREo5oCKU/q26ApjsKxYsdKxJaFdQuUKwprwf/Hbnv3YjEdJEQq6bAYr
    DB098gjaGJPLACCzWCsP5X1Kta/FZH3EAH940zNz/iwXBtnk1MnrhxQnMKRyMB+aP7AR0CCf4zx4/HdKifZ3H8+fw/H17RhPvlbpM4HhpcRI9StvvOi8j4wp
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=R0T72MmZjkIic9apZRoA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeDIDoe (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:44:34 -0400
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:10471
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754211AbeDIAUV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 136/189] s390/eadm: fix CONFIG_BLOCK include
 dependency
Thread-Topic: [PATCH AUTOSEL for 4.15 136/189] s390/eadm: fix CONFIG_BLOCK
 include dependency
Thread-Index: AQHTz5hN55yEExS8uEW1Bjr/3FeTzg==
Date: Mon, 9 Apr 2018 00:18:36 +0000
Message-ID: <20180409001637.162453-136-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:QVtaAGeUF2xPWudrfX0JphO93VYuCGkIpNSTwUlvuNorjTFhTq4fKn708f5wvXAQO1AnzE3oaStl4C9mVjnFq5Hw1HH/65BgybtfjzoH4ESRbTnXvtdbt5m65GOJp+3+aoH8ia7IRpcG73kmSOs5pLt7Y4kYs0szjWqLnzyrraQ3DmA2pv8Qi6CfeDbJcnzkdP/tbQgu7GWjIBb6qbrDKm/ZyzOipVpd6Gz0HV4RGNqcVzK6xXcEDboF9x3WWS9U;20:3ra3RABiiJcE0yNds2ZqzmQDbLu+uQE6K1WWHDpg9UR/EMrtFyFWG6X9VvjruyXAxvO2jAaep/sZsVx8Yz+0fPzooI1ZFtfkb4r7uoPvZVrkGev6W9cNUhJgubbYcBomCbBzOSmo1i2CFMoqbBbnbj6I34RtZKztz+fGnjV8ZdM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1b6f548-7ce1-47e6-4587-08d59dafaabe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110E8E1C8DCE07F35915D04FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: lmtESx5jfyKr+v6h6fcQ/BGho6pG/EbdzWQ4ejsQFpplmu1IR04wTLdFFKcNV851tgzQKeILc5vMzo1Z4Sw8AWL/WgdDlRj6QDVIS1k1aE8EeQbA9UGaJwlisdgQhQi8guqNSVqhY7M04hN2SfJO4lGH0YvK2EnCtFjs6vPoIZZidfOKBLDPlg+3D8y4x4psNU4POh1misTySY5EzfSbs9oMfEdIZvn5iayVOrJ4vPN21HyXzdhIIkhFpinRiOglJmTpasA3PzEbMLWanc6AulOhvqHBKXuyqGUGKilQB4xj2DAdL1sOS+45mqZJy57010pvAS1zZ87ibgLKx1ddWJ2DTVD0DDIE09r7yy1Fg2vxgqttuDLrD0WU0aRGgBrUiilV+qVv3Q0QBmlhcJOVwjhT0YvDmcE7mndGh231JV8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b6f548-7ce1-47e6-4587-08d59dafaabe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:36.7691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

[ Upstream commit 366b77ae43c5a3bf1a367f15ec8bc16e05035f14 ]

Commit 2a842acab109 ("block: introduce new block status code type")
added blk_status_t usage to the eadm subchannel driver. However
blk_status_t is unknown when included via <linux/blkdev.h> for CONFIG_BLOCK=
=3Dn.

Only include <linux/blk_types.h> since this is the only dependency eadm has=
.

This fixes build failures like below:
In file included from drivers/s390/cio/eadm_sch.c:24:0:
./arch/s390/include/asm/eadm.h:111:4: error: unknown type name 'blk_status_=
t'; did you mean 'si_status'?
    blk_status_t error);

Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/include/asm/eadm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/eadm.h b/arch/s390/include/asm/eadm.h
index eb5323161f11..bb63b2afdf6f 100644
--- a/arch/s390/include/asm/eadm.h
+++ b/arch/s390/include/asm/eadm.h
@@ -4,7 +4,7 @@
=20
 #include <linux/types.h>
 #include <linux/device.h>
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
=20
 struct arqb {
 	u64 data;
--=20
2.15.1
