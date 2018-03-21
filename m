Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521624663-2-16166467886248274403
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
    t=1521624663; b=wmTkBRv1yhSl7w05i8pl21xn/FqTMRO7jvxayqVIBK0h9AR
    0pKys/IH61ZCTmwSOIlhYJfTY1HcMOthk/5JJO9d9BsBNkockRPren7LvsWyDtqj
    17cWj/XouIo3nxuBFkLv4od6qvwm0aKymTLHPQsVKsaTSvpeSl1YCQT0uDGnDW7f
    nJ0wkb8ut8waBuPvf4cCcSeGTFdD9/jNHZyxl6qVJ44tqJSc/nFIBVkZtwaffTdi
    eAy2Lu6zxrr9cVmu2LMTv4iJb4tfxqMeYltguYrn+bKIEZIZol7aXeknD/rTCVl8
    T7D5GQaTNZfx02c28JwALVAA+mzkcirCROHy2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521624663; bh=BPzFqFB38UO+UPEsGVW9ejepD+
    EXvubBYDn2KV6mQJc=; b=vA7RQUJqzBNiWJVAgFAVbkV8gd1zEG2VLLFvdyzJH8
    ZGgqKqiOje08zOYQN5EmG/qY5N5zKNf3pRYhpQElWNwrNPCP1ZToXxRSvK39Szhu
    9d7q5c+zWQyxAlV4RCk0gTKVjHkgMz9TXJCf1L3z0hr+v4GBVmxw74+Qpqk6XlDK
    Fu6bqbIbcQOCU12bQxSgv3X88TgN3hgGL5sRaRyJfNWT9PLRG2Fktmi7sYfm156s
    GC+raYrsTwPtYX0/6AkvMQ7gAPREmLDSnznISaslcOcQhMLjci4MVqSoIrcLMG92
    dYOzZiO596bBddtgioC+UMrXJQfTb8WatplbXDaS8Nvg==
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
        id S1751670AbeCUJaw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:30:52 -0400
Received: from verein.lst.de ([213.95.11.211]:41318 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbeCUJav (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 21 Mar 2018 05:30:51 -0400
Date: Wed, 21 Mar 2018 10:30:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] aio: implement IOCB_CMD_FSYNC and IOCB_CMD_FDSYNC
Message-ID: <20180321093049.GA7285@lst.de>
References: <20180321073232.13366-1-hch@lst.de> <20180321073232.13366-10-hch@lst.de> <20180321092713.GR14085@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321092713.GR14085@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 10:27:13AM +0100, Greg KH wrote:
> I hate the "bool" arguments to functions as you always need to go back
> and look them up.  A "wrapper" of "aio_fsync_datasync()" and
> "aio_fsync_nodatasync()" around this maybe?

This is how the fsync API works.  Wrappers really don't help anything,
although flags would certainly be nicer.  Next time I need to touch
->fsync for one reason or another that is high on the todo list.
