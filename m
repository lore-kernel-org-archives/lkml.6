Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241416-2-9113680532272054724
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241415; b=Jc4e8z4Mt8+n6PmHHVbFwv/FXymOx4g4dvJTRb8KracREirDOt
    5qFtlgCpWKnHWHKE0cAnPxfaWq/ANTs/6sVApJ3wfu/hsBcjf5hCgBw1IlPnr3lC
    Fx5vvThVLoobYyKgo3yKWvCXLCWtKEPD0o3mcWSMk42j1bqri0Dm0QDzxKAffkec
    uDz7GKK9UhLpjt33gG5pc6fc42elpKrrXxTN9L+fLw9LviGaaXWbsGaZ5dLjU1LQ
    q1XWAqdWxgMJSbEDkefrIs9LmDRu2KO67PwAsg3L+4TNzDSWAaypgG2+gTyzrgFr
    19E7/WTSlJSUFC/+I6/2CNuzB6VELOehjNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241415; bh=m+Z8XjcW6K
    q2UB965QdZItzXslhlpNFqbUKleE5KA5Q=; b=JYLGTVRhvbBZ1Wt0VjrD/197ZD
    HgU7orXDjvXWd3qU9A7gZ8uc1ENCvBdMRqfW3iNO0xUjVp5VqE6Eg4IJZK3eFiTX
    dosMLSPK+Zai9TdpXxEk9CSONMRKKYAiE2VAYlRMJFqNAdhUMZorIWLuyGY1uCUP
    ovas/j0yD7KHNd3rxnsmd8IO2S0YpOY8/dN/ElBoMGekwdO19FBqQi4rY1qubX9W
    cuuMIhZ3SARORxs7V1SV/+KvvI39umdDf74FzmVTCibqtfB3c9QuIYWYd6VBGRb6
    V1OPpsPmx3Ph3ExZcJGEL15M2WA1PFissFNfO06Axtt6MPMgyH32SHcxGJPw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LvCBXzWO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LvCBXzWO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAvqZtpE8f8LhODCjJOUR/MmnneCWPG2JSGnK3sH40u9rgt6mL1xULkIGkxLnvjRzmi14YG7pmVb5PLmzZvOgURYj6EHgBx3QW4DuqOS2oUHROE6AE0P
    Jtaf6RHvvu9va0ZDuTsEhcIJK8lssvhyCR7eejMULATp9Xxj6x1Uwt0hnSYflTivwMBLV4HM2YabQuCo5oeISJl8FUIJP6e75JuabaHC1xuPukpiuWuu2BGy
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=MvuuwTCpAAAA:8 a=uBuKx8GwAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=FTV7JI04X_Kud7wTVqAA:9 a=wMOkgWOKg1BKXFGZ:21
    a=-iYkbyc65CaTKKsd:21 a=wPNLvfGTeEIA:10 a=dVHiktpip_riXrfdqayU:22
    a=wZgZ3yaTFkxMEWn-yT5t:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755624AbeDICgj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:36:39 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:11355
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755617AbeDIA1f (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kevin Barnett <kevin.barnett@hpe.com>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 049/293] scsi: smartpqi: correct bdma hw bug
Thread-Topic: [PATCH AUTOSEL for 4.9 049/293] scsi: smartpqi: correct bdma hw
 bug
