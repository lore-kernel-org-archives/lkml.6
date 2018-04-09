Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236525-2-4458358264810105415
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
    1523236524; b=oVLQ4NzoJb5gOfCb7a1AL83ABxFf7+sWPCrmVzfSJ1eqdl16XU
    zVfObULJfftyzMqY65xUFVFdHHwtm2stOlz4ngyHPinVoYKPZFeHS6Radcm3vRuC
    0IcMHu/wbORBShTKVl4zvfzB9w2f4jQZv4WYu+czgy0MaQfKwBPhHi6UExR55kal
    4m/YQL1WJwKuL8wcOpJAZPdyW1fsU9bFw91jYG/JxD/uVJILsIgsiV3SUjI3dTIR
    RbUzOqsgTAbT2SFv/xT+6F36F5o9XfeehCJ5J/4yGTdjuGbSZl29vcDolgp83UTi
    0LKrhgHTzKOV55pIIZfZDTy3kAPMmf2q15gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236524; bh=B1igtjuQFr
    DHBLBxodMJSweTYpWN8RPOP1VZ5/2ud3s=; b=B28l5/uRK1/0BFlHrItg/SoLGR
    5oX+f4LR3qi23kVpr3q+gm+sBluqG0dSM6rQr1JuRmDnVhyGPFg1S3ZRuq7c8yIE
    8DQgE+IESSmPCHSnrggFIh5kyzVNrjWDG28txQNsDnxl1gm8W0GYEJjyhKjAN6yo
    jB8WFOjBBqS4nrE0yB9qpP1jkoHQdo+i+VOBbxci+bZM130BdQ7eWJWREMkEc6dT
    3n5HQ3RkO28EoZurgAMUHxEa7Tn7rAhHd1Z2XNxK6mNKChmMfsnCTDf0vRzy6E/w
    hUYPCcr4p2nodVGbq5axPcJI3GXifnhaLMpmZu4t1je+h/Zphnx6VgzSQu2w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XNuBuLW9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XNuBuLW9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF/rguereoFxMJJJoTkMpfQM+3rNCDo/rOBGX2T/bhZna0LEGaKuH+U81PE3BpbgVjVXAnBO3UxOldWAb6qhX4C2PvM+NKZbO8tejaYbIp5C2vLbqJAi
    EZYTqMn1mHElja964lgcVfk1wSjhWzPtm8yInvsOgAiqY34Vc4NA6nK2E+yXK5wS6o75mHZCvNzvh2Pfyx5jCRJ1ocbA6seJBtQQ7bXiPSxk4jTqMfksVgVC
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=alC0domXPAuWEL2TSGoA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756733AbeDIBOu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:14:50 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:3232
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932894AbeDIAh4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: mulhern <amulhern@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 116/162] dm thin: fix documentation relative
 to low water mark threshold
Thread-Topic: [PATCH AUTOSEL for 4.4 116/162] dm thin: fix documentation
 relative to low water mark threshold
Thread-Index: AQHTz5nJiuuzGr1FL0+TCkvTTd64xw==
Date: Mon, 9 Apr 2018 00:29:14 +0000
Message-ID: <20180409002738.163941-116-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:FXZB6oDDkQINBlDWsO/DWhQXVIOSBqUgJZ+RpZcOVgGMNO/X9owKVCXHA6z/qwM4xH90kZBquqbbzWP3lA2njzc6F7w+E0soU97cjrqng1VQBkyGuvtwnmPhCYVPtirrh5eeeYZOpV3ydjAgcwr7OutYqaZ4k8cFCSJJIil2RyjevyRuUI7faOPqwlYx56PvBmN1R6aLfI8kcWZ7SCNA4U1qjioiyl2SSNKSpG2UrwOPcO/22K7vEeFtgtzD7uxt;20:xdCx7LZ4szY7rUjcXc1fyywinkbt1wr6EbGODL64VZCsEakT+vPsTCgIqcxEWs2jy3k3cSseZdNGVQiebIcDsMUi1Cu5m4cteMDMwWg3GvBKru6sjqc/FO+eUG+oPXU0bzOPImWb2jRKD1MD9cuVl7/LJI2OPdo1qaVjtP/X1qU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ed55f50-41c1-4727-9ad6-08d59db2210f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110D27BA115D45196860F7CFBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(186003)(5250100002)(105586002)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DvaoKTgySFZLWTz29Q+btKPQ1Lk/fesuWmgSv4i04UILZjv0AJ5Tp7qdQPV3NnWiZLPSCqrrHIXXuICDhbS7JKG3UUQRcXAx3PvBIprNYsQAfcSjAGZHd8HItXeVvcD/E76BMZ1nPrdO1yhfMZgZ61rO1VIhnJmYu6ICpDD9TsfcEfOnuHbdb2a/dBnlmRU5e4XmEDxwrPPapRuqigI2Es7/QZsXItyTbW0fs4MzJd3Vp+UngAjxn0DyxApMOuuUhitrKM+l/BFNAWA26wETPLmaoOJoU+D4n+YMBnjr/ANzRXNcDXRMeXkL35YixBfJsdCqUKzlUiX2zjBE53qE0epcYyAox1VCfwKppJANkxx9QkiRF8mmYzzNhO1WLqLOea3qDpfiR+XupCuB1Leprr4HNByFvZQCw/H0tifzZm0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed55f50-41c1-4727-9ad6-08d59db2210f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:14.9742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
