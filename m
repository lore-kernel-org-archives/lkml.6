Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELv90nImrVvoTfwFP9oGYsgYtG+14j6H1S29GBgbzBdmxWYkkgtaCRS5MXOZQ0/GbVoqPL2N
ARC-Seal: i=1; a=rsa-sha256; t=1521475693; cv=none;
        d=google.com; s=arc-20160816;
        b=nh5QCygSXQAiZ47O+yOHg6WVk4a3Z2qwZqDgBVOnU7EYzlzUGSVmNnJTqJnR6A0TsA
         o/kCksaraqD4gGbMN36co4TGcwUTtKh2gWLVmsZ+MkdanMrvrlUvmvqfJfG8rukKveml
         IQR2llzDdTt5388oU9T6LhpoIrUfnNXrUS281hp7DI7vVrTwUFEM02h9eCmph2f702ps
         GpTXU2Hp9XdXz7f2HN41AI6OSANCVUgMVVbV4/BKFqsxLc7zDATTVZrO1ogEQSzQTWm/
         bmTl89UTR9MDwa01+2Cs9dWwz5KfnKfGkMT034hD7Xs0ii6LZzPtvHIym1CqQjvSix0J
         1wkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=oIs6ofAg8kFTRTvnTyAgURUDODsXK8vw0gxeVYbuzGI=;
        b=RG1RFF3v6qVN/uQHYHZKEYTwgos3u0638AXmreuasG6nQc1NT+pmYBmFWdsfODsTeQ
         ADWJl9bnXR1d6Z35e/lGOTlZg/5IXZWK9k2bUncq3l17nkeTCEKA4GpBoxRVUPN6GJB0
         Ns2LOG8La7S/hbeFHGnVd0asSGatMY2fo6DzkUHANz1F4IwmIBDf3tziOsOgIWiRARr/
         9wxbswg9qG3KyKjSteXBdVIeNuPlBv7UEtnbljO1u/UaKQHHhPmNwbE96dWEFfqlGioC
         4faw+yWGkfEMGH/XIQJi4r2X7EdXDwm7rbeCJbXoNvmR7CnKazjsH4YwjTY5ETq37ODF
         puZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=N6kuO0EE;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.100 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=N6kuO0EE;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.100 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 045/167] USB: ene_usb6250: fix first command
 execution
Thread-Topic: [PATCH AUTOSEL for 4.4 045/167] USB: ene_usb6250: fix first
 command execution
Thread-Index: AQHTv5w2EvpA+iwtzUOVM2BOV2BDmg==
Date: Mon, 19 Mar 2018 16:06:17 +0000
Message-ID: <20180319160513.16384-45-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:hGi6UQHG7wuoAb2G92PdAxV6wLUBipMsQlhAvI//e9C4DApH4CqVCgpgF8YEJROHciBC0wjHk/HIUW6O9gmp10AuWljfPfWhtri9d4x1SPBO+U4vs2A6f6hsk54pmfztdF0Dcy6wx6WhJicpE0YULIzBhlvQiE4g/DdHga1rf3XhALaaEh8/DRjF8IBfa17VLBs4QgCtFWA+LDcgUqk30pEZXpQsq0an8TEb+J+JMCcO9PF+AnqXwOVTiYCZpPlM;20:gym0T0g3M539oZBprRQqurS52CVJabzRW+R5+VzRkZrRdR3R/BLoWjlp16jBRhPn5/HHp0XkCkhm1pxXBzl4cw0W6IPUR8xVUfWOwyEIyVe/eenNWsx9Yzenl6lubSj7Pce1rQVhJTUoPpIka2lvjCCbJ45eh3OBa/hCvXWzS6o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d034bd6-a5b6-4128-9667-08d58db39d69
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08053E797879D40608C9A959FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2eUr0TkslNqYZ6SQTW6fjQUork1ta2Az1ggd1aaNERHdBrJmL8P3uV1r052wajMXEP80mWjLtRZU3mAihfgBuLvvSV4kOug5PSTOR/6gea4K43LzfyH3WHZ8NrAMUJC04RoHo7v4HcWE5nX2wDUJlHnujyZXxHqimnH389AIruHYF7M3cUw5bR509ldWN1R7UL/hUSS+caMhacCmBKPvHJrQJHLT1CzNCkQytQU2NNPbZLhth5rb3YMvLtgPybhwvGY3nnCD9KfT/9qMok5JLSddQMoD9Z/MggWiabBCL7HZ1f5sJXwKqT1T/3jr3eaJ6SHuyXXkZxYewKMCua010Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d034bd6-a5b6-4128-9667-08d58db39d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:17.5996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382379241586262?=
X-GMAIL-MSGID: =?utf-8?q?1595382897210059465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Stern <stern@rowland.harvard.edu>

[ Upstream commit 4b309f1c4972c8f09e03ac64fc63510dbf5591a4 ]

In the ene_usb6250 sub-driver for usb-storage, the ene_transport()
routine is supposed to initialize the driver before executing the
current command, if the initialization has not already been performed.
However, a bug in the routine causes it to skip the command after
doing the initialization.  Also, the routine does not return an
appropriate error code if either the initialization or the command
fails.

As a result of the first bug, the first command (a SCSI INQUIRY) is
not carried out.  The results can be seen in the system log, in the
form of a warning message and empty or garbage INQUIRY data:

Apr 18 22:40:08 notebook2 kernel: scsi host6: scsi scan: INQUIRY result too=
 short (5), using 36
Apr 18 22:40:08 notebook2 kernel: scsi 6:0:0:0: Direct-Access              =
                      PQ: 0 ANSI: 0

This patch fixes both errors.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: Andreas Hartmann <andihartmann@01019freenet.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/storage/ene_ub6250.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6=
250.c
index 091e8ec7a6c0..eebfa09bccc1 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -2306,21 +2306,22 @@ static int ms_scsi_irp(struct us_data *us, struct s=
csi_cmnd *srb)
=20
 static int ene_transport(struct scsi_cmnd *srb, struct us_data *us)
 {
-	int result =3D 0;
+	int result =3D USB_STOR_XFER_GOOD;
 	struct ene_ub6250_info *info =3D (struct ene_ub6250_info *)(us->extra);
=20
 	/*US_DEBUG(usb_stor_show_command(us, srb)); */
 	scsi_set_resid(srb, 0);
-	if (unlikely(!(info->SD_Status.Ready || info->MS_Status.Ready))) {
+	if (unlikely(!(info->SD_Status.Ready || info->MS_Status.Ready)))
 		result =3D ene_init(us);
-	} else {
+	if (result =3D=3D USB_STOR_XFER_GOOD) {
+		result =3D USB_STOR_TRANSPORT_ERROR;
 		if (info->SD_Status.Ready)
 			result =3D sd_scsi_irp(us, srb);
=20
 		if (info->MS_Status.Ready)
 			result =3D ms_scsi_irp(us, srb);
 	}
-	return 0;
+	return result;
 }
=20
 static struct scsi_host_template ene_ub6250_host_template;
--=20
2.14.1
