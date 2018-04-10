Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-807177-1523400230-2-6326898412477971058
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
    1523400230; b=VM51yKD8474Pc3tnQ8W/Bb90yWfTi8DektMFRUocznQdMJrYug
    YYcm/uXPkTfAH6VIJvfsF1z9upD5zzc7uBjiwyuw1HK2vrmQQGYx4lsp5xKdnpUa
    /kOIXwJWmVrAqCTOBru91UZXZgtXNeNWA2ib6PIKK+8b5mXuH5b45Pd0e4CpTmz4
    6fwsOWRX/W2PRUC842Up6CVEHRMtRzooiOi6Q8ci3tBvJJwj0gTShBG0vatfFf5a
    rKFRvQIERACYnNAY0GVMdQXDZerrGKGY5m/lmB+IolWSxobwr3ocDr8AxK3CwC9p
    378Y04SsLFfZnmPJ6UbzIGFJwyB66uCB9hMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400230; bh=L5f4DsnvJCEj8mJwS43wiqjrOFN063
    Y6gaSrGWbDQI8=; b=aJ9qxxqMPFrZK1OHSA7GKLFQBvN9AHXLEJpGGIOtoLEZ5a
    7zGrRuTluTEGZlfexsO5mmXMb8jP+VXhzsE9Zu9gE0Dj+5z+nE8FKQ9+USulf5yv
    30d6sTD+7YtHpQlbEtgWz/pYUcqDOsXtXcqecv8ZfUar/sSb13YKhRSjqqyuh1PU
    xtxSkXc9thuouGa8Y2e5E6pieM3RwZU3FN+E5B+dk/XrMRMnVp40GG+p65fGMGQp
    D0LyGx+0CSc2OosEiUXxJPQZiDJWl0dza6Quan6auZZqliCo4phnEIfFG+kOL66h
    9HfTfLClmY/uAfnfZQfc3d1niQDShDoqhu15It8Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfGm3UDdEj7romPvX6UIx4BzZ2YwDMOQS3+zRbuXXQlszNLSVn+HdhWNp/peoLFFXuvL9OlRWNnECWKHuu+CG5R/GfA1Y/APXfq0O3qi0j/ParGIMwr0H
    AMz5KfvpNWYURC9GEy0totCi/pzmkOWu9qHw+vuUOOFcoKETnAPcNNHe2h7oTF6ED9HM46cEujdcMCFwKQxqpIQW2Epoo/zhTTOzv0Kn/4l95mDhPh32EdPt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=Y7yGX3ukNk2mNxy08agA:9 a=eX1tjFrm8-UU_n7A:21
    a=iZUM7oMXL7o2SP0L:21 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756074AbeDJWjh (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:39:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45276 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756072AbeDJWjf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:39:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Darren Kenny <darren.kenny@oracle.com>,
        syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 111/138] vhost: correctly remove wait queue during poll failure
Date: Wed, 11 Apr 2018 00:25:01 +0200
Message-Id: <20180410212915.098064426@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
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
@@ -213,8 +213,7 @@ int vhost_poll_start(struct vhost_poll *
 	if (mask)
 		vhost_poll_wakeup(&poll->wait, 0, 0, (void *)mask);
 	if (mask & POLLERR) {
-		if (poll->wqh)
-			remove_wait_queue(poll->wqh, &poll->wait);
+		vhost_poll_stop(poll);
 		ret = -EINVAL;
 	}
 
