Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486032-2-2203819727813188510
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486031; b=usUiPAVN/wGyNlxKf4hgsi8+8NlJtpvx7rTx6LjXBJlSJxD
    qj+AhpoJrSOvJB303dohZ2m2No8O3QiwPavC6+pX4bnFuIJ4BXoXV4v7TXOWbUmz
    fWZaY4EJdrG8H+jgFaV9Tw9clB0BJxzpVDBfFVSaRVAvS8DUAQX8AuqaX5bvLo1m
    3Z0KFpcsMkRjg7SlRh9kTpsFA05dzmoQtc/bq4Ha+irNMM4KxwiXL7s3jkeVMQAs
    mvXaZAJSDvj7ArF3CmWLuVeww1l1hRvoAFj66Y9qHjEfdQUPjFj/TUmMJjk3CfVY
    nfBwvAZEvXSpKvl9ncXNKF4orfzkmU9ARjp4ECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486031; bh=oSjIoE
    FFHOFfQFu0jIC2qi1jplYYODNpnoURkYr+iG4=; b=hFdMID/lYf9qV4HErUtbTc
    Oop2lcrw62l2zrwLTUSHQ6QITk8ww7ZeWUNM2IRmaAPsLIuOg5Ac7Ec6Fz4TBYmc
    lRDRiknTrW+XEAas3l/a3KtBqftbz5Jx3bC5gXZ9UqoNM8phornK/qH271mhomgX
    J0D/jXDvN+Iu89ZPyq0UkFTkjHCELiRIbW3LVeltBkSsPYwak8pIm7x1hzs281Ie
    VfkZ1H7Rn3MoyoZbp3pQ+MzrLd4IXfKJoKkFFImnmD/Da2Q/cMFec4ncgu78aT+q
    SK5dkAhIos9fpDH58SQ2DYD64Wj9q2vI/AhMGpV05IXrjG0i6M8NAJ+Ip+yk7+Tg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GSEafZ0J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GSEafZ0J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966704AbeCHFNt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:13:49 -0500
Received: from mail-dm3nam03on0132.outbound.protection.outlook.com ([104.47.41.132]:45039
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966926AbeCHFLu (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 49/53] RDMA/cma: Use correct size when
 writing netlink stats
Thread-Topic: [PATCH AUTOSEL for 3.18 49/53] RDMA/cma: Use correct size when
 writing netlink stats
Thread-Index: AQHTtprML/sJ+MwOiUCRNf7UyYV+mQ==
Date: Thu, 8 Mar 2018 05:03:29 +0000
Message-ID: <20180308050230.8876-49-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;20:Tbo01wFXNevgamBkPkJhC/rNCM3I/Gxiy0K5YOHuVrSR3LpiUw6dqB6y/Xv/eyykk3rhjSfkKMfGNdjiqf2M+YCPjquRMrOVdyQkNbyweyywqggheJSatW+tsC6iiFXWcHQp/jPgY4NbN5HD1rAfSWtCU1q04En4Sdj+3u6iOLY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7f58225-a81e-4248-cd29-08d584b317d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112F87D6802B07824583015FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: UDICdDqgcnDfPZ1xt1MqMSQAbMRB6FOqgMXoHEKatyd/dPIO3NWKxRuakxnMnLv3i+V0glopnp+3MbWp192FscqgyUA+3VcQW9zSvxpon/sxZBGa4je8pCrkerb/mm5s/oj16spPFqkmOjZvM0tvUW1fLRHYbJrgzjoheqjLZQY05m0n2lyRMfOo48SqV85JwvByZ8zoEYUB0FENYAXyk8wS6FFp2+0FDZ/j+XwJ+JDpdK7SSohJF84xN7V/b3cV7DMjPjNBgYCYnsrEmnxIdxGd/KExHta/prciUuelUBN0u/Gz9zN/77luUMIKNHLpCCerq84ZwlyonrpanV6DdQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f58225-a81e-4248-cd29-08d584b317d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:29.0179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
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
index 06441a43c3aa..903edf760eba 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3632,7 +3632,7 @@ static int cma_get_id_stats(struct sk_buff *skb, stru=
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
