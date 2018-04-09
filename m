Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236371-2-14219272045597544149
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
    1523236370; b=bjUKzjZBAnKMF9n7wPy4ZR7cXVOi1WCu+g8aMklCLYwcSMzEKY
    l6ha7ewVhTOsJUOrFG+aR86x38Tb4mpp+8PoYOVK+lCMbVzyYPK0P+q1+RigqvVD
    vmVECIrmD7rDPPs0lmx7ZwSkJnrATY0Glf/0kSIQcGsTJBfMu0xLdn+1fTvHqUyy
    FffjZGCcwOnufUzH4Emd1JHI+eCCBwvUE8aFn8fzYN8XxQE87Y6TBRu3oawxLQSr
    RyisnIBFIRQvtVKgbSJMf4FD3GxiBQ/NpnZu3LnnjiTdIOAoxC5saYhX8KQkeNWS
    91FpXj0qCtHctaExbzxHRJ1GCc/Fbkf5+zhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236370; bh=fwkQt7gMO+
    wHLUWkbUt0pfk4+osfqkXPXrC7eH6uZ9A=; b=u/X8wS2mKNM9GxC0TmCf/Qm8UV
    AsmAVi3cxwgyyBcXgCJkWnJ64wQ52slZoDlU7uqhXN1US+Ni2JjsaBMOapWF4cYy
    r2XqZ9uIVJY2z/+cmvDCBzcEHsiSy6JB+r3j6XtC56MfMNdrX6W3mYViNBZOFiWN
    LWX48t7/7UIJZ10e2gV3pB91sEKU4/5x1kKBPZVP5WpthubGeLw3oYM0RDW76iGo
    O3RDnP5N+NNdTi30VpIQI0f4Ein9DbFcXSvXMKvAVJ7+d12rXEeHURSYPPJYWGbO
    lEgR17C4JvUZANNAjzIM4psDVWIZoeVCi9kUgsoE5o1Zdu/lAg51pbaZknKg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cpflSShy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cpflSShy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBe2FgEAXdCx0FOS00nvFIZEPqhYpcS9Kgy6mtIck2iO+BL4FvFe5fDFnFRLf7emDoHkCmtd6vVKuRPgYIz+d2yNJUZZ5gKbQDm98w00S/LRlgvPL5aw
    cx01K6MdBoXZ+0NoSx86OwYXQB3Fxt9ScZATbaFxscubNHyUNRZR4wE+9CrkdJC6OkTwhLMn1sMZttlWB8lrFcks54lslsYYutU/c1LyiQ95YKu6AVdLw1zE
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=o16p6HLoKsIpmb_BW1oA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756177AbeDIBMi (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:12:38 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932974AbeDIAik (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        SCSI ML <linux-scsi@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 128/162] scsi: devinfo: fix format of the
 device list
Thread-Topic: [PATCH AUTOSEL for 4.4 128/162] scsi: devinfo: fix format of the
 device list
Thread-Index: AQHTz5nPspP86gjFdkOa+ZxAvBcNdA==
Date: Mon, 9 Apr 2018 00:29:25 +0000
Message-ID: <20180409002738.163941-128-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:SuQ95wc+MlvL1P0sk9pQM7Bo+aj0ddat5lHXgtQ0FlKdQz+nEOjqHa0opGRf+dKvOBlcJ/o7efpE8+Okr4x8NpJMJVbAdZT16huR16to2u2GuuUfx6xu99yo+uF5ETrIPqrEhymHDFXKhHNDnJ+Q1Eyw8hI1leDefYqyo+TguINKn5QGfbovDASCiEcNyE3WY4s4lGq0B8KyJYmK97WeccnzcfAznR4INgjci+py4B42W2IPJ33NKnbJy5LeI5Vb;20:pXofaoYnz1RSV7FTIdAajEzUXO84MG6z5ZQ1ptvuTYXxSGn+MmCH3/KfLKunObujTd7fKhtGo5qxwnldNxtXUF9Xu2zMZLfjuaiWSsyAOgTzV98OH56tTLS91saXvOC8vOUBSS1r03KgV5pc+7u9deEWjNuCVUSlmWn6j0XqTpc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e399fbeb-cd20-467c-8a0c-08d59db23a32
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095A0CF0F506A76E6F8F3F5FBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(39060400002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(575784001)(36756003)(6666003)(6506007)(8676002)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: vTfOSVdJRrqCJQK6z2MQPDysj2afIZxRfDsmw8vnFOs1fqSqe+IB1fc0p1DHMkQ7vXjy6AiH1L7usArV5M/4FfUERS7sM95KTZFvmxZeKuEwjdeSHaWqsXvGeqa1I67bopKCnOZJpbGrXICVeBHxBcIAWdkgUhhpyn9QzgNaDTAHXmjeLFEA9Ln9zAUjMsfRh8KEprPwjr5uWZX0MfjFZkFRrFKiR0iC+ezvUbbq4Sr8glltvk5ahumtZ9o10s60uNsB7JxoT2XU/UuEfUOgh9UvIJ8jwnn5luR2L+X+xEw3Z4Irb3wbLNE1FYn1tnxIk9U+K+LnfuM568n41eAtnZUVSBQZtpVNETXLPlZuW8WThBH8jnVGfMXMiTfrY4sJ73FPfoEGAz9G9DkFD+B6xExV3Ygo1zndrWducDeIeGQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e399fbeb-cd20-467c-8a0c-08d59db23a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:25.0837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
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
index 6b61b09b3226..9a25e798e195 100644
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
@@ -249,7 +249,6 @@ static struct {
 	{"ST650211", "CF", NULL, BLIST_RETRY_HWERROR},
 	{"SUN", "T300", "*", BLIST_SPARSELUN},
 	{"SUN", "T4", "*", BLIST_SPARSELUN},
-	{"TEXEL", "CD-ROM", "1.06", BLIST_BORKEN},
 	{"Tornado-", "F4", "*", BLIST_NOREPORTLUN},
 	{"TOSHIBA", "CDROM", NULL, BLIST_ISROM},
 	{"TOSHIBA", "CD-ROM", NULL, BLIST_ISROM},
--=20
2.15.1
