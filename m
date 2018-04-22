Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2707851-1524408294-2-3738814987046031250
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
    1524408294; b=dMHJNQ7h6lRid8DifvRaHt+liK/Go7TNR/xyTbg9dbnZtiDNiJ
    sf8ONpBCjfzaXAxPt3GjDIzttdvBTf+cBeZGR19bd4SA9Ua6320jiLfvEN8OznO3
    4h0v7Zn8d3DewzIbQCg6fXW9EvWPwwei7Yp3Orgq1koWbbo89L5mXcTM0z3fSrh8
    1kbPVXe/fxRh2f0Wf4eLLW+UaBZXBnaKWqF2bQrUvJmDgqedtlcU3cErJIdmqClj
    aQNkqLxydvjQGaamEXDcd4AaYXqxTagUYBEt642jQieso+mdzrA/+/bRqRenxTho
    gtHXC4fWs+TsOWQNfMwJ/8PHMKjYOYG9kYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524408294; bh=zxVu7yl/VhJrBcTPV3gq45LHgaON+U
    UXUZx4vgiiVoo=; b=e7SGnqqfekYN0hlU3ErfO6JE+ynZWWb7AlGISNUrurgkXL
    vGCqfpfY5ckBHwQ6leUAdF9v2RtY14v3EMZ17RzZFHsAj/s8s7SGiLum1eORDnmw
    JFz/4mpujWlA/+mBs4wPMlLPb7qRq5Kk+MYMpU2m62DZX13VAOIdpHNup2VmyHIs
    QquNIeuLhZ3TAY9P7nqlzZVymN0eT23NNPaY++QZcBit1wv2Hsu+li6f2boX8kRR
    hhF34ZbJerYcmsZuYGljTyMS6kwg/yw5HVIhEDWbW8pYqxkFgap5fvFlkU6VobG0
    JpbM/lsZHdxONgbKMPHuxQHOOcyvLpIusiyhM26Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfDBpkzvIpkK4Q3wPsf+/fKwEv4VCaUIlhVVL8DHMpJMhTvg4dOeQ13uW19j3fZ1bsV5hH6h6Zpqsod6tggy1PMSRjn9i+ZzMYmcsLeIRabbocK0fE4Ls
    qq8smN1BfYe1eiVzB/5T7oaMakgnMy/5KZHZVugW+GppJNNLkoY22lTaSqN4q1o+JhZKPHsDbKGaMfvAofAsSfZbWfTiJrgVKRXqYOopG34n785nJAOtCZtq
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=TWjyZcpIfgi0BG7x1ggA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756829AbeDVOoj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:44:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57866 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932160AbeDVOQ6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:16:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 42/97] powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops
Date: Sun, 22 Apr 2018 15:53:20 +0200
Message-Id: <20180422135307.666419616@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
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

From: Nicholas Piggin <npiggin@gmail.com>

commit 3b8070335f751aac9f1526ae2e012e6f5b8b0f21 upstream.

The OPAL NVRAM driver does not sleep in case it gets OPAL_BUSY or
OPAL_BUSY_EVENT from firmware, which causes large scheduling
latencies, and various lockup errors to trigger (again, BMC reboot
can cause it).

Fix this by converting it to the standard form OPAL_BUSY loop that
sleeps.

Fixes: 628daa8d5abf ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks")
Depends-on: 34dd25de9fe3 ("powerpc/powernv: define a standard delay for OPAL_BUSY type retry loops")
Cc: stable@vger.kernel.org # v3.2+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-nvram.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -11,6 +11,7 @@
 
 #define DEBUG
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
@@ -56,8 +57,12 @@ static ssize_t opal_nvram_write(char *bu
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_write_nvram(__pa(buf), count, off);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
 
 	if (rc)
