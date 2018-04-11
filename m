Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-978433-1523408160-2-14830340448092944093
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523408160; b=UlTNC7IBi0d0+En8n5qIZ8IY2FNQWiNcGcz5PZMrb8+z39P7QE
    uc7CDADZZVrwzS2Q8Pk30ac+HxhNGFVcshyt3h72rdtweEmN2tPiRLob8A3mve6s
    qGVjbMQpP68qfNqiSw2lENrZB+gehy+vRetbxXug9B+llKetKNWyepRPRDy2zMVH
    cJaILTIoQIGwOkHv4H808z8zauY4yDioa3YP4QIUi1ru0kDj+AY7lbzbLBqzGFmm
    HR5PUwZwNBY5KwJYpnTo+MG+xL2WLTpq5faT5qr2H7Rxtvh4DK+iYuqewZ/oDLRc
    lr57HwOFW9LsC7R8sccXKefSbofot6LC4Kmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523408160;
    bh=J7AG3ADkRhg7EUpNHg/vYtNzSWSk6j8N5s/oTtqMrrw=; b=cI+dXtslubu0
    49A7WG7qdcmC1cFk9o7En3dGnSiFpxEvRXGhLG1OQDaKFD1KH+J2zFCkMMbjHD7B
    E3KjuEqpVjGhWn2EZtiayVZbb4va3vtKkQoZjXMBpLrlIcpG1wvZPtc7WdiMmoJa
    9E5Evi4p9LgDjUXlPnbU3ZRfLxcni0omwMyanbgE0GZEAdrhqXCNzb1RzCDzwDOQ
    VKjjhs6pGZ2C2rftrkosfvuICLIS6SEWenSw0UVe+ZYoMkwD6wvCYvefSJ38z9lu
    KayotS2sIwT9FRueq1pSxUGvA7V2LVkCr2vdMQ0JOkG07UhgJDhWMDDbngDyop/n
    PeqMW5tFAQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBlC6RbpC+lS9DeseQXm3C3dDJl8+FH+cEFLg+9PFkN3o69id9mUn8k02zlnLqxAcotECRltdnrbw9kdmfR+s9+MnJH9cmxtK3YxFUQ8oUIlxGtgxF2z
    lVhAPLyuMBbXVD59LSQQqsqSRAMGdbHD1dI9fYm0vVZ16yStUK+k7hnzK1UiDq0W1VROaSbP7o1pyAScbkkq795F0uOTz6dDQTefB1xUrl1ltz+yvLGJ+F3h
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=gu6fZOg2AAAA:8 a=IQ32DifDoM4kLaElc5sA:9 a=CjuIK1q_8ugA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeDKAz5 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 20:55:57 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45932 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeDKAz5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 20:55:57 -0400
Date: Tue, 10 Apr 2018 20:55:53 -0400 (EDT)
Message-Id: <20180410.205553.264864966341341110.davem@davemloft.net>
To: mst@redhat.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH 4.14 134/138] vhost: validate log when IOTLB is enabled
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180411023210-mutt-send-email-mst@kernel.org>
References: <20180410212902.121524696@linuxfoundation.org>
        <20180410212917.818627954@linuxfoundation.org>
        <20180411023210-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 11 Apr 2018 02:33:16 +0300

> That's a bug, davem just queued a patch to fix this upstream.

It did not get queued up.

The patch series didn't apply so I asked the submitter to
respin and resubmit:

	https://marc.info/?l=linux-netdev&m=152337186209819&w=2
