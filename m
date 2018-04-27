Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-422737-1524845500-2-5457323534551760678
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524845500; b=Y5PpP1Ow8QfDcduvgUIsmMFg8wVXmFrDUbe/vN7bEP0Jpa1jPK
    N+a3MPMWgG9XnwOZYDOXciFtlt7a1cxhVU/zT8r/oW94dHluMK2Y+AK5wyckruIK
    uka3UdfM04tSFrt6yjiWZEScR5q55UsOaiYVzsZSPube2Yw/OtzD+AFKZadl/McM
    IF/Cleq9MIHIj2CQrzIKIrLww3FkA++sLUOy3uhtIbphjifadG1gW96HiGTBzpjF
    TAq5eDWcgpUOg075sh+MGVdW9scJYD5t/i6nIkwIY55PjDlhkFlLKhgeferZDbV5
    9H+7Q+mfV+3tolHCwJUSC5PX4nXSZS7ZzhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524845500;
    bh=RDgp2Pnaiz+3sDG686Uy5fW1C6ApY6sedpOxeIoSJ14=; b=RKyG4XQFR5zo
    64RTS4+f8a/Ak+YD1KwAM20hGNoufT23F7wLOhMpLOS4Td2cZ9A8kFUe1NeODJJ3
    p89bt4jua2XFuknd4bvURtLTTZgzV6NyQzSpzywn+dK+sl9luR6u6m1BT5vDecHS
    ygFkNK3q/qnHQTM6b9HQfLsOqy0XnEX7z6FUHXsK1J/4gTlDH5oVThBYtYWOCr1R
    DN4d8E45beuIm1KckBD4ejds1k22H7CBaBseaSLkbrQjD383vfed1wFW0BMw9WTt
    zv63fELq2MIGP1oAAbZDPCKOi8bYgN3wK6j0uNk5uXqBJ8OsMXbfdECqILcoo/jy
    R3ptZLo1Tg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG0dtkNkVolDroJjDoZ3UtAYibl58qbj3i6lXFQgxnqN1l6V9NXziIq6hpj0CfQB15t66c3HuTehPFVwgz2eY5kgifawFDwEmNRAtbusHE7UwWdbLpcX
    m78nzgyqfcAbeND1lBrIy9rkDuHBYvlv4io4NePJ5OxiTbNH6Cf8JSbrookAyVR6LqXMOrd3tAO7j6klUL7oIPGzoSDaD5+1WIbieKeD3m1OT9OF8d8I8k4F
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=nyZn6-Jk8dCT9IqFW2wA:9 a=nAA3hHM4Ih6CNX8y:21
    a=npOlUhOUYlxENQpS:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758682AbeD0QLF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 12:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758462AbeD0QLB (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 12:11:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5242189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 28 Apr 2018 01:10:56 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
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
Message-Id: <20180428011056.931092c5eee7ef42f1effe3d@kernel.org>
In-Reply-To: <20180427071417.lq4swylywht7mdy7@gmail.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
        <152481123945.22588.459569704440210836.stgit@devbox>
        <20180427071417.lq4swylywht7mdy7@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018 09:14:17 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > +	/*
> > +	 * As long as kallsyms shows the address, kprobes blacklist also
> > +	 * show it, Or, it shows null address and symbol.
> > +	 */
> 
> Please _read_ the comments you write!
> 
> In which universe does a capitalized 'Or' make sense, even if we ignore the 
> various other spelling mistakes?

It's a typo. I mean "show it. Or, it shows..." anyway,

> 
> Also, that sentence is unnecessarily complex, just say this:
> 
> > +	/*
> > +	 * If /proc/kallsyms is not showing kernel addresses then we won't show 
> > +      * them here either:
> > +	 */

OK, look good to me.

> 
> But I'm unhappy about the messy typing and the messy code flow:
> 
> +       void *start = (void *)ent->start_addr, *end = (void *)ent->end_addr;
> 
> +       /*
> +        * As long as kallsyms shows the address, kprobes blacklist also
> +        * show it, Or, it shows null address and symbol.
> +        */
> +       if (!kallsyms_show_value())
> +               start = end = NULL;
> +
> +       seq_printf(m, "0x%px-0x%px\t%ps\n", start, end,
> +                  (void *)ent->start_addr);
> 
> 
> All three 'void *' type casts here are due to the bad type choices here:
> 
> struct kprobe_blacklist_entry {
>         struct list_head list;
>         unsigned long start_addr;
>         unsigned long end_addr;
> };
> 
> The natural type of ->start_addr and ->end_addr is 'void *', AFAICS this would 
> remove some other type casts from the kprobes code as well, such as from the 
> arch_deref_entry_point()...

Would you really think we should handle all the address with 'void *'?
IOW, are there any policy that we handle the generic address by 'void *'
or 'unsigned long'?
For example, other address checker like kernel_text_address(),
module_text_address(), and ftrace_location() receive 'unsigned long'.
(only jump_label_text_reserved() using 'void *')

> 
> But the whole code flow introduced by this patch is messy as hell as well.
> Why cannot this do the obvious thing:
> 
> 	if (!kallsyms_show_value())
> 		seq_printf(m, "0x%px-0x%px\t%ps\n", NULL, NULL, ent->start_addr);
> 	else
> 		seq_printf(m, "0x%px-0x%px\t%ps\n", ent->start_addr, ent->end_addr, ent->start_addr);
> 
> ?

Both are OK to me. I just didn't want to repeat the printk format string there.

> 
> This variant eliminates the unnecessary complication over local variables and 
> makes it abundantly clear what gets printed and how.

Agreed, it may shorten the patch.

> ( Note that the kprobe_blacklist_entry type cleanup should still be done, 
>   regardless of code flow choices. )
> 
> Thanks,
> 
> 	Ingo

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
