Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839629-2-1247819357571193775
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839629; b=Mg++3SS/9IL8fKlnLGNXIZWwu0JY4mqZE2SuZGudeWIse760zi
    7j2uS2zIXAefKv5ukNx8f10K8p9HXyktaXVlR4/TFTVB0hhiEjJeG4+FfhVwPago
    oRVVOaYEuWIvCeK6dJtjS2iUUcj6d2gAm4ZNAQQKNlKtZPBeIEXFCr5CyUN6XpDm
    BiTUDkD12sypVa3C9KTngehX+uFDCBqaDg/zBXF7dhMIczwsqCOQKOqgZyiqnNmQ
    4VXYxwwgsAFKnxH+CLEtU8p7IWWXWIFdXuUGjlSk8LyLhqdPwR9GFs3UPJCvRVC6
    NRblSxWvCAoWmhQdY+n5gbYx4rw7kgtSVxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839629; bh=lNCj2c8jBm457/JXSx7UlKaAh/EotA
    n2L1cw54wYZ88=; b=jPSCkDAewDskPxMF+9n8HdivWTgfvbsm41T3mWl/56AHoZ
    9Uh6HkgGt8pOcSswvB2Mph3FyRVoGxwDOuQJlhy4ZTBx8+mTnrv+2w3aYLV+ovHj
    BRjK7xVsyd53IeC7TkPg1AAe0ECV87YrNQjLQg1k4AvtFQkOXp8fQGaWIDySW9Es
    2T4KZx8THGCK8Xo9T8/VAmmugsSNLWmb8OonCY1sfPeUJnXyI9LWB/j50Xyl7IP0
    TY3wkbZhmyLKwizcRgkICoXnAne1SGe/b5dFpjxXmpc6wDlomQii7x6jgkCPhmuY
    EF1j07VkgYQT4Dzzpei+gG69TbWeypiPDpMkRbZQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF1l/mr/vs32hJi3GbPBigh0B2Wyl/fOMEz7qcKOgkIdmpTgQCafZfj8sn9e25Kor4CqMUzHBjrHT5Z4t1Vpo6DC9s5hSJk2u7Ls7KnwSgEu/G4b/mAi
    3a2LIILUBA9+CjJNj49mlleF9rAQklyEnW9ZogSnG3onJbS4IeLxaJUUZ/DIBF76a1rX9sB7jE3sfvHPvffk2hae6WBONqtMq1HBrioC3Y6zmK7yo6DFgCjY
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=AeCkNC4mAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=sDnBjJAm2pfqMEeON2cA:9 a=QEXdDO2ut3YA:10
    a=3H0rhiSm_XezoJcgKFaR:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934356AbeD0Odc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934811AbeD0OKQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A26021864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 23/81] Revert "macsec: missing dev_put() on error in macsec_newlink()"
Date: Fri, 27 Apr 2018 15:58:25 +0200
Message-Id: <20180427135744.539038833@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit bd28899dd34f9283c567f7eeb31bb546f10820b5 ]

This patch is just wrong, sorry.  I was trying to fix a static checker
warning and misread the code.  The reference taken in macsec_newlink()
is released in macsec_free_netdev() when the netdevice is destroyed.

This reverts commit 5dcd8400884cc4a043a6d4617e042489e5d566a9.

Reported-by: Laura Abbott <labbott@redhat.com>
Fixes: 5dcd8400884c ("macsec: missing dev_put() on error in macsec_newlink()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macsec.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3277,7 +3277,7 @@ static int macsec_newlink(struct net *ne
 
 	err = netdev_upper_dev_link(real_dev, dev, extack);
 	if (err < 0)
-		goto put_dev;
+		goto unregister;
 
 	/* need to be already registered so that ->init has run and
 	 * the MAC addr is set
@@ -3316,8 +3316,7 @@ del_dev:
 	macsec_del_dev(macsec);
 unlink:
 	netdev_upper_dev_unlink(real_dev, dev);
-put_dev:
-	dev_put(real_dev);
+unregister:
 	unregister_netdevice(dev);
 	return err;
 }
