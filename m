Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1185227-1520621756-5-14572933062838357200
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520621756; b=b6Rd01CcfnQoQbgUvkKVi/vvjA45FPqSLxaqNFFhRjjOh3p
    F4B1MEtAjvoLXLamTIKCr8ClzLo+5jK6/FUcbs+xZWTNEEYPy8YIAKart44/9+e+
    gtl7mAtz7YfXtsfGLPBoUk8Ap9wWXUgsuSjKBt/pXLQN+xYCZDC29GusqFUiXPt5
    tSdH2w/biT2CzSXv1fyU77pMEb5XMTAxYK1L4odb+fygvPYEbAs+/i98zY5KYkSX
    HZBKeoju3SKCnjcMGeTNk6a5/2MYd1KPu4t5q/tN+iv+AkwlIMgqzLOSu0K23ByL
    xQ7n8w6ix1cCb1pyDByOr9MjrFOQt9DA5mIvFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520621756; bh=me7yE+dbY6QB3pa17XgNyN7oJ0Z6rPfXVKI+Kj0pDe4=; b=a
    Bcxu3qbDRIkhQuCkJoN4Ij2OJb1U0uZsFeti76oFxcOAjhTRG/7IueCVR4tfzqwu
    5EARl9mXzKzvoMART2KkAFgGgrJPzetr5rVir9bsr+1Lk1cobAbNGNW2Mj7HUhAb
    YD5IBbD1d6F98cMLSZY7QtXh/vjtvahRr+SeN56SHyIB4bVh36tSBtVp/JV7y21m
    pcfim5RjxzwpG0mqcGT9hc5DejTGeAc8ZInJx+oVbJvNr+rM3xT5hugApnnWw4Yg
    I/TpTNgBncnCXRbfQMQ1oGiQtC0vEBxZzzcPehx5jDpcNnmCR4pmZUg0VqCCxLB8
    2T5V5nGMZAgWr5Augy08Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbeCISzy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 13:55:54 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:55228 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbeCISzx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 13:55:53 -0500
Date: Fri, 09 Mar 2018 13:55:50 -0500 (EST)
Message-Id: <20180309.135550.385837861865623769.davem@davemloft.net>
To: ast@fb.com
Cc: luto@amacapital.net, gregkh@linuxfoundation.org, luto@kernel.org,
        torvalds@linux-foundation.org, keescook@chromium.org,
        ast@kernel.org, tixxdz@gmail.com, viro@zeniv.linux.org.uk,
        daniel@iogearbox.net, mcgrof@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
From: David Miller <davem@davemloft.net>
In-Reply-To: <74e26cc0-9e72-f03b-5396-f3480921f234@fb.com>
References: <20180309181527.GA15803@kroah.com>
        <E622B120-3C3A-4A15-8E1B-6F7649038623@amacapital.net>
        <74e26cc0-9e72-f03b-5396-f3480921f234@fb.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexei Starovoitov <ast@fb.com>
Date: Fri, 9 Mar 2018 10:50:49 -0800

> On 3/9/18 10:23 AM, Andy Lutomirski wrote:
>> It might not be totally crazy to back it by tmpfs.
> 
> interesting. how do you propose to do it?
> Something like:
> - create /umh_module_tempxxx dir
> - mount tmpfs there
> - copy elf into it and exec it?

I think the idea is that it's an internal tmpfs mount that only
the kernel has access too.

And I don't think that even hurts your debuggability concerns.  The
user can just attach using the foo.ko file in the actual filesystem.

