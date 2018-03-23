Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802761-2-11451573566581297851
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
    t=1521802760; b=wHw9KqvbZMUyK7PR4n/w7Ue1IkQjiTPf87Qy/rbeu53VGsm
    x4xcBdzR0+ajRNzu2t6OXjKhJZD7wqIuoAwvzVAsEmUHBp+xUBW6I1xwLCfCiEpT
    nh+6KHKx+AQN0CwX1qkTaJmdFApK+0NTGt9MealACh2UxoSqVWqR4mX8JtbEtPCR
    WtKI7Zn+Nbw6MawyhyQ7xKkpWMC67rjqW2nZpXx36JX3LVA+e41mjexiJDGDrore
    vANOH5T0RqLmBwTtPcjjOSVU+/ZSM3XAjWuKA25VbvMKKq0IgQ8MWlianpkmwnDl
    5QTVfGDy2gv51bVl+FPyaZ3LAvRP+AbXwK8j/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802760; bh=IUCmDpxhUiX8PuGMwnEDy1eEIV
    GaP7xv51Ez9vRZccc=; b=Te7DM/sXiOxiKKxuYcceuyZSuz8Y69NJVYxzFibBTp
    ruBE8Omn1/YgGwt3fYH8ImoJ8qAWvkzNIU+GSTHA9xjtYJLXu7M/Med7KjRN9YnB
    qMWKUWjvbAZw3+axoS79RIH3dEFySHFVg+a6CEGrfab60eV49X3ZisF3hB74HEAY
    FgBwQ5cnDW9rLlqdH2GIaB7Ag4y9N2UsbUG2igH8VP/B87NrjhVvVSC8bc4Qy4z+
    bRDqBOceBvWi+q3UiGmeEJUHfEi1Bom2M2kvZSOx2z2O3wQRJU8RxtyIyMbOCAEq
    0qO7mUySwe16IHPxIZVU93DiJ7YFxqbNXp1v/3bTKg+g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S1751848AbeCWK6y (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:58:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933225AbeCWKMf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:12:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 171/177] dmaengine: ti-dma-crossbar: Fix event mapping for TPCC_EVT_MUX_60_63
Date: Fri, 23 Mar 2018 10:54:59 +0100
Message-Id: <20180323094212.696536011@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vignesh R <vigneshr@ti.com>


[ Upstream commit d087f15786021a9605b20f4c678312510be4cac1 ]

Register layout of a typical TPCC_EVT_MUX_M_N register is such that the
lowest numbered event is at the lowest byte address and highest numbered
event at highest byte address. But TPCC_EVT_MUX_60_63 register layout is
different,  in that the lowest numbered event is at the highest address
and highest numbered event is at the lowest address. Therefore, modify
ti_am335x_xbar_write() to handle TPCC_EVT_MUX_60_63 register
accordingly.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/ti-dma-crossbar.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -54,7 +54,15 @@ struct ti_am335x_xbar_map {
 
 static inline void ti_am335x_xbar_write(void __iomem *iomem, int event, u8 val)
 {
-	writeb_relaxed(val, iomem + event);
+	/*
+	 * TPCC_EVT_MUX_60_63 register layout is different than the
+	 * rest, in the sense, that event 63 is mapped to lowest byte
+	 * and event 60 is mapped to highest, handle it separately.
+	 */
+	if (event >= 60 && event <= 63)
+		writeb_relaxed(val, iomem + (63 - event % 4));
+	else
+		writeb_relaxed(val, iomem + event);
 }
 
 static void ti_am335x_xbar_free(struct device *dev, void *route_data)
