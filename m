Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237801-2-3512114971964625124
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
    1523237800; b=u75vq7GU/cyCq7mWyBsNrLv1bOSyHW1RcEWtXpS5vcJ2EwvVZy
    r8LGuc1vsuSJtqlZCdDwbSO42E7jk+nMmjlk4yswuQo0scwEJ23czlkOo/6IjxVV
    Yzpl60TPZC5A6aru6wJ4xpIMEBTNBhDZohtf8NJvS1tvqwNUBlm9ccWPdSy9KrIr
    0JlwccSGPp/WiYU4IgvzwcNPnvxxx65aPH0gEKYu/Xc8lYF3G/p22EjE3Bj2gfhf
    HlEWnOKiE7IytlyfhKcJ9jAqKgLMSoNYQOe+KIy8xTWz4jm3svQ0UBMBp8JplVlO
    u89K+prQ/5TaVA/W+FU3JnWgdeG6v7awjlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237800; bh=9cugY49JGe
    Ft1KU7xXJ9vx76/U4PMZ7LI/F03NSYgXw=; b=TFyQW2l/15gOI/iX/SQBVmnG14
    ZviH4+AWBNrby+FpH/j/Rpfj6PbGb0b0wuPoVo5Hyz/Pm07BJVPO7dkkTPiNupmT
    YX8HXet9O3N2BDUhODnvLV13UIiDqSD7CCmCRyg5hcxBMiPp+nPV4ENY/z5C3oz8
    RUdU8WVc9Ldpa9CjMtZx5ko0PWTOiHRBpZxvLLTS0oQEAk+FggkHMCrO6JLIHT4c
    h2MsbUZcA8CoTMJqWxkB1McqsdlIksLK42lf3pEyrj6jR+pPwIEWkM8C6IIr19ur
    NSFeVoseNE+w4j+y7YD6kMWr6dSBXTsj3uIf1HDbY0YXRsAH6vD8oImj1BrA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EY0qE9US x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EY0qE9US x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEM0DU/XlgqeyatpBiqc55TWYpsHYFfg6Mjy2Vu7CI2ERXCG+2U9Sfx3vdmZcs0bElEGD+I5j+iqqmImAs8JM6paEFacf4c8EbEnKfIwoMLS6pANJvsC
    4+upK2B73hd05BmV+izmBpdVHbBxNc0rvGRLNL0v2jEI+DS+virQKT0EUzp1uE9MKrYQo4SAyvaZs4ygpG8jA/r0DvHHWvT3LVcMgjAVymgcwcN6+89SwexY
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=uep1uxCoZj0QLMhyj48A:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbeDIBg0 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:36:26 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:35040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932577AbeDIAfG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Stefan Haberland <sth@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 021/162] s390/dasd: fix hanging safe offline
Thread-Topic: [PATCH AUTOSEL for 4.4 021/162] s390/dasd: fix hanging safe
 offline
Thread-Index: AQHTz5mcwjorMQTZmUaZVEnxC+fEIg==
Date: Mon, 9 Apr 2018 00:27:57 +0000
Message-ID: <20180409002738.163941-21-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:117lkUnaiPRgpMxsPxICdN1vvHB1/fi4l0ZcVqZyjQ7b11Ng9+6GpBjFDJIfqLD4isUUmoiR4VcXS4/YEDGDdVfrGKMot28UccLUp9KhBQ2K+fP4VE8xzz6Ez4hcs3vPeVxYtn1xo9kZAin5eXCjvRg12Mpf8agUHCqgcH6H24jjoNafQrqYK3C5eu6IRA38JSCDJoiutu4L90qhEu3YVcVDc9MRyH3ewCJMpDYbW+Vl15orsnNfIdHuqRh1Y1Dp;20:5nvjzX/qZyAO49XFJ0u3qUHpaB4L5+o6qIXZ8Q5a4TCyeWxWf4Dr5cGj90/XH8zWCUMCwI1qYcwtpv9tnvdRK9LjaiTQ+q62v4dekcUVhTW8rtVxTMqA3AHa+sQyIBffrP9Col/am0OzISGwvfnEdM9Gv8VbaNNc5owPgA6MszY=
X-MS-Office365-Filtering-Correlation-Id: 813169b4-8368-4f12-fbef-08d59db1bc26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101333E56B978B278C91B426FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(43544003)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(2900100001)(22452003)(316002)(110136005)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: q+9bDT6ybQiawVi/ic0oIWtzrOX2fGEd/Zd40W8ECiapJ7aM6x8uS1dn2Q0qURZ7kTPSA09IfLbbbrjEvntz+ill66uDC7WiLh1jmgy/xChVh6xuYhblntz5QB0KvCwO2a0aCXhM/VSE8SXhMlWzlj6nmtWg2vH0nN0nYlkI/ueIVoRCiQSK0CiNPUgsmM1/wTGTGIU0mnv+KS5jJkx8ipme9hfxQW+uMoET2rEuRx/sD8dUErktqANqk1Y91GHDHkLpTbjwEf0qt5SRr6Ot+xcR4LgxLj14TendaAc+zOoRGUVpgMK2VGL/TtU3wzNFCXw3oxWlCdN6UJ29U58j8So72hxLVTNOmwk2iiLzzYptNppkpjFmqMAVTKGDzyTbBi9t8Y5fX4go+o/yJUN+tWN6juodl9MrII/4gqo0rbo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813169b4-8368-4f12-fbef-08d59db1bc26
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:57.9891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
index e7a6f1222642..b76a85d14ef0 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1881,8 +1881,12 @@ static int __dasd_device_is_unusable(struct dasd_dev=
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
