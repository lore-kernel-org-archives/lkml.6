Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524838185-2-12421335993791375441
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
    1524838184; b=SDvDsWVBwSM2N+myCjrDdRnNQhREHVwpPboDP7pEfT5XEGbKjF
    w33Tpeoc0Cmb8aFGlzsqvygwt05h+bT9C4eL9O67bXROvd9pmtiEqLkyIaMNkJ0o
    hpYjU3MdfpvqyNgH1Pt8/Z0VKY2pX5ctuJXxSC5ZUO8/6vgQVmS2hcatyBgwEMBc
    JRoIlQO6uQcX3Ic2Tkn+qsMyiktQLwx4xYmmeGi94DLZ0dUB1Sj3f7UqWJQscoPI
    8MOKHl6cWrjT4KInEAADKCMCWg8nRyoxGp2uGqM5CXicrm3u2C6uZMhOtQoIAGe3
    +tppcAxvADQcHKp4lx6xkBzjT5nZdgf25FDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838184; bh=dob1bgLcwI3WxjHoFG+8DSEr/nq0Z+
    Ff1ShkqKQfdqg=; b=g3agTAbYKndaP5GJEECNrJfOYJ8UIgpHKQTjys9uqP4fXY
    fV9ZMp3KSVMADhQ7BuN7pGgOxe2gBXsK1/SYZcNfSOPoZHZxxqeVH1hRwyOKG3pq
    f0Ao7VKRER2tyVfpNeyNz8GAX2BdYlHIzpAPr33N8WaojD/PkEZ2LHoJ6n6TTuuC
    H9/IZj1amjgAzRkj+mW2ws64DeSNhQeayfvdpSS4BYN5OFulw5MJc7jSOH7jG6AC
    rtfaxGwt9jjcqN6w8RzO8hDlzoNpXCQSQTfK2LZVxwy1pM2+MOAuc6zM0m/2F36l
    viRr0zTC7V8hMYXR5aNIMB9kO97WTvdqDI6mU0gQ==
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
X-CM-Envelope: MS4wfHXOAJCYSl/6RFxtAroONCfXot2FzPhDUq3xIPPCmwVoAEcbToifT0CCB2li4Dt6eORTDVyCraDAzV1RMHDbzhCM1SRqnI+PsTI4/p+6jurjtvC8A9cl
    eIbtNTRH/NbRy/eCeImHo0kGF6GOwvP7LEoJUWDbtTYw1rubQt7bAiPFQPiLM7QMaU/RaOyBSfsnqAjenMkOu8r3H6Cm5SQqVX3NmfzRw7v2pGwK8wD05KXb
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=u9kiiHPU1yOPsv47tnAA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932433AbeD0OJk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934480AbeD0OJi (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:09:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7EC21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmed Abdelsalam <amsalam20@gmail.com>,
        David Lebrun <dlebrun@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 11/81] ipv6: sr: fix NULL pointer dereference in seg6_do_srh_encap()- v4 pkts
Date: Fri, 27 Apr 2018 15:58:13 +0200
Message-Id: <20180427135743.836961669@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
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

From: Ahmed Abdelsalam <amsalam20@gmail.com>


[ Upstream commit a957fa190aa9d9168b33d460a5241a6d088c6265 ]

In case of seg6 in encap mode, seg6_do_srh_encap() calls set_tun_src()
in order to set the src addr of outer IPv6 header.

The net_device is required for set_tun_src(). However calling ip6_dst_idev()
on dst_entry in case of IPv4 traffic results on the following bug.

Using just dst->dev should fix this BUG.

