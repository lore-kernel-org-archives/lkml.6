Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039319-1523472088-2-12767282346552826415
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
    1523472087; b=aCtCJpSL0cpfOPc16CeJLbjAdLvxqaLYuSdQZN6gYH89GK0Hck
    FDSFf6yjtB2Br9AyBOaF4PzM99Q/jFHFDDGOhjP0IlTTkFMMYRcaUwUzCegJbjbP
    IrR343SpLAfgUJuANbk2duZOHq8b9NQWozJfXhMqhgGSVjvGSg0+wK8SKHeXp9mt
    GQ+kcadDJ6EN/vdV8wb6jcl9au1HXhv2O9GVlCE+rM3vLOfurKyiiv8KwQRrxmTs
    9f2N04IGYVNq7oOyTbOafqNWKHZ9xW2/jZ5Vk2psjIKmh6bebBZIiHrYPwXkEQPu
    AchPp2o2TDYY8jZCQWtf5YNRYnxKXQEHKVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472087; bh=L+C+x5Z+XqN284FNP3zFvaNO7P9bL/
    DrcWaTF0pDhbw=; b=DbL9+BBdQzRN3TFge9cOol2xTUf0Yha3Lm+I1GXMRhKL77
    r+ynDWy7KajSkc/QHJLdkVapkUguv48vxpbYW1DVjEKsE0AlxaO7MdEleg15ujvZ
    gUxn5H4PgiAOtT2nK+70/3eSPKKfZ7y1Myn9Vntt1I+C1rxPa2AAtcAxpSD3eyIC
    u1W/SOTpeudFiI52HrtSicvDEfHA/3EV655gwF2DghjuyZjXZAn0o/8ibnLaSYhP
    2AFhA3TG5YDuY8t0vJu/pN5K7cmeMuaOGsNQoEp1zWglIQr3Rn1lVtqx/uUcA0q0
    kDXjAGOnDgMWHVDXKPE0Ez9MMNSgwvQfKL1SpcSQ==
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
X-CM-Envelope: MS4wfIBZoyXr9SgiuessTQMY9yUh0i5HykO/KfNavDg1tAJ4JLttc1IwgnsUsGvMPcQPRzomKDz8DKPUrKvR4kiVZIveSlRL8GHUM7yGBmrbvR7zmah1iDTh
    e8t8yFhLnr4ZClNMpEwoztFtrVYDblEiTlyA10BlHnDdFTykv0CKBkdnk+iKUxorqqIYUE4WCfUcrlH55r3hrHp2uJVEnWx4XcQ8W2pM8PiqqQzhqkKiAXyF
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=m57dygxWIdCukqG92xcA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
    a=S-HzPIwwDS8t1QcwSuWs:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754816AbeDKSlW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:41:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56778 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754698AbeDKSlU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:41:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 078/121] MIPS: kprobes: flush_insn_slot should flush only if probe initialised
Date: Wed, 11 Apr 2018 20:36:21 +0200
Message-Id: <20180411183500.921236032@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>


[ Upstream commit 698b851073ddf5a894910d63ca04605e0473414e ]

When ftrace is used with kprobes, it is possible for a kprobe to contain
an invalid location (ie. only initialised to 0 and not to a specific
location in the code). Trying to perform a cache flush on such location
leads to a crash r4k_flush_icache_range().

Fixes: c1bf207d6ee1 ("MIPS: kprobe: Add support.")
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16296/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/kprobes.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/mips/include/asm/kprobes.h
+++ b/arch/mips/include/asm/kprobes.h
@@ -40,7 +40,8 @@ typedef union mips_instruction kprobe_op
 
 #define flush_insn_slot(p)						\
 do {									\
-	flush_icache_range((unsigned long)p->addr,			\
+	if (p->addr)							\
+		flush_icache_range((unsigned long)p->addr,		\
 			   (unsigned long)p->addr +			\
 			   (MAX_INSN_SIZE * sizeof(kprobe_opcode_t)));	\
 } while (0)
