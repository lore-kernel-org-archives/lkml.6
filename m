Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481612-2-8770394674577500576
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
    1523481611; b=nrYk34HzleFHymDToeMWuxAQafCHj8Zid+Grgkz/I8If3wxwEC
    NCv8c7NUoCrkPrT99H/A/Y/4Eu8RtSwBEVCD5wF64DCyLvR/emJUhVypYhVDL5FD
    9qvnrk8MCjDJzs0JGgX+pE80+9iwt2PfMDQ56i+BF7Rztt4hTAcORrafWdYiUx9l
    jaysVP1x9LylP8CC7vqX6VKz4iT+27oubWHOJRxNPjxC4rTmQl0zrdXOnJUdebpD
    xjIqPB2k+upcBzHayT15KI3jzpXKjtYWHZFZPh1YfBn5c4FRPtQ4GMZMSRo5I6V6
    9e+j0NZBAI/xlxRY828bEPYVWppF9nbgyLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481611; bh=+VMNPVbrWELmTiUVamMr5PDI8YRTMD
    Zfb2+MBGqUW0w=; b=Hn71AH12M7jbL7GAK1Ocpw1lxszL7T58wtCirwxtxtAw3H
    XYeBsDHPdCiO37q/3sk+nuH3cvpOyLdJs3klv/kXwQlJlvuQabsX24iTMG8wWykD
    vA82fJQCnIkcADxQCD/6nddepCJNc7kCfP6ah+MiA+U2SY7jIk9c44Ntz2nHanoC
    ambBf5JjLEl2+hozVKtxV16vXCodhE5mi8IxO4KZ7+LD146WJHgPxGOY9a7lbAbc
    LCFqrkpKLbUd6ro4u/uJz03i2Jnnf24CfFQiVvtK7nSszVI0XkrmQhCfZFwUIgj6
    E2/SgFwBtjR/HP7Ot9wambaOseyyUjvUDVS6ermQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfLM4u6f85uVkV/L1B5vdO6dpH1I5QMZHFQs/KHZkfnHR7PeADDxpeDePbA8Y6QAwDDJdGHT9vbfeHijlnkBSYGtjPkHps8drKkzVXD/6fw0SaPWliNpU
    rYvy0XmtftYF6H4kvqCfnZ98mINdCieUixtvsTeoZyXK1FDUPhWm77R9hZU/H4wpwFHcE4+tQhpIBEcRbANS/WEt3MFI1jYAm3Eras9//i6Cr2EcDsPCOdLt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=zAyngx5bAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=P6LC0INNfiNcU7SuBjIA:9 a=QEXdDO2ut3YA:10
    a=4LA4qAFo6bo561LpWNDU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754429AbeDKSjg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:39:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754424AbeDKSje (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:39:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maurizio Lombardi <mlombard@redhat.com>,
        Chad Dupuis <chad.dupuis@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 042/121] scsi: bnx2fc: fix race condition in bnx2fc_get_host_stats()
Date: Wed, 11 Apr 2018 20:35:45 +0200
Message-Id: <20180411183458.981855529@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maurizio Lombardi <mlombard@redhat.com>


[ Upstream commit c2dd893a3b0772d1c680e109b9d5715d7f73022b ]

If multiple tasks attempt to read the stats, it may happen that the
start_req_done completion is re-initialized while still being used by
another task, causing a list corruption.

This patch fixes the bug by adding a mutex to serialize the calls to
bnx2fc_get_host_stats().

WARNING: at lib/list_debug.c:48 list_del+0x6e/0xa0() (Not tainted)
Hardware name: PowerEdge R820
list_del corruption. prev->next should be ffff882035627d90, but was ffff884069541588

Pid: 40267, comm: perl Not tainted 2.6.32-642.3.1.el6.x86_64 #1
Call Trace:
 [<ffffffff8107c691>] ? warn_slowpath_common+0x91/0xe0
 [<ffffffff8107c796>] ? warn_slowpath_fmt+0x46/0x60
 [<ffffffff812ad16e>] ? list_del+0x6e/0xa0
 [<ffffffff81547eed>] ? wait_for_common+0x14d/0x180
 [<ffffffff8106c4a0>] ? default_wake_function+0x0/0x20
 [<ffffffff81547fd3>] ? wait_for_completion_timeout+0x13/0x20
 [<ffffffffa05410b1>] ? bnx2fc_get_host_stats+0xa1/0x280 [bnx2fc]
 [<ffffffffa04cf630>] ? fc_stat_show+0x90/0xc0 [scsi_transport_fc]
 [<ffffffffa04cf8b6>] ? show_fcstat_tx_frames+0x16/0x20 [scsi_transport_fc]
 [<ffffffff8137c647>] ? dev_attr_show+0x27/0x50
 [<ffffffff8113b9be>] ? __get_free_pages+0xe/0x50
 [<ffffffff812170e1>] ? sysfs_read_file+0x111/0x200
 [<ffffffff8119a305>] ? vfs_read+0xb5/0x1a0
 [<ffffffff8119b0b6>] ? fget_light_pos+0x16/0x50
 [<ffffffff8119a651>] ? sys_read+0x51/0xb0
 [<ffffffff810ee1fe>] ? __audit_syscall_exit+0x25e/0x290
 [<ffffffff8100b0d2>] ? system_call_fastpath+0x16/0x1b

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Acked-by: Chad Dupuis <chad.dupuis@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/bnx2fc/bnx2fc.h      |    1 +
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c |   10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/scsi/bnx2fc/bnx2fc.h
+++ b/drivers/scsi/bnx2fc/bnx2fc.h
@@ -191,6 +191,7 @@ struct bnx2fc_hba {
 	struct bnx2fc_cmd_mgr *cmd_mgr;
 	spinlock_t hba_lock;
 	struct mutex hba_mutex;
+	struct mutex hba_stats_mutex;
 	unsigned long adapter_state;
 		#define ADAPTER_STATE_UP		0
 		#define ADAPTER_STATE_GOING_DOWN	1
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -641,15 +641,17 @@ static struct fc_host_statistics *bnx2fc
 	if (!fw_stats)
 		return NULL;
 
+	mutex_lock(&hba->hba_stats_mutex);
+
 	bnx2fc_stats = fc_get_host_stats(shost);
 
 	init_completion(&hba->stat_req_done);
 	if (bnx2fc_send_stat_req(hba))
-		return bnx2fc_stats;
+		goto unlock_stats_mutex;
 	rc = wait_for_completion_timeout(&hba->stat_req_done, (2 * HZ));
 	if (!rc) {
 		BNX2FC_HBA_DBG(lport, "FW stat req timed out\n");
-		return bnx2fc_stats;
+		goto unlock_stats_mutex;
 	}
 	BNX2FC_STATS(hba, rx_stat2, fc_crc_cnt);
 	bnx2fc_stats->invalid_crc_count += hba->bfw_stats.fc_crc_cnt;
@@ -671,6 +673,9 @@ static struct fc_host_statistics *bnx2fc
 
 	memcpy(&hba->prev_stats, hba->stats_buffer,
 	       sizeof(struct fcoe_statistics_params));
+
+unlock_stats_mutex:
+	mutex_unlock(&hba->hba_stats_mutex);
 	return bnx2fc_stats;
 }
 
@@ -1303,6 +1308,7 @@ static struct bnx2fc_hba *bnx2fc_hba_cre
 	}
 	spin_lock_init(&hba->hba_lock);
 	mutex_init(&hba->hba_mutex);
+	mutex_init(&hba->hba_stats_mutex);
 
 	hba->cnic = cnic;
 
