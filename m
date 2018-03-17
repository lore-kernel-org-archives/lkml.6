Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937799-1521271973-2-9723633400043776640
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521271972; b=rFSf36hi2/hwXwOmkDc4nJs8CutkxuJVYKhLgs8hK3CYN/8
    Z51DHHJoh6+HmdeJx72q92trSgvM7RySW78ziM2UkPX965Ufu6F+MenM9BI85AOg
    aJjyXrTshF+81ksagGKmADThR+rbyjw5lAOnaojlwIzki8/qj2kX4LfxWd08c8MN
    urNrevdgwgJmTOcOkFTrklApeV6qnsZ+6OMMZoj5Wx3+P/320hsmU0fQx8Lz8LSb
    rA58o+z/60IEMP4tPw/7Ak753W+8CqjmeIDk0kSXzM2CyB3UPkaswvNQoU8NadgN
    9BvO2yME+9i/FOmTMBul6CbR1XPbSOiKIW5o6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521271972;
    bh=uQ+9NE5ls18J6P8Gk4pWd6LOzFX9KebBSwL9YpAgh+4=; b=Qp0at5y/FXqh
    G1Nxa6UN4LzIiyTCKruyZtNR9qms/dFbFAoJgxxb/+YuEcITmWq0ib5vWHbTTPRo
    0C91PBRrO9H1Hszw6vYeDkiO//s+pg3OZFSBJwr/wDkJXvN7o35iVzAwL0hcnhtw
    FH72GOtNqzaj2jfEgBetnFW91GUoC1imEkQi/aDAke4wg4gmqzDiqvioCNzDyWEY
    8T36ol2KZHyQugBJxV0lMnETWQxeMw4QNRgDOPLoNq5Dnx4mmuFqYAcqV3gNTmB+
    CHSE9vPwfsQ0Byhe3ANlwdTca5GldKzM2PeyCaQ+T3HYSrbgrJB+ijky6K0biX0F
    keiH8cJVqg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=C5WSX2NH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B9iLJ1iD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=C5WSX2NH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B9iLJ1iD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeCQHcl (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Mar 2018 03:32:41 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42089 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeCQHcj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Mar 2018 03:32:39 -0400
X-Google-Smtp-Source: AG47ELtiMubPHcxuVLmWH6XdZr0QUelc/I9mrmaEn9m/Fa+s7wrhGG2TwAoeX373O4Th3ajQUW/3zw==
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz,
        jacek.anaszewski@gmail.com,
        Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [PATCH 4.9 2/2] led: core: Clear LED_BLINK_SW flag in led_blink_set()
Date: Sat, 17 Mar 2018 08:31:02 +0100
Message-Id: <1521271862-4599-3-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521271862-4599-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1521271862-4599-1-git-send-email-jacek.anaszewski@gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With the current code, the following sequence won't work :
echo timer > trigger

echo 0 >  delay_off
* at this point we call
** led_delay_off_store
** led_blink_set
*** stop timer
** led_blink_setup
** led_set_software_blink
*** if !delay_on, led off
*** if !delay_off, set led_set_brightness_nosleep <--- LED_BLINK_SW
is set but timer is stop
*** otherwise start timer/set LED_BLINK_SW flag

echo xxx > brightness
* led_set_brightness
** if LED_BLINK_SW
*** if brightness=0, led off
*** else apply brightness if next timer <--- timer is stop, and will
never apply new setting
** otherwise set led_set_brightness_nosleep

To fix that, when we delete the timer, we should clear LED_BLINK_SW.

Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---
 drivers/leds/led-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 3bce448..454ed4d 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -188,6 +188,7 @@ void led_blink_set(struct led_classdev *led_cdev,
 {
 	del_timer_sync(&led_cdev->blink_timer);
 
+	led_cdev->flags &= ~LED_BLINK_SW;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT_STOP;
 
-- 
2.1.4
