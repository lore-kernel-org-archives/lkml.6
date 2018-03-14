Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-693261-1521003849-2-12598001616851326930
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521003848; b=IN5yCpFDAUeaQYeCgovrIrIwzOtS6gaCpMh2MkGhZsO9mmc
    faE8XRyFAVW+7KE/QHqCNJ97XKBG4SvVRDPS8duk96eGRyXV8VbEzZ8G4A45Q8ff
    8TevkgTAzrer6c17yCiT8Wfe4wpnQ1cr/DkOiOp8FMh6d/zNklPD+fFhagAHrt3O
    dbD964upfagXLnWne2Lh93hbJphFqENpYu+PEPAtTUYTmTIJgfghIKXHttGqgmYC
    KHzO5wgd9L0QTESXvPmnZJjPQoUfcfa+jvyJD3/D1YNZ86fbbu+iDfjc94N7bzAq
    4SlUEOHvvGh8iFQEyuIfXjxMeVwhhZVRPAdXY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1521003848; bh=oSez32SEFXCO5KBums9jmm2CCfPmNKj+im1
    hg7kxqis=; b=PXZNk2STvjOdzqG2WOYrQ7fvFTcLejodFgwfTJT+fSH+cyVYYYy
    Smqk6jIviN/dmJv+o7+2EXpg1oKtwmbj0wGcJvTTgW+i7Az6iSikzBPH0jruvy7k
    LLyMVbFe+icChxv2bx0Kv0Xs5KAWFPoM1VCFA0VCbzyg3AIsm5g/2fIjMwqBTbOI
    T1+/ynCm/7jXg/+cwFbPCYYYt43TnCvfvCUAtH3nn/ruaNY884fpLBC9UMBUvbI4
    5REujq/mxzMQsLWDQs4PzFMfWIt7/IZwD04/+sjJE8Mf8eMOS/tZtOC6w4Bo9nGI
    M2qrsHhXnny2/EfdfcWY9YAyIzdKB3C6jjw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeCNFDx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 01:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbeCNFDR (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 14 Mar 2018 01:03:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2CF2176E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
From: Andy Lutomirski <luto@kernel.org>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Stas Sergeev <stsp@list.ru>,
        bartoldeman@gmail.com, Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 1/3] selftests/x86/entry_from_vm86: Exit with 1 if we fail
Date: Tue, 13 Mar 2018 22:03:10 -0700
Message-Id: <b1cc37144038958a469c8f70a5f47a6a5638636a.1521003603.git.luto@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1521003603.git.luto@kernel.org>
References: <cover.1521003603.git.luto@kernel.org>
In-Reply-To: <cover.1521003603.git.luto@kernel.org>
References: <cover.1521003603.git.luto@kernel.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix a logic error that caused the test to exit with 0 even if test
cases failed.

Cc: stable@vger.kernel.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/entry_from_vm86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/entry_from_vm86.c b/tools/testing/selftests/x86/entry_from_vm86.c
index 361466a2eaef..6e85f0d0498d 100644
--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -318,7 +318,7 @@ int main(void)
 	clearhandler(SIGSEGV);
 
 	/* Make sure nothing explodes if we fork. */
-	if (fork() > 0)
+	if (fork() == 0)
 		return 0;
 
 	return (nerrs == 0 ? 0 : 1);
-- 
2.14.3
