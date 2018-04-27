Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3869068-1524813267-2-1134161808108657524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 2.361, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524813266; b=D1suKAUlYunQjYEZ0+obMOIK3qB8yUu/qjl0FVLx91E+Ow6L5a
    1EQ6JwRCVyZ9Qma58UUYG4h3kpeu3bu5qg8LlfFCqFb6KRhnxo6uAvqMr3khPP1s
    1fK8PEb1kz5xeb3iEjMegg5Izr+R1sgMjfcKtovZyQvh2Odwaawc4fRxXtHHpp68
    5jk5A43rNEgd+FsMvfD2VOzzXSDIYeaDrQ8HMd9Oy0UoRgWPnlBP0GhoOBJreDUl
    TOPuzm8tfHQh7xXfOzFZoky75Y0fXiceaukniiPdCvOL193WOrC8SaO6qY9SkIZo
    7SKJ3G8dgf8z6GCnw0pgIoIxs07F1sBvctCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524813266; bh=qL20rP9ROT4z3N80yr/i8rvmNpiQJX
    5mfD4W6yQ8YAw=; b=YC16fAvMnnjqbKPosxPNhJQoYN9hGdgf2AxQ5YnShF35Pf
    EHPzHV3TK33lXAaxZBX2EydoCvem+HN31WSOaJPcW/tjXm0Jkqf8+vvZhmY+Lu1j
    NZ/GG5DIUrTpCuv51Iy1XgktPdHmoRUZ21ZnrQ2e8ngAUaHMSAUn2num4tFiuLt3
    SFqT3ndtQbrY7xwEJQHGhHaH/aSrouSHltjmaszodOnOa933f9t6tSZJv7557TpG
    SQ29zzm6iO3niLwvps95e4rwKfFBZhB5afVIK7zUsmAKTx/M/HjUTzIjBCmm8tZL
    5HvchNQRWcqXaUFYF+AJ2fzWOCmy17Dq8ypIEE7w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MEBf+3yH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=l5CVq5cj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MEBf+3yH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=l5CVq5cj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFCUthbTlsMe/FwyPQdxa0k9rcxD1RQTt6vti+YyOC5BOC6Q/dR1jTZYKpqCEEN/hSER0i5tFjNi/h4OyPOP9DSRNXXXQc/hJVzArvfOs7ThRUOHhYiR
    YkqK+G+LOTRVbN4+6S+Qgqb+z6P0qvR0sTrKPYMfBit/ig4g/cMRS9+2foTfMW3GhG4adUz64CC3KseDFRyEAW7Y9wKjhyAEhgYclCemRqo8FWsAxNB+a0BW
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=0Oziw4W3k3YCkwsz0_cA:9 a=xmtxf4RWCxWXvm-R:21
    a=IdSAIqLucTEx2KCd:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757397AbeD0HOX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 03:14:23 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44669 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753079AbeD0HOW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 03:14:22 -0400
X-Google-Smtp-Source: AB8JxZrtxCqmk6WSFFo/JOiaEfslBGGn7bBzMCJBudrqFZ+DsJnIPU+QlLXRti90nvLkvQiQhGzUdw==
Date: Fri, 27 Apr 2018 09:14:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 2/7] kprobes: Show blacklist addresses as same as
 kallsyms does
Message-ID: <20180427071417.lq4swylywht7mdy7@gmail.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
 <152481123945.22588.459569704440210836.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152481123945.22588.459569704440210836.stgit@devbox>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> +	/*
> +	 * As long as kallsyms shows the address, kprobes blacklist also
> +	 * show it, Or, it shows null address and symbol.
> +	 */

Please _read_ the comments you write!

In which universe does a capitalized 'Or' make sense, even if we ignore the 
various other spelling mistakes?

Also, that sentence is unnecessarily complex, just say this:

> +	/*
> +	 * If /proc/kallsyms is not showing kernel addresses then we won't show 
> +      * them here either:
> +	 */

But I'm unhappy about the messy typing and the messy code flow:

+       void *start = (void *)ent->start_addr, *end = (void *)ent->end_addr;

+       /*
+        * As long as kallsyms shows the address, kprobes blacklist also
+        * show it, Or, it shows null address and symbol.
+        */
+       if (!kallsyms_show_value())
+               start = end = NULL;
+
+       seq_printf(m, "0x%px-0x%px\t%ps\n", start, end,
+                  (void *)ent->start_addr);


All three 'void *' type casts here are due to the bad type choices here:

struct kprobe_blacklist_entry {
        struct list_head list;
        unsigned long start_addr;
        unsigned long end_addr;
};

The natural type of ->start_addr and ->end_addr is 'void *', AFAICS this would 
remove some other type casts from the kprobes code as well, such as from the 
arch_deref_entry_point()...

But the whole code flow introduced by this patch is messy as hell as well.
Why cannot this do the obvious thing:

	if (!kallsyms_show_value())
		seq_printf(m, "0x%px-0x%px\t%ps\n", NULL, NULL, ent->start_addr);
	else
		seq_printf(m, "0x%px-0x%px\t%ps\n", ent->start_addr, ent->end_addr, ent->start_addr);

?

This variant eliminates the unnecessary complication over local variables and 
makes it abundantly clear what gets printed and how.

( Note that the kprobe_blacklist_entry type cleanup should still be done, 
  regardless of code flow choices. )

Thanks,

	Ingo
