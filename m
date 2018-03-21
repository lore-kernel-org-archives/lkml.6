Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521623531-2-10469446595283841994
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521623530; b=aoJOIeX0mHqcpXAny4GKYbaqkHF1xKe2RVlHx8oxd1CkHgs
    6vaLKDNvB6fDLotpzWIz6vVuSKVgjtk3cOducuJrDHN4OAGEU/yaI+AQ07ICI7RV
    6DMN4cjAFfTrNrt9TnfJvNi3pwRcXMCsNaj9CgzxS8piEuk1vrKOpiZXiRhgStBr
    40X+mqrlP7NPfEEYkqY09BvrVga95yvFHsCrGKjDYxzHg0UnVVXONt03dVzNobH0
    N0znZ8Bnk3kxEGjaIabSQkHUKvYl96B1O2i8pitXMWTPdwHSX6ZSKTN3k02LPvdD
    5R92iM68kgQl9ocUqXB7ohMFol3Z9I2FrJoGNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623530; bh=h+MqpFkcICrRTqNZvL9CF98Otf
    6gZVLXRQPlfxlnWJQ=; b=fvgWkpanAEUZPpxSY7UXehPm8jdPZV+rQ/H2d8I3We
    DrJ7kdtZQiTkMygLnEtjdXcvmTBbpZ5HWLfquCjrvPLaKYoygN2z3MIaZaka/7K3
    bc2PvWkptKgXvpynRZckF5zq2dw+Td5sasbHDOnxdM+/LdRJYiwJ7UtF6A/xXw2A
    8n8Nz7DesBPcEXB2jZdvlliQAq3hjbV4BQ+T+ByFtdtu0C+0xqBYzdbUSmNxukVc
    9XobHW8vkuoOx5SfkzBLn7hCq6IRV35S/k9c+0DAdiekYPV9KkQH07w8nACFHjbD
    c9JELjSEf6EK5sQQN2bd6gyS6PFep002rXUAGjYi5IxA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeCUJMI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:12:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCUJMH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:12:07 -0400
Date: Wed, 21 Mar 2018 10:11:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/28] net: convert datagram_poll users tp ->poll_mask
Message-ID: <20180321091157.GH14085@kroah.com>
References: <20180321074032.14211-1-hch@lst.de>
 <20180321074032.14211-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321074032.14211-13-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:40:16AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/isdn/mISDN/socket.c        |  2 +-
>  drivers/net/ppp/pppoe.c            |  2 +-
>  drivers/staging/ipx/af_ipx.c       |  2 +-
>  drivers/staging/irda/net/af_irda.c |  6 +++---

irda is now gone in linux-next, but that's an easy thing to handle when
merging.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