Thread-Index: AQHTz5j7HkI0+N7RE0OFuReZ1zI3eQ==
Date: Mon, 9 Apr 2018 00:23:28 +0000
Message-ID: <20180409002239.163177-49-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:bOyDp9H6mgc5G2850JUO5nuWvPIxsQoWjmOzkpHYXYPFvad7uP2lBqcZaO3UeWhCiyolgf919fmdLTfofTNGvxAKX0DJQ8p37v17dBeZef77OQ3BCfg6cYZtlUufF5KHd1XdEz6EjQRHgPaO0Awcp0Keh6OxraGwFuw68npsY8S+P3h+hbuhj649so8pxB+4VsIWuHGZNHJPsvi4mfB61G7iwiwfZSCxnUHCWn8l19mty82xWa9wsQqbST7drJZQ;20:7A/KVDCzJ1xWLrWaDVvEuTKRDxH12Sk5aw3vM3jloNeA0zQsUdQ/pOt2mPl4WZ+jLVZh3EmZXv+KL/Od13bU+4azBQ4dUmz/ujJvgU+hNZvjq9o/b1jVN1QU6D1Edf/PqtY6WjOE3yBijiw1eO4QtGkeu3rr5na2voRsn92yzAQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a26e8a51-df17-478e-e2ef-08d59db0ad6f
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10318FAE1F2BE485E99590C1FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(227479698468861)(89211679590171)(131327999870524)(72170198267865)(146099531331640)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(8656006)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: uy8XJu5T3GDMSPthvpO73QbXK+/e3l7rU+omOw+j4x8k+bOj/ktCo1fm1CFYcKiFc0VX5wW8DpjKAKHZW06N2buDabD821zbiL5qbz2YuYmJizRDFygu4vZpTFmDj79AMLD/i/Iq6AVJcsHQjK/iTW17FxaDM8OFeOY/Mj8RZkCnRxOJGjAvNF0oRGyHNMSBxi+WogEscAU4RtskkWTo/QRw5jPBSfjGUbR991YLNNlSOMCZlcVhS50ZuPAsHdK0ZuxoUSLi9dg6qT5BrzMWG85zuv/aw6OS0EBRuC5a+btqLEi9Mu+tf9WnbZbgo3MnjomnpzArQnz/E4tmF0Ja63skUXU/AraZhwBkcROZFtyRvRkvOhi7twMLnZoBJvSXlfNAuZBu6oSkLzWG5f93k7AxOHwJUiuFbDZbo3J+eqg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26e8a51-df17-478e-e2ef-08d59db0ad6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:28.2530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kevin Barnett <kevin.barnett@hpe.com>

[ Upstream commit e1d213bdc3e359c6c5da8ebbc5b2e87b376e8777 ]

add workaround for BDMA hardware bug that can cause
hw to read up to 12 SGL elements (192 bytes) beyond the
last element in the list. This fix avoids IOMMU violations

Reviewed-by: Scott Benesh <scott.benesh@microsemi.com>
Signed-off-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/=
smartpqi_init.c
index 96a343ec8313..fafb50e2f20b 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -47,6 +47,8 @@
 #define DRIVER_NAME		"Microsemi PQI Driver (v" DRIVER_VERSION ")"
 #define DRIVER_NAME_SHORT	"smartpqi"
=20
+#define PQI_EXTRA_SGL_MEMORY	(12 * sizeof(struct pqi_sg_descriptor))
+
 MODULE_AUTHOR("Microsemi");
 MODULE_DESCRIPTION("Driver for Microsemi Smart Family Controller version "
 	DRIVER_VERSION);
@@ -3024,6 +3026,8 @@ static int pqi_alloc_operational_queues(struct pqi_ct=
rl_info *ctrl_info)
 	alloc_length =3D (size_t)aligned_pointer +
 		PQI_QUEUE_ELEMENT_ARRAY_ALIGNMENT;
=20
+	alloc_length +=3D PQI_EXTRA_SGL_MEMORY;
+
 	ctrl_info->queue_memory_base =3D
 		dma_zalloc_coherent(&ctrl_info->pci_dev->dev,
 			alloc_length,
@@ -4117,7 +4121,8 @@ static void pqi_calculate_io_resources(struct pqi_ctr=
l_info *ctrl_info)
 	max_transfer_size =3D (max_sg_entries - 1) * PAGE_SIZE;
=20
 	ctrl_info->sg_chain_buffer_length =3D
-		max_sg_entries * sizeof(struct pqi_sg_descriptor);
+		(max_sg_entries * sizeof(struct pqi_sg_descriptor)) +
+		PQI_EXTRA_SGL_MEMORY;
 	ctrl_info->sg_tablesize =3D max_sg_entries;
 	ctrl_info->max_sectors =3D max_transfer_size / 512;
 }
--=20
2.15.1
