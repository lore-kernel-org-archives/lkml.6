Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-10225-1522303753-2-871334792633542820
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522303752; b=U3JuUfABc+z0Bbq2NwxUDs8PejsqaWAyRjQj42whToYmLM/
    EVD8GRs6jhB+Z54P0yhqcJfP5E2FejvMNi8pKLXuhjgDjlkIaYgpZlHREPBr1Qo4
    G9du0hlLTKBmEJBWfwL2ikE4tSt39WNIUCRtXb5Lf4tTwh4l+V3NbNweFQuwFWyx
    kJs4dslpYP0APfR/5ZV9kDKC//KBTb5YwqLZU5soJF68eOqoHXLgkYNB5SnxYY5S
    B7Y2m14t+dKa8S2ZFesRJW3kBCBeEfj8f3Y7iT0PTXzKF2p+c1exLC1XKS/TuuSi
    PcsO75Arc9+T4+ohliblChgIJZWwQRk9CGiAyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1522303752; bh=oULlYP5MwS8Y95IQbya0rgymhr
    7W7MC4t6AJ3dz07nY=; b=BeFssoVK6d6ep+SA6sckS3v+A7X1KoPKYtjIU22a6u
    Z8U18i9EOdJ91ewyBemiT/NGmXSZxOs6InvE8/px5tR9a1tFJ2SlPhMxSJf6qQ5+
    oi9ntRGq+TCE1+zVj1i8yRL8uUr8KSmim/N/B70umzCjreyP/lqsKuf9sBulgznc
    4zjIzd/eBDVnzKGJbVJ4KehSq1smEeXHw0lk8ElYWNL3Pivw10qw52m8fvO4CiWn
    0jvz5d4WYlDX1saNi2JYNNt7YUNDq0bXxMuTuithAPV8FDKjoOtO6H4kQo7oMED0
    b/SmqMNV397KWR/VTP7mG4sVrlRSeeJ7RQxRyvbHxiPg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=tnDSBDqd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=tnDSBDqd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKwXHRVNA1QekLX+XNfV+E8e17rb+G6VzHm3XOJ8vNs5OZVSk0le+oJwZQS1JSypldw7At4wwjJfrgi7V2LjXk3WbfYWeRQJX//LZLlOPDPP0aoomjsk
    kHyZl0HB6cnShCBbjbTDk8QpSEaONlKxsAEQ9ITRn+Zj6QPQnec+u4Z/eSllnJTZJXGXSDx1v3c8jjZHZchVqqcIwMqqycZqflr8O/FKhYN/w23gmmzJFRat
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=c-n4J4-pAAAA:8
    a=VwQbUJbxAAAA:8 a=LUjSBQz4yZDabbV9TEcA:9 a=x8gzFH9gYPwA:10
    a=L0NDqeB7ZLmQzAogN4cw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750716AbeC2GI4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 02:08:56 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:30847 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeC2GIz (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 29 Mar 2018 02:08:55 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w2T6882v017946
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: of-simple: use managed and shared reset control
Date: Thu, 29 Mar 2018 15:07:56 +0900
Message-Id: <1522303676-7035-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This driver handles the reset control in a common manner; deassert
resets before use, assert them after use.  There is no good reason
why it should be exclusive.

Also, use devm_ for clean-up.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

CCing Philipp Zabel.
I see his sob in commit 06c47e6286d5.


 drivers/usb/dwc3/dwc3-of-simple.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index e54c362..bd6ab65 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -91,7 +91,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, simple);
 	simple->dev = dev;
 
-	simple->resets = of_reset_control_array_get_optional_exclusive(np);
+	simple->resets = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(simple->resets)) {
 		ret = PTR_ERR(simple->resets);
 		dev_err(dev, "failed to get device resets, err=%d\n", ret);
@@ -100,7 +100,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 
 	ret = reset_control_deassert(simple->resets);
 	if (ret)
-		goto err_resetc_put;
+		return ret;
 
 	ret = dwc3_of_simple_clk_init(simple, of_count_phandle_with_args(np,
 						"clocks", "#clock-cells"));
@@ -126,8 +126,6 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 err_resetc_assert:
 	reset_control_assert(simple->resets);
 
-err_resetc_put:
-	reset_control_put(simple->resets);
 	return ret;
 }
 
@@ -146,7 +144,6 @@ static int dwc3_of_simple_remove(struct platform_device *pdev)
 	simple->num_clocks = 0;
 
 	reset_control_assert(simple->resets);
-	reset_control_put(simple->resets);
 
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-- 
2.7.4

