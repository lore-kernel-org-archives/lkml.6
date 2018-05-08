Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2680741-1525778732-2-13795625529613556660
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525778731; b=TaAau0FLp3xsf+Eoi8T6aYJ/K9i9XKYQy5aRPTiNM9lmE5tEWe
    +qFDAyF+vcAQacXqy9pB5JqJs4PDyeCJBCXKy0lRJLKRjSLLN2FO+4zWNlgg02MT
    8BzEmFWhzvYhmDP7aeLYW50TrNOYsuK3csk5HDa5zMHZc21H1a6g2oGpAqjjXQnM
    5mvMIBp/bPaAJCjoGTz7/14UFm7jSbY4/uirKGVw9vN4UkA6mRAIm68QpJjtiNXc
    I+LJyxJvOdyQtOMDElvrkQG69ZWZH/m2Zf0+/asjmxs+fvDbOyaA+s2dO/p+Wsua
    KD/UgxtvZkBVmYBDCPob++oyqiU8cLWqm6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525778731; bh=K2xut+jbiipsPj6OG35Z8B1S+gSpVZ
    TrybCTMOgFw+c=; b=bd7am6z2Ns7gemQthEvVuVEHmla8yhaRpSmepmhRC2unhm
    BHLaqjHOMaq1ldgwEVkUE10XPMZAsYZHQbC1ovgWmh5lZSARCO0R6bnWE5IwrKPH
    4qqhrhQXBv2HqrRF02dtdJzRkMLgGH8DXFrZZUXNFc0262VjbSy3xvEWndtiQr5S
    6ejdJ9vHRfqM/A07UGlw/DpD7VY0LTtjstHR/SuUylSM8kW1x2sMHtfa1qrfX8hb
    4/JydJ1NbetinN82alzkYarfuniNiV4ty0Qe6vthL9F4jbmRWe0h6GPaytbJlfzg
    zRvN9IRcL96Pa96QOVEBe0wNo54rJivOmhxpRIBQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hfq6jPCl
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=armlinux.org.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hfq6jPCl
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=armlinux.org.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKWLpyMrqInDg8tEDiRm8tca6gGFF8duorlSISsYepvtUlgo5d5Fx0zKZz3H863GJLNtEmpv+fRz4mYLQQhdToXSxih1ogkb5VvmM8CE7bZK06UhC6w5
    dahwW1vFfW3KM/k7OSAgiQhvzUmAshidIUzcuZHwY7JKXSh0FMYSowJoYfyl9d6sh+mLJJmvcrcMhu7VbEtHZXrRnYTMF5l0nkzeFGIVUpKFSZJ4a3YxNh6N
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=PMT70qdeAAAA:8
    a=KC1ZFGkCY2ORz386mhYA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=ZKzU8r6zoKMcqsNulkmm:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbeEHLZ3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 07:25:29 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51346 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932105AbeEHLZ2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 May 2018 07:25:28 -0400
Date: Tue, 8 May 2018 12:25:03 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>,
        Jon Medhurst <tixy@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Long <dave.long@linaro.org>, stable@vger.kernel.org
Subject: Re: [BUGFIX PATCH v3 0/4] arm: kprobes: Fix to prohibit probing on
 unsafe functions
Message-ID: <20180508112503.GD16141@n2100.armlinux.org.uk>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152540727123.29650.13679359124038587629.stgit@devbox>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 01:14:31PM +0900, Masami Hiramatsu wrote:
> Hi,
> 
> This is the 3rd version of bugfix series for kprobes on arm.
> This series fixes 4 different issues which I found.
> 
>  - Fix to use smp_processor_id() after disabling preemption.
>  - Prohibit probing on optimized_callback() for avoiding
>    recursive probe.
>  - Prohibit kprobes on do_undefinstr() by same reason.
>  - Prohibit kprobes on get_user() by same reason.
> 
> >From v2, I included another 2 bugfixes (1/4 and 2/4)
> which are not merged yet, and added "Cc: stable@vger.kernel.org",
> since there are obvious bugs.

Please submit them to the patch system, thanks.

> 
> Thanks,
> 
> ---
> 
> Masami Hiramatsu (4):
>       arm: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
>       arm: kprobes: Prohibit probing on optimized_callback
>       arm: kprobes: Prohibit kprobes on do_undefinstr
>       arm: kprobes: Prohibit kprobes on get_user functions
> 
> 
>  arch/arm/include/asm/assembler.h  |   10 ++++++++++
>  arch/arm/kernel/traps.c           |    5 ++++-
>  arch/arm/lib/getuser.S            |   10 ++++++++++
>  arch/arm/probes/kprobes/opt-arm.c |    4 +++-
>  4 files changed, 27 insertions(+), 2 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
