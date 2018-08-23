Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CF7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8658A20839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8658A20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbeHWMW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:22:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52048 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbeHWMW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:22:27 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0281E49B;
        Thu, 23 Aug 2018 08:53:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 187/324] samples/bpf: add missing <linux/if_vlan.h>
Date:   Thu, 23 Aug 2018 09:54:13 +0200
Message-Id: <20180823075005.535955578@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taeung Song <treeze.taeung@gmail.com>

[ Upstream commit 4d5d33a085335ef469c9a87792bcaaaa8e64d8c4 ]

This fixes build error regarding redefinition:

    CLANG-bpf  samples/bpf/parse_varlen.o
  samples/bpf/parse_varlen.c:111:8: error: redefinition of 'vlan_hdr'
  struct vlan_hdr {
         ^
  ./include/linux/if_vlan.h:38:8: note: previous definition is here

So remove duplicate 'struct vlan_hdr' in sample code and include if_vlan.h

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 samples/bpf/parse_varlen.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/samples/bpf/parse_varlen.c
+++ b/samples/bpf/parse_varlen.c
@@ -6,6 +6,7 @@
  */
 #define KBUILD_MODNAME "foo"
 #include <linux/if_ether.h>
+#include <linux/if_vlan.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/in.h>
@@ -108,11 +109,6 @@ static int parse_ipv6(void *data, uint64
 	return 0;
 }
 
-struct vlan_hdr {
-	uint16_t h_vlan_TCI;
-	uint16_t h_vlan_encapsulated_proto;
-};
-
 SEC("varlen")
 int handle_ingress(struct __sk_buff *skb)
 {


