Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481408-2-12370334761293693185
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521481408; b=RSU7HSw33Ozbwo1zf6WslF1MUPjtjNChS10BhW67oae9lyq
    HKe15laJqtWexKvJjtjvpoCjm2N0YVojHw/DBgWbdNih7aVmsAjEhe+2g4d5JSqa
    7WnNQRCIHUbK7TjuyEcdj9ylLIpwByjLUSeADlKuWTCrqHsEhwf4Zn25dlW1+tCo
    5tKa1YQg7rgfFm9jd1GXOd0ZmwIvUeK07+VINN0gvoQsWb1ZbFQUZhUQ4rW0wOuQ
    9KP0f2QRTIvn+uwyYLI+wRu9dVhbPTFOwG71cdMSHcKr97EjkB9C1a9l7hvs0aZV
    z4UpU9x+rNSFr5sBeJ2+VUsowMXY3S0Wb0wVsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481408; bh=3Kh9Qx
    H4jM1J4DFHozNX5BBd/AGq2xmAzBIQt1WtOa8=; b=bWuaS9lXz069JlOMIV5ELv
    N2jIaD/WoqSIAfGrKO3PGoiGfzATpSkA6AA9YgRTdoeK29V7J/DdAsjBFczK2OzN
    +dxkZalvLasWwiz7FLhBJGJwZmIdhnyxnVYsLxlW7wWepaOEYJUV63yXskE3rjVn
    lVhDdoLSEspmquoM9HP5u0PwR3KT/39fxQA8tobEwRLlQyno0ivfZ3fb2N+0hh+O
    EVoQQT4xE0e8n+MYi/wQ15eDqmPIIG7erDVIZIaioZAhG2FVmdRtJtFODU6du0Ad
    W6CJLKGVnrCP1bvDjKBs35jGYXN+te3M+jsBaHym6nVMIJt0My7KjVGIGlIVp5FA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bF5C678c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeegfeenucevlhhushhtvghrufhiiigvpeelle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bF5C678c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeegfeenucevlhhushhtvghrufhiiigvpeelle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965650AbeCSRnZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:43:25 -0400
Received: from mail-by2nam01on0102.outbound.protection.outlook.com ([104.47.34.102]:50048
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965830AbeCSQFo (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stefan Haberland <sth@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 257/281] s390/dasd: fix hanging safe offline
Thread-Topic: [PATCH AUTOSEL for 4.9 257/281] s390/dasd: fix hanging safe
 offline
Thread-Index: AQHTv5u/W7gBFDWYnEyN1WLlY+T+Qw==
Date: Mon, 19 Mar 2018 16:02:58 +0000
Message-ID: <20180319155742.13731-257-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:9CfN70hA4OEJwO3sg4vl0/TTvhX/2yg3O5yrlgmbwktiqbDN9kReGxUv26NpKroOsTNFEBbcEVk8mq0CXJYWc+k+m4RYtMH7WrCoQuKc1ZFs21Q3DOkeKKETzKoFyW0N3hfJad993tULDpTfMIUqh4Bf9rdfKXIa6h87ebGc5X2uWfJgYlCevc/aYJJO/fyUZ2n9qqV5MaEoS7CfdHG3/NI7og5hmgSTX9NoO7Ft7HNBlG5Q0134BTX9RmTHmgLu;20:p819dzDXEFZCiFV2DgArmi7/wjx/CwDH2zzU1ChL02VBa3aFc0h5PUEr4KbnmQGLB+2OeHhTBugdbBGfYOEiOC/wI+ZwmUNbqgIpqy/GNZVnUiGcEELdUq88KIy2RTslC0gUTDAc6rir7EkA6OAr2aqZKbCSKKxoZZJM4VFwY2w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc3582a0-4634-45dd-ee4a-08d58db3405b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07285CEBA354F8C7ECCE9775FBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(43544003)(8936002)(99286004)(478600001)(53936002)(107886003)(110136005)(86612001)(72206003)(97736004)(76176011)(316002)(3280700002)(5250100002)(2501003)(36756003)(2906002)(105586002)(1076002)(86362001)(14454004)(6436002)(54906003)(6512007)(6116002)(6486002)(106356001)(3846002)(22452003)(3660700001)(186003)(68736007)(66066001)(25786009)(102836004)(4326008)(10290500003)(26005)(6666003)(305945005)(2950100002)(7736002)(10090500001)(81156014)(81166006)(8676002)(6506007)(5660300001)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0njVghYbcBPBUMsgWj0ti0uuYsbuRHtUdr2xt9ljGg4WZqf1CJ3IYWzdI4vxShqRva5ViojBjKGQf+NCGbD9JTqdyT7kMmpo20zdEIqUz83tN7KXtbRathmryNTonhX3ScWg1PyeMKIyuNFMU/V2q7bktHv6dimEwjanAeQ1ZYagIYqwq6wbBPcA+GmFCgAe10RQ73iJyIM+atOboFT7N/wkb2EzTh49Igp7JmTOomE1ocLUzSZcS8xehQc7yKaAbZz4znvERW70Ez+oC8I6N28VjGPiPJe5lMQ6JDb1UCDX28Mh/+CYR/aimz8sQql4JD1g9WSuKqIwUGkew2WQqA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3582a0-4634-45dd-ee4a-08d58db3405b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:58.9061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
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
index 5ecd40884f01..0da246505f70 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1950,8 +1950,12 @@ static int __dasd_device_is_unusable(struct dasd_dev=
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
2.14.1
