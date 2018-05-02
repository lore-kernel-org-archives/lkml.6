Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1503315-1525304347-2-12923321752179088466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES encasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525304346; b=LVR/o3cDBSsLQqyBQZyZM2cIPMOsSFYRdS8eODTCU6wpW/TNyH
    yvatEZZg3gQEO8ZwyAZNcWRR+IYF+Tw8RhP6FzHYuBIZVzxyqpgAOApRTj/DqjvU
    L5JmxkROrpJ3Vg9USUIc+3/2JiADuEJPiXm5tvjttj0rQntelCvxkIrgGhoU58Qi
    k6K2v5h74lDLjIu/tGB4d4Le7JGs/16S2GhwqGNXy6ksQNdzCvcHbc1x2I9gsJ05
    QQDobNdkZMefcbRI6WRz1uvU41+2TuGinVirEtOCE7JP758gaGfdPkhu+1P+x1dB
    Jtp7MN+UQjwRQXncprM1rynXD4HqWB4gVMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525304346; bh=gr/JR7U/cwTqwIlvwrJBNdWU5asgLO
    1uPO1uSnSjFac=; b=kaYSOdQanBJRl8xfsH94lnz+48U7rA1fuMYQRVuvGKhrcJ
    CwRRdz3+SweTu5E5rCJHeSvi18PFbSUXUdwzxFpnHvDT0RQGBufj/8JYd7pWYkVA
    33hSNf2HI2msvReTurgQpQa/vZpMPJwkrwabP2Wk6gAzRs8pfiHcnHAINkMHr7Hw
    4ySGb6hCpbXNKfZ7PN3R1E7qy3iddSf0Fys+5PHp0tVRNoLscbuVGYlhOgacBnPI
    +Eb9Y7i7rYkJC+L4XbLpD0RtQfv2oszeseIi/r2RV33ZZhsxW+0SgOCr5chpqhdV
    U+0Elev58I5OpvyRQKpJQj1F7wvYOVELn9YxoFkQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEYQXwgt/2N2mI3u+VPSdxtUql/5ezkqkVllaK50FvQh3ciSyaAa/y3utzRpB51CCz0wkK02jfP9IiTT4pcNV9BtDqI5BEWd2THr0jjasnyYcQUkmPYD
    29QipIX6VXanFV/zC6jQvqJlPtWHLL3urBMMUeHoBT96Te3KaV5KcI5IRZQpBTtrIYnrMvXRysNw9DRUF5gIMWkCYeZra4BbZ6wgI+BjBJejIuHa86O3Ul4G
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=CmAlYNrdc60C5nhTY5oA:9 a=c_f2tgl6RLWkr6zM:21
    a=3PVS-NEa3XNnmLgR:21 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeEBXjE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 19:39:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751840AbeEBXjD (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 2 May 2018 19:39:03 -0400
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org
Cc: Karol Herbst <kherbst@redhat.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Fix deadlock in nv50_mstm_register_connector()
Date: Wed,  2 May 2018 19:38:48 -0400
Message-Id: <20180502233848.14886-1-lyude@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently; we're grabbing all of the modesetting locks before adding MST
connectors to fbdev. This isn't actually necessary, and causes a
deadlock as well:

======================================================
WARNING: possible circular locking dependency detected
4.17.0-rc3Lyude-Test+ #1 Tainted: G           O
------------------------------------------------------
kworker/1:0/18 is trying to acquire lock:
00000000c832f62d (&helper->lock){+.+.}, at: drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]

