Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521804227-2-17378643657379434770
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
    t=1521804226; b=c9/r7BY8u5ykwRHDk+nCGeaxpz5bMkq2/GjUJvUeWp+r8ta
    d/zxa7C8VDDRuGFFc1XOPVUAl9fbMrstaw28r3mfbq9Pua7TNaqDWJYprOHHD3Cs
    tzglifO/b0/c1z6KxRC6OgstA37F57iulI6cjH1dFxNqjDDadonk6UkpTS6jWcZ1
    dJFyuj/s8ZanScReWSOcDCgQXkdfuytBslZNBXL/TVjn3IYENxLrAMhJcPEV2HxX
    Mt7D3NHqjuhGkmNjjWSVP9NxRRzFzAhH7WMkD2Q1XdKYz52Xx928i4+mq/IKHeer
    qPxGE6BeeJoISTyiFV9riLjo3Rn90GLX9zI0zUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804226; bh=hRMKkijtIDujhIPtqeQmx1dGIK
    /b5fwlknfPit+iCUs=; b=K7SW6RH1gzqBGs7EzHNbLNIA6op0u7vIEAR9zUxllA
    vAb7Nkbn96pNVYBRRRQXmlxiKR/okOxK99ARREqbMWPB2BWjB9kNe/qh26Cg2IDm
    XvF+6aFnfXCUsrUJ8QpoBFrD3JA5IK/bHfG6RGy5hUGi7ydj7nth42XRn4Reb/vz
    OYU9CVomLMKwcwGUhAA+a6Qt/tP3rc1cPGCZH2VmPLCNpJg8k3JHdOX+V3m1aFtx
    gbiohkVRbnBxOMg3YmfXZPzzqxtj8fMysdyX4ODCYMzRZ5eOHBt+DnDOIa2CsD5v
    +Y1oqYuKoD7JHOJrEJ9ieDGMTUy/8v1yLQL3rpBvLHyg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755432AbeCWKIC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:08:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755128AbeCWKIB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 074/177] libertas: check return value of alloc_workqueue
Date: Fri, 23 Mar 2018 10:53:22 +0100
Message-Id: <20180323094208.581032010@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit dc3f89c38a8406554ffeffa370aad086a9c5e9de ]

Function alloc_workqueue() will return a NULL pointer if there is no
enough memory, and its return value should be validated before using.
However, in function if_spi_probe(), its return value is not checked.
This may result in a NULL dereference bug. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/marvell/libertas/if_spi.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/wireless/marvell/libertas/if_spi.c
+++ b/drivers/net/wireless/marvell/libertas/if_spi.c
@@ -1181,6 +1181,10 @@ static int if_spi_probe(struct spi_devic
 
 	/* Initialize interrupt handling stuff. */
 	card->workqueue = alloc_workqueue("libertas_spi", WQ_MEM_RECLAIM, 0);
+	if (!card->workqueue) {
+		err = -ENOMEM;
+		goto remove_card;
+	}
 	INIT_WORK(&card->packet_work, if_spi_host_to_card_worker);
 	INIT_WORK(&card->resume_work, if_spi_resume_worker);
 
@@ -1209,6 +1213,7 @@ release_irq:
 	free_irq(spi->irq, card);
 terminate_workqueue:
 	destroy_workqueue(card->workqueue);
+remove_card:
 	lbs_remove_card(priv); /* will call free_netdev */
 free_card:
 	free_if_spi_card(card);
