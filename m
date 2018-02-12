Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1553285-1518447449-2-9572360923028988250
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518447449; b=FGVjVi40gorhHbcv8fSyGkJc6uXakpu+joEooz/sr9solZ0
    vuB5NNvyJduWbLNiQyo9n6xO11viwCgvlMWkd4sxD5a5RvQsNAjlUpDECjXkbG9V
    JeOnSLo7WGR2HXTvN/7n220BrgbIKWeyhgf+ial69lgMxNLUkPktJ1LT/ddmqIkC
    5NwiAu5J3TaEPN9OfUZvtT8BFq8VmCZ5dgzJA0yZJYliMEc57SkzF8aPF0LO3FBs
    Kc7eh+oy0i9aDiqGbGBwkKa6QhQgMVgvgZXVgNp/rFsYCoxOkVAFlhnMgKBbJuGJ
    N0lHln2mEo1p3zjcn3sXJJI9w3y7vM3NlZKShdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518447449; bh=OgsR/uwkfxIWtn9vpXaEzqpOZk
    Loidd2ZgwdJENmMNU=; b=AzbrbR15qLYgAU0v2ChyHgjBD5c3n+2dJQih7cQPdd
    o8p64QMBeU4/uXLwkQH+U+vrapF+AO5F/vUABGcw6OcYtY5xK/GFRkFf5Q7b4fNX
    1BMbNGceHOSadvCa/uCp5iilt7aqP7r4/YftYOV0YnZ70MjcF/m8iANMdye/DRX0
    mFtOHyVjowVGMUqOl0KNTjKD+B+/kXGT2tpn/rYo6i5pb/xLPlrfzc7chg5m6/P2
    x4aVKku/9f/zJuAtqPO3iyuQ0tJAOiHS2uiwjo5UcKw3PN1pbBOwaTYAv3Qlp68S
    2+p4cvBDJ26P97bxntCZY5A8ssy2nuIznLN6irJ+xgQw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Wi9lzGyE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Wi9lzGyE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBLO5N (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 09:57:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46744 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeBLO5M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Feb 2018 09:57:12 -0500
Date: Mon, 12 Feb 2018 15:56:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Timur Tabi <timur@codeaurora.org>, graeme.gregory@linaro.org,
        mark.salter@redhat.com
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
Message-ID: <20180212145652.GM25181@hirez.programming.kicks-ass.net>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
 <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 08:47:57AM -0500, Prarit Bhargava wrote:
> 
> 
> On 02/12/2018 08:34 AM, Peter Zijlstra wrote:
> > On Thu, Jan 18, 2018 at 10:09:51AM -0500, Prarit Bhargava wrote:
> >>  config ACPI_SPCR_TABLE
> >> +	bool "ACPI Serial Port Console Redirection Support"
> >> +	default y if X86
> >> +	help
> >> +	  Enable support for Serial Port Console Redirection (SPCR) Table.
> >> +	  This table provides information about the configuration of the
> >> +	  earlycon console.
> > 
> > I just got asked this by oldconfig, which left me rather puzzled, WTF
> > does this do?
> 
> Odd -- I thought I had taken care of that :(  My apologies Peter.
> 
> ACPI SPCR is used by a vendor to define the serial console for a system.  If
> SPCR exists a user can add kernel parameter "earlycon" (no extra kernel
> parameters) and the console will work out-of-the-box.
> 
> The serial console configuration varies from vendor to vendor.  This takes the
> guess-work out of defining a serial console.

But when I specify "earlyprintk=serial,ttyS0,115200" this SPCR crud will
not interfere?
