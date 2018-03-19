Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475790-2-13686643479085352155
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
    t=1521475790; b=mAS2r8CfGO+1w33XYzTU9ERLu9BCX3ztVlMVIZKRWCf68R1
    HSK31RCaf7TKvKTt/6pu5YjVSiRC1z1bVEQMruJNE9/S2Ghy/AE/Q8xFcdWDMpdZ
    FX2NwTfuTkXmlcPZ8AO7RV4SfAoJWLrtLNugxpp+ajeBuWY18C5aQzEwfRhvQ6EZ
    d2QXEhIjI8UJUpxz2lamECCiN+CMr/JwiSumkZCz7kVaBLcJzzyIAS/XEsODf3p+
    PKFeYsY9TdNVt5jnoIpPiZ3lLpnPiEPu/4/nO7DFs+LdymuTIphfFY6kRQTHRzeO
    QZClF3pEJ3q0dMQk076eg1TLbfpJmAV8TLtjmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475790; bh=R0ZLQm
    7vBjAinv3AE9Kl8JI2oHr0eCKiX39tSXnulFE=; b=JQImpwKi+LOB15+HItie/j
    ZItBiJpZ1dO/AyYgoxhavti40F4p/dGPyoGEBVODDc27iuOvNjBgPEVP9TD5UUke
    5hyNUE+UTwnBNTkXp4FS10aXKyyM/phZOGB6sNtJS71u6mtqfDRAaOzaqbIqu5GO
    xHqdEX6iNVIiLgHpjF9NapGYL+Xd+2kxPTJwUun01DLCMcHfQCrrWRLH8QiejHqR
    GP77LfRPvRWkIT1Eum0Tkx6rAidOsUsweYsyi9KBDp+pNh6E5USgredGISzMV0JY
    1BTJdk6tCwhdGb4nkTlWc+Oujbi8/E2In9qcq05GYxKT7oOXnDSwJwHTQenyvksg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jc8dnBKA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtgedufeenucevlhhushhtvghrufhiiigvpeefge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jc8dnBKA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtgedufeenucevlhhushhtvghrufhiiigvpeefge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966388AbeCSQJn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:43 -0400
Received: from mail-sn1nam01on0124.outbound.protection.outlook.com ([104.47.32.124]:21024
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966051AbeCSQJW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rafael David Tinoco <rafael.tinoco@canonical.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 090/167] scsi: libiscsi: Allow sd_shutdown on
 bad transport
Thread-Topic: [PATCH AUTOSEL for 4.4 090/167] scsi: libiscsi: Allow
 sd_shutdown on bad transport
Thread-Index: AQHTv5xYCfqbyoCwuUe2jBwqRxcH1A==
Date: Mon, 19 Mar 2018 16:07:14 +0000
Message-ID: <20180319160513.16384-90-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:LHziC0aF1khRzZiyzHNvJctiqqQziC5o9M9dZQ9tXQdE61bKxCsn1sOP07RLaQEKXrkWYJ39aCbnWXH+kbyp4gNcnlPE4hROnXymjf+Mr14FGpnMNJL/0Kzl3ExC59yd35msOu9/YR9Ymuhln/umfxplt6SBgOBFXMbTV6v25ectExI9Ho03TWmrn1cpVZaIhAV99Vj1Y4BFglsg2hCjM2H3YowNqE/07lMplM8d6JylgMIHh7yO+d0w2BVi4IwJ;20:/eYEdNuDhU8D77mt3PoAzlRJCHlQEnaatB19mR6Eeq48PFaiGMgZZpW2tTGlDNs7uA7LtZwKunMWrkm3GB59LGAWcG1myaGHXMI/bQiUD7rkbdbi7JYrFsh5CwaBUM2zmKWsJQnXQWmifDQcmhy625p5OhYCMIWjj9jOLmx/otc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d21b15f0-8f18-4aba-5a95-08d58db3bf5d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902A72C258CA41516F1DEBDFBD40@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(146099531331640)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(4326008)(305945005)(7736002)(66066001)(105586002)(316002)(8676002)(25786009)(8936002)(6666003)(2950100002)(5660300001)(97736004)(81166006)(81156014)(3280700002)(22452003)(99286004)(186003)(2906002)(76176011)(5250100002)(59450400001)(54906003)(10090500001)(110136005)(6116002)(2900100001)(3846002)(2501003)(1076002)(86612001)(107886003)(106356001)(6436002)(6512007)(575784001)(86362001)(53936002)(6506007)(6486002)(26005)(14454004)(10290500003)(102836004)(68736007)(3660700001)(478600001)(72206003)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: n6kU0qKOztN8+VIJ2Rn47nKNpr1uHPjpKXv8OHks5MaF9f2Ly/LyxG6aZJ+ZcnTQXqg7d1nxXptpIguLvfMAi90lgTYpHBm8LGzaJ2a87jbwhuXNMgG5UCLz6eZot3EeylY80hVagZmswuszXQJXxxeo2nPS3zwMPd7ijFy0dRTOq9y1CKhhfHoLn4CpB8/myapgdd5PiIxkQ5fk7FUndk78BmaFyhMI61Z+C8WZEJa1hcL3kAiz/Pu3OM0sV1yryqygaXx4f6spV4zXUVZT+eBopvtJ9zS5grL8a3gh9ufpCe1IDYK3jB9TIgbd318QlDUvEljk6jEYQH3iP+g/iw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21b15f0-8f18-4aba-5a95-08d58db3bf5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:14.8581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index efce04df2109..9f0b00c38658 100644
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
@@ -1979,6 +1988,19 @@ static enum blk_eh_timer_return iscsi_eh_cmd_timed_o=
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
@@ -2083,7 +2105,7 @@ static enum blk_eh_timer_return iscsi_eh_cmd_timed_ou=
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
