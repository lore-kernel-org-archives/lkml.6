Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223491-1524187018-2-1460104569035686435
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='hk',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524187017; b=r0LWBsZhhMjZdqA/weRKRCSCrCUlaUuP1YLV45Gp0L7OpE6Dd5
    v+jENm9A4ERKlPxlrInM4hq2VqPEZSvojWxw/UCY7B8hSWZav/YDh19wW89fBgJC
    3ZOfOuQ3SM7q/p5GSWuCce31dT4aArmjZdNUzaK9+r1j7a1ndvcS0aTVvNNkqdAY
    AUkJSTJri3SdhlDw0mb0Dz0vjQcj/tdORizeOSMkKATChCMbB+0Q5DUEbFHZB/eg
    C+33qPzhqoJyEMTvhu8JyPHwhJ3rGKfP7ZF+I9I6Cl23EYh4vYOicKjJnjCn60af
    pgJA6DcVfiQHQxkW3qm6I+nv12GSeD9Lni6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524187017; bh=9heaUHC+6BjjYAKd1MK4vmNxbfYQq2
    KJxXQHxlFOc8Q=; b=rRV3XVwJXVje59D6Ihca3NB1y8fNAKYi/SEKdK3mMR1827
    pVcVDCE5sj8R81kyzEF2S/IMUq832v36Df3l/EuCw5a2MqOnkTX9HYmHEvJ5NxVx
    9jpQvJ80nu5NddfhphI4EA1KPVRSl5v8QjQQktv1bX30HT6LGtzAJwkx3k5UC8Dc
    7qIGIueQB+9TZbrTKSoJvVKFbUzmYx3PMTfnY1NrTK/GrCiFAUrm8g42w9NK5nh0
    YJob++doiTXxC5zB2X+PwyB4voLmnedCh18l+e5KIUbWIbr8QnAV72A5jqPruRUb
    xfPuhrUwBPIsIAqgd59pR4Ff6bYxeGN0oNFd6DNw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gtsys.com.hk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gtsys.com.hk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gtsys.com.hk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gtsys.com.hk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJZ6iDJJK/WOWRLGuwkRxC9xPJcWgLIbO8qCPZbEAHF19a8iaMWESaXPty1JFE4yVA8lxHAbjcEW9q6/hrtlWo7rQHXfe8A9HY+7YJWgvpdE9A9S9Xrb
    APoupmA/k9ndwAnpu5GzDNfMeqdrlQh0QoBvmkPmFLA0AmT4OxZRQZT59rwzMT91gezT8/UNS34w850WXGNBndVQmeXRoGjRJRQOZBF5dJwe1BpqeQ0d168k
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=O7zmUmNSAAAA:8 a=VwQbUJbxAAAA:8 a=dEruC2ghU98leuGHHHIA:9 a=x8gzFH9gYPwA:10
    a=IJxu9zi5bFdC9NS7oKyv:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeDTBQy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:16:54 -0400
Received: from sh1.xit.com.hk ([111.91.236.50]:51242 "EHLO sh1.xit.com.hk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753703AbeDTBQx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Apr 2018 21:16:53 -0400
From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: [PATCH] serial: imx: enable IMX21_UCR3_RXDMUXSEL for non-dte-mode
Date: Fri, 20 Apr 2018 09:07:59 +0800
Message-Id: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.1.4
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix a problem introduced with
commit e61c38d85b73 ("serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off")
result in non dte-mode imx-uart fail receive data.
By add back IMX21_UCR3_RXDMUXSEL the serial port works as expected.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 91f3a1a..3d09933 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1391,7 +1391,7 @@ static int imx_uart_startup(struct uart_port *port)
 
 		ucr3 = imx_uart_readl(sport, UCR3);
 
-		ucr3 |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
+		ucr3 |= IMX21_UCR3_RXDMUXSEL | UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
 
 		if (sport->dte_mode)
 			/* disable broken interrupts */
-- 
2.1.4

