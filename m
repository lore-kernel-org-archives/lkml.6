Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489815-2-804354578058456159
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
    t=1520489814; b=wVdRIFuTmgbms/BMe63hpYc2lXBnLwAHtCjqi2ZAnqTn3d2
    hJUlX/+lMyI7MSSrgF9NIWLji1355c02ZcxeivKqWX/HsGZvKBk31XLp83mqttFC
    kSaUFdPDcv/8FE1iIg8k9TuIWOnvRa4MV7DT+lMXgezOnmGXaRyQpV1HekjcVtFu
    yD+KCotmZV3e5AuY7kKnxAyiAARPmWrtLQUffhEWjp43NtRGatTdtwFGBaM0gHlL
    eyoS5avYDMWaXXXwkEyuU85Na9fEkCoSi7kxzd9oF3Hp6O/DVpbj3wepFEE2eXDl
    KTKdv+1TXptNOssk73YI1o3nIxkeh92VkmzJ2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489814; bh=krJ1fA
    E+1HseJFg5UbSxvll2ytqlPn2ROl/7WiYYj6M=; b=CK6A18irGu3opjh4Fh/UO+
    cm7NQw9t6/aQYAHp6PSxDW7Tia78ipWtfEZZXm27Up6zTqBnAYHIPrD2aaDj57oV
    H6f9pFBU+w488gRuvtuLzn/D4kgK8pelYGyxsy7C5fqzxnO3+thYDZJTgTWH5N+O
    NDuZ0kwSD2FiCPaL6P1HCh952UBd+45MmzYHdKLd/34ZexPj8Rp+O5a/xDQkZZDz
    FdOoP5BsSSsb/r5+My7yxNKMPwKJ9Ky6dq+CsV4hiCh7oTWQOAmq3cAedvV21oSR
    +oJtXefwvGaILPyhivhy1y7dSmYjd8PyPBcUciqSNUnvGTvLm+C5JKPv2TnUouNg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CFgRwi8f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CFgRwi8f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755187AbeCHGQX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:16:23 -0500
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:20160
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751187AbeCHFB0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 071/190] netvsc: Deal with rescinded channels
 correctly
Thread-Topic: [PATCH AUTOSEL for 4.9 071/190] netvsc: Deal with rescinded
 channels correctly
Thread-Index: AQHTtpo5ACIm3cUmRUWFfuVLdKDAjg==
Date: Thu, 8 Mar 2018 04:59:23 +0000
Message-ID: <20180308045810.8041-71-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:7gUhlfM11jUqQoB2vDST3o+jblsLFxggQB05mtT/Tt511rDCzznI7ufwPg2XHw/QdVfE8rIoJH6oL2ebh22YPBsureqxELJ2awKJMcS4NmokOyFUZml/ln8Rgg+dtgcbf75nQeUkjy5JDk8enOMmWESe9CZlr8gmnglqVr2A0rNPM7VUU5CzKcLVXYit2trCw5G7vlWBrVva/JZIRL/dq5NQ8++Fn+n/Zq9oTIwdDw4vSJZAVnlBnfvQF85OXCAI;20:ORLQFiXy3cJQe4GnJZmKPhCG3xJdwQWE4XoJGgxye7ZGD1BzOsFG67u3IgUL/+SWGDjWGXf73yqO5Sa/Ah/zj5BdPbHV1w/ichfVwi4QBWFEpQK7c/l6Re3wn2lhWgPAlImAxPErCd0GOhlPScp2ORUUI3BM+0GuyqXVDTftPbY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48396eaa-ea83-4c06-8c60-08d584b1a441
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0901392732F4746E238E2C7DFBDF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(189003)(199004)(2501003)(5250100002)(99286004)(10290500003)(53936002)(14454004)(72206003)(76176011)(97736004)(6512007)(106356001)(86362001)(10090500001)(7736002)(6436002)(8936002)(6486002)(36756003)(110136005)(305945005)(54906003)(81166006)(105586002)(59450400001)(2900100001)(66066001)(6116002)(22452003)(3846002)(1076002)(478600001)(3660700001)(102836004)(81156014)(6506007)(107886003)(8676002)(25786009)(68736007)(4326008)(3280700002)(2906002)(86612001)(2950100002)(26005)(316002)(5660300001)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: +5quT/SSP7mwqXno5zsal0EpjQELweI1Gr7qw3SLWCaNgkuP/G4XNHPWe+qAFQYfN7NN/AE0IrT4fL2sqfumLkWaDM5hzslnaQbHrIxJjQ66uRuszFy9KSZu0rVxL5/dlr1NLlvrImH/HNA4eisvhXmNUywgmdefhJwUDw5AgIIR3efu222lAJZn3q5uhcFEeB5TzwB9gpZF3fH43mDLg/h36Q4+Z98sMZJwY3OkvTE+bZy0+GcDSUwc+FR/84jsRyvk1Y5utyVUahn7UIQSy1GT8MRJ8VyFQdNsrX6fprFuNFCQdFZUvb/H/BM2Drn+u23F2QfkH0b6e2/W5jrkNA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48396eaa-ea83-4c06-8c60-08d584b1a441
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:23.2093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

[ Upstream commit 73e64fa4f417b22d8d5521999a631ced8e2d442e ]

We will not be able to send packets over a channel that has been
rescinded. Make necessary adjustments so we can properly cleanup
even when the channel is rescinded. This issue can be trigerred
in the NIC hot-remove path.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/hyperv/netvsc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index c2ac39a940f7..14f58b60d1b5 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -151,6 +151,13 @@ static void netvsc_destroy_buf(struct hv_device *devic=
e)
 				       sizeof(struct nvsp_message),
 				       (unsigned long)revoke_packet,
 				       VM_PKT_DATA_INBAND, 0);
+		/* If the failure is because the channel is rescinded;
+		 * ignore the failure since we cannot send on a rescinded
+		 * channel. This would allow us to properly cleanup
+		 * even when the channel is rescinded.
+		 */
+		if (device->channel->rescind)
+			ret =3D 0;
 		/*
 		 * If we failed here, we might as well return and
 		 * have a leak rather than continue and a bugchk
@@ -211,6 +218,15 @@ static void netvsc_destroy_buf(struct hv_device *devic=
e)
 				       sizeof(struct nvsp_message),
 				       (unsigned long)revoke_packet,
 				       VM_PKT_DATA_INBAND, 0);
+
+		/* If the failure is because the channel is rescinded;
+		 * ignore the failure since we cannot send on a rescinded
+		 * channel. This would allow us to properly cleanup
+		 * even when the channel is rescinded.
+		 */
+		if (device->channel->rescind)
+			ret =3D 0;
+
 		/* If we failed here, we might as well return and
 		 * have a leak rather than continue and a bugchk
 		 */
--=20
2.14.1
