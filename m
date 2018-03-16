Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443417-1521219018-2-17728242160504088026
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521219018; b=YWDiIIzRono0QCqCvDuN+Z8xYp0kAZ5oxQNk9QCYrSP3/kW
    3+zyCDiVXTn6YP+OdK+VXQW+WBmjXOwu5XFmoktipbDENJzo3EnWAOndQMKEtJwV
    rrHymT8P/54orDlSRvZK5RlpAqFhfZOR1YB/jVZ47dIf/H9mSxOb1t01CPw5toEl
    wEiwveh5iPUPNF+14FenjCHb143otXAJm7nVmYyj43sZBlQtpatM9y5VGlxECQVq
    htn5wdOv5cvpFa/H7cFHDKHODKM6aNRcs5j/AFBpuBupYQVAmRhksloR8fOwHrOp
    L30yJPBd+ARQwrZ18bpjtYvtA3eU89SfoqWBvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521219018; bh=hP2GVBwHaf22IeTCpUjkCFZFiz
    EanZYvZDrql9Y5T4c=; b=Wul3IoJvArthTxM2w0Wxam4/5m91/HFa9W2DV7ZFM0
    x7hVIQjq9DaxvlqOlRtaVKBdwhd25MpzNwyqyEeYwSRjnWgdNwH0WQJ1WQb5d8PB
    Px03SydA7AjG7a9yFJoVGcTY/eKl6A7HTlBtiA/fsNeua6WSxs8shNfw9vPQ9FwG
    7mGBryhVfZIjXQvv9y8DyrczcHAsT2hp2V+8MFqB7reMLjo0fpjOwTa56LjvduaI
    Ssx9Fgy9RPtjX+kETg70+O8VmMgFqpXTnevr7+6dBVhhNM+zLemZF0zd64chlEmZ
    /bMXNUVZjUPEp1AG0hLQrVfv15H+gnRnpULimIuJDxtA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934038AbeCPPey (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:34:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39582 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934026AbeCPPes (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:34:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greentime Hu <greentime@andestech.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.14 024/109] earlycon: add reg-offset to physical address before mapping
Date: Fri, 16 Mar 2018 16:22:53 +0100
Message-Id: <20180316152331.266725718@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
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

From: Greentime Hu <green.hu@gmail.com>

commit 1f66dd36bb18437397ea0d7882c52f7e3c476e15 upstream.

It will get the wrong virtual address because port->mapbase is not added
the correct reg-offset yet. We have to update it before earlycon_map()
is called

Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: stable@vger.kernel.org
Fixes: 088da2a17619 ("of: earlycon: Initialize port fields from DT properties")
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/earlycon.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -253,11 +253,12 @@ int __init of_setup_earlycon(const struc
 	}
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
-	port->membase = earlycon_map(port->mapbase, SZ_4K);
 
 	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
 	if (val)
 		port->mapbase += be32_to_cpu(*val);
+	port->membase = earlycon_map(port->mapbase, SZ_4K);
+
 	val = of_get_flat_dt_prop(node, "reg-shift", NULL);
 	if (val)
 		port->regshift = be32_to_cpu(*val);
