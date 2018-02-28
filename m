Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519833592-2-6917947652029061151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833591; b=ikhCIjG8Ylcku+LTGmhy8Cl/t4xCiuYrhLhDTj83F+gzNHe
    2YcOel6GzZp7/n28+sHFKGp0Cz6nBadcjZ8rV5Cozjl3YiE7H1T/VU1CEknURM8n
    HSAP3zb3PRIa+B4iebKMPM1TeCsFSck0TAVwQOXI49YUNF7EetgFy82x4u0SP/zk
    LMmyB87wy3HhicpuY4+CphQwz8PRxpGHaH/W27vbCVHZ9YNIcUjxf8iEo8W63vdh
    lrr6TYEZFoVE6E/7unPYEQby4OLOUvfaSpD7ayWeajSCbygcboibQnekBr34gl+I
    3g4CNurb+N9IBOX0Rsjc+c9IQwg8d6V79VoUctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833591; bh=tyIPU0GNxmfLVCOyy0+
    O6onixUyrNk7PqYOe9gqZOQE=; b=jpq1c03+ojQj3Pr/shyvAUpdvWjAwjI3ILh
    I/SJg+M3t9d4j/CwlXsE2SiT72pm3hYLMObiHAemBq4UbHVzRH6XMcUyd2gVItFn
    4QzljQch9/qG3a8hzhVzxX4Wf5aViAlj9pkK0eE/nG+ytCi11dB1DuT9RQmapcC3
    ZnhodH1R7ijXJDhSuoDQ8eXLVTdHxjVaDcRog07dba9Ke6hHm63rzJ/+LfgJhgYe
    qQPLS+Nkkn/p6yttyooeaT6plB/IX4ODl1HE44EQlZsQkSFRqfYh+SfquhflsrWi
    QYR4bQ8QLzGpEAhvHwPM4oK6KeBHlg5eu40u8+ihPRdoyMLpjjA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933810AbeB1P7Q (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:59:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34611 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934361AbeB1P7O (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:59:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Guenter Roeck" <linux@roeck-us.net>,
        "Guenter Roeck" <groeck@google.com>,
        "Fan Ning" <fanning4@hisilicon.com>,
        "yangdi" <yangdi10@hisilicon.com>,
        "Li Rui" <lirui39@hisilicon.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Yu Chen" <chenyu56@huawei.com>,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>,
        "Guenter Roeck" <groeck@chromium.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.381332768@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 047/254] usb: xhci: fix panic in xhci_free_virt_devices_depth_first
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Chen <chenyu56@huawei.com>

commit 80e457699a8dbdd70f2d26911e46f538645c55fc upstream.

Check vdev->real_port 0 to avoid panic
[    9.261347] [<ffffff800884a390>] xhci_free_virt_devices_depth_first+0x58/0x108
[    9.261352] [<ffffff800884a814>] xhci_mem_cleanup+0x1bc/0x570
[    9.261355] [<ffffff8008842de8>] xhci_stop+0x140/0x1c8
[    9.261365] [<ffffff80087ed304>] usb_remove_hcd+0xfc/0x1d0
[    9.261369] [<ffffff80088551c4>] xhci_plat_remove+0x6c/0xa8
[    9.261377] [<ffffff80086e928c>] platform_drv_remove+0x2c/0x70
[    9.261384] [<ffffff80086e6ea0>] __device_release_driver+0x80/0x108
[    9.261387] [<ffffff80086e7a1c>] device_release_driver+0x2c/0x40
[    9.261392] [<ffffff80086e5f28>] bus_remove_device+0xe0/0x120
[    9.261396] [<ffffff80086e2e34>] device_del+0x114/0x210
[    9.261399] [<ffffff80086e9e00>] platform_device_del+0x30/0xa0
[    9.261403] [<ffffff8008810bdc>] dwc3_otg_work+0x204/0x488
[    9.261407] [<ffffff80088133fc>] event_work+0x304/0x5b8
[    9.261414] [<ffffff80080e31b0>] process_one_work+0x148/0x490
[    9.261417] [<ffffff80080e3548>] worker_thread+0x50/0x4a0
[    9.261421] [<ffffff80080e9ea0>] kthread+0xe8/0x100
[    9.261427] [<ffffff8008083680>] ret_from_fork+0x10/0x50

The problem can occur if xhci_plat_remove() is called shortly after
xhci_plat_probe(). While xhci_free_virt_devices_depth_first been
called before the device has been setup and get real_port initialized.
The problem occurred on Hikey960 and was reproduced by Guenter Roeck
on Kevin with chromeos-4.4.

Fixes: ee8665e28e8d ("xhci: free xhci virtual devices with leaf nodes first")
Cc: Guenter Roeck <groeck@google.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Fan Ning <fanning4@hisilicon.com>
Signed-off-by: Li Rui <lirui39@hisilicon.com>
Signed-off-by: yangdi <yangdi10@hisilicon.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/host/xhci-mem.c | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -982,6 +982,12 @@ void xhci_free_virt_devices_depth_first(
 	if (!vdev)
 		return;
 
+	if (vdev->real_port == 0 ||
+			vdev->real_port > HCS_MAX_PORTS(xhci->hcs_params1)) {
+		xhci_dbg(xhci, "Bad vdev->real_port.\n");
+		goto out;
+	}
+
 	tt_list_head = &(xhci->rh_bw[vdev->real_port - 1].tts);
 	list_for_each_entry_safe(tt_info, next, tt_list_head, tt_list) {
 		/* is this a hub device that added a tt_info to the tts list */
@@ -995,6 +1001,7 @@ void xhci_free_virt_devices_depth_first(
 			}
 		}
 	}
+out:
 	/* we are now at a leaf device */
 	xhci_free_virt_device(xhci, slot_id);
 }
