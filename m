Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3835922-1520574964-2-3337660559779767173
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cc',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520574964; b=OWUADaHHDCCD7ezypafUW8eWeEVa+ObAwWHIpi0YJpd8kMD
    OfkPlyHozIzYLvkEH4x2SxiKcl15jdgNxNinSLc1v8HDesUVqu+9UH8gePg+DOdJ
    dy4Tx6C1aWQcw9NY2Glr2WHjLHeARtpTMqnodX1Fkpw+Jf2Df6YsUBKUFYVJA0Lx
    vs3PRe2WgFS01XRfVVQMBU9Mh5UkRIkOAxo0aeDi7EXg6aHJXLcGBc4vzFC5LglP
    1XSy0rcS338hnRLIWrK2G06wT8he86+35hE16hBLyxRcm+fVuZfeoYVVEpZyzDXI
    QUkBzwPHybqx1Yrb1WkLjxvsmLsJJN4UyXf2znA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520574964; bh=J0/crp/4T9sdQ/ix8HAB2MhBm3
    mrBW4g6tGeTutVZB0=; b=vT0KNqjz51+IbuDXBraSOwFsMveM8qNHdF/raSSe8u
    60HrjE6JQBhi5qAY4/5Bd6rIGLcwq942tbTRlcrcNaEz26+YsOD/LJWqr9zZ7KSU
    8/0TL7/R6Oe9z0MF1FlDPNQuKb7xilXapqYt0RvBBJ2s/GI1SujbFaaylgrGmN1Y
    tK+b+yok/a1N5xObW0rtd2RMvYcXKEhnpPSmgFznH+QLguvEhONGUn/dB/2nBwta
    3W7nJdHxZrUkG2D8zia+Ux72AuJPNh16s7BzOmFyCeM1cMBbLv5Bg702L1dUN+RM
    4huTIb9axh2aY3dDYWA/nc/eglz3kVYtcFbcYF15MmNw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=IA6/nTat x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=styyVnSs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tobin.cc header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=IA6/nTat x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=styyVnSs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tobin.cc header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeCIFzt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 00:55:49 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43371 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750909AbeCIFzs (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 9 Mar 2018 00:55:48 -0500
X-ME-Sender: <xms:5CGiWpCQHu3VVurgIh0hcmXkoDBmnTv6GhpW8aZbHCklkQRMqI4rVw>
From: "Tobin C. Harding" <me@tobin.cc>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 3/4] usb: Remove stack VLA usage
Date: Fri,  9 Mar 2018 16:55:35 +1100
Message-Id: <1520574935-7457-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/usb/misc/usbtest.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 90028ef541e3..9e1142b8b91b 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -2028,11 +2028,14 @@ test_queue(struct usbtest_dev *dev, struct usbtest_param_32 *param,
 	unsigned		i;
 	unsigned long		packets = 0;
 	int			status = 0;
-	struct urb		*urbs[param->sglen];
+	struct urb		*urbs[MAX_SGLEN];
 
 	if (!param->sglen || param->iterations > UINT_MAX / param->sglen)
 		return -EINVAL;
 
+	if (param->sglen > MAX_SGLEN)
+		return -EINVAL;
+
 	memset(&context, 0, sizeof(context));
 	context.count = param->iterations * param->sglen;
 	context.dev = dev;
-- 
2.7.4

