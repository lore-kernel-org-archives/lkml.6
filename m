Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493847-2-2359181530864605479
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
    t=1521493847; b=XY4BGOePlF5KE/LQRMe9QbK5jDK8DI3pqSWAi/6WmOTFgnY
    ttAOY7utvnhJtsmwAj1Hro5Izy1CWAJcT/ePPjhsYRtrH3x2s3OknAQgI6pWKtrR
    vZ37KTxxd5P9riA0g6Eua/Xqgu2T7wlQLV7IsJVSiP//APApxqZf722fk4ulaGxG
    kb4/QoLU5OUuZJMDfDt3d5ksj8jWSLekD4cGwfo1wB5d09C0zdYEK9BViZEUAJ6/
    aDVTeRaEQxZcZAolMgc9QB3/M2s/a3cLAsKkfji5wEwZZKVbKb+DTAbfCje9lwYy
    QBxS8nPbPkN8TMoBaAM/68Li324Dx8PQ+NZ7Ckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493847; bh=xzqZbE
    0oLnuIMJYy9JX3cnGO0WbFzIU+E4vDA/o661E=; b=ucfYPpPPabhThbF0enJbTt
    7q56+/9czyfg1/zEubmfuLeM5TqmSRR1Y4clx3VW0jb5FQ75wwwLQhk84Gdh03Sd
    iYZseXS3J1YB40Jw90hvQHfFiqSebQ0oS13pxLTcxy/Rrd5EPCa3zZNZnybdVwAH
    dsetqOmonIn22ii/n63DDSSpHA6mxR4Z+V+II/flMwexnZC7CorWjBwxVvQLcy9a
    8DiNkrBDBH2PB9WW9E/bK/PW2Kly9XxuXsOHIAE5K5ko1oNO1c0ywVMwefg2DpGI
    +x/5CtFyoOQ8FQ+DvOoM9RKxc8gQfio/bcK62WCg2s0nTvhfxw0Fui82QvNKEJMA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lsmn2vRI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdegudegnecuvehluhhsthgvrhfuihiivgepheef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lsmn2vRI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdegudegnecuvehluhhsthgvrhfuihiivgepheef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935920AbeCSVKQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:10:16 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:15805
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934955AbeCSQB5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rafael David Tinoco <rafael.tinoco@canonical.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 136/281] scsi: libiscsi: Allow sd_shutdown on
 bad transport
Thread-Topic: [PATCH AUTOSEL for 4.9 136/281] scsi: libiscsi: Allow
 sd_shutdown on bad transport
Thread-Index: AQHTv5tpwCWBeP6WME+5gOm1GvIZtg==
Date: Mon, 19 Mar 2018 16:00:34 +0000
Message-ID: <20180319155742.13731-136-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:ZVBMRZjwJHQy5UdXtB/LhwrmsGQVA8fr6FHtQ2yO4A0qI6BMjlW3b9ARe6ysABazJ0lpCqsc+IWvcaYSlboGP1+RuMkbz7IZZ91nLprB0jpBK4R/SCX2ghRJFGhvKE1dCnUn0rphiwA4I1jxxXh9FVC54s0tJfVCIYUK5fS2O+3m+R9zZnk9rrhbTMDkvgnCHFLOMlnyrinVSgjU5SP9pYpnSZ83NTn267mB3YmfVsm/k9OkEYTf/6WuxN+j/Xoa;20:gyms6b2e66Y7uNZXYEy4RMddzyLXoQdtJ1LqQ0G7xKyws+1zqV7MYMAdwawok2t0d+YAvXCYixCgiMy7fwKcd/S3RvtgnXf9oVZfky71yy6uCMKgrFH9WipEH0rQ/cIhFQrZYBJvsTpD0Hz6XaJCGgPRHhpA2rk58um6jVUN8DQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80d31a5b-b891-40fb-8af9-08d58db2b92a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919527B4B3F2C564999287EFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(146099531331640)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8/hig42sbQBUwirYsvwDZGiuWbA2NCMagvVQBvwPYfSZUbZiWXAugzPJKGA7FYPTWl+c/NbH9nHsO7XVBmTVwjoD5wC/p32kcb/uXdedp+5wCezDFdJN9W2suApCNPHKliq3D9LGEsOiU6Nx/Q3NZtC3IjfwIusecTKcOweaimiltbG06cn+lMV+OpOQI0aiSWQokB7+B5NWCEtImZLJz5S+5ntssT/5JYR5nQ6u8xNWYJomIL47kSfmdfGPVNL79uYB9QiFJ0j35UpZcnKYa9nSVz9SEoLVxnTmR2nKS+Sey73iri77d8GBrmR9dn/w7vxpW1VeO2Fu76/apqEYZw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d31a5b-b891-40fb-8af9-08d58db2b92a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:34.3713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index 4abd3fce5ab6..c2b682916337 100644
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
