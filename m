Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3611583-1525407355-2-13486414659358148410
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525407355; b=H6IrkTcKDSUxp4L5/A/78iLoYrPhy5eo5+XaWbceAtKU5D16sX
    zQgo0rE6NsYsrLQAQQGEHfbxeDtzLfTOUv6srJ+ga40YPCYpi9JdPc+YWhy3vABK
    UCKwV5YPiLki5zWSq3BI2Gxb+IrZyWJrMIAcS4TamS6pOYZW202BOp/8ANI35yKT
    8hrEnyRsXKfBJNxFIRfqpL0IrYJz6TJOUxePDWjnF2saCIKdx11gn1kP+95vAao9
    Dpiw8riFFGBOUTc/MPBdQmHqrHRb0RQmhLhAttlBQ1jLCdxg8WzAb1wy2a5FcR5n
    0Y9IV1yJ4iV6i6o/Jxng2e7OWpNsRtzcCZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525407355;
    bh=4bBbXp0pCCqzZyqFoVCpIHaH6r3DL26JWrSraUTRQOg=; b=jcmbVFCBBlBD
    yLXiA5oBdXwaB4Dc/+MYDBJCTwlrsgnoNMMwrP6yKap94UK3RYJxMqtcM6NxrnHK
    9/BShUq+IuVB+Y4czRBnBJpZitl18oJBOrkqNRWzzczYZuV0SYlQX65aipPc1fsx
    CQ093LGkHX7Xihj86TdVn+G+vCMinVzL5DmhxM8Ewu5FdUqpRBdK1iz79TM1m+Qi
    x7Bujz+yoSJUUcjjSSCGFejuRMlE1GS+ohXy8P2yY66a/9lNforGxp2mQRDKKKGM
    OOsRI2AKaIJJ3wcT/+R6BEGYhKl/czj6GU0PLgFMnILwQHLy6IspCh9Q61qL6nzO
    aDDm+2zHDw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=uBdbMCWf x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=uBdbMCWf x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHG2Z9X1gtFvSqpg0hX8jN6VAdF4VKoCz0cvuKexd9YfaL9i/LYtz+wFmTIdo652564VQrBIgAe26aptBW3G8jYCfXq3QgofwD2TmY8tG1zkz1y9BGJf
    3tAgE05vbeVQJ78yuARxb68Zf1F/CcxBlgDgZFLh4V+iAshZOPvpRr2Sfu8EYsaEcE8qmxM6omQwVFuK4/wI4eVM+LZMCzdf77jRCE7YOedSKPfp8Xjvk81I
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ZULaGYWSKZfac68WfhMA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeEDEPx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 00:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbeEDEPx (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 4 May 2018 00:15:53 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>,
        Jon Medhurst <tixy@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, David Long <dave.long@linaro.org>,
        stable@vger.kernel.org
Subject: [BUGFIX PATCH v3 2/4] arm: kprobes: Prohibit probing on optimized_callback
Date: Fri,  4 May 2018 13:15:29 +0900
Message-Id: <152540732952.29650.11645105922811248579.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152540727123.29650.13679359124038587629.stgit@devbox>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Prohibit probing on optimized_callback() because
it is called from kprobes itself. If we put a kprobes
on it, that will cause a recursive call loop.
Mark it NOKPROBE_SYMBOL.

Fixes: 0dc016dbd820 ("ARM: kprobes: enable OPTPROBES for ARM 32")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm/probes/kprobes/opt-arm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index ddc5a82eb10d..b2aa9b32bff2 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -192,6 +192,7 @@ optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
 
 	local_irq_restore(flags);
 }
+NOKPROBE_SYMBOL(optimized_callback)
 
 int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
 {
