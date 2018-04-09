Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234983-2-17442184971832207954
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
    1523234982; b=YmatNcgddxHn4BE3Tla7SuaBxDSJvCHvw3Y48tpFQfRYCzulSy
    XqYdcnkVHlhoYU4p4WklQBhkCcP/aQVwIn5N0zFw/bOdVkWzfcHXZ06iU72Nn1+B
    44CPSQmAXEW3PwnRjAk7Yb+vtAUPwHcwTkprGYOP36mkuz7SyNwO/lExLRCMLBjf
    zXi9wl7zGs5GeNU5mBdwYenWcmrj6qknUg7rONYi4vejl9uodlcKnBmg2xruzNUo
    21hwM34MwxedisnZSb8HvLCpKNjYd22bGrLV9refxBVtLOwcn4WjSLB5oEIUg7ID
    BMr74KwDm/0FYvBewFrJh+fO+WmNyLfWz6Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234982; bh=85yfWp2wsU
    4xJj8upiyuQHMc9gmsd1+Ltv52T9z7fyo=; b=NzeQg/x+8aAWFjD7weYje//KMp
    FFpXGkwkV10qxJhC86xODqNzG1zycZ+TMOHMGth1gpzMk7DFGbnML00T/ZyxiBp4
    vKwjR/eFIEhrkasEbvdFEVA7RdiJq50OXxlPp0AytCcnrnEVEM4PVuKGxsxH+Dez
    73xD3r/h71YG4WsK+2Xvle+O7GBwFVDMGnrEg0vQyZQMZfEjMGbfUOCstVKmTfCG
    Pjbuq+wvWhLDTdEK+WfL6Zgq/2y50rC4qi7bhuh8HxLSxRt7zxJ3kmCh4WQX40S8
    MCnSS7VGDqFjL1krqXkaEL6jPoexdoRqJKbcO4EF9WyjYNdytstjz1rRiWAw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lxae70jL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lxae70jL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFltDqttul6uFLqzug8YThfBhDUP/OmPST+C3ElEpD6LQxMz3FKnFa5q1/JxIfgibKUGBgHsp+qIQlbbqUNM4G+erpXLsSFxH3L8Mt0kIzXehOQbrM0v
    SI/unjmj/t3LXd2Qv/aSZSQsXCQaV3dOYrEGPfXVsNHnuXD7Uk0xwGGOueT4dwdX4ytI993SrGJF9E+A6wbi0IGH/4QpoO+6s8BuPlOKefG5ZDOpmO8dcUcI
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=alC0domXPAuWEL2TSGoA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757139AbeDIAtS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:49:18 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755263AbeDIAlh (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: mulhern <amulhern@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 070/101] dm thin: fix documentation relative
 to low water mark threshold
Thread-Topic: [PATCH AUTOSEL for 3.18 070/101] dm thin: fix documentation
 relative to low water mark threshold
Thread-Index: AQHTz5uBP+sigcMj6EG1W6FOpqueiQ==
Date: Mon, 9 Apr 2018 00:41:31 +0000
Message-ID: <20180409004042.164920-20-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:fnqvOFopjtx+o3nyscCiTrO2oE334rjgDR7ZZs4c+/r5bxYY+0b85zGTplPYxmuLIbzjXtmcng3zMgE8zDX7PiX4ESAUpkOuAwBuwln/26OnZlS3ls4MDoEkwKTWI6BaA4O/NZ3f0uKXl1Cm1ceWMf2ywxl5vIAAIm9oXw12eAoMLoP+4vci78mj3mUxzZhaO1n/XBYnb/WHtR1BSJH22m70CEXc/T426SNNdKYlM4d8aBLThJBFqqkZrhyfz4XH;20:shAjBFyZmMSvZMX2OF95Ft2djWMwx74q8c2alzJ+jtHQyMV3VAOP8gpnLrgwwEW6nmOAlxMv+jl1GNmUk5qVqALy2bUv60xN+gNTDiS3woKd+dqfPMzh4QAzRBnIEyJaT8Y4zpi6li9C/eH4WJyE7q6+EKgG0RlcJLdPsp/HIts=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8834bdd0-5d39-42f3-e664-08d59db2a3ad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0901B7FE45A7C9D3B7FC67ACFBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: FEUEQUaKuDAd4nYsK4u0FkoIAxd3YIoHbdqJKUH90j7gC9g2OripQ+kcCPiI2YGm36cQbbqSiG4vx4Y72e7/ZDszgaeaa0wpb2Jiyqb3XE1Gv6gYsQwWCLQrwr/ENXpXQxiM35mn+o3ppVapHr/x29UdSiY5hma+SBShN2WaKOv8aYPZ9zRNq6whnyTtuf/9FPdWjw6I5Bu4vBuHmxWqZRRGCxWDp3SYgae3oKY+DVCAFNGo2BESregYCUmAtqnG7tN6xT2mwJkKQOSboGC+vPqQySlu4W9Dw9O8TOHTU4ta/UZ6l0685z6XgAevvKtsBpjYqqy0Tn7xcy7q7JPyXRjEPDRqTxYBLnhwgr93UzggOfVUzeEPqaRWeajD04HK4Nv5z2ME+KYRvFpH8O6CLNPi8kYIMlWLcluSMXbCnBk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8834bdd0-5d39-42f3-e664-08d59db2a3ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:31.7365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
index 2f5173500bd9..2800b014a619 100644
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
