Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214437-2-12319437680463636659
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
    t=1521214436; b=PBxYV3dLmfHiZdvhGHysg8X2agHEMsElYpMd6tQHtzlQz9J
    RtzVnhDSWg/qnAUM7MCTSMYECED32lVGBTZIpnTzFZxZN1oAyc75nV9C++sdNGYO
    vibOo93XjvOGmDLItWm9gaPGvn89ThY/BTaalBSqjeIulAMFgvB7VHBdOo+uOYvN
    32Hqfb4K0FIca0WcOKuLSIkkp/1ALtX8tnvAgDzodf6/93V4HR8lQsb5FKgOLq3g
    +Zbtz5nckmdzndGRBHyiDBbq1A+Lu002GHFP/t7rPfCJKau/GsQsFCIlrhrMgpX1
    7/yUUMUpROfnCP7uifK1PPFShBM113hedA3EP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214436; bh=pWxfpzG92kekcMdQ3WTpout11w
    7zKxG8vRswLHot94k=; b=KijYhFa6NiLxxXDdxH8gxCg4kd07r2MR1tnlF2EEVe
    DX1k01Cloqeo/cYyQ69WSLC2jJt18q4XAbOogSbvamMmOOvp2x4OBRjFjCUhLpoR
    rehC/SeELoLaGsnT1Bk+bIBloWYx5WACejXWC3Ib5oJwN1T6Q9c/G1TpplpFB4Nr
    O6XZ7OGHCVruDBA4K+2onctJHKoKbsmo7XDLsK7nCzzR2Fp9Oa7Y/zJl+Bs+y3fu
    1NQtgQHW0PaMmLovLeJ9Ych9fquioWbbFbFiKlwCHMt+FD0VMzvnqxpDCO4DcAUq
    q58QA7weZ7fTZFsvBB9A5VDCNFgEITpoE1DDPXTq9O8w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S933808AbeCPPdx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:33:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39182 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933832AbeCPPdv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:33:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 84/86] serial: core: mark port as initialized in autoconfig
Date: Fri, 16 Mar 2018 16:23:47 +0100
Message-Id: <20180316152322.993784908@linuxfoundation.org>
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
@@ -1135,6 +1135,8 @@ static int uart_do_autoconfig(struct tty
 		uport->ops->config_port(uport, flags);
 
 		ret = uart_startup(tty, state, 1);
+		if (ret == 0)
+			tty_port_set_initialized(port, true);
 		if (ret > 0)
 			ret = 0;
 	}
