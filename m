Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2245322-1526979925-2-1959293665318121041
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526979924; b=VdTLWeGHGBJQLjLnG0pkba+yawyT8u+3gEWFgFonmKSgcMro8v
    ozXJrbiRryFs3q900NwOcmlJzYlLFyIE2Vd+NNGQPejp7FjuOcx43+D1GsTjKBwP
    ACwLqjFQSVbCKcYLelXzVMq0EDdu3x1LkQygXNYd+r4EWfHksHkfkVx+WiI6HqS7
    kmPyOgEVK5gz76pXsxTLXwfv/yAzkM+v8P0Pctqxw5RBjB5RRjt2vk0Vds8s7cqx
    yi554iYmKDW+0ka8txp4XzHX35sXM7WQ/CTrV6V6HSmCVfSKgS4R22kXCra7oP5X
    A8mKkx/LWct9ZqGCm336ptXxttv/9cgCjpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526979924; bh=GMsVWA0tF7daGkxuGGIQhsQ1MuVisz
    Ea5kiGmiFA1Jg=; b=d5MlKCCXZkPLkfb1WLz4s5gDZgrp3gcLnlO78rK9/Xmuqv
    3ElKf4Vaf/yYHbmlXKG2Hyu8++R1nPNERaBIbHXxJXpScklAkf49S4sW+ZbgRarf
    f//tonJFm2dpg3TGwTVdRvixImE3yahwtzjvwCZNGHrVGBg4/KaHUu2JF9qqowUD
    ugJ31fEbQoMN9FZtbxMAldEur0wMWcBSZO3CaM+H4xSDeLk9LexB9tpaKNAqOoWz
    R4jJauB4CfjinuApRvAkRr9qBzCLP2uiBdnJDJzFuhR1/fLeFCK0LXr6CQv5Hour
    mApZhr3cW7oaxcn7zoFgTO9yeig9O+0Ic7kZQNfg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJw7KiYjvqicsFxSc4pdi2RNlRODbfwcDEFfXxz3VtpI3jcQkj9ZrZy4SqOT4HOQ/iUHnyr7WM74oJuHPTB1oaVz7C+OnpodZxUKIKia6quz/rxmh4yy
    Um9leAU5WIy168GV18bwKevZwjn2VVBA56bRJl5fYGL2vnHK01Z+FSPLRVgpVVNN03HaBpiljHWORorI8T4roei1+Q5G7Sm/tegqjpiHodrQ1zhw6oSlv5Tn
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=WIDgAgoGNlgI1gk5sAUA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeEVJFN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 05:05:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59267 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEVJFH (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 22 May 2018 05:05:07 -0400
From: Colin King <colin.king@canonical.com>
To: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: tcm: fix spelling mistake: "Manufactor" -> "Manufacturer"
Date: Tue, 22 May 2018 10:05:05 +0100
Message-Id: <20180522090505.14953-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in usbg_us_strings array

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/gadget/legacy/tcm_usb_gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/tcm_usb_gadget.c b/drivers/usb/gadget/legacy/tcm_usb_gadget.c
index 682bf99dcf76..40870227999a 100644
--- a/drivers/usb/gadget/legacy/tcm_usb_gadget.c
+++ b/drivers/usb/gadget/legacy/tcm_usb_gadget.c
@@ -41,7 +41,7 @@ static struct usb_device_descriptor usbg_device_desc = {
 #define USB_G_STR_CONFIG USB_GADGET_FIRST_AVAIL_IDX
 
 static struct usb_string	usbg_us_strings[] = {
-	[USB_GADGET_MANUFACTURER_IDX].s	= "Target Manufactor",
+	[USB_GADGET_MANUFACTURER_IDX].s	= "Target Manufacturer",
 	[USB_GADGET_PRODUCT_IDX].s	= "Target Product",
 	[USB_GADGET_SERIAL_IDX].s	= "000000000001",
 	[USB_G_STR_CONFIG].s		= "default config",
-- 
2.17.0

