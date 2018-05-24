Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155649-2-4781988215644515749
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
    1527155649; b=YPOLNAkbfDdpfin48kgHA3Il+BV/Me7AoqFrvLZcQ3zZ+6IZXY
    Tb7V7+xAAw4M9IVJMtA1eliwhq+oPNDxQG0JrQN9uWws+V918tj7DUWLgjZIFx38
    2dX/Bw2OsJmo+dvkS27vOW0RMVfgRD4xjRnyBL5QFuuKbJO+0yE6IPdQPbRd1Wyr
    93qO/wKUVQ1+/JoEGxc6b7Sp4tQbbwE5AhL3u4ovg/v4xToyyG1Z97TD5Cae48ee
    HYj4mxKy0/aDTAax4Wzj9y+V/fSZdz/Y/xTpPAK/kQbb4VjbqPbzj0Mv6YI6mZq2
    ycdWSQkqjAqut/WGrI9pPv1DwUIYjcE3GlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155649; bh=/gGmirxjTDbbkyJCjMAP8nszjnig9N
    Mdl0k7u4SyavM=; b=JZUpiVLZVtSmocaXZb4GPjIA26drMtiIKlWimwp2ioDApN
    yE5g70er4k7diFKe1tsfLy/kfQc1y4obKid51n6HpHB6sTsjLs/tyrHhQxav8Oyt
    2VCXOMeo9MpGVK1tfLT4hNWH1B9KCPFtUQmln479QQ4fCETWyHUsfiqU7h/T3rx8
    Ca427VJEOTAY9HgxvdkjagYRYqS0JF0hxkGb50A9Mm6UpR7Cb4dSYs1vO9//ZfGC
    x0nM5tQ1zzGr1xZY1aikFZW1iUDRGuliwCn+/IpCRh4CozpPGiaoXbiWbIFT6JvZ
    GOSsuB6AjTOYzITPjc/lzPUFv74EKbO+G57NrL+w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=B9el9k+u x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=B9el9k+u x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCOpCxL9WoGiOsD5lelXf3EoXEYyRWqfENoMLcGamlK8kRk7AvgPfRmPFOq3zCxuZaPLcST5mkVjxWbhe9U2arm9BBVdLknyVlX8T7BIcyNp298ExqNr
    2Bz0KRDIbY61wklcVu8GoMiu3/4jKbtgOI7ielatEF+4dpzAZXi8YPkCp/p+2EbNLhsDb3g1K0HS3TlXNH2Ov3Fxy6eiBTo22QdQ3qqQfHXLPj7v9zGxX9BR
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=BaJfaVqg3fX9Kt3YGFIA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968088AbeEXJyB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:32918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966770AbeEXJxx (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:53:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dominik Bozek <dominikx.bozek@intel.com>,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 060/165] usb: cdc_acm: prevent race at write to acm while system resumes
Date: Thu, 24 May 2018 11:37:46 +0200
Message-Id: <20180524093624.443683603@linuxfoundation.org>
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
@@ -187,6 +187,7 @@ static int acm_wb_alloc(struct acm *acm)
 		wb = &acm->wb[wbn];
 		if (!wb->use) {
 			wb->use = 1;
+			wb->len = 0;
 			return wbn;
 		}
 		wbn = (wbn + 1) % ACM_NW;
@@ -818,16 +819,18 @@ static int acm_tty_write(struct tty_stru
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