but task is already holding lock:
00000000942e28e2 (crtc_ww_class_mutex){+.+.}, at: drm_modeset_backoff+0x8e/0x1c0 [drm]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (crtc_ww_class_mutex){+.+.}:
       ww_mutex_lock+0x43/0x80
       drm_modeset_lock+0x71/0x130 [drm]
       drm_helper_probe_single_connector_modes+0x7d/0x6b0 [drm_kms_helper]
       drm_setup_crtcs+0x15e/0xc90 [drm_kms_helper]
       __drm_fb_helper_initial_config_and_unlock+0x29/0x480 [drm_kms_helper]
       nouveau_fbcon_init+0x138/0x1a0 [nouveau]
       nouveau_drm_load+0x173/0x7e0 [nouveau]
       drm_dev_register+0x134/0x1c0 [drm]
       drm_get_pci_dev+0x8e/0x160 [drm]
       nouveau_drm_probe+0x1a9/0x230 [nouveau]
       pci_device_probe+0xcd/0x150
       driver_probe_device+0x30b/0x480
       __driver_attach+0xbc/0xe0
       bus_for_each_dev+0x67/0x90
       bus_add_driver+0x164/0x260
       driver_register+0x57/0xc0
       do_one_initcall+0x4d/0x323
       do_init_module+0x5b/0x1f8
       load_module+0x20e5/0x2ac0
       __do_sys_finit_module+0xb7/0xd0
       do_syscall_64+0x60/0x1b0
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (crtc_ww_class_acquire){+.+.}:
       drm_helper_probe_single_connector_modes+0x58/0x6b0 [drm_kms_helper]
       drm_setup_crtcs+0x15e/0xc90 [drm_kms_helper]
       __drm_fb_helper_initial_config_and_unlock+0x29/0x480 [drm_kms_helper]
       nouveau_fbcon_init+0x138/0x1a0 [nouveau]
       nouveau_drm_load+0x173/0x7e0 [nouveau]
       drm_dev_register+0x134/0x1c0 [drm]
       drm_get_pci_dev+0x8e/0x160 [drm]
       nouveau_drm_probe+0x1a9/0x230 [nouveau]
       pci_device_probe+0xcd/0x150
       driver_probe_device+0x30b/0x480
       __driver_attach+0xbc/0xe0
       bus_for_each_dev+0x67/0x90
       bus_add_driver+0x164/0x260
       driver_register+0x57/0xc0
       do_one_initcall+0x4d/0x323
       do_init_module+0x5b/0x1f8
       load_module+0x20e5/0x2ac0
       __do_sys_finit_module+0xb7/0xd0
       do_syscall_64+0x60/0x1b0
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&dev->mode_config.mutex){+.+.}:
       drm_setup_crtcs+0x10c/0xc90 [drm_kms_helper]
       __drm_fb_helper_initial_config_and_unlock+0x29/0x480 [drm_kms_helper]
       nouveau_fbcon_init+0x138/0x1a0 [nouveau]
       nouveau_drm_load+0x173/0x7e0 [nouveau]
       drm_dev_register+0x134/0x1c0 [drm]
       drm_get_pci_dev+0x8e/0x160 [drm]
       nouveau_drm_probe+0x1a9/0x230 [nouveau]
       pci_device_probe+0xcd/0x150
       driver_probe_device+0x30b/0x480
       __driver_attach+0xbc/0xe0
       bus_for_each_dev+0x67/0x90
       bus_add_driver+0x164/0x260
       driver_register+0x57/0xc0
       do_one_initcall+0x4d/0x323
       do_init_module+0x5b/0x1f8
       load_module+0x20e5/0x2ac0
       __do_sys_finit_module+0xb7/0xd0
       do_syscall_64+0x60/0x1b0
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&helper->lock){+.+.}:
       __mutex_lock+0x70/0x9d0
       drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]
       nv50_mstm_register_connector+0x2c/0x50 [nouveau]
       drm_dp_add_port+0x2f5/0x420 [drm_kms_helper]
       drm_dp_send_link_address+0x155/0x1e0 [drm_kms_helper]
       drm_dp_add_port+0x33f/0x420 [drm_kms_helper]
       drm_dp_send_link_address+0x155/0x1e0 [drm_kms_helper]
       drm_dp_check_and_send_link_address+0x87/0xd0 [drm_kms_helper]
       drm_dp_mst_link_probe_work+0x4d/0x80 [drm_kms_helper]
       process_one_work+0x20d/0x650
       worker_thread+0x3a/0x390
       kthread+0x11e/0x140
       ret_from_fork+0x3a/0x50

other info that might help us debug this:
Chain exists of:
  &helper->lock --> crtc_ww_class_acquire --> crtc_ww_class_mutex
 Possible unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(crtc_ww_class_mutex);
                               lock(crtc_ww_class_acquire);
                               lock(crtc_ww_class_mutex);
  lock(&helper->lock);

 *** DEADLOCK ***
5 locks held by kworker/1:0/18:
 #0: 000000004a05cd50 ((wq_completion)"events_long"){+.+.}, at: process_one_work+0x187/0x650
 #1: 00000000601c11d1 ((work_completion)(&mgr->work)){+.+.}, at: process_one_work+0x187/0x650
 #2: 00000000586ca0df (&dev->mode_config.mutex){+.+.}, at: drm_modeset_lock_all+0x3a/0x1b0 [drm]
 #3: 00000000d3ca0ffa (crtc_ww_class_acquire){+.+.}, at: drm_modeset_lock_all+0x44/0x1b0 [drm]
 #4: 00000000942e28e2 (crtc_ww_class_mutex){+.+.}, at: drm_modeset_backoff+0x8e/0x1c0 [drm]

