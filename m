Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523473891-2-4799529269904653108
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523473890; b=IcgIQ8wm4RbEf1lR+Snmw5cfPatOyU0eFE1RO/yJlwR6ngEoi8
    uSjfZ52knsR04nX4Qz1uL9RfbJl2d9kOWHt+DW09dJ5aq8ULsZ7KAjdSKopAgJYz
    uxv98Pbb0PX/RSXhJmyYkzx44zAAxpvZ/lfcr97W+9k0RYzUvszQ9Hcffgyp4ft5
    oCz6h2QJQFp5c42oFk9eBbckNRpH/cLBNFiHdUuBtNFjn96QmDka2CPmGT547fl9
    Z8Ij1NgW/+Ks9XPMjbs3p7SeP6lA//yh//Nc3+6baVcPi1bCGZwxEsGG3YxRtxna
    EQEvGymK/k5Ye2p8uAWZ959hxJna8YZIDKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473890; bh=pPDv5Idn265j8BpOyZtnv9ZtruM/9L
    2eDqfO0o1nOpA=; b=oep0CUYhvWo6bcfSv5Ay7mzlHrXm/8Y2Xbsv4x+0jJ1niO
    55glhy2dvGfVeLUv0kWiaB4l45rnMOcOhpEzenPNdRJfCbJf6vBpNPaU+Y6OhdOo
    FBQItmnBaXhAypMbcmrXAiHjSFgmJkOqphd1JHDxf4Ld4okShtutBndZk7vMvHGN
    YwGzPsvMgc6IYbM2n2lM64kOPf+H/lKdgQaz0yI2xazsdXCg2ywVKnaFKvhJRR2U
    5wj/fw/JtBxi3Zrm7Ues+EvTWDRkkW+7XMnt09tv8A+sFyjiuoAPN0r3IUUjlPWL
    LjypuDpJjgViyALlLWuFxW2o8M40P2Yb6VCGfw2Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfMFvrJH/e6CflW/d4nnjF6quj2NSiEEFNfD5cn86SyK7xBHuQ6zIZVlOFm4sAVpGDJFAfd7JrxfZf8FJjat5Zw9dn32OJjEB+u3inidkxEQdqX12eiZy
    ls1L3GcTlNmYuQQ0jyhPzT3FIWCj5aMCWvTZWIYgGZRDuQVvx8iktU7uHPNVcHOi9Xw+SZFwFvbKjAy+C7cOIfcg2Rb89CyIpeY8+O2v95+scIWsCOnjPd/m
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=0MICtIxJ6JLC3FJUMOAA:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935216AbeDKTG2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:06:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40778 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935193AbeDKTGX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 301/310] net/sched: fix NULL dereference on the error path of tcf_skbmod_init()
Date: Wed, 11 Apr 2018 20:37:20 +0200
Message-Id: <20180411183635.510991859@linuxfoundation.org>
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


[ Upstream commit 2d433610176d6569e8b3a28f67bc72235bf69efc ]

when the following command

 # tc action replace action skbmod swap mac index 100

