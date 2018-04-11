Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3150701-1523473552-2-3781177757288416159
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ensvsk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523473551; b=ahBZVXyLmSEIy7QA6ai8ICnhigtJgyeQVifuJY0lGuXpg9Sz/d
    xUfbZbmdlzNLwAA7nd80DB+4pWo4wPupxoU+PiChm4yUg6SEMLTfKhQ2awUtkEJD
    e9JDRlTtXFF7fmjZ8LF64vqH6fGU+A3b+1L1Fx7LrJH7SzkmKP4xL0lyNUWrcIeG
    stgL2//6YF5NG33tqRrfppLNG/9k8Sj8OgK/rMPRv8iKoPUgliMqcK5N+DuxidEz
    5jZZjMJg87iaZHuCF+0g8wJpUO9m1aIzFaM/c+TWoZ+Q6fLY5LAUOpSSbrsRy1OX
    krd+415umywPNF8eAa+cVTfCpAN7m6ERbLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473551; bh=kMpWztBBD9Bb5eiNsQesW4U6aoysvF
    1A3kPOhZGyLsQ=; b=QMEhKsuhPWpkcz6R2yuXmBD3Qvqth1/7tBWgmUIN2c8DNd
    iZ+6EzkzrBJvYoUY8ukyF8Wvjths7vfn9zIi/K8o3E/7X1mO0K+sPhz6MGgzp8RM
    UzgX1S/NL/swwdX3e1nSRdT+oPBxJ+8Js3E27gl2e0km7a7ctwAqFBoaiwzds0pz
    JZiPfTOfKGyhV4aX6Fu58sHKP57gSTsZbLmU9HCPr+8IxLYqL/6GSY8qZZbuA8TN
    /qpSAdNMyV0pi8+iqaYNZVe7JnLlBcF/++j4yNB3pqUUEtaDlTt4pQcq3Ho5S9Fd
    uV83abxAsEnLEpdDbkZ0j+e/6UguswQuaEozEDYQ==
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
X-CM-Envelope: MS4wfI7/IUh62Sm0izYVaAcDSUtGRlKbyldQP8sz9pnAsfKj+NGEJnUNadB2eYKhAcyKXtUV45MsvzjNlMzpnCxZKt8yg/N1JrOg2XjUrWIN4ZlKevr52iFy
    Xi7z8lv7exxB9e0sIXJ4dn7FYYxCrf4kuOpcmh3MilqdXp8h0F8OaJUy8spdkHtng/bnH15PA8P/TJhvq5xuwD7pmuLs20LL4frK/Jriq6iN2zvGMD0Cmt5O
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=sozttTNsAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=1IKCCceyvx1ZhNYduq4A:9 a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935097AbeDKTFs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:05:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40578 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934041AbeDKTFq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:05:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 254/310] hsr: fix incorrect warning
Date: Wed, 11 Apr 2018 20:36:33 +0200
Message-Id: <20180411183633.357953859@linuxfoundation.org>
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

From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>


[ Upstream commit 675c8da049fd6556eb2d6cdd745fe812752f07a8 ]

When HSR interface is setup using ip link command, an annoying warning
appears with the trace as below:-

[  203.019828] hsr_get_node: Non-HSR frame
[  203.019833] Modules linked in:
[  203.019848] CPU: 0 PID: 158 Comm: sd-resolve Tainted: G        W       4.12.0-rc3-00052-g9fa6bf70 #2
[  203.019853] Hardware name: Generic DRA74X (Flattened Device Tree)
[  203.019869] [<c0110280>] (unwind_backtrace) from [<c010c2f4>] (show_stack+0x10/0x14)
[  203.019880] [<c010c2f4>] (show_stack) from [<c04b9f64>] (dump_stack+0xac/0xe0)
[  203.019894] [<c04b9f64>] (dump_stack) from [<c01374e8>] (__warn+0xd8/0x104)
[  203.019907] [<c01374e8>] (__warn) from [<c0137548>] (warn_slowpath_fmt+0x34/0x44)
root@am57xx-evm:~# [  203.019921] [<c0137548>] (warn_slowpath_fmt) from [<c081126c>] (hsr_get_node+0x148/0x170)
[  203.019932] [<c081126c>] (hsr_get_node) from [<c0814240>] (hsr_forward_skb+0x110/0x7c0)
[  203.019942] [<c0814240>] (hsr_forward_skb) from [<c0811d64>] (hsr_dev_xmit+0x2c/0x34)
[  203.019954] [<c0811d64>] (hsr_dev_xmit) from [<c06c0828>] (dev_hard_start_xmit+0xc4/0x3bc)
[  203.019963] [<c06c0828>] (dev_hard_start_xmit) from [<c06c13d8>] (__dev_queue_xmit+0x7c4/0x98c)
[  203.019974] [<c06c13d8>] (__dev_queue_xmit) from [<c0782f54>] (ip6_finish_output2+0x330/0xc1c)
[  203.019983] [<c0782f54>] (ip6_finish_output2) from [<c0788f0c>] (ip6_output+0x58/0x454)
[  203.019994] [<c0788f0c>] (ip6_output) from [<c07b16cc>] (mld_sendpack+0x420/0x744)

As this is an expected path to hsr_get_node() with frame coming from
the master interface, add a check to ensure packet is not from the
master port and then warn.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/hsr/hsr_forward.c  |    3 +--
 net/hsr/hsr_framereg.c |    9 +++++++--
 net/hsr/hsr_framereg.h |    2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -324,8 +324,7 @@ static int hsr_fill_frame_info(struct hs
 	unsigned long irqflags;
 
 	frame->is_supervision = is_supervision_frame(port->hsr, skb);
-	frame->node_src = hsr_get_node(&port->hsr->node_db, skb,
-				       frame->is_supervision);
+	frame->node_src = hsr_get_node(port, skb, frame->is_supervision);
 	if (frame->node_src == NULL)
 		return -1; /* Unknown node and !is_supervision, or no mem */
 
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -158,9 +158,10 @@ struct hsr_node *hsr_add_node(struct lis
 
 /* Get the hsr_node from which 'skb' was sent.
  */
-struct hsr_node *hsr_get_node(struct list_head *node_db, struct sk_buff *skb,
+struct hsr_node *hsr_get_node(struct hsr_port *port, struct sk_buff *skb,
 			      bool is_sup)
 {
+	struct list_head *node_db = &port->hsr->node_db;
 	struct hsr_node *node;
 	struct ethhdr *ethhdr;
 	u16 seq_out;
@@ -186,7 +187,11 @@ struct hsr_node *hsr_get_node(struct lis
 		 */
 		seq_out = hsr_get_skb_sequence_nr(skb) - 1;
 	} else {
-		WARN_ONCE(1, "%s: Non-HSR frame\n", __func__);
+		/* this is called also for frames from master port and
+		 * so warn only for non master ports
+		 */
+		if (port->type != HSR_PT_MASTER)
+			WARN_ONCE(1, "%s: Non-HSR frame\n", __func__);
 		seq_out = HSR_SEQNR_START;
 	}
 
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -18,7 +18,7 @@ struct hsr_node;
 
 struct hsr_node *hsr_add_node(struct list_head *node_db, unsigned char addr[],
 			      u16 seq_out);
-struct hsr_node *hsr_get_node(struct list_head *node_db, struct sk_buff *skb,
+struct hsr_node *hsr_get_node(struct hsr_port *port, struct sk_buff *skb,
 			      bool is_sup);
 void hsr_handle_sup_frame(struct sk_buff *skb, struct hsr_node *node_curr,
 			  struct hsr_port *port);
