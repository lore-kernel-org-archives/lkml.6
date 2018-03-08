Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485659-2-16292490744228237706
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485658; b=FjgWZaxKfxGw2CfItIXAm38VZGayNfbTsrDImytc76MExW1
    3aX/1v3qQ4cs+WmyAmHWt9I7hYFYLFlF+9N+/IwivI5dv/ZOFENUVIdtIPSdVd+S
    fdrg1wQWAhqgQNMl85wAPjS3JSscrI6UxfW7kcVyWH7l4Q3M6U1Y4bu2ElLSZsCB
    wjLZlih0GZsJudW+fhNyD/4jR4MVf5RuRHz7qOKK0c8iln5K1v7airmtBLLAkIIl
    xfNqxr7DRJNe7UL0z5eGQpp5W2yB7o0WqXHyYAvmfIX5Aq53uYd2369Sy9ET4zoE
    QZU/DrPtW+8/Krb11rNJ3fb4gAbS1JskBxinpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485658; bh=YQPT8j
    qNU77D9WoqwJNWLj3QjUfwKZUP3xe3r+KrAMo=; b=T8twPUQ6st0IkJJszrRkZe
    EsW3Hca/TueD/Tnfptb+l6Fei245UjS+WyDx4DPkQM77dT994V1aLWAXpZdcN4uP
    6yyraCtY6wzgXE7WAtzJqgbzBbJ+Hoq4itmGxwuPlmF7FnNQKjlG70V5XEDwzfa4
    cU01Tl1totNMsxp9d4/DoyyykAfRmwLM4+rG2AxbigqA2UYQfUsRlG7rGnIiOwGG
    sP1c0xSNYdamOqPsnQ5NKZfqtocbJHegTnXv+JoINdqnChIS4CmlzVX1iVsqULLC
    0sFPYVPNo6JO7WTfkorF/adadgEcGV/qp5ip9zrGwgEGDql6cAnVH/Q9hMzWcIFg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JrDWFC1M x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JrDWFC1M x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966624AbeCHFH0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:07:26 -0500
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:54752
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966616AbeCHFHY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 089/101] RDMA/cma: Use correct size when
 writing netlink stats
Thread-Topic: [PATCH AUTOSEL for 4.4 089/101] RDMA/cma: Use correct size when
 writing netlink stats
Thread-Index: AQHTtpqe/RfUcdkw3U+oE/qMtuNUKw==
Date: Thu, 8 Mar 2018 05:02:12 +0000
Message-ID: <20180308050023.8548-89-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:vMmn58Kk3gRZ5Ib3bbsPPMgnztElWIIVfkDmMFBFxGaz+E0crvBs7CkPs0ZxWEMLjYe9PP2Eoj3cWRWZ9h9dEPwCT5N0Cf2jGuTFoeNrIA+mkhH5D48AsCynE/WgmufrJitVqd4tG6RNOGcoRHHBFs8xSgzbuG0zBrClvlb3Cs0yI6dawxh/09U7QKIbu4HNezq6V/SbCJwjt/X5kqeoMyAO9q/iIlKpblzE7x2PkSw/3dzefPN/65wCikW4fXR8;20:uQL+d2uFI4bGoiRuTU4JoNedbjl+TJAtm7jQo+3koHNf7TZTbNVn3n8ucZjlgxPboH+TwB9nMLJjPVcu6YGR+nAIlt28mgPe9sVPeQpMko9XGzzmNfw6bQseYnVUWXcWaw4fX23t4WQJH947RqFJA5trZD+DL7sRfXJiWOSuMHk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47a29aa6-e3ed-4547-12ab-08d584b276e3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10775DA95AF487BF21BC2C51FBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(6506007)(59450400001)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(6666003)(86612001)(3846002)(3280700002)(2900100001)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: niTdNxZJzBIblOTPQleuaA6weHu+9m8IYI3gzWiBvVaWOWWBt3EY0JHRJc9e5s7NFUrwPKaAVhSt7qtbV9J8J2S1lY2MBF79iYX464JT9szFVTjuIeot0Jjzl3y6Nv1Ss0Y7hWe51KgWdeL/sE46I1cpvyhBG+b/m+Hvkb+bh07c8tTrKrnfndUtDa92iqSeYI94sj/njXwxNAPW+3UQbOFWSHY/VTCEi2FsclaRbGXZZZXhHS8FPqHmRTU8FUJkMt/7YXZv4vEqVf3Ovxr5BnRKdT3aIv+dqNB0zyMNpF8UID9zK12f8t18g2u0rb3qibonW7bXkr80GpmufxAjmA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a29aa6-e3ed-4547-12ab-08d584b276e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:12.2589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 7baaa49af3716fb31877c61f59b74d029ce15b75 ]

The code was using the src size when formatting the dst. They are almost
certainly the same value but it reads wrong.

Fixes: ce117ffac2e9 ("RDMA/cma: Export AF_IB statistics")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index b6c9a370a38b..be5a407444f1 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4007,7 +4007,7 @@ static int cma_get_id_stats(struct sk_buff *skb, stru=
ct netlink_callback *cb)
 					  RDMA_NL_RDMA_CM_ATTR_SRC_ADDR))
 				goto out;
 			if (ibnl_put_attr(skb, nlh,
-					  rdma_addr_size(cma_src_addr(id_priv)),
+					  rdma_addr_size(cma_dst_addr(id_priv)),
 					  cma_dst_addr(id_priv),
 					  RDMA_NL_RDMA_CM_ATTR_DST_ADDR))
 				goto out;
--=20
2.14.1
