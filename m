Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239995-2-13681524239910779239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239994; b=KY4ILVPz3ofLyHokPBxRgb11ig6GWmCEqaD8h7nkkl6TH7vzFj
    I93ufFbLlsFrjiAHJQC9f8cQ6r+I7gmOJASy/ncbaILNy1IW9RrGdqcGSw3l7uyt
    6bggMfpFnCbHUMDXlvk6+R4q/1MKrdm4UGr4ARXf/aJdL8buo8bPcGmz5s+ma80J
    9gblPgh3binKQAU04yTngYb07T8PTDpewsB6zophgQZYbhXfTe4+7J6GqUeR9HSt
    3gtkWBRN5ukrUeKDYSWQaTENWPUj5aH1pLPHTBsbAPo//k6cPUa7rA9dbIdBkbRW
    W+eExqOw5XP07K9UtNEDNBs8qqldae678c+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239994; bh=88kVAncQk1
    XPMpOpte0jijVxZdk1H6zSCFTjPmHclBk=; b=gQvYyQa+lee3P2re9W9N0VUYcN
    W6RHYtY7mAxZdUGsMKTg65JYXDmnLcSFVClVXLHX7eV0rCB1Nzj+zrOVC+he4ebA
    xmAalpnfnbx2xRD31Zl+WPdBe2+POc1nd1C1YRb4srEtXZpBdaZBo0TVo4oUYA4F
    3gUon0y0oRzOTKFgSdEy5IVVnGzInaH+w5PKkCjTLM3VQLRgFSyuP2kzZRJWurfd
    b0PgC3Zw4ApFmUEeqaLulaLxgKSnW3zQJ6Sv/eNKo9tuTarYQSubroidbC2Qyqs9
    mA924Qs7NMV+jkHgIhIUKOtL9JgCBBQikHXOMCU0QNgvmGRwv8Mnr90mQ7Dg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cSw8JMKm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cSw8JMKm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKvxSCSk91a4Jwsbi9cHXQx+Q1fOkpcrLJfsK9vc9IMzSyaE6DgI7JwMtk2H9cr6nwn+Hn5zrwiiSnNwRaZqnUrzc689NHk0QJifG3xawOMgHhx872fN
    uF9CK2GTXjs+lNQfq0hpxTpITGGc7ByVDVxAA2anFmS3SSHczLeIsSrNJNO/qeWaDJJs34eAzWq1xvnKT2UIa4s+62IRG8NyN6wg4Dq23jS187xlQ0KthIpV
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=ESC_2_oHsVqC15QSV40A:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754849AbeDIAbL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:31:11 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:16544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754851AbeDIAbH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 152/293] libnvdimm, pmem: fix persistence
 warning
Thread-Topic: [PATCH AUTOSEL for 4.9 152/293] libnvdimm, pmem: fix persistence
 warning
Thread-Index: AQHTz5ktzw5kzqj8I0y83vxLpQ7ONg==
Date: Mon, 9 Apr 2018 00:24:52 +0000
Message-ID: <20180409002239.163177-152-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:CWTCnIc8pbngbth2ESVl97bnlr4Q4kyStF5nvf1a+UerdM7SjGAn6j6JEcRf2VlpSya0gEeY7N+l2tFb2Xf3pq8SirHk+RTcV31R+5G2/BzPIkgMpRBbvGwP9GrxCp6iLlnTHJApE8WJhIRLxInltc2+rHnSSkDjKVG1S0iuKPGsxMAe2ZEprB9KyWU3YNMd8f0lww8vqfJuR1Y4J0LJDLnfK9KUkTyUq60N04pi5LzZECjwA+6oWtdWMXugTELS;20:P8mh+SCB4hWxHh8kHqTtrQKBtaWUhwIP+aO9512VCTJaZbDGhTQel4QKn2arqCOS9V9iMLqdFJptHJfaC5VNhBrF1aYuXu9ri3pvNdtGw6thZ7crdrAEN9p2QL1ZFw9OD2MNgayRoCKMPEe8GURDo5xM0MTfKjyn1fDtNCF92pg=
X-MS-Office365-Filtering-Correlation-Id: b74d85d3-e384-4d0d-e060-08d59db12e3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091761AEF7BA8EBA4CC7DD08FBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(2900100001)(2501003)(14454004)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: vY/BCvXlX94r7lbiqAFCv3vGF+F8+cLE46/VmnP/f4Bu32GHndOPnypvLmHtCqaugxdfQQkWZ5S0wiSlki583yH1mK16TbqC+FW1eSKFGrOwiCg4vNLgutW2P9XiIO7p3R/P0jBDqYdcqYZN4bvx14SWrLSEpUJvjnG8lBnC2sHmiT7rcopP7LO2QB6yoMZJIuAZCQtS2lADuDDBaXfAUVVy5BXZyo8qp9RLsrSqNKLZUAOonNnBxczbV7MugiJ7ewg4n0rRmJWQf1XgtaNDJVrEds8fSwv2i86kOCmBkpcrEu2mShh9do4OGobQH2bAa+IdppRaxXKD2MJrPdubviHMQT5bG1C/uoeLXY0D/W29Qb0lgI5KJN2NhFZrkxPT2JIyAYzoxtyNZRZPOSjvwLx1UDH2bdoFx1l4vYBQNfY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74d85d3-e384-4d0d-e060-08d59db12e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:52.3626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit c00b396ef782cb2296200d868a0013d8ca1d615e ]

The pmem driver assumes if platform firmware describes the memory
devices associated with a persistent memory range and
CONFIG_ARCH_HAS_PMEM_API=3Dy that it has all the mechanism necessary to
flush data to a power-fail safe zone. We warn if the firmware does not
describe memory devices, but we also need to warn if the architecture
does not claim pmem support.

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvdimm/region_devs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index f62306246ca4..2ac9c6222914 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -970,8 +970,9 @@ int nvdimm_has_flush(struct nd_region *nd_region)
 {
 	int i;
=20
-	/* no nvdimm =3D=3D flushing capability unknown */
-	if (nd_region->ndr_mappings =3D=3D 0)
+	/* no nvdimm or pmem api =3D=3D flushing capability unknown */
+	if (nd_region->ndr_mappings =3D=3D 0
+			|| !IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API))
 		return -ENXIO;
=20
 	for (i =3D 0; i < nd_region->ndr_mappings; i++) {
--=20
2.15.1
