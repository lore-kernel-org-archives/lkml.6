Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119562-2-18201600377993544717
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
    t=1520119562; b=wrbcjXZy8aoYasiyKXC192DW9PgepJjfPifUK2btKSWaRSR
    26nxws/zuZntU5ZzsG/1uGUStggjaBMNHnxD5QwirrGbyGlEYWYF2oSkIxyavLMk
    l1k5X0ELNU3syqSaxNltv0sfloNbgJRqck9N7OYGUpNAOBlwbBnckSJlEymcovTt
    /ydmS8TtdVUnH31GOMk/SsisRy/DkIG1WcbxydmpNn5ITItcrVq3wA8iInUMY5Iz
    0YfKsECnjgkQyeYYYMoFDk6ip7H/OAEA/tNGYmQ5j5QjOXrq+j18LSSVPrGr4DXy
    vOVP3wHmxQcBsIIxqDSOZXLgK7Ez+RhQsC33Uxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119562; bh=OUb64i
    UfNRA/vkf+BQ/FEDEj6sQoHg+27uJReHlBNMU=; b=U+zlEB7q8TKYQXcmwngPJy
    6JPiQlOoxYvIrzInlKTbVyhpOppNgIgorKjcxO6piuMf7quDnVNc0WiXOVH3mJ+n
    pWjK28itkxD2m9NQKtoD3L5uNSOFiJXjDVSfFiHQgeRE1rom6VPvOj2fkG0TxldC
    VHKv8ROLMNeKbVCXROBkwNoLG+npE/k7p1iGblatcXn6tMGREdpzq6kMb9v0e6Zf
    66yR+fpPAApmT/y6cfhGyAq5KYj9QxoHtDhnlun9fHFpOkDjQPkVOy+lmV5yJXgq
    s6u9atZurO3zGpraGaQPSP/iF/ny0z0IoRqONoHNZGm5CZhdqaNG+G0PvIQTVEfw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=licfJevq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=licfJevq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbeCCXZ5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:25:57 -0500
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:4477
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934675AbeCCWhI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Li Dongyang <dongyang.li@anu.edu.au>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 196/219] scsi: ses: don't ask for diagnostic
 pages repeatedly during probe
Thread-Topic: [PATCH AUTOSEL for 4.9 196/219] scsi: ses: don't ask for
 diagnostic pages repeatedly during probe
Thread-Index: AQHTsz8kKJGgltkNo0SBt1aKjqR6pw==
Date: Sat, 3 Mar 2018 22:29:50 +0000
Message-ID: <20180303222716.26640-196-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:lK3O063I31c/nkYDXw8YCkZ6iHzhpOlwy6Ando3+63tueFOhLZY4GBoJltrvTIAPZ0PwRXGg7iGDVNmpueHlUqNCCD+jQaCiOJZARXamPn01gX4DCQp3iGCtSlQjq9GzjH/zdnwhUtcJj9L88Fz3XEwEvbCFjM64kg0XqQLVv7S5sCjF00xFb9f+nsfyvtb0SRUpIDpYVpzJU2LWDskXG05tOXiNzEah0VmhKwkzM/8CZ3K3I7VxvOk5brajI2UK
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe738f59-2218-47cc-6c88-08d5815741de
x-microsoft-antispam: UriScan:(43697045539745)(38994716169672)(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB0969B1EDEA44F2CA74B70BEAFBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(227479698468861)(43697045539745)(89211679590171)(38994716169672)(146099531331640)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(575784001)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: WgYQAvkxuSKtmmUWa4LY+wPPP2NRgaFETpML5gPA0HLQiY2YY2CQJ6TWv8fpU94jpqtPPyGWSKHJ8+gObqubv1RMW0HNEIRGfF9FeWSpYUUuTqpymwgd/KNVqkWHPP1+VWRCC7SbrsiTCocI/CXpTZdL+nc9cZpW2pYoB1QW0Nk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe738f59-2218-47cc-6c88-08d5815741de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:50.8226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
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
index f1cdf32d7514..69046d342bc5 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -578,13 +578,16 @@ static void ses_enclosure_data_process(struct enclosu=
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
@@ -615,7 +618,7 @@ static int ses_intf_add(struct device *cdev,
 		struct enclosure_device *prev =3D NULL;
=20
 		while ((edev =3D enclosure_find(&sdev->host->shost_gendev, prev)) !=3D N=
ULL) {
-			ses_match_to_enclosure(edev, sdev);
+			ses_match_to_enclosure(edev, sdev, 1);
 			prev =3D edev;
 		}
 		return -ENODEV;
@@ -727,7 +730,7 @@ static int ses_intf_add(struct device *cdev,
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
