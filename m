Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122576-2-11215222275186050223
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
    t=1520122575; b=dVKp5o1RRuT+p8k8S56QJ2UXmpeq1fG0PXYpHpO4A5Mu000
    vy2gb9944DR0g8K6XgChhJnO/xBeV2Rif7uftqUuIV/oaW3T6rie7oVlPTA3iYNM
    HMORq1Q3Axj/lRtVYWAJMuDvDkiRRYzUiUW8E3peygvAV35vLTdZT1OugmseLm5g
    VoGPTC6LhB+UU+82qQlBFOOw8Z9g90QhzbhKUMCY38cepQlg7k0xT/gJn1yoCcHJ
    8GpOdAoti+7dND5lHLCHNyxiLf/zFsGyEf4vGQU7FaJCf2n80vqgXe5yveb3z/Fa
    Q/p4qftWWtaD+xvE/JxKLxpS5R0bzsjPVjKI9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122575; bh=QoH4Jk
    kXXUQwqnnN2a4CggnVSWrt/xa+Nvblxvk2G2E=; b=pn4kI+L+muCjAbxBQHlSMM
    3UONaaFITXLvZ7pLH3OExB+ueSV+1szuJIvV3GKonOiNAbMSQzjaHpdSFZseqxsj
    SA05HNwv9Ey8U9FGrI88XQN7NIq9/eoHxoMqWnfAV5NaLBd4yTt3NKlL+CfFcESe
    hRAhHsgeCeDGAF++S+IAVhtM/oDa1UenXgxUMOWarXjUkANtBc25fw9orQhpfSos
    5+J7v3Dby3CGeTQRIF+XNXDF6SMORW0M1fZtWWxerVK9JwKQDcOrgU6iHG7SSVZo
    RLKHl8ja6sA44eYDMBoej40UuhtE53Mjog4SIE6AIp0vcWlQeEGRre+BeHcx9vUQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lYCbq23U x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lYCbq23U x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933390AbeCDAP5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:15:57 -0500
Received: from mail-bn3nam01on0135.outbound.protection.outlook.com ([104.47.33.135]:45024
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932729AbeCCWaP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Takahiro Yasui <takahiro.yasui@hds.com>,
        Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        SCSI ML <linux-scsi@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 59/84] scsi: devinfo: apply to HP XP the same
 flags as Hitachi VSP
Thread-Topic: [PATCH AUTOSEL for 4.14 59/84] scsi: devinfo: apply to HP XP the
 same flags as Hitachi VSP
Thread-Index: AQHTsz6vwWlhDqjIhEqQWyzbHTKkVg==
Date: Sat, 3 Mar 2018 22:26:34 +0000
Message-ID: <20180303222518.26271-59-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:ENHVGfZiXfSyhp/fKHPc/SGOVKtt3KlKI6Zmd5WO6vSRSRrnBifal41xatW/qRuNzhXEw2Bgv/c8RDA9c3hzYjZP/HBHeRHvUhM3wmVb+WaNuGQhCZ7FMK0FqvvdyvePNQLTeq8lXgopmfntgW1lZejcJ5A8SfdwdDsTblQjO4EN7322tMLQosTRtKjuW/w4hplZ6S3CZ03rSZf1gEb9s7Z51z9HS3FGLWDFUTYEbf7JciqBkfJpRtjhdYxZRT5k
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7e19eeb-4d16-4509-fee4-08d581565285
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106559AF7C995BB80AD222B0FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(104084551191319)(146099531331640)(216909439241126);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(39060400002)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(8666007)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 3xohcojXS77gdUsZkXOgsLOhgVZWMvM/TkqiuaLV6pSz0n2UDDaYC2rQg9d+ljc6MKXZMK3Cdr5lGy6rVE0PT8A5G83kWO+9hZ4JCDEjrPCy6SwbYPE50yEetMy7iZwPmjCqRvkzr6cZI86T2PvUgYPJ1p5SXciHDUPzgc/Nblw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e19eeb-4d16-4509-fee4-08d581565285
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:34.5723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xose Vazquez Perez <xose.vazquez@gmail.com>

[ Upstream commit b369a0471503130cfc74f9f62071db97f48948c3 ]

Commit 56f3d383f37b ("scsi: scsi_devinfo: Add TRY_VPD_PAGES to HITACHI
OPEN-V blacklist entry") modified some Hitachi entries:

    HITACHI is always supporting VPD pages, even though it's claiming to
    support SCSI Revision 3 only.

The same should have been done also for HP-rebranded.

[mkp: checkpatch and tweaked commit message]

Cc: Hannes Reinecke <hare@suse.de>
Cc: Takahiro Yasui <takahiro.yasui@hds.com>
Cc: Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
Cc: SCSI ML <linux-scsi@vger.kernel.org>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/scsi_devinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index 42f0a1a6f689..cfc095f45e26 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -181,7 +181,7 @@ static struct {
 	{"HITACHI", "6586-", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"HITACHI", "6588-", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"HP", "A6189A", NULL, BLIST_SPARSELUN | BLIST_LARGELUN},	/* HP VA7400 */
-	{"HP", "OPEN-", "*", BLIST_REPORTLUN2}, /* HP XP Arrays */
+	{"HP", "OPEN-", "*", BLIST_REPORTLUN2 | BLIST_TRY_VPD_PAGES}, /* HP XP Ar=
rays */
 	{"HP", "NetRAID-4M", NULL, BLIST_FORCELUN},
 	{"HP", "HSV100", NULL, BLIST_REPORTLUN2 | BLIST_NOSTARTONADD},
 	{"HP", "C1557A", NULL, BLIST_FORCELUN},
--=20
2.14.1
