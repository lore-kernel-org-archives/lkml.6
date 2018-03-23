Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521805951-2-1962185269534950568
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
    t=1521805950; b=jnx4ERtXK8GN0suWDoD/80w+hoEWtaqkAtZiL5utPvGaECM
    LhQ3wMqULRJyIj/W+ZHA4NeiT9/zK+YhBBtkoJu0voom4Z/K0hWu4qs94SBtnTxV
    OgNM68hRr9zwnGLkT+WtuYnHXemZ+2DnEuc6SiIE5wq189R6MyTEZx/b6/tvMX+4
    PZozZuD5uCe7poacoBGsbQgPrwp/tsIIb0sT+7f4s3SDJ1KKac0bOr6F1blBIoOp
    rHjhRl2/yuQj69Q79PUysYQ/u91F6MYzbO7KeWzVVN9WnA7KbUUtrXB025PDRxbj
    u6xgZRyj8BhUPVsUQDxstERoW+EiR8obsp7h3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805950; bh=ACmoHL3K0KYKcTvEg5C1OXoy17
    0D5Nd2SJVuRdy9rwQ=; b=gGnbyE1LAWjPu/SzxxSY33FWUP64nQh9j0ByChj/A6
    7mUxDLT71ykW29HYp27SfEnjOq4y/B7/u1qne3ipg0oSvZ29BzIswVjjFf++u+LH
    TfdZW1tWNZ/0a+Z57pOcqbWUy/62FLhdUPu+79lUpkE2yLUFg5J849doENIuIs8o
    MSkXKDHv0r+CtrJJYMtdil2MgrwFhoyxUZ6eSsOHahpxak26icqYjKuOkxKAsXYx
    HnirGJnLo0VkkKSqyyVs3l4LcGosJgCcrP/zycaWy8xsYhM8lTLeOTvvb+EjgGgy
    D4LgFmLGb6bL31hnuNoAxXAhVuN170L0AwtUJY3lB6zA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754095AbeCWKCG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:02:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38176 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753607AbeCWKCE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:02:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Walker <robert.walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 44/77] coresight: Fix disabling of CoreSight TPIU
Date: Fri, 23 Mar 2018 10:54:18 +0100
Message-Id: <20180323094145.195943008@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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

From: Robert Walker <robert.walker@arm.com>


[ Upstream commit 11595db8e17faaa05fadc25746c870e31276962f ]

The CoreSight TPIU should be disabled when tracing to other sinks to allow
them to operate at full bandwidth.

This patch fixes tpiu_disable_hw() to correctly disable the TPIU by
configuring the TPIU to stop on flush, initiating a manual flush, waiting
for the flush to complete and then waits for the TPIU to indicate it has
stopped.

Signed-off-by: Robert Walker <robert.walker@arm.com>
Tested-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/coresight-tpiu.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -46,8 +46,11 @@
 #define TPIU_ITATBCTR0		0xef8
 
 /** register definition **/
+/* FFSR - 0x300 */
+#define FFSR_FT_STOPPED		BIT(1)
 /* FFCR - 0x304 */
 #define FFCR_FON_MAN		BIT(6)
+#define FFCR_STOP_FI		BIT(12)
 
 /**
  * @base:	memory mapped base address for this component.
@@ -85,10 +88,14 @@ static void tpiu_disable_hw(struct tpiu_
 {
 	CS_UNLOCK(drvdata->base);
 
-	/* Clear formatter controle reg. */
-	writel_relaxed(0x0, drvdata->base + TPIU_FFCR);
+	/* Clear formatter and stop on flush */
+	writel_relaxed(FFCR_STOP_FI, drvdata->base + TPIU_FFCR);
 	/* Generate manual flush */
-	writel_relaxed(FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
+	writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
+	/* Wait for flush to complete */
+	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN, 0);
+	/* Wait for formatter to stop */
+	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED, 1);
 
 	CS_LOCK(drvdata->base);
 }
