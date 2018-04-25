Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-585387-1524656195-2-7396415146904089676
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
    1524656194; b=JvixibuQ8uEUyLCl6bS9fjVwbJXX6S0kI3naisYR2ZLhsMu7L/
    0AMXrgGc+kIsd+r6YNHs/65/prJH6sUNlfUmXQID1Q0lOrnPxp/8Iw5AjzSlxVww
    3vRpfAi3atwHBjkAWM+gYwr0hB/1iMQ878tsSFHljSTRgLIDkhMdt2waHWnMbkqY
    1wjBYV4hmDi3sdM39OGZBaHS8TePYSY8CwfyvOz3UHbNHMtHFBlOls5UeGSfw+/X
    4uuOJRcSHjxwYluWphF92dfhJSnQyP+QZw6VzvdmJLXJGkMKQnz9k1VKb5JzlQz/
    OZsZ+w6bljPstOMIuOrWH8LncgGeSQ3YmHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524656194; bh=zYAyIMDRu1EtVSjN5/85Uv0Hr6jXLQ
    /Cgn9HBHwfQWA=; b=bB19LhPkEUcXWbqO64s+IBhjR+Ep+Tv6WFP0yUXLd5OZVi
    1n+xyjUf0fmnZRUpEqNoR/r28mdzm3AsbWhVlKTBxjOMmPaV+fxllmOrExTZ9jcT
    Q3sWOvpMuYBGeocKnQ1dP+OrqkXEs7wxKlAeZSMES9PJgu53ugj/R0e2jWkUn5UH
    WUK6pIY9fuiWjfn7PlvSQNUR/X7dtCA4gEakXVOO31KkO+sBELDfxsjmi70Bs0kk
    aecvCQOUynWb2jd0Xq5W5/BY6RkOek7xXiV+rIKKjHgft4uJVrWAOLIVwuIbUtKI
    LH9dROz8qyPgGoYH3ygtbkbSlIMXcSZybjkmsC8A==
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
X-CM-Envelope: MS4wfAEVC1Kc9TPEApuHz8m/gefmJruj6sgCfj0ptEVLym2Z9jOwN7jh7tE9b6mVoCsopHex+LdXkO/otaGd+cgnVQ7DBTL6lGS8Iq5ooqojdrMwvBYdi+u7
    mQaMJQcuxWIRyyhOY3i2x0EPMkq+s7qgsdDY+aGMKAJ54CEqWv4+Lors3PPgbKEnCViPbuweVG0PG2jDvX5mlpT3tgABBVGXBBcm7kQptN80W0OqjI3CF0jt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
    a=taGs_qngAAAA:8 a=ag1SF4gXAAAA:8 a=vjPB7pzYwXVepp3yt5YA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22 a=DM_PlaNYpjARcMQr2apF:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeDYLgc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 07:36:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeDYKd7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:33:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fei Li <fei.li@intel.com>,
        Pavel Nakonechnyi <zorg1331@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.16 12/26] drm/i915/bios: filter out invalid DDC pins from VBT child devices
Date: Wed, 25 Apr 2018 12:33:21 +0200
Message-Id: <20180425103315.334586020@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jani Nikula <jani.nikula@intel.com>

commit a3520b8992e57bc94ab6ec9f95f09c6c932555fd upstream.

The VBT contains the DDC pin to use for specific ports. Alas, sometimes
the field appears to contain bogus data, and while we check for it later
on in intel_gmbus_get_adapter() we fail to check the returned NULL on
errors. Oops results.

The simplest approach seems to be to catch and ignore the bogus DDC pins
already at the VBT parsing phase, reverting to fixed per port default
pins. This doesn't guarantee display working, but at least it prevents
the oops. And we continue to be fuzzed by VBT.

One affected machine is Dell Latitude 5590 where a BIOS upgrade added
invalid DDC pins.

Typical backtrace:

