Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523474092-2-8655194465955902535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523474091; b=kj4s7r1dNSfMzQV+Dhqb5icbJS0loTpxFFatQUKWykxLYnJOx/
    +nn/NoNmUpWYHseRVAUQJfhD3a4ZwI0HGpm+6wwmjMGywT5Cbu0ngchbBx22dwGE
    b/+wC5FA5CRruI06E+tlHUuA/ztIC6Oe3G0GR+JOBfGlM2uOp4839pg1q2jZuys9
    7BC2B6e5pwu9/tTAHBMT/Z3bPCWnHstXO/lJC11VqAl9VfXcJVbooXSG8ID3TZxl
    GB5i9DwwdmOcVgvc47uNUuChFZnhV1p5/QJBOCPW+/ZE81yhyYwcwanUu8PA5H5S
    RxLryB1MOG0BnPGlnDad0P3iTKO7BtKFrnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523474091; bh=GWGmiQgEZxHBIO6iPBF5tDx9RLNZV4
    wRCYx904b0WyQ=; b=cg4oYiQU98SWYTBUodcp5Rx3FhzGIci982+4D+rA2zGsje
    sgri0uJk1FzhEUZIW+Tl8c7GBMTwVtkFyXHcPTKdJLA2CGq17qcM08sRrvKTq9fq
    NnTLCDhPntiVNkoWnNx8zF/M3EYa3kTptZROTDO0VGLojSRx5IIUg8AiTPOUG2/j
    S97xHnq0NGDtfEJkCpAyKvyOPrVroalB5q/A1l2DdQKS7ku6qXo7737KXJtti95H
    d8nQICkF2OTwVmXrFeKh006Oh2tZ1TJZIdEhQZjsRtOqKv4i3+xFvGph2YvCNNsG
    6BsvevQNZspZyA1sS7Rd1jjAjrliLSk/30vAhReg==
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
X-CM-Envelope: MS4wfAw009EhettFORDzKOf/AQvTTdLQrL0IsGQEKwy7yT5RC2ZgfOHUMNr4PLIri5GqcC3wudH/p2RxgTqclnnZseh7yhqqJxPn+oh/cSpc5O27lX5G9wM1
    cmA+7Hk8nAjB0x8BRpjfjhG20aPBYCHlScXLDxYXyPzuUlrsexlTxmYBINLk5m6kp/K7h7suSBzcv2Hnll+KQUaLyhZZonTYmNvz590HMID2nEGpnpB77jzp
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=A7XncKjpAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=rMu8KXn3jyocVQpUU3cA:9 a=QEXdDO2ut3YA:10 a=R9rPLQDAdC6-Ub70kJmZ:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935066AbeDKTFi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:05:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934041AbeDKTFg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:05:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Bates <lucasb@mojatatu.com>,
        Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 282/310] net/sched: fix NULL dereference in the error path of tcf_bpf_init()
Date: Wed, 11 Apr 2018 20:37:01 +0200
Message-Id: <20180411183634.741572943@linuxfoundation.org>
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

From: Davide Caratti <dcaratti@redhat.com>


[ Upstream commit 3239534a79ee6f20cffd974173a1e62e0730e8ac ]

