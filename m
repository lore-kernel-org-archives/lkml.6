Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3307667-1526016373-2-5804477043966664410
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526016373; b=BCXpSv1YLYaY9W1QPGdTj7argMyAcdCOFrJjM4hyq3S2vD4Tgx
    Wiseo0ynmepNrovwU0KsxdujNfoJ65BrxjLCKfnYqrZ5FgqcXwo7ndQ+gFmrle5L
    xCbHq+wzB03fM8Ze4yWD+c2dHexkVgJIou0+kmrNv6pwEoDh6HxuEiXLiT6BN/6E
    ElJBWiySbinbf0+DJFOzfxwWYsV7O8r675NPrHkCQ0U4GGUlYy4EvFB/b10yxWHF
    I2H1lzsOYfZlY3IzLEFOLMoRPd381mAxfLxfOqawYMlLK23zGpmsYeveqvV/MvLH
    Fyb7A1HSeosE8CR1XiSrnVJd7eUjqr5JMmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526016373; bh=+mn8FDYDHpdib/dD38zPOrSZgtEwiz
    Cz3SWP17gbJOY=; b=PrPqJlvIB2oz+Rq4ItevsMJ6trvwwmY2lukKDTlhZHjPv+
    TwyxD8bFqtVyHinDoGo7rsTenzmpj2Ov49AebFZUZjPrL6mUmdnBwwp1JZ9S492F
    B9XjyjMGdOcpGibTzBx77+yxgcRP3S1FPZoo+VjjX6KFUw4bOu6qgk329ICF8JSR
    w5vUlQHLDdbu4LrZ0ivrbkaqepJ+DyyXIh6NykpuxUqISulJpQgFe39iuaFS8Wr1
    7S/ft0C013DzbpjeLu5bYavVM1XSxOStxMzeDi9/rQX+d/hhrR1jecB3m/Gs62an
    tA+vJ1O7W9eAo4cV6odEzTms2LreKIbavJvHwd6A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=H7Nf1P8N x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=H7Nf1P8N x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfB0uhlc5HJm02gJUNknTY316R+jcs3m70r1JNAYOCz6rFJVuBWlDtLNyLIn0Eq6WIjD9m6OS+1uG+Qccwaou4pBlXGRvJXRhWiAn+rvievESjOrBB56p
    9wiH5AUdDxvE+uIss9WMka+4ib4tAe+nj+OXAqlSXSuDQ6eFLaGBuKDl8kt2VoiB0PU/FVGYj8OxRbiYcoGarTEq/CHwDYTZ2AOpeuvS0AnmUMaoy9366QJ0
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=MvuuwTCpAAAA:8 a=VwQbUJbxAAAA:8 a=qWSmKI64JADd2OkxZ0IA:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=dVHiktpip_riXrfdqayU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeEKFZe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 01:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752122AbeEKFZc (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 11 May 2018 01:25:32 -0400
Date: Fri, 11 May 2018 07:24:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: mike.travis@hpe.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>, jgross@suse.com,
        dan.j.williams@intel.com, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/platform/UV: Add kernel parameter to set memory
 block size
Message-ID: <20180511052433.GC2902@kroah.com>
References: <20180510231832.035433756@stormcage.americas.sgi.com>
 <20180510231832.439202532@stormcage.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510231832.439202532@stormcage.americas.sgi.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 06:18:35PM -0500, mike.travis@hpe.com wrote:
> Add a kernel parameter that allows setting UV memory block size.  This
> is to provide an adjustment for new forms of PMEM and other DIMM memory
> that might require alignment restrictions other than scanning the global
> address table for the required minimum alignment.  The value set will be
> further adjusted by both the GAM range table scan as well as restrictions
> imposed by set_memory_block_size_order().
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
> ---
>  arch/x86/kernel/apic/x2apic_uv_x.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
