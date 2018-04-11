Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523473914-2-9134814208627718475
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
    1523473913; b=dznBTc9MNaUG/SmuEOaGhalkUiHrQylOjIGtke3kKdEE0+N06u
    MKNkIa5U+9QxoYrAA5w7aFKQRbAr+5JU7qJReZvHSSFha5CJVLw/SKqorAWXVR/M
    SNoMiCaH/Lkj81ouAWkD56jgRK+nuAfjD6EwuG6Y2QDcaK5J7ZJcb3HEhKRpkofb
    w14IhcHSCCuY6Kv5hyc+OhgZcJXnjEXj9s7qcRm0/lkUJrMpj6lKFW5Eo5V3gTun
    IKd2VCYh0Iw8rPIklaeORoWD2PiqaYzJ0SvNaImpctQmwDUWP73XF49Ffi2R3Y4s
    B8P596bHcnuIgMwxKwdcpFyKjp9XtLV8qEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473913; bh=9JolQLdUfRFq5H49PtE2KtTGX7BcpE
    IicQ0GV1W8d+c=; b=pIVfSUpn/hzYWMiOKM3X52qi26WXQE00ZlvSTx2BL9khdt
    xXrMky+DJm15XppWJQsa2gErpwcSYnybHuU+m1GmMBjsHi0Kwe97kuVR80yGqLHL
    6gzalr+dh0mXip9s8GJ6HsqTtHhDjFhNBDY47DMy2B9FumOPCuD6SQ2D6P616TA0
    QRJZuJ8YLe3rgB90Ys8+A03lrSaqQT3DkEPEad+U56ML9qIVQzSnIBSEef+rUX7j
    8Mlkjnk2ldzUi/6pghCenZy2hR0uIINIOLSCPPeonth35XL/RY2J1IaH+6w7Rfnk
    kA2EcyavOmihKGEAXjDt1WRYHGSPNF31S/++gvGw==
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
X-CM-Envelope: MS4wfKvtj91Py8urDs7Z0s4n+5PcsfH9T/kdGSWTnQc9m9aTsTVdgcul05DYJvygkcvMaq/bET1PYPCiiZw9VgaBzYpHpIu+OwbJqtpvYHCkIbPsaFn2++IP
    3a26/z2XEy4beJzskzmA69BqsM+vdeQtFMiRDFSvk0vmJ67zvdmcrFCYjMEYV5r0wa7D097TXlK5JWYPgz+slk07951cbgzDugMcqGJQP3yd3Gw5NGLXyOOf
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=Z_VroLKX603g8xN7Fp8A:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935197AbeDKTGV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:06:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40756 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935193AbeDKTGU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 300/310] net/sched: fix NULL dereference in the error path of tunnel_key_init()
Date: Wed, 11 Apr 2018 20:37:19 +0200
Message-Id: <20180411183635.476629726@linuxfoundation.org>
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


[ Upstream commit abdadd3cfd3e7ea3da61ac774f84777d1f702058 ]

when the following command

 # tc action add action tunnel_key unset index 100

is run for the first time, and tunnel_key_init() fails to allocate struct
tcf_tunnel_key_params, tunnel_key_release() dereferences NULL pointers.
This causes the following error:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
 IP: tunnel_key_release+0xd/0x40 [act_tunnel_key]
 PGD 8000000033787067 P4D 8000000033787067 PUD 74646067 PMD 0
 Oops: 0000 [#1] SMP PTI
 Modules linked in: act_tunnel_key(E) act_csum ip6table_filter ip6_tables iptable_filter binfmt_misc ext4 mbcache jbd2 crct10dif_pclmul crc32_pclmul snd_hda_codec_generic ghash_clmulni_intel snd_hda_intel pcbc snd_hda_codec snd_hda_core snd_hwdep snd_seq aesni_intel snd_seq_device crypto_simd glue_helper snd_pcm cryptd joydev snd_timer pcspkr virtio_balloon snd i2c_piix4 soundcore nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c ata_generic pata_acpi qxl drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm virtio_net virtio_blk drm virtio_console crc32c_intel ata_piix serio_raw i2c_core virtio_pci libata virtio_ring virtio floppy dm_mirror dm_region_hash dm_log dm_mod
 CPU: 2 PID: 3101 Comm: tc Tainted: G            E    4.16.0-rc4.act_vlan.orig+ #403
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 RIP: 0010:tunnel_key_release+0xd/0x40 [act_tunnel_key]
 RSP: 0018:ffffba46803b7768 EFLAGS: 00010286
 RAX: ffffffffc09010a0 RBX: 0000000000000000 RCX: 0000000000000024
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff99ee336d7480
 RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000044
 R10: 0000000000000220 R11: ffff99ee79d73131 R12: 0000000000000000
 R13: ffff99ee32d67610 R14: ffff99ee7671dc38 R15: 00000000fffffff4
 FS:  00007febcb2cd740(0000) GS:ffff99ee7fd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000010 CR3: 000000007c8e4005 CR4: 00000000001606e0
 Call Trace:
  __tcf_idr_release+0x79/0xf0
  tunnel_key_init+0xd9/0x460 [act_tunnel_key]
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
  __sys_sendmsg+0x51/0x90
  do_syscall_64+0x6e/0x1a0
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
 RIP: 0033:0x7febca6deba0
 RSP: 002b:00007ffe7b0dd128 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 00007ffe7b0dd250 RCX: 00007febca6deba0
 RDX: 0000000000000000 RSI: 00007ffe7b0dd1a0 RDI: 0000000000000003
 RBP: 000000005aaa90cb R08: 0000000000000002 R09: 0000000000000000
 R10: 00007ffe7b0dcba0 R11: 0000000000000246 R12: 0000000000000000
 R13: 00007ffe7b0dd264 R14: 0000000000000001 R15: 0000000000669f60
 Code: 44 00 00 8b 0d b5 23 00 00 48 8b 87 48 10 00 00 48 8b 3c c8 e9 a5 e5 d8 c3 0f 1f 44 00 00 0f 1f 44 00 00 53 48 8b 9f b0 00 00 00 <83> 7b 10 01 74 0b 48 89 df 31 f6 5b e9 f2 fa 7f c3 48 8b 7b 18
 RIP: tunnel_key_release+0xd/0x40 [act_tunnel_key] RSP: ffffba46803b7768
 CR2: 0000000000000010

Fix this in tunnel_key_release(), ensuring 'param' is not NULL before
dereferencing it.

Fixes: d0f6dd8a914f ("net/sched: Introduce act_tunnel_key")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_tunnel_key.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -196,11 +196,12 @@ static void tunnel_key_release(struct tc
 	struct tcf_tunnel_key_params *params;
 
 	params = rcu_dereference_protected(t->params, 1);
+	if (params) {
+		if (params->tcft_action == TCA_TUNNEL_KEY_ACT_SET)
+			dst_release(&params->tcft_enc_metadata->dst);
 
-	if (params->tcft_action == TCA_TUNNEL_KEY_ACT_SET)
-		dst_release(&params->tcft_enc_metadata->dst);
-
-	kfree_rcu(params, rcu);
+		kfree_rcu(params, rcu);
+	}
 }
 
 static int tunnel_key_dump_addresses(struct sk_buff *skb,
