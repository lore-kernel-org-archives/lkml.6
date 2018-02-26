Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3776141-1519677376-3-13938608649717542657
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519677375; b=g1X1RlOX6FZkPGvhos22fEm69gFvf4D74OthYa+cPtIzOSh
    ddl0fpPlwNQU1+b8ON4lU5DYDriQgWl96gV1n28uqCwXr6sHJyGsRZ4wJMmTm/qI
    JHalGOBXmnk/KrQtMC1hG6eoMSBUfS7SL2Dpra6LQzxvQzQ7H0vD7+dRx5t30DcR
    a5qjvgQNiUimXeDA5G8RudtBMIs/XKtbO4IPRzNUSIn9aCix+Zg79+8nbWXD/8dz
    9i5wFHXlBC4oy4I5Fi66s1SlC3C6T61DSB+UtolfTBFln9Ges0J5GDi8uSTM98BC
    EPgjW9G0OEF9ftNv6VYhtAoarXL28cO/yIY+jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519677375; bh=K3gPZLwdIKx87aznDSeQJGLS/d
    UryKbxX1kkznKelbA=; b=oVQme8Ycfi2/Ws6aoPyZfCv8lO3fGIJzD5D0uru/kK
    am79WHMgbXuM3vflyqQghtC7NHg+EhNlczk1x8Y6rInsGsxtXYKIulnYt8vKXRal
    Scqmvcj2hLUP00Sdfj65wlLT0YsnzWF9IU4+xatmrtwi73aOI6ZlUIO6kCivqN1L
    TIukftic851V8cvN60eLA1zfxbQcc1LFnM6ppFRHiVQR64VhjPGIymjeSwytOp2c
    tjrdb8OPbQgYzLKvJ8bqiLvcFPUkg4rjXrw1DZ8tgAKHMGedAW/Ac1BEvnFMnA82
    SmB+jXEZcbhMOuHBQS7CPp73C4LwJEDAiFy46RGC8YdQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753771AbeBZU1q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:27:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36846 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753766AbeBZU1p (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:27:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Weiser <michael.weiser@gmx.de>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 40/64] arm64: Disable unhandled signal log messages by default
Date: Mon, 26 Feb 2018 21:22:17 +0100
Message-Id: <20180226202155.161225789@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Weiser <michael.weiser@gmx.de>

commit 5ee39a71fd89ab7240c5339d04161c44a8e03269 upstream.

aarch64 unhandled signal kernel messages are very verbose, suggesting
them to be more of a debugging aid:

sigsegv[33]: unhandled level 2 translation fault (11) at 0x00000000, esr
0x92000046, in sigsegv[400000+71000]
CPU: 1 PID: 33 Comm: sigsegv Tainted: G        W        4.15.0-rc3+ #3
Hardware name: linux,dummy-virt (DT)
pstate: 60000000 (nZCv daif -PAN -UAO)
pc : 0x4003f4
lr : 0x4006bc
sp : 0000fffffe94a060
x29: 0000fffffe94a070 x28: 0000000000000000
x27: 0000000000000000 x26: 0000000000000000
x25: 0000000000000000 x24: 00000000004001b0
x23: 0000000000486ac8 x22: 00000000004001c8
x21: 0000000000000000 x20: 0000000000400be8
x19: 0000000000400b30 x18: 0000000000484728
x17: 000000000865ffc8 x16: 000000000000270f
x15: 00000000000000b0 x14: 0000000000000002
x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0008000020008008
x9 : 000000000000000f x8 : ffffffffffffffff
x7 : 0004000000000000 x6 : ffffffffffffffff
x5 : 0000000000000000 x4 : 0000000000000000
x3 : 00000000004003e4 x2 : 0000fffffe94a1e8
x1 : 000000000000000a x0 : 0000000000000000

Disable them by default, so they can be enabled using
/proc/sys/debug/exception-trace.

Cc: <stable@vger.kernel.org>
Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/traps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -57,7 +57,7 @@ static const char *handler[]= {
 	"Error"
 };
 
-int show_unhandled_signals = 1;
+int show_unhandled_signals = 0;
 
 static void dump_backtrace_entry(unsigned long where)
 {
