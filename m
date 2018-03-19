Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521497610-2-11708357113205140237
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
    t=1521497610; b=uxqpRaLb9MBGLgRdNKVpsV5SfPbFi5p3fyuySMpI3e50Tsm
    4/wf7wNHvf8ai28UhFw2O8DUTExiz7PR+nVAv5bX0cJx6RK5kaw77sK74s2Eyd9K
    9FFuwNtfyLW5L5c5oO8X9OS9FW6LjGtL2N/MY8KYzi2Zn8MdWrmCka17wfx4uqQJ
    9yw/wFW6ObTZg9OkD7+z3ebOQJQVETwAZC1gigqYJGSCCOo4cG/t9TH7Fbun9q+A
    JaWHpJiXibsELiW9el/5dDvKLvoJi8A9Ww/JL83R2rr4eAbBPYd3K0qet4BKs5/n
    GgQy2xbl/UHQQi0FyOsFyMKl5RVS79ZyzeLi51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497610; bh=bS1+UA
    XaD0AU18P0QpEw16dp5jd0kN5Go92upDD7XOs=; b=TMot8v4sV/wxrqCgmIImYH
    GKAS861k/FfAPXbBmGlYo1rcCI67RIo83mdKLevvOv35KfJKKCbujL/NAKBEa6Oa
    iXUEyVKgklJpRlnJrbGDSMDnGFtP0xfDMbUeQG2OHoNV5kA4Q8arNkhiXzzPeog7
    WgPqVzKzVbPt/AB5t0YL0dGQ5pHekXHU5OPGtBfeoDDBjFbnSgNJ/yJQqdvwTEoc
    E4mPrJRkJH9aFBw5CwfPHUbD5MIk0bGciLDZgsYjAp3YhsCTMgh+FeY7rCqE29Kq
    wHUpiPQyWcRaktH04fq+g7JmfvJn+Iqch1+4rqq/+yjoLZ/mwLCDFOQp4yOWdMYQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HoDKHdO7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeelvdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HoDKHdO7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeelvdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972307AbeCSWNE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:13:04 -0400
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:45512
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934220AbeCSPy0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 03/97] i40iw: Validate correct IRD/ORD
 connection parameters
Thread-Topic: [PATCH AUTOSEL for 4.14 03/97] i40iw: Validate correct IRD/ORD
 connection parameters
Thread-Index: AQHTv5qNuUHgKXuQLU6xKzBt1jQ4Qg==
Date: Mon, 19 Mar 2018 15:54:24 +0000
Message-ID: <20180319155411.12348-3-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:0yhLLRmNR7AT8QoCxSW6pgtFSart9+b/pXCDr7WeYaOqFEAv9Hn64elWrimTd3zwnX58gKFlLClbKsemugbOlAECmqfAJw92yRlfLvKKyAkzJmTBPHKZBQrb1Raz5kTmbvOHKLY1ImyQSprhtbbvC164E910uRMl0HrOXnelbzLuo2I37y5/EKCsu+LPWwamskcYMOGlTtCrPiufZiOxLioNFYNX15en/tR/zGKj6v3pzHABsHNf/yBcCHYbroZ/;20:9MnsAzPHtq59kFpZPl1/7k/EgeyhMdQgYbAY9Vgvs+ptSlQfNH/5Bq0n5vQeifF6skLohCVugsiaJyAnHEeYehHAfXIKZEM8oi7/5g8gACcJ3vugud5KDn0P5MWjCqsMBouvstpluu+XfCTEup+6JJzPL3EJ9JxcbEJk+clWjfU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d107831c-2158-40c1-501e-08d58db1b005
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806D10DB168FE8E9CDBE470FBD40@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(199004)(189003)(14454004)(105586002)(6486002)(316002)(86612001)(68736007)(106356001)(36756003)(6436002)(99286004)(2501003)(5250100002)(107886003)(54906003)(110136005)(97736004)(5660300001)(22452003)(26005)(186003)(6512007)(59450400001)(102836004)(6506007)(53936002)(15650500001)(86362001)(2906002)(25786009)(478600001)(66066001)(2900100001)(72206003)(7736002)(8936002)(3280700002)(4326008)(8676002)(81156014)(81166006)(10290500003)(10090500001)(1076002)(3846002)(6116002)(3660700001)(2950100002)(305945005)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: lFJhrxRkW8Q6ndNGH4uWc6NARbgVxOW+u90MbAQQ5YsA2B8ncfKypo1BtSz8dMi0x8WSntgxeFL+U2NfU+KlWaH2VgG0o2PB5RZepBW1KZ2bYHF65WTyf6utfI5I9XAOjDlgsVfcxSX3WUGJaRBN7W35uV/sO10qLyyQfV2Q+JR906Q+6q7saHivuJQnr9i5eFpk5IjWpGNIJmqvFYoKOTH28byCfY/gcpEH6ZK5nX2ZejLJgDfShJBg2jF8FWk1Pu6VQhyBnJJZLuh46FEfnx3LNnlbMr1YbqT2O8WF/FXmi7n5c1+uL/sfI9wVyHKA4CokE948eaOansaQ4ofBJg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d107831c-2158-40c1-501e-08d58db1b005
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:24.2657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

[ Upstream commit ce9ce74145aa6814a370a9ff4f5a1d719baaced1 ]

Casting to u16 before validating IRD/ORD connection
parameters could cause recording wrong IRD/ORD values
in the cm_node. Validate the IRD/ORD parameters as
they are passed by the application before recording
them.

Fixes: f27b4746f378 ("i40iw: add connection management code")
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw=
/i40iw/i40iw_cm.c
index d6a1a308c6a0..b7f1ce5333cb 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -125,7 +125,8 @@ static u8 i40iw_derive_hw_ird_setting(u16 cm_ird)
  * @conn_ird: connection IRD
  * @conn_ord: connection ORD
  */
-static void i40iw_record_ird_ord(struct i40iw_cm_node *cm_node, u16 conn_i=
rd, u16 conn_ord)
+static void i40iw_record_ird_ord(struct i40iw_cm_node *cm_node, u32 conn_i=
rd,
+				 u32 conn_ord)
 {
 	if (conn_ird > I40IW_MAX_IRD_SIZE)
 		conn_ird =3D I40IW_MAX_IRD_SIZE;
@@ -3841,7 +3842,7 @@ int i40iw_connect(struct iw_cm_id *cm_id, struct iw_c=
m_conn_param *conn_param)
 	}
=20
 	cm_node->apbvt_set =3D true;
-	i40iw_record_ird_ord(cm_node, (u16)conn_param->ird, (u16)conn_param->ord)=
;
+	i40iw_record_ird_ord(cm_node, conn_param->ird, conn_param->ord);
 	if (cm_node->send_rdma0_op =3D=3D SEND_RDMA_READ_ZERO &&
 	    !cm_node->ord_size)
 		cm_node->ord_size =3D 1;
--=20
2.14.1
