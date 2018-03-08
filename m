Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488889-2-3816128559979807146
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488888; b=Dfp615cAXXga5AOx4iznH7HSEVWgEJ5i1b+MX9mAtbUpUd5
    /8XyLQwjhXppJRjyuc2Q04aJgFrDT1dHMAfLT0fD9hG6g91xFQbJ0r80gQjdWBuR
    p6AG81PFQNlny0wXYWrrEzk43cMDATDcvc1qffp67LyMv2s3Bi5pWTnzjJrkKowv
    OwKxAPnHo3ikR+pyiU/ljk6jcXcIzX7Gzf8IxlkGAfRAUuQ9R8hgTzWHAT/AlgCi
    PZevga8WEWHaj/XgYImzDLB5xw9T4Tch3mheazx+FTWGylYYYP3IiaT9o0DuZz9+
    jkji0Mm0ETD+32hKfCWupxZrQvvASRiBeMDK5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488888; bh=LNz/u8
    3Dh3ebbP0F/xVEi292MMqJ3Ox9o70c3F3GPRI=; b=QKEjfGaOVuIhEYlk3QeNq0
    UvPiv901dLnGX6WGYLTnkhetV4UipjLYpnyC0pEaNMTFjEifUDKd4vnIF4Zxw27l
    ciGQ+jY/ZWiSsqQmERfqFhAlJ7kBeg2I9JVlCqNvkpacRv18JxtuGdrzQ5ezRF1F
    6gw0jEkJcJY7XZTwGbYu+rrehQ7rlRGC7OM7dEMN1zOfXB7j75T66vWMatS13dYD
    dX+T6Y2qmvuefOe94eAn/sqpBaCu5lm5fF9sF3metrYaJ8ylupitoHgOnm9zF31g
    QdK+BfMYLm+sCFCfcP9sIBw/OuH0htuHGXoMlf6hEm2CYVfx8qhum4mUYrNfc99Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZGCfZNeh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZGCfZNeh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965755AbeCHGBZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:01:25 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:54752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965927AbeCHFC7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jiri Benc <jbenc@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 125/190] vxlan: correctly handle ipv6.disable
 module parameter
Thread-Topic: [PATCH AUTOSEL for 4.9 125/190] vxlan: correctly handle
 ipv6.disable module parameter
Thread-Index: AQHTtppHwNnID05msU65ToeJBP5yAg==
Date: Thu, 8 Mar 2018 04:59:46 +0000
Message-ID: <20180308045810.8041-125-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:TSdlLU94NcfCdBoqf55nzLkI7NfuGNcFxFzQjDcEclqeyUs+NLLpJUyptjJEduEMqv14Hai0F33WSl9UqMkfDtNKuIFS5wUlXhzGPg1+4CuX590GZSfjDwlW3JvmBYGKjDmVvQnSpJiU9nTbgou93JagqjpRYa1z7oNiJPf/xrbzRXEmnAIOqB2n1rXtMP/6jKclyhYHDCNediYWHLvj9p3aBgXz146aCLP6+Ko5KIsE2LeCrGFMlKwX6y3nJT/M;20:11kiuebHvJ3inX8H6PhCz8KLjO5rBN3xBZdhM8dnTgI2N21v5mycr8ka0/aaOVAZvBIiqITBmb3JageaGGrHgI2Vcr3l47hZCTjhTXIICzAiO3EeuyIhaB9G8hwKCzfMcUxKIdP+VuOBxxZY9lqo+TtAoKmITcmJ+jbDwJPNvf4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8383397a-35f1-4c09-211f-08d584b1db7c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10130FA05DC90828AB99D496FBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 7hQ/v1YFwpcokFlmNOjv4/QBz2mO4zNXSIvoZU2AQVcRJbgE5bb4M4OMPBn9F0N0JR98GFzT9FkpeqLtjPNkHPCUqgdjzFXcQd4Lyq9MN3KiplVXE+sZiPTdxOWqlWOfwERvw+LtbVT+0wnNwZSDOdzd+ufa6pkDEDK1UEq3i3xzvQRv5LbjXoEOkWQABhvfbfZVgL+pGUs0Q7HTXp0zA/4wyqrNW2F1eekRJLgNQdAPRIcAjW5CoDe2TerGGJZzDhshc2ZHj81KS1tY82UZLvr2L12KpGcLlqYygqbqt6D4Vh2Xrgb7CdiXEbQAjIgUr9DujY46lmYFE+VR0rZVlQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8383397a-35f1-4c09-211f-08d584b1db7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:46.7490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiri Benc <jbenc@redhat.com>

[ Upstream commit d074bf9600443403aa24fbc12c1f18eadc90f5aa ]

When IPv6 is compiled but disabled at runtime, __vxlan_sock_add returns
-EAFNOSUPPORT. For metadata based tunnels, this causes failure of the whole
operation of bringing up the tunnel.

Ignore failure of IPv6 socket creation for metadata based tunnels caused by
IPv6 not being available.

Fixes: b1be00a6c39f ("vxlan: support both IPv4 and IPv6 sockets in a single=
 vxlan device")
Signed-off-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/vxlan.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 983e941bdf29..817b22f913da 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2816,17 +2816,21 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan=
, bool ipv6)
=20
 static int vxlan_sock_add(struct vxlan_dev *vxlan)
 {
-	bool ipv6 =3D vxlan->flags & VXLAN_F_IPV6;
 	bool metadata =3D vxlan->flags & VXLAN_F_COLLECT_METADATA;
+	bool ipv6 =3D vxlan->flags & VXLAN_F_IPV6 || metadata;
+	bool ipv4 =3D !ipv6 || metadata;
 	int ret =3D 0;
=20
 	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	RCU_INIT_POINTER(vxlan->vn6_sock, NULL);
-	if (ipv6 || metadata)
+	if (ipv6) {
 		ret =3D __vxlan_sock_add(vxlan, true);
+		if (ret < 0 && ret !=3D -EAFNOSUPPORT)
+			ipv4 =3D false;
+	}
 #endif
-	if (!ret && (!ipv6 || metadata))
+	if (ipv4)
 		ret =3D __vxlan_sock_add(vxlan, false);
 	if (ret < 0)
 		vxlan_sock_release(vxlan);
--=20
2.14.1
