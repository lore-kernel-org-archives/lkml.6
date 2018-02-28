Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835633-2-12375320233420911998
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
    t=1519835633; b=HYRthESGo19VGfCfTG2Ny9lLYNfr3BMNO1MlbQr39OxzeHu
    HbqOfS4eYtBbOdVDvvaZOFp0Cg3IUcGzJQu9PMQAdUE6mKQ6VG1ez0Ii2es+/m6k
    myC0FOE58jwsnuB+hUdqFWMvhxrbss2sPiUCnGKFKkCJDqt4MLcgFB4FX7jt++z1
    cILL/u23Mrr+bNXAXl+JEezyWDSNf2guNI6I9MlDtQm7IhAWKcIIW2VzZK8YHkak
    t/AEUX2hNqekF4HJ/csOHW1K7FiAnHnqzVNAyfuVGG89e4PvnzEiKmiBHztKaglZ
    GEnXy+T99i/lExMSDeIkzyt6McAjfX156p7jJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835633; bh=24Sx/u2Eojwxb1xFAma
    /4aYhxpMfPnWniVKarLr14v0=; b=DMuKrH0FZDpbmRVYDEYLvi2pRRLgDlQLENi
    JXH7jo7IlwxYPY/RF2Jn3snLjsYA47DOwbg5vLel4pEK+doirxF5MAPzQAmQFKOT
    UtsVCFUPMvkpYaFRr+MY1RkHI4rerAwSAsMxi6gg2T+Hk7I5S2S7SH1W2BQzz/NE
    8vysSV2QAH7rfTkTf+usmqMnY0RnS+yYVzlr/cOnj3WlA60gnbtdbOjGFcgV3yZU
    HRV5zp1ztJv2MEFyuebKc/GZyR4azNy0/a12CGeGCocDXbwPiXDIn4D3JZqmZhU9
    ZkqNnXztQQU2KAaopPw7UGJsKU5FB4Fx743LGhg14OYnFaB/TVA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeB1QOO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:14:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35092 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752615AbeB1QOM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:14:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Jann Horn" <jannh@google.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.586549626@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 051/254] netfilter: xt_bpf: add overflow checks
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

From: Jann Horn <jannh@google.com>

commit 6ab405114b0b229151ef06f4e31c7834dd09d0c0 upstream.

Check whether inputs from userspace are too long (explicit length field too
big or string not null-terminated) to avoid out-of-bounds reads.

As far as I can tell, this can at worst lead to very limited kernel heap
memory disclosure or oopses.

This bug can be triggered by an unprivileged user even if the xt_bpf module
is not loaded: iptables is available in network namespaces, and the xt_bpf
module can be autoloaded.

Triggering the bug with a classic BPF filter with fake length 0x1000 causes
the following KASAN report:

==================================================================
BUG: KASAN: slab-out-of-bounds in bpf_prog_create+0x84/0xf0
Read of size 32768 at addr ffff8801eff2c494 by task test/4627

CPU: 0 PID: 4627 Comm: test Not tainted 4.15.0-rc1+ #1
[...]
Call Trace:
 dump_stack+0x5c/0x85
 print_address_description+0x6a/0x260
 kasan_report+0x254/0x370
 ? bpf_prog_create+0x84/0xf0
 memcpy+0x1f/0x50
 bpf_prog_create+0x84/0xf0
 bpf_mt_check+0x90/0xd6 [xt_bpf]
[...]
Allocated by task 4627:
 kasan_kmalloc+0xa0/0xd0
 __kmalloc_node+0x47/0x60
 xt_alloc_table_info+0x41/0x70 [x_tables]
[...]
The buggy address belongs to the object at ffff8801eff2c3c0
                which belongs to the cache kmalloc-2048 of size 2048
The buggy address is located 212 bytes inside of
                2048-byte region [ffff8801eff2c3c0, ffff8801eff2cbc0)
[...]
==================================================================

Fixes: e6f30c731718 ("netfilter: x_tables: add xt_bpf match")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[bwh: Backported to 3.16:
 - Add len variable in bpf_mt_check()
 - Drop change in __bpf_mt_check_path()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/netfilter/xt_bpf.c
+++ b/net/netfilter/xt_bpf.c
@@ -24,8 +24,12 @@ static int bpf_mt_check(const struct xt_
 {
 	struct xt_bpf_info *info = par->matchinfo;
 	struct sock_fprog_kern program;
+	u16 len = info->bpf_program_num_elem;
 
-	program.len = info->bpf_program_num_elem;
+	if (len > XT_BPF_MAX_NUM_INSTR)
+		return -EINVAL;
+
+	program.len = len;
 	program.filter = info->bpf_program;
 
 	if (sk_unattached_filter_create(&info->filter, &program)) {
