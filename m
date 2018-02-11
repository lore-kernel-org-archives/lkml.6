Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518323846-2-16271488706596306967
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518323846; b=iK+0zhLQ48swt5J6XFnkhkXQwIfUZUmtxUIlg43Bqxhz0P3
    PZrmBcH+D4/g0yr9uO0U5iEIP9McMglXTYpE1qDlrD7uNq7zGxJfALh81JmrJkyN
    bKQfWtJjNtt5n4XXbCpPa/J0T4qNMRDNtelEPp/ks8Gc3+NKqUxrl2qh2BRzGOSr
    AWumPQpGk4rkXqCfVenw0kiqx+Yj7Tbr2VW02HEk/4h2o+DAYjXd6gJLRkWqKgyj
    jAbZZOfs7XhQFH6iApVDRdrBWyd3dRH1DMuczlqonM2g1/j2qWIvjQsvQktu6deH
    PEnMof0OATwb6HA28Y5hgSCpSNUrYbPePyvvrng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323846; bh=3yVlIA6GF0y+/va2RFQ
    j/qciDzcgYnsAlZ5miwLXyb4=; b=NRCbCq9Z+bulEPI+Z2hWtMd+EfGkXKSRgPZ
    Ip+7kdxw1UMhCE3Eh1tAf959Rio2Z4Jgzz4V0uRFLP7dvspC1Hgb57MgtLmsQXvb
    MvSUyO0+pVHf/oFJqa9pJu2/G/GJavuhnXY/A2/vvDDaHuA45Buey63kBg+GQcyb
    G1cASyacJ/HZJinjFtiwP3QdYQmu587QUuTfEUM2DOrB/LOhAu/uFIy5LlnwV35l
    gy7V33gOrN/eFz/GN211lufBOve8pd0fhgxiYHdwpY079rUIqLnAU8hT9hPkVJr4
    a57egfUMN35TyX1GKK1y7lhixYaaYS++KGS5Q1PUxAWRaQ8ruoQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbeBKEfB (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:35:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41772 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753006AbeBKEeO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Hannes Reinecke" <hare@suse.com>,
        "Mike Christie" <mchristi@redhat.com>,
        "Nicholas Bellinger" <nab@linux-iscsi.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.387477916@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 066/136] iscsi-target: Fix non-immediate TMR
 reference leak
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Bellinger <nab@linux-iscsi.org>

commit 3fc9fb13a4b2576aeab86c62fd64eb29ab68659c upstream.

This patch fixes a se_cmd->cmd_kref reference leak that can
occur when a non immediate TMR is proceeded our of command
sequence number order, and CMDSN_LOWER_THAN_EXP is returned
by iscsit_sequence_cmd().

To address this bug, call target_put_sess_cmd() during this
special case following what iscsit_process_scsi_cmd() does
upon CMDSN_LOWER_THAN_EXP.

Cc: Mike Christie <mchristi@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
[bwh: Backported to 3.16: target_put_sess_cmd() takes an se_session pointer
 too]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/target/iscsi/iscsi_target.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1917,12 +1917,14 @@ attach:
 
 	if (!(hdr->opcode & ISCSI_OP_IMMEDIATE)) {
 		int cmdsn_ret = iscsit_sequence_cmd(conn, cmd, buf, hdr->cmdsn);
-		if (cmdsn_ret == CMDSN_HIGHER_THAN_EXP)
+		if (cmdsn_ret == CMDSN_HIGHER_THAN_EXP) {
 			out_of_order_cmdsn = 1;
-		else if (cmdsn_ret == CMDSN_LOWER_THAN_EXP)
+		} else if (cmdsn_ret == CMDSN_LOWER_THAN_EXP) {
+			target_put_sess_cmd(conn->sess->se_sess, &cmd->se_cmd);
 			return 0;
-		else if (cmdsn_ret == CMDSN_ERROR_CANNOT_RECOVER)
+		} else if (cmdsn_ret == CMDSN_ERROR_CANNOT_RECOVER) {
 			return -1;
+		}
 	}
 	iscsit_ack_from_expstatsn(conn, be32_to_cpu(hdr->exp_statsn));
 
