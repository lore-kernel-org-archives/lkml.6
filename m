Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3497624-1521623143-2-1598259626935785265
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521623142; b=aM/LS0nIylAfWr6NFLcAaJaLWhw//ghiWAc3qa32kwShR4x
    kUZ+QAqy9b8Mk89Z9iZPy50sO5DGtuqEUK0+nWzYWABw42KOgvBhQqjxfcTyip2X
    ZOrBOsVs1G88/agT3XTSN8IypZP5MxoM6yLzOqWHgOcj04PuLsrA+2rO737dgdcD
    +FAMJcTUkeo4TrWWd9eh7i7W7GWiWHxoD1MOXtY2lZqJdoNZfirzm6Ygeepdi0aZ
    dKuKziWn5Miim7U3bqQoX7KCN+U8GbKqka+ARYtQiTM0SAPh24qXUCt3NqFM/otG
    exijGD5R8XWhaNPD/yFNvp7oje26TcOTs63PHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623142; bh=G4nzehd936NCTTJbfHregav3Mp
    zzm5vdgk30YP3rMCc=; b=GTfO4is/wPzDWGK3o1gWJGmOH5p+Paia1bNFD/jHFH
    kqlYpf60FYqBLPa51yfyLxHM38/ik0WXXIjA6K4XcfYQVvJKloEymfxmDZESKYZA
    3M7DFT/7SWGY9aQJYabErSRmCuDbD4DD68SOpFncdX+1gZUFGfU8Lo9J/k0SJDfY
    9L8aq0DElI9zvGezDBhWlCP5A5heWBq9pcvqVEO0opAKMdWg68pPDjYWk1gipUYt
    J9IGBdB3uCd4L9itDBwGl6eGnbwnMv5N6oqgJoudR66xHbQ/RjueK5lcLbdjyMXl
    FzIuKDQpuOqdazXjCsUMnIuii7+0P9tKVqNZF5BMjd5g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1751671AbeCUJFk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:05:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbeCUJFj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:05:39 -0400
Date: Wed, 21 Mar 2018 10:05:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/28] fs: unexport poll_schedule_timeout
Message-ID: <20180321090535.GA14085@kroah.com>
References: <20180321074032.14211-1-hch@lst.de>
 <20180321074032.14211-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321074032.14211-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:40:05AM +0100, Christoph Hellwig wrote:
> No users outside of select.c.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
