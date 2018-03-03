Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118008-2-9005374997952017568
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118007; b=bOM8dNmSiLrdpROVedZPCtBVNwCUTfP/rFBupFBwJESS5tf
    7pWMAnqL6KPASzebv2FLVQidqc0NjncM0Iwd5/7E+J/zuYxYmeHauepkmUxH3zeZ
    DVH3mv0kyzYk0kGdqzJARyvq0hYfmR25TccLaA6tN66cHlVxgXqfmC3mKuEaGqhP
    AHJHNIgF6BKH6dlWNgTridm+WZIlETvbye4LgaXnvMSGSOtDnLs3KMW4ujl+O/Kd
    mNn4peK5qN/emwaD236PrwcJDwIj5DIxlKdI1lLDUzJYF7Ey9Ml38z2Ciqs30vCw
    ZsTHDCBr5zcjuaxjaaJJZSqF9rl9SbIn6J1MTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118007; bh=I6zliU
    66Pcjh9JDpgmwvRI9IQp9FV5BpC04c6NkH1eg=; b=fZST5+jvhBJ5HN8TguRG++
    rsC48lGJym08q9uAprhQ9vr0hFdd4M1RXBWmBuGSmrDe4vWlQ1oLHKSNbNz4sgQA
    BTpsd/eFZTpjiRYaUqQ5zCZh3O+qquaWDoNlNjdW3SS8Qr3IY+0X27Np/B0MTGtO
    2lbi8ib7o/2Vjv82JvoEXu10bSx65YfppKUorcgTa3QJEUbljT8xnaZah/wG0m3A
    ZgQx/MsJq8xYeCPCgR8u10XjHD1yeMIuAyc8q8PwnApkp5nAm1X9dE7C7WEwGq5G
    NtN3jSbNZAUB50DDong9LLPQeG3brjVu+MYOUUrrtVhKwR9L/IAtUJAtEudVrqEg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cEX5dYQH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cEX5dYQH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935346AbeCCW7M (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:59:12 -0500
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:30112
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934888AbeCCWkx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xose Vazquez Perez <xose.vazquez@gmail.com>,
        NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>,
        Hannes Reinecke <hare@suse.de>,
        Christophe Varoqui <christophe.varoqui@opensvc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        SCSI ML <linux-scsi@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 105/115] scsi: dh: add new rdac devices
Thread-Topic: [PATCH AUTOSEL for 4.4 105/115] scsi: dh: add new rdac devices
Thread-Index: AQHTsz9tmvdnmQx3eEO+Kk3uLSGBOw==
Date: Sat, 3 Mar 2018 22:31:52 +0000
Message-ID: <20180303223010.27106-105-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;7:Nzb8FoONrS6huc4sI0i32TqrlexPRhnqCE+tJtkizgey6SlKhivz3YDydtTtoLiO108ybui38kPfqicAzl77IRz5p3xx/geJffmPBuKq697ASlF3uhvfWDNt/gRW6MFjsbkauSmk/tSe8lJfuk0Skneln7qY+mSih5el4f3+3RI+U1rosawP7bYdWBXDXpuMo3Lr2w4cakQQkQuVVFaP13KKePR268McmFqAQ9EWjdowIkmzRukFIkpEiqSNtB/I
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96653e3e-6a98-4382-52c2-08d58157cfe3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB3445837C7052AB4BFA695E5FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(59450400001)(8676002)(5660300001)(5250100002)(2501003)(6506007)(7736002)(7416002)(36756003)(25786009)(3846002)(6116002)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(39060400002)(6486002)(53936002)(107886003)(114624004)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(6666003)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Z1rB5UcKzWiTgpHKMSwG6foU5DReHPxF663ExgSH9oo7DsAqUTm2iBMx4F+Lxb5fppRZ5ecjWQ6CYjBPtyQmsJ1hKSq7RNLqL7YX4CJNyyAz1P0jYW4590nyD0nAkr9T1YP7B2PyWUercUNiVUXwtJKNWpNUYp+7Ci4s9PkoJn0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96653e3e-6a98-4382-52c2-08d58157cfe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:52.2614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xose Vazquez Perez <xose.vazquez@gmail.com>

[ Upstream commit 4b3aec2bbbce1c35f50e7475a9fd78d24b9ea4ea ]

Add IBM 3542 and 3552, arrays: FAStT200 and FAStT500.

Add full STK OPENstorage family, arrays: 9176, D173, D178, D210, D220,
D240 and D280.

Add STK BladeCtlr family, arrays: B210, B220, B240 and B280.

These changes were done in multipath-tools time ago.

Cc: NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
Cc: SCSI ML <linux-scsi@vger.kernel.org>
Cc: device-mapper development <dm-devel@redhat.com>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/scsi_dh.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_dh.c b/drivers/scsi/scsi_dh.c
index 4d655b568269..5711d58f9e81 100644
--- a/drivers/scsi/scsi_dh.c
+++ b/drivers/scsi/scsi_dh.c
@@ -56,10 +56,13 @@ static const struct scsi_dh_blist scsi_dh_blist[] =3D {
 	{"IBM", "1815",			"rdac", },
 	{"IBM", "1818",			"rdac", },
 	{"IBM", "3526",			"rdac", },
+	{"IBM", "3542",			"rdac", },
+	{"IBM", "3552",			"rdac", },
 	{"SGI", "TP9",			"rdac", },
 	{"SGI", "IS",			"rdac", },
-	{"STK", "OPENstorage D280",	"rdac", },
+	{"STK", "OPENstorage",		"rdac", },
 	{"STK", "FLEXLINE 380",		"rdac", },
+	{"STK", "BladeCtlr",		"rdac", },
 	{"SUN", "CSM",			"rdac", },
 	{"SUN", "LCSM100",		"rdac", },
 	{"SUN", "STK6580_6780",		"rdac", },
--=20
2.14.1
