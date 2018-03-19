Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELu+DrOzCNwZMBe1nDw4b4U8KOW8k70Ko3fUWnTiIipXhjeEouiNbukkHF4c+eCmG8CrA0Dq
ARC-Seal: i=1; a=rsa-sha256; t=1521475931; cv=none;
        d=google.com; s=arc-20160816;
        b=KcC+27pjeY4juYIk+jOaHn5ziwvu7xDb0YaTKBDlUqPjaa2COyD7p/+yizbK9zz7fO
         mKFmKVRN/BrY/7AXhxVHzmOI7D5BXomA3yb9JNDpTe7SJZhXcuVCiKyKoxNy8Oeiczz/
         aWF21mnVlEYqZGRYm5y09YvtHJKhkTDtfxzoz4ltScupA6sIGVXOWVdoojFDCY0vGDCy
         Irn2YnObyEgiq6C89J9Hy34rcRV4vH3gmMv6p2yETYtOtSaHbpPLIAlBXgvP+y3rPViH
         mKD+CIfB3ZLR4FNMcgnOKO1uA1S5eVpuA37cDcU9k2lBVnt9hPY052/fGsfvZFiuN1yx
         ZfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=ERmxn+0GRh8KShSH8zB6K8CGSp/YmziXXEWGNZ22sPQ=;
        b=wO2j3kLW71qafG2ig7EjJ4Cn2zEOPOflH3hnciqlZvkG3YLKqSWZObYSgv2O99PV91
         Md6rxuh9QtGqFSdXH8nsIcb5FBA+clmVvfLe533RcgaJQA8u8hR0ERTP9JjNpE/PbY9m
         qNx8pLeS+R66QOKGesv93oRc8kXg3IJb20xfLGzolSwtC0A5ZjTWuQ9eqBjjSDcHj1OH
         Aye3V59phJ33wwiTic3WPLPmNYqeBmCXZodRIRS1lubcKjnV8NolmOgGl/1qEFIixk1T
         R3JmZldm9i79h103Vkx8zj4VShslAtfSMhwuSCex+F0vOE57Qh/GcMt2v2E9taOULhve
         xoSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Hvg0zmHM;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.115 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Hvg0zmHM;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.115 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 032/102] USB: ene_usb6250: fix SCSI residue
 overwriting
Thread-Topic: [PATCH AUTOSEL for 3.18 032/102] USB: ene_usb6250: fix SCSI
 residue overwriting
Thread-Index: AQHTv50G1xMh6svlFkG9bESAfieIcg==
Date: Mon, 19 Mar 2018 16:12:06 +0000
Message-ID: <20180319161117.17833-32-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:e0dZLkB2jvhJ5Ul9ocRhLm95d4gANSPtlrWNZYKHDGWT8iIYWRkfLOErP0yR7seAX3mrmjW7EyNhYYgcVlFMpU0l1ySqDBAWU1+xp3hoyS+pRaiclZiXMkfaqSpAA0XFXqaPV+Mr6EmTu4OmYr07IliwrKvG8d2k9+yLEekxWRGmtyGySHHSwGJf3JV+sQzFcW/ON23kH5ET+22WGlUvxKCowPALOvFLGTXnt6IgiCm7HoN8eB7dUD2zTGtjA3V7;20:Q4SePbDIiH9QuQbfwnVCeER1pYDb5UBvkxs7qiGjOroIqNVd7vqnrmqi5zOjIC7ybwRT8WxSTwoZS3C8cajCvqNO/miNfLUmQWAJrbkwsh9sn6IRwwyH1TbD4wOkxnd+yYv+TpTQ8kPyN/izGLd5JG4Q73J01wTpdujbi9OV1sU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acb6a6a0-3f6d-434f-1467-08d58db42b42
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920108A8BAB4C9EE1C1E3C3FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xB9gbBrYJguDtb8ZpzAVvkxucGM+/LfUeq6KPQSevbp88h3qGGhFaCZPzEOmLNBoglmTmLTrWjyUyVW0Pq/9K/P03UwwMFsfqCYSJIQ9zHS68uXYC65yzBM82EPEsNYGj1yT+NAoGgaSYsYlD6jZuEgvF7HIvGgvyd81SE3bxFwE433O2M2bRKgnuJKYOcaGXLrOudcCVkRwDwrHzy4L7swlZdbrlpEUvGYKLh/DFdlZO5FtgP8OLnjY/QbXcNRX96BwSECDEJo0A8JTI9RfcLk9XDbP5yEMgQAt0aBY4/P4pHrEu7Aerdqe4EVeKEmzB3TbJjPBx98qIIk4gmPtsA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb6a6a0-3f6d-434f-1467-08d58db42b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:06.8900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382379893976957?=
X-GMAIL-MSGID: =?utf-8?q?1595383146019469552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Stern <stern@rowland.harvard.edu>

[ Upstream commit aa18c4b6e0e39bfb00af48734ec24bc189ac9909 ]

In the ene_usb6250 sub-driver for usb-storage, the SCSI residue is not
reported correctly.  The residue is initialized to 0, but this value
is overwritten whenever the driver sends firmware to the card reader
before performing the current command.  As a result, a valid READ or
WRITE operation appears to have failed, causing the SCSI core to retry
the command multiple times and eventually fail.

This patch fixes the problem by resetting the SCSI residue to 0 after
sending firmware to the device.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: Andreas Hartmann <andihartmann@01019freenet.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/storage/ene_ub6250.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6=
250.c
index 7e0bb58f7944..e82e179f3558 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -1950,6 +1950,8 @@ static int ene_load_bincode(struct us_data *us, unsig=
ned char flag)
 	bcb->CDB[0] =3D 0xEF;
=20
 	result =3D ene_send_scsi_cmd(us, FDIR_WRITE, buf, 0);
+	if (us->srb !=3D NULL)
+		scsi_set_resid(us->srb, 0);
 	info->BIN_FLAG =3D flag;
 	kfree(buf);
=20
--=20
2.14.1