[   35.461411] WARN_ON(!intel_gmbus_is_valid_pin(dev_priv, pin))
[   35.461432] WARNING: CPU: 6 PID: 411 at drivers/gpu/drm/i915/intel_i2c.c:844 intel_gmbus_get_adapter+0x32/0x37 [i915]
[   35.461437] Modules linked in: i915 ahci libahci dm_snapshot dm_bufio dm_raid raid456 async_raid6_recov async_pq raid6_pq async_xor xor async_memcpy async_tx
[   35.461445] CPU: 6 PID: 411 Comm: kworker/u16:2 Not tainted 4.16.0-rc7.x64-g1cda370ffded #1
[   35.461447] Hardware name: Dell Inc. Latitude 5590/0MM81M, BIOS 1.1.9 03/13/2018
[   35.461450] Workqueue: events_unbound async_run_entry_fn
[   35.461465] RIP: 0010:intel_gmbus_get_adapter+0x32/0x37 [i915]
[   35.461467] RSP: 0018:ffff9b4e43d47c40 EFLAGS: 00010286
[   35.461469] RAX: 0000000000000000 RBX: ffff98f90639f800 RCX: ffffffffae051960
[   35.461471] RDX: 0000000000000001 RSI: 0000000000000092 RDI: 0000000000000246
[   35.461472] RBP: ffff98f905410000 R08: 0000004d062a83f6 R09: 00000000000003bd
[   35.461474] R10: 0000000000000031 R11: ffffffffad4eda58 R12: ffff98f905410000
[   35.461475] R13: ffff98f9064c1000 R14: ffff9b4e43d47cf0 R15: ffff98f905410000
[   35.461477] FS:  0000000000000000(0000) GS:ffff98f92e580000(0000) knlGS:0000000000000000
[   35.461479] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.461481] CR2: 00007f5682359008 CR3: 00000001b700c005 CR4: 00000000003606e0
[   35.461483] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   35.461484] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   35.461486] Call Trace:
[   35.461501]  intel_hdmi_set_edid+0x37/0x27f [i915]
[   35.461515]  intel_hdmi_detect+0x7c/0x97 [i915]
[   35.461518]  drm_helper_probe_single_connector_modes+0xe1/0x6c0
[   35.461521]  drm_setup_crtcs+0x129/0xa6a
[   35.461523]  ? __switch_to_asm+0x34/0x70
[   35.461525]  ? __switch_to_asm+0x34/0x70
[   35.461527]  ? __switch_to_asm+0x40/0x70
[   35.461528]  ? __switch_to_asm+0x34/0x70
[   35.461529]  ? __switch_to_asm+0x40/0x70
[   35.461531]  ? __switch_to_asm+0x34/0x70
[   35.461532]  ? __switch_to_asm+0x40/0x70
[   35.461534]  ? __switch_to_asm+0x34/0x70
[   35.461536]  __drm_fb_helper_initial_config_and_unlock+0x34/0x46f
[   35.461538]  ? __switch_to_asm+0x40/0x70
[   35.461541]  ? _cond_resched+0x10/0x33
[   35.461557]  intel_fbdev_initial_config+0xf/0x1c [i915]
[   35.461560]  async_run_entry_fn+0x2e/0xf5
[   35.461563]  process_one_work+0x15b/0x364
[   35.461565]  worker_thread+0x2c/0x3a0
[   35.461567]  ? process_one_work+0x364/0x364
[   35.461568]  kthread+0x10c/0x122
[   35.461570]  ? _kthread_create_on_node+0x5d/0x5d
[   35.461572]  ret_from_fork+0x35/0x40
[   35.461574] Code: 74 16 89 f6 48 8d 04 b6 48 c1 e0 05 48 29 f0 48 8d 84 c7 e8 11 00 00 c3 48 c7 c6 b0 19 1e c0 48 c7 c7 64 8a 1c c0 e8 47 88 ed ec <0f> 0b 31 c0 c3 8b 87 a4 04 00 00 80 e4 fc 09 c6 89 b7 a4 04 00
[   35.461604] WARNING: CPU: 6 PID: 411 at drivers/gpu/drm/i915/intel_i2c.c:844 intel_gmbus_get_adapter+0x32/0x37 [i915]
[   35.461606] ---[ end trace 4fe1e63e2dd93373 ]---
[   35.461609] BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
[   35.461613] IP: i2c_transfer+0x4/0x86
[   35.461614] PGD 0 P4D 0
[   35.461616] Oops: 0000 [#1] SMP PTI
[   35.461618] Modules linked in: i915 ahci libahci dm_snapshot dm_bufio dm_raid raid456 async_raid6_recov async_pq raid6_pq async_xor xor async_memcpy async_tx
[   35.461624] CPU: 6 PID: 411 Comm: kworker/u16:2 Tainted: G        W        4.16.0-rc7.x64-g1cda370ffded #1
[   35.461625] Hardware name: Dell Inc. Latitude 5590/0MM81M, BIOS 1.1.9 03/13/2018
[   35.461628] Workqueue: events_unbound async_run_entry_fn
[   35.461630] RIP: 0010:i2c_transfer+0x4/0x86
[   35.461631] RSP: 0018:ffff9b4e43d47b30 EFLAGS: 00010246
[   35.461633] RAX: ffff9b4e43d47b6e RBX: 0000000000000005 RCX: 0000000000000001
[   35.461635] RDX: 0000000000000002 RSI: ffff9b4e43d47b80 RDI: 0000000000000000
[   35.461636] RBP: ffff9b4e43d47bd8 R08: 0000004d062a83f6 R09: 00000000000003bd
[   35.461638] R10: 0000000000000031 R11: ffffffffad4eda58 R12: 0000000000000002
[   35.461639] R13: 0000000000000001 R14: ffff9b4e43d47b6f R15: ffff9b4e43d47c07
[   35.461641] FS:  0000000000000000(0000) GS:ffff98f92e580000(0000) knlGS:0000000000000000
[   35.461643] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.461645] CR2: 0000000000000010 CR3: 00000001b700c005 CR4: 00000000003606e0
[   35.461646] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   35.461647] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   35.461649] Call Trace:
[   35.461652]  drm_do_probe_ddc_edid+0xb3/0x128
[   35.461654]  drm_get_edid+0xe5/0x38d
[   35.461669]  intel_hdmi_set_edid+0x45/0x27f [i915]
[   35.461684]  intel_hdmi_detect+0x7c/0x97 [i915]
[   35.461687]  drm_helper_probe_single_connector_modes+0xe1/0x6c0
[   35.461689]  drm_setup_crtcs+0x129/0xa6a
[   35.461691]  ? __switch_to_asm+0x34/0x70
[   35.461693]  ? __switch_to_asm+0x34/0x70
[   35.461694]  ? __switch_to_asm+0x40/0x70
[   35.461696]  ? __switch_to_asm+0x34/0x70
[   35.461697]  ? __switch_to_asm+0x40/0x70
[   35.461698]  ? __switch_to_asm+0x34/0x70
[   35.461700]  ? __switch_to_asm+0x40/0x70
[   35.461701]  ? __switch_to_asm+0x34/0x70
[   35.461703]  __drm_fb_helper_initial_config_and_unlock+0x34/0x46f
[   35.461705]  ? __switch_to_asm+0x40/0x70
[   35.461707]  ? _cond_resched+0x10/0x33
[   35.461724]  intel_fbdev_initial_config+0xf/0x1c [i915]
[   35.461727]  async_run_entry_fn+0x2e/0xf5
[   35.461729]  process_one_work+0x15b/0x364
[   35.461731]  worker_thread+0x2c/0x3a0
[   35.461733]  ? process_one_work+0x364/0x364
[   35.461734]  kthread+0x10c/0x122
[   35.461736]  ? _kthread_create_on_node+0x5d/0x5d
[   35.461738]  ret_from_fork+0x35/0x40
[   35.461739] Code: 5c fa e1 ad 48 89 df e8 ea fb ff ff e9 2a ff ff ff 0f 1f 44 00 00 31 c0 e9 43 fd ff ff 31 c0 45 31 e4 e9 c5 fd ff ff 41 54 55 53 <48> 8b 47 10 48 83 78 10 00 74 70 41 89 d4 48 89 f5 48 89 fb 65
[   35.461756] RIP: i2c_transfer+0x4/0x86 RSP: ffff9b4e43d47b30
[   35.461757] CR2: 0000000000000010
[   35.461759] ---[ end trace 4fe1e63e2dd93374 ]---

