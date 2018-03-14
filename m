Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-757256-1521007105-2-14306219947051756849
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521007105; b=t/CUD63/mVZWYivyoDza42AiRyoyH61HDp35SBRurEJCC/k
    BDdIfF/ZwR5Zk7WMQesfrfgcgRvgDX9coGaeIsR9C23qvuzhxd6SeyinChBMV8Ws
    V+il4aCG/YCg1yMKS+5TYjLADy1eQqYQLPMZAh9Xybn1TRHIDxHF7OBEJyh1nnnX
    aTPPwa0NZeEbCkCxu9VOTNUV7dD7dhIvvjujw1QEmsx+yCCcWnKfueUQnS6i6v8V
    lELX6frs7T5UxPKPsGWmD3sjr8wGyziXpcBo6wh5Sixpf25a1VP+NlDMhtW06YsO
    x7g8bCDRNamUbgja4WIlm1GWGQzxgPUMP8gANAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521007105; bh=Mat9dykDqNiyh8djVcT1GE5A8G
    e6oUZ04DkL1NkUyLI=; b=meGXqnwf1IV6BC+1Mx6wBBwD0yQyPCDNGtYU7KsHrB
    dloiQTi7BAoUFxWUCheBGQcnQKER/NoDzKYbEbzw2Dr+TVY/6fV24MphmlNYKp7m
    9UlLyF6Ytp+bx/OFaf7tu7qj7bpPIRy+QvVjWt1fY5+E/qmsOdI9lQSpufQL8TZ4
    H+YocT0F7dD77nw2jcp7+6TpjsGjhbjefO0k0TGk83cPPjtlDIqvyOIY4mLjJRWR
    v/V683Qm1YgxdVBqQQvWUx76HJ1MWUOth0TTWvm5c8qlgC6ltRC0fqyWJV6g4m3G
    tZKu/TYbt+x85fLcVJfwJ3MWAWaXxz/ruB86orxZqdlw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dominikbrodowski.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dominikbrodowski.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dominikbrodowski.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dominikbrodowski.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeCNF6W (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 01:58:22 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:45918 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeCNF6V (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Mar 2018 01:58:21 -0400
Date: Wed, 14 Mar 2018 06:48:02 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andy Lutomirski <luto@amacapital.net>,
        "Tautschnig, Michael" <tautschn@amazon.co.uk>
Cc: Jann Horn <jannh@google.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jaswinder Singh <jaswinder@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86: always use SYSCALL_DEFINE*
Message-ID: <20180314054802.GC8354@light.dominikbrodowski.net>
References: <14A5C8D0-3F9D-486F-A20C-55849D70FC80@amazon.com>
 <CAG48ez1RBhBbH8jHwseeZMQwdKciLdjYhoy3O9yDs8WEpMk2TQ@mail.gmail.com>
 <CALCETrXh7BLrv4AsQm-Vpwmd=ttnGWQXV6dAxxi3GVevxnMO7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXh7BLrv4AsQm-Vpwmd=ttnGWQXV6dAxxi3GVevxnMO7w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Michael,

On Tue, Mar 13, 2018 at 11:18:08PM +0000, Andy Lutomirski wrote:
> On Tue, Mar 13, 2018 at 9:16 PM, Jann Horn <jannh@google.com> wrote:
> > On Sat, Mar 10, 2018 at 12:55 PM, Tautschnig, Michael
> > <tautschn@amazon.co.uk> wrote:
> >> All syscall arguments are passed in as types of the same byte size as
> >> unsigned long (width of full registers). Using a smaller type without a
> >> cast may result in losing bits of information. SYSCALL_DEFINE* introduce
> >> adequate type casts. All definitions of syscalls in x86 except for those
> >> patched here have already been using the appropriate SYSCALL_DEFINE*.
> > [...]
> >> diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
> >> index 2f72330..d98b2a3 100644
> >> --- a/arch/x86/kernel/ioport.c
> >> +++ b/arch/x86/kernel/ioport.c
> >> @@ -23,7 +23,8 @@
> >>  /*
> >>   * this changes the io permissions bitmap in the current task.
> >>   */
> >> -asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on)
> >> +SYSCALL_DEFINE3(sys_ioperm, unsigned long, from, unsigned long, num, int,
> >> +               turn_on)
> >
> > Shouldn't this be "SYSCALL_DEFINE3(ioperm, [...]", without the "sys_"?
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-api" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> I think this patch will be obsoleted by a series of patches from Dominik.

... the ioperm change is already in mainline (did an equivalent change a
couple of days ago), but the sigreturn/rt_sigreturn changes still seem
useful. Could you send a fresh patch with just these two changes; and -- if
the x86 maintainers agree -- I will push it with my syscall-related changes?

Thanks,
	Dominik
