Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3031306-1521206088-2-14490086498800801458
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES rosk.us-asciien,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='jp',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521206087; b=NXp/BMTZdZi/evvUprSuHPwifnH7w67jId3l1Lq6D/vUwhl
    kIIEwu7AeMi0RPMhlXZt7xNRPcNNQsStiGkhwLdJ/2kJXm3blfzG+Hvz+Ov5wEL2
    eKT0qu/Llo/OyA5gzWtCWQVRNlhXmlVAlvNlME4s109c+XA0kcCO2BxIm+gqMrKL
    L/oWvPab9Bd8+UTSRAlAqsjSfmyVT/Vb80CH/4OotD7ABZYiO/X1YICv1h/ZqmPx
    XaW6NAdUG/s04uFDVritkH23cUj+UGNOTI6oHd0F23wBXYbLWK3Joz8KmlDmgFqp
    H3/sK5C7l1Wrpp38/nW+8Qeq5nb1qW552HYeiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:subject:from:references:in-reply-to
    :message-id:date:mime-version:content-type:sender:list-id; s=
    arctest; t=1521206087; bh=37QKzKpBOnUqFRqAcY2+THeYAff+SzFo2MAO+d
    0CYd4=; b=cx9CmrWZPoN4PFjZpUjP8Py+3s5Nmza64twdxg5YHxWc1CGsxxy1hf
    RFvONjUefCA02rEROdsfMAvcF4QY/Rg8QH0Q0M1E1kNbDqWyD7pwu9ikxxU2F6g9
    rlTvZF9mg0YsqjzkjLuP95xjmbhb02e8Uqrj/5l0C5ZiSVnx8Er/Qyh4+jVDRGqt
    yhaCQioStQCbGE3JDsrcCrasbNozsBIiG71UGG67OY0lvTUtGX16Aehc//eE7vY6
    k/PccyaglX3nlBzNft0h7m95A0vfZbblFR8IR3V+NOcwkJJ+ceL5bvtvbwaFbmcF
    d76iDuKk76/qbYW6EbCyO7xczSJTf+yQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeCPNOr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 09:14:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:15750 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbeCPNOq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 09:14:46 -0400
To: kirill@shutemov.name, mhocko@kernel.org
Cc: kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-mm@lists.ewheeler.net
Subject: Re: [PATCH] mm/shmem: Do not wait for lock_page() in shmem_unused_huge_shrink()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180316105908.62516-1-kirill.shutemov@linux.intel.com>
        <20180316121303.GI23100@dhcp22.suse.cz>
        <20180316122508.fv4edpx34hdqybwx@node.shutemov.name>
        <20180316125827.GC11461@dhcp22.suse.cz>
        <20180316130200.rbke66zjyoc6zwzl@node.shutemov.name>
In-Reply-To: <20180316130200.rbke66zjyoc6zwzl@node.shutemov.name>
Message-Id: <201803162214.ECJ30715.StOOFHOFVLJMQF@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Fri, 16 Mar 2018 22:14:24 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

f2fs is doing

  page = f2fs_pagecache_get_page(inode->i_mapping, 0, FGP_LOCK|FGP_NOWAIT, 0);

which calls

  struct page *pagecache_get_page(inode->i_mapping, 0, FGP_LOCK|FGP_NOWAIT, 0);

. Then, can't we define

  static inline struct page *find_trylock_page(struct address_space *mapping,
  					     pgoff_t offset)
  {
  	return pagecache_get_page(mapping, offset, FGP_LOCK|FGP_NOWAIT, 0);
  }

and replace find_lock_page() with find_trylock_page() ?

Also, won't

----------
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 34ce3ebf..0cfc329 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -479,6 +479,8 @@ static inline int trylock_page(struct page *page)
 static inline void lock_page(struct page *page)
 {
 	might_sleep();
+	WARN_ONCE(current->flags & PF_MEMALLOC,
+		  "lock_page() from reclaim context might deadlock");
 	if (!trylock_page(page))
 		__lock_page(page);
 }
@@ -491,6 +493,8 @@ static inline void lock_page(struct page *page)
 static inline int lock_page_killable(struct page *page)
 {
 	might_sleep();
+	WARN_ONCE(current->flags & PF_MEMALLOC,
+		  "lock_page_killable() from reclaim context might deadlock");
 	if (!trylock_page(page))
 		return __lock_page_killable(page);
 	return 0;
----------

help find lock_page() users in deep reclaim paths?

----------
[  100.314083] ------------[ cut here ]------------
[  100.315695] lock_page() from reclaim context might deadlock
[  100.315708] WARNING: CPU: 1 PID: 56 at ./include/linux/pagemap.h:483 pagecache_get_page+0x245/0x250
[  100.319686] Modules linked in: sg pcspkr i2c_piix4 vmw_vmci shpchp sd_mod ata_generic pata_acpi serio_raw vmwgfx drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ahci mptspi libahci scsi_transport_spi mptscsih ata_piix mptbase i2c_core e1000 libata ipv6
[  100.325951] CPU: 1 PID: 56 Comm: kswapd0 Kdump: loaded Not tainted 4.16.0-rc5-next-20180315+ #696
[  100.328439] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[  100.331625] RIP: 0010:pagecache_get_page+0x245/0x250
[  100.333211] RSP: 0018:ffffc9000085bc00 EFLAGS: 00010286
[  100.334832] RAX: 0000000000000000 RBX: ffffea0004ad3100 RCX: 0000000000000007
[  100.336900] RDX: 0000000000000b63 RSI: ffff88013aa0b700 RDI: ffff88013aa0ae80
[  100.339068] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[  100.341108] R10: 0000000000000040 R11: 0000000000000000 R12: ffff880139b6e0c8
[  100.343153] R13: 0000000000000000 R14: ffffffff82068220 R15: 0000000000000002
[  100.345242] FS:  0000000000000000(0000) GS:ffff88013bc40000(0000) knlGS:0000000000000000
[  100.347510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.349277] CR2: 00007f326c67e000 CR3: 000000000200f006 CR4: 00000000001606e0
[  100.351343] Call Trace:
[  100.352374]  ? iput+0x52/0x2f0
[  100.353567]  shmem_unused_huge_shrink+0x2e9/0x380
[  100.355112]  super_cache_scan+0x17a/0x180
[  100.356553]  shrink_slab+0x218/0x590
[  100.357854]  shrink_node+0x346/0x350
[  100.359161]  kswapd+0x322/0x930
[  100.360370]  kthread+0xf0/0x130
[  100.361566]  ? mem_cgroup_shrink_node+0x320/0x320
[  100.363112]  ? kthread_create_on_node+0x60/0x60
[  100.364634]  ret_from_fork+0x3a/0x50
[  100.365943] Code: db e8 70 4c 01 00 e9 5e fe ff ff 80 3d 44 51 f8 00 00 0f 85 46 ff ff ff 48 c7 c7 60 11 df 81 c6 05 30 51 f8 00 01 e8 5b 86 ee ff <0f> 0b e9 2c ff ff ff 0f 1f 40 00 83 e2 02 53 8b 8f 48 01 00 00 
[  100.371197] ---[ end trace b50eee6f891efec3 ]---
----------
