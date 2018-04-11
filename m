Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481384-2-13625997707028936910
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
    1523481383; b=waMSNltH+0AOk+FdGZyBs/BLwAsq5uuosDDKF3WhJrAmcQc6Eq
    WqwX1EYNhAkNzpgJADoOa3VbbzzM6f/FQdfkVDDV1/y3lOcVx2AZwYdJFepxxvUb
    BfDev3aFI/+tdXP/gbOBb1QII28FgEqFBDs64DWiz6KqY74CeK9F17hBAR91Dy+3
    50MuFn3tkkteXXE0L+ufVhY5WVAC/HXfkWqkzB+L2rncjyXKWsw8Jx/3UEt9aM/U
    6AKtF+opOzJlLdddQueMuKBNO4w6MqXnHnqGlKVORHdTrbrMDlp3EwBd2ol2i7xy
    3Ho6i6PwmhbxDW3787mjclkY20/sUn3W42Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481383; bh=EFs4re9wmhPJopy6hvOGv+0G3zkHUS
    A+TOFDcOQU4QE=; b=OM7EueQK2eiNx4V52Ur7kwTq7Mwi2oVoxbqXm1CU1Ibven
    nWaqTIhsNFefQ8BbDSIJLCHFEd09Y1P1OAGd4g8LF4BqehX8wo1aM0oDdpfKqrQl
    cYfMpwkJhk+8NnVJoL/TUPXto41x3zGkUY4ArA0ZBE46tkLbyN7QQ6qwVcjC6A9t
    +E98jGng6eI4vowwQ2s4JAXIVFJr9+7aCi9Z5oBYkW+hujrKZ118uUMnHLWLzyp7
    py00iz7Ub/5pIj0YWpdJPFksZMpWAN+Q1FI7GVJL3vDVqnQcpxU+JZ5qeaO3kiO1
    9vxAs6cs1pJVGYXtOKGoarjAJpqcvZo3wms3wWPA==
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
X-CM-Envelope: MS4wfAkyZ332vk6SZmmi7SJyh8XIoRCv2f6JQdm/DUn0/Z9wBgYI1fZGijegUZWUaFf20hE44OELkX+5jX1cvB7NRhYJcEAvYqtT0046I6WQo0VzFVx83WVq
    OszBAgn50fLQLyyGY1hrZy2epWmIHJk8LCiNrN6V31fWSdaIiANqSfJ739IXFmG6WJZ6+rwe+BZr8NzaigTEWHXE4nLYJTX8dys6TnUMlPSfYSgR4m8tOGkU
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=6rqHouBjAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=FOH2dFAWAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=eKbnkA8_PierirrJJXEA:9 a=QEXdDO2ut3YA:10
    a=Hx1yvPaMooE3kwe23bt7:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=i3VuKzQdj-NEYjvDI-p3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbeDKSkm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:40:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56522 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754623AbeDKSkk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        Jens Axboe <axboe@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 066/121] bio-integrity: Do not allocate integrity context for bio w/o data
Date: Wed, 11 Apr 2018 20:36:09 +0200
Message-Id: <20180411183500.218573435@linuxfoundation.org>
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

From: Dmitry Monakhov <dmonakhov@openvz.org>


[ Upstream commit 3116a23bb30272d74ea81baf5d0ee23f602dd15b ]

If bio has no data, such as ones from blkdev_issue_flush(),
then we have nothing to protect.

This patch prevent bugon like follows:

kfree_debugcheck: out of range ptr ac1fa1d106742a5ah
kernel BUG at mm/slab.c:2773!
invalid opcode: 0000 [#1] SMP
Modules linked in: bcache
CPU: 0 PID: 4428 Comm: xfs_io Tainted: G        W       4.11.0-rc4-ext4-00041-g2ef0043-dirty #43
Hardware name: Virtuozzo KVM, BIOS seabios-1.7.5-11.vz7.4 04/01/2014
task: ffff880137786440 task.stack: ffffc90000ba8000
RIP: 0010:kfree_debugcheck+0x25/0x2a
RSP: 0018:ffffc90000babde0 EFLAGS: 00010082
RAX: 0000000000000034 RBX: ac1fa1d106742a5a RCX: 0000000000000007
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88013f3ccb40
RBP: ffffc90000babde8 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000fcb76420 R11: 00000000725172ed R12: 0000000000000282
R13: ffffffff8150e766 R14: ffff88013a145e00 R15: 0000000000000001
FS:  00007fb09384bf40(0000) GS:ffff88013f200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd0172f9e40 CR3: 0000000137fa9000 CR4: 00000000000006f0
Call Trace:
 kfree+0xc8/0x1b3
 bio_integrity_free+0xc3/0x16b
 bio_free+0x25/0x66
 bio_put+0x14/0x26
 blkdev_issue_flush+0x7a/0x85
 blkdev_fsync+0x35/0x42
 vfs_fsync_range+0x8e/0x9f
 vfs_fsync+0x1c/0x1e
 do_fsync+0x31/0x4a
 SyS_fsync+0x10/0x14
 entry_SYSCALL_64_fastpath+0x1f/0xc2

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/bio-integrity.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -165,6 +165,9 @@ bool bio_integrity_enabled(struct bio *b
 	if (!bio_is_rw(bio))
 		return false;
 
+	if (!bio_sectors(bio))
+		return false;
+
 	/* Already protected? */
 	if (bio_integrity(bio))
 		return false;
