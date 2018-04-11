Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479431-2-4485007362373633110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479430; b=dicJY+74/qRueinIemsiK6KiaU1Qc8STI0aQNiyZUABtajKfcc
    UGBcyF33xFqsc/GQfMe1J7Bd7VdYSYPCEWYvUFAgEbSOhxwkpjyq0mLonJPeUTIl
    EDwRVHUR0ve/xdzP8RYWiQmYa8AAKVNm/PZzBSo0QIhNZCqA85aBahihiSEGYY+Y
    xF10oby55qnqvwqhCjISzaoDVlCvdsK3iO1UCj9gf7SV+Sb5ivL2vrloksYME4ia
    usE1O/rAxSacxXmvST3xcgs9eIiOjIWDYvNFKZG/S34NGaglrou5rSrboc3qj5ep
    TV0K6nTuZKoJ32x9G7txL4dSVtMgnsD8tbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479430; bh=Z+s6ehnQfvG+7ApyAiwo8S8wTTXnNg
    rTt5Vp/g2GIMA=; b=WQAtWm196a74YbatYK2g8NOgQaJUnQafqj5D/UvEHuZO7g
    HyzmNlNpIAEMnd0xCe9/OaOyqqnOIKB68Sd+EgAUcDiCJrYe3OgdQ3r9t6Ly+cXq
    IWuy+cnYy4IpYgo3bhPfP5KQWfgq2IG2lQe1yGeSRc0E80p/TUBZSffaNJzd20EY
    7FN4yQAXRkqZR+O+kcQ4WoXPj6touhJH9L8Ne2GygicMMdUPPwOBq2ZlzFrSBAuf
    q2oQwzzK398RB1ZCW/kzklxKgbtp36buXSQak9xH9evpVGVTxdXBI6ew7gxteZLC
    wI9k9aGlY6O9KmbqQZ24hvHx94qzgCsdeObLYHhA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJoBpSQxrBOLz3+FP7trMfxJaJFsU46WYgyg1LHTJwfWJZP7cc25Q5DTohwtL+UPJnOB5bFK/dabbkBRg/s+ZyHNyjcmn7wWJFn1+YZySQvAD1FAcDzz
    6ZICI8LT5hCLSQtOCC0DrlKWKwiTW2RiwzhpL2YDfiLx/begOruC1dQhBdf424VhLNFcAgKCM2aiHauWeXBcKCgWxHPKEXIPi7hrQOyxr3T546zX7t/3yyVa
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=_8L-UY4ewCS_Er6kyY4A:9 a=QEXdDO2ut3YA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755910AbeDKSr1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:47:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755889AbeDKSr0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rafael David Tinoco <rafael.tinoco@canonical.com>,
        Lee Duncan <lduncan@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 089/190] scsi: libiscsi: Allow sd_shutdown on bad transport
Date: Wed, 11 Apr 2018 20:35:35 +0200
Message-Id: <20180411183555.829471728@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/libiscsi.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1695,6 +1695,15 @@ int iscsi_queuecommand(struct Scsi_Host
 		 */
 		switch (session->state) {
 		case ISCSI_STATE_FAILED:
+			/*
+			 * cmds should fail during shutdown, if the session
+			 * state is bad, allowing completion to happen
+			 */
+			if (unlikely(system_state != SYSTEM_RUNNING)) {
+				reason = FAILURE_SESSION_FAILED;
+				sc->result = DID_NO_CONNECT << 16;
+				break;
+			}
 		case ISCSI_STATE_IN_RECOVERY:
 			reason = FAILURE_SESSION_IN_RECOVERY;
 			sc->result = DID_IMM_RETRY << 16;
@@ -1980,6 +1989,19 @@ static enum blk_eh_timer_return iscsi_eh
 
 	if (session->state != ISCSI_STATE_LOGGED_IN) {
 		/*
+		 * During shutdown, if session is prematurely disconnected,
+		 * recovery won't happen and there will be hung cmds. Not
+		 * handling cmds would trigger EH, also bad in this case.
+		 * Instead, handle cmd, allow completion to happen and let
+		 * upper layer to deal with the result.
+		 */
+		if (unlikely(system_state != SYSTEM_RUNNING)) {
+			sc->result = DID_NO_CONNECT << 16;
+			ISCSI_DBG_EH(session, "sc on shutdown, handled\n");
+			rc = BLK_EH_HANDLED;
+			goto done;
+		}
+		/*
 		 * We are probably in the middle of iscsi recovery so let
 		 * that complete and handle the error.
 		 */
@@ -2083,7 +2105,7 @@ done:
 		task->last_timeout = jiffies;
 	spin_unlock(&session->frwd_lock);
 	ISCSI_DBG_EH(session, "return %s\n", rc == BLK_EH_RESET_TIMER ?
-		     "timer reset" : "nh");
+		     "timer reset" : "shutdown or nh");
 	return rc;
 }
 
