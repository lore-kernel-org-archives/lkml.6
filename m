Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443417-1521219060-2-15033805742434686873
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
    t=1521219059; b=nOKzG8EYM3JirEWUNTjtyzG12WM55M/CiJ0m1KH4G56Gs+/
    MpFqQeuFFRe37/8uaJRskDpDQVKf30+dyNzSYB1qGjpUFFHg1GxbQsd1zVPJBThM
    7rAqWri28/ZUl9NL2SNUCde1AkF9TiYH5rPGJ0/i6hY/1qkuh+rdfm0MjYyEgrRj
    mTQGXINt9iNo0qkcIHjLlkKTfwDT/xu5L8vAXCsZnnLZYinQOipAEhVVSdhppw3q
    2rLjoKUjShA5ul6VRX2hX83hE1x6lfJOHC1I9yYwdditp5jiP5Y/V30ucPDVnAeb
    ajWUAw3+ZT0Oa0QfOw3NifLyY7k8Ry8q1mtfBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521219059; bh=BW1QWuxyoNp1r+2083o9xAJkJF
    5gplbIOm49SLoxv7Q=; b=r2Ghm5zruC+VyfYde8+o1m/JpqWPiQtUSgTJJVPtnY
    ZiWNJ2wvs2G/ajqJWEuqqxqldXUcVyvuKzee5Di+iDe29hkNOrnBClRZ1EFsGmvO
    SNjYW3+gf3blRkj7N/Gt8rtjnpCgJiHmlf3VgexyGOwsDZKXBhfp5QXrG7l2+yHs
    EX7Rxh4/JslfElIKEP8+NUdVDZ0uliVOUyRgbxG60N6UcIDQiyHsbiQ3iBpvjUvc
    j9YBrbwjVb83ytR8hKjTFTOD1BURuElmRXDFRaJuETnCBD6FYyDwXbrVfl+Ct0UU
    J9SKUHlVYEYr6LEW4XdmmzIlzkEMpP7PbPNy0noXVGOw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S934018AbeCPPer (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:34:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933420AbeCPPep (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:34:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 023/109] serial: core: mark port as initialized in autoconfig
Date: Fri, 16 Mar 2018 16:22:52 +0100
Message-Id: <20180316152331.220071545@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 714569064adee3c114a2a6490735b94abe269068 upstream.

This is a followup on 44117a1d1732 ("serial: core: mark port as
initialized after successful IRQ change").
Nikola has been using autoconfig via setserial and reported a crash
similar to what I fixed in the earlier mentioned commit. Here I do the
same fixup for the autoconfig. I wasn't sure that this is the right
approach. Nikola confirmed that it fixes his crash.

Fixes: b3b576461864 ("tty: serial_core: convert uart_open to use tty_port_open")
Link: http://lkml.kernel.org/r/20180131072000.GD1853@localhost.localdomain
Reported-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Acked-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/serial_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1157,6 +1157,8 @@ static int uart_do_autoconfig(struct tty
 		uport->ops->config_port(uport, flags);
 
 		ret = uart_startup(tty, state, 1);
+		if (ret == 0)
+			tty_port_set_initialized(port, true);
 		if (ret > 0)
 			ret = 0;
 	}