[  196.242461] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[  196.242975] PGD 800000010f076067 P4D 800000010f076067 PUD 10f060067 PMD 0
[  196.243329] Oops: 0000 [#1] SMP PTI
[  196.243468] Modules linked in: nfsd auth_rpcgss nfs_acl nfs lockd grace fscache sunrpc crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd cryptd input_leds glue_helper led_class pcspkr serio_raw mac_hid video autofs4 hid_generic usbhid hid e1000 i2c_piix4 ahci pata_acpi libahci
[  196.244362] CPU: 2 PID: 1089 Comm: ping Not tainted 4.16.0+ #1
[  196.244606] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  196.244968] RIP: 0010:seg6_do_srh_encap+0x1ac/0x300
[  196.245236] RSP: 0018:ffffb2ce00b23a60 EFLAGS: 00010202
[  196.245464] RAX: 0000000000000000 RBX: ffff8c7f53eea300 RCX: 0000000000000000
[  196.245742] RDX: 0000f10000000000 RSI: ffff8c7f52085a6c RDI: ffff8c7f41166850
[  196.246018] RBP: ffffb2ce00b23aa8 R08: 00000000000261e0 R09: ffff8c7f41166800
[  196.246294] R10: ffffdce5040ac780 R11: ffff8c7f41166828 R12: ffff8c7f41166808
[  196.246570] R13: ffff8c7f52085a44 R14: ffffffffb73211c0 R15: ffff8c7e69e44200
[  196.246846] FS:  00007fc448789700(0000) GS:ffff8c7f59d00000(0000) knlGS:0000000000000000
[  196.247286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  196.247526] CR2: 0000000000000000 CR3: 000000010f05a000 CR4: 00000000000406e0
[  196.247804] Call Trace:
[  196.247972]  seg6_do_srh+0x15b/0x1c0
[  196.248156]  seg6_output+0x3c/0x220
[  196.248341]  ? prandom_u32+0x14/0x20
[  196.248526]  ? ip_idents_reserve+0x6c/0x80
[  196.248723]  ? __ip_select_ident+0x90/0x100
[  196.248923]  ? ip_append_data.part.50+0x6c/0xd0
[  196.249133]  lwtunnel_output+0x44/0x70
[  196.249328]  ip_send_skb+0x15/0x40
[  196.249515]  raw_sendmsg+0x8c3/0xac0
[  196.249701]  ? _copy_from_user+0x2e/0x60
[  196.249897]  ? rw_copy_check_uvector+0x53/0x110
[  196.250106]  ? _copy_from_user+0x2e/0x60
[  196.250299]  ? copy_msghdr_from_user+0xce/0x140
[  196.250508]  sock_sendmsg+0x36/0x40
[  196.250690]  ___sys_sendmsg+0x292/0x2a0
[  196.250881]  ? _cond_resched+0x15/0x30
[  196.251074]  ? copy_termios+0x1e/0x70
[  196.251261]  ? _copy_to_user+0x22/0x30
[  196.251575]  ? tty_mode_ioctl+0x1c3/0x4e0
[  196.251782]  ? _cond_resched+0x15/0x30
[  196.251972]  ? mutex_lock+0xe/0x30
[  196.252152]  ? vvar_fault+0xd2/0x110
[  196.252337]  ? __do_fault+0x1f/0xc0
[  196.252521]  ? __handle_mm_fault+0xc1f/0x12d0
[  196.252727]  ? __sys_sendmsg+0x63/0xa0
[  196.252919]  __sys_sendmsg+0x63/0xa0
[  196.253107]  do_syscall_64+0x72/0x200
[  196.253305]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[  196.253530] RIP: 0033:0x7fc4480b0690
[  196.253715] RSP: 002b:00007ffde9f252f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[  196.254053] RAX: ffffffffffffffda RBX: 0000000000000040 RCX: 00007fc4480b0690
[  196.254331] RDX: 0000000000000000 RSI: 000000000060a360 RDI: 0000000000000003
[  196.254608] RBP: 00007ffde9f253f0 R08: 00000000002d1e81 R09: 0000000000000002
[  196.254884] R10: 00007ffde9f250c0 R11: 0000000000000246 R12: 0000000000b22070
[  196.255205] R13: 20c49ba5e353f7cf R14: 431bde82d7b634db R15: 00007ffde9f278fe
[  196.255484] Code: a5 0f b6 45 c0 41 88 41 28 41 0f b6 41 2c 48 c1 e0 04 49 8b 54 01 38 49 8b 44 01 30 49 89 51 20 49 89 41 18 48 8b 83 b0 00 00 00 <48> 8b 30 49 8b 86 08 0b 00 00 48 8b 40 20 48 8b 50 08 48 0b 10
[  196.256190] RIP: seg6_do_srh_encap+0x1ac/0x300 RSP: ffffb2ce00b23a60
[  196.256445] CR2: 0000000000000000
[  196.256676] ---[ end trace 71af7d093603885c ]---

Fixes: 8936ef7604c11 ("ipv6: sr: fix NULL pointer dereference when setting encap source address")
Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>
Acked-by: David Lebrun <dlebrun@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/seg6_iptunnel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -136,7 +136,7 @@ int seg6_do_srh_encap(struct sk_buff *sk
 	isrh->nexthdr = proto;
 
 	hdr->daddr = isrh->segments[isrh->first_segment];
-	set_tun_src(net, ip6_dst_idev(dst)->dev, &hdr->daddr, &hdr->saddr);
+	set_tun_src(net, dst->dev, &hdr->daddr, &hdr->saddr);
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (sr_has_hmac(isrh)) {
