Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3307667-1526016367-2-2127708033298003878
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
    1526016366; b=QmPwDLSNxOQHBS8rJtCRGaKq6Js462f8OI2CzatC8kdMlEJZRX
    0cf3x6m5S0zx1PXI8EcfGnpmCyZOT0Xpozc0PT/UavSkCeb82QenoXEWX/hUyVAR
    kKmHg7NTb+OJ6AVNPZFXsUrrxGGcA5aIy+adLQBLMWUVySxd717Qy+6Ngy3Cf7XC
    4g5SnmOF9wfDpTCMU3KqcH30ngn0rgC6J8zmm4pB2VWnRTP0GsSDIPDUf95w2EFp
    zszPafMBRlmTZUZg16a3uagC+wHR88+8adQIQppfxyKGdj3YK0DfkLjoFQ2hXkEs
    7DvDGwjlL3eJbYmN0PDnQqeVqY4naQVs+dUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526016366; bh=HrjNx06hFpQspbk0PBGnR/QczJMurZ
    DyN2rYd5tYrYE=; b=govDSrMc09MPhsi2+DbvyecSvGPW89oDu3waqm5Pe5eOFT
    0Uj9b9RgwC00VeKC97iIETmaHbbfPlLhADHwMBecDo2eZ4gDht6BZutgFR0+IQ13
    txdFnv4KKJs9BbRh13p4o0OMa/0dEVK2FsoSBjU9eT6kXNNxdZFevA91ZgVb/Ozs
    qqVgkAV+Tmoa8gJ6o598JxVBJMmkNaoeJzSZz6akhe4ZabVJk1zddlWG3/W/XFDV
    9ADIdEHZvSoWPvGI1to4/Nqtz9aDOG2kCFd7uWNwmY1qHRhP894P9M+UP2quZP4U
    FjQgF/wKoHWcxwynqXco6CqwgRCJoVDtK07uHb7Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=pqW8EScz x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=pqW8EScz x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCFixhRz4eoUMLoA13tv+zvrpBpWfeC0lp0xCAlr0L44PLkeqJJAEQTZs3mVR+R2pcy6tuu72eevXgIqwtqNc3DqDPb9mKzxcdPEbCOWKkEwTZvuAq9u
    m0A0bP+/Q7Bm1UJDBgrnUR9McMkmqeRVsKfSXscOl8hIMvi56yBIzzCjYKsFsqeOpAfz2a3Gb9umaX1UQzCrhQxyJa0kl1hmXrqODgzPZQh1W8914kNNsJeQ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=MvuuwTCpAAAA:8 a=VwQbUJbxAAAA:8 a=vRdlZZgw6pkx_HoQGjEA:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=dVHiktpip_riXrfdqayU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeEKFZw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 01:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752306AbeEKFZi (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 11 May 2018 01:25:38 -0400
Date: Fri, 11 May 2018 07:24:48 +0200
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
Subject: Re: [PATCH 1/3] x86/platform/UV: Add adjustable set memory block
 size function
Message-ID: <20180511052448.GE2902@kroah.com>
References: <20180510231832.035433756@stormcage.americas.sgi.com>
 <20180510231832.201546912@stormcage.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510231832.201546912@stormcage.americas.sgi.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 06:18:33PM -0500, mike.travis@hpe.com wrote:
> Add a new function to "adjust" the current fixed UV memory block size of
> 2GB so it can be changed to a different physical boundary.  This is out
> of necessity so UV BIOS can accommodate Intel BIOS changes for NVDIMM's,
> which can align these new PMEM modules at other than 2GB boundaries.
> 
> A "set order" type of function was used to insure that the memory block
> size will be a power of two value without requiring a validity check on
> the size value passed in.  64GB was chosen as the upper limit for memory
> block size values to accommodate upcoming 4PB systems which have 6 more
> bits of physical address space (46 becoming 52).
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
> ---
>  arch/x86/mm/init_64.c  |   20 ++++++++++++++++----
>  include/linux/memory.h |    1 +
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
