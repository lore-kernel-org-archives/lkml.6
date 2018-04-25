Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653885-2-9570893013122642030
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
    1524653884; b=MWt4Jf0JjiJIYCsQ4+7eY/qi9VoPqbNYhn/szRErcCNcpTB5/4
    Zo9P8wd8ia40Fr/XicTqLDAIcfj+233nRiftT6iSjpemfYnPw/w8H6iort8XFFL2
    uYf1HFvpuPQ/LpB6MZCDqajFaTec6oMwNmCTIYFQiSoVZMXg7hBpGWVMu8y7pixB
    bY3GW5YEmCFKAsgymz3l9a2pNBRJBLowjtUZxhbETsL9rHzIa9sXyl1+Wqs7QBI2
    lQ4TallTZsSwuoXx2XgdY+/oVvg/52LWGu6LpnrQRl1+qI06EbHbVyG3seLcJH4Y
    LapOtULjwM3ypHSW7kpB+zpGoC8l+cDuMIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653884; bh=UePeVIGylLexUIgcc1hilub4IQ7ujy
    2nJM3fKRCAHoU=; b=QFegPD+jOMCcQmpJOERvXYCDzq4c/8rZCVTxwrPmreJ9u0
    pByW1CshLEGQhClF1dcnzfoKCY3cTevflwmBNcAcQxoBoaCTfWJrRgyxxEFgOjWA
    w/K14msr5Sgpj08K3IHrF0HHNB+zQj6ociso4c6VR83uOYCD6bNC4/oTgZLPWkiW
    mS3fqO2PDsHwWqlK/2bs3AMdE29msrNmhe4p00VGC56ZtPxDS4kFKH/iF7HAb5PC
    A8QgIT+/PNQRgiEBlJxY/WoGEcTXZ/g1nkQ4DExt7rpR3SxYrjO8pZkKZJJOinrB
    I6rFz/1TmMtc/pfQV1dXQXqt9QjwnZcoFnEqDvRw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfK6bpZdS0iEH/YFvzF6QiLtoDx9skBsXNSPreZVgBq0M6DQ51sLip3muWB59GCNUc2sY37Yy2HpYAwVk6MC38Cyph+8ybJ2EOmgZ4QLDPuF9RQQYoXVU
    PBpKPU1760bR4mWzxRT9/TfDXIjJnCNdK8wwoxuo5E27tJyVKKh+MCh1afW3xS4yVZFfFNsvN0qQG5VXWKoJiSJAzn8+or8Y8HuVQbdQDCuJZVvPpR68cPxu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=DYjp3tQfXsJm4qdJRokA:9 a=QEXdDO2ut3YA:10 a=KCsI-UfzjElwHeZNREa_:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeDYK5d (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:57:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52860 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754174AbeDYKnF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:43:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 141/183] bpf: sockmap, fix leaking maps with attached but not detached progs
Date: Wed, 25 Apr 2018 12:36:01 +0200
Message-Id: <20180425103248.215506927@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: John Fastabend <john.fastabend@gmail.com>


[ Upstream commit 3d9e952697de89b53227f06d4241f275eb99cfc4 ]

When a program is attached to a map we increment the program refcnt
to ensure that the program is not removed while it is potentially
being referenced from sockmap side. However, if this same program
also references the map (this is a reasonably common pattern in
my programs) then the verifier will also increment the maps refcnt
from the verifier. This is to ensure the map doesn't get garbage
collected while the program has a reference to it.

So we are left in a state where the map holds the refcnt on the
program stopping it from being removed and releasing the map refcnt.
And vice versa the program holds a refcnt on the map stopping it
from releasing the refcnt on the prog.

All this is fine as long as users detach the program while the
map fd is still around. But, if the user omits this detach command
we are left with a dangling map we can no longer release.

To resolve this when the map fd is released decrement the program
references and remove any reference from the map to the program.
This fixes the issue with possibly dangling map and creates a
user side API constraint. That is, the map fd must be held open
for programs to be attached to a map.

Fixes: 174a79ff9515 ("bpf: sockmap with sk redirect support")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/sockmap.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -601,11 +601,6 @@ static void sock_map_free(struct bpf_map
 	}
 	rcu_read_unlock();
 
-	if (stab->bpf_verdict)
-		bpf_prog_put(stab->bpf_verdict);
-	if (stab->bpf_parse)
-		bpf_prog_put(stab->bpf_parse);
-
 	sock_map_remove_complete(stab);
 }
 
@@ -877,6 +872,19 @@ static int sock_map_update_elem(struct b
 	return err;
 }
 
+static void sock_map_release(struct bpf_map *map, struct file *map_file)
+{
+	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
+	struct bpf_prog *orig;
+
+	orig = xchg(&stab->bpf_parse, NULL);
+	if (orig)
+		bpf_prog_put(orig);
+	orig = xchg(&stab->bpf_verdict, NULL);
+	if (orig)
+		bpf_prog_put(orig);
+}
+
 const struct bpf_map_ops sock_map_ops = {
 	.map_alloc = sock_map_alloc,
 	.map_free = sock_map_free,
@@ -884,6 +892,7 @@ const struct bpf_map_ops sock_map_ops =
 	.map_get_next_key = sock_map_get_next_key,
 	.map_update_elem = sock_map_update_elem,
 	.map_delete_elem = sock_map_delete_elem,
+	.map_release = sock_map_release,
 };
 
 BPF_CALL_4(bpf_sock_map_update, struct bpf_sock_ops_kern *, bpf_sock,
