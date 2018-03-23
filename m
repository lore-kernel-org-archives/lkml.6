Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-977995-1521799819-2-10793224099168566536
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
    t=1521799818; b=hfLDMiJWo4yYxtxnMsRPYusJoTacg9UXbg8mU7QGSB2zgfN
    GnaDwXJNot/zEAx9m9c1hkmrz0Jf6EnHzCOaJzXnrjxh8Qs/Iw9kIIefCi6KMOS0
    ariAXQ+NImcnxnujgry/pe3PoDCU+qkY51hFqPqQ9jfmudIyCVW5Lc858NXOHWGq
    Yl8I3/w3Ve9Tl915x0TAmBYsJ/uoslEJS4eA0k/w4wMTgdnWE1gxy38gtnRBNWZ2
    v2uBqfRmeQdpaYIZo6zgx5y6fhokWySzZoPayxzaO6xV9fUCJjZ9vxCHTOBzheY/
    nWNBMRTLqpHZuyJDG9xWKSS5knp53B2KsoyNtGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521799818; bh=4K6w8DBjSf3XoNRVuav98B/gGL
    EDVlHYnDumPgFSY4s=; b=trTS91vhajBSWDjesLzvjuP9DeTq0XFXAa+ClgTYro
    yx3iz6D7xaJpbDvT3vmAYRNoiis7SuOPFgWJHaeQGW2wes2F1kJZ6mQn/SPozHQ+
    U7/BCQMIqTdnyjqDkR/OokFK6VRbY/M798/bcqCT46xqoAxfhUHAIYOoq6Fkxa34
    1+b9u3FWYhus3XgrDMIyRIwX9lmpTTQ9CYG7FKlGSaMpIbyJUGfhKq6lxMgqz+X6
    X6rlInHBd3U8Vl7T3k0184EvoS4bnVBOYIGfT3PaqAw02WX+g01EXDJiATdrILgL
    0klDD1Vpefd7NM50hkkSTbe88PNHCdaaMtdKA5LhneuA==
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
        id S932644AbeCWKKN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:10:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeCWKKK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 122/177] sm501fb: dont return zero on failure path in sm501fb_start()
Date: Fri, 23 Mar 2018 10:54:10 +0100
Message-Id: <20180323094210.632543676@linuxfoundation.org>
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

From: Alexey Khoroshilov <khoroshilov@ispras.ru>


[ Upstream commit dc85e9a87420613b3129d5cc5ecd79c58351c546 ]

If fbmem iomemory mapping failed, sm501fb_start() breaks off
initialization, deallocates resources, but returns zero.
As a result, double deallocation can happen in sm501fb_stop().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/sm501fb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1600,6 +1600,7 @@ static int sm501fb_start(struct sm501fb_
 	info->fbmem = ioremap(res->start, resource_size(res));
 	if (info->fbmem == NULL) {
 		dev_err(dev, "cannot remap framebuffer\n");
+		ret = -ENXIO;
 		goto err_mem_res;
 	}
 
