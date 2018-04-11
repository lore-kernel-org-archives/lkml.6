Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481706-2-14936828608662634277
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
    1523481705; b=eL/WnJjoDN9JaV/gpJsZGTcIy9oDkvLgTVJLn9KN6dIIuMtPir
    TCz8OfooLkulniLv2z53RgY0kawgUnUGJ4l7JCyk0XZu/gQG1BT11cqjqhjQHrbM
    q+mFGxBIfVjmGAT6B556FR44mJ4m5aYsVAVPJCgpYBKcwa2TO92XoTRyDUlMtnb5
    4GbrDiDSJ5dbJHBAU1EuS5BpoMYeVX5TyJXCgYh0qOnJj0thZeaDfD2o8u/GfAO7
    JWrNznT424AstwOZMz7TUYsp+EZfqbMUZqvIHv+WGN/DxbUOqn8taN/5ireESWLl
    XNTxOgwFTbJJlXT8sFqyBT5VIMwdvIhiaIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481705; bh=b87YcO+OAkkVR2e8KVYZuAlsrsZkbH
    59zquAqlmTvJo=; b=HbyMo7f70GYF2DDebToF1B+s/7cPCPEvsDgvOOgHzXOGze
    VJ6JlAGa7XQAWrQlE/0Dr5ejawWF/qLZdh9wg22PpfSP2YmmrwSbdh1WYESKAmwj
    dZcX63y6pZbNFM75kgbU3RSTAnBGkVGUZAOj7IWJOhvAIhMpeaHPrluhVHfNucCf
    Dd4KDUQW8X06MwIRP476xffr3WvidwH3aZpO0fBICNXCNPNLRQkmhqpdmjlFc2V/
    8eF7y/gZUALhoOaDe2G8SuJuFsqqHv4DbwtbbdLC+3G6jxF79WdXnzq3zxUBO7/7
    pxsE6+dIbknVj1OQQb3GYYUfmtrLU3/GyzULpO2A==
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
X-CM-Envelope: MS4wfJsRGDZmx2sAf8MpjzaJP3JiMSnV+9RM9fKn1tWKPePg7cE+VrYAjIBBst+5HES6gLOc9FmGRaOnIGqS0auvk01ONeqXqt/ejkIRYR4cQFcfXY41raK2
    93+KU1he9UP93bpid01O6h72VTFHm3w8xT83ZEkLZSnGf0OBde3irBmLMjVe8h7jK0jl3yMADotJFJL2hJzxtHyfC0mVEiKvmGJDHufGRIzlAug1Yu5xnXtj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=uAS_uZ3KAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=LmmgGHosWJ0mTfuy6g4A:9
    a=QEXdDO2ut3YA:10 a=_KzJdI3Ai4rueFdl_XLO:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754308AbeDKSjJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:39:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55626 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754277AbeDKSjI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:39:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 034/121] selftests/powerpc: Fix TM resched DSCR test with some compilers
Date: Wed, 11 Apr 2018 20:35:37 +0200
Message-Id: <20180411183458.173618894@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>


[ Upstream commit fe06fe860250a4f01d0eaf70a2563b1997174a74 ]

The tm-resched-dscr test has started failing sometimes, depending on
what compiler it's built with, eg:

  test: tm_resched_dscr
  Check DSCR TM context switch: tm-resched-dscr: tm-resched-dscr.c:76: test_body: Assertion `rv' failed.
  !! child died by signal 6

When it fails we see that the compiler doesn't initialise rv to 1 before
entering the inline asm block. Although that's counter intuitive, it
is allowed because we tell the compiler that the inline asm will write
to rv (using "=r"), meaning the original value is irrelevant.

Marking it as a read/write parameter would presumably work, but it seems
simpler to fix it by setting the initial value of rv in the inline asm.

Fixes: 96d016108640 ("powerpc: Correct DSCR during TM context switch")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/powerpc/tm/tm-resched-dscr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
@@ -45,12 +45,12 @@ int test_body(void)
 	printf("Check DSCR TM context switch: ");
 	fflush(stdout);
 	for (;;) {
-		rv = 1;
 		asm __volatile__ (
 			/* set a known value into the DSCR */
 			"ld      3, %[dscr1];"
 			"mtspr   %[sprn_dscr], 3;"
 
+			"li      %[rv], 1;"
 			/* start and suspend a transaction */
 			TBEGIN
 			"beq     1f;"
