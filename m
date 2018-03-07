Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3402803-1520432636-2-79879677080392119
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520432636; b=Zhd97MVxUqJ7mybF8cDq+4Y95I8XXyp9nT0kTPQObwql7ZD
    FUqZzIKZY32zB8t7x2akeSJYlBVphdg7z73gGza+XHncEJsBHaucTECHZ8gU0tpx
    C99EGVK6HF9+qeuD4IBux7Lufgr7O4asHaIuJO3pslAm5qp0oUzw24gNovpHEAKp
    ayr6vz1eWxttzLcCm9Lui5R74dmEgBfaotPNn0RpJvY3BTxOYh5WBQbigRQ9IkHe
    NKSKKfMpeVJtcTOpN9rGm9HrkIwci0Wgo0O6xBhKUMq5s9f4LSK9bOUf6d/V+nPC
    7Yf10C4Y3EUlefr//2eXJSSj0q/c+rxLxQxZfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520432636; bh=b5A3cyw6ps913k/W+NLBPbq5fB
    LU4J8Yzl899Sw535E=; b=lpKu/fzZBVOWTzcMgoKgGnipzDcP4RVH6NK+ufSCCV
    txBR1loaoXY7Iobif5j3bVlY0eLIPx24yE2xJe/DOj7XUVwrZ2rpkl5JkqYws3GG
    ifgJlLy3hoDhpDV5R+hSAnToyHbgiVBLNe5ZeD8jSDwGB0GzsIyrZTPLYDhU8fsv
    ChB1OOnK+jfQP72kKI4hD/P/xC7d3uHxH6FFrEfLRo1yM1poDsh+EOh0D6BRul3f
    HoHwQzLEfB6lYnFUFdktlLBApq/fyGzwiToUBHh0HIrMEouwUQOsJw+0YH+myAOr
    +UZnye59MkSlEvuMjNLHnopqcBhNzSmSzxOALuivElDg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbeCGOXk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 09:23:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeCGOXj (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 09:23:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E099921770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 7 Mar 2018 11:23:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ilya Pronin <ipronin@twitter.com>, Jin Yao <yao.jin@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sangwon Hong <qpakzk@gmail.com>, stable@vger.kernel.org,
        Taeung Song <treeze.taeung@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/9] perf/urgent fixes
Message-ID: <20180307142335.GF3701@kernel.org>
References: <20180306172343.16546-1-acme@kernel.org>
 <20180307082258.ldhidzjvdekhhi5g@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307082258.ldhidzjvdekhhi5g@gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Wed, Mar 07, 2018 at 09:22:58AM +0100, Ingo Molnar escreveu:
> Pulled, thanks a lot Arnaldo!
 
> Note that there's a new, minor conflict between perf/core and perf/urgent - I 
> resolved it and merged perf/urgent into perf/core, please double check my 
> resolution.

Thanks, everything seems well and dandy,

- Arnaldo
