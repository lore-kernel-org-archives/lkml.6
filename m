Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4170472-1522168308-2-15943272274024674005
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522168308; b=dgdPmnnO5D/cgFH+6IQYWBc7t6KqnYwpOYpnffL9iU9MySy
    AYTtTlDNcVl/QigDf36glJ3+VXKDBu8Y1MTRyVT1qxDVjNiQucR5CEbFNFvAZ5TU
    /hzo9hfCf+L52rE8JcsaptbsrjZ4RCMVRceiSEx2G14phFv78Gbb95t6LzhprgXN
    EDbmVlQ/CKjfmPzgEvqq3UG9T1HQdIHt58n7UXQds1L0/0PRpi2VyuZF3T3YRIwl
    vy9GQEPqb962k89raYgD+yaf6dYncv9v9HsbSmOXCaXjCLCjEDebH/a6hvfjaaYc
    krMQX4kP8hbnYbZ2X4PDmHaSo7/dCfC2EH8NgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522168308; bh=Owr1zWCxAEq4f8kOo6Vr7Tq3Yq
    hvKTp6/MtIuNWfxXE=; b=NFYd38RERRaRAUwCXxnz8AAHTeF361Pz15wveqEeFz
    s0JDP2Yxww3uBKkOG2ST1bt7AGMiuRCSXEatEGdRhDAHbGMDMbHyslgUQdVr4z8N
    14OaRuoVP2boRPzPVWBBc5blGu1dEbmXkx7UDmfezNSr8gr+JZ5ob+efTdLEXxXS
    GxN8XBaknP90xzwCjrsqx/szIouotoroFL49/y9h7z45iFQTP98wBD8Bm8jOTfXR
    BtwcvL7ZpqVEN15Tcb/iWgIvynZqwFKcYMYceHNjgb7Hiv0x3UutehYkCBfYVQcn
    v0CcdlMFIx+QHR+6dYiyBDlnTVqZpHuiNnirYLFM0n4A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfEQ/EvyTvDvtGfCxoLpjCh/VfclwAbnvT+r6oCqApvhuExqClBBxLEQbLx/sB9XHMtJvcp2Uzl3aBT6gVJMUHmyTD/Fh//7JcIjL3/kxfO3r6W5+hlD7
    nsN3vLbQhB0KEHpQurBZ3haxqRaNfnDZeBkN0vJS7Epylp6A0wE8w14vFU09GflcPuFPZvDF6kLSPflRzQ3QZzU+Uy2dp1PmI8JJIiCQNIJYf6027rRJ05Y2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=fNAmQFtE6RKuwFAVZa8A:9 a=mUN646lUQuh35fXH:21 a=19K3xS8a7fPaSGWn:21
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbeC0Qbp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:31:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43062 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeC0Qbo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:31:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+1ff6f9fcc3c35f1c72a95e26528c8e7e3276e4da@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.9 14/67] libata: fix length validation of ATAPI-relayed SCSI commands
Date: Tue, 27 Mar 2018 18:27:06 +0200
Message-Id: <20180327162727.479449745@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>

commit 058f58e235cbe03e923b30ea7c49995a46a8725f upstream.

syzkaller reported a crash in ata_bmdma_fill_sg() when writing to
/dev/sg1.  The immediate cause was that the ATA command's scatterlist
was not DMA-mapped, which causes 'pi - 1' to underflow, resulting in a
write to 'qc->ap->bmdma_prd[0xffffffff]'.

Strangely though, the flag ATA_QCFLAG_DMAMAP was set in qc->flags.  The
root cause is that when __ata_scsi_queuecmd() is preparing to relay a
SCSI command to an ATAPI device, it doesn't correctly validate the CDB
length before copying it into the 16-byte buffer 'cdb' in 'struct
ata_queued_cmd'.  Namely, it validates the fixed CDB length expected
based on the SCSI opcode but not the actual CDB length, which can be
larger due to the use of the SG_NEXT_CMD_LEN ioctl.  Since 'flags' is
the next member in ata_queued_cmd, a buffer overflow corrupts it.

