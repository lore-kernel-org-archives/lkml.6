Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3496597-1523891894-2-17823737453018885882
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523891893; b=sP9W79Wt+2uD9dOmX2A29bXuR2NkRBbUq0xHBOJjhqF0ZCxnUr
    ELIMlW/E9AhcN3Bc0TxlHti3jJxxdD/WjsgijZ8rDCgDpnMX9QghsMPd/IpD6qC5
    QCJhtYZvnUo6XwcvAuyZv5YDTHWfG9fNki3whzTnpiJEoVZW1+jvAYSTFcKToRem
    xh175szOpIxbMB4fUn/csmqxeprp/IuX5KgR+tjOfSCsagT5a75Onup/gtfjgnlT
    EpKmuZxZW7YJSzRiK9gZZMKKLV8cRq+Rou8ZCEFbSap5mDQf51Y037+7diodn/8o
    p8yrisvIZYPuXuPEvikI+KFMrvuJFzp6N19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523891893; bh=LfKCYT6N98GK97PmJRpZvCHGszxsfisQT29sIqtEyF
    c=; b=QF1bwTaSWZ5bVjRcSQMQ0GJj2H0yXBGE6varIdFGsldTCerSmGDnE1D3BG
    h2tbCfIpUX3ednTZsmvCVekVbQIpf1kcdoc3bvyvKDKYYoh83MX8isKTlUgnNihq
    ofQyD611xdsYflJjQbcUWuok+sN2TtxTGkz2BTFI4taT2XoDjQ5CASxOBPbjiOj4
    AVmpzNogZMHADj89exn7vrvo5eEgTVgENiKJ8e8h9d8STxmdhqx+VFQMpiw0mMSL
    xV7Gwo7q9ogdHYuhkZ4ff9E2fMtZcVMuoVida64Eb1xkoaVXivrPQhMHs439Q3Ec
    jA0oIgnxGF+zuMzX10tCBPFg+MuQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V0y+FENu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Qc7AIJMJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tG/NxV/N;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V0y+FENu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Qc7AIJMJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tG/NxV/N;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMlxDw6P0NjOSani1JI7rp2q+dtPW17Omg9VxHtk7L4vRLTwUnnT6CsTMddRM1og/0xeNB5XpydkYvSnRG75Wbp8nbFS+kKi9KS1o/2+Uzr0J154cNSl
    7sWJxMM+KqDKxJie3HmPqN+bZw5voArrxPFs6q0SgYh8LuKAJE7oxZCt1xNj/ZMUT3BH0TmXcq4BtUWNAUKVgvIAlOn68OoLgZ7qi4TKs7JSh7FWEi62+rtm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=p4XW2I9AwPl14U6kVe4A:9 a=QEXdDO2ut3YA:10
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbeDPPSM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 11:18:12 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:51008 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDPPSL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 11:18:11 -0400
X-Google-Smtp-Source: AIpwx49FKn3NeVQlS9haUBSQDmqLjI/n8jnOeSvdWLCVo6UmwIDbtJ/UXQUHV8J9/p+KxjDZZv1sLSNSjhxu9z4hAZM=
MIME-Version: 1.0
In-Reply-To: <20180416093058.6edca0bb@gandalf.local.home>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com> <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 08:18:09 -0700
X-Google-Sender-Auth: 76LttqNT6r4Cdr79Y5QWNL4NbzM
Message-ID: <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 6:30 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I wonder if the "AUTOSEL" patches should at least have an "ack-by" from
> someone before they are pulled in. Otherwise there may be some subtle
> issues that can find their way into stable releases.

I don't know about anybody else, but I  get so many of the patch-bot
patches for stable etc that I will *not* reply to normal cases. Only
if there's some issue with a patch will I reply.

I probably do get more than most, but still - requiring active
participation for the steady flow of normal stable patches is almost
pointless.

Just look at the subject line of this thread. The numbers are so big
that you almost need exponential notation for them.

           Linus
