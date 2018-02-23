Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414942-2-1038934614439298089
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414941; b=YpNGZnj9JDAEbZZLHwv+30ZlSlZzcVoId0XjJysiqxAtdcF
    yIOkhgMwLtVzc/AE3eDBftpmEpGY2lIHQu2kqJcCJImyPGpumUy3PYCkxRZyiQ7m
    XDZagCSQt5oEMhoEoTwzk1TDEhXGD8jaLKSAXVtjtogIUwNT2F/GnDCpj5a6MBUU
    oUcNwKzVFf0kZXY4uyc3yFhzSMw6cECaArw1fAlc2EJslbc6DDQffaPHRR/iSEaS
    LR+g8FiQ/US7P+CK791S8WOZQ1Ti1gn5STePcJLKRjUU7tTYh4hTQgOKHVfIbKTU
    KKJFKxkZQSfp9K8Ps039jzHZm2jgXSPmxYmo7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414941; bh=imXk5ExmtYS0u4px6oEj9mv40O
    yxX0LemIn0pN96qFo=; b=QCOTti//n64oBKZtFe2/AjAgol2c++Cb2eFiXiK4ZP
    qxLcBAml8AMbSnxKLbZKAe1St/hmFtuvPyiXnUv29wFsGfXT3fu2vKSOgW597o21
    YBW9U1PGEUio9KpvNyv6Poc06t8wBlOhpUuRZiikLDIFQvsgWUMaplZDnORt75j4
    iW1fM3A/Hh0UVcKNVw69yc9IRG+8TuMmyRPa52VUzGihzWXvu68BEeOZC/cGoKfp
    b0m1yz9KD98T8YuDhqChF1mU3W3Y7QalBoefBOTLuIa+T0LFBZshgMpacbNZqvVE
    xC2Cdht/eieUHow0zhs2gRkSxl6yfzoSbgdZ4ddnR5lA==
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
        id S934414AbeBWSse (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:48:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934405AbeBWSsb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:48:31 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 138/145] idle: i7300: add PCI dependency
Date: Fri, 23 Feb 2018 19:27:24 +0100
Message-Id: <20180223170742.562665464@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

GCC correctly points out an uninitialized variable use when CONFIG_PCI is disabled.

drivers/idle/i7300_idle.c: In function 'i7300_idle_notifier':
include/asm-generic/bug.h:119:5: error: 'got_ctl' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (unlikely(__ret_warn_once && !__warned)) {  \
     ^
drivers/idle/i7300_idle.c:415:5: note: 'got_ctl' was declared here
  u8 got_ctl;
     ^~~~~~~

The driver no longer exists in later kernels, so this patch only appplies to
linux-4.9.y and earlier.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/idle/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/idle/Kconfig
+++ b/drivers/idle/Kconfig
@@ -17,6 +17,7 @@ config I7300_IDLE_IOAT_CHANNEL
 
 config I7300_IDLE
 	tristate "Intel chipset idle memory power saving driver"
+	depends on PCI
 	select I7300_IDLE_IOAT_CHANNEL
 	help
 	  Enable memory power savings when idle with certain Intel server
