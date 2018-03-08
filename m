Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492192-2-6202694747699301239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492191; b=WgB5EL4e7CL1g69OSZAdCOdtYwlgXjqUo3coEPhBTnZX2kf
    kfFGbDoLpR47Wlzx2+h2Fn279UYN33lM024i9aHGLqj8I1sUeE5IzkuZ6hpwxJvn
    WxuG2MVEIVcSFQ5pqSnXYg/G67Znn7RMy4CYFw+CoAsqzcM/dDOQooK2eygNJrQy
    4sKT43ScBl2lVe6Jh2k5x3lt4tBL0vLncqMtPSBMnBlOXOKYuzAKTlEMZ9QdJE/r
    GPk164asTUCcUi39u0S6cEPMPZQxZBwVfJro7tke8YL9iICZYOtakTHCQFAS2UYm
    1OMXfHeRMs+MMy/eDuuF0bww5GoLtczA9jJ986g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492191; bh=Ud1zZu
    Z4eGEdCzT1WYPWXNi5g7teaRvnY93Krfw1Is8=; b=CcUD0LoI3ktp4JsK4YAcL4
    ughyXIQ/UiU5ivXor069RMDO4P0tlyBB06ftAjnuKj9DNecwarDrJ4q6lM99PywE
    H0EMjz2KNn0jgiuYvLp+y6MryXjTfKII4+f9J4aryGFSup3MnuEvBh1+BQwSZf9z
    3pZ3QmPqvraRqrHfV8OOMVUJQYGEHE1zaQ+rdyvyp7RBjAZSJUrc30UNkPOcYwnL
    rw9nxPovF21d4prLhmlKXFE0zsChZl1YGsTtjP6YQoRTtM3rW8jOYEPzwM9b47bx
    Pi00LU52fcnCUnq+1reQ/Av0GGHVWw0MMzJS7gS+vVeBLsygqPGMZCYP2o8jHelg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b9vjiykF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b9vjiykF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964956AbeCHG41 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:56:27 -0500
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:33969
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964952AbeCHE54 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        William Tu <u9012063@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 65/78] ip_gre: fix potential memory leak in
 erspan_rcv
Thread-Topic: [PATCH AUTOSEL for 4.15 65/78] ip_gre: fix potential memory leak
 in erspan_rcv
Thread-Index: AQHTtpnSt2PiVoj3YkuSFHEZB8kZXQ==
Date: Thu, 8 Mar 2018 04:56:30 +0000
Message-ID: <20180308045525.7662-65-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:0r7LVUSjVxaPtzuJ7Y14b9OJ6CQ7I6aJbYopj9J+SazS5sJmFCUfZS7kFwAKBlZzRATOUnOM2kJcxtf+DH2Os+JzCcCFhEJDuo8gds8FDR3DSFYgiHMVDPU/TZEfMh3T+V3J2EZ8CvZIAE8/7zW+DNAhlFU0oY8fG/QQExkhzoj9DoqqUJ3g3BmTsx0dpcW7s4TlqztZGHEVStfquj1DnjIFoOhEscxZIpRmNdF+V2eOzIggFrmQ120mjx5K2UfT;20:7Val+7LqPnZYWMSDaTGtnrl3PR3PZRYrqQgoe8xftahlF90Ix0uDKEpGb2QPvvBCUFIeePHsJQZWXNfm3OshMOFmtN4VRc3inpAlN2f4wM5J9jBK6mNsi1YiiSnCMYPhriUuIdI/9uf/5HXN+jCkQ7UEN9I8UbXcohhmrWWhONM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e148d947-d784-4483-4694-08d584b12786
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0888D4F0C22DCB0D89E3BE77FBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(173505980823694)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(39060400002)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(575784001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(59450400001)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: yNPBkkJGz4n17lYMbApyS9ZyPXiboNxG+DbdWWNZpHXLca0ExjIgS3K530AFa1QhUif02Ua2u8DYGxCPVSoKWl2uYatXSRd0Ehdg1JxymzUoQRjkpsIwkRSiLUlfo9QcJ1j1zsUgl08KiAtxNde693tFWUZOIXzYoEPNONnIAm6SxuVyV1tikEriPKseSBBK4kP2ZYyf6WLYNhV9v4job4YWcEW55IEtaevDiFH96ICgF1nExtQXSHMf6S0QrmmAGvk0N9Oj7syKQeIsb4Ha6JM6UPHGIrlj0LKNmtGbv7rwdFdAYotEDpBEvKbeRzilW1pMR9hA2dlN3Xo5daGpKw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e148d947-d784-4483-4694-08d584b12786
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:30.0749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

[ Upstream commit 50670b6ee9bc4ae8f9ce3112b437987adf273245 ]

If md is NULL, tun_dst must be freed, otherwise it will cause memory
leak.

Fixes: 1a66a836da6 ("gre: add collect_md mode to ERSPAN tunnel")
Cc: William Tu <u9012063@gmail.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/ip_gre.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index e05bca0e61fc..01bbbfe2c2a7 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -303,8 +303,10 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_=
ptk_info *tpi,
 				return PACKET_REJECT;
=20
 			md =3D ip_tunnel_info_opts(&tun_dst->u.tun_info);
-			if (!md)
+			if (!md) {
+				dst_release((struct dst_entry *)tun_dst);
 				return PACKET_REJECT;
+			}
=20
 			md->index =3D index;
 			info =3D &tun_dst->u.tun_info;
--=20
2.14.1