when tcf_bpf_init_from_ops() fails (e.g. because of program having invalid
number of instructions), tcf_bpf_cfg_cleanup() calls bpf_prog_put(NULL) or
bpf_prog_destroy(NULL). Unless CONFIG_BPF_SYSCALL is unset, this causes
the following error:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000020
 PGD 800000007345a067 P4D 800000007345a067 PUD 340e1067 PMD 0
 Oops: 0000 [#1] SMP PTI
 Modules linked in: act_bpf(E) ip6table_filter ip6_tables iptable_filter binfmt_misc ext4 mbcache jbd2 crct10dif_pclmul crc32_pclmul ghash_clmulni_intel snd_hda_codec_generic pcbc snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm aesni_intel crypto_simd glue_helper cryptd joydev snd_timer snd virtio_balloon pcspkr soundcore i2c_piix4 nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c ata_generic pata_acpi qxl drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm virtio_blk drm virtio_net virtio_console i2c_core crc32c_intel serio_raw virtio_pci ata_piix libata virtio_ring floppy virtio dm_mirror dm_region_hash dm_log dm_mod [last unloaded: act_bpf]
 CPU: 3 PID: 5654 Comm: tc Tainted: G            E    4.16.0.bpf_test+ #408
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 RIP: 0010:__bpf_prog_put+0xc/0xc0
 RSP: 0018:ffff9594003ef728 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: ffff9594003ef758 RCX: 0000000000000024
 RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
 RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000044
 R10: 0000000000000220 R11: ffff8a7ab9f17131 R12: 0000000000000000
 R13: ffff8a7ab7c3c8e0 R14: 0000000000000001 R15: ffff8a7ab88f1054
 FS:  00007fcb2f17c740(0000) GS:ffff8a7abfd80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000020 CR3: 000000007c888006 CR4: 00000000001606e0
 Call Trace:
  tcf_bpf_cfg_cleanup+0x2f/0x40 [act_bpf]
  tcf_bpf_cleanup+0x4c/0x70 [act_bpf]
  __tcf_idr_release+0x79/0x140
  tcf_bpf_init+0x125/0x330 [act_bpf]
  tcf_action_init_1+0x2cc/0x430
  ? get_page_from_freelist+0x3f0/0x11b0
  tcf_action_init+0xd3/0x1b0
  tc_ctl_action+0x18b/0x240
  rtnetlink_rcv_msg+0x29c/0x310
  ? _cond_resched+0x15/0x30
  ? __kmalloc_node_track_caller+0x1b9/0x270
  ? rtnl_calcit.isra.29+0x100/0x100
  netlink_rcv_skb+0xd2/0x110
  netlink_unicast+0x17c/0x230
  netlink_sendmsg+0x2cd/0x3c0
  sock_sendmsg+0x30/0x40
  ___sys_sendmsg+0x27a/0x290
  ? mem_cgroup_commit_charge+0x80/0x130
  ? page_add_new_anon_rmap+0x73/0xc0
  ? do_anonymous_page+0x2a2/0x560
  ? __handle_mm_fault+0xc75/0xe20
  __sys_sendmsg+0x58/0xa0
  do_syscall_64+0x6e/0x1a0
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
 RIP: 0033:0x7fcb2e58eba0
 RSP: 002b:00007ffc93c496c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 00007ffc93c497f0 RCX: 00007fcb2e58eba0
 RDX: 0000000000000000 RSI: 00007ffc93c49740 RDI: 0000000000000003
 RBP: 000000005ac6a646 R08: 0000000000000002 R09: 0000000000000000
 R10: 00007ffc93c49120 R11: 0000000000000246 R12: 0000000000000000
 R13: 00007ffc93c49804 R14: 0000000000000001 R15: 000000000066afa0
 Code: 5f 00 48 8b 43 20 48 c7 c7 70 2f 7c b8 c7 40 10 00 00 00 00 5b e9 a5 8b 61 00 0f 1f 44 00 00 0f 1f 44 00 00 41 54 55 48 89 fd 53 <48> 8b 47 20 f0 ff 08 74 05 5b 5d 41 5c c3 41 89 f4 0f 1f 44 00
 RIP: __bpf_prog_put+0xc/0xc0 RSP: ffff9594003ef728
 CR2: 0000000000000020

Fix it in tcf_bpf_cfg_cleanup(), ensuring that bpf_prog_{put,destroy}(f)
is called only when f is not NULL.

Fixes: bbc09e7842a5 ("net/sched: fix idr leak on the error path of tcf_bpf_init()")
Reported-by: Lucas Bates <lucasb@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_bpf.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -245,10 +245,14 @@ static int tcf_bpf_init_from_efd(struct
 
 static void tcf_bpf_cfg_cleanup(const struct tcf_bpf_cfg *cfg)
 {
-	if (cfg->is_ebpf)
-		bpf_prog_put(cfg->filter);
-	else
-		bpf_prog_destroy(cfg->filter);
+	struct bpf_prog *filter = cfg->filter;
+
+	if (filter) {
+		if (cfg->is_ebpf)
+			bpf_prog_put(filter);
+		else
+			bpf_prog_destroy(filter);
+	}
 
 	kfree(cfg->bpf_ops);
 	kfree(cfg->bpf_name);
