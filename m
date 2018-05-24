Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159503-2-3555616517474401157
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159502; b=MPWic0lrxYaIV+lS1KrssOUrFMAKUo1bL0BS3nYxqjG5mVUnq6
    tdz76fyC9gTAEu1PB0VTruF1sdP8nQGG4J3KhKSS4n81eZF2yiEmDDmZ6G7qZ7yB
    fzCE+xqHwUKBiILsWzkmW1Df4EMbwS19qZckgb0RPPdtKU8xK0gdn2tVZtfS2+gJ
    Pm0auYJT1EY51R+z9XOxUhgLb07D5w2Z3HJ/8vv1kRtG56Io58i1C5YkZ/t4Maee
    oG8yijHuPiK0GZThubjvT5HhsJHCUt90bh4PUBy/+qUI9GUxlpQDCyGBz7I2H3a+
    8eeEglgPKe+w7UKKjYOQPySsdhp8rd6O1A9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159502; bh=J+KvaMfLGOndurC+NYzXDw0zTxD6+8
    WZ0u0Gp9CfSOo=; b=Cnfj4s258glbercCQwTWVB+YaEAUhZimO/5/mwM9T4YmAM
    UA+ENvMdTVX6cBPhY01h8jnkrrvA5cQO8ZzPXETYl4waR2pC8LzGnjkXnp4rTooQ
    Bf986XopkrhrLHJX4sDcA5jf93vYQqu2bi9iZt6t65haeTC/MbMuR3EVPwk/a3pv
    FU8Dk45nR7b/qVP8L6JGXy3DCtda94fnwLXs63d6Tn1dbUmYdGrqJEqQsPV9oOK3
    dJjrdbzST0/pFScH4sG01U3lsRbr5o+Ixlb4j24LSoiNEHcfVFIHwiCeVU599lIK
    WiMzdQppwozpGCcXoLEKXMWJS5eWexHPkTJID7eQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=XrSjE3Io x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=XrSjE3Io x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLNFIFdGJoCydW2mtThyMhboXhBqAxMeBAOd5hojbt3IovxV33ktBwDKrPwxVZ7l8et28x5nX9q5TxI8/5V+vHnanPVbMWLOVpRQJ/a8kY5vkEWORU1c
    tlhEAAH6kdndw+SgDAUjL5b+pbRj6N+3GMsUk4gyzG7Sl93nOhBWU/P6SElJlWgl+X0p3LNQIBAXT2CSUc+p2qFQL4dq0Z0KVj5yySvMHbnZUs1W0AHaiPMy
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=zAyngx5bAAAA:8 a=JF9118EUAAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8
    a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=OWTPzIq-PwndnzJ9viQA:9
    a=QEXdDO2ut3YA:10 a=4LA4qAFo6bo561LpWNDU:22 a=xVlTc564ipvMDusKsbsT:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967722AbeEXK6E (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030236AbeEXJ4F (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Vasquez <andrew.vasquez@cavium.com>,
        Nilesh Javali <nilesh.javali@cavium.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Chris Leech <cleech@redhat.com>, Lee Duncan <lduncan@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 107/165] scsi: qedi: Fix truncation of CHAP name and secret
Date: Thu, 24 May 2018 11:38:33 +0200
Message-Id: <20180524093626.345592797@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Vasquez <andrew.vasquez@cavium.com>

[ Upstream commit 1683ce57f568c7c92d53e9234624a53554a29cd5 ]

The data in NVRAM is not guaranteed to be NUL terminated.  Since
snprintf expects byte-stream to accommodate null byte, the CHAP secret
is truncated.  Use sprintf instead of snprintf to fix the truncation of
CHAP name and secret.

Signed-off-by: Andrew Vasquez <andrew.vasquez@cavium.com>
Signed-off-by: Nilesh Javali <nilesh.javali@cavium.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Acked-by: Chris Leech <cleech@redhat.com>
Acked-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qedi/qedi_main.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1840,8 +1840,8 @@ static ssize_t qedi_show_boot_ini_info(v
 
 	switch (type) {
 	case ISCSI_BOOT_INI_INITIATOR_NAME:
-		rc = snprintf(str, NVM_ISCSI_CFG_ISCSI_NAME_MAX_LEN, "%s\n",
-			      initiator->initiator_name.byte);
+		rc = sprintf(str, "%.*s\n", NVM_ISCSI_CFG_ISCSI_NAME_MAX_LEN,
+			     initiator->initiator_name.byte);
 		break;
 	default:
 		rc = 0;
@@ -1908,8 +1908,8 @@ qedi_show_boot_tgt_info(struct qedi_ctx
 
 	switch (type) {
 	case ISCSI_BOOT_TGT_NAME:
-		rc = snprintf(str, NVM_ISCSI_CFG_ISCSI_NAME_MAX_LEN, "%s\n",
-			      block->target[idx].target_name.byte);
+		rc = sprintf(str, "%.*s\n", NVM_ISCSI_CFG_ISCSI_NAME_MAX_LEN,
+			     block->target[idx].target_name.byte);
 		break;
 	case ISCSI_BOOT_TGT_IP_ADDR:
 		if (ipv6_en)
@@ -1930,20 +1930,20 @@ qedi_show_boot_tgt_info(struct qedi_ctx
 			      block->target[idx].lun.value[0]);
 		break;
 	case ISCSI_BOOT_TGT_CHAP_NAME:
-		rc = snprintf(str, NVM_ISCSI_CFG_CHAP_NAME_MAX_LEN, "%s\n",
-			      chap_name);
+		rc = sprintf(str, "%.*s\n", NVM_ISCSI_CFG_CHAP_NAME_MAX_LEN,
+			     chap_name);
 		break;
 	case ISCSI_BOOT_TGT_CHAP_SECRET:
-		rc = snprintf(str, NVM_ISCSI_CFG_CHAP_PWD_MAX_LEN, "%s\n",
-			      chap_secret);
+		rc = sprintf(str, "%.*s\n", NVM_ISCSI_CFG_CHAP_NAME_MAX_LEN,
+			     chap_secret);
 		break;
 	case ISCSI_BOOT_TGT_REV_CHAP_NAME:
-		rc = snprintf(str, NVM_ISCSI_CFG_CHAP_NAME_MAX_LEN, "%s\n",
-			      mchap_name);
+		rc = sprintf(str, "%.*s\n", NVM_ISCSI_CFG_CHAP_NAME_MAX_LEN,
+			     mchap_name);
 		break;
 	case ISCSI_BOOT_TGT_REV_CHAP_SECRET:
-		rc = snprintf(str, NVM_ISCSI_CFG_CHAP_PWD_MAX_LEN, "%s\n",
-			      mchap_secret);
+		rc = sprintf(str, "%.*s\n", NVM_ISCSI_CFG_CHAP_NAME_MAX_LEN,
+			     mchap_secret);
 		break;
 	case ISCSI_BOOT_TGT_FLAGS:
 		rc = snprintf(str, 3, "%hhd\n", SYSFS_FLAG_FW_SEL_BOOT);
