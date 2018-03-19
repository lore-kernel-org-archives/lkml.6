Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474548-2-2899820717741999555
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: AXB_X_FF_SEZ_S 3.299, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521474548; b=mUwvGphA18TJqVfzcQGDFhYwelTqfXLNQCRp84edGlynPyw
    xhAwLTg3WRP0lu+y89D1Ps30n5fZNRAzj9LeT3Ua2lTSMRiPLvNWVout25gV/OnP
    thkgkVBU/M0XDK6Ul3I15QcQtbCLReZ9jnamLoMzjPXNEXe4xbRzGdxOHlFG550x
    SbmTYdMx76Fz16E2Q4qUSa+N/WwUmKz8TAYL2Ac08HqVL49QLNUTbdt295seRk9v
    RpyUBavF0SCb4sylCyFqP9Tp3fdfqTPGL+VXmn/PUubk6YNRyVXOerKem/haEuoD
    up1rH6WJnjGQY7Lt11rL6jMUxPVPvAbZmWzyHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474548; bh=RBcRX6
    pRmv001DFYD0mhbWlf+R8FJ6Iu31dgtNiiCpg=; b=LDqyOSrf/D1KivUPNlPasH
    Da0r9H5j7LYTnFgD/v0ygbWGHyLOhK75dN+bj2pZZh/o7OiI9LpyqKojf0Ixreh0
    DpDSkufulbe83GH9mQ8PR8qMBu+SN2oCZ1nfqnb+288dgDJrOSF+A5iOIFmRvD4W
    bQdlLEgOb3EsFb4PaVhRS0LRQ6ArnyDrEIsbLgNI9Nea1yoT49/ZASM0l4ZC4cQl
    OBiYLwugjamiFfn7JlFBlLNitqecyZUKi2pCjl/sC4dHQkl1Ne6VMcq422IJKQxz
    +N/rsZ639S6JuF+F5UGZ3B4+8JOuj1UbhgvgnvoW09/1WnLg8WyTb98c2czBBVUQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MQZkxpfX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedttddunecuvehluhhsthgvrhfuihiivgepheel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MQZkxpfX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedttddunecuvehluhhsthgvrhfuihiivgepheel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933739AbeCSPs7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:48:59 -0400
Received: from mail-co1nam03hn0231.outbound.protection.outlook.com ([104.47.40.231]:31040
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933765AbeCSPsy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 067/124] staging: lustre: disable preempt
 while sampling processor id.
Thread-Topic: [PATCH AUTOSEL for 4.15 067/124] staging: lustre: disable
 preempt while sampling processor id.
Thread-Index: AQHTv5mwxkDvAm2gK0+I0+b/zxmAJQ==
Date: Mon, 19 Mar 2018 15:48:13 +0000
Message-ID: <20180319154645.11350-67-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:ZbcTiI7tGTSUrXNgvm3CTwbcn2L1Myas+NcBPOe+vbrGmFVYPWIjw8/ZhWZnfqX0utgGfqNlTTyT/WULrJLFSykeNIrQAp1sd1aPXl5Fx+Ipg5/I6DzBr9zoKY1GoM9cOaBxmE+9SivkSdf6B/M2AED6LBd7Yki7WBlAUuBNjanxzXXYUYrfcpDPqbCnyIDaDj8H2ZqS/jr/1pkuCWoVHKmIlQdJbJBoWKw+0j6S7UN5OBrGDAFEfMrMQ5TGpQlq;20:Rv5Cpg+cneX2Gejwwr0YNjAUmN+A8j1ebLOoO7FWs37J2AtMZ6JTyLANo79To8z8SKz0D3oFehxwIG+lMwtK1RNkgFkgWJbV+jWFra8FUggUDfWNulXs1/g31y1IOC6L55BPArOiYMQyRvP5GzC/DJyHCU9aE9VUUpgMPZIwz/4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c4460eb-f314-4782-34a6-08d58db0ea60
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
x-microsoft-antispam-prvs: <DM5PR2101MB0936BD65862F7FEA55DE5D27FBD40@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(39380400002)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(2900100001)(3280700002)(2950100002)(10290500003)(66066001)(106356001)(76176011)(86612001)(6666003)(478600001)(5250100002)(6512007)(6486002)(107886003)(36756003)(97736004)(72206003)(25786009)(6436002)(53936002)(7736002)(2501003)(54906003)(110136005)(105586002)(10090500001)(2906002)(86362001)(305945005)(5660300001)(316002)(8676002)(6346003)(1076002)(3846002)(3660700001)(81156014)(4326008)(14454004)(26005)(6116002)(102836004)(8936002)(81166006)(6506007)(186003)(22452003)(59450400001)(99286004)(68736007)(22906009)(13693001);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: hAT9Xm+jPTJORGxJHjMXFMQCxbHhtbc6ffL9uiGJmUotQsFTBr/dBO2OXfBI5Kj88tIWZdxx3fwYbC5ZL0Zt9ABIJak3BYodNHfyMxh5g0yhFAboNFvuG5392GxqopWAGTErl0DUqmDsUuOMfQYQGEa2Zfnz0c8kmo7sJQeA695YHPPrab0uGWwkbYQ4w4RN3c/TPhhAhslfB2XHffGJW1sNEVoNZbSeAZXA1DeejbXq/CzQz40ltKMOKR9iN3pCnwNmRnJ/hr9ojcA0NtlkLSKgEx8LO2QCPJUKQBoMwMAQsrydOQbpROUnn47R6M+lcsd9rg5pGAJhcHt3P1ui2e4hhxmOY36+CWOhOfszxYmUH3RaZ8RHSiIcdFCwlklkR3De1A0YzzX0QlrMeRCOBxFl3NvHRab68mawIAcIEqVHNog+1GeG0CWl2Y0TYLFWcj+Q5dhSfsbRpcgU8syZr6AZxn+47DCtt8zsArpeIjez02AAs+KAZimZ34pk46oV
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4460eb-f314-4782-34a6-08d58db0ea60
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:13.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: NeilBrown <neilb@suse.com>

[ Upstream commit dbeccabf5294e80f7cc9ee566746c42211bed736 ]

Calling smp_processor_id() without disabling preemption
triggers a warning (if CONFIG_DEBUG_PREEMPT).
I think the result of cfs_cpt_current() is only used as a hint for
load balancing, rather than as a precise and stable indicator of
the current CPU.  So it doesn't need to be called with
preemption disabled.

So disable preemption inside cfs_cpt_current() to silence the warning.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers=
/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index 51823ce71773..a013f7eb208f 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -529,19 +529,20 @@ EXPORT_SYMBOL(cfs_cpt_spread_node);
 int
 cfs_cpt_current(struct cfs_cpt_table *cptab, int remap)
 {
-	int cpu =3D smp_processor_id();
-	int cpt =3D cptab->ctb_cpu2cpt[cpu];
+	int cpu;
+	int cpt;
=20
-	if (cpt < 0) {
-		if (!remap)
-			return cpt;
+	preempt_disable();
+	cpu =3D smp_processor_id();
+	cpt =3D cptab->ctb_cpu2cpt[cpu];
=20
+	if (cpt < 0 && remap) {
 		/* don't return negative value for safety of upper layer,
 		 * instead we shadow the unknown cpu to a valid partition ID
 		 */
 		cpt =3D cpu % cptab->ctb_nparts;
 	}
-
+	preempt_enable();
 	return cpt;
 }
 EXPORT_SYMBOL(cfs_cpt_current);
--=20
2.14.1
