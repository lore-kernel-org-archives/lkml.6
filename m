Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1361518-1519212391-2-3492975569512262777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519212391; b=Q5+NGmFXyReMXntMi0vvoZaFw7x8pvrXl4mICVpe24tK1Wo
    GxnsBd7njz5oHq1wWWsUsEnp8XCjHsA0Cyv9n3op6xssWiD/tHlzS0cDRkUKarKl
    IGVt5zOqpu+r5tZdrZTUdb25j8AMVeMSmmEDnoiW9/DFCqEEo4qedHISWbUfzOg+
    iF9t+gO88iXucDJFxVI54EFZKWT9RMZnZ6dRDX0na9xJFFx8Zy6o2D+xPipOv6/C
    gooe3asevQyyjDRoG9fs+HqvuWK67hFfhbBsQ+XKTaccbq1DMWfZfL57KqfNB59M
    n6ZeyfsyM62aUyQsONoGCuoQgwbmCdYCBaot0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519212391; bh=MfPXl74vFlzhWVr2JawFRnchIQ
    V4XIBJJ6VC8mpJAoA=; b=OkmF/DcghI7sV017j9oUwXLvHJ+UUtGYfcZWvDxbjz
    flFUjbh2SjMrCKOPxZS8UL71lacQb0o9K01EswuVZPymln5x7zcWvRsLrNE8EX9x
    BB2CZAGgjoanOyXWFYDu/Nq9UZf92k0vtw/v4tcIpZHn1J2pDRGaUGS9+RjqHoqx
    39FFpLt1/bLiIy+8oZjx2TgR8nXz5XyVTCc8m5GnVQAUaw3OOAD4h2DjTlk6NvE4
    pZJnrLDjHSBmqM73JHMxQWmlchTn3z/0A+fVMfpwXMGnGcNaUkyJHTniovrVYCU8
    4cKGmmoQWVHRjc6ghzkVTarQfsf5ZOFnRFDtqWXucCjg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeBUL0a (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 06:26:30 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34238 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbeBUL03 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 06:26:29 -0500
Date: Wed, 21 Feb 2018 12:26:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [stable 4.14 patch] x86: fix KMEMCHECK warning about
 FRAME_POINTER
Message-ID: <20180221112631.GA19900@kroah.com>
References: <20180216152949.1630609-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216152949.1630609-1-arnd@arndb.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 04:29:10PM +0100, Arnd Bergmann wrote:
> When KMEMCHECK is enabled without UNWINDER_FRAME_POINTER, we get a
> Kconfig warning, presumably harmless:
> 
> warning: (FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && KMEMCHECK && LOCKDEP && UNWINDER_FRAME_POINTER) selects FRAME_POINTER which has unmet direct dependencies (DEBUG_KERNEL && (CRIS || M68K || FRV || UML || SUPERH || BLACKFIN || MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS || !UNWINDER_ORC && !UNWINDER_GUESS)
> 
> In newer mainline kernels, the KMEMCHECK option has been removed, so
> this no longer happens. Adding the unwinder as a direct dependency
> for KMEMCHECK works for 4.14-stable as well and documents the
> dependency better.

4.14.y now has that option removed as well, as I just removed all of
kmemcheck as it was "getting in the way" of other patches, so this isn't
needed anymore.

thanks,

greg k-h
