Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3511991-1521221426-2-7793063517068308090
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
    t=1521221425; b=ldWksxE3muQgGDavW+wwvzQWtY5fkx86FfpGfXz9VeMByrq
    0VpXLatvVPb9Y+MJN1Raryd86nDMzHh+skOlo+j/SjRAmXfPG+6n1EANVZIEDIDM
    v8H/Ky4Lzh2If72lZXOgQ1tRvQH+ChBUQ4lJaUJIU+LgUgSUivNL/OpezZ/0PboJ
    ZEpeAF0geBNMDiNuJLmhjE8GGmKgt6X3hWDN9wtJqAKVr79UXruhqCtyjA6tKjhH
    t1lFyo0zCr0yIKfq9ugobJ9RXwwlbsEeIZmeBHrvU4McdbejJyqpC4X+ILXxu2oN
    iYk5oemMqdavkC98jAnCbeWPSinrS5OWUPAupNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221425; bh=hCCPKOaDHBkVqxIKxrpOFoWyee
    u6Jyde9NT2PklvJXM=; b=PQQhSB4A2r+Fp3s7lUrJD4+er3fH11/hpGypBm2st+
    gk8FQyphB8flGaixUI0wwVx7mRJco2GAAQ1Pv+ihjoZCQ44I5GHYI4FvaZcJ996x
    gsTPhLDG5N7tzHrZIYiegJWrD9gmFFjG6LbH60FIa7gAZvgw8JXDWRW2z8Ky9ifD
    y0TT7kw1RgBWLgk+Oj/vuKrdA396UDwE9cND8GjGIySLC41XENSAYjnriKI9msc+
    hIdjn7V0DfC32JMCPQl3s8NSU5EEZeSQHeyrBJhsQwDVzCHSGzr0PQNAaUF9cYKt
    k1+ax9I0cDH937n4rAcQWwQWPmWA3JBjN0K5eSb0JReA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753310AbeCPP2A (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:28:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932768AbeCPP16 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:27:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 32/63] Input: tca8418_keypad - remove double read of key event register
Date: Fri, 16 Mar 2018 16:23:04 +0100
Message-Id: <20180316152303.655847464@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 9dd46c02532a6bed6240101ecf4bbc407f8c6adf upstream.

There is no need to tread the same register twice in a row.

Fixes: ea4348c8462a ("Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-un ...")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/keyboard/tca8418_keypad.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -189,8 +189,6 @@ static void tca8418_read_keypad(struct t
 		input_event(input, EV_MSC, MSC_SCAN, code);
 		input_report_key(input, keymap[code], state);
 
-		/* Read for next loop */
-		error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
 	} while (1);
 
 	input_sync(input);
