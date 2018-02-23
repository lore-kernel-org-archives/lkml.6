Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415128-3-10782045354022543319
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415128; b=N6kaUClTtnIny3lG6hSqsX90rQa82Pm64rGh0ArCVP6IP2J
    uAYpboVfsA4YaqNAYm1cBRs5AsroNekXvBO3q+1akwSpfAwIJiP+FhoE3GTQvK2F
    IDY8OA9eACRwe31L81t+dMhKVQeOawMK0lrSCotOQyTvplri1EzHm+2WS6tU/RUl
    8JV3K3e970NRY1WsRSNT5b2ONT/53cJXnHW+dUKrHe4ghy6FfVfYiDBmknoEbhLw
    QL9dFVzgC7X56Ep52ZPm7QrN8/wEgz22WY8GDcNOzsSjSA8szWswL5YKYP3h45hQ
    4TBLABqqwCH/MpXPrP0FdjU4hQp3vPUG+hzJKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415128; bh=fQ/LgaizzKtTxNwGG6eRtcvDDy
    zckjDq5Yu7vKqY/VQ=; b=LulYj5haJmfscV1OTL3F8Op+jtninhPTP1M8jK7jKK
    HUSaa+fhbPSAylsTyWySZoh19L0Jr4IAwYX3VtlFHttJ4d5OLMWYqwgSdrQlKBNU
    Bfek6MkphsAEIs3S+vE7nwGmbDfykX1/fnc4bCaprd42SYNZZ5H10jcJ6d0MZbtQ
    zam2ef7pdAa8fWUtfXjEqt6p5VSvKybYgGpKT+b3UetHrPuJfry4Y9XVC/8hrcKU
    quagaBH3/6LvDDg7uswaYybF6ib843JACuUwVov+s8/LQBbZ0aK5TuiXE5X6Qi6G
    MEmTaLQi39UC30kxw8D+Av7q3kUs0j5ZhfCV35afjMkQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934293AbeBWSsF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:48:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934308AbeBWSsD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:48:03 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.9 091/145] drm/i915: fix intel_backlight_device_register declaration
Date: Fri, 23 Feb 2018 19:26:37 +0100
Message-Id: <20180223170736.526455297@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit ac29fc66855b79c2960c63a4a66952d5b721d698 upstream.

The alternative intel_backlight_device_register() definition apparently
never got used, but I have now run into a case of i915 being compiled
without CONFIG_BACKLIGHT_CLASS_DEVICE, resulting in a number of
identical warnings:

drivers/gpu/drm/i915/intel_drv.h:1739:12: error: 'intel_backlight_device_register' defined but not used [-Werror=unused-function]

This marks the function as 'inline', which was surely the original
intention here.

Fixes: 1ebaa0b9c2d4 ("drm/i915: Move backlight registration to connector registration")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20171127151239.1813673-1-arnd@arndb.de
(cherry picked from commit 2de2d0b063b08becb2c67a2c338c44e37bdcffee)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_drv.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -1581,7 +1581,7 @@ extern struct drm_display_mode *intel_fi
 int intel_backlight_device_register(struct intel_connector *connector);
 void intel_backlight_device_unregister(struct intel_connector *connector);
 #else /* CONFIG_BACKLIGHT_CLASS_DEVICE */
-static int intel_backlight_device_register(struct intel_connector *connector)
+static inline int intel_backlight_device_register(struct intel_connector *connector)
 {
 	return 0;
 }
