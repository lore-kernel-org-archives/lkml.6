Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3954714-1521499438-2-244483128307392726
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES encafr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521499438; b=uCF7tfsDJfSkghQMyqaPQOhMOzNlbFF4QUvge84AP4csSGI
    1A0NqJOguthuzjXVzYqUo6u+NP53V3xP0UCKbEXH1/wnXRLZ1wBTqobqeTqXJPxj
    Q32F5ZWw/SgnatvjjYggKqpWcuHV5r6RfGwQXoTWObL4u8TjLKvT1hgv9OXFUlkj
    6KxQw7+CU3CGnRJgh1uD5u+jLdqkLVtP2wxtwcoTJvIWbuFCLDEIBb8zR1Zm/SxZ
    STxpP5T63p5VDFomNPVqJhEt4vN5MXuTL6VV2ZLc6todgiyxUHx2lmb9u4lopchS
    0Yb1HkWv4qNLj07hh8a6nA3vmXjn6R1uPORMw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499438; bh=YFkla0
    tKPJ2YMWfHd77eUUWlmbVBKSDhY64LhMD/R6s=; b=GMp5Jpy8yVK0pE+VmjipQy
    QI+YK+uT85M9pQn94HQLtjPaRaK90el0diliqX8BDQUBYbedce0JPGSk/wpXLB5i
    9MXgy84V50rLs4jgFLYfe6M+aYPPs3RP05YkfGQLtqtS8yVWjcqkCUGIpWc0k4nu
    DAqIi1IvVgmMtUhJVGj4yCKvRbfmx9lWs+UVSomjDgplMLb2tdHKFPoZPPbxM0EQ
    wwtLx1Dy6BU+ieE0j0uPMgga91GfDMN187dX3XHILZo25t60W82Zt8xJ1wSOANxm
    Z2M4pxpKDoDvFsZ5/ENPJTK9Z6nVFyJCIrLhPxwJLIvpFBPaxg8PDgnx5IGvCHHA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=joP+KXCA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejvdeknecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=joP+KXCA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejvdeknecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755859AbeCSPrA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:47:00 -0400
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:37074
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755478AbeCSPq6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:46:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 002/124] i40iw: Correct Q1/XF object count
 equation
Thread-Topic: [PATCH AUTOSEL for 4.15 002/124] i40iw: Correct Q1/XF object
 count equation
Thread-Index: AQHTv5mCGdqHmq6di0e1k7xsAt8QoQ==
Date: Mon, 19 Mar 2018 15:46:56 +0000
Message-ID: <20180319154645.11350-2-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:f72GPZ93f6tRgHucOMtS/zB3RR2khRyMB3RLSD695DsqkGXzgS6Yg2xV1cvQ1Ja/E7aXRuFRH6HxiuXUbA81j/GIt2E4Pnvq6jEvY/80GZZt+JLIG7CM6JLO9w3kJBzpZ6pNTDNTaPAnTRRK4Un+XA4OtSEF1Xu71zaoj+X5oJfuXl1zOc7OZTjWBxALTTuHdVBSWu1wHI3H1PmVFXGQMZt6a8Xm1g35hqm+ACuAJ7Fv42utMVoYTXep/EmrGweC;20:m9NQwiXhJ08mfq9HD/ROlhRujMQsHSHQi7FDZIYm5N/3JHHMsVKiF+IRoPqcMVmIQCc7J5p+Wue0EOic+SDcqi92KgDE4UI03c3qeewbQr6ZKqsSrglxru/qOyXKAUqvdG4T9soALLfZ3ie/puAnK6BRUKcV9stXPt+OBBkxD1U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ee79b54-4332-4b4e-355e-08d58db0a50c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013AC1012522DC48944D0B8FBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(575784001)(54906003)(53936002)(36756003)(107886003)(3280700002)(14454004)(22452003)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(76176011)(2950100002)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: JA+vUb/2YY7VjPqes9Vm190KJiGvcX6qm3FFbarM/i/sItYxGznhWxBZ3m27jephuDBOFi5fMOFsrbsilcVi2KPJ4ps38ToOd86oPZFhIkwdoGDFkOor3gxoHi6wxIUUDlLPFX4ht3KY4SwHXW7pNoW1mVDlP9Y+GBKM1AjItTl7OO1s3ij7vZKOQbYKykxxnY7e42Qmp8pkhYwdGCYCj8L7GJye+vpcUWQpl9zvrx4AhyStkIHQ7lfJmI4XsKuIS9joDdGEFNWMP5MMmhQzEzGNUu8wFnybZ6GzC7Y3A30B12krjpVh7KNpSOXjpp3ABG2WFAKUVYvEOhrUMwwFKQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee79b54-4332-4b4e-355e-08d58db0a50c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:46:56.3693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shiraz Saleem <shiraz.saleem@intel.com>

[ Upstream commit fe99afd1febd74e0ef1fed7e3283f09effe1f4f0 ]

Lower Inbound RDMA Read Queue (Q1) object count by a factor of 2
as it is incorrectly doubled. Also, round up Q1 and Transmit FIFO (XF)
object count to power of 2 to satisfy hardware requirement.

Fixes: 86dbcd0f12e9 ("i40iw: add file to handle cqp calls")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/=
hw/i40iw/i40iw_ctrl.c
index da9821a10e0d..1b9ca09d3cee 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -3928,8 +3928,10 @@ enum i40iw_status_code i40iw_config_fpm_values(struc=
t i40iw_sc_dev *dev, u32 qp_
 		hmc_info->hmc_obj[I40IW_HMC_IW_APBVT_ENTRY].cnt =3D 1;
 		hmc_info->hmc_obj[I40IW_HMC_IW_MR].cnt =3D mrwanted;
=20
-		hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt =3D I40IW_MAX_WQ_ENTRIES * qpwant=
ed;
-		hmc_info->hmc_obj[I40IW_HMC_IW_Q1].cnt =3D 4 * I40IW_MAX_IRD_SIZE * qpwa=
nted;
+		hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt =3D
+			roundup_pow_of_two(I40IW_MAX_WQ_ENTRIES * qpwanted);
+		hmc_info->hmc_obj[I40IW_HMC_IW_Q1].cnt =3D
+			roundup_pow_of_two(2 * I40IW_MAX_IRD_SIZE * qpwanted);
 		hmc_info->hmc_obj[I40IW_HMC_IW_XFFL].cnt =3D
 			hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt / hmc_fpm_misc->xf_block_size;
 		hmc_info->hmc_obj[I40IW_HMC_IW_Q1FL].cnt =3D
--=20
2.14.1
