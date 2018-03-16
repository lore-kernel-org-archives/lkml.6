Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214428-2-14079229537644123180
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
    t=1521214427; b=BoYAmVNHkL+xOWATOC/yesSG+8FZ1l1/Q/ihTSYvv/IUX24
    8Mw5+09EO54R/AOqjR+xxE44qA+6Z5R/YZ5UR8gfyMv7KesLWc2un7QlN6zRHppu
    7sWqJozPikZuWRyEeNGAm5LHumd7c/JtFgfj739qtcQtl4mwdb3U+Pg5YBmjR7NM
    at8KW6KtUcvlTn5fRXkSniZYG0Ch9gyUGb1K4hvKz28UpuAEfnWkijVE5P6VVyNP
    yXA8KNQHSOSgoeUwjfAdhbl9j72yE9dNww3RoiL0RhQhaOEofe+Ek0tlBp5JTgZR
    CoxR+ZBycqLiskK+WkkikgR/Er2RKnVt5BD6tTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214427; bh=fYJb6Ce9jFrI6zDXqQ/tTt6FY8
    dJGPjCzoKTJsGDWYU=; b=JiHcBJF8ZZgQAh5IVQ94IKdXXZKxGZEB4tLDHO217S
    X7jKarTSOFai2qXWQuS1Y3XI0yeHeuJcuhXfcyD5lfgcSZr4MFv2SgpQezcDXCRx
    kmiXByExfAVuQUaKhlkOkj6doduwwgjoC2IxApBc7rx3Unx+eLZ2tCfo9RdG9v2e
    NaFXb5lqv2LTmbCLiqnhYiztZkwq9Fn4nn60UBQ+4f3IORGU0As0vJULxkYnMXze
    KgaXUPD58PDBAron1Wg0SAEYNN7DbCwzdhUi2rNLzDUlFsumvCzsp0VFNrUD/Aqy
    rgX649A3nU0RsK0FnNFXe4hEZINBjEOEW7q443U/Qfxg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S933797AbeCPPdl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:33:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39060 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933410AbeCPPdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:33:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 52/86] Input: tca8418_keypad - remove double read of key event register
Date: Fri, 16 Mar 2018 16:23:15 +0100
Message-Id: <20180316152320.912127006@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
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
