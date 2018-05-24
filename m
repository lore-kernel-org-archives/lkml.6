Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527159435-2-2486622024012982475
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
    1527159434; b=fW/DPCkh+wtmwo0OAhZGlj9vP821jP61TGK7HA4fmBV4ikP+Nj
    fuP8/pcv9JxfBZJaaNpzqIAZff1ZSF2faUMyegn1hAHimtKP/tcVyqJKmVDChB11
    bHnTk0MI3bwtyPAh1cs+lWaJg2gVcubgwcChEdt7vb6REfJ9ALXm4Mzr0pIg6FXU
    m8FaNUI/XCn6ijC6bYA57HIK9i0MwtEEwE5Em7h4KRufGwfGT/8trJmpSn+/hDc+
    EJES2n28JM03mUbdrvtuMCN/Xj4Tb6g4ujMMOqick2ucpXTdxTK0u5Q8HKH4yM6L
    0SyJLBLKiBv5Zj31uT+85N1KicA1FJPMjGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159434; bh=c5AA2PI6zYK1jT0AZabUsCZvoPHO48
    0/7iDTyweHNxU=; b=NDkLpjJ7Qx423cEgWobkUrR99ntD09UjRRUwCw44GUOSIt
    iFPOAWL0uqyP9yyKsYyoxMhyoXtTuTscy0xWA8MHs80dfQSIti+abd18NLG/Gx87
    6MAh9PV8DSlSL9MoDLqTC38em+DZA/HCBqRrlWpSG3IowyfhZMu3TrbqCzxf/GcU
    82pYlQLhKAiqiZXYEFrhix/R1hGrPrG2WAf1n/fLzz+gJLOlixBdryYuRZvG+mH1
    AAQxG3u70TVh7Qp1i6Me5n1IYHACXVyh2LQZzc03VgokP38GJHS8Pq6KMFj2riiA
    ZJRLuQ61oFWR8CFHBADKQNEBTpx47Ut2dbywX+9Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=N/VXf+Id x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=N/VXf+Id x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfNX6Ibg1S8c4x0CGZ/vaA61J5DZO3ezsNxYbFIF+Dgv/VNS07YTcVcfyELdNx5I0Q2BDhy4ii8W39agLnOkruAXK69HSN4L6Ia1ivLz/P+oGwyYgJsCg
    zvf9B9hTXx5R8yJDZ/hLYJApM89Wz8/lEF0OioQunm5FMgZ9qYl9k34iAxN/Er/9dmSvpuYC89+U60Gd9cN0+brix+RjL/zb2dCSrE7ZA59nQ4dSJknuiBd9
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=zAyngx5bAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=zj8qez6UZ4e0oZhRU_AA:9 a=QEXdDO2ut3YA:10 a=4LA4qAFo6bo561LpWNDU:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030284AbeEXJ4S (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030277AbeEXJ4Q (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manish Rangankar <manish.rangankar@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 111/165] scsi: qedi: Fix kernel crash during port toggle
Date: Thu, 24 May 2018 11:38:37 +0200
Message-Id: <20180524093626.511889842@linuxfoundation.org>
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

From: Manish Rangankar <manish.rangankar@cavium.com>

[ Upstream commit 967823d6c3980a30e214b92bfe6a101e7b46d025 ]

BUG: unable to handle kernel NULL pointer dereference at 0000000000000100

[  985.596918] IP: _raw_spin_lock_bh+0x17/0x30
[  985.601581] PGD 0 P4D 0
[  985.604405] Oops: 0002 [#1] SMP
:
[  985.704533] CPU: 16 PID: 1156 Comm: qedi_thread/16 Not tainted 4.16.0-rc2 #1
[  985.712397] Hardware name: Dell Inc. PowerEdge R730/0599V5, BIOS 2.4.3 01/17/2017
[  985.720747] RIP: 0010:_raw_spin_lock_bh+0x17/0x30
[  985.725996] RSP: 0018:ffffa4b1c43d3e10 EFLAGS: 00010246
[  985.731823] RAX: 0000000000000000 RBX: ffff94a31bd03000 RCX: 0000000000000000
[  985.739783] RDX: 0000000000000001 RSI: ffff94a32fa16938 RDI: 0000000000000100
[  985.747744] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000a33
[  985.755703] R10: 0000000000000000 R11: ffffa4b1c43d3af0 R12: 0000000000000000
[  985.763662] R13: ffff94a301f40818 R14: 0000000000000000 R15: 000000000000000c
[  985.771622] FS:  0000000000000000(0000) GS:ffff94a32fa00000(0000) knlGS:0000000000000000
[  985.780649] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  985.787057] CR2: 0000000000000100 CR3: 000000067a009006 CR4: 00000000001606e0
[  985.795017] Call Trace:
[  985.797747]  qedi_fp_process_cqes+0x258/0x980 [qedi]
[  985.803294]  qedi_percpu_io_thread+0x10f/0x1b0 [qedi]
[  985.808931]  kthread+0xf5/0x130
[  985.812434]  ? qedi_free_uio+0xd0/0xd0 [qedi]
[  985.817298]  ? kthread_bind+0x10/0x10
[  985.821372]  ? do_syscall_64+0x6e/0x1a0

Signed-off-by: Manish Rangankar <manish.rangankar@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qedi/qedi_fw.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/scsi/qedi/qedi_fw.c
+++ b/drivers/scsi/qedi/qedi_fw.c
@@ -769,6 +769,11 @@ static void qedi_process_cmd_cleanup_res
 
 	iscsi_cid = cqe->conn_id;
 	qedi_conn = qedi->cid_que.conn_cid_tbl[iscsi_cid];
+	if (!qedi_conn) {
+		QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_INFO,
+			  "icid not found 0x%x\n", cqe->conn_id);
+		return;
+	}
 
 	/* Based on this itt get the corresponding qedi_cmd */
 	spin_lock_bh(&qedi_conn->tmf_work_lock);
