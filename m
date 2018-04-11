Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523473727-2-15910206503176976954
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
    1523473726; b=mDjAmMCgGOP3q3r0himbS955ZpQZ6vkMkzTeZ9aGB1tuYYjhu+
    bPBRY8QZTffQxJsF7CfU8Opmjo5fAFTzw4CW2xOWpV4Vf1ovTXgVgCxGSPM+l8+Q
    YC2pIV5e3nt1Xlgz/BnTJDf2GfBmny4912DWpLSAWW6KYXtsXbmuL24/gafD0l7a
    sfsE3ljYHEu/r3BwpYBn69iutsPnmjeu3LJypzdVs23pijb1cOKABJaLzE6eDJUz
    z9fQqAujygD7OwNqLIjBhRWWyuUi2syR3BsIJhOLzH6vAG2+7eXQuWfFDbeDISBn
    Wpgf6H0AE3KzCcxYhrDcrAn0XPXBhzUbrlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473726; bh=mQZDkdgB4bbDNhmmtUaGq4Gvbalggi
    GkwuoH8rqF1QM=; b=BrdpEkzS7lJV/R2Ua5FpZP9KjU2WYl+pKCVSQZldKweJkn
    IZj90WrjFaIcRS5mu/Qs2WDZb8m30AwNerHlVbpESgB+0/+wxt7Y2LMqpGNOanIx
    9AfDnJ6/eHeCbHGwXp85ZCYv3h/6TftmHgqenvTBrkRXH4Kk5yYcGGBYEgEiY9mG
    0JCwcM7N640wrbeoRp0DLPWPn+MK4lhoMVTPjJOLqwJ7dH3RnHqmW2YzF9D3zaqw
    KQo8NgWRI0iiWKyWANBqSGSpFtaW9xk5aLwaxEb1RabKYf3QRiRoID7ZCiEMGFhj
    dwYBQBmnW5+HaEIYABlhYyh1T8And9oCftGZbYrw==
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
X-CM-Envelope: MS4wfB7ZYztpvuq7+aiMEyjLnTxwrHD3swaffm0OFh3PPGvWWVzsrGThupxGy3bparGpW7viMI/tx6/PLzIg5aVt4FU1/dtgJ/oqZXUuoqnmPTyXHhdZuH9r
    q6qtuOcoYjHQzludN1J85BK5bH+6C71x4DvZ5/UluSlTicCY/itMVbO+nUE+kjS/aomTdN1Yd8ZuUYWK7WCjBr7HWb1BviqpZzeXiV4FTW6iy/NnE9mznHjb
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=Y7yGX3ukNk2mNxy08agA:9 a=8XKPzbGZAI11UYcX:21
    a=iZUM7oMXL7o2SP0L:21 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934567AbeDKTG7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:06:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40984 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934027AbeDKTG5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Darren Kenny <darren.kenny@oracle.com>,
        syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 288/310] vhost: correctly remove wait queue during poll failure
Date: Wed, 11 Apr 2018 20:37:07 +0200
Message-Id: <20180411183634.992629242@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Jason Wang <jasowang@redhat.com>


[ Upstream commit dc6455a71c7fc5117977e197f67f71b49f27baba ]

We tried to remove vq poll from wait queue, but do not check whether
or not it was in a list before. This will lead double free. Fixing
this by switching to use vhost_poll_stop() which zeros poll->wqh after
removing poll from waitqueue to make sure it won't be freed twice.

Cc: Darren Kenny <darren.kenny@oracle.com>
Reported-by: syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com
Fixes: 2b8b328b61c79 ("vhost_net: handle polling errors when setting backend")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -211,8 +211,7 @@ int vhost_poll_start(struct vhost_poll *
 	if (mask)
 		vhost_poll_wakeup(&poll->wait, 0, 0, (void *)mask);
 	if (mask & POLLERR) {
-		if (poll->wqh)
-			remove_wait_queue(poll->wqh, &poll->wait);
+		vhost_poll_stop(poll);
 		ret = -EINVAL;
 	}
 
