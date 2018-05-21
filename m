Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-596430-1526900986-2-6883143517761027251
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526900984; b=SOQWxGYBTWupKSx9BOo/Sxu3yh6yUTx++2zeBTvvNXTZ6CMohY
    gIm3atYzhBnwO8HomfbrcEDDUCWj8pukxuloZSgGz34p2uL8FZtUZIESegSSuYrd
    nM9vpuKOocKUnA31CSph1GluoXmaXye+FINZp+Ra6Sou8kGDKjp458EsSOA6i5l3
    AFHsyvbDKVsOkiRzBw+4BlIxRTtBSs7eWd9OTRGWTMAxiPkHIxCWtX3Z05IN2cxw
    6nmg5z/hbFDXRo/ZxVxFmSjVkvt3EPaGiCgsJzwOVubGTPEp+SpM1fq7ZEAg+XeV
    dVWt2o1QyQ8yjzo34XnfunKPSreW+tBPsiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526900984; bh=EavtXXFhg240ZdfUeJDujv4ztIlgSB
    Xw9PPNupMj3Ko=; b=OeycSLKti0Xk/bEy9p6G/Mt/uumL6ToxbSD4bMq0xpfHzO
    Jx2iF8rLRXi+C9TIMBoJ4NQpg0YmQNuv+9ZWQFIlBCnQmChY8/H95zv15b3Py2ED
    7uIxLMJOFxCbtC0F79ZV9CH7s4YxhmA1WXEXV+UMmVU53G1GQ+Tp5AahMYpQ0PEi
    O+GVeuePlGhNjHTK6Ixci7Fj+l0GxYSELT0BXXbfaqZjUWp3Mpwe516mvHWgbmEG
    P3IjL8X5V2xpZV1qK0OKOrtP5Ja7cIa2je1KWGxiIWefLLiTizzNsI1wiOb25AOV
    12aRHicdtm2qBq32x6muRRzSHto8RfSUtTF9W2og==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=CQ8oyA4S x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=QdwgcKsY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=CQ8oyA4S x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=QdwgcKsY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNXd3tSbXOqHYPLkTYmg7agnT3Ckp8es4Mvj2SmBfokufznzXLrbtJRxdKKCNQJ7Zn37sr5OEJbrpFWVQasYeq+uZRl+BQ7cG1Osay9U3XZDLGXuAUHh
    2qr/EIx1YWuJFtCxVuiEU3sw7GaAb1vGGwn21VWqhbWvNKDbUU8WszrbK3R1xBi9I1shjgowKmC3TAW0bqQPC+z+NF9diMNT1wRf+vZ90wJO3a81ZF7j0POH
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=eRTpF45XpbGsSURLGqkA:9 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeEULJb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 07:09:31 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40756 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeEULJa (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 21 May 2018 07:09:30 -0400
X-Google-Smtp-Source: AB8JxZpsnY4GS1opjluLpXOYdMVXMMXCQt10PBJ7Z/BXjJlxPluuHhimsHVZ+fRnAHq3FgMTyGG8gg==
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] tty: add missing const to termios hw-change helper
Date: Mon, 21 May 2018 13:08:44 +0200
Message-Id: <20180521110844.30728-1-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add missing const qualifiers to the termios hw-change helper parameters,
which is used by few USB serial drivers. This specifically allows the
pl2303 driver to use const arguments in one of its helper as well.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Greg, are you fine with me taking this one through my tree, or do prefer
I split out the pl2303 bits?

Note that this helper is only used by a few USB serial drivers and that
the pl2303 bits depend on a new patch targeted for -next.

Thanks,
Johan


 drivers/tty/tty_ioctl.c     | 2 +-
 drivers/usb/serial/pl2303.c | 2 +-
 include/linux/tty.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index d9b561d89432..d99fec44036c 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -290,7 +290,7 @@ EXPORT_SYMBOL(tty_termios_copy_hw);
  *	between the two termios structures, or a speed change is needed.
  */
 
-int tty_termios_hw_change(struct ktermios *a, struct ktermios *b)
+int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
 {
 	if (a->c_ispeed != b->c_ispeed || a->c_ospeed != b->c_ospeed)
 		return 1;
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index ac231cdf48a6..5d1a1931967e 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -533,7 +533,7 @@ static int pl2303_set_line_request(struct usb_serial_port *port,
 	return 0;
 }
 
-static bool pl2303_termios_change(struct ktermios *a, struct ktermios *b)
+static bool pl2303_termios_change(const struct ktermios *a, const struct ktermios *b)
 {
 	bool ixon_change;
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1dd587ba6d88..955cd0c93d84 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -527,7 +527,7 @@ static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
 }
 
 extern void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old);
-extern int tty_termios_hw_change(struct ktermios *a, struct ktermios *b);
+extern int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b);
 extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 
 extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
-- 
2.17.0

