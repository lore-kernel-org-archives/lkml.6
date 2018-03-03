Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118713-2-15719397816094597761
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
    t=1520118713; b=AQb2l3bO40ZDFnE6VPvnsqepl/JoLBvKOSmeFhDGgYsiIqv
    PeuYHiJsAzch3Fxzl0Y1ORCSA++qyTEUqDDzMTtZoicoFGd2vPljzO/a33IhGhkw
    BKxYjscUj96IkvKnuMpgqrWXJYS+iiu3MnPhSYXPwGYXaXPumlasVQUaeVxMgIHV
    eGtJ13bZ3ZakRkxEvLB2vfGI/IBrEdVPfg6AKkLqXI3bIY/epSz8F9iAMgzQRpj5
    ybi4U/VeKzS7MOIB0OT07pQVWhOFriOhKnG43GyvWVaVWdDFo3BT3yg/DjtGEzpy
    lQbJmK0RPGsSkqVr2KDyLmPBfAwJDMjpz8aPTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118713; bh=Ut7aNm
    Vd9aI3QvDz2y5zuQSsnPulLCOfuuPvcZx3Tzs=; b=JI0W3DX0MKLNT2b2UuddEG
    t/TJ3qdR+xc/1AJUQdJILBv+rw4ZWUIf0jr0DZ4eUBx064MByOHUWsBZJmELuUsD
    qt3aTsCEvyNezmLmee0c/Ain8UGhmn9Zc+bcXbQukjlLsPNRnOchW2MntE1KevQk
    mjsCkOpYMePxgMhMJZtHtOkq2uVKUeDgHefncKC1AfHY5dIp8frcfXOVdT7cBSAm
    gIyVqbImJ8T/68LraFvMPvh7n40UOXcA+vIAvQc5zf+kfvcFPa7tLJBEJYxaex5S
    Ef5DCekK1xcqAgQKhw5wdfXyMkc8Ijqvi1DqEhl879yy1gEzlPW8qQ29Tgt7SWaQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h08FwpFS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h08FwpFS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935061AbeCCWjT (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:39:19 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:1120
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934573AbeCCWjR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tobias Klauser <tklauser@distanz.ch>,
        Vincent Cuissard <cuissard@marvell.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 046/115] NFC: nfcmrvl: Include unaligned.h
 instead of access_ok.h
Thread-Topic: [PATCH AUTOSEL for 4.4 046/115] NFC: nfcmrvl: Include
 unaligned.h instead of access_ok.h
Thread-Index: AQHTsz9XPkNiMy578kOrfGX5zndsiQ==
Date: Sat, 3 Mar 2018 22:31:15 +0000
Message-ID: <20180303223010.27106-46-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;6:yJXN/ypLgRaTONHW3GW2Js/cGalod05HfEqPk01WBIlO07Rr57VN1PcvaTgJjEFawV5mec52h4jv/xdGfc73X0+G0ZMjofDB+k1FpIhUcTkJrXYmh3x3i1A0E9DemPBV3faPT1hkHX/C/nIAtbMFeoyvR/OPPK9kaR258WtHNZsuViHRbmkfp45EPqJPleXunarvc7Xg0BMWwA0Jqz3fCBkA1mcqJPCHiSDChGbX0afBGUdwHuiyW53HAepIJ2s0xx8kl9tdJMhDl4JAAbdC8FZRdEIBZlYnZk1wxxv8KTF6NXPdKPqvZ8KIKN+josWFrJ+eiwQ8Cyx5gxcypaEzB1PFB+kRipxzMOqm1lqBdJ2/pc0Lus0/y+M9ZWhlQgDV;5:+uRYNF0xvkp89j5c812Hx+WrAw9G+H3Xogdp4LDWL48x6VV+8Z3Mgew7lhhpCess2GlDWFJRLuXhbirSiSSMx4bHLE0zLYRWeaTWSxw5Kl7bJ0VtohgMBFWJzS1Fs/X1fx9y/XX6SmPiGP6FZR/Pb7LxXqP5ucTfTkMv+4SQwmA=;24:mkXkGJTh6/VTyQIpfARbjuFq9DEg8NVEh4zuZ1gpjxEmDbaDpRw3Phc5cxyHEoeGu0zHqTS/aasWXc9bdo7bwLv3N+Qw9L9LBRg8gQfi63o=;7:que8EIqX9oR5V+12CfsZRi9N7VfEEGXGBzuA3K21uEULXiZp/fqgcJ1/Be1xopscQJXE2EaQ8Yv6UEeg2piYsWxYuaaIBDInc2sCFotBxVpKQicC07SKottzD2+MQXVmlBI7dpMJpvrJUXXBCxdu+4FzI38IUcZOX4P6Zr3hfx2bCcbJuSvk0LXfE9FGJM3ehlR81C6ko2tK9CKZvtSSMWLk6vsnFrTchmmaGOpeOkstzOgxNKQHec8++A78j/sG
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0de7d51-3294-4ff9-79bb-08d5815797c6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0938AC17AEDF7B5A5B6786C1FBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(966005)(6436002)(6512007)(14454004)(6306002)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(59450400001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(7736002)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(133343001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 6cXtd+eRKjfiGRpap/6s/K5OOIYnXN6yB6DhXfGf0IlMoO12mD4i4wqjCMv8CPsfTjdpiTq6NwcqREJSmvilGmqKAbe/4cCtnvDtm6o6qNDoHq816O4l9xOfB4HqBCLeZ/84tSfd9n1omiFqikdVxO8+gb4FU2pjsV84dlyIjH8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0de7d51-3294-4ff9-79bb-08d5815797c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:15.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
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
