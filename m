Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805175-2-13087176489502480090
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
    t=1521805175; b=vqXU6iquWUAAtx3255xFSXSNuNINl0XmLRMecIkJGxpruso
    C13u/e0ROAveQ0P3YZ4wXaOfyOUlCmKksPn3JyH4j75QvSYKJdO2nTuuPuk01yZ6
    7M8wHLTVbiMg09bib1MVqQJrjVIFx+amC1LNLnQoNFNSV/D50+Bcg2TtlEmkUwFu
    RNLmP1c1xNqCQh2b5JSuWyKwLj1p6EWT1cCssGpYE4lPSwu/njEn9USSTOqb1u8I
    Jm0vfJIumZeb9T2O2ISEDgj72wwxreCwi/AIwR6mUWSCtAKz8T3ery46M2MCUlNe
    L1OyxKkQQkl7btYxkKNFDf6htyunthzeQUdzGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805175; bh=BHRqH412Em7MfmtrfeJueSFpid
    5sj2W3pFoLlfGz8m8=; b=DqtmKSqsl/C2r17ALItP7p3N2C8rtuzgyaOBPB7q02
    iE6TQ63KD7IGFCneZYoIGQlNEIBXsdDd2bI1cKjfYjqxq2qPwQ3k27XnWI+hKDea
    0Op09WPNJn4TZlBBjVIk9kbxEm3fSpoODXsNz3bVrztSliOsHmSBP/0p7e9IbRrE
    UVFdh8ycWRszY1x98VhUQ2f0YGqgbJmG5MnlFmLRVYUJbqEGOqWFz7kj0sijPxZF
    m38tUBuEN0fmQXWrvnjOzN0jOOwyVnFmm0/7B5AppEvmYL7SDdMTizjE3xTJWarJ
    GcZYRXEKHtYeseAfD4L9YdOE+JjnuGvEDRdRPSWttBkQ==
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
        id S1754722AbeCWKE1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:04:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754714AbeCWKEZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, pavel@ucw.cz,
        jacek.anaszewski@gmail.com, Matthieu CASTET"
        <matthieu.castet@parrot.com>
Subject: [PATCH 4.9 007/177] led: core: Clear LED_BLINK_SW flag in led_blink_set()
Date: Fri, 23 Mar 2018 10:52:15 +0100
Message-Id: <20180323094205.532542495@linuxfoundation.org>
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

From: Jacek Anaszewski <jacek.anaszewski@gmail.com>

[Only needed in 4.9.y due to other fixes in mainline - gregkh]

With the current code, the following sequence won't work :
echo timer > trigger

echo 0 >  delay_off
* at this point we call
** led_delay_off_store
** led_blink_set
---
 drivers/leds/led-core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -188,6 +188,7 @@ void led_blink_set(struct led_classdev *
 {
 	del_timer_sync(&led_cdev->blink_timer);
 
+	led_cdev->flags &= ~LED_BLINK_SW;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT_STOP;
 
