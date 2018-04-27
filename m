Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839361-2-15656465297984118700
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
    1524839360; b=HTM6dzpNwqDCjXfGe4cuCXKODQnxc31d/QQ2RV5dddj0Uh9WK0
    J4mYVMWR2DM6X9To5VmqlcNN7uwHdnRwb7BqEowrUqPxFrGg/IH6ItV0dvKq+Aiv
    oZJHNqEfcpiVTAkKRcbUmopu9Yv/YW28pZTwctbyJgQjBZCo7H7vT6bBWm4WkJUJ
    E/7f4YzuzKWK2mu5YOK47lfpECx5j0PIUtjn/e/bkKZtRckA2evB/FN4wgli3h7J
    LtfTeHu+Asb/7Lscn2LZDGbB5Yd/wDmXzbMKS/1hKr2wu/11qI+rd5RYwuIF30ZO
    fKzXe7zOYxiDyeSQiGfKo3Vyp4qRi7oqBamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839360; bh=QojBfPUZBw4payw+xmfOCFnwXhAVcV
    RdMf/tSulPdfE=; b=NnG79ZeRVGzfU782NqCHX0Hgg0Q/y8CB33aq5WF4HA3JkN
    KdRhdvNK2lyM2PB7fxae1vn/2Jsijb5jjLeZxDmr09pFw8VPX9SGGI1dkwg8rPuL
    n9l5CIXtDCOs2YEhxtrJNXZCiHi3RcISsKChQD8JFcoKFUY5M4fqJs3YwOnsPq4+
    lkIbE7Tbb3ShEMj65vj6z42nyr8m3CP3QfHgeb/O2tCWKLaYiRX5WWyHNZVqa0wL
    nRToMEunBVA7Wt2yh5aGyzIRnwdO2bYv0fTlmK4fs0VPlMMWw39QbKNiheDjHFPo
    KVH1JUo9l4FsdQjqb3T+n+0gDYdTlQ/1rXQyLqDA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfPG/f+LVjRt0/64R1y467NI2U/e2GiPQNvaiT4iw818ExWx+kpL1vjnsUuzEuS+RiWPCwsuopa6QAPCOp6ka5NcMJJ0S35zmI2/ogHpKGvw1Su0Vesqa
    XmdZVcddmvGhdduFDUvBk5nt2p87QLyF/Tcs16wg7WMAn2S3BkLmHTsvtSk7tS1DxfSIeay1deqQsMnpNdbc0btG0GMcsB8Cjcr5jkwc4X6wehcqsN/PlCvk
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=eh1Yez-EAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=EIqoDTw9sgbaII3D_O4A:9
    a=FUPER-ISmEGs5ufQ:21 a=vGe3rE3NxhcbhR0Z:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934977AbeD0O3B (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932916AbeD0OLJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:11:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855F72189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronak Doshi <doshir@vmware.com>,
        Guolin Yang <gyang@vmware.com>, Louis Luo <llouis@vmware.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 34/81] vmxnet3: fix incorrect dereference when rxvlan is disabled
Date: Fri, 27 Apr 2018 15:58:36 +0200
Message-Id: <20180427135744.984141762@linuxfoundation.org>
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

From: Ronak Doshi <doshir@vmware.com>


[ Upstream commit 65ec0bd1c7c14522670a5294de35710fb577a7fd ]

vmxnet3_get_hdr_len() is used to calculate the header length which in
turn is used to calculate the gso_size for skb. When rxvlan offload is
disabled, vlan tag is present in the header and the function references
ip header from sizeof(ethhdr) and leads to incorrect pointer reference.

This patch fixes this issue by taking sizeof(vlan_ethhdr) into account
if vlan tag is present and correctly references the ip hdr.

Signed-off-by: Ronak Doshi <doshir@vmware.com>
Acked-by: Guolin Yang <gyang@vmware.com>
Acked-by: Louis Luo <llouis@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vmxnet3/vmxnet3_drv.c |   17 +++++++++++++----
 drivers/net/vmxnet3/vmxnet3_int.h |    4 ++--
 2 files changed, 15 insertions(+), 6 deletions(-)

--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1218,6 +1218,7 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapt
 	union {
 		void *ptr;
 		struct ethhdr *eth;
+		struct vlan_ethhdr *veth;
 		struct iphdr *ipv4;
 		struct ipv6hdr *ipv6;
 		struct tcphdr *tcp;
@@ -1228,16 +1229,24 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapt
 	if (unlikely(sizeof(struct iphdr) + sizeof(struct tcphdr) > maplen))
 		return 0;
 
+	if (skb->protocol == cpu_to_be16(ETH_P_8021Q) ||
+	    skb->protocol == cpu_to_be16(ETH_P_8021AD))
+		hlen = sizeof(struct vlan_ethhdr);
+	else
+		hlen = sizeof(struct ethhdr);
+
 	hdr.eth = eth_hdr(skb);
 	if (gdesc->rcd.v4) {
-		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IP));
-		hdr.ptr += sizeof(struct ethhdr);
+		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IP) &&
+		       hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IP));
+		hdr.ptr += hlen;
 		BUG_ON(hdr.ipv4->protocol != IPPROTO_TCP);
 		hlen = hdr.ipv4->ihl << 2;
 		hdr.ptr += hdr.ipv4->ihl << 2;
 	} else if (gdesc->rcd.v6) {
-		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IPV6));
-		hdr.ptr += sizeof(struct ethhdr);
+		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IPV6) &&
+		       hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IPV6));
+		hdr.ptr += hlen;
 		/* Use an estimated value, since we also need to handle
 		 * TSO case.
 		 */
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,10 +69,10 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.4.13.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.4.14.0-k"
 
 /* a 32-bit int, each byte encode a verion number in VMXNET3_DRIVER_VERSION */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01040d00
+#define VMXNET3_DRIVER_VERSION_NUM      0x01040e00
 
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */
