Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3835922-1520575904-2-3429138126477344080
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cc',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520575903; b=rxMHdoH2ZAyGeoNz6e3xd5ifdkBnXeUVW5DrdvdO7HoxQ7L
    LTBi3JBQ3lbrsMBwdVReUNWPHXwXUjDZbLpeXVghcXM22XLwhTQU04vJeAq72taH
    kkgaqwV5dfC4E+ywVefINB6Wuq2CtKeHNwc9Q2Vhv9YlSPmxKj79W1+V3Bk2NRKE
    klZ4hBjD3yp3nJzEcCTG4jZePcclpTn6Tb+lxN6YWGUEPqhPJ1pSnM3upNjg+xuB
    OWFbSXfb012cu5rHoJcYMI156874RsEcDvfCGpSrjMfkeRp6na0qeP4exWudbhgO
    nGPHmrAiesHnTedJzmJAYp40QQ2slGlVZ+zyNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520575903; bh=9XXcKzOouI4RN4phwuvl2OVljD
    LQumSh23BYnsLCEkE=; b=iSTn810YF290OXZ8tqXxySZ4W0nGx9tOQ9OKDlT5fH
    CXRtxEXLxlAbLiAJWW8H4u8mjPOTtWDmxgPZC23I/o0C7AUpL67kWLnMa+R5FMyv
    czGQh3epynYplsRFcLF+/3YiSo0dNpUI0ari4ra3m1uwtH2ib7GTbXHWWgClYhc5
    C4AZVc40E8ym1pHLQAcdRxKR9oI5t23vIynVIqPAx/tASwP5qKR4F+EO3T0e7Z8u
    hzaOdnbWYPmHZPFFeHkjDNsPXIp6qlLtsiHg1phjAKErobc63Cv99dGuJNgmgzw2
    bhAr1L+EAV6JX4XK6t3nK4h8zqc88GuEONGNNFujrjfg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=VzrNIVnQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=ObR6XFXT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tobin.cc header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=VzrNIVnQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=ObR6XFXT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tobin.cc header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbeCIGL3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 01:11:29 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56649 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750932AbeCIGL2 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 9 Mar 2018 01:11:28 -0500
X-ME-Sender: <xms:jyWiWhwCQxJj5V6JGLjr6lhdGU_FSfHovg6828qa4m_rOSYaxBYcAg>
From: "Tobin C. Harding" <me@tobin.cc>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2] usb: Remove stack VLA usage
Date: Fri,  9 Mar 2018 17:11:14 +1100
Message-Id: <1520575874-15281-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel would like to have all stack VLA usage removed[1].  We
already have a pre-processor constant defined MAX_SGLEN.  We can use
this instead of the variable param-sglen.

[1]: https://lkml.org/lkml/2018/3/7/621

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

