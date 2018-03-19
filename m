Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521477573-2-507818678573503591
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521477573; b=slx4wofjsX/fuQsgAcIyvNB6A7V+yDYG6biIV+f/pEfcMtN
    smslLHjKhuqJ4+UNXVAtpvjgAHz88O0SUUF/wIcvRAoF+DVunOZvgdnKgDgUiuoC
    hqYwAufguOT5ZOpSrLt2kULQJhhXs/6JJgxTnq/FuIGz4HY/92jB/mUFd1+eGxds
    +ymleezEiBC8m0AOt0Cd+jxtJBdRur1NmehOQVxf/3D3umc25HiI0Z5NnSG3ZKuH
    rHiCqbL28d+3u4Cb/9Myd/xmiL51FRPxjuJtejUV9LXPiP53KB7PdXN8bbPq/Oty
    REwy7lMTWEFNVzrOpXArzPIzDyRuHJvLccC8O0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477573; bh=E2R9SS
    zprlGiLy/zDltXfiYR92ngtceW1ZRUdBRjjXQ=; b=wmMNDOM/snP2Fmkubkp6X1
    JGOx/81XwlzCMf+Xh91RxfW0dccOeL0vp9PArXnuCyVa+Eg0NjZMjtaKRcNcficC
    0Mc/2SUHEzgy6bzY+8k9Khb+Ogaw1PCLsjO7nUxcBqQOSEcQF8wwVbML/96yj4le
    lSnfyuuZ/MP1X9g/AGK8M6jdVyBJNn+cY3D9UHmA02BpwzAjH3KCGqJ+tgX0b8US
    yFD60k/dIBGV3LRgGQwVSlyYc5czDnxl02zAjZ1AiCmZzEkxPLdvw0h64g/3NEv5
    +GEcOX28Mm4NwQsX+82gY2AGz53LrAOJuRtPX9I17dDQxRpq/hK9ckSvhTMDh89Q
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=drReo1mP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtgeduheenucevlhhushhtvghrufhiiigvpeeivd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=drReo1mP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtgeduheenucevlhhushhtvghrufhiiigvpeeivd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966876AbeCSQNI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:13:08 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:1938
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966862AbeCSQND (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rafael David Tinoco <rafael.tinoco@canonical.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 051/102] scsi: libiscsi: Allow sd_shutdown on
 bad transport
Thread-Topic: [PATCH AUTOSEL for 3.18 051/102] scsi: libiscsi: Allow
 sd_shutdown on bad transport
Thread-Index: AQHTv50XjZYpgVcPR0W8YVMqr5/BZg==
Date: Mon, 19 Mar 2018 16:12:34 +0000
Message-ID: <20180319161117.17833-51-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:d8YZ4Whmn9toAKWWlwLHu4K56n1fPz6VUnq+uOVn6B4nXezGRT93GKQzIBtBuz6bkAGv4bFtttmZVaJnGnCVgOGBfZbQIampPe0v13TTb3+ZY0MKOy/uPC+yMz8B6loPhZW+6K+G4HOy2DnebYkXVQoeXaSufXCxUs4yG5ndJ5HfkId5ewbvFHsQ4g0tGqdRMbB/opw+2z7rgz2ZUnqTAyg/dHpRZlzZn/ZGE+VU4iuEQJy4Za5ek1O2frO0/0Nw;20:EDHKn/xflyaeTqOvMBCXmNYNUIvgFTvDy1E5uv6FXtuxba4yIiA7O4w2nOEP+CD0ghQfmgDoW7Bsan1MhndjIeWNSZGQGNX3ao2+t5nBbwsPbyJUb7IGVbW3jwTRlZ9UN3XlgfOYYfPqxN4t4pk/0VoEtfYKt0eyxCsgTLIjmoU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0889f4a7-66c2-414c-5f22-08d58db446f0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048B025F8161B8556F80E29FBD40@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(146099531331640)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(3846002)(6116002)(59450400001)(305945005)(6436002)(36756003)(54906003)(110136005)(53936002)(14454004)(97736004)(3660700001)(99286004)(76176011)(22452003)(7736002)(6512007)(316002)(6486002)(186003)(86362001)(2950100002)(575784001)(6666003)(5250100002)(66066001)(3280700002)(102836004)(107886003)(10090500001)(106356001)(25786009)(6506007)(26005)(8936002)(2906002)(81156014)(81166006)(2900100001)(8676002)(86612001)(2501003)(478600001)(105586002)(1076002)(68736007)(4326008)(72206003)(5660300001)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: RcKSqI9mQwo+rifR/Mg80SmPc2BF7abajGGOEHa91kmr5nnw5StMjG6r4RixhZWQ//3rjwpVkywef5GSd0Mu+oX3HaJjULvhHx6Iad1gGFy6faN+tVKUO5tDUTNG42yveP1GVyBc7ppi7hIvLiOutF34OSxxnmIBefXyhLzG3/ruFSC+qUmTy5x2pjBViwtfagxSth5yObkmk5s2c/DZ0iYU9LHq+ggcx0K4eNDbJkF4Ppje1abS8ae+aL0quuE/P7DIFgtSeD6acq5D2miXm+UhZjP7XsUMRF4sNx667Uiahl8YJyTuvHy+0SzaprynocvEOUVroOgR+sIKRYHtxw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0889f4a7-66c2-414c-5f22-08d58db446f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:34.4674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rafael David Tinoco <rafael.tinoco@canonical.com>