stack backtrace:
CPU: 1 PID: 18 Comm: kworker/1:0 Tainted: G           O      4.17.0-rc3Lyude-Test+ #1
Hardware name: Gateway FX6840/FX6840, BIOS P01-A3         05/17/2010
Workqueue: events_long drm_dp_mst_link_probe_work [drm_kms_helper]
Call Trace:
 dump_stack+0x85/0xcb
 print_circular_bug.isra.38+0x1ce/0x1db
 __lock_acquire+0x128f/0x1350
 ? lock_acquire+0x9f/0x200
 ? lock_acquire+0x9f/0x200
 ? __ww_mutex_lock.constprop.13+0x8f/0x1000
 lock_acquire+0x9f/0x200
 ? drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]
 ? drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]
 __mutex_lock+0x70/0x9d0
 ? drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]
 ? ww_mutex_lock+0x43/0x80
 ? _cond_resched+0x15/0x30
 ? ww_mutex_lock+0x43/0x80
 ? drm_modeset_lock+0xb2/0x130 [drm]
 ? drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]
 drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]
 nv50_mstm_register_connector+0x2c/0x50 [nouveau]
 drm_dp_add_port+0x2f5/0x420 [drm_kms_helper]
 ? mark_held_locks+0x50/0x80
 ? kfree+0xcf/0x2a0
 ? drm_dp_check_mstb_guid+0xd6/0x120 [drm_kms_helper]
 ? trace_hardirqs_on_caller+0xed/0x180
 ? drm_dp_check_mstb_guid+0xd6/0x120 [drm_kms_helper]
 drm_dp_send_link_address+0x155/0x1e0 [drm_kms_helper]
 drm_dp_add_port+0x33f/0x420 [drm_kms_helper]
 ? nouveau_connector_aux_xfer+0x7c/0xb0 [nouveau]
 ? find_held_lock+0x2d/0x90
 ? drm_dp_dpcd_access+0xd9/0xf0 [drm_kms_helper]
 ? __mutex_unlock_slowpath+0x3b/0x280
 ? drm_dp_dpcd_access+0xd9/0xf0 [drm_kms_helper]
 drm_dp_send_link_address+0x155/0x1e0 [drm_kms_helper]
 drm_dp_check_and_send_link_address+0x87/0xd0 [drm_kms_helper]
 drm_dp_mst_link_probe_work+0x4d/0x80 [drm_kms_helper]
 process_one_work+0x20d/0x650
 worker_thread+0x3a/0x390
 ? process_one_work+0x650/0x650
 kthread+0x11e/0x140
 ? kthread_create_worker_on_cpu+0x50/0x50
 ret_from_fork+0x3a/0x50

Taking example from i915, the only time we need to hold any modesetting
locks is when changing the port on the mstc, and in that case we only
need to hold the connection mutex.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: stable@vger.kernel.org

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nv50_display.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nv50_display.c b/drivers/gpu/drm/nouveau/nv50_display.c
index 8bd739cfd00d..2b3ccd850750 100644
--- a/drivers/gpu/drm/nouveau/nv50_display.c
+++ b/drivers/gpu/drm/nouveau/nv50_display.c
@@ -3264,10 +3264,11 @@ nv50_mstm_destroy_connector(struct drm_dp_mst_topology_mgr *mgr,
 
 	drm_connector_unregister(&mstc->connector);
 
-	drm_modeset_lock_all(drm->dev);
 	drm_fb_helper_remove_one_connector(&drm->fbcon->helper, &mstc->connector);
+
+	drm_modeset_lock(&drm->dev->mode_config.connection_mutex, NULL);
 	mstc->port = NULL;
-	drm_modeset_unlock_all(drm->dev);
+	drm_modeset_unlock(&drm->dev->mode_config.connection_mutex);
 
 	drm_connector_unreference(&mstc->connector);
 }
@@ -3277,9 +3278,7 @@ nv50_mstm_register_connector(struct drm_connector *connector)
 {
 	struct nouveau_drm *drm = nouveau_drm(connector->dev);
 
-	drm_modeset_lock_all(drm->dev);
 	drm_fb_helper_add_one_connector(&drm->fbcon->helper, connector);
-	drm_modeset_unlock_all(drm->dev);
 
 	drm_connector_register(connector);
 }
-- 
2.14.3
