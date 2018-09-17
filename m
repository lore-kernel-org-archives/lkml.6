Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A334ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37685208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="m2T8RcKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37685208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbeIQInD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:43:03 -0400
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:43296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729432AbeIQIbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snRggXdxcZUl5BFY5egV993x7WqGyxH/u3qPm8kdsYc=;
 b=m2T8RcKx+YkwqsV8hdFCBUW9A1On/Ai1CezbgFUzA0dUEOXt2t89fXKtrLI9TRMX2Psm8j4fpRPT8E2Hg01+Z+wK8NRw8LrjeqrhQh0puUGt/Rou4ZPIz99dnVWZIILRhnVb4KyRCFRGHy3F5MRq5Ve4UFyAuNQDU+R7/ccaK3o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:05:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Breno Leitao <leitao@debian.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 26/57] scsi: ibmvscsi: Improve strings handling
Thread-Topic: [PATCH AUTOSEL 4.9 26/57] scsi: ibmvscsi: Improve strings
 handling
Thread-Index: AQHUTjMUT0B460ex+U6pcExX0bbMsw==
Date:   Mon, 17 Sep 2018 03:03:59 +0000
Message-ID: <20180917030340.378-26-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:aJ2aaMwhIXyB5NFEjNusvWKy0asefz8qa+CLzWedsG4kCYbsNSTz4jZjaxNC4P9i0RW+71THavgGtFrwQh6FEjWE83lXK37I/E/1uW9O31/3kmFFxHWkITjNrw+0TfWapR4/+7x3quyzRXLrKfy8jHWDrTgQfqVytcr287N3ICnvvsDNsC2jn/YHkfQhVa49QwMmrVd4CdfEQ8VMlUYt2qgWTphJD7+0od4Me6vAm6Ev1sO1nGpldiu1I1tsjDwne+arEXwyIy91ScR/vxOeCrYtaQAOfrBTN1t5ieoDPG0VnLBhKEnjNECtgDC66jmxQH3jPC5DH9TEn8eQ0ao/6hatHwMCDyoQsPXfJHbMe08IxlPQS2CN7Ay0sNVWgkQnwTqvs/Crg3nKWbeK7Bom8raPBCdHNPa9rhc/wcjOLP8wmnJAUfENlSEtC8xQL3l1cbi4qsKO2HPsHN0WckpAxA==;5:GLDQ3n1ehDOyZhApIrOG7DMjvkU45aopPN5fbJ9TCIgtG0SB2JyXfC3Q3x/1nW9c3Z1Y00CT3E1wAikBv+Znp4zutyhO7OhXnwtoN+BIE+1hxBg1yFdQq1Ea/PLublHDxBMj2vWY2LbwCSeg0wUVgOJK2Bl5NsspIRMQ+GFKi48=;7:lUevv2n1yesywjuzuarLD0Cs+vA1hnCDkofaIN+gsgICwX2zoXZemy3EUsVCgRN/u43o8uUX+gM8cogSuMspk1WsemijXPdRb/KuQWgHKPXUfVBXR+tb8jlu8mpNLgyuHYKI7cJoAQnlgkG3VPwuNvrCNWAA0khsc0gsiblv67LdE5kwQDpfGfZx3x41p5hir/og9T1o8/F8fWZ/EQ3tjPVgrrW36lLt40F+YIgAf36Ctz4M7bQjy1QPWnRbk7Z0
x-ms-office365-filtering-correlation-id: 69e70019-fef1-4876-4cdc-08d61c4a761e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07570E1D014E20218E306A0DFB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850)(104084551191319)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: EwMExct2A3p0LXXf25zPFOmsAxkJxHFu8yYWs7OMa++qhmfJTzVNX4S2rO0rQsjCqyq4fP1ZWZKYI0Ki/QpdKLJUJ/7HZH35K+ek50iMMUOovPmUQZlKhzos4XNXN32jbgWTjed/siso0szOKeZRnMNyHjuw3ARrwbg7Vwb6cEaHcRirSwWtkqp3VrrZ+0E2HVKhNMXTkVHuSqsjc9UGheJI0H+zYS2wd6w228L+F/1dlf6USKGdP1JxiuLp67iCM3nCYRzf8GsBCKGYT84cVFgnyFBd1SXRBFlwWHsDOZjwons4qLcJJy1s3QvpGtmCQLq2TaetSXzmprB0R+QfdHlSR/9t+nU0W+UICayQn4Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e70019-fef1-4876-4cdc-08d61c4a761e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:59.5709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 1262dc09dc9ae7bf4ad00b6a2c5ed6a6936bcd10 ]

Currently an open firmware property is copied into partition_name variable
without keeping a room for \0.

Later one, this variable (partition_name), which is 97 bytes long, is
strncpyed into ibmvcsci_host_data->madapter_info->partition_name, which is
96 bytes long, possibly truncating it 'again' and removing the \0.

This patch simply decreases the partition name to 96 and just copy using
strlcpy() which guarantees that the string is \0 terminated. I think there
is no issue if this there is a truncation in this very first copy, i.e,
when the open firmware property is read and copied into the driver for the
very first time;

This issue also causes the following warning on GCC 8:

	drivers/scsi/ibmvscsi/ibmvscsi.c:281:2: warning:  strncpy  output may be t=
runcated copying 96 bytes from a string of length 96 [-Wstringop-truncation=
]
	...
	inlined from  ibmvscsi_probe  at drivers/scsi/ibmvscsi/ibmvscsi.c:2221:7:
	drivers/scsi/ibmvscsi/ibmvscsi.c:265:3: warning:  strncpy  specified bound=
 97 equals destination size [-Wstringop-truncation]

CC: Bart Van Assche <bart.vanassche@wdc.com>
CC: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvs=
csi.c
index d9534ee6ef52..e1730227b448 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -93,7 +93,7 @@ static int max_requests =3D IBMVSCSI_MAX_REQUESTS_DEFAULT=
;
 static int max_events =3D IBMVSCSI_MAX_REQUESTS_DEFAULT + 2;
 static int fast_fail =3D 1;
 static int client_reserve =3D 1;
-static char partition_name[97] =3D "UNKNOWN";
+static char partition_name[96] =3D "UNKNOWN";
 static unsigned int partition_number =3D -1;
=20
 static struct scsi_transport_template *ibmvscsi_transport_template;
@@ -259,7 +259,7 @@ static void gather_partition_info(void)
=20
 	ppartition_name =3D of_get_property(of_root, "ibm,partition-name", NULL);
 	if (ppartition_name)
-		strncpy(partition_name, ppartition_name,
+		strlcpy(partition_name, ppartition_name,
 				sizeof(partition_name));
 	p_number_ptr =3D of_get_property(of_root, "ibm,partition-no", NULL);
 	if (p_number_ptr)
--=20
2.17.1
