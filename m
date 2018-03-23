Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1790898-1521828327-2-7664994561455855776
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521828326; b=Vp6wDN1TGHF7Fcxw1btHjbydvi1uFoNCGL/unoYQ5VnNTFr
    82ErgEttyZtg3FAo73G86BUP7PPQFjR2bAERdpiiKb0iC6z9eYRjAKCZE5Vs7cWX
    qx83SPAH3w1eodXlt5knEFo7OUimPllttC4zAOIK38jFi9dzRVwqeLjLCUpRQXUb
    Vgb8xnczpkoIudbMQtMrwXktSdyXPmwTLhkARf8XV4DKcMUHldlh8oRBOa6UznA+
    LQDTPQHZY6S2KEP9WBzbKgQ+qndHBPmNl320lrrmmopjgUmDpGkfeHf0HX0NmQyY
    WvtR5tgOFbe8IbX52g0XvOBKO0jahXYA789tzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521828326; bh=EnCZOpdqOKD3PQHHNnr0NZQcMw
    /YKvTblrc5MBKeg88=; b=jtViSd10WthdQT07hHpj9zIRNX384g0gqdzxaxrqxh
    VKr4RR02Ry/k0g4EgLP/5Pom5wZvd8UdtiRwpFBcaigRsXp73q38gmZKdVfyszOJ
    V1cY7unp1ILlyfZu3LFXVJFM46XZHzKJW0ZYelPFTG8Y5p6sSJUSHTUigWfDx4HP
    azFxpHLyG9eYeB/Fyhy3bjsJyJzEPwsdp7GBs5lksYLdddgS40Zh5TWgAj7XD/Qq
    22NDfll+QR5qw4H1+QguGHs8o9DxPoT38SfQpVscMeWywCsaASkpX9ucz1ZPA5Ca
    uuYVDil95H0FKnIMEp2cltpNAmEfHGyP4VSChMi2CoJQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1751691AbeCWSFX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 14:05:23 -0400
Received: from verein.lst.de ([213.95.11.211]:53671 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751790AbeCWSFW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 23 Mar 2018 14:05:22 -0400
Date: Fri, 23 Mar 2018 19:05:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/28] aio: implement IOCB_CMD_POLL
Message-ID: <20180323180520.GA7837@lst.de>
References: <20180321074032.14211-1-hch@lst.de> <20180321074032.14211-7-hch@lst.de> <20180322165255.GI30522@ZenIV.linux.org.uk> <20180322172410.GC5542@lst.de> <20180322181653.GJ30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322181653.GJ30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 06:16:53PM +0000, Al Viro wrote:
> On Thu, Mar 22, 2018 at 06:24:10PM +0100, Christoph Hellwig wrote:
> 
> > -static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
> > +static bool aio_complete(struct aio_kiocb *iocb, long res, long res2,
> > +		unsigned complete_flags)
> 
> Looks like all callers are following that with "if returned true,
> fput(something)".  Does it really make any sense to keep that struct
> file * in different fields?

struct kiocb is used not just for aio, but for our normal read/write_iter
APIs, and it is not suitable for poll or fsync.  So I can't really find
a good way to keep it common except for duplicating it in struct kiocb
and strut aio_iocb.  But maybe we could pass a struct file argument
to aio_complete().

> Wait a sec...  What ordering do we want for
> 	* call(s) of ->ki_complete
> 	* call (if any) of ->ki_cancel
> 	* dropping reference to struct file
> and what are the expected call chains for all of those?

fput must be done exactly once from inside ->ki_complete OR ->ki_cancel
in case it did manage to do the actual completion.  Reference to struct
file isn't needed in aio_complete, but if aio_complete decided who
won the race we'll have to put after it (or inside it if we want to make
it common)
