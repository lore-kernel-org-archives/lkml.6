Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492301-2-13648983609592217192
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
    t=1520492300; b=k+6IV443SLFTAyHXWp3tFNws+sLPDZnMMQC69ENgYJayNJQ
    hS+8nw+4FdXykzhkwvZn6lndEd9N5emCWkUlIhM4yomko0RiYKTBr++V9iIzrRrF
    DBbzmoz8BmLWxngSuJp/Y+K6YDXhYW5SdnQhVzvXUZWFU9PfH5t7ZuTD9F4a5Bts
    p9VVgY21VLrf6gBVejUfvCVCf9Ub8f4egMeqM0uZ+1bdDnoz++iYOVnApzIA4s0U
    I3wYX+w3e1hc9y2trHFM7dODxueEjnAu5SthV4QeYATExZcFGtclyzC31pqpJqs2
    9TZNQkQos7ABgcOzajHksJAcfbmwMxUYC2smnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492300; bh=6s3jR3
    dlTlbsds0G/3zd5VjQX+n7S5l+lwhcHFdQRYM=; b=p1iFA7LRekZsMwCEhYEZxj
    vBX8zZfbB/1e6ePetvAATKYqLHBpEpFGfrOCKkJxuLZJVwYzS65Xp1mAZSlc+vdI
    8VxdFv+n723hh1Q01nwE6IhVJZKV7lQ/EbsFvUkpmU2anG1Z+MSw92TasqJy94JV
    pGx9fD03m6wekyN5IfzzNbKELEqdptD8Wqx8KAkfFD3Eum9tt3F+bCcgSOuHD/cC
    5hcW9zpJn5E4jATwdMgowNQ1Lf6smFGzECgZuz8ulwQqiBL4G+fZit1XlNErFclS
    XVoxODjte+N+GEzP43YfcCZgTKgNzhOdM+ICr0JmBYjdF1tJUrBRNbGHZL2SYp4A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M4p+SLk0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M4p+SLk0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935058AbeCHE50 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:57:26 -0500
Received: from mail-bn3nam01on0119.outbound.protection.outlook.com ([104.47.33.119]:51237
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934985AbeCHE5T (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 42/78] RDMA/cma: Use correct size when
 writing netlink stats
Thread-Topic: [PATCH AUTOSEL for 4.15 42/78] RDMA/cma: Use correct size when
 writing netlink stats
Thread-Index: AQHTtpnMGlosHE2YVEiNoUMHU4CvAg==
Date: Thu, 8 Mar 2018 04:56:19 +0000
Message-ID: <20180308045525.7662-42-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;7:iK6dtMPm8Q0C58/XoTgSF3hg83mAPtboSLt8oqFaImlx2DW/46Id3VzNAYyE4sFCFvgyMmgVg5JsV941WeGCKU2fpXuz+Kmi1bMrt1LgXh8qJ8ReYr1s4gVvAlsTv4UbJ2KIAk0XIvtl3Xaiv3rhsHT4Kn9ywmcXlQtcvCtAEsqSy/GxMDFVHQS3LNyTQ35cMexWyjijOGvoEPGkS5lER5KMM51VBm2qwh7MgQ5D4YjJGYl9a9rqeUS3Jj2vI5fP;20:wIKQVr6gVi6FsXxDfNkgUJh4tffdJj9xZwX8wwFOAnWiUV7GinKKGHE3Ms7EX9Cs7K+dUKTpIJ97orTa55tx/Jq+oVy+LBgbhRgzQYkb9EHmQanHt++54jKJxUkGI2Ew2DJfIwMrX3JrpU8hQRsiusvflD8Pl5Ln1zRHj2gGOuE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1ba241f-b3d7-42c6-d0d5-08d584b10c45
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB107974B1D7F932084CD05D2CFBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(59450400001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: FdeBuTJUB0I2UEpp18ERqxvWSdO5JGkdmJogLvx1pSLYSNZOK6pR5Vm9Am4q8VWZ4iSVPSGSrfSQ5vkj4KROkBptuXUPNghzBIk0Gw34BNTt95c9hiKN32umTjT6EKGk81xx2Mwj3Im1m4WIkjuboXiyNqTqE/89IYYjptPeSG7Xztv8noyWSP/lZcg9OCx5gZ2luAyjVBRCYQ+tUYW0FF6lSCyU+MIsJcBTofhdW3LDWEIw4+KUVN/N7nZyCy8RWFZy7sjwPAsvhctxAQUnqNv+/wlW9KvIb+a6j0uuPSQ5rWWH+9vsBYTG9rc8rLF3hSILqbpruyQ9ZtxdmeiW9w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ba241f-b3d7-42c6-d0d5-08d584b10c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:19.9778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
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
index 6294a7001d33..3eddf2821504 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4432,7 +4432,7 @@ static int cma_get_id_stats(struct sk_buff *skb, stru=
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
