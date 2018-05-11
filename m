Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3307667-1526016305-2-2447530486463516368
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
    1526016304; b=WQv8PCJ4QZzQRyzKu55KmxW/r0cfunSSYYpu4VInw4z7vykWrB
    HMeXqulk9On4q/k09bBwH3vdk0FWPi1mccYrpcog98KjHUzO1EgmOM8OgxUkbXm6
    YeCKG0RF2G+rPFtkpW3ft3ptE16UwQhB+rNLBi2jwCpN9PRQYig1cF95/VSld0/s
    E7olB1UnEj0cqBvxgoQ51b/+eLyWRdcHcnruzcbuU4pbszGureiY4zWF8GjURZCK
    aBwIvCeaSkLWmP3Jws6BwBsGbLj4g+z9YwoKtBHAEojdjMcIIqUGERQcGC7V96xY
    hPSMI+uY3b3UKohtKBkwhVMZCrk5i1jPL2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526016304; bh=9FIgF1mwBEnBDecBnTpSFJSMDGtgs2
    6k+E/7aZUp4yA=; b=Y9cD6GbSmV39rcyPjsO69ok3NfkxUthoaJ5xWLZcHNuh+R
    qPV6qfjg6BvGlYgjqxIlFmoqe0D4+oYGvTKrOb6IDBJ3UeeiyfprYYyRZD5nkNBu
    bW36OrxH1HM27ImGZisaHvB8F2MKkLvGjCPZaLK62KenLglyqtBG69eDRXXkJ9xv
    ygZEtZ1+go0vLMziMMJ2nGmujS7XBscy0EzBDv6JrRO3nikKnsSBUwGxlgeKKltK
    U3FurbBc0f15IuQfnevNxQYafK+uCajyK1zDj3ff9YSMZG412s627Y7Z3qPANq1M
    qZ8AnZEiZcg3f2PfrhHq0pHr/JmD4fb7dpdHS+Pg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ACLmbk8r x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=ACLmbk8r x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKDnMK5xWNtbexICrxAVXHVx/UUf2d6D9UoepN7/hEk0+Wm4rBhUn8sNggO28g9vFmHm3RaefpFTJpFpAiCB28+6+0AeMUI8tI5FQN6XFWzq8G+4atFj
    xYLkyjeoTb+x9124nyg58tlH5b/bisEw5JmOfW79sXRN/S9nL6/nVkclHnhj6RKfjjcctJ6mk9MW+IcAwn0o/ccdWxuCphRXOEcIr+pD4kYI9HIrKAFyqy0j
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=MvuuwTCpAAAA:8 a=VwQbUJbxAAAA:8 a=L4lvR35ZoCf6_yh02WwA:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=pRQRx_yQ9a0A:10
    a=dVHiktpip_riXrfdqayU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeEKFZD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 01:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751406AbeEKFZC (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 11 May 2018 01:25:02 -0400
Date: Fri, 11 May 2018 07:24:25 +0200
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
Subject: Re: [PATCH 0/3] x86/platform/UV: Update Memory Block Size Setting
Message-ID: <20180511052425.GB2902@kroah.com>
References: <20180510231832.035433756@stormcage.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510231832.035433756@stormcage.americas.sgi.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 06:18:32PM -0500, mike.travis@hpe.com wrote:
> 
> Update support for the UV kernel to accommodate Intel BIOS changes in
> NVDIMM alignment, which caused UV BIOS to align the memory boundaries
> on different blocks than the previous UV standard of 2GB.
> 
> -- 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
