Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-343544-1525868790-2-7599908208952805472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525868790; b=B2JsbYmmKyoLU4BlxxoFZuCLpBrE+YRGKVqIGpaxd4neS0dDPx
    dkbwK5BPGGrncuUngoBWbzlyFKCU4PKrVbeTs7TnkbQZ3kLcIB5jP/ddVX6BsOjz
    9yyc3wK4PrfodYHBElHY5z3BirN3EsyUYIAFY/aEBslcsP05RRorkg56H0QUNvws
    f6Gxc/aY7nyDpTcOU2b1zwQSVEZXEop39w5DmkBUG4cJMKyux5p6R5ahgZZE0tv6
    IfZ64ckfUTXiPTnah1LyfJO805NDsjUft6WiBEz8Toh5ZZliNEH39C4irXEwYU6j
    BMnpwC2Ye9w8Wkx2KigCFIUo5IZBmjaJBmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525868790; bh=+JEIANQmXpes6bOoYpn1oFl43ldZC1
    uMuNOY/fWo8qc=; b=jLwxZthTB9X7HoM0oy8IaBjJN025YTSroozuBzOGblO2W5
    jFIq8GCmyM/lg6YYzfp08vEI88KvyZQskv3uOLY8tp29wgkmnz/K/a7hEiysyYvL
    9KdmZi29qS54jVasRC/Ex4CmbVF/y6R3n6GuswGP8HRySw/Sj4TG9m1Ghl+O8pmZ
    HRNTj9qvwdBbqoWgWYVtJ33oT3Ln0Bxh1grMvn94mdcL77SrYxOqF+8US1+Ri3wS
    zA0zrWbADTx8YbHVi7YJz4xKq57ycLGam2926YZktKVO1u7pZmQt+2mQyGXYT6XQ
    W3lEPp4/25/CAzTj3C/jH5NPOtOgeClqDhh7RXWw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMiPkjLvdprh9sLaXJIl4amWaHiQ/Q1hkvvD2ixf8CfKTA25vMLxSpNrMM6mj5HWbRJajfxLCkl1FCKTBmtwWrkmEcopIdpIFGrDgA5xTJs72Nqlc66h
    5zaErsEt5KoAQM4xivtC1gpQGSK6wKTmE0yNkbdztoMFlSH2lOGeTnCjPFW9S0R6sF8cfNiaHB+cwxIqd3I2YLAdrL3wppAOVK0qHJ2qcMtyqJl3V/6ix9RT
    p9Du60kDkTbp1sWpG5HHZw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Nh4K_YnUV0rKVLwa62sA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934194AbeEIM01 (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 08:26:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:48634 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932318AbeEIM00 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 May 2018 08:26:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="38580331"
Date: Wed, 9 May 2018 15:26:21 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: 'Jason Gunthorpe' <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "'linux-integrity@vger.kernel.org'" <linux-integrity@vger.kernel.org>,
        "'linux-security-module@vger.kernel.org'"
        <linux-security-module@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: tpm_crb: relinquish locality on error path.
Message-ID: <20180509122621.GB8271@linux.intel.com>
References: <5B8DA87D05A7694D9FA63FD143655C1B94252945@hasmsx108.ger.corp.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B942627FD@hasmsx108.ger.corp.intel.com>
 <20180424160328.GA5119@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94272F33@hasmsx108.ger.corp.intel.com>
 <20180502133246.GA6091@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427B083@hasmsx108.ger.corp.intel.com>
 <20180503063508.GA8702@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427B9A6@hasmsx108.ger.corp.intel.com>
 <20180504081634.GB6373@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427D284@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9427D284@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 05, 2018 at 09:07:21PM +0000, Winkler, Tomas wrote:
> There is already one 'out' label in that function, what would you prefer for this new label name?
> Thanks
> Tomas

Aah, of course. My bad that I did not notice it but please just point
me if I miss something obvious like that :-) I'll apply the patch
today..

/Jarkko
