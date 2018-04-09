Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246326-2-15170632682588496330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246326; b=XdWs5VxmlviTQPzTgy953Nzbdge54CQM9h41HjCwoVA+ELI+kC
    Kom8NYYT60ODtX17qVRvwbDf+2rl4vqEyQmpKswip1utCq/49k2gF14NoJwMKi+s
    w0vpk5ZgT/C9RJZMZ1qj6qCbMye1TO2zs486RRxy/D8Vb3sraTxqMqNaraD83DnY
    IT2DKybuaSCgBGCcK6IvSV+fGLPpWMv8EXUyiUB6M9jB3FUWU6rgdu4g8rkPhv9x
    LCcU1F218Ic6/MRA9IEhk7rKb4/ubaZiKLC0TLGR4Qcd4Ob2Oz1Nh5MoisyNYo6Y
    uUUyxCXlSQbVZAnc3GUD8utHFTfmb1ykWW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246326; bh=q6649q2ocr
    IkqcEh0/q5lQEmpFHYKFVV+2OMmOEjkP8=; b=ZfUG5zY8DVYziLfZRxlGsdBLmM
    u+NPSeBxGL+OuiDS1qrWiiuA6n2zwCPhgEREmUE7ko45KOl7YLPpJIM8fT+VIH91
    Yc3AbW13u9qJy3JnJD+f3OWjHNapMlPwwjt0AIEWv2amY15S6z9zjsYyEi8McrgK
    A9wel6sOdJP5Dm0NG45fTgmdSst/4UGlcf2KyOsTrVBIGKpzws3+h+7tjO51pJin
    LkTJWlrbE7jOYbPCnOfTX6EsI3v1wjBZlX9/oCC3/aQAvkGddqBrmiMaGpgz4wX/
    3joCm/jUntlUC4i33JaGeVGKKm3IxRuI9wFGiJts1Fp0Wl0IDJKwz/o9Nskw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FwrF/mF5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FwrF/mF5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNhtNk9H7wt6LKkkHEluSvr63Tcl7FtTxSbEaYGf+12JeUY38rnRVKFZGEpDbDNcYJw3kGlJahZ4WK3RJdvUsudMAo5e5WJzsPHV3O4oAgyJk5T0/52H
    +xiSWyz6GQoG53eOw70YP3SswkU5ejAHfnOarDw4R1qFTheJSc4RKNIRXcJsn/1350Dgiw7a4zHGkshKRvq/tOHqoODG9q775rIOLuCiErBXGUFAp3IUBPTH
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=o16p6HLoKsIpmb_BW1oA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeDID63 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:58:29 -0400
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:37278
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753654AbeDIASh (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        SCSI ML <linux-scsi@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 070/189] scsi: devinfo: fix format of the
 device list
Thread-Topic: [PATCH AUTOSEL for 4.15 070/189] scsi: devinfo: fix format of
 the device list
Thread-Index: AQHTz5grZLPlm9TW60mrAY4OBi/9Fw==
Date: Mon, 9 Apr 2018 00:17:40 +0000
Message-ID: <20180409001637.162453-70-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:OydMNQrEGQEE0JeKoD/7w8ehlPKHBN/5f9xFdv9MsJRtfmFk8dDfZMRQ2vphIoAXH+DPrcDqIbwlzDEr/2ZcawnjJgKHEjNuxbIkD9lOuiyLo1YJV1DwDo2xtEC20/oXg38FtucKrgr/AJqChaoGYkbxHdSUYcqcDQhfLLP7a/cV1rHCI3unS+0vK6Sc28omNoIVkEjxgc02x+g+WVtq+zV/iLezXk1X0UL4f6tYjS0SAC5ir3gnpfuP37sbOs0l;20:tGvr2nkKHJUkLp0A7ELalpxv9fYQpC3VliQ4+h1cEmqfTCIvl3G9BHVBiDRaa8yptzvCxlSPiRqnXDchPzHX4peRd8RpRf3Y5JvvLBDf/DZGGTaRqt6pSWQDVYUVmA7zUTjwkCBxLeRC+Cd4mPTUkrsj9fQDd1UZ90swflUABHo=
X-MS-Office365-Filtering-Correlation-Id: 374acc50-7b03-4ebc-947b-08d59daf6de1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10468B26E9A151E150A70413FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(575784001)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(39060400002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dqcIkg2MnpoWceoAgtJSFT6h6KwqretFI481VeMfm99KQll1Hn4kQ/RjCL6aANSxTQR3vJiLEcF61ueQ4RcKyq2fYksDJjYRonvKNiy25K9R2eQqYuuyDB1udMZV5wDlCOsP00sm2/fLdVL9C9BSb+DOTuTM/1FBiZUD6vJCtd0Cckd4BYb+pXnQ20NS2Srg0q49e3ofMIrcUYA98vit8OpdUVTP+MBk9gS9DrZDFZLqfS961PGkk6EDsvnealfCjRu+TqNoqSsjfH7O3r/p16xWPtHEDH53QYOr2/A+GT6RxDaNRO2NtJ595yknmGe2WBPaJt7nxNJplFP93olidSHLzBy2hpYTHY+wVGxl4XIqogqCxYEzKhy2ktg0EPFsdM3BPg9WkkxVLQtE2hzBOdAn3cRjewj/eW8gc+wcXNI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374acc50-7b03-4ebc-947b-08d59daf6de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:40.2741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
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
index 0a17b9e5dc35..6d976db33d9f 100644
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
@@ -255,7 +255,6 @@ static struct {
 	{"ST650211", "CF", NULL, BLIST_RETRY_HWERROR},
 	{"SUN", "T300", "*", BLIST_SPARSELUN},
 	{"SUN", "T4", "*", BLIST_SPARSELUN},
-	{"TEXEL", "CD-ROM", "1.06", BLIST_BORKEN},
 	{"Tornado-", "F4", "*", BLIST_NOREPORTLUN},
 	{"TOSHIBA", "CDROM", NULL, BLIST_ISROM},
 	{"TOSHIBA", "CD-ROM", NULL, BLIST_ISROM},
--=20
2.15.1
