Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520641576-2-2391339437173525734
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520641576; b=nc8zOIBlCEX2sp6RN/wKRwb6hZo08QReb81wbqHhgUjoV0O
    3Tc+jHIL1waNoCSQCaGE15QmM2lLIBWNb2duhExR1rGidixUnmXNwQVhXwFl8vAs
    gZWvlznBsWOdnjQhcdQjbZlRn82udaTy2qD6RlXGBngZe2UxifbTLaE3z1OoEC7k
    vwz8QI5rgRaok/kr86Ilc+4W3Qku30lBpS7HVKwy04vgi0tvI3GFBXk4jPSu4+Pi
    iKBeK/d3HVYSS0g2oyK6QHsvSmKLGvjqDvL9R39Eec+CVKF+s544vQzXqfR9BwQE
    Be0QatZGvXeF3z4umn9pnc4zDIaYvEPPDmwNspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641576; bh=7SHuI/2JQcsTs6lTq9JFtXSPrH
    D3gTZ1+MQL+FW1cMc=; b=oIq4RoNk8IKg51FOeE6FFfkdEFWz5AFas/ji0r2Cw0
    865olPveGX2GU1oZa/HQZUEahqiKjfjjA1+w8lNe1k4VxcCVX+gcJT6pX9Jtb9zB
    9gjoGP8A96WsIXxPFXr4FU+E4kMi8fkJCekRK5TXq3HNKURaR4E1wgi3cbYSBGmX
    jKXMTzqIhmSvz5DYJkKCOOOZIAfl6pMsPmZ7R0aGFj+ERewJyfV+DbzgV295SqKd
    Pg4BBqCSH99pvdbwKwKoJt3hNCoN/8LgSrgzI6Jfg0mg71dqzjVXq8arODHVcS7G
    COCmFiYDUwux/B0Lq68584x089s88p61r0tqiwriSz4w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933583AbeCJA0A (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:26:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40882 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933798AbeCJAXg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:23:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "ast@kernel.org, daniel@iogearbox.net, stable@vger.kernel.org, Dennis
        Zhou" <dennisszhou@gmail.com>,
        syzbot+adb03f3f0bb57ce3acda@syzkaller.appspotmail.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Dennis Zhou <dennisszhou@gmail.com>
Subject: [PATCH 4.15 01/11] bpf: fix mlock precharge on arraymaps
Date: Fri,  9 Mar 2018 16:19:15 -0800
Message-Id: <20180310001834.624988627@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001834.560857664@linuxfoundation.org>
References: <20180310001834.560857664@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ upstream commit 9c2d63b843a5c8a8d0559cc067b5398aa5ec3ffc ]

syzkaller recently triggered OOM during percpu map allocation;
while there is work in progress by Dennis Zhou to add __GFP_NORETRY
semantics for percpu allocator under pressure, there seems also a
missing bpf_map_precharge_memlock() check in array map allocation.

Given today the actual bpf_map_charge_memlock() happens after the
find_and_alloc_map() in syscall path, the bpf_map_precharge_memlock()
is there to bail out early before we go and do the map setup work
when we find that we hit the limits anyway. Therefore add this for
array map as well.

Fixes: 6c9059817432 ("bpf: pre-allocate hash map elements")
Fixes: a10423b87a7e ("bpf: introduce BPF_MAP_TYPE_PERCPU_ARRAY map")
Reported-by: syzbot+adb03f3f0bb57ce3acda@syzkaller.appspotmail.com
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Dennis Zhou <dennisszhou@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/arraymap.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -52,11 +52,11 @@ static int bpf_array_alloc_percpu(struct
 static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 {
 	bool percpu = attr->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
-	int numa_node = bpf_map_attr_numa_node(attr);
+	int ret, numa_node = bpf_map_attr_numa_node(attr);
 	u32 elem_size, index_mask, max_entries;
 	bool unpriv = !capable(CAP_SYS_ADMIN);
+	u64 cost, array_size, mask64;
 	struct bpf_array *array;
-	u64 array_size, mask64;
 
 	/* check sanity of attributes */
 	if (attr->max_entries == 0 || attr->key_size != 4 ||
@@ -101,8 +101,19 @@ static struct bpf_map *array_map_alloc(u
 		array_size += (u64) max_entries * elem_size;
 
 	/* make sure there is no u32 overflow later in round_up() */
-	if (array_size >= U32_MAX - PAGE_SIZE)
+	cost = array_size;
+	if (cost >= U32_MAX - PAGE_SIZE)
 		return ERR_PTR(-ENOMEM);
+	if (percpu) {
+		cost += (u64)attr->max_entries * elem_size * num_possible_cpus();
+		if (cost >= U32_MAX - PAGE_SIZE)
+			return ERR_PTR(-ENOMEM);
+	}
+	cost = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
+
+	ret = bpf_map_precharge_memlock(cost);
+	if (ret < 0)
+		return ERR_PTR(ret);
 
 	/* allocate all map elements and zero-initialize them */
 	array = bpf_map_area_alloc(array_size, numa_node);
@@ -118,20 +129,13 @@ static struct bpf_map *array_map_alloc(u
 	array->map.max_entries = attr->max_entries;
 	array->map.map_flags = attr->map_flags;
 	array->map.numa_node = numa_node;
+	array->map.pages = cost;
 	array->elem_size = elem_size;
 
-	if (!percpu)
-		goto out;
-
-	array_size += (u64) attr->max_entries * elem_size * num_possible_cpus();
-
-	if (array_size >= U32_MAX - PAGE_SIZE ||
-	    bpf_array_alloc_percpu(array)) {
+	if (percpu && bpf_array_alloc_percpu(array)) {
 		bpf_map_area_free(array);
 		return ERR_PTR(-ENOMEM);
 	}
-out:
-	array->map.pages = round_up(array_size, PAGE_SIZE) >> PAGE_SHIFT;
 
 	return &array->map;
 }