is run for the first time, and tcf_skbmod_init() fails to allocate struct
tcf_skbmod_params, tcf_skbmod_cleanup() calls kfree_rcu(NULL), thus
causing the following error:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
 IP: __call_rcu+0x23/0x2b0
 PGD 8000000034057067 P4D 8000000034057067 PUD 74937067 PMD 0
 Oops: 0002 [#1] SMP PTI
 Modules linked in: act_skbmod(E) psample ip6table_filter ip6_tables iptable_filter binfmt_misc ext4 snd_hda_codec_generic snd_hda_intel snd_hda_codec crct10dif_pclmul mbcache jbd2 crc32_pclmul snd_hda_core ghash_clmulni_intel snd_hwdep pcbc snd_seq snd_seq_device snd_pcm aesni_intel snd_timer crypto_simd glue_helper snd cryptd virtio_balloon joydev soundcore pcspkr i2c_piix4 nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c ata_generic pata_acpi qxl drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm virtio_console virtio_net virtio_blk ata_piix libata crc32c_intel virtio_pci serio_raw virtio_ring virtio i2c_core floppy dm_mirror dm_region_hash dm_log dm_mod [last unloaded: act_skbmod]
 CPU: 3 PID: 3144 Comm: tc Tainted: G            E    4.16.0-rc4.act_vlan.orig+ #403
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 RIP: 0010:__call_rcu+0x23/0x2b0
 RSP: 0018:ffffbd2e403e7798 EFLAGS: 00010246
 RAX: ffffffffc0872080 RBX: ffff981d34bff780 RCX: 00000000ffffffff
 RDX: ffffffff922a5f00 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000000 R08: 0000000000000001 R09: 000000000000021f
 R10: 000000003d003000 R11: 0000000000aaaaaa R12: 0000000000000000
 R13: ffffffff922a5f00 R14: 0000000000000001 R15: ffff981d3b698c2c
 FS:  00007f3678292740(0000) GS:ffff981d3fd80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 000000007c57a006 CR4: 00000000001606e0
 Call Trace:
  __tcf_idr_release+0x79/0xf0
  tcf_skbmod_init+0x1d1/0x210 [act_skbmod]
  tcf_action_init_1+0x2cc/0x430
  tcf_action_init+0xd3/0x1b0
  tc_ctl_action+0x18b/0x240
  rtnetlink_rcv_msg+0x29c/0x310
  ? _cond_resched+0x15/0x30
  ? __kmalloc_node_track_caller+0x1b9/0x270
  ? rtnl_calcit.isra.28+0x100/0x100
  netlink_rcv_skb+0xd2/0x110
  netlink_unicast+0x17c/0x230
  netlink_sendmsg+0x2cd/0x3c0
  sock_sendmsg+0x30/0x40
  ___sys_sendmsg+0x27a/0x290
  ? filemap_map_pages+0x34a/0x3a0
  ? __handle_mm_fault+0xbfd/0xe20
  __sys_sendmsg+0x51/0x90
  do_syscall_64+0x6e/0x1a0
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
 RIP: 0033:0x7f36776a3ba0
 RSP: 002b:00007fff4703b618 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 00007fff4703b740 RCX: 00007f36776a3ba0
 RDX: 0000000000000000 RSI: 00007fff4703b690 RDI: 0000000000000003
 RBP: 000000005aaaba36 R08: 0000000000000002 R09: 0000000000000000
 R10: 00007fff4703b0a0 R11: 0000000000000246 R12: 0000000000000000
 R13: 00007fff4703b754 R14: 0000000000000001 R15: 0000000000669f60
 Code: 5d e9 42 da ff ff 66 90 0f 1f 44 00 00 41 57 41 56 41 55 49 89 d5 41 54 55 48 89 fd 53 48 83 ec 08 40 f6 c7 07 0f 85 19 02 00 00 <48> 89 75 08 48 c7 45 00 00 00 00 00 9c 58 0f 1f 44 00 00 49 89
 RIP: __call_rcu+0x23/0x2b0 RSP: ffffbd2e403e7798
 CR2: 0000000000000008

Fix it in tcf_skbmod_cleanup(), ensuring that kfree_rcu(p, ...) is called
only when p is not NULL.

Fixes: 86da71b57383 ("net_sched: Introduce skbmod action")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_skbmod.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -192,7 +192,8 @@ static void tcf_skbmod_cleanup(struct tc
 	struct tcf_skbmod_params  *p;
 
 	p = rcu_dereference_protected(d->skbmod_p, 1);
-	kfree_rcu(p, rcu);
+	if (p)
+		kfree_rcu(p, rcu);
 }
 
 static int tcf_skbmod_dump(struct sk_buff *skb, struct tc_action *a,
