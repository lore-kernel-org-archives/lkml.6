Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837146-2-16878268554351217972
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
    t=1519837145; b=D1yw3XRRdTakyf9XloNIwCb3K9wjVhuJVvdRzJeTKo++guD
    No/mRidep7q60QH/4Izwa75ZhmuCIS2dJ5fiZlaSV+oaJI9R5KaNTyrfU1Qzq/F3
    nYsMXK2MLCjTZLRSy0XsprFJwFfFRLgWvBTSbIf7yv3w2rmbMuIGLnVe86fp/tjD
    1v47k6kcgDWJzTsdPi9Y64Vup9OMwZHDkwRz2RtSeXXMWluZ4/Eal1tagmQxsZPN
    /Wy4LW4AdDQIMc6CRSCihmHAq2YZTlH4liNY/NI6X7E/xZBieDkuRV7K/yIh7zPu
    9tObHrtprchLWcK8KEc4ILvWKEqXemtgOIGHlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837145; bh=qarby9sTwATY9vYLpkv
    Ytqx3hP81tAKavaatkVSiG+Y=; b=NMrupZlVDGJDrmTnyQOxWQqajowz8xaTl6G
    mZxq/DkFXETlGrn94kwDIUm9VxCcwxM/aNV+wohQJr6uodQR4XWGI7ssg2KHGiFE
    27BKHVi31p7KvMeFvfp/Yeh9LIEVYSWqHkuSJ2Ip8L5e0DlM2Z2d9RUmbN92BrJQ
    P/RMncxm6eD4zkOBqiITHKHNxCs1a+73V12wAKeUp0nEYB7NOkqZ8/iLS/qmKbRV
    hYT2p09lYwmoLj7nTh/AMqsnilAlpD7KfiEARd7LFhJjhwtCFocz36ZTfP6temvx
    4qGPe+TFtCXrm/NSedkJwgg5gXyBeYJeypmtv4LLdx7UANaTiJA==
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
        id S933855AbeB1Pwa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:52:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34397 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932426AbeB1Pw0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:52:26 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Marek Belisko" <marek@goldelico.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.421637201@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 185/254] Input: twl4030-vibra - fix ERROR: Bad
 of_node_put() warning
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

From: Marek Belisko <marek@goldelico.com>

commit e661d0a04462dd98667f8947141bd8defab5b34a upstream.

Fix following:
[    8.862274] ERROR: Bad of_node_put() on /ocp/i2c@48070000/twl@48/audio
[    8.869293] CPU: 0 PID: 1003 Comm: modprobe Not tainted 4.2.0-rc2-letux+ #1175
[    8.876922] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[    8.883514] [<c00159e0>] (unwind_backtrace) from [<c0012488>] (show_stack+0x10/0x14)
[    8.891693] [<c0012488>] (show_stack) from [<c05cb810>] (dump_stack+0x78/0x94)
[    8.899322] [<c05cb810>] (dump_stack) from [<c02cfd5c>] (kobject_release+0x68/0x7c)
[    8.907409] [<c02cfd5c>] (kobject_release) from [<bf0040c4>] (twl4030_vibra_probe+0x74/0x188 [twl4030_vibra])
[    8.917877] [<bf0040c4>] (twl4030_vibra_probe [twl4030_vibra]) from [<c03816ac>] (platform_drv_probe+0x48/0x90)
[    8.928497] [<c03816ac>] (platform_drv_probe) from [<c037feb4>] (really_probe+0xd4/0x238)
[    8.937103] [<c037feb4>] (really_probe) from [<c0380160>] (driver_probe_device+0x30/0x48)
[    8.945678] [<c0380160>] (driver_probe_device) from [<c03801e0>] (__driver_attach+0x68/0x8c)
[    8.954589] [<c03801e0>] (__driver_attach) from [<c037ea60>] (bus_for_each_dev+0x50/0x84)
[    8.963226] [<c037ea60>] (bus_for_each_dev) from [<c037f828>] (bus_add_driver+0xcc/0x1e4)
[    8.971832] [<c037f828>] (bus_add_driver) from [<c0380b60>] (driver_register+0x9c/0xe0)
[    8.980255] [<c0380b60>] (driver_register) from [<c00097e0>] (do_one_initcall+0x100/0x1b8)
[    8.988983] [<c00097e0>] (do_one_initcall) from [<c00b8008>] (do_init_module+0x58/0x1c0)
[    8.997497] [<c00b8008>] (do_init_module) from [<c00b8cac>] (SyS_init_module+0x54/0x64)
[    9.005950] [<c00b8cac>] (SyS_init_module) from [<c000ed20>] (ret_fast_syscall+0x0/0x54)
[    9.015838] input: twl4030:vibrator as /devices/platform/68000000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@48:audio/input/input2

node passed to of_find_node_by_name is put inside that function and new node
is returned if found. Free returned node not already freed node.

Signed-off-by: Marek Belisko <marek@goldelico.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/misc/twl4030-vibra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -185,7 +185,8 @@ static bool twl4030_vibra_check_coexist(
 	if (pdata && pdata->coexist)
 		return true;
 
-	if (of_find_node_by_name(node, "codec")) {
+	node = of_find_node_by_name(node, "codec");
+	if (node) {
 		of_node_put(node);
 		return true;
 	}
