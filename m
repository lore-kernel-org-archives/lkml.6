Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3670513-1526634129-2-14632075283585001848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526634129; b=nvNaurv7h6N4DV+jnD2V06mhzOpo4mr1f+dUzx2aIG6VszkJBG
    +mLsJpSU9WIUyXno09t1dAkc93GT8wCGR9Jp1QIRpgW2OuT/O17PeUTywZ0XdpN+
    osPbBwINtxU5g8mw2QDfQqd99/KYXbKHBzFpzfRM2t+sxThs8TUeDirxM8uoeqGS
    8sFuKxOjYGzL/kIpA82wO6FoaUW+gnUAYQ+q+oXHlSf8WhUnfTMOg/bw5fU6d0e2
    hOmcp12B9h/hcrc76Ubzzmxx1a12q/EZ1w5HnMraKoZUV6hUXFfxqar7+fI1FjeV
    KdELuII6P7nViJ1If0LRL4K2Ap0CvaU8jtBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526634129; bh=g2ox40YIqJP
    qukanI9whuXS6ONooWuOChu6k15hk2rk=; b=GHyWUgtyQ/AsdCP9cR4065gqZ1z
    HXiv6j/N5krU+jEVUJ0zoUrsfFO2400xgNUdQ1AROqB3rGVob5OyCqJ3lm5e7vt+
    TUsFf1q46mauFQY99MIa3/aTDgVihatAwyWbxueiM0oh1UodlzC554EYmg6kklg+
    5A9fEBRSNpbum4N9Ow30ovLi+G+7Bbvp9ufUKcRLL3bg+YPwFtnO2Buu+/Wau6wS
    KCIqlym7sK+6nn9DiapmuqBl+IMgvFNzDvvgu8rxTq75/V351A3KMbBqHwSeIsxF
    +fU+9WAbl1DM8CXbXGn4kr/UiikViUH2H1aHBv4TMndrkEf5DVmxIZ9e1yA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=yG3qvLwR x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=yG3qvLwR x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGNavdNYqzpiIkqso63gt07dibYusdZh0oOfVbMTs6drjnNb8pzEe5vD6ojZNSH3+M+TS008fLH+wHA4UY8YIjLN/jzOFiG7pOhd9P5EdHEfUtYtcy0x
    NoONoH7IzP+n5w8lMSCvHuz9z/EFTCmrFmb17oxTm9zuSn6LAQDN1P1nrUTdGJ8d6kl1bepgh8XT3Gopojk8dVCyUlB8O2ktKP4CHBDarSHdqTNqYGVjq0FQ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=rNm-Oa-FrAlvqsD5aIwA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbeERJCG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 05:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752095AbeERJCA (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 05:02:00 -0400
Date: Fri, 18 May 2018 11:01:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        peterz@infradead.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        linux-snps-arc@lists.infradead.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-xtensa@linux-xtensa.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Stafford Horne <shorne@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
        Vineet Gupta <vgupta@synopsys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Kuo <rkuo@codeaurora.org>, linux-alpha@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH 4.9 27/33] futex: Remove duplicated code and fix
 undefined behaviour
Message-ID: <20180518090141.GA10227@kroah.com>
References: <20180518081535.096308218@linuxfoundation.org>
 <20180518081536.166573281@linuxfoundation.org>
 <e8dc5f94-3b52-dcf0-3b5e-b442bde7d803@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8dc5f94-3b52-dcf0-3b5e-b442bde7d803@suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 10:30:24AM +0200, Jiri Slaby wrote:
> On 05/18/2018, 10:16 AM, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Jiri Slaby <jslaby@suse.cz>
> > 
> > commit 30d6e0a4190d37740e9447e4e4815f06992dd8c3 upstream.
> ...
> > --- a/kernel/futex.c
> > +++ b/kernel/futex.c
> > @@ -1458,6 +1458,45 @@ out:
> >  	return ret;
> >  }
> >  
> > +static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> > +{
> > +	unsigned int op =	  (encoded_op & 0x70000000) >> 28;
> > +	unsigned int cmp =	  (encoded_op & 0x0f000000) >> 24;
> > +	int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
> > +	int cmparg = sign_extend32(encoded_op & 0x00000fff, 12);
> 
> 12 is wrong here – wherever you apply this, you need also a follow-up fix:
> commit d70ef22892ed6c066e51e118b225923c9b74af34
> Author: Jiri Slaby <jslaby@suse.cz>
> Date:   Thu Nov 30 15:35:44 2017 +0100
> 
>     futex: futex_wake_op, fix sign_extend32 sign bits

Thanks for letting me know, I've now queued it up to the needed trees.

greg k-h
