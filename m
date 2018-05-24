Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527163635-2-11858368687296895375
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163635; b=aszLb1lflJjrXEXSJyHNBV9UUEuhiUnFamu7rxTusCD4PxPkBC
    D7bO407bW/zzNKnMD6JP6Zqzcg1VyLHq3E47hc4ufMZkuu8RT+Bkui0EzGcmocif
    TSeRFyiVJEq7GWCPV+HVX98DgitPWtZrZTBOOG+rWYJ5w8M+4rOR3xwsMHRq45wg
    0GCYaG1glvHgcjcgqt2eCijpP14IjbPs+188PnN1oAFQPPe4OYUtWCEoox3MwNbh
    16TIbaehrArlp+/nfDgVDPN3KDGyv6o5qVFI+Fk5OGavHsFX4czVafi1L8vdbVbp
    U2Y3io2ZKLm8YSRDRo5qPse6c1NGBzvMf/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163635; bh=bEGuFokpmJkJPl6a1bWCWwIkDA5CmU
    3KknEPf5Qnrno=; b=N2bbAgo5P0WBZs6Vp6R8/Z9Uxl38a47NcL3O+WjnoS+s1s
    T0KhRfeFZRbKmJY1fcEKL4ocVUsad51gd/EH2evqlpTidXMNcANgNyckxVa7lDUn
    aEi1A6MPTdGRNM3wTTYmwLCd5rHSB4mb8J8A/CeA6K9cClwVBJkGYVJyhOZEN7DY
    wO5dDr+YECE1ewYtRDBK/K1VqDdRmsmHGZ3QFkDpiuQ5vYYybBbSq/de112xNUju
    ZmyjJGtzO16jg2WZ1pqHJl1ZKGrLNRQQMJehx7x4Q9uZ9d0X6j5OUzvWsLlsiklm
    ymxkw5pPTp3Vm0A6T6kIrx4nVIgLI7bY/IE0FWSA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=TmjPQCh+ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=TmjPQCh+ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfObZBfTODTcFC1ZPjbJFAE4z++VEHSuY7KgVHzuhvobsaCaLl3fF+4YlrvVrF+w7rYyFIMc1YRAeCiyJq0UQxq2nPzYOzpsB0XVGQbRnyhMSeDHermQH
    hh3KZXalGX+/IN+v1a3NQAdLy+8Z+5prcYn+7wLv1x1SZDoF4zzwJqAO8W3dIkm4VlTWXU+YnG5QF8RcYA8gzehjiSZ/Zmjq8lDZh5vqwPNHQ5ZxIWZjImoX
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8 a=ag1SF4gXAAAA:8
    a=MDz0VIy7dXfzDBeg1A4A:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969557AbeEXMHC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966170AbeEXJn4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 31/92] futex: futex_wake_op, fix sign_extend32 sign bits
Date: Thu, 24 May 2018 11:38:08 +0200
Message-Id: <20180524093201.896882019@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby <jslaby@suse.cz>

commit d70ef22892ed6c066e51e118b225923c9b74af34 upstream.

sign_extend32 counts the sign bit parameter from 0, not from 1.  So we
have to use "11" for 12th bit, not "12".

This mistake means we have not allowed negative op and cmp args since
commit 30d6e0a4190d ("futex: Remove duplicated code and fix undefined
behaviour") till now.

Fixes: 30d6e0a4190d ("futex: Remove duplicated code and fix undefined behaviour")
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/futex.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1457,8 +1457,8 @@ static int futex_atomic_op_inuser(unsign
 {
 	unsigned int op =	  (encoded_op & 0x70000000) >> 28;
 	unsigned int cmp =	  (encoded_op & 0x0f000000) >> 24;
-	int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
-	int cmparg = sign_extend32(encoded_op & 0x00000fff, 12);
+	int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 11);
+	int cmparg = sign_extend32(encoded_op & 0x00000fff, 11);
 	int oldval, ret;
 
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
