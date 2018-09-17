Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED49ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19AA208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BHMw7l+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19AA208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeIQI0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:40 -0400
Received: from mail-eopbgr710118.outbound.protection.outlook.com ([40.107.71.118]:45407
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728945AbeIQI0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNeK+JXctuk+zvUFVZSWCuEInANulxVHi1ZgYKL8HcI=;
 b=BHMw7l+qcoTpXzNkc7ONbAwGCyc1k32Gh6Tejacg+OhnA63Malm7l3b+Qt4OmHuv3A11uMrEkneArzNPl0YzLXIIVo23K1Quaqq0DtK71AjAI+OoyDWoHqexf0g+s2AMGGjZCZfHNSRRy7zuK4WdZFxVLjW57E5IrnhkHwe17lw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Breno Leitao <leitao@debian.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 050/136] scsi: ibmvscsi: Improve strings handling
Thread-Topic: [PATCH AUTOSEL 4.18 050/136] scsi: ibmvscsi: Improve strings
 handling
Thread-Index: AQHUTjKfHZHuPIBaXUOLQjRGB7T3XA==
Date:   Mon, 17 Sep 2018 03:00:43 +0000
Message-ID: <20180917030006.245495-50-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:bkLgarQkpOeF+6ljVURDnmTWGg5TXAGebL51rOwW2OjMNYw2/p2wjiWf+PEHDiotYXidj/DdY2eiHKpmbZPyke7yn5seOSRgDgrZ+9FeDJowJelIk3LvCGyiP8KFavDvB+p8X1KZaxTlv1YGqR+NME49mRC4NaxBrN2uKCzkNh4G8abiGWBP4NitnV/WcTxQ3iWVq8mT97iPOHRT9PLIDpBowjsATq0zqtntTUPfA63K+d6Ytq2haIHeVJX3hZ77BRlK36mfbj+EFtvkxku3VOmeItpQRRvsYcUKxhTQKzyyvqS7biNQAJHSzZz2cjDjSa5Vy9fM6dMSYozFR9ho/qZRlYmG6Yl6vzwmGyT26IH2bWpZt2k9piXQmet2iZj/v16M7zQSVBzoxCq2h/G8MmZ0iCES5s7ue5TJenrvpHbdMv2Fc0OIqEj0Y6PXi9hr/mFogW42y7+nD0gp5ExD/g==;5:h5cqWeI6fq8fWaXMgprqxUxRrdHlhPppYQAcWUoKwTZ/1pSi1ca7J3TKs+/VEcrXa+51YM2npacmX01yIr3WSeo70bB/iX397Op4Bx+U7BWe/wx3Ypktno1az9iIl6XAOmVaNExNeGcdM/4XTEbmUItme0PbZUdYuoatNQmUmx8=;7:pxXSEihWqACQ8eRWlzEWPJmKN5LrGigJ2L2W8M6tE3BXT+cW0/45azikyXPtoY6gxJSz1DzVOn834P7MvJnHX4hKBorfklNtVwtGJ0OGm1MZ7SEXVcJ6Z1ShNpu4RHRKh205sd68/brfTfySE79HNxGrA5byQquV9/G2dQ9LbdZRHaretT3CEE41F+FI7Qi6OOqSBSlEjtyqta1fIpsIIHAheImsd9TItQmarWT4r5g83bkoNb1V70/NkKNeZ25/
x-ms-office365-filtering-correlation-id: 91267e60-afae-47bd-6aae-08d61c49d38b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167D7538E1616AF028CD91FFB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850)(104084551191319)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(575784001)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: n3T20WCo7hLEkuU3bqHKUREvfDwZDJaXHZymcrCCFR6IYAOtMCEgMYPejByE7Vi/tfge0zvlVT1XqkjdeXGVIGmd8EQ8bMSMuc5g0s5umjH8Hu1lhVW4Y0VCECBDmjeSmUWcx7wyhbRvXya1K90+fdSFsTJ+LlqkMEXkMlRNK1MwKM0jb0WybyFN7LZ4sX7DuaZWmbC1FUicKJ7L56Kw7qHrSBOGvm7NJVJFSlJK5/u2owik7ZJ7n+C6YWqSxlhWFRM04xCiKaSsbNqVFCOBxdiK4hc7co6OHCC1/LmvhjXgtiPkMUN65ut9uYtoBg03mMvdjous06TnRELxCPHS0/GPuE6cNM0DYjE4R2lm2Hw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91267e60-afae-47bd-6aae-08d61c49d38b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:43.7608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index 17df76f0be3c..67a2c844e30d 100644
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
 static LIST_HEAD(ibmvscsi_head);
=20
@@ -262,7 +262,7 @@ static void gather_partition_info(void)
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
