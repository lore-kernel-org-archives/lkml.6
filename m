Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161540-5-4656784848364808351
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161540; b=npFXNCcnqzk+Bahu2qmeDbvxVDL6jEwvcG+OyhS0sMveTnXy3R
    6FBBcB28WMNyBk/kQjE4PYISUoiLNCtU+b6DVM6l/7dKd0t94Wv5ma3AdflWloi3
    NSsP+Cib2nhaLFMjtTXw0Vhha/lAA8owgVqrucGhDperySgIPyFUJV4Ei7IKO3R2
    Ameu01TyhNdTrMdOA6h0DiXQRGg3BwsMQuXrEYSAD9Jq7rSS8c6ocvX2m13Y8CCY
    iZOY3QIwd9nPQKO+kj6922Jt1Wh9HvPhSldnIVDVLsJfaE0mEqFQFfxkySWaKdO1
    e4IiqvYumKjNcWMRWuQkmGnfR6Abxug6HIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161540; bh=YHSfPFdhIG+Qiy6P1cT1Wjm0pvpXYi
    wroEFjmpgAchE=; b=AtXQYwLN47VagkM0YT+6Q6/D3PNXSU+k6PEAZe4CHJXxY2
    LPPQhw2FY3kWaFxJub7VkVHXMt1+iB2SgqXpBDpvs0G1+Fajxnkl2mYgwGVKv33H
    UukQuOTkLiBVUOm44fs0fznUXEshKKHbmRLYV3QPP3d8YzK9EffFw1F0DKNyMhv/
    0R95SKlzehhWj6DDAzt5CMmuEP0bOSVeDGfK9rPrgfCWIw62ENuuw1d2sRVq5365
    acx6HCTkjYikjqxFh/DdXOeUTxRubm7k/EDHikPOL2ZXNb3famzp7kRuqRpdJZLI
    /lJJ8MnVbCQjpa1gTjWld2nJ759f0xIVvKIoknrQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=vgzwtll5 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=vgzwtll5 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfBUhLTZAh11gn9Zx9MCQ//PchT+UR9zByJSuoiNtYn/A2ZXlikdGQue4/OOF9lIwOgbfMa5QmaQYhiBr079AezXvzZev6e4SwMt7WBylLuEAZ4TMyJar
    ifakicWWQfF1NmjGK+ZTsJD2/KC2CVrO73yrmph4pdg8J0swmG9UJYxs7DXFY5YKLKhNLVCFFhbELhnjXr7lyFCo3entxKctz/Es2ja2LE2lXXEwfoqi4HPa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=uBuKx8GwAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=yb7EpQngLdXqSQRUoOoA:9 a=QEXdDO2ut3YA:10 a=wZgZ3yaTFkxMEWn-yT5t:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968879AbeEXLbp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967616AbeEXJut (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Carroll <david.carroll@microsemi.com>,
        Raghava Aditya Renukunta
        <raghavaaditya.renukunta@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 62/96] scsi: aacraid: Insure command thread is not recursively stopped
Date: Thu, 24 May 2018 11:38:45 +0200
Message-Id: <20180524093609.028038084@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Carroll <david.carroll@microsemi.com>

[ Upstream commit 1c6b41fb92936fa5facea464d5d7cbf855966d04 ]

