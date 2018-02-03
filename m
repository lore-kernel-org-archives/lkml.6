Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682902-2-18325855143602937922
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682901; b=C9zXD/6vWeJvywOdcRo1cOg3pRFo6a2sqCrF+CE+lHizr75
    9FrQ7lpRX1f6F29LNgFW+cnc4qt9/RUCZbSzqCTto/M+xul4q/VyY+2FuI4KL060
    POXCLzQgBXr8/MQWINXy23cEDoVNvq29fR8MQPGGGSxGpm7wzqMr7q5H+PxojS7T
    pSq79LWRfJ2NzQHFYuKEVq5N6QpObfNqFFnJ/B7w1aTeAyBR6+R1qKka5vaSB2XD
    EMLAXaxpOhFqOJL6vOTJCzc9/b/WRe4ci9PBkB1BCleSK1chXU600WZy88Wpv9nv
    VDWpvf92gqVXw8hOeYqYPNXJwm2x4eMyk51GdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682901; bh=7b6NXu
    Er92jeEyv965PAyrnel5VBD6qQgvgDuVskg7Q=; b=IMKsJRVkN68RHjrJ6asZpA
    zPfg2KQx0a2reh80/CRB+n5fZl/P92VzVkO3M+jz+ztybglfHpQF7SVld/JEBy2j
    evR33Kto4gguaKSv0Ic7Np2h9bMN0N+E2ynPqzdf9iN6mOWh/VjMAkldXixuGGSY
    KbfCmr7ISLPODJh0CKSryk74iMJO26D8Gbd5rZpVtG9O1uc+N6f3x/D/6YAI/3Ab
    oN0W6Sseou/3Ka6Ntfc435QrLCBcfUEmBvwRmaSVOwHVAFp8pWW8f8TelJzeOxpD
    IU1LgJL+3+us5KUdJBljubGMjMUgtFRfbsqnINVXyVaLUjisnVVL+kBMdaaauScQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LQSy3sM/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LQSy3sM/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754674AbeBCSe5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:34:57 -0500
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:45338
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753293AbeBCSEE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 104/110] xen/gntdev: Fix partial
 gntdev_mmap() cleanup
Thread-Topic: [PATCH AUTOSEL for 4.14 104/110] xen/gntdev: Fix partial
 gntdev_mmap() cleanup
Thread-Index: AQHTnRkGboIa0o9odU6MhvxINVTtbQ==
Date: Sat, 3 Feb 2018 18:01:33 +0000
Message-ID: <20180203180015.29073-104-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:72O0gVr5VJWG1CfRQZ9eK2x52xARYqJLCPO5I7hjM7TzsgqpxTJ/wKm/8ZSvTsG3aZIPFLUG/QnejduGp2ygZ7494j19fTOw+4qdemyVd2GldAouVeXKnWQ0A2jcPhfodtfYJq8NJkIq6TemiJPPVsXLIktdjY2HqFklJZ88NVqfNiRcpZoT51czfsKDp2cCiFhuOvhv83fT5R71o8VvRv+I8hUJVRNyRF9ElvBcKbCliL04nLp27cHcM2U6hhRT
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60d116b1-febb-4e33-8ff0-08d56b305876
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993BB43320E186845E37730FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(8666007)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 3pARVRv8Moox7DBmb74Zdn31GMVTLjbZ/M4IZrERuidVYt4YjboJF0XlI1i0oa84GKPO1gGZAZcUlQRck/fw9Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d116b1-febb-4e33-8ff0-08d56b305876
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:33.2846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit cf2acf66ad43abb39735568f55e1f85f9844e990 ]

When cleaning up after a partially successful gntdev_mmap(), unmap the
successfully mapped grant pages otherwise Xen will kill the domain if
in debug mode (Attempt to implicitly unmap a granted PTE) or Linux will
kill the process and emit "BUG: Bad page map in process" if Xen is in
release mode.

This is only needed when use_ptemod is true because gntdev_put_map()
will unmap grant pages itself when use_ptemod is false.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/xen/gntdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index d3391a1e3796..bd56653b9bbc 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -1071,8 +1071,10 @@ unlock_out:
 out_unlock_put:
 	mutex_unlock(&priv->lock);
 out_put_map:
-	if (use_ptemod)
+	if (use_ptemod) {
 		map->vma =3D NULL;
+		unmap_grant_pages(map, 0, map->count);
+	}
 	gntdev_put_map(priv, map);
 	return err;
 }
--=20
2.11.0