[ Upstream commit d754941225a7dbc61f6dd2173fa9498049f9a7ee ]

If, for any reason, userland shuts down iscsi transport interfaces
before proper logouts - like when logging in to LUNs manually, without
logging out on server shutdown, or when automated scripts can't
umount/logout from logged LUNs - kernel will hang forever on its
sd_sync_cache() logic, after issuing the SYNCHRONIZE_CACHE cmd to all
still existent paths.

PID: 1 TASK: ffff8801a69b8000 CPU: 1 COMMAND: "systemd-shutdow"
 #0 [ffff8801a69c3a30] __schedule at ffffffff8183e9ee
 #1 [ffff8801a69c3a80] schedule at ffffffff8183f0d5
 #2 [ffff8801a69c3a98] schedule_timeout at ffffffff81842199
 #3 [ffff8801a69c3b40] io_schedule_timeout at ffffffff8183e604
 #4 [ffff8801a69c3b70] wait_for_completion_io_timeout at ffffffff8183fc6c
 #5 [ffff8801a69c3bd0] blk_execute_rq at ffffffff813cfe10
 #6 [ffff8801a69c3c88] scsi_execute at ffffffff815c3fc7
 #7 [ffff8801a69c3cc8] scsi_execute_req_flags at ffffffff815c60fe
 #8 [ffff8801a69c3d30] sd_sync_cache at ffffffff815d37d7
 #9 [ffff8801a69c3da8] sd_shutdown at ffffffff815d3c3c

This happens because iscsi_eh_cmd_timed_out(), the transport layer
timeout helper, would tell the queue timeout function (scsi_times_out)
to reset the request timer over and over, until the session state is
back to logged in state. Unfortunately, during server shutdown, this
might never happen again.

Other option would be "not to handle" the issue in the transport
layer. That would trigger the error handler logic, which would also need
the session state to be logged in again.

Best option, for such case, is to tell upper layers that the command was
handled during the transport layer error handler helper, marking it as
DID_NO_CONNECT, which will allow completion and inform about the
problem.

After the session was marked as ISCSI_STATE_FAILED, due to the first
timeout during the server shutdown phase, all subsequent cmds will fail
to be queued, allowing upper logic to fail faster.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@canonical.com>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/libiscsi.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 0f100b35f9ab..9ca83ebef776 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1695,6 +1695,15 @@ int iscsi_queuecommand(struct Scsi_Host *host, struc=
t scsi_cmnd *sc)
 		 */
 		switch (session->state) {
 		case ISCSI_STATE_FAILED:
+			/*
+			 * cmds should fail during shutdown, if the session
+			 * state is bad, allowing completion to happen
+			 */
+			if (unlikely(system_state !=3D SYSTEM_RUNNING)) {
+				reason =3D FAILURE_SESSION_FAILED;
+				sc->result =3D DID_NO_CONNECT << 16;
+				break;
+			}
 		case ISCSI_STATE_IN_RECOVERY:
 			reason =3D FAILURE_SESSION_IN_RECOVERY;
 			sc->result =3D DID_IMM_RETRY << 16;
@@ -1998,6 +2007,19 @@ static enum blk_eh_timer_return iscsi_eh_cmd_timed_o=
ut(struct scsi_cmnd *sc)
 	}
=20
 	if (session->state !=3D ISCSI_STATE_LOGGED_IN) {
+		/*
+		 * During shutdown, if session is prematurely disconnected,
+		 * recovery won't happen and there will be hung cmds. Not
+		 * handling cmds would trigger EH, also bad in this case.
+		 * Instead, handle cmd, allow completion to happen and let
+		 * upper layer to deal with the result.
+		 */
+		if (unlikely(system_state !=3D SYSTEM_RUNNING)) {
+			sc->result =3D DID_NO_CONNECT << 16;
+			ISCSI_DBG_EH(session, "sc on shutdown, handled\n");
+			rc =3D BLK_EH_HANDLED;
+			goto done;
+		}
 		/*
 		 * We are probably in the middle of iscsi recovery so let
 		 * that complete and handle the error.
@@ -2102,7 +2124,7 @@ static enum blk_eh_timer_return iscsi_eh_cmd_timed_ou=
t(struct scsi_cmnd *sc)
 		task->last_timeout =3D jiffies;
 	spin_unlock(&session->frwd_lock);
 	ISCSI_DBG_EH(session, "return %s\n", rc =3D=3D BLK_EH_RESET_TIMER ?
-		     "timer reset" : "nh");
+		     "timer reset" : "shutdown or nh");
 	return rc;
 }
=20
--=20
2.14.1
