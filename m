Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1302654-1526119561-2-7691528735125378811
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526119561; b=RZ2KPPniPgWqlWY3oAwnKJ9SxqafGk6mv8jPmZCu4XJJUGnWME
    pinVcMhf+lZvg0GoCDkXzsgsOE6mBRWKrWh9nH7dp1fqAZmdSu9wuGwcph+I0V4O
    YLN9/L6BHpCYfgbzhpGUBlOcIX+aLhCXciXLzUlFG3kIt4WZ5He3jbQuS2G2uv0f
    q6PkrelJt37CMq1b8b7JLogbHgNxh4MlId7MshUNHAD8g068XzyEkhxwKtYOywip
    mqYPKxXe32uvXCe9Z2/llRs5pGMVhX44H8jk4srFnRnwtONjkdlwRmTypn6n0Imz
    yYBzQPKMX81KP10venu2o7S7Ku6MMBvhXk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526119561; bh=GRlQYP124YnDXMsLLSkaBPexCbpSFZ
    Mg7ibMI4v0fZA=; b=LS80+GdtObYFtTAMyL1+AQI+hIL/eSO1jfDyNp0iLtccgP
    vh2ELsSt1FI5BtzQriKp2ApwY98UgW5o0ewI7PwW4IfYXicwi+tOiZQN1OS/jDO9
    IxPJCdZj0LVLu/Mu1PLsEufU52oZqQMI7iRpGseSH6HBxu7rx+8q17IHEgut4JDv
    TgMbvsJCItiaPOESEbxv3G6rx7ZrrU6r50unt2xRychCzIQJyV8sOtv+7jx3J1+f
    X4iLOHy0I5F71EecCpiPfoG7niqwVXm7PK5UvWWyJcweIAoS52OS6WCVwTDkjHc/
    ZxFWWdS0yQkqKo9KR/WOaFS6ZDrBzdwBI/om7SnA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIZfAE5tnqV7mSEbmRT1S3t+WZzYdOwf74LrASUZ5JuWJqGS3yGo6bIE9L4cDk54CN8cXw5ZZR1d2jYMG75VhwBBj5MCOEQiWSF5FL4xTeCKAskdWLNj
    WPmeB3ySzMZBHUl/ZX16fewLHwlCcdcD8YZTimRwZrdb5BsGUG6maGzTShMk4ClJOay5pkSCYLGRawbwCSw5pR24q4ZdKszNKQWuX0SGcO7ZYYXakmY/gzj7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ZjxHVW3EESxXp-Ie-zwA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750772AbeELKF6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 12 May 2018 06:05:58 -0400
Received: from verein.lst.de ([213.95.11.211]:56437 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeELKF5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 12 May 2018 06:05:57 -0400
Date: Sat, 12 May 2018 12:09:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/32] net/tcp: convert to ->poll_mask
Message-ID: <20180512100950.GA5954@lst.de>
References: <20180511110803.10910-1-hch@lst.de> <20180511110803.10910-15-hch@lst.de> <96284b0e-0d4e-a944-4fd5-933d12cf53cb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96284b0e-0d4e-a944-4fd5-933d12cf53cb@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 06:13:11AM -0700, Eric Dumazet wrote:
> > +struct wait_queue_head *tcp_get_poll_head(struct socket *sock, __poll_t events)
> > +{
> > +	sock_poll_busy_loop(sock, events);
> > +	sock_rps_record_flow(sock->sk);
> 
> Why are you adding sock_rps_record_flow() ?

Because I mismerged the removal of it from tcp_poll in
'net: revert "Update RFS target at poll for tcp/udp"'

Thanks for the headsup, this will be removed for the next version.
