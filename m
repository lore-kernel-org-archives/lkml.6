Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683511-2-326852826510423527
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683511; b=AqGH0/onM5YHwgXlAqeLaA307QWBLdGUqvZAJdfrYxJK93g
    UMSLYIHPyqJPZHET7+hVaIbm3aOf/GPirv6f6zdXXRbtwWloPbnmodTdTU+MWVF1
    zfzmF+Fyp1ITTigSSbOq0j8WnGkGyUH7u8D2JiT8okKs0sfMbjeIb0bG2th7wxRg
    BOeMtIE5hpVdvmbgcGQR4csQz64bSJih8UBoVC6I4+NA4RrxRhMmm5FKNrqJD+PQ
    ocCNKjr9CDx6Lntlq4DeFhfwxSa1sz5lLmAlxKkF05F4YiTMOB7pdVcN+HfmADmr
    JSREzgu1Qfl2IZ+Cmja5Y1uXDNlhkMUasVYG4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683511; bh=tth9vf
    f280XUNGzVJAgSvu6WTZRCt5RFEn+/OmK+LD4=; b=Y/jJku0j4t4leD6uEf5EKB
    jls8pIca6EJnBDd8KZh+DlGlpd/zA1Mq4OEcXgJGlb2ALyIIXuSA9kYj/30Z9xaf
    wdRJoQAz2LTwri4P2X3h4QFS6ymn0pFpz3P2gkFToMigoIsi7EcAsFp3RxQvAy8K
    e2cbGei1kMy1dJorXDW7a3xri2RdeUdXJvfDMYn6ja27pVFOe+oBOSesVUNY2dDK
    Kw1B90i6KHlxkMZJI/kAW0VqYgKAKTnvPX/XxeYzKhd3KWP/Mf1zYXPMY4pVof+Z
    mGUZCgVZcP+pQnBC0pKzUPpgZW+sPN8n4Orfa5J7veQtibe9MQlRVfgVpmI3indQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ld31TvwJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ld31TvwJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeBCSBZ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:01:25 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:24890
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752235AbeBCSAj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:39 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 007/110] phy: cpcap-usb: Fix
 platform_get_irq_byname's error checking.
Thread-Topic: [PATCH AUTOSEL for 4.14 007/110] phy: cpcap-usb: Fix
 platform_get_irq_byname's error checking.
Thread-Index: AQHTnRjgRXZMm53aSUKcgH+Ups8MoA==
Date: Sat, 3 Feb 2018 18:00:29 +0000
Message-ID: <20180203180015.29073-7-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;7:Klfo0xVDHe0ehFV+Tyqy+MdLa8ZMYTeMHsdse+PRhvxlOPbqLRuTFegPG6EOcpqNYqyRlbFJmcTevNUdrJSQdaCmhDfttE6/0YaVsnHnuH03JJY1MyOXDO/8NOCJz35Mv/XXF65UsevatDSo2+qL90nJcJnoEr/LkB0S4pg0j9HJIBzXMscuz/Q0J1ULrJhHdtXHzv4rMi/cxY08ApPwZLvD4T6q1wWJNRg+6t8IljaxxeS+lePuq2r5yLqr53jb
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9fcfdcb3-5ac4-4d94-0c88-08d56b30047a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB1043A9AEA14C96FD1B2AA323FBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(59450400001)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(6666003)(2950100002)(2906002)(5660300001)(4326008)(106356001)(575784001)(86362001)(97736004)(25786009)(22452003)(39060400002)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: qtSd5dOUQLlktRmpC8woLdqMWYKnoT7hTIpxLuBeoQOG+b3DfNmWdxH+mYMDW98g9ciWDKFcKd9fgoOy+VVd0g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcfdcb3-5ac4-4d94-0c88-08d56b30047a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:29.5190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

[ Upstream commit e796cc6a3a9186c92092e2f5929cf8f65b56cf01 ]

The platform_get_irq_byname() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq_byname() error
checking for zero is not correct.

Fixes: 6d6ce40f63af ("phy: cpcap-usb: Add CPCAP PMIC USB support")
Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/ph=
y-cpcap-usb.c
index accaaaccb662..6601ad0dfb3a 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -310,7 +310,7 @@ static int cpcap_usb_init_irq(struct platform_device *p=
dev,
 	int irq, error;
=20
 	irq =3D platform_get_irq_byname(pdev, name);
-	if (!irq)
+	if (irq < 0)
 		return -ENODEV;
=20
 	error =3D devm_request_threaded_irq(ddata->dev, irq, NULL,
--=20
2.11.0
