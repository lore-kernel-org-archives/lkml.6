Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485841-2-12143664648055302689
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
    t=1520485840; b=kHPBPTopo0ghxelUHsDNo3CF95yZynGpfPpMFRiTJrxVt4r
    8I8TKcSN7NrC+1r86jZe15yb5ofRxDKhm42IpRvF/GTR7hQvi019PXfe26NIfbSO
    VkeO+jMJwCxLHXQtwsa+azQuQNPCh5K6sfQZM3Be47rLk+PL0Ktph7hIysO+RuM2
    xkxxMxpmTqw2PRfytiih4dQ2jRljySgIRHE1mHexeMdSh9zxAJ7XDSn7A4nr2lqf
    vNEoAn//qG3kISUFxTnEsazUfRiCXj+zRfr7YNA/DRb15+f23BF60Fol07GGzRek
    8EWuhxXVvvv5WZc1rOk05nW+2YNMCqWgGl3kGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485840; bh=gP8Nkj
    z1xRnjXwdp3W23/UP4CDX+Y4cE03UK0X2bMto=; b=MrTvJdRs36H3+ylefKvtDu
    TsBZSQ+FFd4PSp7ZKl1Ek6TShmXNbNv3hrTki06xdydwDxyTuS/KHk+L6bD9S50Q
    aRGAxkRtBk6PRqcBANq+w2dpVxSUXCLS7oYprHXsX6Q8kHVQffjIwimUDqqXkpKC
    jb0D9szB8aFPkeSqHprgLiOr+HfcO8Qf/S5VLlhxVjiPpnq0wtUTYCX9IuU5loly
    huKuCOuqfifvYAeHfcbA4rDx7TFv+H4XjEzS/RoThlh4MEEHNrF5oWO+E/Rc6TB8
    DNODf6A/PF1bdbUJrCJG9WSzN09B38FMUyI5UQUAO2Ql2knmXeQaUBuOjoQcmUgw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P7x+4/QW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P7x+4/QW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966451AbeCHFK1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:10:27 -0500
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:61856
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966278AbeCHFI6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 25/53] HSI: ssi_protocol: double free in
 ssip_pn_xmit()
Thread-Topic: [PATCH AUTOSEL for 3.18 25/53] HSI: ssi_protocol: double free in
 ssip_pn_xmit()
Thread-Index: AQHTtprFik5eEnwK1US4dIADygiSgQ==
Date: Thu, 8 Mar 2018 05:03:17 +0000
Message-ID: <20180308050230.8876-25-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:DHsukCB9iVUf+8PKQTeX92Xe5pKWkfrzsVvJsSgEyckPN73T+du7BeXN1k1SCTBI6xCDrFGx8tKWKKAE+ET+VU37OqqBDRHtTlWeOF3sh3H/bn/s9H7zTWQdIBGNnwpw0z6KX+ikF+eMDB3Dw1cl4YU7KCYzFq2dH/QJQLIwU0Y/i4DrulnAsWSWhs3tA5sSSJkkYn7qT3TyRYcPNAd49kr+xHs7ehqkavKM62OKCJgB8w3WPJ5LbiFCAKd2adFZ;20:WQH87Jf0zarS3/U+MAV1DCj63bt+tOoZHkFzDYfEtXozK2lfEPmO5J4nahp3qlQgDOGYw7Toi4WD0kk+5zZeWfUXkQwDmbXDQW4mD+ESA1c5kmisSC930iC7bq7afcEABek/fMU6MThr1RE3qtxFQmZ8Nr+pFKYN2qyWr3FIIKg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2477f4a9-9554-4580-cf19-08d584b2b142
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10303C98BC7F5E5B067CE41BFBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: eZ7IH2QC5F5mRX78wWJ/4SYIMOKgrHw3nbVrwCfC3ewhIZ5MGdrl8RW5n42mBBwss0OmYmSpUXQAZKjzWHX7/JzS18IwOr2nmSvf2cvnu40RbVY9rd/eY5E+tMSrGF6Fi9v8WBJvBLWrE0fxRjOcEwMKl6wE9LjCKdCgFCG05x3hWW4cyqNTlWfL57VN2FWK6NUNCOGyckMBH/aiCkrPLBcZ7vA0e8mkCqn2KUFw5lsn5rCobKLMGIXbuaZw24A8vixrwpWDwcMljIU9vOSSQo0GpN5pRbDBiKI8H9ywDAmX5e9DpM2ywJ5hTMP6DuuNRfj1V8p9XJiOGsM7poQPyg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2477f4a9-9554-4580-cf19-08d584b2b142
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:17.8517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 3026050179a3a9a6f5c892c414b5e36ecf092081 ]

If skb_pad() fails then it frees skb and we don't need to free it again
at the end of the function.

Fixes: dc7bf5d7 ("HSI: Introduce driver for SSI Protocol")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hsi/clients/ssi_protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_p=
rotocol.c
index e5c7a969f28b..0cb78f30696b 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -976,7 +976,7 @@ static int ssip_pn_xmit(struct sk_buff *skb, struct net=
_device *dev)
 		goto drop;
 	/* Pad to 32-bits - FIXME: Revisit*/
 	if ((skb->len & 3) && skb_pad(skb, 4 - (skb->len & 3)))
-		goto drop;
+		goto inc_dropped;
=20
 	/*
 	 * Modem sends Phonet messages over SSI with its own endianess...
@@ -1028,8 +1028,9 @@ static int ssip_pn_xmit(struct sk_buff *skb, struct n=
et_device *dev)
 drop2:
 	hsi_free_msg(msg);
 drop:
-	dev->stats.tx_dropped++;
 	dev_kfree_skb(skb);
+inc_dropped:
+	dev->stats.tx_dropped++;
=20
 	return 0;
 }
--=20
2.14.1
