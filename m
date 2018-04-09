Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238956-2-15344235547287034937
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
    1523238955; b=mgn2w4W9VY3yxWFlxwt9sxr4gf4xv/5Ai/IcmTwGNPgEezvHoh
    AnHnqeDFcaslhV1iPrFRAs2KlXuC8BZaPgmJaNC47MUXcRWau+IO51/ACgEDkD3A
    C3gMRdlkPbxEB7mDPmVnOlvGxgub9cLyzVPmhb8uMB/275RQf4GDjKs2MJxS4Crh
    0zHRr8/2Pm0ed5X5OLKZy716dLpej+BTCzCFz+CPp1gbwO+xC+ixcnpICC02Vxf4
    39W1Lrg3XoyTOdP7iI75v3da+RUeovDfXjEjZzjq/8oRzUTEfVyW2nrRgRKyjV5r
    ctk42ThUQnmGyHV8vozVEbcGolSNRPg8NPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238955; bh=B1igtjuQFr
    DHBLBxodMJSweTYpWN8RPOP1VZ5/2ud3s=; b=T0BWfLTb5HI2FCmiYmvKh9lElc
    QjUjxv5CafZvFmOFnaFMP4wh5Q0Q8+3ol0/SB5A+7snVdMEjDwNjlRukdCKG1473
    becrqnNSHOn/mT0pa4ur8rfncGtM4djnnIQe0bVUctxLBLAqW/Bnx/I6jcjBvsYW
    dc0dKo3eQGWtKRZSskTSPs+vdZJZ/xnGwT4zBoUht9xMz4cem1mx/UIKZrLCHlWf
    JiLCf70inR//1LXaUTuRrTsAIb1mhHEwIMY2CDHm7TfD3bMaxA9AW4VqAa4kTUnL
    q5M8VKYqjk1WmwV03Jhf/QcC/v84hDmOsmfVQegDvD4JtKOoq5RxlKKHV8dA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mlf+evzk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mlf+evzk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJpL51sJFEDsJM25p1f2Tosf7f/AeG6kOjaO0JRFw7k7mQIWvxHzPyysVdXryDM8KRbCftgn3nkB7h2dlFRyGMxM6j7Qu4X2G8XHaDAgT1G2TjiF2UCe
    Ce/v2r5LkIfoYgFpaXXBtiaIi2wM471evaAwCiSEu0oH8cgPZyKO7we05CXSB4XmHJQCepJYTskJ9gp6MeqJFkzhGO/ZIwZA4uUOMA9l4Jb0vR0Wv3qxOVQO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=alC0domXPAuWEL2TSGoA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932224AbeDIBzl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:55:41 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:22599
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932174AbeDIAc5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: mulhern <amulhern@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 226/293] dm thin: fix documentation relative
 to low water mark threshold
Thread-Topic: [PATCH AUTOSEL for 4.9 226/293] dm thin: fix documentation
 relative to low water mark threshold
Thread-Index: AQHTz5lQeDTjgKgtekqIApcQBO2twA==
Date: Mon, 9 Apr 2018 00:25:50 +0000
Message-ID: <20180409002239.163177-226-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:oZBtKnEXyrAENYxNQdoOmpHTmuW3BZKA8FNQ2QwVMdmMLS2MhG1gs52mKnHTdVhj8QN+LrMpUceZA0Ub6S9XDdec0hPG2LE29Yj9Z6ixvfUw212tb4EqhaxFKtOC0Tw23oQpIXJDC1WtIIDoU8XE+gxePpVvI+2JYLY9weSzpjm5cOddNLZCDp0zwklBBJGSrKdZcrwV2XxeSq0h22I7JxRdu0s1T1pI0LatkDElDuftWMYQFSVmBtXafXgGaMAC;20:nfENqRj7hGmienOx6Abhdy9FyAlxAw9lR1NOqi+Y+zHDVEhmJDpD2EE6NLRvKpf/OH24ijNufWudYElQsiJU0wblq14Ll7E1t6juuljV1iZuaiJfs4F76KskXDXtM/mEvbIl/c3pjVg8OpfK9d9LzR5upkYPXRg77kqOey2uww0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd05d29f-8e0d-421b-9c5f-08d59db17039
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902C404818F3F7D654A33B8FBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 85I0FpJL2Ujt4MZaM5y4z9fBw1xaBhnu/dwdkC3/CoVMezQXyqExuM1oqrfkqFre9OBHvca9yQ8JcqVb9BFr+LdAiG8jDQqu0NWbjnzuDOf39IJMqZ6Rs4g9CAIKUuS5b4jX9W9hW8iiDdRJU5fZqk6zaPHHTvQyT6hl2vTUMs4b/Bo4XgCQsKx0WPxdBEH/jE3oDqmMTIR/qfr7O4LUVSb9nC194eJg1tHcLpdcL6fKNp258LOoFHD2Z+O0oC3dme2SgNRwjBobZMJ/8rTEhF+fi9V5F+P8MtXPk4oArLqrflfGKgS85HW5I8cBzXpjjBzRQmd73gpZ6yvj1HRpDWQB+YSNarmdT7mV351/fkBo0YhaeRDEnDDvDE8dB3PTn5zUM4ZXzrO1jiVciQmrwSJgQJ3s24lI1jDcVdig9EY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd05d29f-8e0d-421b-9c5f-08d59db17039
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:50.5192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
