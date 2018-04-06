Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523021541-2-13471616553437931021
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021540; b=pTJnLRxUDcFVIyGgdkc1b2Md9pAEObXhSpHXGnQDXf62ItfabR
    KLX1CqdEW0m2RcuUepGPOqGjmW6HBP+rUAROoUPLiLYdc0HddETfgK4Y78DHBQff
    eD7swiVFZdm+j/EEzVUi1ZJ3f7jThDjEo++wVKgxe4rc4Lj0Gc312xuHV6Olm9Sk
    TrpPFbUVUsBFMfMQZQ/LDq8vSS7VjjjRGqZZOQUroIssvKDziYJ5GrxJyZgk3cKc
    gh9iZLE8zj8my9GJtvLqadMS8nBryL01vqfCst9/mln82KfVBvzh/M5P8BHaC6sC
    E4gMZB2uWgjBpVkyhHgA5K3a4d4mLicOprog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021540; bh=RO0fnDaNZZfjBjrPJUcSTcpJdgUAg0
    cDSYLXSSEFAxk=; b=LNtRzQKTXeZdZOg0irgpt7dUwbWEHUpjllZKpPKPQOTpKY
    ZgkKU/qm9lRAH0XsDsZOzxp1NBaoM4JqPY0AZ+6sqUifjYDxprkS+gs0z4B0KuaF
    PbdIRKnJuzOQThpvCwYDRAhdx9/UJ/F8Q34D9hcbwXMvFYripUsxpbQlZExRSin+
    LYcFm8NlsWhB7tSUzE0Ev3qofzEkrnDxtf+MDtVmMmKwLgKAlB6dwuYFkZzKOs3V
    RV6NYylAxBHXHb8glH3qalWuoGWbTOLf3rfyflhWEvuDjDHoYHRqUjvJQm9U36JE
    ftb3ahOabYeOJscw/ImlycyfAXAitNL4azrtoIjA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfBB3mUTV0Zvd/Ts+xLEDZkgA/bG1HR6nrGtDx+MqrFOS6I+qL7UqqxDFiHKNjtJQ7YbgYaIyRdGBbhC2nNwFPH2gR4KUnVtpbxgcp+slTlB0mMx9w2qs
    v9jh/uEjLZX0qx11ttxlCMN8gEoniKEEIf4VQkE/ywi9UjK0QnF4PtJNQ2zzVr9WpTFXfOEUie6ZhJf1SxJKoLRfunx5kZC5E4oGtIbM3u6klVRsMGZYUy3x
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=1EsaE_6oAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8
    a=iC0j8UYkz9P5EM_vmR4A:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=3ZumFrijQQ-2J9H5h8ct:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755305AbeDFNcR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:32:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57464 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755304AbeDFNcP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:32:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH 4.4 71/72] net: cavium: liquidio: fix up "Avoid dma_unmap_single on uninitialized ndata"
Date: Fri,  6 Apr 2018 15:24:12 +0200
Message-Id: <20180406084311.816498986@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This fixes up commit 1d1cb762524f05cfb37994e0d36b7b4b5e957134 which was
commit 8e6ce7ebeb34f0992f56de078c3744fb383657fa upstream.

Ben writes:
	This goto should not have been changed, as no DMA mapping has been
	attempted at this point in the function.

	This seems to have been fixed upstream by commit 6a885b60dad2 "liquidio:
	Introduce new octeon2/3 header".  I leave it to you to work out how it
	should be fixed in 4.4-stable.

Fix this up by hand, as the referenced patch isn't worthy of being
backported.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -2823,7 +2823,7 @@ static int liquidio_xmit(struct sk_buff
 		if (!g) {
 			netif_info(lio, tx_err, lio->netdev,
 				   "Transmit scatter gather: glist null!\n");
-			goto lio_xmit_dma_failed;
+			goto lio_xmit_failed;
 		}
 
 		cmdsetup.s.gather = 1;
