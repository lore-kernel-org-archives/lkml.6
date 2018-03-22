Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3361413-1521742621-2-18419165853219672028
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521742621; b=KxQy295g1zmy0VhY8Ab2MmbkP7Vnix59fGlom5SS5Fm/guC
    2EdsYrD+16B93Eihpj5leJ3du0Aiu1IeNHK7OFyLnCsTKZ/GaPNCTYaG/vWf5d5j
    EwwUcSM+vuv6yzPEcxXwpaVSjzQ4PqcTD4ZwQL+F+HKkzFvjvECThoS6nkdAnVJ+
    Zbc/hhrvpxDmPF2w4O8aGe3ISXgvaDzMIYWZXpRxbhpIXwk3FlL4vQnaDtBm4dBF
    EBujblR9Ze1wVbyJze9CxuDh3mMHoqESs4pp/vu3cHyBt5GJOp7IU8NWfnSMw207
    d+K7nkikDLCpX0zmbot2aUd3mdyrSBZ1nXJcCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521742621; bh=OBqmvg2S3vJQu1QtAdss9ALrCE
    6UXIbJnNVDqhvRXPQ=; b=LEjgo0T78mrJq8WpZFpmhRL1MMTMo1Q+WYB5ufqlQe
    f0eT1s7QDH8BnACKt8jqYSo2f89heKhwbzXdxaNNipKXEPWx40E5pEypGEFAB0vc
    lGIh0vjTpl+T5xTp2z5nJ6JWcLrIkvsq4SSHBbbS/6MDEM+mP8O5Zjc2lks5vBZQ
    uNbVVQGg8uoLc1o08qH1T7TqYCNE8MRnpK4ziQAaT14QzPubwFsbzdgzqZQdkriN
    9EWiNMggL5EJjv4s1Y+qSLAry3R3A/EU12hne6ehcUfKMhx65ik7F/wnLA7WZTcI
    /cN4wnkJsStpQQNuAjG19u7EdmAA8hHKRR7IMuVopgOg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1751609AbeCVSQ6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 14:16:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38440 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeCVSQ5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Mar 2018 14:16:57 -0400
Date: Thu, 22 Mar 2018 18:16:53 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/28] aio: implement IOCB_CMD_POLL
Message-ID: <20180322181653.GJ30522@ZenIV.linux.org.uk>
References: <20180321074032.14211-1-hch@lst.de>
 <20180321074032.14211-7-hch@lst.de>
 <20180322165255.GI30522@ZenIV.linux.org.uk>
 <20180322172410.GC5542@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322172410.GC5542@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 06:24:10PM +0100, Christoph Hellwig wrote:

> -static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
> +static bool aio_complete(struct aio_kiocb *iocb, long res, long res2,
> +		unsigned complete_flags)

Looks like all callers are following that with "if returned true,
fput(something)".  Does it really make any sense to keep that struct
file * in different fields?

Wait a sec...  What ordering do we want for
	* call(s) of ->ki_complete
	* call (if any) of ->ki_cancel
	* dropping reference to struct file
and what are the expected call chains for all of those?
