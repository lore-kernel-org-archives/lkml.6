Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906373-1527164236-2-6094520452633444036
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
    1527164235; b=ZsS0qDqbPY/aGnzMkkCpgkDp1hwODwecl/fj/Og+rJNoxGdX3M
    7NdbD9eCVeOc3K29E0EdO6yYP7l9S4Sgq2aH1oWgZTKsZgzURlMP2Qq1iDLiwYrN
    wsxqbICaFrd/Is1SraKQY0QZs/arU3DV3IgMLHGPKCgUr1Wukj5r8U47HlR+akpc
    VQNDI0wOHNoUlw9ZjnyHY0RzW/G+mAOeMz66PknBlUCStw9PcDsQiNOOC1CP977l
    FM885zswkOQcDLyb+/n2k/l/B4nI78qRwFAiSrVVghjQwWfmqd06G5FKiReE0MJ+
    1bLacul16TPh2/rUV4QR5kKPcBW3vGg+sMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164235; bh=DmlA/L+yBnLoYgoHTqSEbRKnxpbRbV
    Y8CKlDd9IXNLc=; b=ge0CWKTn5NXuvCUj6HXBl2YGRg17RUGb1NuCiTSL7VCoAZ
    PNdzcKYskz9xZJG1Z/4m0cTq1GM+BtU4LoEIcMgBLwgaoXCCPOnYjKEUJg2W6jop
    WT8pivil04Djoi8wZfbsANx9IcCScqoVFZpTBO4auJuZEAbNICjXeB3JzaM901SK
    00r/fIBgcKmZ9a9mypUXF8IAWNftDh6HQC1SBc0mEVqfbTzmd2K1g5+t7Z7fcjLn
    XQ/DHHizkjX6vxOow56Wuf8Adb+uvCbDvZV5CplIQB3UmvAzMVb5BbkfBctgCCO8
    40Q+FJDdadzUVIMp0uMt54M1O9/l0y9Ke1BYVp3g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=o8mWpKKE x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=o8mWpKKE x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMStPRHdXxdUJBDs9ManRXYN7r6iFxPlhaCKVpS8FoNjslpC1q035MhYk2McdycD3tueEr5fi4sMIt+mfoOG3rtSGLbnTlK7octi7ddvr1U6yuYS35PI
    HKUbbsRGroXgCzHOoKqZqhQNnOLWrHAEaq24JA2CU+r7cU9xUYPrKPlYmfJOd28wEP0qIdKzdYRfRpP1ORHPpRzA1YmlXKJgvojs3lAMBj0ZFWeaCV+qSEzH
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=_Gl1HcQ-4U4wQ9qHoBsA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966260AbeEXJl6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966025AbeEXJlx (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:41:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3.18 33/45] powerpc/powernv: Fix NVRAM sleep in invalid context when crashing
Date: Thu, 24 May 2018 11:38:41 +0200
Message-Id: <20180524093124.842743719@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
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

From: Nicholas Piggin <npiggin@gmail.com>

commit c1d2a31397ec51f0370f6bd17b19b39152c263cb upstream.

Similarly to opal_event_shutdown, opal_nvram_write can be called in
the crash path with irqs disabled. Special case the delay to avoid
sleeping in invalid context.

Fixes: 3b8070335f75 ("powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops")
Cc: stable@vger.kernel.org # v3.2
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-nvram.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -43,6 +43,10 @@ static ssize_t opal_nvram_read(char *buf
 	return count;
 }
 
+/*
+ * This can be called in the panic path with interrupts off, so use
+ * mdelay in that case.
+ */
 static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
 {
 	s64 rc = OPAL_BUSY;
@@ -57,10 +61,16 @@ static ssize_t opal_nvram_write(char *bu
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_write_nvram(__pa(buf), count, off);
 		if (rc == OPAL_BUSY_EVENT) {
-			msleep(OPAL_BUSY_DELAY_MS);
+			if (in_interrupt() || irqs_disabled())
+				mdelay(OPAL_BUSY_DELAY_MS);
+			else
+				msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
 		} else if (rc == OPAL_BUSY) {
-			msleep(OPAL_BUSY_DELAY_MS);
+			if (in_interrupt() || irqs_disabled())
+				mdelay(OPAL_BUSY_DELAY_MS);
+			else
+				msleep(OPAL_BUSY_DELAY_MS);
 		}
 	}
 
