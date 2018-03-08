Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492180-2-16670118714440313448
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
    t=1520492180; b=vNXD7FDCtJXjZe9ctzGMixQ9nMc1D7Cx3k34hrVRIyrIcHK
    1/Y0unu1OwXrY0F81NrGMkLWXRUIGkxSoZv2QmUp3wtEuqynNlIMPMPHjcX8VKt7
    bFXmipVuJwDzIGCU2MiWQFusU6ks5Xq7ExoXA7NoK2KPUl8dgG15V/ryYWNxh1tm
    sCLvj6Dt24ogdkprjR6FmKeF8DW4d7GtMiZNsoPKL5OAL5XTBH0LC4k7tdp6AjBJ
    MIhOhtSm93ckCHlnGrJvFamgV7j8NF6fSi2quJ46EqM6hDukotq84H24YihViFSY
    aEyWiaxMmNJY1SSkeBCxN429Ia818VAUe0/WxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492180; bh=7/uFjc
    SoaeZ2PCGlJ/u/kzB1Iqr5riyTS/4Ipf6w0m8=; b=nFeciPbJ3Jr0+PrCh8DZk8
    4tjnkrtW7IjYTYy0vuiv8MWeqwWwRv0Ey0F3xGcfcbz+Ts7D7+Up0Ncl1k3ASx9V
    EDqAKKfhdRlYzGceo/5eC2V6IyGEl1Omd/7YC+c9sVkkjvQxocF0uSkcp605B9mw
    dEXy4hnwKqLnvgKl9U921khNncBckVBwx+T1Cab8JkF4DxT+3y+R2J9cRCn+LUzi
    7no45L7A+gsSXwozhkqWFzws3VZH5Jb6745y4uD2SQojkE1SwCus+9Rt1HaOZc0f
    thLcifXRZzLDK7txN51mD8aE+ZEio+hyHrJb2Pd7+i4xL5InXMVTLT+Xkly96x6w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Gj3OPwdI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Gj3OPwdI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935127AbeCHE56 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:57:58 -0500
Received: from mail-by2nam03on0124.outbound.protection.outlook.com ([104.47.42.124]:23374
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964947AbeCHE5z (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        William Tu <u9012063@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 64/78] ip_gre: fix error path when erspan_rcv
 failed
Thread-Topic: [PATCH AUTOSEL for 4.15 64/78] ip_gre: fix error path when
 erspan_rcv failed
Thread-Index: AQHTtpnSuzUdMB3i40CdGAmhGiErDQ==
Date: Thu, 8 Mar 2018 04:56:29 +0000
Message-ID: <20180308045525.7662-64-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;20:e9ODDwRHIbMBaMDcWy8fb98PtGNp7oHaJCPZKLSBPxFqiYQkAjN9+WJDPJH7LtoQQbM90vsgaITulJXt1XO5bHYiqH7fNl+sWiKkRjj0Oo4s20LOK07+Eh5pdMtb6/toGiNvyS+fW+Foxmn3auMTiP8t606RHZtWQJ7SSe4L2Ys=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07e67a49-1b52-4bba-1d33-08d584b1274a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936A834FA9DDC4B42F8B11DFBDF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(173505980823694)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(478600001)(99286004)(575784001)(6506007)(3660700001)(36756003)(86362001)(54906003)(6116002)(110136005)(2950100002)(102836004)(1076002)(3846002)(6486002)(3280700002)(39060400002)(10090500001)(10290500003)(305945005)(72206003)(6436002)(6666003)(26005)(5250100002)(2906002)(186003)(2501003)(105586002)(76176011)(66066001)(7736002)(68736007)(25786009)(6512007)(106356001)(86612001)(8936002)(107886003)(81166006)(2900100001)(5660300001)(4326008)(81156014)(53936002)(14454004)(97736004)(316002)(22452003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 0frkygPIPIcuMTnhsuxPrCJ1B45YXsAmyewCF8AmXfv/+rAlfYITAE95GSDvhn6L0Ghrmr0QHYk6wD4V27r7FxN2NchOC/UCwXTvQI99eGvGnh8eAkw7TfdYUJzyhJ5nJGr/kuWHtcW8s5uhmnbQH9M+9MeJ6j1FggmOFLzv7uSm80ObSZdqU5Bgjyk/6Iust+UqObSajwLbsia2sAPZbAf5es7TL7F4NgwAJSg5eYRZyyOHtJCgK8BZ1/YrYzIA9S/fHJ4axYrDSBvdt/c8SHI9AZRBbl++B/ZwyWNDrBfonVcwwJyliAN7DTA5apbv8HeyFCHXG1DOMcrHMvq3yQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e67a49-1b52-4bba-1d33-08d584b1274a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:29.5855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

[ Upstream commit dd8d5b8c5b22e31079b259b8bfb686f1fac1080a ]

When erspan_rcv call return PACKET_REJECT, we shoudn't call ipgre_rcv to
process packets again, instead send icmp unreachable message in error
path.

Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Acked-by: William Tu <u9012063@gmail.com>
Cc: William Tu <u9012063@gmail.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/ip_gre.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 45ffd3d045d2..e05bca0e61fc 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -408,11 +408,13 @@ static int gre_rcv(struct sk_buff *skb)
 	if (unlikely(tpi.proto =3D=3D htons(ETH_P_ERSPAN))) {
 		if (erspan_rcv(skb, &tpi, hdr_len) =3D=3D PACKET_RCVD)
 			return 0;
+		goto out;
 	}
=20
 	if (ipgre_rcv(skb, &tpi, hdr_len) =3D=3D PACKET_RCVD)
 		return 0;
=20
+out:
 	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
 drop:
 	kfree_skb(skb);
--=20
2.14.1
