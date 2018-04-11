Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523481209-2-11416788669141220870
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
    1523481208; b=htLhrUQsBde1O/8ztbypDJqrX9Nml7PUwAtzXYPw9SjMvKkOlp
    WpWAQwggSXXj1l9YWTeP+QbroOB/EhvIs6fEqO4OLsBGmwQ6TQvuzj1KSoM4tiv/
    4g0mSshiT5Vfojh26VgQ4uKqPg5B+mAWdIZdVV0RTT/9lrnPNhoJKxPn/OLr0KRh
    SfcB96XNRp59EV54wTP+wYdTjHpea2qViQ1a7foK74J9pBdroE50VzV4w5YRwC6k
    o7aMRJrdqaaayDm/Y6CSyTpEAIlXzWtfOJ7HL5NceJPALf8+2/Cn/fvoGZwtech8
    NOQzq+u8LVgEV09cxL8nsurQt6QIXjNaTm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481208; bh=LwrSDsU43rsy3zatc4loTYYoeYmvXx
    wM+eUBRZtagkI=; b=PrJ5eYz02XJon1zBftHk20oo5rAN5KnGlvi4boonQTm0nM
    66pX3w3vxMi4mUsm3/Qe//iBYEWq8xLLBBI/rgN6M0Yis7J7azFKrCjcMPnYkA2E
    LB1LGLohvfxdAZ1RabtYasV5skxRaXi8Ns8/C8E6+1vGE2U6kaZeyRuN5eYE45ey
    pb49VrV4hRGwvjDVIViGnlzu/YKiFc7mY4oLbHuIh42cOtTyMYtgtSD16nuVEnZf
    a9EzhAeBk3PpmlvjQBeHLcwmNelChZUxZNRYQY7ILlJOceQnKcrzzVjndGh/la07
    2+c/I9W7lbq/u5xUCoDjks49UqlIJfMKUorm1sJw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfFN6V/WNbnYx4QH8DOvsgtQyoIsH89zlJyYziJD+zjsnPcEl18frRYJ23eiN9HehkIkLgW6BYsL0QUjY7roIsVML7HgNp3/jnTXld9YVVsRpgcEZekQ7
    v4HjViMUmQOu87xFHv/g6PVxGb4lGZoZrOC31B4dRyi9HwQmZcQkiZ84ELqbTT1eaU0tUE6tTAID/PVzEs0lVTw5c94Wk+5rq/lCksboYCoOr1sL59+nyvJb
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=wPr4Kl_KzdIA:10
    a=Kd1tUaAdevIA:10 a=taGs_qngAAAA:8 a=e5mUnYsNAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=fytQkneqYxwBSb-776AA:9
    a=njjGWIRFeZRvNkZH:21 a=thEZXCt98IJKwKwc:21 a=QEXdDO2ut3YA:10
    a=DM_PlaNYpjARcMQr2apF:22 a=Vxmtnl_E_bksehYqCbjh:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754781AbeDKSlM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:41:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56694 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754698AbeDKSlK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:41:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 075/121] e1000e: Undo e1000e_pm_freeze if __e1000_shutdown fails
Date: Wed, 11 Apr 2018 20:36:18 +0200
Message-Id: <20180411183500.703788877@linuxfoundation.org>
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

From: Chris Wilson <chris@chris-wilson.co.uk>


[ Upstream commit 833521ebc65b1c3092e5c0d8a97092f98eec595d ]

An error during suspend (e100e_pm_suspend),

[  429.994338] ACPI : EC: event blocked
[  429.994633] e1000e: EEE TX LPI TIMER: 00000011
[  430.955451] pci_pm_suspend(): e1000e_pm_suspend+0x0/0x30 [e1000e] returns -2
[  430.955454] dpm_run_callback(): pci_pm_suspend+0x0/0x140 returns -2
[  430.955458] PM: Device 0000:00:19.0 failed to suspend async: error -2
[  430.955581] PM: Some devices failed to suspend, or early wake event detected
[  430.957709] ACPI : EC: event unblocked

lead to complete failure:

[  432.585002] ------------[ cut here ]------------
[  432.585013] WARNING: CPU: 3 PID: 8372 at kernel/irq/manage.c:1478 __free_irq+0x9f/0x280
[  432.585015] Trying to free already-free IRQ 20
[  432.585016] Modules linked in: cdc_ncm usbnet x86_pkg_temp_thermal intel_powerclamp coretemp mii crct10dif_pclmul crc32_pclmul ghash_clmulni_intel snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hwdep lpc_ich snd_hda_core snd_pcm mei_me mei sdhci_pci sdhci i915 mmc_core e1000e ptp pps_core prime_numbers
[  432.585042] CPU: 3 PID: 8372 Comm: kworker/u16:40 Tainted: G     U          4.10.0-rc8-CI-Patchwork_3870+ #1
[  432.585044] Hardware name: LENOVO 2356GCG/2356GCG, BIOS G7ET31WW (1.13 ) 07/02/2012
[  432.585050] Workqueue: events_unbound async_run_entry_fn
[  432.585051] Call Trace:
[  432.585058]  dump_stack+0x67/0x92
[  432.585062]  __warn+0xc6/0xe0
[  432.585065]  warn_slowpath_fmt+0x4a/0x50
[  432.585070]  ? _raw_spin_lock_irqsave+0x49/0x60
[  432.585072]  __free_irq+0x9f/0x280
[  432.585075]  free_irq+0x34/0x80
[  432.585089]  e1000_free_irq+0x65/0x70 [e1000e]
[  432.585098]  e1000e_pm_freeze+0x7a/0xb0 [e1000e]
[  432.585106]  e1000e_pm_suspend+0x21/0x30 [e1000e]
[  432.585113]  pci_pm_suspend+0x71/0x140
[  432.585118]  dpm_run_callback+0x6f/0x330
[  432.585122]  ? pci_pm_freeze+0xe0/0xe0
[  432.585125]  __device_suspend+0xea/0x330
[  432.585128]  async_suspend+0x1a/0x90
[  432.585132]  async_run_entry_fn+0x34/0x160
[  432.585137]  process_one_work+0x1f4/0x6d0
[  432.585140]  ? process_one_work+0x16e/0x6d0
[  432.585143]  worker_thread+0x49/0x4a0
[  432.585145]  kthread+0x107/0x140
[  432.585148]  ? process_one_work+0x6d0/0x6d0
[  432.585150]  ? kthread_create_on_node+0x40/0x40
[  432.585154]  ret_from_fork+0x2e/0x40
[  432.585156] ---[ end trace 6712df7f8c4b9124 ]---

The unwind failures stems from commit 2800209994f8 ("e1000e: Refactor PM
flows"), but it may be a later patch that introduced the non-recoverable
behaviour.

Fixes: 2800209994f8 ("e1000e: Refactor PM flows")
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=99847
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6363,12 +6363,17 @@ static int e1000e_pm_thaw(struct device
 static int e1000e_pm_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	int rc;
 
 	e1000e_flush_lpic(pdev);
 
 	e1000e_pm_freeze(dev);
 
-	return __e1000_shutdown(pdev, false);
+	rc = __e1000_shutdown(pdev, false);
+	if (rc)
+		e1000e_pm_thaw(dev);
+
+	return rc;
 }
 
 static int e1000e_pm_resume(struct device *dev)
