Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238776-2-17292536112672000693
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
    1523238774; b=g1eXryBkIPh0dvUnl+COW/0nlOJ7YRqhZlIEPGY00pThRJ8fj5
    xaaBequ/iakx5OhUm6FPsoB1RAv5PjmvokqBE96L0ZEPxdC+aJQ2YwfOot/gVueH
    tOxSJTBirnEtH1YhtJmxY2JRPm0XKNRgAIZMPmDz2qtjOoazhEUGqr/N30zFTs8V
    v+cHk4f+dCLFBJz/9TLrBet9s/otA/t+xal+wPZS2zX3/7EwU4QIo7hBDY6vqMWL
    0BuWBrkovTTO9WCQORDGLuUdZv/E4kZxp9piiad5vxnWJGrqYDO9W3+iyxBwYmf7
    +Aymnnvk61cLAiLY8cWiHy+le4o6+ifDGLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238774; bh=Mep3g3xxda
    GfQBeh1mQ0pcOWzgctoFnADIrFA5C3CGI=; b=X11zGPK5gwnzfyrcBPw0zGLYLB
    H6FruSFVVrdja6v/H1AqnNHopD7DUv3OYfypcFXOZMYKtanquMn/eLrOaaZkqexS
    H4rDqkj9nFdKH1P50brjrL1MHG4Sb8U/vNn7WgiFEXlQOcwuXO94PDZ/2rqt49j7
    yybinxYaP/piUa7EoY/DR8AXHiXZQ0rz4N+S9ImfiWSipZpArjGqbmY1fZXq2gcd
    NPf3N0/uZqQUbWOaP+G1Og7S7iRAJI07u2rOH8fcSKAX2ZFAJgL66MUdLtwd8nKj
    itr5tCrDzIfwE2XRVsl37wz2G+i7lKSeoQxCgwu/99YjSI2qIQNPOfgiV9PA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ngdAemuM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ngdAemuM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBk+Xu/dv1Rtjz1rxqe0TpXPMkgRDE3Da9MFmZasOjhCRVbIrgMYrETPVG73iTQk5UgBta3xGv6uL3M7Ln/Woab9BTnjtRoPSgtParpBFZzgZuwt4cKH
    9xsqFtrKAM90hTptCaBn/QSSLrPjwri5N8voWCaoAySWyxoPFn+nsn+QYMqk+3PvOR/VnP7bEJgj1tBylkPFopW96LTpWXcUMRMcJx8S+363IwjJy/oJpKaR
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=o16p6HLoKsIpmb_BW1oA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932521AbeDIBw3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:52:29 -0400
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:45024
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932287AbeDIAdp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        SCSI ML <linux-scsi@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 241/293] scsi: devinfo: fix format of the
 device list
Thread-Topic: [PATCH AUTOSEL for 4.9 241/293] scsi: devinfo: fix format of the
 device list
Thread-Index: AQHTz5lW4TfS1fi3Rk6tZPiS8KFLKw==
Date: Mon, 9 Apr 2018 00:26:00 +0000
Message-ID: <20180409002239.163177-241-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:juUHmCBwIW6lgnnbUcR2ccrPOjhboLwwJco4lkH/JTOupleZL6gsJw2NgtU8cgBHdi9VWOUGeR8pwJgyA7dwvABG7RTReLDZk8BMrI33qekqLlh3LtdycPglt09Gt3C/+W7qJxx7yP1BVq8PT5Df5k+7ZC4Y3/WdhhXrEY9C5s+f8QpJguJwFYIUOydO/9K2NrTB6GMrKqoAAUrROL1Y87kx9tunsCeHSk4v5kZ1gvPLxZbnkJ5JirdJmKmIzsYQ;20:h2neBKMqQVpyiAbXSBkQW9+9Y2/DDfUZ/9CdYVx5fZ/J8m72cl3+/C5aWc5Eq3JlXXEiyYVdKPtnYQevsLX1mG4bwSpxza2tTs6dRUh8D4/QKbdHG7A4rlbrMpoxLRuRJ6YrmqmZr0f0biFDu3s6f6SKXLMFBQuAaep30o7yofE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3cdb755d-9886-4a4a-2330-08d59db18b2c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998E39F7B254F6AB12A5113FBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(39060400002)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(1076002)(6436002)(53936002)(106356001)(575784001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: bCs4AF52ITrsb6vZLe0Q2pDo8MdmQIntBy+r5YHX1bIgcikkXQl09maDIEY/es6Y15GjMGWSeo008YUmnQjB6htFLqPM1zJXXvCHiT2Xwxae57PWYlA+ALN0fXZ3dH3YOomvpuKiEVr7hFSRKduHhOcSi/ONsZCMtRoT3P4zz9wU3gX3Gup58rmPygOajsni1lf0zjqUMT+9njuQ9xUFs6r9RVtnUsKK3hnZC2ofeN07J6uFWS2KZp3jdu3dYa6eIEAQfaPmvs9wxt020uZt//rn5G/yBpp+XR286DE3EqVZkHeeMFK4fOPnU4u33BXgd3MQL9zdM/DclAiaL1wTjDLJ94lHbkjNAeH1P+TkorE2MEDd9DJaAhhnjOVtIMTwbdmK+kNnccWSrLW8Ik7XSS8bRABrN2NUWkwlmtUvUjM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdb755d-9886-4a4a-2330-08d59db18b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:00.9880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
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
index 43d4b30cbf65..498d2514cb59 100644
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
@@ -256,7 +256,6 @@ static struct {
 	{"ST650211", "CF", NULL, BLIST_RETRY_HWERROR},
 	{"SUN", "T300", "*", BLIST_SPARSELUN},
 	{"SUN", "T4", "*", BLIST_SPARSELUN},
-	{"TEXEL", "CD-ROM", "1.06", BLIST_BORKEN},
 	{"Tornado-", "F4", "*", BLIST_NOREPORTLUN},
 	{"TOSHIBA", "CDROM", NULL, BLIST_ISROM},
 	{"TOSHIBA", "CD-ROM", NULL, BLIST_ISROM},
--=20
2.15.1
