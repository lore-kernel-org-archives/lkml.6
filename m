Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118783-2-15328913064303017024
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118782; b=ABTBsx0ePuhGuM3eERPtTTMRqb9wDWnHSvm6h71SBgw3xdX
    l32b5DpLxnDFjw6Jgpsqzd48h8xXzpiXD99jDVL40Qdu2qA1yK0hmTmOG7eeWqXQ
    lXp/lEo9l5d5tmBpLHM/YDRnbxqqWVuvurZ7ohMcfxgHPqHZIcgbFtxDi6qvoe72
    I6i36jFpYLHhUrvdwGU7f9osRUCTiCnEnf9fRW+WBAQL5eE5dnDn3ORuLqnknI0G
    QakNsmIV4G8n6pDsknwyDn7AH72agJBvgxaJdAYBypYrrm8+5TcixoSCfKuW0Fjd
    xs0XpxPs7CeppZE78DKXQnwFdcdJ2wi119Dngqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118782; bh=VrAxMT
    2LdsTT/uNVPmLfR56vJvpioV6duUjdFrbZ8Hs=; b=jx+oqlCk0yaLZTSUbCQe1c
    3fLCwO0ZWz2/QU1Z1UzlJ25LAIgWFvrKqxrghzrjV/H+41r1OVnxoPcRj9zJ6LiY
    Hi2ywvP06jizJcLl5rVBSG01xOP+nvsAi04dyr+f1NLt16f9iYqoW++PbIbpL/I+
    BMCv3lmSkI2s69a9SvPVQNDb0cjzDDXdVxBMbfjyDxaOyd9icK+k6cJfuVnllYB+
    lVPCaFdMzSDplr5+Ucx2eIYsUBEtqsC0nJvmZSVZb96w7IWU1J0tpI8qETLwwlIm
    2amVzQLGIZ+Q6L79p99zlBweAQ+SOZJYDjnPnvSxaGPN2XwDAKqgJqe/nMPLQlgw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EzQPb0xi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EzQPb0xi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932366AbeCCXMq (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:12:46 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:1120
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933489AbeCCWjQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Felix Manlunas <felix.manlunas@cavium.com>,
        Satanand Burla <satananda.burla@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 045/115] vxlan: vxlan dev should inherit
 lowerdev's gso_max_size
Thread-Topic: [PATCH AUTOSEL for 4.4 045/115] vxlan: vxlan dev should inherit
 lowerdev's gso_max_size
Thread-Index: AQHTsz9XHj/f1DlwYE69pmnwuaBcWw==
Date: Sat, 3 Mar 2018 22:31:15 +0000
Message-ID: <20180303223010.27106-45-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;6:TDnBNPTrSF8KRQ2xlS7NNAg4ksTIN4l1OqqXyMQg0kQVeqCHryx+eI5bzQWn4SEy4fLNRYSx2BWnW7upaIYW/HtCqh/B3adG7RWBzRX9UG+XGQxriLUw3ILexnGP2/4t//CDqLWFtJdz+B/jQ4zzYugz0jWOOGoB8JLTtuG6G4N+wgMRao1hnKr7Zb4BNuYGeodSp8RmgnbV4y7jeSPNQBO2XYSML+pkAM8GfybadH4SwG3TDN+g6bY0nxX+48QUl/mwoM7bkgCaxGyRMeyx40WT1tcN55Jx7Y/eHMkwjTlGKKO0POnUtLEDEu8K/Vn7VGFU4n7Wze4IkYypN838R4kyXV9pI/LfvaHgY5VrCDEBgEYwn4VX5aOSIOykurDN;5:hwl8pkVkNfbMqt83RW4QWY1IkIeg/CEXRdcXKxH+8RUV8DpBLrFE05IeoRB/N5PhGKyytNuPZggt9zxoyepdvuyl+RrossgNMYipoyk5sX5amDG3ZzQPZ2gZ73eMo49YPjjJXnCjyfmrpZpwzkk3oC15SKnNDgGhC1wnWvk7iaw=;24:rbb8UHm0FdDoqgZCqW8RGZpyzb974SvNZyjp8K/rxIss5HiTBf+nrmxmgELfu5ShfIYrH/aLayFFv0Kfka/dcc+EGyZaSdrSiYdReLrroDw=;7:nGoZ8vUr87YAXxH3WK1RV5ETnouyLhtsde4cPlAGuRjgsSDk1h6HOYt5azeajGooYraOSwi60GAeGdy8CcAgyUQzUFJY6Te8a5OpnrLOQFjx+8udsl0to7eGQ+diiKPZb+IHKS5bzYvqloluPHvPWBJFf+FS/BjCt1+9l54fGiwYumG1mow1BPPcrnduooV6wQ7/PMZKF0PNABSC/iJoJ0qJuu74ahcfItJitnOeWRq5Hp0IlPVW2D0R3uESyeSq
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34098517-1303-4b85-69f6-08d5815793eb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0938FF8F4E385524AB198F8DFBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(6436002)(6512007)(14454004)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(59450400001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(575784001)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 51njhI0naw9Oj8q/hMW5QfvOu8A1Y8qLMIhZP3fcX1FOQCQunWaThgvCfk6MePONI03I4y+2uYAxxbj6Klaw6kATf0bide+4gsmY2Eq/TmpL/V1GIYlgDnxrMoaEipYEIO0xsWY/bwM5J+0k6aCdM/Bp5lKOH34qdYmbQw303Nk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34098517-1303-4b85-69f6-08d5815793eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:15.1509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Felix Manlunas <felix.manlunas@cavium.com>

[ Upstream commit d6acfeb17d030bb3907e77c048b0e7783ad8e5a9 ]

vxlan dev currently ignores lowerdev's gso_max_size, which adversely
affects TSO performance of liquidio if it's the lowerdev.  Egress TCP
packets' skb->len often exceed liquidio's advertised gso_max_size.  This
may happen on other NIC drivers.

Fix it by assigning lowerdev's gso_max_size to that of vxlan dev.  Might as
well do likewise for gso_max_segs.

Single flow TSO throughput of liquidio as lowerdev (using iperf3):

    Before the patch:    139 Mbps
    After the patch :   8.68 Gbps
    Percent increase:  6,144 %

Signed-off-by: Felix Manlunas <felix.manlunas@cavium.com>
Signed-off-by: Satanand Burla <satananda.burla@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/vxlan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index dab3bf6649e6..e4ff1e45c02e 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2834,6 +2834,11 @@ static int vxlan_dev_configure(struct net *src_net, =
struct net_device *dev,
 		needed_headroom =3D lowerdev->hard_header_len;
 	}
=20
+	if (lowerdev) {
+		dev->gso_max_size =3D lowerdev->gso_max_size;
+		dev->gso_max_segs =3D lowerdev->gso_max_segs;
+	}
+
 	if (conf->mtu) {
 		err =3D __vxlan_change_mtu(dev, lowerdev, dst, conf->mtu, false);
 		if (err)
--=20
2.14.1
