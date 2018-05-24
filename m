Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161815-2-4202134659084175759
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161815; b=JLLnD3FMQ7oQeuL3jFlEH2VsM3mPAzzhdREwOxu7g5D4IahW53
    tnUI3p3GQpUFOZ/U7SQhPKGQfBLNYRM+yLrWV+UrjB5UNIOyPIMz257WQ/YHNFHL
    ECieSMNsuU4cFvpLn2pdntL4IAFYvqN24mljwEIXhbTIhgsSX5htZ+0xulBetFWN
    Gw5Ah2CVVpz3TxF5MQkBRTHV0OMU5gWwPTEuF6i+zjhFns9Q07gpM0LtQ+X3KYtA
    rPA2pdUW3Qlwxe0car8c9JVS4B/hHmqL8NlfRm38BLvsgPCfUY7khVBylpstIQE+
    HqhLs21ZGqEko1kkvpkVZ0jixHrBkXYMBHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161815; bh=Zv+sVwY8qvcaLqcLUQRV3+sWPMzRio
    rFUS/eoQ3Ij6A=; b=ERqg8/juD5WPHkNzIXRFJRLlt/OomSrdNQM2NePzeYvy2s
    bVBO8EYZh5KQ+BxPeJg3OrW9KN+SyPI8kl9ZX045lAkRwd7S97QVbiwr1ZfYuLZi
    05vbkITlTWS1MCIZtq5/9v+UKAkcYk/o1TUweYsq/RLLcW5OxA3D8Qp9EQE2Llyf
    XV72MAo3wiqf1DBCdiXEO6HIKEAypX9Pp5geI5m27BpKFSihye3Px6jatDMWhnRH
    PUW0uvOIeMc8Cq9zNwzbE8YjrbDDFID07HMzwAdQuHZ3psA1QkCoBBrqaMNRfdYG
    u1gZnCNbno7HBy5yNPhRfcBs9mnyoC4CwWtzhGGQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=S5GrSDsc x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=S5GrSDsc x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGZ4POCaJGrDgqCU8aRhHXP4Ck9wjbJdVqms93S7LHqjhqCmwta7P3IrvO6PTJvSi+AwSs5r250XA4NYDuD2gBBOJh6uHT+AbDmkXMsEpdyxARPHEyhy
    F8Qv8ZuEnnib4suqAFbmxhzIcfwRwMUgh84LoqKwwrEcahNNjRH2DbG1BErCxC6aClBsNAgvOlWg3+SjTbSdVl3EATNuS+BNQlFb6YUtH1gnn6W60fBfd3df
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=BaJfaVqg3fX9Kt3YGFIA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967104AbeEXJtk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967093AbeEXJtg (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dominik Bozek <dominikx.bozek@intel.com>,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 30/96] usb: cdc_acm: prevent race at write to acm while system resumes
Date: Thu, 24 May 2018 11:38:13 +0200
Message-Id: <20180524093607.272458772@linuxfoundation.org>
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

From: Dominik Bozek <dominikx.bozek@intel.com>

[ Upstream commit b86b8eb6fecb5a4bac1ed0ca925c4082a61ea6e9 ]

ACM driver may accept data to transmit while system is not fully
resumed. In this case ACM driver buffers data and prepare URBs
on usb anchor list.
There is a little chance that two tasks put a char and initiate
acm_tty_flush_chars(). In such a case, driver will put one URB
twice on usb anchor list.
This patch also reset length of data before resue of a buffer.
This not only prevent sending rubbish, but also lower risc of race.

Without this patch we hit following kernel panic in one of our
stabilty/stress tests.

