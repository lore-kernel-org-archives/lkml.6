Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519410943-2-9990997833104685482
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
    t=1519410943; b=E/0fyzfkTbBJ0OaaJIhxRw03QvguIizY/QqySvf4MUSa0wB
    sy2D2sTZkeY+lqZig13TtPDqVvq/cA+XbCfULHpK4Z4v3EvCoMwVUDKbQNk8IuPV
    JEXtUkFCMUBX+t+MVja0faLN4X3aNxknf1SKnmHzjCJlk/wu3zXWm6x+btpPuPKe
    cP95lpUJcK2F/FPIIPDj6tjlCVY9W1x7QYv966Wz84piQMGVn+w6D7izkHhNOyXS
    2xiZNOQH1PBfBqePClSLfEUOlf9VLPbEDj3SDHx6mpXyK1Zys6MeMq3R+fJhCEvq
    0LkKGqAq//4ra0941rQLxnREgElthcKn8I7hyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519410943; bh=0HUeRsc4WeX+r+RRdHJHH5wKPc
    8sYNo5xdAn0EKBvpc=; b=PAJAjnBZoE7aJBBtQEtd1r0lJGep77Sz6zY34rwO+o
    XXTl+UN+Llchygh8JeNzpXLz9IjkIIQUyunvVHy6N2Qx3gZhNlVzGXwa8qTNNYh2
    8ZHfVHACBm1wUoDi5yzOuCOqJTsO9zNk8sGoig7hhdxI9UKcK8I4zeLZnlrtaeHo
    LJkq72qGe5oFTL/t/fI7yGl9sU0pgWq1tI543JR/WRKZcd4DVNF9rtJa+ze/f3Dp
    ypn5pHzl0uRE7ZAYCDLrzUv/p7arrS/gA9awLrVnZoZrFwvc+LQCjDLMlR4GPdgl
    n+ntmaofUhe3eP5JE17BIb3IuAmPlzWHhalEbfLgJODg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeBWSfk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:35:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37372 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753875AbeBWSfi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:35:38 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 063/193] isdn: icn: remove a #warning
Date: Fri, 23 Feb 2018 19:24:56 +0100
Message-Id: <20180223170335.827722797@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 01ed1e1504ac83a8b0b365c9f55d3427babbd7d9 upstream.

The icn driver currently produces an unconditional #warning whenever
we build it, introduced by Karsten Keil back in 2003:

 #warning TODO test headroom or use skb->nb to flag ACK

Karsten's original commit (from BitKeeper) contains this description:

    - here are lot of bugs left, so ISDN is not stable yet but
      I think it's really time to fix it, even if it need some cycles
      to get it right (normally I'm only send patches if it works 100% for
      me).
    - I add some additional #warnings to address places which need fixing
      (I hope that some of the other ISDN developer jump in)

Apparently this has not happened, and it is unlikely that it ever will,
given that the driver doesn't seem to work. No substantial bug fixes
other than janitorial cleanups have happened in the driver since then,
and I see no indication that anyone who patched it had the hardware.

We should probably either remove the driver, or remove all of i4l,
but for now, this shuts up the distracting #warning by turning it
into a comment.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: http://git.meleeweb.net/linux.git/commit/?id=b0deac0886b0056765afd149e9834373b38e096b
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/isdn/icn/icn.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/isdn/icn/icn.c
+++ b/drivers/isdn/icn/icn.c
@@ -718,7 +718,7 @@ icn_sendbuf(int channel, int ack, struct
 			return 0;
 		if (card->sndcount[channel] > ICN_MAX_SQUEUE)
 			return 0;
-#warning TODO test headroom or use skb->nb to flag ACK
+		/* TODO test headroom or use skb->nb to flag ACK */
 		nskb = skb_clone(skb, GFP_ATOMIC);
 		if (nskb) {
 			/* Push ACK flag as one
