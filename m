Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234862-2-5606936142396171425
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234861; b=dQehrtFMGYo1spcp/HEKEf1EqTvj2ic1blXcYkzRUzzadgautp
    cy/3EszSYB9YxQZP5L9m1HZxeX5HkZL1vtJyGkMNYlDHWfn6veAiQ02SJcB4ZnX4
    epSEFNZTNGEqPVR4h16UkR/mSAkzIfw/wMyA1O5vE6Cf5LnC/eJjCuuqv23IezC1
    f7EfrKkgWEa43hp0J/deeC+k4HdhLAy4t+YU5p3ovteEblQEnr1XW4ARMkLvOwkB
    +y+tiiG7bQDkXRM3PKYCEtnmdawM7x9yLgGPTatp1Xox5ir8DGliC33S/jLGTu5h
    ZnhLpFQyrnn7STlqIEAtU/Wb853V6AEgOm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234861; bh=rCvO1m3qAJ
    Spv+AFaGJ1gBENKMzNiV9jj2F26KIYoiA=; b=HzJGYyAozfUg9BgPrRRLQruxkK
    lHttTshPQLPfHiOzWsc9CwGK7KiOXav/MikOuJUtKMbYnU9jopitfj0xoKzg/Ct9
    jP35WYEsHdeCIWucVzDCjqFe7VM99Vde3FoVURl3QuvYp7us7Pbgzb+aitkGMetl
    p4w4Pr/dMMxLBlVBgc/03JPyWCbujSHWnDEI5yjdOKqD2GCZTF6DQct5GAtNrooG
    bY6gpJADFEd6GEF/SqOKXfOi/DdMl99lSTWovatE81r47D498KQ2+0+qUCGNUWTo
    WF0ao/JgMTJwlsSeMOVg/GkT21ywnRQ1eQhKcX4G67JzMHaWB3phY/kbaykA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=K9tNoseF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=K9tNoseF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAIkMi61U1VGzlgqNx64dvaGNEBQCiMFk56mnZMzEVjmEvcicqOn25QOUtdd+FVD7MWiDMYanYtQKWejh5/JJYYBfAYwLm/QQ0eX1zT4mHwe8PeDu/pY
    n+W23xyMV60ME6MBjN4jpjbVKmZeDzwDZFGRyc/vrER6wS4R/ZJL6932SqmWvKuH4WOZHA1ZUyegMmj75FlXN2yPaU+XDfuPgqaXTQElsRPza/TG3FJLUv2w
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=o16p6HLoKsIpmb_BW1oA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756714AbeDIAmI (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:42:08 -0400
Received: from mail-sn1nam02on0109.outbound.protection.outlook.com ([104.47.36.109]:10733
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756501AbeDIAln (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        SCSI ML <linux-scsi@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 077/101] scsi: devinfo: fix format of the
 device list
Thread-Topic: [PATCH AUTOSEL for 3.18 077/101] scsi: devinfo: fix format of
 the device list
Thread-Index: AQHTz5uEkHPL8UBDU0qBE3mw8JqcJA==
Date: Mon, 9 Apr 2018 00:41:36 +0000
Message-ID: <20180409004042.164920-27-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:vKS79GitwwaiIfHX5wUHijKML92eAzlqLrlXQ+5VZF3MzLIJZqbLqr12yH2lup7rlkJv7/0GN5vd7ZLx4CFTrQb3kgpguP/6RmED54FuCBB+wlq8MIAc9DqFFns2RwukZXqzaIsfK5BJAKNoScnoBWVnlZnIqnMIeIxTBUS3ShG9tkbipSgzzarfl7nZER052FUcsnZghsJDVhCns4IlOk8kd3IhLIFs0uWUIDzH3kiP3dIqo71BQcWBYqHyYaoM;20:3LvpTIrCbgHmtT4rEEg1WgZ7c3d/YVNeVyeDRGhbFerHZSkHQMIvJwMkuzgEq6YCB/s7sCQMkLsi95LTdgqWm+8EN3pP2T+eLHA+65cuGiUGlxSu61sMEFJDN2bBEgqypqFTFldwAmXYpR0DQhf3d8iNNLeLXjQ0UIxAWp7lmOw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48b8f0ee-04e1-4205-176e-08d59db2a7ed
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062AAE8B716C11EB2BB5E8BFBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(54906003)(5660300001)(110136005)(102836004)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(6116002)(575784001)(3846002)(305945005)(86362001)(39060400002)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: O5wA3UcIdxUVv6DB8Nn86Ten7sLPCNjz3ZVrEGi1XGjf2fgHI/MMPnJffwwWSQID//dgczA7pZL+fMRswWRZLnyJS7NDuBlyUvSDM3OF+1ZEopGg3C1al+fJvb3xgGGqzj39O3eZ+0EysPPDFqTh8/7bQQ1LTmERAGPmPqcFwP5BjiKgj3wOIPcAmbSiKc1mTyBU4kvYaIrlLAMiQjyhnugaszaDiyze6msKn8FfFGlI7N3NGPiDMQj4mxU9+6cJNLywWQWydHhHRg+l1X+f4f0QVtIw2HhrX6j+RCW8dITwuiIhP+ihbnmmoZQUe/2EZYVxntHduSNLn2BDRU/GzgYX1qufbj2haJ8PzUkOUUrW9HNKbtnJq6o6p5SLndj0cFztpBFFKnHrUiFKzvT4QxT5joDOGBlj5dKG5JVk+30=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b8f0ee-04e1-4205-176e-08d59db2a7ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:36.7209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xose Vazquez Perez <xose.vazquez@gmail.com>

[ Upstream commit 3f884a0a8bdf28cfd1e9987d54d83350096cdd46 ]

Replace "" with NULL for product revision level, and merge TEXEL
duplicate entries.

Cc: Hannes Reinecke <hare@suse.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
Cc: SCSI ML <linux-scsi@vger.kernel.org>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/scsi_devinfo.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index 90abf7f5289d..2f994edce4c4 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -108,8 +108,8 @@ static struct {
 	 * seagate controller, which causes SCSI code to reset bus.
 	 */
 	{"HP", "C1750A", "3226", BLIST_NOLUN},		/* scanjet iic */
-	{"HP", "C1790A", "", BLIST_NOLUN},		/* scanjet iip */
-	{"HP", "C2500A", "", BLIST_NOLUN},		/* scanjet iicx */
+	{"HP", "C1790A", NULL, BLIST_NOLUN},		/* scanjet iip */
+	{"HP", "C2500A", NULL, BLIST_NOLUN},		/* scanjet iicx */
 	{"MEDIAVIS", "CDR-H93MV", "1.31", BLIST_NOLUN},	/* locks up */
 	{"MICROTEK", "ScanMaker II", "5.61", BLIST_NOLUN},	/* responds to all lun=
 */
 	{"MITSUMI", "CD-R CR-2201CS", "6119", BLIST_NOLUN},	/* locks up */
@@ -119,7 +119,7 @@ static struct {
 	{"QUANTUM", "FIREBALL ST4.3S", "0F0C", BLIST_NOLUN},	/* locks up */
 	{"RELISYS", "Scorpio", NULL, BLIST_NOLUN},	/* responds to all lun */
 	{"SANKYO", "CP525", "6.64", BLIST_NOLUN},	/* causes failed REQ SENSE, ext=
ra reset */
-	{"TEXEL", "CD-ROM", "1.06", BLIST_NOLUN},
+	{"TEXEL", "CD-ROM", "1.06", BLIST_NOLUN | BLIST_BORKEN},
 	{"transtec", "T5008", "0001", BLIST_NOREPORTLUN },
 	{"YAMAHA", "CDR100", "1.00", BLIST_NOLUN},	/* locks up */
 	{"YAMAHA", "CDR102", "1.00", BLIST_NOLUN},	/* locks up */
@@ -248,7 +248,6 @@ static struct {
 	{"ST650211", "CF", NULL, BLIST_RETRY_HWERROR},
 	{"SUN", "T300", "*", BLIST_SPARSELUN},
 	{"SUN", "T4", "*", BLIST_SPARSELUN},
-	{"TEXEL", "CD-ROM", "1.06", BLIST_BORKEN},
 	{"Tornado-", "F4", "*", BLIST_NOREPORTLUN},
 	{"TOSHIBA", "CDROM", NULL, BLIST_ISROM},
 	{"TOSHIBA", "CD-ROM", NULL, BLIST_ISROM},
--=20
2.15.1
