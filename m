Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591180-2-14524955444446183143
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591179; b=DUOKqQjvjA++CJ8nA2Fv/xIOE7O9YZGfEeo1bntTG0qOtS2
    PI3V2QEWfJFO99ZUlFct7nriqIzvIuXgafl50LQVwEK2EWqZ+JO2avVKP0xdGuMJ
    hwXv+LhQd6cSag3mR7H3Bk6/VJVgQuds0Rw6YZeWT/sNMy8Q5Wo3kURbdTdRVxqp
    gqbXiKL4DigTVfap2ghS2YnZmIvxuuixXIwPBn9Kgo3Dlhzbldn4vC3SjxPd1rnJ
    6v8OM5ltv1Pgwo9GI73SqbG1ZbOVvm5BJtJN7THoD/KiPyO2IXzMr+ODdYDBXHK+
    MKU9xe6+xZosTXRDigWaEEviGYxDSxqPlJCjgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591179; bh=EfcsOHrkboi69+FMChtRL9PH4T
    UiWbG4BYwgYvy4BNI=; b=POeMmm/Btt8aSnG8S3ronYHJSiEkq1QovkD4xqOPKW
    Ih3/V6hhth1h2O5Tlpenxyhqn2WEt9gWy5ysIBz788pDhfnW/RLC2+lVoZkRBMLI
    HqvjS8ONkxdnTQNj33RahjyL6HT02s8fjkDGSd1LwWmyY1pO1q+9c4Msb2vQxYYK
    BzGrTt68j6MVEuoZRz6EgX3j2ZZURl4xLMRTgf2PRn2fQk4u7UWsSFx/zrfOqlYz
    cQUEQo0TqoOWt5QX/EO8Lp9vDG2Mzrx4JR04YhUrjO+6QNXXVH+sYS5D8xQvSiXQ
    H2zvcIS/iG1L4BSpzeCf+oKu8aAD+8IgHSPaYcB13EWQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753064AbeBBRGP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:06:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeBBRGJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:06:09 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.9 75/86] USB: cdc-acm: Do not log urb submission errors on disconnect
Date: Fri,  2 Feb 2018 17:58:35 +0100
Message-Id: <20180202140829.578778512@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit f0386c083c2ce85284dc0b419d7b89c8e567c09f upstream.

When disconnected sometimes the cdc-acm driver logs errors like these:

[20278.039417] cdc_acm 2-2:2.1: urb 9 failed submission with -19
[20278.042924] cdc_acm 2-2:2.1: urb 10 failed submission with -19
[20278.046449] cdc_acm 2-2:2.1: urb 11 failed submission with -19
[20278.049920] cdc_acm 2-2:2.1: urb 12 failed submission with -19
[20278.053442] cdc_acm 2-2:2.1: urb 13 failed submission with -19
[20278.056915] cdc_acm 2-2:2.1: urb 14 failed submission with -19
[20278.060418] cdc_acm 2-2:2.1: urb 15 failed submission with -19

Silence these by not logging errors when the result is -ENODEV.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -375,7 +375,7 @@ static int acm_submit_read_urb(struct ac
 
 	res = usb_submit_urb(acm->read_urbs[index], mem_flags);
 	if (res) {
-		if (res != -EPERM) {
+		if (res != -EPERM && res != -ENODEV) {
 			dev_err(&acm->data->dev,
 					"urb %d failed submission with %d\n",
 					index, res);
