Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2857690-1520804720-2-18016885591651294691
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_24_48 1.34, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520804719; b=r1xAZXHWLB3K5xcTgXti1SiwcCnu73d9O0+A5GIO496SSuE
    7qIVI2E6jJTjA+NOnGF0XrKKu2J+5tk/GyDgG9czthTzxP4kA9vx7NP9MVa21ek2
    r+fzfpiGo72eNeB27gckULhRzU7B3UxWctK6si6exDkJeEto7T3AZ/fak40nGyCX
    Aqjw86iYSv8O/1GP2UfiLTNF17S5DKUDLczo8zNzHUoxRtA5wVH5ygpbuWyIHuYv
    7mGuISV6s+rLYflghNf4eipMExtasJ3KD+NIsWo+Iub/zjZUSAnsM3oMYZbfSQXy
    8JwkYn2cvk2pnB/6OlyhGwhZWpwT9kga+1ipLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520804719; bh=wjij17ALWBc5afJUViPUR52TpT
    3ihRNDsC/Gtx8kEAU=; b=KVJj4wK0sZS1WgPqFJythaQXrV1FRWsl8MrBPC/mDi
    Exfu/CR0TMi282fSa6AXKbLXb/KMxtVvGjkYcS2NJZ8PYCkStb2uYSvQtIXwfrA2
    WEKm1dBAoGCctTYI6sijD89uocP6Y3PWj0xdc+Trc7Y/O3ZfBu5UjTTdiELCvK0n
    /fdB2oW+SgIxtDvSaIIo4SpgCoqQUAeuRxErhKvUz4Aoyg+cka6GRRGEovVDxigk
    CGgygwpK9J37RNnjbluubIT/kxaab5PXa7Nd3/p0inCltcjzmus8jMvID0fcdzpt
    8jLE0Ds+8RuEJaw00Ms3aSxa0+qPZKclbCJpz6NM0Nbg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932324AbeCKVpS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 17:45:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:39109 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932286AbeCKVpR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 11 Mar 2018 17:45:17 -0400
Date: Sat, 10 Mar 2018 15:16:52 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Alexei Starovoitov <ast@fb.com>, Jessica Yu <jeyu@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        David Miller <davem@davemloft.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
Message-ID: <20180310151652.GV4449@wotan.suse.de>
References: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net>
 <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
 <20180309.135724.452219538059491199.davem@davemloft.net>
 <CA+55aFyN8JDh76bm1VinBvrgMH5jNL6RbuFAkrH8vuYU1s9GDQ@mail.gmail.com>
 <CA+55aFx-kDp87_uv9TW5pYD2+nr8c65=ervvwcxhTBJVg7c_pQ@mail.gmail.com>
 <81b7599d-aab7-6cb6-7843-64510c8f6260@fb.com>
 <20180310140843.GP4449@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310140843.GP4449@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 02:08:43PM +0000, Luis R. Rodriguez wrote:
> The alternative to this would be a simple equivalent of try_then_request_module()
> for UMH modules: try_umhm_then_request_umh_module() or whatever. So just as I
> argued earlier over UMH limitations, this is not the end of the world for umh
> modules, and it doesn't mean you can't get *properly* add umh modules upstream,
> it would *just mean* we'd be perpetuating today's (IMHO) horrible and loose
> semantics.

I was about to suggest that perhaps a try_umhm_then_request_umh_module() or
whatever should not be a macro -- but instead an actual routine, and we don't
export say the simple form to avoid non-deterministic uses of it from the
start... but the thing is *it'd have to be a macro* given that the *check* for
the module *has to be loose*, just as try_then_request_module()...

*Ugh* gross.

Another reason for me to want an actual deterministic clean proper solution
from the start.

  Luis
