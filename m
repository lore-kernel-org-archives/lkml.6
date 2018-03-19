Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482566-2-5301872519671257943
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482565; b=F2+tdp6zrVUYVWYq5mfJIoaIiCOhM9l6OPnKO34hFPAYHZC
    f52RiSqKsgyUuoZTooiCE7TuQZfYYbTX5YKi7u8XXi64V8vJs5g7BYwznmabwMpn
    RhH+9eGf0L+ge0AVcuuBz6uOOkwYFaKIoaRUWOSD9O0oDKJ/lZuJp0ApSREm/j3w
    vYD2wWM7MmcBXxq0ERb2UK0TmibWEwEIml40El0eQL8tdfdtj/Vbb0Ek7cHSptm4
    Ht2mYVIxZb3/VtEDCVgBH2Ak1pq507zoDeXZR4Oy/6jm88gK8X2k0v7wygvjQeMt
    4JmxVCSqaThqwIOcWG0+PltnqXzOlz8N2T5d+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482565; bh=uWtkp5
    eu5/GqZ2rHI1djVSs5hNheJe+uIF5Yb8TcdQ0=; b=hevtmjqb0KRCYhrD5f9qAG
    eN7onJrayUKwWUEmzu94kntM8OLT4kW+PruJmh1pa7oUAl3YtVKx3CuYLK5y+r2s
    8PIeEnX8CqqpFj9gi3lZgI4b1FPr0SePGkJqG1CP/b0qwOO/NcEdRiAKcrpZpOZV
    8w2Yl8fTl8qpOKOEhagUGM0xUrnIt4K3CEjXhYekdOes++yWZzOMtaskNN9mbCOe
    rlqqWFBm6dmhk0uSqMWORU7UrACmyVSgLgsviom+UUPuUzbPJZ/AeOH8OuhKl4GP
    DqyNgfOlB9FOVtDD1UJRk/y4Rt51zcw1qD0RnFVRFJjZ1AGKx3wq5uaXdd/sE+RQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ThqsKAQN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejuddvgeenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ThqsKAQN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejuddvgeenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968513AbeCSSCk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:02:40 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:27376
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965618AbeCSQD7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Steven L. Roberts" <robers97@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 188/281] RDMA/hfi1: fix array termination by
 appending NULL to attr array
Thread-Topic: [PATCH AUTOSEL for 4.9 188/281] RDMA/hfi1: fix array termination
 by appending NULL to attr array
Thread-Index: AQHTv5uOVKLYbnNMcku6icSM9k84uQ==
Date: Mon, 19 Mar 2018 16:01:36 +0000
Message-ID: <20180319155742.13731-188-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:mOq8CQCu0pOJyhh0XCQ2sM4LjDPIzxr5xuwVnd5sZspF5oVYls07P9hDyCW3IokNFH8yPvW50cHETLGuo2lPT7p5N9r1vBitZGFbJAauxdDoen8P+2bDy/TW6UxJnhM+/wCxG9Wrnuh5k4aNfdF/csXNVfqoH8zP0WZBXZbFO1azuxJoYa7CVds+GwtvdcI47/dR4WCB/Rl3uB6QAvNs/SMQAbW7KCX+OAd/TFCI0U43izXraQtdD5yKwmz6Jo37;20:hmXlNr/h/kYc1OJ76/ILnO7XGdc5TAyPXFE5d7YmQyRGAiiavA1M3PRoQkOUr2rPx8xFsNXmfNfAEY6N3mc6VdRy7KpvuWsl/kyqiI4BBbYkUDWaQwKYVeiavsSEHgfV0Q4bgp1N9jBq1IOsfKDQggx5lILwaTt2Nbw50gEfPss=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 477e8efc-25ae-405a-b566-08d58db301ff
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1077057FF633A86717521EC5FBD40@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(199004)(189003)(110136005)(36756003)(3280700002)(66066001)(3660700001)(4326008)(6666003)(2950100002)(25786009)(86612001)(105586002)(10090500001)(68736007)(22452003)(99286004)(39060400002)(106356001)(5660300001)(7736002)(305945005)(76176011)(54906003)(5250100002)(97736004)(316002)(2501003)(3846002)(6116002)(1076002)(2906002)(14454004)(2900100001)(6512007)(8936002)(186003)(478600001)(10290500003)(53936002)(8676002)(107886003)(6436002)(81166006)(86362001)(6506007)(59450400001)(102836004)(26005)(72206003)(6486002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Sek9JzVlco4FaYnre0L80vmYKJfsk55l31zGQjRwYUSPLl4LjDp0+d9k8Im/QuQY01fP/uVnJVvH7PYZPZym+5TkkcWrbBFu8aP/ZuZsVfetlIcMOXNOlzyDZ517zWE4V7jchcfwdJaI+ymGE8qYtD8wMbYGTZ/1exsodCNuFobn9ArcclJme+34LuK941XEOK7GtHVeBvocyBRof8TGlA6hstTvkjJEss38crYqcoftMMp0EQygblp3NACSrF+sp9tiFqPRVAkd9blHWDLo5E7+dlHlX68magctfQgAIDDtHOfPzzqpNliSG17CHBobAyHMbK6MuLRpepnkKURQxQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477e8efc-25ae-405a-b566-08d58db301ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:36.0526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven L. Roberts" <robers97@gmail.com>

[ Upstream commit c4dd4b69f55abcc8dd079f8de55d9d8c2ddbefce ]

This fixes a kernel panic when loading the hfi driver as a dynamic module.

Signed-off-by: Steven L Roberts <robers97@gmail.com>
Reviewed-by: Leon Romanovsky <leon@kernel.org>
Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/hfi1/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi=
1/sysfs.c
index 919a5474e651..621b60ab74ee 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -196,7 +196,8 @@ static const struct sysfs_ops port_cc_sysfs_ops =3D {
 };
=20
 static struct attribute *port_cc_default_attributes[] =3D {
-	&cc_prescan_attr.attr
+	&cc_prescan_attr.attr,
+	NULL
 };
=20
 static struct kobj_type port_cc_ktype =3D {
--=20
2.14.1