If a recursive IOP_RESET is invoked, usually due to the eh_thread
handling errors after the first reset, be sure we flag that the command
thread has been stopped to avoid an Oops of the form;

 [ 336.620256] CPU: 28 PID: 1193 Comm: scsi_eh_0 Kdump: loaded Not tainted 4.14.0-49.el7a.ppc64le #1
 [ 336.620297] task: c000003fd630b800 task.stack: c000003fd61a4000
 [ 336.620326] NIP: c000000000176794 LR: c00000000013038c CTR: c00000000024bc10
 [ 336.620361] REGS: c000003fd61a7720 TRAP: 0300 Not tainted (4.14.0-49.el7a.ppc64le)
 [ 336.620395] MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE> CR: 22084022 XER: 20040000
 [ 336.620435] CFAR: c000000000130388 DAR: 0000000000000000 DSISR: 40000000 SOFTE: 1
 [ 336.620435] GPR00: c00000000013038c c000003fd61a79a0 c0000000014c7e00 0000000000000000
 [ 336.620435] GPR04: 000000000000000c 000000000000000c 9000000000009033 0000000000000477
 [ 336.620435] GPR08: 0000000000000477 0000000000000000 0000000000000000 c008000010f7d940
 [ 336.620435] GPR12: c00000000024bc10 c000000007a33400 c0000000001708a8 c000003fe3b881d8
 [ 336.620435] GPR16: c000003fe3b88060 c000003fd61a7d10 fffffffffffff000 000000000000001e
 [ 336.620435] GPR20: 0000000000000001 c000000000ebf1a0 0000000000000001 c000003fe3b88000
 [ 336.620435] GPR24: 0000000000000003 0000000000000002 c000003fe3b88840 c000003fe3b887e8
 [ 336.620435] GPR28: c000003fe3b88000 c000003fc8181788 0000000000000000 c000003fc8181700
 [ 336.620750] NIP [c000000000176794] exit_creds+0x34/0x160
 [ 336.620775] LR [c00000000013038c] __put_task_struct+0x8c/0x1f0
 [ 336.620804] Call Trace:
 [ 336.620817] [c000003fd61a79a0] [c000003fe3b88000] 0xc000003fe3b88000 (unreliable)
 [ 336.620853] [c000003fd61a79d0] [c00000000013038c] __put_task_struct+0x8c/0x1f0
 [ 336.620889] [c000003fd61a7a00] [c000000000171418] kthread_stop+0x1e8/0x1f0
 [ 336.620922] [c000003fd61a7a40] [c008000010f7448c] aac_reset_adapter+0x14c/0x8d0 [aacraid]
 [ 336.620959] [c000003fd61a7b00] [c008000010f60174] aac_eh_host_reset+0x84/0x100 [aacraid]
 [ 336.621010] [c000003fd61a7b30] [c000000000864f24] scsi_try_host_reset+0x74/0x180
 [ 336.621046] [c000003fd61a7bb0] [c000000000867ac0] scsi_eh_ready_devs+0xc00/0x14d0
 [ 336.625165] [c000003fd61a7ca0] [c0000000008699e0] scsi_error_handler+0x550/0x730
 [ 336.632101] [c000003fd61a7dc0] [c000000000170a08] kthread+0x168/0x1b0
 [ 336.639031] [c000003fd61a7e30] [c00000000000b528] ret_from_kernel_thread+0x5c/0xb4
 [ 336.645971] Instruction dump:
 [ 336.648743] 384216a0 7c0802a6 fbe1fff8 f8010010 f821ffd1 7c7f1b78 60000000 60000000
 [ 336.657056] 39400000 e87f0838 f95f0838 7c0004ac <7d401828> 314affff 7d40192d 40c2fff4
 [ 336.663997] -[ end trace 4640cf8d4945ad95 ]-

So flag when the thread is stopped by setting the thread pointer to NULL.

Signed-off-by: Dave Carroll <david.carroll@microsemi.com>
Reviewed-by: Raghava Aditya Renukunta <raghavaaditya.renukunta@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/aacraid/commsup.c |    4 +++-
 drivers/scsi/aacraid/linit.c   |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1374,9 +1374,10 @@ static int _aac_reset_adapter(struct aac
 	host = aac->scsi_host_ptr;
 	scsi_block_requests(host);
 	aac_adapter_disable_int(aac);
-	if (aac->thread->pid != current->pid) {
+	if (aac->thread && aac->thread->pid != current->pid) {
 		spin_unlock_irq(host->host_lock);
 		kthread_stop(aac->thread);
+		aac->thread = NULL;
 		jafo = 1;
 	}
 
@@ -1445,6 +1446,7 @@ static int _aac_reset_adapter(struct aac
 					  aac->name);
 		if (IS_ERR(aac->thread)) {
 			retval = PTR_ERR(aac->thread);
+			aac->thread = NULL;
 			goto out;
 		}
 	}
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1083,6 +1083,7 @@ static void __aac_shutdown(struct aac_de
 				up(&fib->event_wait);
 		}
 		kthread_stop(aac->thread);
+		aac->thread = NULL;
 	}
 	aac_adapter_disable_int(aac);
 	cpu = cpumask_first(cpu_online_mask);
