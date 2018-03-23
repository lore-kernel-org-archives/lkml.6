Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521807308-2-6233482811606415597
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
    t=1521807307; b=ro3v1y9XxcBorIbAgi3fdqo5Eh9ORMW7l38mxuby5Htynej
    hVLnvGDS9BhqVzcCi6EFIa4PTd9bHJS406wNgac/J4iKPBmfjdL4h3V5pFNey+2o
    hGPrt8kf9RchRiA2SfRCsBLy4fudwwStglLk9fa92nOIcj9rnxNNaN+KIduY4xD2
    BJ3ETx/TMEQbMQx18+74OweykwSQVD81+RoZ7zUXdpPzWdWljUjhNEW4fy0lQmjs
    KFfF2+195ghFZoN19DntDiH4xrDwlJwTL8lPidjhIYGh0ZcUtiIWZIPRTcvxF1TG
    XU64zPkhCBvKJet+LCrQlP0dVOtZCQeegOC/3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807307; bh=ZTMwODJi9Fb0cUjQ/nUz6r7Xkw
    JBbzKUWKOBpochMfw=; b=Y7+7eKOM3jGVyDPZzaSCuhpgfZEIMbHP9GL2qnPd8u
    vxCnkpsitzCZkB96KnGX2juz5VrHfOtujn2BME1ua+uvZhxAZlgPQNbm/xPsg+nf
    Dup+guy7pu70pi8/36WowX1+wsVcA1oLt5J8WankYGD9dKJ0QZYPQDyD9bbG9LWM
    xOh8zTp3M/0jglzlY+FcXKPjUDFivfazMKgXqJqYk1Fb6litby+hcqTZ1iPIO6L8
    Re5YmPTxib6wh2fPPzH13OozYx4RS5VmlJIJA+2XZAywp1aQjqmRyAw1tYSFj5Dn
    T5AacaHWJmm+hWVUc7iIgJNFUueG9HP7a1F4Y7OoDnHw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeCWMOk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:14:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbeCWJ5B (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jyri Sarha <jsarha@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 30/84] drm/tilcdc: ensure nonatomic iowrite64 is not used
Date: Fri, 23 Mar 2018 10:53:44 +0100
Message-Id: <20180323095416.456606529@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Logan Gunthorpe <logang@deltatee.com>


[ Upstream commit 4e5ca2d930aa8714400aedf4bf1dc959cb04280f ]

Add a check to ensure iowrite64 is only used if it is atomic.

It was decided in [1] that the tilcdc driver should not be using an
atomic operation (so it was left out of this patchset). However, it turns
out that through the drm code, a nonatomic header is actually included:

include/linux/io-64-nonatomic-lo-hi.h
is included from include/drm/drm_os_linux.h:9:0,
            from include/drm/drmP.h:74,
            from include/drm/drm_modeset_helper.h:26,
            from include/drm/drm_atomic_helper.h:33,
            from drivers/gpu/drm/tilcdc/tilcdc_crtc.c:19:

And thus, without this change, this patchset would inadvertantly
change the behaviour of the tilcdc driver.

[1] lkml.kernel.org/r/CAK8P3a2HhO_zCnsTzq7hmWSz5La5Thu19FWZpun16iMnyyNreQ@mail.gmail.com

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/tilcdc/tilcdc_regs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
@@ -133,7 +133,7 @@ static inline void tilcdc_write64(struct
 	struct tilcdc_drm_private *priv = dev->dev_private;
 	volatile void __iomem *addr = priv->mmio + reg;
 
-#ifdef iowrite64
+#if defined(iowrite64) && !defined(iowrite64_is_nonatomic)
 	iowrite64(data, addr);
 #else
 	__iowmb();
