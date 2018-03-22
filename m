Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039695-1521732301-5-16766335009642951018
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521732300; b=HCzHGPQ8OrgA//vD9UmKSi+1DSQvzCbSvXCdE8/F+RiToFo
    5MdzYm0sFpjFWdIjfSmhgPxbjLECv65j3k1DeYgU9ZDq/m7DhQOK/QH4LMjs2to/
    TGlS8Ver9ob272j0Wpr8FEYmhvgW2fwFdJEwq/WgdscbiOFz0Wddl3Yq/vl8YXZV
    CsLEzIL9FOAuydjnP7cX6InaYtXLEgbZ7YgwWq4XmURlg/yl6Rs75bqtB2hwtLHc
    DpJvAcSYKxuC/67qAgCAgUA6Z107Sx+pcRyontFBbFb1e/WvPsurixNmTw6SqPYq
    BWDqRA1CxmOjM458BIlN8WKHVfPdpvRg2sLcDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521732300; bh=+6HnzCiV3DvA9ebfQZCgAoQNrl
    humUq+YZdYRra2X+U=; b=Y0nc9QJ2JVl4SlnRL2iGAZRtEOU0oHPVB1HtWWBt8k
    1vg+YgMh9K/RJEWM+0ioqkHwIsHZEOvpv9Gy4taWgbuYVzfK/0esMgRQx6Wtt7Ko
    Y4jZ4z/1z7In0fPmLPTxaZXeYoa9ZPGJvHa83LyaPs5hFd/eYEaIdXnx5iFZ+Uwn
    tgHW9lOoVdGKBih0LZjUbX9G5+ZcM1TEeS4v+y4X5gJwlhLXgL9gsdgMMlKjiSer
    S6OGKY0XMc1ZAzgl2tPmdsMwssHJK1V0Yj/WHIAjjJ4OlqNflNcpdm8tBqzxI8HI
    B/lU1iywz1tyC5qItMXOx0buI2aPe47KXASWxbnT6J6w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeCVPY1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 11:24:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33350 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754542AbeCVPYR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Mar 2018 11:24:17 -0400
Date: Thu, 22 Mar 2018 15:24:14 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] aio: sanitize ki_list handling
Message-ID: <20180322152414.GF30522@ZenIV.linux.org.uk>
References: <20180321073232.13366-1-hch@lst.de>
 <20180321073232.13366-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321073232.13366-5-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:32:27AM +0100, Christoph Hellwig wrote:

> -	if (iocb->ki_list.next) {
> +	if (!list_empty_careful(iocb->ki_list.next)) {

Umm...  Why not list_empty_careful(&iocb->ki_list)?
