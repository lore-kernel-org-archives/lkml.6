Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123962-2-3664884249114413822
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
    t=1520123961; b=Og/DwXz/k8hFVr3d+f/Lpi5OZERto2N3SgXUNRpbzSd38OM
    ZECn/WLRBXJ3WGztiM1wQle5alGVcFhhbimvpNGZBLh+Z4ZaMdKhWAxTh5f/oQy9
    72y4jmyV7Oy1NwRSvxH2pHTxqPnUSKxJzLQcZ+ueEVG34iBHZHX+J91nuBhXadn8
    IfMUt4ykjL2sq1+cGc7VqCbsArBqa0/MTjMlRkOcLN0V+53DMgDXRoYyp9EG1mEX
    UzY1ATnJt9uVpK0nGHUiQX7dHkuCGGMXF3jqeFnOSzEB1uUzYJ2IFeE1A86sBOKm
    aX8JH4s/UUu9pe1GKn0d4RhAz2p9cGB5TFZOS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123961; bh=jjbWf1
    zMqsMCRSnCHxhQWOkAVohQcEdEXRyrN+XT/eo=; b=KR9d9DogB156MeTHTmhvWx
    uTgXesmvKL12LSQEM+se8zTnHULQtMPJcVHXHmw3onQ0orGmEG9VuyKERDAU1l9z
    4m8aCxJk/NN2LBIYeXoTj2qDUHfxYvQjsDtKMtIC0zL0Z+lDShMse+SFblFoThbH
    3WCvL1/zFY5ighgSGZnyuuCTJtDi2sV7W5YFo5S1ZPvVPSASV9enr+ntrDSAp73K
    WyM9DzvzhcbEchA+I61KPaMekPLzoqoJTjI5ikZHRkIvrk7I5SYJcEi6k/zoigRc
    LUK7Qo7GYtEHEJ1B5XMalr1xDhpaOGEJCvVbKB/iXBNkjUN3oP6iP/g6cSTXX3EQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YeO6pZ57 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YeO6pZ57 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932705AbeCCW02 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:28 -0500
Received: from mail-bn3nam01on0098.outbound.protection.outlook.com ([104.47.33.98]:35904
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932667AbeCCW0Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Li Dongyang <dongyang.li@anu.edu.au>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 057/102] scsi: ses: don't ask for diagnostic
 pages repeatedly during probe
Thread-Topic: [PATCH AUTOSEL for 4.15 057/102] scsi: ses: don't ask for
 diagnostic pages repeatedly during probe
Thread-Index: AQHTsz5thyErdlOBk0+dpnzAdHUnGQ==
Date: Sat, 3 Mar 2018 22:24:42 +0000
Message-ID: <20180303222318.26006-57-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:U1ngt3gGhT+vUOgdTtVY4FmkUDFj02L3M8w1wruYJUPHrc+cnHo/Qp9XozgZ8yExCNw6C9/f4KZ7QNAK+XsoeKoVPL3pDB5diow5NiUMHeKlmsJ10hiMrbob4Dyoi5xHuB7oH5O4yAGNB1xwVoBErl9LuDP9Lq3mU0BSi8dAKl24VbZTHQV6ZzpIxrWnMYt29ryEsSXGRHLdMt0LQK2ZkYs22pOaxV4FdHitkh+6NgGktQKuh5kpYCH3Czuke0cN
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 22e7d1b5-b5a4-4e60-c0e6-08d58155c72d
x-microsoft-antispam: UriScan:(43697045539745)(38994716169672)(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09708A2D6EA4C602AED57366FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(227479698468861)(43697045539745)(89211679590171)(38994716169672)(146099531331640)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(575784001)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(7736002)(8676002)(53936002)(72206003)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: vb816pMJLqt+yhUvCZ6M88X4MAglt4FIs5RrSbgCAzMZwJBA6qc9cVpVp/J2tSbrkXxXTwYW97Rm6DYF0vLAC+oclWIybvIMW1LsqdJhDxS3GBLvXt+UUX7hRVviNLzKi58bUOLkbgMJA1F/NIedkzCfKCtYo1DM8Kl/LQd9J3A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e7d1b5-b5a4-4e60-c0e6-08d58155c72d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:42.4784
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
