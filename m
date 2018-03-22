Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230827-1521738263-5-3675082926192136767
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521738263; b=j0rYH30u2mv/Cp0tFKBeGtJ+pDg53AVFXrr9ksBUjXY6kH/
    PwCaCfQHLG45dXxKeLZXqqah5ttoSaUqZjKRV+pntZG4IGh+oLQVGXuqMJi9pOaZ
    EgcFFhyW5UxFZrpLFFiHSXbw/ww6wORDxD92s8bMnPAqQgQ6KrEr1JI1wYOwHgwk
    1locZSFoR98GMbg1r3SOOq/+y7etUHmAX6WO4qJgUHfEF3FeSgBNsc5QrpPTdcOA
    T3/aBiSe7l4b3FJly0UvrrhupMxwaLMrH5SWLAHSA4wwH0IjKbmrxbjq0vVuqK9N
    s1GduHqGEe+17Jpxt6gKgedAvjMjZHEFEDOQIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521738263; bh=KY28v2bnjaUbBU2uNyev0JLELz
    0HlK4BCTbmkvfWCak=; b=sgiB+eWeN4ZF6IQdIH1u6cJNzq7QFZsXkNPW/fNt4U
    NiYPLxbiXZnlEr0iN4A6e3eaTuYb1DJK6tf8GhPhAxVubp9tjKAWZL1RX8o3J7Qz
    R6YlEG3wEX5mPRKSTivwdSFJv6+Q4hkOk8UmUfsa0d7srxp46WWqP7agAa5Nk0ND
    KaYQKk7/NtwYcd9Bd36jDoBnf+WC/5imuXPYU69bUKJAFkhQjeJBciMd0V6MoNWQ
    +wLSW5KwWGgExFawikprtU65+o9zw3imj1hxB8+wT5TnGXJCeyvlAdRxi9RojwlD
    t/77bjKBjXVjHyz4HR+sZE5fCMRdK5makJWM9gKDGexQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbeCVREH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 13:04:07 -0400
Received: from verein.lst.de ([213.95.11.211]:48078 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751286AbeCVREG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 22 Mar 2018 13:04:06 -0400
Date: Thu, 22 Mar 2018 18:04:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] aio: sanitize ki_list handling
Message-ID: <20180322170405.GB5542@lst.de>
References: <20180321073232.13366-1-hch@lst.de> <20180321073232.13366-5-hch@lst.de> <20180322152414.GF30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322152414.GF30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 03:24:14PM +0000, Al Viro wrote:
> On Wed, Mar 21, 2018 at 08:32:27AM +0100, Christoph Hellwig wrote:
> 
> > -	if (iocb->ki_list.next) {
> > +	if (!list_empty_careful(iocb->ki_list.next)) {
> 
> Umm...  Why not list_empty_careful(&iocb->ki_list)?

Yes, that makes a lot more sense.
