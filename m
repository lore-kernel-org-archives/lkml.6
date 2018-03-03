Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120442-2-13683183240298466585
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
    t=1520120442; b=R8c92ojMUFSC1N9hP80ZAgP5G4lJGU5wnGB/6c87Tdode4H
    +tl7S0Uv5O13p/9hJduZj6N843LG+1dfp5bQbz0dAWqfE/D/vR6H3gRHDV8MFhhb
    0NNrhF0cG56w/P76Bc+9EL2WOnyE6nipd92C/7g298V/V9g/+CtSjcRdTrcrEqFp
    tv7S3GX4U3kPhbdCqCnESPimSv0jAEIN2CDhB1XbMNPccmDOhvQGV0FcWj/P0q2r
    t2d95YpH0uCtza+P3bEJC+/J/kSPf6JBuDOx0ijrPMDLA5Rb3rlduPFoqXJKKDzD
    LWApaN1G9Pw6KagYRU/8E+kSHcix3sZnsdVTeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120442; bh=gtbClv
    F1xqsjb/7SBpfRoYOC/v6VzhG/+P16djqCTrc=; b=m7lg/5k/OB4R/8Lha9dfhX
    +bmSjiMsEFe7Gg07FfuHqeXpMQJxuiFZKF8Qjwt3FjrwMtehLa/MaW5f7nMwEZpW
    /sLFIGjt6dzIajM+N0J1DgTY9krbHD2kmmqyZwaWJRKFSZVYzUJofpQUZtgX2+vk
    2SXULRTEv4mCpIePujrqtrbOd8Q2huDCwIkBiovx3I8Jf9WmQ1EwBjabAW0ltYNl
    24ewkklt/mVLF1z9PXXZxdacLppuemvJ0+CdOmesM8b67TwNBU5S/AWzZSzGMl7p
    TuwdmRy4+wzXEoeDfhRcUWtTznUNMDZn0XmCNrwBuPulRlCggNUzKtSTGd5rR/Ig
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KZtvErVc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KZtvErVc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934533AbeCCXkh (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:40:37 -0500
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:45030
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933879AbeCCWfD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 143/219] md/raid6: Fix anomily when recovering
 a single device in RAID6.
Thread-Topic: [PATCH AUTOSEL for 4.9 143/219] md/raid6: Fix anomily when
 recovering a single device in RAID6.
Thread-Index: AQHTsz8SNZreys5gjUSpYeKEkq9yJA==
Date: Sat, 3 Mar 2018 22:29:19 +0000
Message-ID: <20180303222716.26640-143-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:L4hwUMzFt17f/7kARqDoNWEVxFtCllWuIUJF3Bjj6uw5xSh7uG2WACA/YX0S9yECwWK9tstBwDiWRjePQRKd1EZ0wR9ECfYHgQprh6VTXtJmmVGPLJknjKG1/6HLSEZyWnW2dpdGGvfcq8U//sJ8gl1DL1SSZCuOz8a/ak0NhE1M2k3OaxgrHI7swhipnNJ5Sb5i/4yHGpgCjlxG0ps8FAR2jZLBBkMuQXmgQtfAOa0aSjWrSj55uJAQZla0vOpEe9mOqOkrGOTrypO6+01273nTcwxpoBJ1ce28EzRydk7+5LJvCN9tkLTnF5NUTmDDjs0jfVDbWLbT9Rj2JvWLTyioIR2eC1uOGcVGJ9Ax2Dk=;5:WWNGmcUAhl0MeULtVcPa1kawinERVuLeu5T1vuoI5yb1shb5zDIYRZRzlxtZEv5AQZFzB9PiJNxMw9j0jo2U50Wyg/cnO7o0sMYeh8PUeEG+Owp+LPrq52KIjeH+asqy7qiqrgzxLdtcxzIxkiY3dl/3gdpiDuDfMFOGQnuanUo=;24:K5aTJBira/CEGlqh8XnQA1GAs+ak3MvCfWNTodIxuJoUkgNBkeJTu+pod+9vMf5V0HYxoNmGN6OCNU8mRL9XUkNOp7uGQhlHZFo3SWsJ2K8=;7:g8lqkC7Nx+KY7sn+gm7aWhk6C18LryzL0cKz5bmEtY1DPn6NFMtNYcs0ZiuG4EndyMILBkv9MZ1oCiYUyueW9/1HaSWrFP24nj8dMgNlk2K82PtknAnOTR7QgXyD3Ediw/weLR314UPVAhEIO0zkfipNNyPsSJmFtX7TEa3mV2lBiHhigp+EtWWHlV5Fbp5n7Mrd4yi95oLmFV1GCSgGwvoXahcJwpEFQP56EEi/ppIJY6GP/5wdAjBpa3I7xveQ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab4f8fd5-e6ef-4c37-1645-08d58156fe7a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB092415C1E15330096513763EFBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4f8fd5-e6ef-4c37-1645-08d58156fe7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:19.5413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: NeilBrown <neilb@suse.com>

[ Upstream commit 7471fb77ce4dc4cb81291189947fcdf621a97987 ]

When recoverying a single missing/failed device in a RAID6,
those stripes where the Q block is on the missing device are
handled a bit differently.  In these cases it is easy to
check that the P block is correct, so we do.  This results
in the P block be destroy.  Consequently the P block needs
to be read a second time in order to compute Q.  This causes
lots of seeks and hurts performance.

It shouldn't be necessary to re-read P as it can be computed
from the DATA.  But we only compute blocks on missing
devices, since c337869d9501 ("md: do not compute parity
unless it is on a failed drive").

So relax the change made in that commit to allow computing
of the P block in a RAID6 which it is the only missing that
block.

This makes RAID6 recovery run much faster as the disk just
"before" the recovering device is no longer seeking
back-and-forth.

Reported-by-tested-by: Brad Campbell <lists2009@fnarfbargle.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/raid5.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 475a7a1bcfe0..4493be50fc6a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3391,9 +3391,20 @@ static int fetch_block(struct stripe_head *sh, struc=
t stripe_head_state *s,
 		BUG_ON(test_bit(R5_Wantcompute, &dev->flags));
 		BUG_ON(test_bit(R5_Wantread, &dev->flags));
 		BUG_ON(sh->batch_head);
+
+		/*
+		 * In the raid6 case if the only non-uptodate disk is P
+		 * then we already trusted P to compute the other failed
+		 * drives. It is safe to compute rather than re-read P.
+		 * In other cases we only compute blocks from failed
+		 * devices, otherwise check/repair might fail to detect
+		 * a real inconsistency.
+		 */
+
 		if ((s->uptodate =3D=3D disks - 1) &&
+		    ((sh->qd_idx >=3D 0 && sh->pd_idx =3D=3D disk_idx) ||
 		    (s->failed && (disk_idx =3D=3D s->failed_num[0] ||
-				   disk_idx =3D=3D s->failed_num[1]))) {
+				   disk_idx =3D=3D s->failed_num[1])))) {
 			/* have disk failed, and we're requested to fetch it;
 			 * do compute it
 			 */
--=20
2.14.1