Fix it by requiring that the actual CDB length be <= 16 (ATAPI_CDB_LEN).

[Really it seems the length should be required to be <= dev->cdb_len,
but the current behavior seems to have been intentionally introduced by
commit 607126c2a21c ("libata-scsi: be tolerant of 12-byte ATAPI commands
in 16-byte CDBs") to work around a userspace bug in mplayer.  Probably
the workaround is no longer needed (mplayer was fixed in 2007), but
continuing to allow lengths to up 16 appears harmless for now.]

Here's a reproducer that works in QEMU when /dev/sg1 refers to the
CD-ROM drive that qemu-system-x86_64 creates by default:

    #include <fcntl.h>
    #include <sys/ioctl.h>
    #include <unistd.h>

    #define SG_NEXT_CMD_LEN 0x2283

    int main()
    {
	    char buf[53] = { [36] = 0x7e, [52] = 0x02 };
	    int fd = open("/dev/sg1", O_RDWR);
	    ioctl(fd, SG_NEXT_CMD_LEN, &(int){ 17 });
	    write(fd, buf, sizeof(buf));
    }

The crash was:

    BUG: unable to handle kernel paging request at ffff8cb97db37ffc
    IP: ata_bmdma_fill_sg drivers/ata/libata-sff.c:2623 [inline]
    IP: ata_bmdma_qc_prep+0xa4/0xc0 drivers/ata/libata-sff.c:2727
    PGD fb6c067 P4D fb6c067 PUD 0
    Oops: 0002 [#1] SMP
    CPU: 1 PID: 150 Comm: syz_ata_bmdma_q Not tainted 4.15.0-next-20180202 #99
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
    [...]
    Call Trace:
     ata_qc_issue+0x100/0x1d0 drivers/ata/libata-core.c:5421
     ata_scsi_translate+0xc9/0x1a0 drivers/ata/libata-scsi.c:2024
     __ata_scsi_queuecmd drivers/ata/libata-scsi.c:4326 [inline]
     ata_scsi_queuecmd+0x8c/0x210 drivers/ata/libata-scsi.c:4375
     scsi_dispatch_cmd+0xa2/0xe0 drivers/scsi/scsi_lib.c:1727
     scsi_request_fn+0x24c/0x530 drivers/scsi/scsi_lib.c:1865
     __blk_run_queue_uncond block/blk-core.c:412 [inline]
     __blk_run_queue+0x3a/0x60 block/blk-core.c:432
     blk_execute_rq_nowait+0x93/0xc0 block/blk-exec.c:78
     sg_common_write.isra.7+0x272/0x5a0 drivers/scsi/sg.c:806
     sg_write+0x1ef/0x340 drivers/scsi/sg.c:677
     __vfs_write+0x31/0x160 fs/read_write.c:480
     vfs_write+0xa7/0x160 fs/read_write.c:544
     SYSC_write fs/read_write.c:589 [inline]
     SyS_write+0x4d/0xc0 fs/read_write.c:581
     do_syscall_64+0x5e/0x110 arch/x86/entry/common.c:287
     entry_SYSCALL_64_after_hwframe+0x21/0x86

Fixes: 607126c2a21c ("libata-scsi: be tolerant of 12-byte ATAPI commands in 16-byte CDBs")
Reported-by: syzbot+1ff6f9fcc3c35f1c72a95e26528c8e7e3276e4da@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org> # v2.6.24+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-scsi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4177,7 +4177,9 @@ static inline int __ata_scsi_queuecmd(st
 		if (likely((scsi_op != ATA_16) || !atapi_passthru16)) {
 			/* relay SCSI command to ATAPI device */
 			int len = COMMAND_SIZE(scsi_op);
-			if (unlikely(len > scmd->cmd_len || len > dev->cdb_len))
+			if (unlikely(len > scmd->cmd_len ||
+				     len > dev->cdb_len ||
+				     scmd->cmd_len > ATAPI_CDB_LEN))
 				goto bad_cdb_len;
 
 			xlat_func = atapi_xlat;