Based on a patch by Fei Li.

v2: s/reverting/sticking/ (Chris)

Cc: stable@vger.kernel.org
Cc: Fei Li <fei.li@intel.com>
Co-developed-by: Fei Li <fei.li@intel.com>
Reported-by: Pavel Nakonechnyi <zorg1331@gmail.com>
Reported-and-tested-by: Seweryn Kokot <sewkokot@gmail.com>
Reported-and-tested-by: Laszlo Valko <valko@linux.karinthy.hu>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=105549
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=105961
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180411131519.9091-1-jani.nikula@intel.com
(cherry picked from commit f212bf9abe5de9f938fecea7df07046e74052dde)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_bios.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/i915/intel_bios.c
+++ b/drivers/gpu/drm/i915/intel_bios.c
@@ -1255,7 +1255,6 @@ static void parse_ddi_port(struct drm_i9
 		return;
 
 	aux_channel = child->aux_channel;
-	ddc_pin = child->ddc_pin;
 
 	is_dvi = child->device_type & DEVICE_TYPE_TMDS_DVI_SIGNALING;
 	is_dp = child->device_type & DEVICE_TYPE_DISPLAYPORT_OUTPUT;
@@ -1302,9 +1301,15 @@ static void parse_ddi_port(struct drm_i9
 		DRM_DEBUG_KMS("Port %c is internal DP\n", port_name(port));
 
 	if (is_dvi) {
-		info->alternate_ddc_pin = map_ddc_pin(dev_priv, ddc_pin);
-
-		sanitize_ddc_pin(dev_priv, port);
+		ddc_pin = map_ddc_pin(dev_priv, child->ddc_pin);
+		if (intel_gmbus_is_valid_pin(dev_priv, ddc_pin)) {
+			info->alternate_ddc_pin = ddc_pin;
+			sanitize_ddc_pin(dev_priv, port);
+		} else {
+			DRM_DEBUG_KMS("Port %c has invalid DDC pin %d, "
+				      "sticking to defaults\n",
+				      port_name(port), ddc_pin);
+		}
 	}
 
 	if (is_dp) {
