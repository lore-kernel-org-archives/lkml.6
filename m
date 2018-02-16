Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3360196-1518758887-2-16793079120474052412
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518758886; b=qG97XiWqJIQ326Mw57azomoUbqoHgdcQmxXClWSf3N3VkCR
    A8EGDAhhq5UBH7Ev5n743Cs1MUELFwaboOijb8LYrFgGVHyXjgktm2xZQWcodR6l
    EZXV4MeFCDaHF9Ki0t7RzDrPK7Qq9ViGmNm949uUN12MBfc23qonNIN63wmkTUn+
    E9s7Td9zXzfMfGxR+HJ27hNipkZijQojtvAaozNSp9el35e3DRK+qst3tbV0ILRa
    44QDNJfx9p5aGp9FuQncLWeSKRI0iJMDIb8QWzAo84k+wcqtVe/rmjdltTOUejbX
    Neeq/5pyJVz876ylYgI6WIeSPnwm/KvqgAlf9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518758886; bh=N5hK53b6FsrZDeMcE8MYxCTV6K
    pIm8XNwFwAnlLxCB4=; b=mIS5ZoqjcpuUeCKny+hnZc/aUhGh1LShCug5U0xIEr
    BHYPPKD4bk4k56l4t8PrvIVmYesHaerzSqtS17i4yNCdDIbwd19Z8rqk9J10yQT7
    OmFHjz4Pv71ZiQtDpdjXrC0kmThwdXOVgUW5+nElRbh7mdot0GWI7YsKHygNDvJP
    VL/F4VfuiJi3r2Oejp/RlW+EMYfnaS8ClKjNUZro0WVY2Uzvo4F6ET4f8+rW9zEG
    4EMZqeKpLqj+Yy6GAtL/lEBKKBbI1SYVRk+qW16LhyBPNXX8PqEhG7aporQsMKa9
    Fj7qhFwt7pNQDdOHU1+t9ul9VvN2dyn+/AO/VHWLzyMA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeBPF1t (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 00:27:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:1923 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbeBPF1s (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 16 Feb 2018 00:27:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="175771844"
From: sathyanarayanan.kuppuswamy@linux.intel.com
To: gregkh@linuxfoundation.org, oneukum@suse.com,
        felipe.balbi@intel.com, heikki.krogerus@intel.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominik Bozek <dominikx.bozek@intel.com>,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v2 1/1] usb: cdc_acm: prevent race at write to acm while system resumes
Date: Thu, 15 Feb 2018 21:27:48 -0800
Message-Id: <112e7d95e73a6c8e64e345a0e8d7b0e6bf149935.1518741722.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dominik Bozek <dominikx.bozek@intel.com>

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
---
 drivers/usb/class/cdc-acm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 06b3b54..7b366a6 100644
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
@@ -805,16 +806,18 @@ static int acm_tty_write(struct tty_struct *tty,
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
-- 
2.7.4

