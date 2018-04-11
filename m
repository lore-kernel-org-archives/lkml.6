Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3216147-1523476373-2-12131691401411148674
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
    1523476373; b=rIR2TJLzC0OAXNGwhrvCrc2bXm5TwZuDocovvXsZZQXj0aPegC
    H51hbLCGHhjYejDeGtj5CSOD/F41vNnXzFHtbrAPqsiMAlxupPWQkDgPbJZg62Kt
    GJa45F/Z9exN1wAsCUVAxtLHkupjhlP/Iycy3fkX91MLrgXUBpqQIZk0I97Tkhje
    CjeKTTVe7/bgt/De8eegkgZaoYQdBm4RYwVm26Rd9R33Swqzqk2aLEJoQ8KLlnm0
    EsL1wDFc/KL2jGzqmvdG6s5t/hCJ3RS2IsFaKiFn0rAzxtCH5Qm/kuvpn+dTSWP/
    coBr05kMcRMpipjNq5mhCjUlxOh7f1cQzocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476373; bh=eFTm3Chj4FW1C71v5RNNFjSjP+3jRA
    TP9QJqF0aNjbQ=; b=LPs5+Xhjm7hFtCXEKtaPME4eWLmC+UQSLLUhTEcsW7T+XI
    oCTrTgHyYWV821OmU3td3lIME2t6nnmOieHU7DCif1AGa7tlktJ0v6Ch981qA0Lw
    iqn8nEFb+O4hV/RFlP3SFeoIRJg0Wl7QkPLP1G65B7AR12lxB1mIJoVwAWPDOJZi
    Y3At94aaykOdHa3gQFgMWblrPRzoIouNRxPtouMEtVh1CrHk+9B1rhwtx1ISuL4o
    iIxlUznCORlezSvrJBP2PKVVpJMR0Mj0j7jtcx6nBuaXu9e04i7QlysMCb3xoh9m
    DIO9AHSw4QMGA/y9r7nFu1OJ71/qvU6Z9JkWjhhw==
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
X-CM-Envelope: MS4wfIJDr36ayI8UwavCuIV42229Hs6ne8QZFkSF3d+NfsO3hKJbqeJAEcIYN0imQmK2CB1Hi+dG82B59kdiFd2h8rSfFVF6qIkjcO0jJJ46TQYjdmIeZIFT
    lYrrBbXTmJ+ywixWSPgdsft2pnAGMGNt5ND8FzI083al6rvYaqMqU01feFqe04Sn8ItoP/0CAmyENMdeHiJgrDuul3mpQOFXf1HAoICQYSIPkI+GOYiKok0y
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=C8Vud2rhAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=nEKseXGMGnxo6E0TNbQA:9 a=QEXdDO2ut3YA:10 a=sk968m3YkE6f23GvJKqC:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754213AbeDKS6C (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:58:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36502 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932601AbeDKS6A (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:58:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yi Zeng <yizeng@asrmicro.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 122/310] thermal: power_allocator: fix one race condition issue for thermal_instances list
Date: Wed, 11 Apr 2018 20:34:21 +0200
Message-Id: <20180411183627.411499905@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Yi Zeng <yizeng@asrmicro.com>


[ Upstream commit a5de11d67dcd268b8d0beb73dc374de5e97f0caf ]

When invoking allow_maximum_power and traverse tz->thermal_instances,
we should grab thermal_zone_device->lock to avoid race condition. For
example, during the system reboot, if the mali GPU device implements
device shutdown callback and unregister GPU devfreq cooling device,
the deleted list head may be accessed to cause panic, as the following
log shows:

[   33.551070] c3 25 (kworker/3:0) Unable to handle kernel paging request at virtual address dead000000000070
[   33.566708] c3 25 (kworker/3:0) pgd = ffffffc0ed290000
[   33.572071] c3 25 (kworker/3:0) [dead000000000070] *pgd=00000001ed292003, *pud=00000001ed292003, *pmd=0000000000000000
[   33.581515] c3 25 (kworker/3:0) Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   33.599761] c3 25 (kworker/3:0) CPU: 3 PID: 25 Comm: kworker/3:0 Not tainted 4.4.35+ #912
[   33.614137] c3 25 (kworker/3:0) Workqueue: events_freezable thermal_zone_device_check
[   33.620245] c3 25 (kworker/3:0) task: ffffffc0f32e4200 ti: ffffffc0f32f0000 task.ti: ffffffc0f32f0000
[   33.629466] c3 25 (kworker/3:0) PC is at power_allocator_throttle+0x7c8/0x8a4
[   33.636609] c3 25 (kworker/3:0) LR is at power_allocator_throttle+0x808/0x8a4
[   33.643742] c3 25 (kworker/3:0) pc : [<ffffff8008683dd0>] lr : [<ffffff8008683e10>] pstate: 20000145
[   33.652874] c3 25 (kworker/3:0) sp : ffffffc0f32f3bb0
[   34.468519] c3 25 (kworker/3:0) Process kworker/3:0 (pid: 25, stack limit = 0xffffffc0f32f0020)
[   34.477220] c3 25 (kworker/3:0) Stack: (0xffffffc0f32f3bb0 to 0xffffffc0f32f4000)
[   34.819822] c3 25 (kworker/3:0) Call trace:
[   34.824021] c3 25 (kworker/3:0) Exception stack(0xffffffc0f32f39c0 to 0xffffffc0f32f3af0)
[   34.924993] c3 25 (kworker/3:0) [<ffffff8008683dd0>] power_allocator_throttle+0x7c8/0x8a4
[   34.933184] c3 25 (kworker/3:0) [<ffffff80086807f4>] handle_thermal_trip.part.25+0x70/0x224
[   34.941545] c3 25 (kworker/3:0) [<ffffff8008680a68>] thermal_zone_device_update+0xc0/0x20c
[   34.949818] c3 25 (kworker/3:0) [<ffffff8008680bd4>] thermal_zone_device_check+0x20/0x2c
[   34.957924] c3 25 (kworker/3:0) [<ffffff80080b93a4>] process_one_work+0x168/0x458
[   34.965414] c3 25 (kworker/3:0) [<ffffff80080ba068>] worker_thread+0x13c/0x4b4
[   34.972650] c3 25 (kworker/3:0) [<ffffff80080c0a4c>] kthread+0xe8/0xfc
[   34.979187] c3 25 (kworker/3:0) [<ffffff8008084e90>] ret_from_fork+0x10/0x40
[   34.986244] c3 25 (kworker/3:0) Code: f9405e73 eb1302bf d102e273 54ffc460 (b9402a61)
[   34.994339] c3 25 (kworker/3:0) ---[ end trace 32057901e3b7e1db ]---

Signed-off-by: Yi Zeng <yizeng@asrmicro.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/power_allocator.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -523,6 +523,7 @@ static void allow_maximum_power(struct t
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
 
+	mutex_lock(&tz->lock);
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if ((instance->trip != params->trip_max_desired_temperature) ||
 		    (!cdev_is_power_actor(instance->cdev)))
@@ -534,6 +535,7 @@ static void allow_maximum_power(struct t
 		mutex_unlock(&instance->cdev->lock);
 		thermal_cdev_update(instance->cdev);
 	}
+	mutex_unlock(&tz->lock);
 }
 
 /**
