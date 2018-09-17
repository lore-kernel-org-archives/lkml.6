Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD222ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB7C214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ee+a/jBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB7C214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbeIQI3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:35 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:1680
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730167AbeIQI3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvbVaqPdATNXaQi0qSjNlPTwip7CAcuFrj7OB4NyZDo=;
 b=ee+a/jBnsZa+/sjVaGnD0Fx0FJxHC5qtQCf9+7dRWPGuL6d2DSYMtAhuho8a+ohd8S73F5BhIc9rPyy4SlT8FVICguS/MH/kAOBMrb0pNXM91Jf0VaB3tpsc99FxpuXIyiTbJoEdspLkHGL+Z5Bw9PR58RoGvqCg65/8JNTldwo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Breno Leitao <leitao@debian.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 36/87] scsi: ibmvscsi: Improve strings handling
Thread-Topic: [PATCH AUTOSEL 4.14 36/87] scsi: ibmvscsi: Improve strings
 handling
Thread-Index: AQHUTjLpDX7DdbkAr02x2hiXajBjlw==
Date:   Mon, 17 Sep 2018 03:02:46 +0000
Message-ID: <20180917030220.245686-36-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:inSxz4YtAXJfwndSoyuA59qE6+RS5TES3sbuw4yTKzleAMLzKLv3yFaRQFd2Av8ElwswH2j7IXbtvitgruIf+aTNEjV8hqwCb0+bjZnKKZH+nK8WRvv+xdgllYD4OHfsjnMYtVYAFoQYV//6a5ZaH3hceSbk56cIikCReF6Skhgf0IUPTUnuJNyH6/IYDmouwIDPq753EyQ1NowFnfMC2onZmfTb9t9B3fbFzNn86BJ82RdLyyJsufLL30EfSqaAquJCrdBSnzpeHUySwUD7csXOmVVh/K/8wh4ULhPm4IzmuWzdzqYJhE2MctVZt/iNSZ7xGEYbA0l8oJt5eb14b9QwW5CtLXoVj0ytuf29ivvv/EJThE2Iya53RivXiTOY0XYOpIhRgRmB1cpgMu4o5BNGWHdaae2+NeR+glIvQzm46rtJjkA6pCquDFBv7Xon6Jl1dzJuoCuguTCbgD/K7A==;5:4UDIpyT50QIp/NFlJXIXCrIBEHQi6t6cH+MXmHxqcoelqK6SIObTheUHgU4Ij/smMj7fybQI1FihlXOVfezrlH6MbJlfqWO81dtlh1oq3TXgncrfrjJQZfXZMbzDVrc+k8rAEsLvKtNK9L8I0nI5OnkspHhnqw19kRjQtOnJsQk=;7:afNxBiz8UfaC8V22RuQtbenLrQNf+nTZrZcNqUrTAWzryLA70JBS9HdUsCxuHKIDVnXUPamy5H0LxIyL/M5ifXPzYhGqgNAGWSEZp5GOsPBzO16VoljGybF6Q44zS1KSck2weJvZUD5byps7uALeb0I40bVnywvMv9bXiCbSI1fFO31HO8SF2ubTVNhoRjsaWdd2xcCmgdFfpmI/o3wNydn/T1qnTUen1kBlDk3okK1OsEsJudTuX57DNz8sHWl4
x-ms-office365-filtering-correlation-id: 2976d291-914f-478d-5928-08d61c4a3f47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB07764ECE9EA7A92020621129FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850)(104084551191319)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: XtfYG+fPY/1ULU49OPYlpDYjFZo/OkVwg6VqG6lA8O0koVAEdEkiZOR0HQP4zwjOzgL6vXfH9bej8vPVl5XlgMG4aCoH8lbdzdy4DQDevPME9O828j4rKyeY4/eTRI2pSUqZmxiZiRevn2PDP7sDXpoHRQ2ryrlscOa950BFr5s5P42lFzavQMSrfEeepZcOCpd0WadBEleamIZN0R7vgxzHBSf3EpJO/GujMi6AC8R3YajOtWGXgOBBtU9a5aJ6V+Uqy6nyQoNhRl6pBqg0Bu5r7bPDzPViHQq5bAjbAq5qZsc7mk2cZb8nRpK4nNx9xoal3L8xPq7ZQLwuSuLxZ4AsQO06QNQgKtzPL8trq2I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2976d291-914f-478d-5928-08d61c4a3f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:46.7437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
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
index 7d156b161482..53eb27731373 100644
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
