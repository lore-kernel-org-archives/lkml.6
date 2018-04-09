Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523244211-2-3420527274276938543
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
    1523244210; b=GTtOBPdQfxnnM+kTQwvRnVIgMNIcJ7qnhVxCj6iZ1DDUaVIDdx
    q9e3WoAnw+Q/qIrWXmkBxOtCFjKXDZ0Jdt6tCCrBIQP9c7hDcBa8Ud3e85/ojgo+
    w3A4xNuPt6FCMXuOgNRdGBY+qdyix22oGCoUvV+nIwb9EXWmfxrXqQb9aG2u1gMd
    XMdT5Zfh41AiuIHYzKAJLaQ1YJH6hrylo3CN/OmZJ1oNgY/MKlKfbVdei8/pQiDA
    duAUKBbU78BvRoY+a9VX9amB+x/BtW0Hm3UBvumvtx7h0Wd8e5A0UEP8nT9pEYbO
    xw89e/CG/PyZLcad9Ryl/+trDvZpySVq0m1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244210; bh=B1igtjuQFr
    DHBLBxodMJSweTYpWN8RPOP1VZ5/2ud3s=; b=GkIeC/RO3AUsYolPAtqh9lYFtc
    z4vB8adZ5YeP0DmdIEH6SNcZRlhbELz+3mlsLcipamJVbIb8+CrlB9Y1yjYvTdom
    HuW0t6JndYR3044+hS5NphKcfA++sqZjsCTk+Y5JS8GQBUb+QqrzvQ/7dw+WoaMR
    7U/PGcqaaTXSPzVU0ukHtwct1Fgo4LvpmQHHpdL72RqyZrVByDdK0IAPkMFbtbSY
    n96MNetm5mg8L4e3u0pejOMuoSOIGv9tu6TAAgwkUfN6s4U3IIdEQ2brIkl5vw2Q
    2evDQqkUR6/wH7/hXBPkDa0NXRUcgIeTQRhBy2Ud8T22tWQBbFDZav9S/Vhg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HakT1W1R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HakT1W1R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNTHepKshdYLn3JJmkPd19BpWiSC+IsgyTeEUI4a7OqimFzP5hMP7Uo8vn4dgmjxFDTs11meVvcUWy51/1tLqiguuvKjAo6rGaYo+6ZCl7zsOYOY+1bz
    0TarfIaYYKxeoeiHV02zfeJ16VXwOXI/+/W2988qErJPl2SGQgB09+46lYPVgwqbo6RPdNMk/H9E+8njrdP0uPi/oCuNht4OK3KCGczNqQrhl10BSjYqkf65
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=alC0domXPAuWEL2TSGoA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754738AbeDIAWw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:22:52 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:20813
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754709AbeDIAWt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: mulhern <amulhern@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 032/161] dm thin: fix documentation relative
 to low water mark threshold
Thread-Topic: [PATCH AUTOSEL for 4.14 032/161] dm thin: fix documentation
 relative to low water mark threshold
Thread-Index: AQHTz5iEjGiVTWR7Ykalw5LQdzXY8g==
Date: Mon, 9 Apr 2018 00:20:09 +0000
Message-ID: <20180409001936.162706-32-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:gyRKnqXLDinlz0a/dB2lkGps4BzqRf09XP2yjAXiCGKqFmLumwH/FnPmkzTBALatro4pzqzbub1RHbUAlJRSCJS41PKtaRtcGm3JfG7iFoVZltwFtgN6zR4oi3SnDxccDaTv7sezA8xGb1c6N34te3cb+7j/F8rEP/07dOOL4z+dmwVPQykIBw1QvRCJwKY+2cLdg0h9WO7wdmCRAl/i3q1G2Rc6ozG09paIHRwdqTTQHKoqNbzHo1M2mgz2lmTA;20:HvDag95rIin6hOXmufA8nn1bQ+iISyWPcpmZj3YUZSHcBbTJruEoukSgxa6n02rSyaoMg4OxozKYGW9P5ZzRLElp+UpSL6DMZyAZzMR6D/Ug6C+VAlvroUB8KW2pMsrWdeFgA2J4+tRJDp2UP049z+pufEhi3hu/XsaR/Yd8ykg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a33f36b7-a589-4211-b03d-08d59db003ea
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966803C49831A958BE0D6DFFBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(59450400001)(6436002)(186003)(6666003)(2900100001)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: OjbsrDRX5egSYqhX+2UfAXvO4+ewfqpqlmNMVkWnjIlozJTBwnlPQyQVVc/cCjAhaD2p2TqiQorF4nmCSfE3Vv7+irGQ1+WPI2d3iZIzvz9RaCSGb2BQ3E1tLGcDIlFAmefZxh/EoeKer4MzMuv7XZl7Yy+Ia2xQpeCgMey7urwyTLI7Voa1Fo+3guDKjsGpYi9BifQD0Nu9wd9f+jLDR2Mv/6daaZqOrvTE0IXImVvSeneVmlkaWC3/DG88oxOa9lQko9sUoUAMpeL4ERO3XD/K9af7/6J/tzx7b4lBZa4ACldH57QYYncHXXAWyrJ/pcBJ+DnckS5ko5NBKLkC9GWMeYWlEaSLuCIpNosJ5CmWeMg7I9MpOvDADCKagpS1rFDSoy01i5XiI084sIpV3M1wEEGb1AupCfsRy1I7Ygg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33f36b7-a589-4211-b03d-08d59db003ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:09.2853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
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
