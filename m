Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521498012-2-3237757860275208808
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521498012; b=PRa4q7CMALcHBSVIm/Cbb2MzKoQPapkx+7pnj5XMIuY9nqp
    SMVSjuYRwFweDLSy6Qr7e28adDEaKjyUpK0OLU9IprEld3aid3+qP932dW95H4rA
    1v7yyeI1r4MksHktzUK8Bpr7kYV8s3PYNsAF98LOt/J9xqWZdvm8zrmxujFp4Ul8
    6vqqTD7G30q40ns81Y2CM7QPNT+87pRNp1j1HYnljbCezJkxjtow6eJ5+jojiBW8
    mCg7Cwgx1wbCnBKDaDncNTKsucgW/y/0D9tmSre/Pp7Iv8o1XQQvRIwQF7NKoqGO
    93BPhrTyX+4IaJHFki0trk8dJCI0TgSQfID9d0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498012; bh=+Lr5ds
    lDjTCYBkfzrd3TLuNTKtdUgnOYEnGuq6LT7LI=; b=Ik4UPGaz/EoCxaWPADb9Tr
    lczTG2FLoo594zhlVYg85qxzJGR0sDpblWzyEVpQE59ogjnI/SDjzCc+a6VkTxb9
    TaA9Ip+Q6U7ogmyCr94bDe/ZwfOLwZ22ClNr50ZB2ESxT+tvBJvAqQCXoorsWULT
    l+dgw+E7fim+clUbbw83iHByAV1d6b0FiWe4w2Aau8O0X3y/uYT0s+RGxWj9zj8J
    LoGKR82EiZ/6UEV1u5eZ2Qt7N3DlP15fjxKgPCeFE/iyeF06bZNmcZ9cJDkDUKO1
    GOIeOSt3muMSFbIHGW26dC+ifix0tiPbOpo/ThXNw4K4MJ5PIIMEbFT8hWH8/1CQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a12clBmK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedvheenucevlhhushhtvghrufhiiigvpeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a12clBmK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedvheenucevlhhushhtvghrufhiiigvpeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933956AbeCSWUJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:20:09 -0400
Received: from mail-cys01nam02on0096.outbound.protection.outlook.com ([104.47.37.96]:43108
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933944AbeCSPtW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jian Shen <shenjian15@huawei.com>, Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 080/124] net: hns3: Fix an error macro
 definition of HNS3_TQP_STAT
Thread-Topic: [PATCH AUTOSEL for 4.15 080/124] net: hns3: Fix an error macro
 definition of HNS3_TQP_STAT
Thread-Index: AQHTv5m5rHyvNChAjEGzTAb2RxJU0A==
Date: Mon, 19 Mar 2018 15:48:27 +0000
Message-ID: <20180319154645.11350-80-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:iKYq26HT6VKh0x9odUa2sjDAaccQrtPgX/pCL9F9818cW0Si6FMXpMH9g/y897FrIULhbJrgZe9XbwTGEB61pINSM2RTVtFhYCDvbVs/Pj8+1R/MRjBrNv/EXqrkvEmZil0kHE6cc2Xll7S60H6YzqrcYNwpxYiK29jtYqLXoiBTyp9Kf2hbyNy8Zy82Yl0SEkkYK1qlUGkUqICz6ipA/BLrtkhadAnPs5M/LiWyL05Z3T1OYeVgX+AFkp8Q5b7m;20:yT0t0FTIySbaXZg4FXRKkvTgrJKGZQQ0vbg+ssWMgBsIORmhBGOrkdsZvanUDYIIZ3R9lMuaBUYs3WB26KbR7GQWBerMFNrtzfNld4302l8rOliDTyCBEXrupM2hKUDoMde/orQKmZzGTFg67VR5Ym5TdNsSpPgaS42t0/3hhwI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2fda588-3c85-42db-02d1-08d58db0eedc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09197DC5DAAB93835E755B60FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(59450400001)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Y/8rHlCeyYTLtVowmX+IpKIlhBM1ZIiVph/1XMEm3CGlK1VbHS14gqX5kUIBgiguqueq1mh06lVuk3MXI7FerB5AEyI8MLtIVgOhsKw2mzP/WJK5GhM51puRs/LPPYY5IzDoNCtgSzBfb5LZvJDCXsJ7sdXF/lWDxdMud5maPU86UfyzsVwFTvE8EJLFA7JCuLVXhTcWrP3NLOsX8nYV0eNRc1i++MQAhud9HoWIRALtrielq4Zt9985mGfL9NZajrMMw9uhVQSmSAhcWw40O8BEoTrzxNbGGoaUCxtxphb7JZR9Rcz29fVkjXHqqY+J+XbhP8WMZ/aTju2gLvvEeQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fda588-3c85-42db-02d1-08d58db0eedc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:27.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit 57ffee737b36dbb81e8e60a37e01791553157a5e ]

The member "stats_offset" was designed to indicate the offset
of each member of struct ring_stats in struct hns3_enet_ring,
but forgot to add the offset of the member in struct ring_stats.

Fixes: 496d03e960a ("net: hns3: Add Ethtool support to HNS3 driver")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c b/dr=
ivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
index 485497a04d7d..8974be4011e5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
@@ -23,7 +23,8 @@ struct hns3_stats {
 #define HNS3_TQP_STAT(_string, _member)	{			\
 	.stats_string =3D _string,				\
 	.stats_size =3D FIELD_SIZEOF(struct ring_stats, _member),	\
-	.stats_offset =3D offsetof(struct hns3_enet_ring, stats),	\
+	.stats_offset =3D offsetof(struct hns3_enet_ring, stats) +\
+			offsetof(struct ring_stats, _member),   \
 }								\
=20
 static const struct hns3_stats hns3_txq_stats[] =3D {
--=20
2.14.1
