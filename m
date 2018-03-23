Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803758-2-16769458893758567960
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803758; b=O5QsVrymbWJ0LAiiEHbRWlmDUCoDO4+IjGx6JFtvEn4Rqwb
    qNhbJfl3nth4fd6/1DKfuQ+MLXM8tQekyRAfuNVdPtdf3GrZeXKbij/Gh3kxjjot
    mXXyEgwv2QfYGN22I+qmsy4w7146mtXx8zeGDsyw6QWOCL3MsQtncVs9Guhr698A
    TeOykunuVm7Ut9aUhwPCIBgMjlDzvuGIXTpx3DSh/0SB7n7L3SMy9xZ+bcLoRdTS
    haHNBgIRx1eLyc7KcJoMmc6SiNUJpKGAjmIgT2cZILfibX3jmqvSwAUhM0EgXvNH
    Z5AxH3ZBL+/TU+ihhlnS5TW1Gb5RB1WTHH17WHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803758; bh=qng4NUTxzLnhh6p09fmPc1i5lr
    LQ57QJxdmGCLqJMzM=; b=dCw9p/Akom5kla4ZgU5jArrcGWGlBv5WexQjIMwRB6
    bfV89DZ0MopXSi5boJ7r7OzQYR/kA86r35wfrr80pOKo7cja7p5gBLmG76tDtTp1
    UzIS4hVE10ghzDO8gWKEQq2C9ZDZ1Bc42a8I7wVSTLRbvQW80S4P7Vy/Xxe0wroE
    cUNFP8uqnva4ege4r65wfUdJo5qv21Ah7Wx97MH1BLXirc7XnX1FBTm4UBcBEDD3
    mmXc7piO5W4OL8Ew8DPAmgX7WFcbQ0CmH4BLV0h+6VhMX1+xKSx8/diODv4xxIxK
    osXGyyE8pJwxxyWREeNLdD+Tmwia1RfTNqxYc/GrpN0A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCWLPo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:15:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932343AbeCWKJu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 110/177] bnx2x: Align RX buffers
Date: Fri, 23 Mar 2018 10:53:58 +0100
Message-Id: <20180323094210.125362634@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Scott Wood <swood@redhat.com>


[ Upstream commit 9b70de6d0266888b3743f03802502e43131043c8 ]

The bnx2x driver is not providing proper alignment on the receive buffers it
passes to build_skb(), causing skb_shared_info to be misaligned.
skb_shared_info contains an atomic, and while PPC normally supports
unaligned accesses, it does not support unaligned atomics.

Aligning the size of rx buffers will ensure that page_frag_alloc() returns
aligned addresses.

This can be reproduced on PPC by setting the network MTU to 1450 (or other
non-multiple-of-4) and then generating sufficient inbound network traffic
(one or two large "wget"s usually does it), producing the following oops:

Unable to handle kernel paging request for unaligned access at address 0xc00000ffc43af656
Faulting instruction address: 0xc00000000080ef8c
Oops: Kernel access of bad area, sig: 7 [#1]
SMP NR_CPUS=2048
NUMA
PowerNV
Modules linked in: vmx_crypto powernv_rng rng_core powernv_op_panel leds_powernv led_class nfsd ip_tables x_tables autofs4 xfs lpfc bnx2x mdio libcrc32c crc_t10dif crct10dif_generic crct10dif_common
CPU: 104 PID: 0 Comm: swapper/104 Not tainted 4.11.0-rc8-00088-g4c761da #2
task: c00000ffd4892400 task.stack: c00000ffd4920000
NIP: c00000000080ef8c LR: c00000000080eee8 CTR: c0000000001f8320
REGS: c00000ffffc33710 TRAP: 0600   Not tainted  (4.11.0-rc8-00088-g4c761da)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
  CR: 24082042  XER: 00000000
CFAR: c00000000080eea0 DAR: c00000ffc43af656 DSISR: 00000000 SOFTE: 1
GPR00: c000000000907f64 c00000ffffc33990 c000000000dd3b00 c00000ffcaf22100
GPR04: c00000ffcaf22e00 0000000000000000 0000000000000000 0000000000000000
GPR08: 0000000000b80008 c00000ffc43af636 c00000ffc43af656 0000000000000000
GPR12: c0000000001f6f00 c00000000fe1a000 000000000000049f 000000000000c51f
GPR16: 00000000ffffef33 0000000000000000 0000000000008a43 0000000000000001
GPR20: c00000ffc58a90c0 0000000000000000 000000000000dd86 0000000000000000
GPR24: c000007fd0ed10c0 00000000ffffffff 0000000000000158 000000000000014a
GPR28: c00000ffc43af010 c00000ffc9144000 c00000ffcaf22e00 c00000ffcaf22100
NIP [c00000000080ef8c] __skb_clone+0xdc/0x140
LR [c00000000080eee8] __skb_clone+0x38/0x140
Call Trace:
[c00000ffffc33990] [c00000000080fb74] skb_clone+0x74/0x110 (unreliable)
[c00000ffffc339c0] [c000000000907f64] packet_rcv+0x144/0x510
[c00000ffffc33a40] [c000000000827b64] __netif_receive_skb_core+0x5b4/0xd80
[c00000ffffc33b00] [c00000000082b2bc] netif_receive_skb_internal+0x2c/0xc0
[c00000ffffc33b40] [c00000000082c49c] napi_gro_receive+0x11c/0x260
[c00000ffffc33b80] [d000000066483d68] bnx2x_poll+0xcf8/0x17b0 [bnx2x]
[c00000ffffc33d00] [c00000000082babc] net_rx_action+0x31c/0x480
[c00000ffffc33e10] [c0000000000d5a44] __do_softirq+0x164/0x3d0
[c00000ffffc33f00] [c0000000000d60a8] irq_exit+0x108/0x120
[c00000ffffc33f20] [c000000000015b98] __do_irq+0x98/0x200
[c00000ffffc33f90] [c000000000027f14] call_do_irq+0x14/0x24
[c00000ffd4923a90] [c000000000015d94] do_IRQ+0x94/0x110
[c00000ffd4923ae0] [c000000000008d90] hardware_interrupt_common+0x150/0x160

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -2026,6 +2026,7 @@ static void bnx2x_set_rx_buf_size(struct
 				  ETH_OVREHEAD +
 				  mtu +
 				  BNX2X_FW_RX_ALIGN_END;
+		fp->rx_buf_size = SKB_DATA_ALIGN(fp->rx_buf_size);
 		/* Note : rx_buf_size doesn't take into account NET_SKB_PAD */
 		if (fp->rx_buf_size + NET_SKB_PAD <= PAGE_SIZE)
 			fp->rx_frag_size = fp->rx_buf_size + NET_SKB_PAD;