[   46.884442] *list_add double add*: new=ffff9b2ab7289330, prev=ffff9b2ab7289330, next=ffff9b2ab81e28e0.
[   46.884476] Modules linked in: hci_uart btbcm bluetooth rfkill_gpio igb_avb(O) cfg80211 snd_soc_sst_bxt_tdf8532 snd_soc_skl snd_soc_skl_ipc snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_sst_acpi snd_soc_sst_match snd_hda_ext_core snd_hda_core trusty_timer trusty_wall trusty_log trusty_virtio trusty_ipc trusty_mem trusty_irq trusty virtio_ring virtio intel_ipu4_mmu_bxtB0 lib2600_mod_bxtB0 intel_ipu4_isys_mod_bxtB0 lib2600psys_mod_bxtB0 intel_ipu4_psys_mod_bxtB0 intel_ipu4_mod_bxtB0 intel_ipu4_wrapper_bxtB0 intel_ipu4_acpi videobuf2_dma_contig as3638 dw9714 lm3643 crlmodule smiapp smiapp_pll
[   46.884480] CPU: 1 PID: 33 Comm: kworker/u8:1 Tainted: G     U  W  O    4.9.56-quilt-2e5dc0ac-g618ed69ced6e-dirty #4
[   46.884489] Workqueue: events_unbound flush_to_ldisc
[   46.884494]  ffffb98ac012bb08 ffffffffad3e82e5 ffffb98ac012bb58 0000000000000000
[   46.884497]  ffffb98ac012bb48 ffffffffad0a23d1 00000024ad6374dd ffff9b2ab7289330
[   46.884500]  ffff9b2ab81e28e0 ffff9b2ab7289330 0000000000000002 0000000000000000
[   46.884501] Call Trace:
[   46.884507]  [<ffffffffad3e82e5>] dump_stack+0x67/0x92
[   46.884511]  [<ffffffffad0a23d1>] __warn+0xd1/0xf0
[   46.884513]  [<ffffffffad0a244f>] warn_slowpath_fmt+0x5f/0x80
[   46.884516]  [<ffffffffad407443>] __list_add+0xb3/0xc0
[   46.884521]  [<ffffffffad71133c>] *usb_anchor_urb*+0x4c/0xa0
[   46.884524]  [<ffffffffad782c6f>] *acm_tty_flush_chars*+0x8f/0xb0
[   46.884527]  [<ffffffffad782cd1>] *acm_tty_put_char*+0x41/0x100
[   46.884530]  [<ffffffffad4ced34>] tty_put_char+0x24/0x40
[   46.884533]  [<ffffffffad4d3bf5>] do_output_char+0xa5/0x200
[   46.884535]  [<ffffffffad4d3e98>] __process_echoes+0x148/0x290
[   46.884538]  [<ffffffffad4d654c>] n_tty_receive_buf_common+0x57c/0xb00
[   46.884541]  [<ffffffffad4d6ae4>] n_tty_receive_buf2+0x14/0x20
[   46.884543]  [<ffffffffad4d9662>] tty_ldisc_receive_buf+0x22/0x50
[   46.884545]  [<ffffffffad4d9c05>] flush_to_ldisc+0xc5/0xe0
[   46.884549]  [<ffffffffad0bcfe8>] process_one_work+0x148/0x440
[   46.884551]  [<ffffffffad0bdc19>] worker_thread+0x69/0x4a0
[   46.884554]  [<ffffffffad0bdbb0>] ? max_active_store+0x80/0x80
[   46.884556]  [<ffffffffad0c2e10>] kthread+0x110/0x130
[   46.884559]  [<ffffffffad0c2d00>] ? kthread_park+0x60/0x60
[   46.884563]  [<ffffffffadad9917>] ret_from_fork+0x27/0x40
[   46.884566] ---[ end trace 3bd599058b8a9eb3 ]---

Signed-off-by: Dominik Bozek <dominikx.bozek@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/cdc-acm.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -174,6 +174,7 @@ static int acm_wb_alloc(struct acm *acm)
 		wb = &acm->wb[wbn];
 		if (!wb->use) {
 			wb->use = 1;
+			wb->len = 0;
 			return wbn;
 		}
 		wbn = (wbn + 1) % ACM_NW;
@@ -731,16 +732,18 @@ static int acm_tty_write(struct tty_stru
 static void acm_tty_flush_chars(struct tty_struct *tty)
 {
 	struct acm *acm = tty->driver_data;
-	struct acm_wb *cur = acm->putbuffer;
+	struct acm_wb *cur;
 	int err;
 	unsigned long flags;
 
+	spin_lock_irqsave(&acm->write_lock, flags);
+
+	cur = acm->putbuffer;
 	if (!cur) /* nothing to do */
-		return;
+		goto out;
 
 	acm->putbuffer = NULL;
 	err = usb_autopm_get_interface_async(acm->control);
-	spin_lock_irqsave(&acm->write_lock, flags);
 	if (err < 0) {
 		cur->use = 0;
 		acm->putbuffer = cur;
