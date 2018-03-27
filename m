Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-22565-1522168854-2-3454413811561011117
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
    t=1522168853; b=pHIyVCWZPUYLdS4t728YUlonvQDTGpgEghcCzAt6O1+8qu3
    zPwtnHcE99QuhJc9iQzOIbW5TE2Giw0QJYEriRHXsrLUt3IUaJ1SjLznDgr8iztU
    TypBqkSbZPQHBZ7bYg/MHw6awoKUblTfG8nm8qujCBXEi7owLwEL1eGQazOvpsj4
    RFLR1n+WkEnti5xZcqw4g8qbblLHEz1QEhzQ/mNYiXd/tFNfAK/FYXpdpq9f9s4R
    R7anYvv4DzjTcGcEyTI4jIhfE4pX59LIPbcaaMiakyBDcHz9Yav78wHNUJKOJNSF
    NRkzA7FwwLFfX9q2mPWWPydlOI7evMfK1xeGC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522168853; bh=tOI/K1WWQqYQ9JPffiHe6Prrm8
    p2QVXGgpRNu/YbkXE=; b=mubqmjA62vlF4iGBvr5o5URuCQ9bsn7niSeydgKWLb
    7YlO0WSUERcoar1tHqzQMMJIl84U3KvnZ29J/YfSPB9RVWtOQKODPIDGEl218wn4
    sxF/Am6faT6l1th/DMehksMkjZnWy0eAJRXIoNHWKIHPP8IAxrm+6xmD4BdtjT9U
    HHA84xhDI5BYHhGXxKg5Txf5ruh6VUXdGoon5Ejw9NSrffPRCBAzuFNp/sjgPMZj
    7TPzYoTJ+nqBYj/MljjFJROf8Pan3N8jon1RuPG53xzacy+ZGqb+m9TmmjTGJ1es
    R/C2jPNLGaGAj4toA5cH707cRBk12iKzUgrSGvZF7j5A==
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
X-CM-Envelope: MS4wfDMjdQxr5TvKA+RYggO7+URQYLPQPX7fDppOaM/jUxBdv2eaVg4NVyYKHzG9knZ1DmLFUjpc91KUXAQRR+PKYkFaL+EBYpNyWweMWYeeieCTZjv42XUs
    whoscRPxsWmXjSNOwuwRMpwfU9bZqLWLQwhNyjrheH6+qBrbVdRdPJoejM7+f5ZpoUAEaDmUdIgAVHa7TD9ZemajeTLP2skRE7w8Rg6r505i4DklVMDbxYbr
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=Wu67TXmGlbXehAlrRNsA:9 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755502AbeC0Qkt (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:40:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48382 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755308AbeC0Qks (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:40:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+2f69ca28df61bdfc77cd36af2e789850355a221e@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.15 036/105] libata: dont try to pass through NCQ commands to non-NCQ devices
Date: Tue, 27 Mar 2018 18:27:16 +0200
Message-Id: <20180327162759.541155346@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 2c1ec6fda2d07044cda922ee25337cf5d4b429b3 upstream.

syzkaller hit a WARN() in ata_bmdma_qc_issue() when writing to /dev/sg0.
This happened because it issued an ATA pass-through command (ATA_16)
where the protocol field indicated that NCQ should be used -- but the
device did not support NCQ.

We could just remove the WARN() from libata-sff.c, but the real problem
seems to be that the SCSI -> ATA translation code passes through NCQ
commands without verifying that the device actually supports NCQ.

Fix this by adding the appropriate check to ata_scsi_pass_thru().

Here's reproducer that works in QEMU when /dev/sg0 refers to a disk of
the default type ("82371SB PIIX3 IDE"):

    #include <fcntl.h>
    #include <unistd.h>

    int main()
    {
            char buf[53] = { 0 };

	    buf[36] = 0x85;		/* ATA_16 */
	    buf[37] = (12 << 1);	/* FPDMA */
	    buf[38] = 0x1;		/* Has data */
	    buf[51] = 0xC8;		/* ATA_CMD_READ */
            write(open("/dev/sg0", O_RDWR), buf, sizeof(buf));
    }

Fixes: ee7fb331c3ac ("libata: add support for NCQ commands for SG interface")
Reported-by: syzbot+2f69ca28df61bdfc77cd36af2e789850355a221e@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-scsi.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3316,6 +3316,12 @@ static unsigned int ata_scsi_pass_thru(s
 		goto invalid_fld;
 	}
 
+	/* We may not issue NCQ commands to devices not supporting NCQ */
+	if (ata_is_ncq(tf->protocol) && !ata_ncq_enabled(dev)) {
+		fp = 1;
+		goto invalid_fld;
+	}
+
 	/* sanity check for pio multi commands */
 	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf)) {
 		fp = 1;
