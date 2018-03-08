Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488679-2-13612452455730384028
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488678; b=uTOwUeMxWtuTHKdIIfegOuSI6k9usK5EMMONLlmJ7APurXh
    e9CG6qsEUkUPfAYgnFvshWxnQ2oOkw510XXCM9suVHB67VugeKortxr9/vXdy6li
    oZhv3fHxgWa2+T/PdgbhzTi4WhZIy2LHxfI28a33k3kk4uqtFCuYEDednz9n3nLk
    gYDq6aY8Uo9CZOnOGTJg46Txnrl5big2VOTDAMtznQulKba7ufcRY0fDoPW1Q4OG
    MVMgIfQtbP/l6RZduY1JELc/EDHHbjBQuUjfUXi6qoVSgviOxyHkaU2Swh/UjWzP
    RXmoYpboe7cAxjwrZb55rigC/EoItNavb3F6/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488678; bh=XHQRde
    gbPHnoz82H8rqatF9LlItd2qWIBZP2yXbhQfQ=; b=jSBZFkIrNLZbKRMKpbQEjf
    QrdI38UEhytucOxNQ6pGlLv3pZIH70H+KJr0ygGlxe/IazkLKjP6goxCcCEKohaa
    MDhMl+yKijiP0hA+BcuTK+biC1rX0Be7i4bMpeHiKzOd1ypeRKPXcPARtk/tm062
    gJKM0gPdeQJLCAIUI2G9ExHjXAqaghJ5RXvPqSbipt2XKfJqRWg0gB1DPO5gq5Ul
    1gmA5wC3wY6duojtLs8GwkIZmjKD7tcYDvo+lmxw+S6q+cszaXVMGHs7IbivPNLB
    CxddlMbUS24lI2Lf6HGfUMj6vthBorXtVjcLGysZvCDH5K4OTnCXe2ZqvDBnvCvw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eqfY6xVd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eqfY6xVd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965676AbeCHF5m (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:57:42 -0500
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:37347
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966011AbeCHFD3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:29 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Moritz Fischer <mdf@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 148/190] rtc: ds1374: wdt: Fix stop/start
 ioctl always returning -EINVAL
Thread-Topic: [PATCH AUTOSEL for 4.9 148/190] rtc: ds1374: wdt: Fix stop/start
 ioctl always returning -EINVAL
Thread-Index: AQHTtppNY2j9paYj2ECXXIkF3YB18Q==
Date: Thu, 8 Mar 2018 04:59:57 +0000
Message-ID: <20180308045810.8041-148-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:zmK37ypmagcEO8BtUIHJWQm5dNmBrMn9AyV/KYr3tn04LPKE46r85zMmkFSzeJ3O28f/P2WE77Pms/HkG+maq8ZsRtCIB0nMqY98V+8D0SqvMcYMJZCWCrlVliJOwMFu1SPrve1NWEJWz01JRkNYEBk0ow8jxj1rgsWgRF374kXSk1RLXTqdq09iBCocd56Iow9B6m7d//50ifknMKOANnsBFciKomr3dMqIruu7PFahC36Cgux8t0YGUBMsZVgc;20:XrFAayNQhQC6OtAkrGGwsPk4Bg54TaAeTNXv00wg+aBqjvhCyGTKs4R8X3Y99CXPieW4buZ2rOI3d0o/XQQHoCx10q3yVd48fbo6DWYNk9sJyuRWC2f/pa1OfzFt9O/yvPNFkkG6gBrZIn5290uxL4S80/I8BjbNcWrcZAlXwkI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca5c5ee7-57bd-4bc9-086f-08d584b1eaa6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902A0550FE6420AD39985E3FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(6666003)(2950100002)(106356001)(10090500001)(575784001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 20wPBloE5kynpzycKdW97jmS36+7jC/KmXrT0hfVCcbZdT9d2pt5uH2VVm0/P2UQRNSDQDNJCgdax62+EDH6cO4turu9yVG3nT9iK3kw1KQQYH4awYuPoe+2TI8FZDGefK5QNt+G1zsey3B4CKyTB4VGuPabrgX7gGMdkDGOAFwO0Bm7WW8Mh6fXqFA4ZIjGCiDrAILSha+tr9xtpIIbyddK0DnJHLXD3hG/0tlXmQnbEGZguOqvXhoyamby1zNqgoTeZ2q4T+EPTm/lTh35gxCZBOx9olAy42tJb88ck317H0SuNuMbTmrgtj041ZhkjgRNlQ+61Dm56Iq/ZIo8Fw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5c5ee7-57bd-4bc9-086f-08d584b1eaa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:57.5686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Moritz Fischer <mdf@kernel.org>

[ Upstream commit 538c08f4c89580fc644e2bc64e0a4b86c925da4e ]

The WDIOC_SETOPTIONS case in the watchdog ioctl would alwayss falls
through to the -EINVAL case. This is wrong since thew watchdog does
actually get stopped or started correctly.

Fixes: 920f91e50c5b ("drivers/rtc/rtc-ds1374.c: add watchdog support")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-ds1374.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 5b5bc7dc3a1c..c0eb113588ff 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -548,14 +548,15 @@ static long ds1374_wdt_ioctl(struct file *file, unsig=
ned int cmd,
 		if (options & WDIOS_DISABLECARD) {
 			pr_info("disable watchdog\n");
 			ds1374_wdt_disable();
+			return 0;
 		}
=20
 		if (options & WDIOS_ENABLECARD) {
 			pr_info("enable watchdog\n");
 			ds1374_wdt_settimeout(wdt_margin);
 			ds1374_wdt_ping();
+			return 0;
 		}
-
 		return -EINVAL;
 	}
 	return -ENOTTY;
--=20
2.14.1
