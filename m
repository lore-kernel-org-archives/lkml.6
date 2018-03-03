Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118042-2-9524161923516935242
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
    t=1520118042; b=P5wwwe1kMq83z4UOP8zJHBvhIkpeduhcszXqM+EwJ9A6ZNm
    9sj8AKLOPYghm5GHYP8qo1pvKIdZ8ahdPo713V1fOEG5NvBoGirk0bm4QrcTZOeq
    1E6ZYv32VrGp0hWZ/ZE3vDl6Z446ujrX6+UWGka0/gPvomVsHNa/QpMdyvt5u3zY
    WffTwPrEF2bq4plCv+lB0ziIU5yebhxHAULLU3SxvJPuXtAMiuCSkfHHIlkJaZu/
    0UvXMt7OPPNy11StepJkN6E6RM0Wbcy/w4WVhn+vcK0GDQGwseb5glCsURD3X0H+
    yh5RB9PB+bwQ8UXhJpNle9yqOfFdB8zd0fUVn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118042; bh=I6WcGE
    mReQP4/PCZtOmL/GjUPUParDVdsOXyb6h7lwo=; b=hd6cbGGGiZ+h7/kLXZ8o3B
    4KtaAoMDPze3LvA1xk/1kiuLXqFj4t9E16smjpp56L7+7MKo5R+2/8EZlL50dETi
    yU9TL8U/gJk+G9/1bt2PLTT3fNv5yapjcYTHt0DC9PAj6pmsMsopkZDJSW+d5ngv
    +tExOCSQc4iPdg7m2k2DlsMvcjQ5prKGGmilqQV9XZKO2PBkPmQEEGfC0+eCDE1q
    TG3weisrIEESIM4ItVeGRqecmH9xNRX5n5jom3hH6qnmxGfeVnpG1XQ9O6oT69rv
    58deV7Ey/gFbmD8C1B9TomU1NYCiWUOY33n56zhgACnr1fT9aGVIvsQrLMbhwQbQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fVtN0M5l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fVtN0M5l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934497AbeCCXAW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:00:22 -0500
Received: from mail-cys01nam02on0110.outbound.protection.outlook.com ([104.47.37.110]:31968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935201AbeCCWkw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:52 -0500
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
Subject: [PATCH AUTOSEL for 4.4 104/115] scsi: devinfo: apply to HP XP the
 same flags as Hitachi VSP
Thread-Topic: [PATCH AUTOSEL for 4.4 104/115] scsi: devinfo: apply to HP XP
 the same flags as Hitachi VSP
Thread-Index: AQHTsz9sFoIMPgOVckCROF0k7MEbkw==
Date: Sat, 3 Mar 2018 22:31:51 +0000
Message-ID: <20180303223010.27106-104-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;7:sqfXNtManGs4z6e9tAXjhbBwO3NW2oTcJx4Npdi5FExCf4ERZntvTk28Bj5FDl/QneSPqxnGQSBZR3nIhFJ1A9lNSva2yu5ctkxZ58AncUbVSNTQVnb1jpY9Nh0OFxFdbn5pbmbemu3UczT2W8XsvoiFbkdA5YxWSRqBrmOg1cFwBkX5lNoAK12TmIId5Lv+Y/fmtdlariXAyB1VimVJC3Z2uXEoL8ebFMM2c1B65o/n0enBjIFajNs+Nwh22d4E
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6691b3c6-2102-488a-a4fd-08d58157cf94
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB34477897334E2DE2B2124F5FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(104084551191319)(146099531331640)(216909439241126);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(59450400001)(8676002)(5660300001)(5250100002)(2501003)(6506007)(7736002)(36756003)(25786009)(3846002)(6116002)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(39060400002)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(6666003)(8666007)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: z14D+FgSqsbULNCijxUwH2LNImTt4HdxPZKMDUtzppZ5BFbAxJl/Gxex65ZqKzyEeJrZCPiSZ2pVdVbWQnG1h3f4nqBvKlEKlhVM2/GxBGbi1zIaDy1Te+anpX/vUK6uOJ7+Ksx/pqWkH0tEITEaafAdsozFrEJ7nz0eD+IzncM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6691b3c6-2102-488a-a4fd-08d58157cf94
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:51.5583
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
index 74126b8591c8..6b61b09b3226 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -180,7 +180,7 @@ static struct {
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
