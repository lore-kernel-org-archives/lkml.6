Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477623-2-3400767149822956373
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
    1523477622; b=TiSxDpaVixyAg9leAoZszgBQWe31u0NrDrSNqErB2jKkUXBTyL
    eOYcIgleMq+vc+MwkLphoyTsn1C8YxeHdzYPvcOQOIXWrENpAXkxT0uizsZlSKxI
    M6i5cw/WgZk/IytUzAN9uh/x7vcS1AbTGRRaMdsjfvPXj4h1ocWdhruA3IhjGdHq
    8Sr6oCBqzN3QQgERQEa8FekvpSWBpR0M7BGqf2Zus+eCrUiMTP0LcL13Gmt+YV9o
    FRiaQprsQXvpnLsFFxpVAQVF80T25DDUKKsjBCWQDDdsVijOD412TBgbQPWpWMyx
    rmz+NGAXfvXfchS1H8ljHhIOCc8ojN8fxIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477622; bh=nGZx5UD9oXZBtMv7POLy3iOkEqW/Zw
    4ZG4KQCh+usGQ=; b=od7AuHHXeAdItcp7q0lNfS+wbjIhvKVNCYywdDbYVzBVGg
    TfF6BZHSbaL7zofcXVgTBFaISopO7GTF5e/oroAyZhgAGWeyTVGMfMUpFcwjEhSJ
    pIGzfBm5pcexm3k2diS+WGlJDNrHPX+vNxEHP9mpdnpikO+evBsmHsqeNaSAtmJw
    swGkkbnY3DQlByhrEAkZPea0p7J+M0Pyv6Yo/5beiyvvfRnYKROzJzphGMObQUMc
    lXfRx/xD/kM1E8HmkDFHM9opBW197mg1Dw5q49FUabsBnP4SPwR6K9EKG8yR+c9Q
    6j0MGDBe9vxNf9HBXZxiOK/O/cgLirItS8bJvjHQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfGBAhFCk2R+Xyy7z3+0vjF0A0Etsqgj/f+s1Rh7ngSVoe4SPc3Ncmwybf5Ia9wLVycCBSIq7VPtYBd+0fgDROgEHEXhqYor/2weZsepQbI+0nknQde08
    9clV7Fle7kQsz+ZBVgVbKwHdqXN0PnqVUOkIv/gErdzCRf0OBpQi46SifRGy9gOKudu8GD0VQrE1Cys63uOmLveJ4aARdXQ5Mz1o4lHFP4XQyJPbbSOiE8p2
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=gVGD3344AAAA:8 a=ttLlOQO2AAAA:8 a=FOH2dFAWAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=nUTw6ldM4BOOjH20MDAA:9 a=QEXdDO2ut3YA:10
    a=xQEvYfgLW3QvObN0DhJi:22 a=1BJeXTq6bvZE9X1NrNaC:22 a=i3VuKzQdj-NEYjvDI-p3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756299AbeDKUN2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:13:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33928 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933337AbeDKSxo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander GQ Gerasiov <gq@redlab-i.ru>,
        Julia Cartwright <julia@ni.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 003/310] md/raid5: make use of spin_lock_irq over local_irq_disable + spin_lock
Date: Wed, 11 Apr 2018 20:32:22 +0200
Message-Id: <20180411183622.442074804@linuxfoundation.org>
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

From: Julia Cartwright <julia@ni.com>


[ Upstream commit 3d05f3aed5d721c2c77d20288c29ab26c6193ed5 ]

On mainline, there is no functional difference, just less code, and
symmetric lock/unlock paths.

On PREEMPT_RT builds, this fixes the following warning, seen by
Alexander GQ Gerasiov, due to the sleeping nature of spinlocks.

   BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:993
   in_atomic(): 0, irqs_disabled(): 1, pid: 58, name: kworker/u12:1
   CPU: 5 PID: 58 Comm: kworker/u12:1 Tainted: G        W       4.9.20-rt16-stand6-686 #1
   Hardware name: Supermicro SYS-5027R-WRF/X9SRW-F, BIOS 3.2a 10/28/2015
   Workqueue: writeback wb_workfn (flush-253:0)
   Call Trace:
    dump_stack+0x47/0x68
    ? migrate_enable+0x4a/0xf0
    ___might_sleep+0x101/0x180
    rt_spin_lock+0x17/0x40
    add_stripe_bio+0x4e3/0x6c0 [raid456]
    ? preempt_count_add+0x42/0xb0
    raid5_make_request+0x737/0xdd0 [raid456]

Reported-by: Alexander GQ Gerasiov <gq@redlab-i.ru>
Tested-by: Alexander GQ Gerasiov <gq@redlab-i.ru>
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid5.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -110,8 +110,7 @@ static inline void unlock_device_hash_lo
 static inline void lock_all_device_hash_locks_irq(struct r5conf *conf)
 {
 	int i;
-	local_irq_disable();
-	spin_lock(conf->hash_locks);
+	spin_lock_irq(conf->hash_locks);
 	for (i = 1; i < NR_STRIPE_HASH_LOCKS; i++)
 		spin_lock_nest_lock(conf->hash_locks + i, conf->hash_locks);
 	spin_lock(&conf->device_lock);
@@ -121,9 +120,9 @@ static inline void unlock_all_device_has
 {
 	int i;
 	spin_unlock(&conf->device_lock);
-	for (i = NR_STRIPE_HASH_LOCKS; i; i--)
-		spin_unlock(conf->hash_locks + i - 1);
-	local_irq_enable();
+	for (i = NR_STRIPE_HASH_LOCKS - 1; i; i--)
+		spin_unlock(conf->hash_locks + i);
+	spin_unlock_irq(conf->hash_locks);
 }
 
 /* bio's attached to a stripe+device for I/O are linked together in bi_sector
@@ -732,12 +731,11 @@ static bool is_full_stripe_write(struct
 
 static void lock_two_stripes(struct stripe_head *sh1, struct stripe_head *sh2)
 {
-	local_irq_disable();
 	if (sh1 > sh2) {
-		spin_lock(&sh2->stripe_lock);
+		spin_lock_irq(&sh2->stripe_lock);
 		spin_lock_nested(&sh1->stripe_lock, 1);
 	} else {
-		spin_lock(&sh1->stripe_lock);
+		spin_lock_irq(&sh1->stripe_lock);
 		spin_lock_nested(&sh2->stripe_lock, 1);
 	}
 }
@@ -745,8 +743,7 @@ static void lock_two_stripes(struct stri
 static void unlock_two_stripes(struct stripe_head *sh1, struct stripe_head *sh2)
 {
 	spin_unlock(&sh1->stripe_lock);
-	spin_unlock(&sh2->stripe_lock);
-	local_irq_enable();
+	spin_unlock_irq(&sh2->stripe_lock);
 }
 
 /* Only freshly new full stripe normal write stripe can be added to a batch list */
