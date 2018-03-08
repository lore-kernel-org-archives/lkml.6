Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491443-2-12761759435516359037
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491443; b=JeSO6Gw2C/gNkW4XatX4T615DY3JJ2UGSve9ffX173sbAZC
    cC7ozQKU173L+7S3YrxHfjFQ5sSYWcGXwcoIkdz+Ju168mAMiPDs25TEl4vO5JA4
    5JdO436MoVNkWAFCtmjhc9WYnAX/5Ck8R1T61Vc/TkRK+S+V1oRoJsGhTaPhRrhm
    SE7XSsGKwLm7yrZbVh/eo84JCbe9R3u0ojaq68gSvcMs35tdpTWntaSXxCLbCee3
    UDEhkuLvGEJ6pf7OnN1lq3Ln4OOm4mrLRsPdloeQa/xiuOCph/KvutGvojI0CWf2
    rnI8kMSdLB0Hpq+RFtkUKhdJbEkc0kaKDZo2eFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491443; bh=zCCiar
    D63WZij3aLffessz64rHjdomuS89lr/iCmwAs=; b=obXSS3tJR7K525lv7EcZqr
    ctlCOzr3gzrRezpJYMY4+k7Rgi099fuBtbrj4GjNCE4pjpGe8w6Mc3s8EDlTIY6s
    NP4rWRiBR8A2wwIsjFMqHhQxrmrXSl9DfoSUyQhdDz1T1nOELYJ8UDNm3tDCT6aw
    IWPrH/qLoJHkTjxUAI3Knv4167oqEfmTNOcnQlak0HA/I4sxgwcoZT5Vg6dk/JIY
    +jTLeuNE3tsLdY03F6qoYSrOykq9jXrAV0THc61KQ4ZQvwKTj9dTVOmXy+cMVLH8
    D6NqWNbyU5M5cSys/xA8kk9UpRCnsIh7aCqT3MlnSVCd1MGfzKyaQatLezKPS79Q
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B/yqLo0G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B/yqLo0G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935353AbeCHGnf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:43:35 -0500
Received: from mail-by2nam03on0124.outbound.protection.outlook.com ([104.47.42.124]:6433
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935351AbeCHE66 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 37/67] RDMA/cma: Use correct size when
 writing netlink stats
Thread-Topic: [PATCH AUTOSEL for 4.14 37/67] RDMA/cma: Use correct size when
 writing netlink stats
Thread-Index: AQHTtpoA+nP+XPktsEOTc5ePuTyTVA==
Date: Thu, 8 Mar 2018 04:57:47 +0000
Message-ID: <20180308045641.7814-37-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:kyouoEFWfGN+9SFkemRX2iX+WNLYcg4XIVQm9zY/9GdIpxQPs5ntRZNTW8+vHn6Z2llYb6W7pteoerNtuJ1hnPj966BRahal+wpydDDixuDtBp2ULU5XF7YJCco6Mt8gfeHt+r4894dxbgTi0Pg2pTxqqGNAOxKVhA9AedPayZzvTyQbc8v+GmeqUhc60MdIHfW0ySnwnKCCCu6PfH6f/MzE3D2/F71U910fJwU6IJgNSZ7Ty1J6At9B54AEKgF2;20:YQuEoXH9HqpTdeXgNUJumV8iGnsQDI7+doIlMt67XBJkYr20nvp/Ijyprga2/i4QDYzgZJYzmjyJOmmgIwHYwZtn5zxAs2tH6sKwUo8OslBcikhEpeDj33tFL+88UkFLv7mtTBMe4rZg4SEicvyXAQH7q9RG5faZySxra+uV4Fc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fdc208a-a1b3-4287-4897-08d584b14bcc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080C9F18C46898D4A7C2BBEFBDF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(6116002)(1076002)(5250100002)(26005)(102836004)(2501003)(3846002)(59450400001)(186003)(6506007)(25786009)(3280700002)(4326008)(2906002)(68736007)(66066001)(86612001)(3660700001)(22452003)(6486002)(6436002)(14454004)(8676002)(81166006)(2900100001)(72206003)(81156014)(8936002)(478600001)(10090500001)(105586002)(10290500003)(53936002)(6512007)(6666003)(107886003)(2950100002)(106356001)(76176011)(316002)(7736002)(86362001)(36756003)(97736004)(54906003)(110136005)(5660300001)(99286004)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: zShJITX/zajHeReIgOzsjalnwO74cCb6+JFpW5/7tcuI1ZA9tlNG+SD4Bl1bFqqeB7RrDtW/HwmP4pz+WXHZjNdSabdDLOOatVI+6nliOvfmbWd6nP+0lAignK/xCo7fdI/TEgzkBsRhifOvYQn2WeIfhL9/9qyQbzcWV2YZkvHWrPhWHOfHntP3mjlS0K42jT8tQcVpDWYDQwo9c7h9CiWM39xfxw7GhgQrLP2lFOohSjkyULNhj89wtWb4q2QM0VbqcWdN2bFL8QAaGIJTtjE8oFDqLShjvcx17D4V1aUWH3LCe63lniiRkmONet6vX/bNT0+jmsEScrJ6aEZ9jg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdc208a-a1b3-4287-4897-08d584b14bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:47.7331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
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
index e457dface2d2..537512396eab 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4436,7 +4436,7 @@ static int cma_get_id_stats(struct sk_buff *skb, stru=
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
