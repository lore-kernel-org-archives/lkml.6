Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31997ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8C920866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AkCxD+Mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8C920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeIOGtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:08 -0400
Received: from mail-eopbgr730117.outbound.protection.outlook.com ([40.107.73.117]:17920
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728779AbeIOGsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHS1VPAXCBZU2vPg1Gfx3uUSSbwQ9hyG0dqVd9zscEw=;
 b=AkCxD+MzJWb3LYNO359PnX9Rao3gdP8ihNWs7bSKR/2hSTiyQhfrEG3WxVLRtn4tfFuP2lM5AMxgTwCkbvS1Nnowo9aA21XCd0LTkCyZlH9DOsBZvFjk/cxVIeIOTsERSm/mnmwiduPpLSLlPXQAa2zkAWblPLwPvPdQLXVRu+s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 71/92] scsi: libfc: fixup 'sleeping function
 called from invalid context'
Thread-Topic: [PATCH AUTOSEL 4.18 71/92] scsi: libfc: fixup 'sleeping function
 called from invalid context'
Thread-Index: AQHUTJO1ADtIXLiyMUWpGHJr+Zr+Qg==
Date:   Sat, 15 Sep 2018 01:30:39 +0000
Message-ID: <20180915012944.179481-70-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:ZprwNQfxkMAKq8lLNtRkkFAXnj03xZyXisW0ZE6xJQt5/lSRgOVCsF1p8LuLmG9GheJtCD9y/FG63yXJ6uc0VClqXerETzATMl/ntfrvAPnWBbE2IwCe6xmqVSgcdMkaZwwc0vSp4JI1eyrimvSd/lJ3LJ6crOwu8iGifZbkf8dTRs0LHQ115auQ74bKQhfowpw+c9hFgV3ZetpclM+kRd18I/VwshBVyyhNYwPdZtbGVBmnPGYItNHsfj82vcaKKTP0hC4hr9CBlU/5PY1JfS8aiktXErARTlKAF46Sso2ZZLCuCFcdUUO5iV9cOg0bHu7a73MJMwv+vLpdKz1wMsHNG1YmC2HYz/lsq1iFTYim3sZIYitrjwHD3Y4hSe0jy7auVomIDZIiMOnCacYnJ1scJUljzOF3bAWhqSbxD/R3CUjdm7TqMtfJ2QZd6+qQySeeU7OmR2TFgThEVMsehQ==;5:8JX0GEkqWC9aJSQumdBGBOXXK+RdKFUXx2dweFnwPGMh6ZxJ8dznuiesLV5B8uk5F0Fc2YZ5F3oHl2M1z9z/oT3JQUBaegt1rQf3QbtpsGFQ0tod8L6OtpxSql0nRzUZyCAZWd5olISXvvD/tpNk2GkXxnZsN59Q/ZMZtRaU3OI=;7:gDet01P7MGHzqU2oJQ+3PEdbzUUmH8LKcu/y056a48747Y2qHIelQf7FuNQFe3T+iXosBoOPn+HywaeG490Qenl1sm9sddADd3bmkVF7uHHqth3Fb+vqHyePa1brb6YR2hP3A6y1Ho7T9v1r6BE+oyvv3XCdiQ6OhQb4wM6MOYWxxUHXM2ORRgdeP5Mfs+BiKZsJ34wBn3OoDiwOzm1dOd5MhZMj7mbGGa+Biwo+r1pXzfjQvZ4XNKhOGVTaGlKf
x-ms-office365-filtering-correlation-id: 781f6565-029d-4418-4e27-08d61aaaf91b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470404BA285C55BA2899A29FB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(14444005)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(2900100001)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: QnauT0APWoStKDAM9fpdXuPjfn3px+5iuKG1QIwraVdmhedPDQRdq7g/LGHc+G++ZmKVFSYmnvGOkxaZxC8dhGX+jcIp7PyS1efcHredE19kIzJym/uSJOWbtwaxEY2oQmzdYDxu079ina13Qy8ZbwSs/ly+RSjXw5pcZoeA4Sp5dDqRGy4zrqhZc6XECHYLXTfgAwvdFx1t2WhpnnWDHpHR6p7B0r1Zjq3yhAYG7dauL5d+EbmmrR6eYpVxVkIV50BGJq2Dk+VF4wag/EIREEsVt1kme31d3AF9vH3RvOfmvZpDqWfggBlFXIoyd8o0WvnH8D03ouHtGzvuwiAGHQvJrbZ5kiCcQaSOpmjhSo4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781f6565-029d-4418-4e27-08d61aaaf91b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:39.4792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit fa519f701d27198a2858bb108fc18ea9d8c106a7 ]

fc_rport_login() will be calling mutex_lock() while running inside an
RCU-protected section, triggering the warning 'sleeping function called
from invalid context'.  To fix this we can drop the rcu functions here
altogether as the disc mutex protecting the list itself is already held,
preventing any list manipulation.

Fixes: a407c593398c ("scsi: libfc: Fixup disc_mutex handling")
Signed-off-by: Hannes Reinecke <hare@suse.com>
Acked-by: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/libfc/fc_disc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libfc/fc_disc.c b/drivers/scsi/libfc/fc_disc.c
index 3f3569ec5ce3..ddc7921ae5da 100644
--- a/drivers/scsi/libfc/fc_disc.c
+++ b/drivers/scsi/libfc/fc_disc.c
@@ -294,9 +294,11 @@ static void fc_disc_done(struct fc_disc *disc, enum fc=
_disc_event event)
 	 * discovery, reverify or log them in.	Otherwise, log them out.
 	 * Skip ports which were never discovered.  These are the dNS port
 	 * and ports which were created by PLOGI.
+	 *
+	 * We don't need to use the _rcu variant here as the rport list
+	 * is protected by the disc mutex which is already held on entry.
 	 */
-	rcu_read_lock();
-	list_for_each_entry_rcu(rdata, &disc->rports, peers) {
+	list_for_each_entry(rdata, &disc->rports, peers) {
 		if (!kref_get_unless_zero(&rdata->kref))
 			continue;
 		if (rdata->disc_id) {
@@ -307,7 +309,6 @@ static void fc_disc_done(struct fc_disc *disc, enum fc_=
disc_event event)
 		}
 		kref_put(&rdata->kref, fc_rport_destroy);
 	}
-	rcu_read_unlock();
 	mutex_unlock(&disc->disc_mutex);
 	disc->disc_callback(lport, event);
 	mutex_lock(&disc->disc_mutex);
--=20
2.17.1
