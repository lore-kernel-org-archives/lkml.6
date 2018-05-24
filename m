Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156474-2-10469121468214723642
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
    1527156473; b=ZQJoFZ7Gf6nBsKlBfMtx4GzENDPxWf8ST6VPxoC4p93XvvKkFf
    CDpfm/uIK1DYXSFXv6mj/yNOeOIjezCd20Kq2+eT59hc/BxHzN0utMHbHsOoAzHL
    fymqiF8zOfGa/VGUAk9jSlqnhxmH+tWfnre8OmMG4W7PSO3D2xIStV9IXMNKElGY
    odDaYoqlDS7gnz4TSPFpduqLiFUl5uLoaYAiXygzINpz97TSLjF4vk7llH+KlPq+
    eQNvMXrwFfksQjN3xhSfnuDSUZl6/wWPsPpemghqUkQlitekvBjFoBqSHRLU6RfK
    y8WO9L3rJ4yY6Gl9F4lZCikWY/QrM0XKphRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156473; bh=6BgOIuarRbnVIXTI/iLfQQH8A0hZZD
    Xdjer51ZJISbs=; b=b7qEh7zxOfAaVJVx6vinFfvp3kI25fBOTa7cCPD+uarvnT
    xtfClLqHJBF0QklpDCgWT00N6Sneq9ADYQK0h+LT2NJ7uRSGoHxhYDq1pwBwZXV0
    FBel+YYMv155P32XX5ugsKCIlhl/CeaxYYlv41sIBvOWgw0C5LZCUZr4iKBZkLGP
    /E+Yb+E9+1AW1UtYJRwrW/QCdYixednvQc8hTDaN3RwKZJ10yVKal6KS9RmPMorL
    JyE2Y874C09kl3Zc2z4KpcuzUyIJapOVNAgBdI6OXfV9P7o1wdyEwKKCrrKzbiYQ
    qD2f6MCmah1hqNTtCf4QMQg5GoZDloUjoddHKn5A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=pWD3C1ir x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=pWD3C1ir x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJEfH3Pi/Bf2L/PFFW+N7t8tytkYZgLM+XgBSM2in9WC5zKONZ/kR3JOLBEMTlEE1nivuuoD7cIKfP12+z2fEk13YOXydvFIjK41S15+X9rrw0fUSYDI
    YJzTEzis181rEgUMtmB5m0pt8LAmYHYg468OuIxfc12baz22jKv1/86c3OHrIll9YJtnoLHiBQXXRul8RK/TTvRYKTTVHZrHzAPjY4TX1xitCmVzJjc041W3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=ATlqkBLompyTqWQ9KKQA:9
    a=QEXdDO2ut3YA:10 a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031707AbeEXKGV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031695AbeEXKGN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:06:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 138/161] media: lgdt3306a: Fix a double kfree on i2c device remove
Date: Thu, 24 May 2018 11:39:23 +0200
Message-Id: <20180524093034.906207899@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
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

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit 94448e21cf08b10f7dc7acdaca387594370396b0 ]

Both lgdt33606a_release and lgdt3306a_remove kfree state, but _release is
called first, then _remove operates on states members before kfree'ing it.
This can lead to random oops/GPF/etc on USB disconnect.

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/lgdt3306a.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/media/dvb-frontends/lgdt3306a.c
+++ b/drivers/media/dvb-frontends/lgdt3306a.c
@@ -1768,7 +1768,13 @@ static void lgdt3306a_release(struct dvb
 	struct lgdt3306a_state *state = fe->demodulator_priv;
 
 	dbg_info("\n");
-	kfree(state);
+
+	/*
+	 * If state->muxc is not NULL, then we are an i2c device
+	 * and lgdt3306a_remove will clean up state
+	 */
+	if (!state->muxc)
+		kfree(state);
 }
 
 static const struct dvb_frontend_ops lgdt3306a_ops;
