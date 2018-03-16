Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4146336-1521240914-2-8922875094006344703
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521240913; b=HYohUQ9emCr9QddIopiwfY6aBj2I0awFTU7GFTuWkMxlMV0
    Ja/V5AsmtQ2EvlPN+0vl3Enn7aV3kwNHD6r26Ddzv14qWxWBAP8Mnrd6kda9qX8n
    1iNl9vGKQjY3WU4hHwEFBZ3qgKKlt13BbRrEcpgJNIP8mOaIIq+P/5LOgJw1kL1T
    ARWhQ48IVMUhy6qQKnP0KRcPK6tX3rZ9Eyblxw6dLj/JnSKg9T07zAAOUfes8muN
    tCXfQ7r+S/9aPrvcbtRYU3GEueuJbNoX2493SzkGNy1RT+7BNKw3JLm6VB4DFS0Y
    0TAbM9lEXfH5s5OSTBg7NDJ/Y+IV3mB3JKdwbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version
    :content-transfer-encoding:to:from:in-reply-to:cc:references
    :message-id:subject:date:sender:list-id; s=arctest; t=
    1521240913; bh=O1UcADgeUwTdDXenCsu+bmnfdBKKJcTFmMoEwWgKaF8=; b=G
    wL50D5nuOANq+L22gp/0vcbYR55r9/2Ji1TURw3hp0uKMYwdHLGFwEOQl/tUSgfo
    YfEjIawdadGA/BYVI/MbkcKtA7ls0HZna2J9zyoyRUP68eY1Gr+Ju/ahbVU46lre
    3/WflNho35XEbK/OCTYSB+nVSOxQSz2MP0i8dpgOqC/8VA/nSwpWQIXSMy+YCceX
    e2LcavXdpUiTTDS8gEh1xnpFPj7jxBWG7eDa2yG/EFcCQ/Vy2/JWgVMEN3lt5YT9
    PpaIi8amxqNRbfdt5S6G1NILTSer9plnBt8CUkfcIFc1KqI2tm1sCQmwMwwBkON6
    6u5586v/Uqrds/VyPsDIw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S1751719AbeCPWzL convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 16 Mar 2018 18:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbeCPWzK (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 18:55:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF34F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180216152807.1629038-1-arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180216152807.1629038-1-arnd@arndb.de>
Message-ID: <152124090910.242365.9614136166072414865@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: fix false-positive Wmaybe-uninitialized warning
Date: Fri, 16 Mar 2018 15:55:09 -0700
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Arnd Bergmann (2018-02-16 07:27:47)
> When we build this driver with on x86-32, gcc produces a false-positive warning:
> 
> drivers/clk/renesas/clk-sh73a0.c: In function 'sh73a0_cpg_clocks_init':
> drivers/clk/renesas/clk-sh73a0.c:155:10: error: 'parent_name' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    return clk_register_fixed_factor(NULL, name, parent_name, 0,
> 
> We can work around that warning by adding a fake initialization, I tried
> and failed to come up with any better workaround. This is currently one
> of few remaining warnings for a 4.14.y randconfig build, so it would be
> good to also have it backported at least to that version. Older versions
> have more randconfig warnings, so we might not care.
> 
> I had not noticed this earlier, because one patch in my randconfig test
> tree removes the '-ffreestanding' option on x86-32, and that avoids
> the warning. The -ffreestanding flag was originally global but moved
> into arch/i386 by Andi Kleen in commit 6edfba1b33c7 ("[PATCH] x86_64:
> Don't define string functions to builtin") as a 'temporary workaround'.
> 
> Like many temporary hacks, this turned out to be rather long-lived, from
> all I can tell we still need a simple fix to asm/string_32.h before it
> can be removed, but I'm not sure about how to best do that.
> 
> Cc: stable@vger.kernel.org
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next
