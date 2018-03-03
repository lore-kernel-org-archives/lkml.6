Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121527-5-15605347926392896189
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
    t=1520121527; b=NWrRt8ZVuzt3v3D/7srEkSdn9SP4VKxZu99pQBg7YKFT7xj
    GpeEjiAXldob9347bRstRxbQKUYaGgXYI6ZGqwBv/D2KEEdpI+Dk8WuH5q7YxbaK
    c55dJFg/cLVE7jhvNPEMfsAR+1KnPGmyyF68r9+BoXw0TJoiQBRT08iwW6LmkYrE
    eFyfZLZl7G3eto2EztMjNFbMDbbwgMUwSwJy9uqxec6D+j9oCeVK6rntiyEQhJ/F
    bmKSeQtsEX0FZTy9zphEsCDVkFzfhysLAEcC9NC0jt1maxT4OUmTdwHkqr2Qmtoe
    oc0Jgnn6wi4MfOVKG3OCHMj8jSdHqORvyT9nm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121527; bh=prFox4
    Cnuqe0guV2GGMjOkRAsSKCQvunPRkq0hO78X4=; b=VJJQyfOzo0/PhL5mHjLnB6
    AepPo+MpR8i2QbP+v1Sy2zqMsdmgXV/N57Q9JuOyMuiHCXMHJVqJMmnZ9rJii9Rv
    8On4b5aOYzLgVwAWGYJ1hmbRbcCOocoKDj1bQUa+OCFE+pc081DF40b8+fCJJUvF
    a84QPh3GOjUAhkicVdWAfec9JSmNi3Qu2s2vjlKQi3nwN++JYzLdA3oN7n+SpPqT
    AqBplArvZhFTF37Vzr8qlKi0j3fpBhn8mHY9Y+jEx5F6FOc0lLK48cA7f6KV+h+G
    7GDH8cP9Tqu9kTgY0sE9paAADSIsyw6qBfWR7j6tp0iOGHV7S51XUitBl4SLOjIA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k0XESZDP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k0XESZDP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeCCX6Q (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:58:16 -0500
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:54496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933821AbeCCWcX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 055/219] scsi: fnic: Fix for "Number of Active
 IOs" in fnicstats becoming negative
Thread-Topic: [PATCH AUTOSEL for 4.9 055/219] scsi: fnic: Fix for "Number of
 Active IOs" in fnicstats becoming negative
Thread-Index: AQHTsz7zlVNh2T8eMk6hN6s0pBNcWA==
Date: Sat, 3 Mar 2018 22:28:28 +0000
Message-ID: <20180303222716.26640-55-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;7:AQODEIK9rd9nCQZYRr66s4pMbSgbmacgSuxUOdKh3BdEyUbjhULWZhwdsIrTWKNiqw3xrYRONW5C8yoWUKYrebsJqudfVRbEzj4uPoh5HB1SBn5HcTcWo/L//9RsntGPly8iuWW8gDGtCPCk+Ps2Sv08a42ufPlXR77fOW2E3beZqQhafeMmvLQ/rBEI803gl8tsn7NN334cptNh8gIA33YqTvIXRTybJlRAi2pgPbHLZTaqxoqzLr5Tc2OsO0n9
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0417b733-3266-44a2-8f16-08d581569dec
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB103665C13F7CE7638417336CFBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 74pyB9/x8w/eLz5u7ZZN2b6yRuDG70dpTgch429gENXQiJS/iJOMeHqUHAlXV9JWiiKsd+yKTn3WeDE3dTyRqLKQCRs7k/wH/y3uvNnf4A0s6kSaMfqv0foP+F+6n3WlCHZyDJKjeVFKKWqdn2d5iRuqVl/nxSoEO9IL9SSTmIU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0417b733-3266-44a2-8f16-08d581569dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:28.2756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Satish Kharat <satishkh@cisco.com>

[ Upstream commit 7ef539c88d7d394410d547c9f082d477093a2a22 ]

Fixing the IO stats update (Active IOs and IO completion) to prevent
"Number of Active IOs" from becoming negative in the fnistats output.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/fnic/fnic_scsi.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 44dd372aa7d3..c056b8111ad2 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -1127,12 +1127,6 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic=
 *fnic,
 		else
 			CMD_ABTS_STATUS(sc) =3D hdr_status;
=20
-		atomic64_dec(&fnic_stats->io_stats.active_ios);
-		if (atomic64_read(&fnic->io_cmpl_skip))
-			atomic64_dec(&fnic->io_cmpl_skip);
-		else
-			atomic64_inc(&fnic_stats->io_stats.io_completions);
-
 		if (!(CMD_FLAGS(sc) & (FNIC_IO_ABORTED | FNIC_IO_DONE)))
 			atomic64_inc(&misc_stats->no_icmnd_itmf_cmpls);
=20
@@ -1173,6 +1167,11 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic=
 *fnic,
 					(((u64)CMD_FLAGS(sc) << 32) |
 					CMD_STATE(sc)));
 				sc->scsi_done(sc);
+				atomic64_dec(&fnic_stats->io_stats.active_ios);
+				if (atomic64_read(&fnic->io_cmpl_skip))
+					atomic64_dec(&fnic->io_cmpl_skip);
+				else
+					atomic64_inc(&fnic_stats->io_stats.io_completions);
 			}
 		}
=20
@@ -1962,6 +1961,11 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	/* Call SCSI completion function to complete the IO */
 		sc->result =3D (DID_ABORT << 16);
 		sc->scsi_done(sc);
+		atomic64_dec(&fnic_stats->io_stats.active_ios);
+		if (atomic64_read(&fnic->io_cmpl_skip))
+			atomic64_dec(&fnic->io_cmpl_skip);
+		else
+			atomic64_inc(&fnic_stats->io_stats.io_completions);
 	}
=20
 fnic_abort_cmd_end:
--=20
2.14.1
