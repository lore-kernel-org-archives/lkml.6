Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520641669-2-14338933620093138050
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
    t=1520641668; b=kR6xSM80gGvakDv4ad4m1IKvvwptsoRogvOEURolvXvNzyk
    OITfpNP/K6MLNgIUfVEgfP51yCbQYs8Ys6C8RjmUO7tYw93S/8GKEQG3+nhcoy07
    siF4AKXAr/M5qEIK0ATECrJAQQ0H11V+e8t07s5qqvUnGn8P6MwNs6FN6LbgAJ6D
    zepvicf2S7VdfHjZbnZZlg7DccW7+xZHa7sp2c+ssD7MrPv3AEaWoVLdb97Os5Wn
    kmuWqesqiZr2MRZwNveCPdA9EKYtTpNNyNA2i+2RzUg2mKtothnJPc/7NtNm9yf5
    mRN6acpWQJcqGvhixkhNwSyOihtbdniTcVuJ0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641668; bh=MEpSbEklJ18y+aTrQ+KmxJ1E+q
    /BEm+PlAHEhtN10Cg=; b=ifl/jPPXtPkxqWFznaDHUciMTxJgvELMdv5tt41Hbk
    aUT6ReiwulbvSKqj1za1dsb90vtb5kVcLOO3SgRzUEG9UFO1Qy0PJbTJW41L4vU+
    grOuWMFoDlwBmyal4QU/bX246j3pLJoYWKbxQGj816nvKO/FJ1A79HcVA7GjalRB
    x+YKEcyPBlIo8Ay+inhRNa0QNgzocRxutASOA8b3vo9RkMj6pnJjMzJKQVyNwbR0
    z8vP6pr3zxDAkVer4k1YAVbuU2FJ24Kv0+PNlgPKd7elSs1C5C3zpUFGBD2wkdNm
    ouWZebUzEp7MRxLOXcAMb15RPO7xFJnXiGu0bLtRJCkQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S934051AbeCJA1c (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:27:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40406 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934064AbeCJAXR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:23:17 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "ast@kernel.org, daniel@iogearbox.net, stable@vger.kernel.org, Yonghong
        Song" <yhs@fb.com>, Mathieu Malaterre <malat@debian.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH 4.14 2/9] bpf: fix memory leak in lpm_trie map_free callback function
Date: Fri,  9 Mar 2018 16:19:07 -0800
Message-Id: <20180310001828.656537139@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001828.476933393@linuxfoundation.org>
References: <20180310001828.476933393@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonghong Song <yhs@fb.com>

[ upstream commit 9a3efb6b661f71d5675369ace9257833f0e78ef3 ]

There is a memory leak happening in lpm_trie map_free callback
function trie_free. The trie structure itself does not get freed.

Also, trie_free function did not do synchronize_rcu before freeing
various data structures. This is incorrect as some rcu_read_lock
region(s) for lookup, update, delete or get_next_key may not complete yet.
The fix is to add synchronize_rcu in the beginning of trie_free.
The useless spin_lock is removed from this function as well.

Fixes: b95a5c4db09b ("bpf: add a longest prefix match trie map implementation")
Reported-by: Mathieu Malaterre <malat@debian.org>
Reported-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/lpm_trie.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -470,7 +470,10 @@ static void trie_free(struct bpf_map *ma
 	struct lpm_trie_node __rcu **slot;
 	struct lpm_trie_node *node;
 
-	raw_spin_lock(&trie->lock);
+	/* Wait for outstanding programs to complete
+	 * update/lookup/delete/get_next_key and free the trie.
+	 */
+	synchronize_rcu();
 
 	/* Always start at the root and walk down to a node that has no
 	 * children. Then free that node, nullify its reference in the parent
@@ -484,7 +487,7 @@ static void trie_free(struct bpf_map *ma
 			node = rcu_dereference_protected(*slot,
 					lockdep_is_held(&trie->lock));
 			if (!node)
-				goto unlock;
+				goto out;
 
 			if (rcu_access_pointer(node->child[0])) {
 				slot = &node->child[0];
@@ -502,8 +505,8 @@ static void trie_free(struct bpf_map *ma
 		}
 	}
 
-unlock:
-	raw_spin_unlock(&trie->lock);
+out:
+	kfree(trie);
 }
 
 static int trie_get_next_key(struct bpf_map *map, void *key, void *next_key)
