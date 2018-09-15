Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B000ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E973B208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DyF4gsgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E973B208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbeIOGue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:50:34 -0400
Received: from mail-eopbgr730120.outbound.protection.outlook.com ([40.107.73.120]:32793
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729438AbeIOGuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdqYp3xcfKG24aKivtK1on6bSgMwQpJTbOWPhGUpXv0=;
 b=DyF4gsgA5hITlDtp8P3vEAajkoDmv/YOlCsUG0BObutYySmw0qSyU3YhZu/utiY5GddLZOfBp0QQaoG1Q7Y2fe/jc23EGN6CtEsxWjj7q/DaYt8rXry76N/Uv3TUJ/gMW55jrDZShxYxrV4vk31MTgZXzafmGjPWXOVwy1dHBek=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 46/57] scsi: libfc: fixup 'sleeping function
 called from invalid context'
Thread-Topic: [PATCH AUTOSEL 4.14 46/57] scsi: libfc: fixup 'sleeping function
 called from invalid context'
Thread-Index: AQHUTJQIS0wfw5QnGkyI8tR/zOF/Vw==
Date:   Sat, 15 Sep 2018 01:32:58 +0000
Message-ID: <20180915013223.179909-46-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:Q6YU6Qr/PmV0svj+4K3Oi1+UFT5cA1Go9VFp/8z5CS8bksoL2Xo/5Fts3pm/wgZHLEkyFMY1LaNxaIxDkNl8InR8G+/RLF+n5EuvvS6h2/NJmzaJ9MgBorGj9P++Nir8zwen2HMNXHuPTU9j8EOkOEVntPtiZy4KePkJanS4PfDphkhF/YmrAnxMZLy8hldQEcGBY04snDDZ66E5nYjrfd950pJcr6KzdKOEnQlARzf5KUaJEbxMzKTVMCjbjSKKsq9escU4WgrV3GTDh+WdQs8VmqyNNUomvHWwvZBzb65+JOgjctfewj7WyycC4Y27lonECTXyk0drZc5DjFnPpgQkCI19Kr8iLyF8tJFNoFtLH40Md1bTh3ufW9KFxy9Kb8fFwgDyPHWSUmby1o9aYIbIPTt6x0rJAS0qvfkUaj5FGtFVTZeWHyXFc1+9TfTX7IBSQoCyZu47QlJo0cqRFQ==;5:6qXNI0sQRl9TW5JwN464JdTNvWlYr5B45LYWsDNbtubFCL//91IavPSnHOTkwZ+pnMO+UmWfyLLZeROg8iNm2MzUFrdsJRgpNJdVlr+rvIw6BB1yv8eEUffq0m7KMf/vMFP+yrMYAcG1Yz75NGKjzuI9ahyDtDceVzSIVACkBpE=;7:eTgNZTayKieRGkzKCQGDSDn/ASL7WL/p9LKlIPKPOo1DI7FEZtT4crfgUU6LRuApiSSja+P3exLPImTmtw6RP6NNOWiiREPEJYrWu81zV2ddXGdrRbNxd20x3Wgli74YVXwJTuKDArdZGOBl7qb14wYoX8+VsgVzR/BU4jG+Py89T4+/IxcHHMNIlBnEkkOUrogLIqe1MHXjsNOJZA1+vkuvpHpjXPEQVSkgIAAGdcyjMmsWlz2qCbbvyS1LpHMa
x-ms-office365-filtering-correlation-id: 50d44641-f463-4dd4-9a67-08d61aab3a87
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB0471510068EA8E1B60A92E53FB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(14444005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 8vUeBblVn7zriyWU9uPcxcIIo0c6KEwnVVnccTwj0CB5W7fPpO3mQkmhSYjMbNzQmyRjvJjX64oT3Ybmkj+fCPk/K29NmwRI4SLZjg43k9D7ERoyizQge7OhW9EttaHeQbQcWlzUTiPeZ5TEM3tGOEwvmzDlOL0W3EpsIFFPoWb07f9zooPMH49nRwvYOdH6FRTLJS6k7yuWundwVJS7ASHWYro6eMbF3AS7y8in/qTFVNuQuyEt1t/vkPcyjgIhxLJ0jVGT1bLFttwLd+q5kbj45lebW7SZIfUZFVNyHufoRiMvYebMygJNfO6IuPzFP2E3AgRxpIbBJn+5EF+zZrCDPdbXAsyPOgijGxgqY7k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d44641-f463-4dd4-9a67-08d61aab3a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:58.1646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
index 8660f923ace0..bb9c1c016643 100644
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
