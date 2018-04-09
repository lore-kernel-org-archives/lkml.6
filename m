Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246826-2-13985625198809605066
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
    1523246825; b=KOnMVAg//Y/uKXM3topkHjLmlZtVy9BC0mHGX6/Si7jZK8tWYi
    7IWkEhXifhBESMHul8Fq8+K635RzyxQwntD5xDFndQ1GMJ09JlsPIkHghpZzYcOo
    32zAo4L4JnUyUdqpt4A2631ekSCfLOC3Pxb6BkBjxQsBdkPfT6xg9RTBZ1FOI7x1
    psJ8u0HOb9fXbM682HCn9FPXYBhuT07EB3aJUJGpgR52RI1cn9WCk+Z0+fzjZC9a
    1Xam3xn2ZRj1FaQgoKbTd5PO7ywV9g9g6mWOCUZyElfZI0PjV7r+1TBTmhVli/Tc
    8LBZKzuwJaUntjz9WG85LAddflF+jOOjK7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246825; bh=B1igtjuQFr
    DHBLBxodMJSweTYpWN8RPOP1VZ5/2ud3s=; b=OTKzr41gkaZ4ZA8nB1GVnR/Wgc
    K/zh+Y8OLsimzQIKwIKrBi4jfAgccLFtnaSfCYS33Kx2Mdj6EipQMDBd9QyAlMN1
    MZImh+apixT/+OFZR5wzO3rw6C2V8B7JRtk7H9uchBzVS1xTp/ZxkcS0GWUjeBIK
    KsDA4gEk6lbK+hn0sxkZrpytUzSvFXEeu7HBFfbq3nNel9rZdMUMQSvxI3dxhwcW
    IMgNITQJUrgsmKZwezm193xD78/zHdpIRfS6lqbPTdQYeJAgUF+Dktt6Tv7JBp5v
    ZkUNXxsjAU3fB5ZLuwLIHsHDW0CpnxmcgT300CjCs9/fz9M9WTp0ajTJcawA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FySn6h0D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FySn6h0D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKhKXAf3uJqju23AcnatmmSKM00BdXLsW0B3nLYBSikSCIai1vOPmfzgpdRIexN0QYZ6ebDhOwOMMJUzuU3+lQ8Xna+u6ssd4IG0oFIVCeAJyoC+pDqs
    /uX2bJOXsAzaLWYrmm4kDOGNDDwWb230B88brTZvCalHSgUy/1ezEvzbLbHYvRsx20kYuSAHinHSzPSgvcRgWyP/CyTRLosZU8czH57cfTaZsZ8ywiCqh86i
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=alC0domXPAuWEL2TSGoA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeDIEGt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:06:49 -0400
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:51875
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753164AbeDIARt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: mulhern <amulhern@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 036/189] dm thin: fix documentation relative
 to low water mark threshold
Thread-Topic: [PATCH AUTOSEL for 4.15 036/189] dm thin: fix documentation
 relative to low water mark threshold
Thread-Index: AQHTz5gcHlXbdNi+4kayYiJ/MEGtqA==
Date: Mon, 9 Apr 2018 00:17:14 +0000
Message-ID: <20180409001637.162453-36-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:f+DlivVm5xHetjzHpmCLE8SF8oHS4yDn7zlAhxTDO88aUmU8gJbKD/VaNfhg+Y6WSlQSoFO/Rl5zeZsDxN+CThJqqVOqBQj6VU7er8mMNgjGGysM24vQOY6Z807pan4stfMSIHwuJBgVl1k4ZBn5w9dO3oStu7X4OZEHM5sOdcMX/G9BwQukSrLlFI8jz/2IfYAiUoeyokFZfdRLFeACJkT6FE0cvqbfz9BN0cWUDhtwi0VSvenuNN2ZakmBMpjB;20:40Lc3+NF7Ncs/UDkfOrWicYQXczbgndzS4whpC0TI7Fb7IcEpkVB0gmIAXlFVI3kGPVf/umgJifRzSOjHDuvbU1loWdPQLBV3VdoEtb1kZGRqfk1H7KOqJ6W6Hn1Iz2yWcP/pdnxmIrV/yGNbObOd3zAF18t92tYiGe7h5FPmjQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad96e82f-9246-4783-016b-08d59daf5098
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048BE7E1A92D0C833C077CDFBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(59450400001)(86612001)(25786009)(2900100001)(14454004)(97736004)(53936002)(107886003)(68736007)(102836004)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RlOygxPAJqBUCYDHwxtqfN1MPLzr75vWN9u9b2OOsB1xH0TOevGXgeHv/xXcEWzRc0Oh1V0pV7kxq3YydmVQ1n/Mpi4I+WB3sP3N8vuCx0SoJ+iuZeYeirLY82RQR0BFyI6SGkgsWtMt/gCxXamHRbkZljYivXoZn1U/Fsj2QxNDd8dtLL8nQN8w6HPD3bjOFze4mfAJQdXlDpDsZRFc7e8+8nQYxTEMD+HisLBckdSDD8yra/97V5XEHRAhbrbz0hpOLLq6O5aR9jn3uQbEzdOvM4ZHf+mne5br4iRx7rgojZykBjtMgqACoCNoYdZdC9CaUB2jtKrUldzrAjE47s+ll/LtsKHFDDmKZnQac3t28n+8wtfWUpQTCQzcz4aRVln88QRdOHVT7RY1bcXcEhMQlDlIcR3jtehTW4nYL34=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad96e82f-9246-4783-016b-08d59daf5098
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:14.7766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: mulhern <amulhern@redhat.com>

[ Upstream commit 9b28a1102efc75d81298198166ead87d643a29ce ]

Fixes:
1. The use of "exceeds" when the opposite of exceeds, falls below,
was meant.
2. Properly speaking, a table can not exceed a threshold.

It emphasizes the important point, which is that it is the userspace
daemon's responsibility to check for low free space when a device
is resumed, since it won't get a special event indicating low free
space in that situation.

Signed-off-by: mulhern <amulhern@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 Documentation/device-mapper/thin-provisioning.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/device-mapper/thin-provisioning.txt b/Documentat=
ion/device-mapper/thin-provisioning.txt
index 1699a55b7b70..ef639960b272 100644
--- a/Documentation/device-mapper/thin-provisioning.txt
+++ b/Documentation/device-mapper/thin-provisioning.txt
@@ -112,9 +112,11 @@ $low_water_mark is expressed in blocks of size $data_b=
lock_size.  If
 free space on the data device drops below this level then a dm event
 will be triggered which a userspace daemon should catch allowing it to
 extend the pool device.  Only one such event will be sent.
-Resuming a device with a new table itself triggers an event so the
-userspace daemon can use this to detect a situation where a new table
-already exceeds the threshold.
+
+No special event is triggered if a just resumed device's free space is bel=
ow
+the low water mark. However, resuming a device always triggers an
+event; a userspace daemon should verify that free space exceeds the low
+water mark when handling this event.
=20
 A low water mark for the metadata device is maintained in the kernel and
 will trigger a dm event if free space on the metadata device drops below
--=20
2.15.1
