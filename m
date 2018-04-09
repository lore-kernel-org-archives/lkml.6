Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243804-2-2540072679544941853
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
    1523243803; b=HAaQdsMJKnnspoRNRJgXMiRhzJZPUaZgtpaddLtmlBfilTpg3e
    GZ9M7tfBo7RoGDd98x1Mi6u/fcR2K3DeUK0OqskShZiTgpr1wuh53JuRKlKpFAYK
    DeHkT6L6SWYC+rrlCTFKA9W1CsDR27P1Y+dz44jJR+/kMO6iihm4RdlugUu0adI/
    xDE91lMdA56uNEGUSNb11Ikwea18yLuWBgaX1mCiM/WklWLASveXwYI/rciNA48t
    X9/JlBY5hSCSQQtElMnoRM4lyQMBjR9fd3dNwNVw6h6IEvs6dhxglokuX/M5wGS1
    k6Dm9r4pLE4sfIPQVU8qpb1ZO1ZC50X3LblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243803; bh=QsM6t5n9+n
    zohp+WvCbqEYOaWJIrOllX3bpZYAayO1M=; b=JrY5pZyg9cmdIkHLRg0+Ldk0sf
    MNxFNw5QUz4z5HPbl/KYpXO7GyoXZ56YUhykZxU8vsnzL8W/nUIeWHb5XMyScnnE
    WKH0sxmN34TiA9UY/Kabw14E1nfH+Nt8CEToW0Pa9PreIi5L3/S9L6Rzvh+sGX2W
    DTL3Pp0F0WHHoORl6Ve/EYV2ghpFvgcGiKI/kEXKJkB6LjO6cRHeWOpsBYmVGTza
    W6SaZFzc/ALOnG+DdhYWIOgYgyd/p2NDikJRfYv2MMaVtUc6Lx3uJYd6dV9P3Mtp
    3ubDhnM+7ZKYt9p5tUapX+Dj0vRivBdPhPtTE2jR2DSiADhSaPhJ51fmLnNg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UbQUQYV5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UbQUQYV5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKraBY50YwSxVbM7I6Xek5wYA2b97+P6KI3rY9ojeEqNQ86Be9BrBaKDfc50zfL1h7BZ9hKg+alwC/CtQMInohY+10k+biIx3M3qUq8Cph8aSuFwVYR9
    8MaVkkIcGfSAI8VNboQR/UnFkxokgYhAXt/VlRDi6aT/EIW7M5Hff71HP/5yZ4PivYcCSzKiyhsKCPLmJQTVyBb8qO00VZO9NbaQHvHQ3k6H3ojZSYWUoU7O
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=o16p6HLoKsIpmb_BW1oA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754883AbeDIAXh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:23:37 -0400
Received: from mail-by2nam03on0112.outbound.protection.outlook.com ([104.47.42.112]:27929
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754878AbeDIAXe (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        SCSI ML <linux-scsi@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 059/161] scsi: devinfo: fix format of the
 device list
Thread-Topic: [PATCH AUTOSEL for 4.14 059/161] scsi: devinfo: fix format of
 the device list
Thread-Index: AQHTz5iTh4WDEevyQEqVTzl2DsprZw==
Date: Mon, 9 Apr 2018 00:20:34 +0000
Message-ID: <20180409001936.162706-59-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:t9qpTws0GQhPpKgCtJQWMah9UQHNW4etY8p9a7SyAQQofvi3MQ94oDFldlK18Ickz5IyuVdLLhPkk/yyQDR/de/2dKb5NJ0MCCw8v61sq9R+ODTGLAOR/3dix7TiE0MsNnlcqUMBQ2cH+kmR8sh8Q8bIJKvzM8h5haSIB6sPv7eftWlJgHNNMTPFReclBO+a5h4NQzcHqlpfMdNUnZKy9WHR4kRXKzn5wvKtRP9Bb/88MOcm+jGRdYrFuK4BAA9V;20:k05h1OFEXBTnplBzvZh1+l6niHr/f2Pbkuu/+Y0orKw8f7oS4T65j1RmP9rrEHZLsTpuMgBNGqF2UtCaKjxCXMXm66XDgl91NGTZK7ktpLJtql2nyMEBMSLmpDGEcn2khEy+n4OBU7FNVTQb8qH31kfDdN0vgiSng8JwcKk03ds=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a5e6f56-6ee9-4ca9-12e4-08d59db020ad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080155AAC8A7B8F9BD12BB0FBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(39060400002)(476003)(3280700002)(2616005)(11346002)(4326008)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(575784001)(76176011)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: XigrapUni1QqkQlyVnqk/FzcunUR9XzERF1xyYLFHpwmDBSzb60+mOlYWsYTFpcS5TMs/PrPZl2xEZypgpkVnxLWNVwHmFfa9rqocMyF17uCbbvGapH/N2cY4qownfziiD7ifszc3zTLAh/90lMQ10+4FVHve1jWnxNOaNsQcKF5Ro8br3LZW5yjf6JhsRK8MdXVTZUXSzILeQsdH0/Sl/KuQmw9eBiOnYoeoemr23d6TQeLcqptstxxwWeUAEjm0o+3phQbiVdIjJsSkqae99XDLD2x1rLftWf4OlqsXtwPI//Yk63MDquWn08e9SA4WuE63U11fuA4TdMKr46wkVsdi8mfaWALvpdo2bCK4MqtwIPe5JJyL+BRCiofdJQW3esxOaNL0YI2xr2F71JB5txV2NHCKhDVv460Unty1J4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5e6f56-6ee9-4ca9-12e4-08d59db020ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:34.2692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
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
index cfc095f45e26..ea947a7c2596 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -109,8 +109,8 @@ static struct {
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
@@ -120,7 +120,7 @@ static struct {
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
