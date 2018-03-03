Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116205-2-642145789597992960
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116204; b=BXSPRJSZ0cHUKADOs5733nXBAiPMjJk0pWEX0Otr65Mt38y
    c1uq1sxehYrEX2uwy2ORi1XcxS8J9z+uso+chY3b3OdzaITlsGw4ZAWplZ5rYFvl
    Rk76s8MjpSN8rTuyZfPLRiD6sUqrMGuXXg/Om2V/OcJojAYlxQEpfL1wGGahbeR5
    tUEZhzdYVbJOUdaaKjxAWP+UJAPPU6T+4WObTGxfEtw2MvjvtP8AW6nGrqImm4Ar
    xnSoA+DxkxSTlQ+RAfV+lnMjvjeqhGk14UcoTtttbbVhRc7vqlqSAZz6DxtS/t+b
    1RfNbYIZDbaBnr8ARHTzyyDvSXCj6LbcUmth68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116204; bh=jjbWf1
    zMqsMCRSnCHxhQWOkAVohQcEdEXRyrN+XT/eo=; b=MNWn4EVe41szEUPXGHptYS
    L+V62RhmVRpk8ovJsAKfs9Z3wGc4/vS/2oDzM477sti+YszH/yxCQI/U8zAz7NHS
    LvaAcjqODnteQfgVYPyEbIE1gVcKg5Ybf0rz86bnEfzdaMQDY+T5ihSDmMGwBEnH
    m9npp74UgE0uDP6B5u4daWGGeK/P4OtnbH+NwUhSyw1oE5ukN4HRNaZkqLv6ZSqz
    GX4ssHdTPQgn5lAslx1ZFrJtTqwYks8CTxuFnpxymGw1oYK34Ij4rm4XuDNLySXs
    5uUZAZbWnw13yQqLA1Gd6dPJchEYls3Jowc3tst9cUMBmaF60YFd7msjPfr3NJYw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QVwztkol x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QVwztkol x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932490AbeCCW3N (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:29:13 -0500
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:12224
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933319AbeCCW3K (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:29:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Li Dongyang <dongyang.li@anu.edu.au>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 43/84] scsi: ses: don't ask for diagnostic
 pages repeatedly during probe
Thread-Topic: [PATCH AUTOSEL for 4.14 43/84] scsi: ses: don't ask for
 diagnostic pages repeatedly during probe
Thread-Index: AQHTsz6qcOKhvYRYnkCQ7BJHI+QE3Q==
Date: Sat, 3 Mar 2018 22:26:24 +0000
Message-ID: <20180303222518.26271-43-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:S75vGJZG5NYhs4P9wHvpZfvkRo5eZWdbnf0ZVAh+l02kBg7hnP9bTOPIAXEApnR7bpAzGd0HYqf1BBlc6cXYkK+oBueBLqNAxO2fm2CFALydFpzR3wtZxyCv+/ABPBpXr82Hg3WpggjzOnOHein8ELZzcKZ9bTqWHOkdil1Fy6T5jQ9rqaBIWelV6gwHmSBySGQxkxR7DEK7pYFJDRPDEtoThf98tux98rUWsjqsn9kfvYEvmKCthB059WFr7C8s
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61237500-13f4-46f3-c506-08d581562d6d
x-microsoft-antispam: UriScan:(43697045539745)(38994716169672)(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB097081953B191C9C06643E31FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(227479698468861)(43697045539745)(89211679590171)(38994716169672)(146099531331640)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: PVB2FoXEVBFBIuJQKLPoKbv8i0ocEUSWOl/ZtsQU1auhG0aGRoEFtUkl8bpLjZJjaciabq/P7j6OEAiumii0LwxMGHYVmoJPWDuvS5OPlcmj4wz0DFbl8cyneUQtuEGsJyrksHIvOWblAzNeNASMEPNcOz/H3xk8+T7GldNgXso=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61237500-13f4-46f3-c506-08d581562d6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:24.6973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Li Dongyang <dongyang.li@anu.edu.au>

[ Upstream commit 9c0a50022b8ac7e863e6ec8342fa476fe5d1d75c ]

We are testing if there is a match with the ses device in a loop by
calling ses_match_to_enclosure(), which will issue scsi receive
diagnostics commands to the ses device for every device on the same
host.  On one of our boxes with 840 disks, it takes a long time to load
the driver:

[root@g1b-oss06 ~]# time modprobe ses

real	40m48.247s
user	0m0.001s
sys	0m0.196s

With the patch:

[root@g1b-oss06 ~]# time modprobe ses

real	0m17.915s
user	0m0.008s
sys	0m0.053s

Note that we still need to refresh page 10 when we see a new disk to
create the link.

Signed-off-by: Li Dongyang <dongyang.li@anu.edu.au>
Tested-by: Jason Ozolins <jason.ozolins@hpe.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/ses.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 11826c5c2dd4..62f04c0511cf 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -615,13 +615,16 @@ static void ses_enclosure_data_process(struct enclosu=
re_device *edev,
 }
=20
 static void ses_match_to_enclosure(struct enclosure_device *edev,
-				   struct scsi_device *sdev)
+				   struct scsi_device *sdev,
+				   int refresh)
 {
+	struct scsi_device *edev_sdev =3D to_scsi_device(edev->edev.parent);
 	struct efd efd =3D {
 		.addr =3D 0,
 	};
=20
-	ses_enclosure_data_process(edev, to_scsi_device(edev->edev.parent), 0);
+	if (refresh)
+		ses_enclosure_data_process(edev, edev_sdev, 0);
=20
 	if (scsi_is_sas_rphy(sdev->sdev_target->dev.parent))
 		efd.addr =3D sas_get_address(sdev);
@@ -652,7 +655,7 @@ static int ses_intf_add(struct device *cdev,
 		struct enclosure_device *prev =3D NULL;
=20
 		while ((edev =3D enclosure_find(&sdev->host->shost_gendev, prev)) !=3D N=
ULL) {
-			ses_match_to_enclosure(edev, sdev);
+			ses_match_to_enclosure(edev, sdev, 1);
 			prev =3D edev;
 		}
 		return -ENODEV;
@@ -768,7 +771,7 @@ page2_not_supported:
 	shost_for_each_device(tmp_sdev, sdev->host) {
 		if (tmp_sdev->lun !=3D 0 || scsi_device_enclosure(tmp_sdev))
 			continue;
-		ses_match_to_enclosure(edev, tmp_sdev);
+		ses_match_to_enclosure(edev, tmp_sdev, 0);
 	}
=20
 	return 0;
--=20
2.14.1
