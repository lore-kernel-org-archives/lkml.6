Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2574145-1528209544-2-114482130392235595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528209544; b=UqM7tVwbHVoB2SMg6KoMvN69xrZ5q2FhjgZij7zfBkifrAdhhH
    H2QXTWj+LzAT5domMbckNFZ11t3Ggbhzte8dy0lpVmlg5t85HqXxiOfBTZBmvBLu
    CgSPc5ofpkja+FgHUAte/FwAAtvjTrT8YXwMI5wRHP/WKmAIRZrNet+iUqA6VQ4p
    DfYMcQ/wdKVq4uXfC7sAZeUIrPDFU6QJeRH4+2dm1IHVwqx5s4Vfand/JX1mxWgT
    cGi8bwBbV4X2HKw7W8gsYdkBi8iiF+pWs8V9+oWclHx/ns6nOmOwGPXOfIPjVtIn
    wfU2qsi3TioZLwYJqwPgg3rLIq1Wj9MnLvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1528209544; bh=AVB+w8NGBJVTbi850fdm/WxUn50Osv
    kqSNNRTd8xjr8=; b=WnJYqwXAJpNGuh6xtibJc8s/0Va2Cf3Pkiznjr/c2s45hu
    NUytZWS6eJkIP8h+gs6/ylk5g/UoTDoQmlzFz/smgvFoZ5fj7hNkWy+Z/cOhzcvp
    zLfNt2O8iIwxpC5RNxsbYIrwX4ijnN1shj++crgeUhnJvJ2BUYxn5g4g+47N+49X
    B3Okxb3SrYkRT/U0NNbcneGphBWIO1pzejTysgjy22MjEZE8ejE0RXJ+8EKBUEqA
    jYC4G0rBGlwA0xqnzJyN7HyxZbSH9BgUkE6Vlsui2kp3yeUWtd1BwENxinHITjBi
    OMAB63uoXk624Eg4/65/H7a5bsudsw5/1V77UMIQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGl/DjwrSl4zxu1Uziuc1+28u35o1fDgressd6Am8WNNq0/yJyckyrI785qcN8loN+RSmOXi9tTbNeBSNJutGSNu182Eivg9fblBquB86zB72Nfn1gQu
    QIlpNeeqF5moSDfz5J+XBdwDlNvW1ql4HoP25dTfdzBJUuJ5TLIJAMIejOS8jd+H3sGFoCvaDfJHoziGdneTNV3Q6k3TTxl78M6KlXe6n2jTFZleXrsa8kwi
    HKXxp6VhHk1DsKJJ7t8QpA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=5ZDGai7jz5g9HE0-3WEA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeFEOjB (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 10:39:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:32625 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751959AbeFEOjA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Jun 2018 10:39:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,479,1520924400";
   d="scan'208";a="45433820"
Date: Tue, 5 Jun 2018 17:38:57 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd 4.17 fixes
Message-ID: <20180605143857.GA6199@linux.intel.com>
References: <20180602130001.GA5196@linux.intel.com>
 <alpine.LRH.2.21.1806050201050.30339@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1806050201050.30339@namei.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Jun 05, 2018 at 02:01:29AM +1000, James Morris wrote:
> On Sat, 2 Jun 2018, Jarkko Sakkinen wrote:
> 
> > The following changes since commit 424eaf910c329ab06ad03a527ef45dcf6a328f00:
> > 
> >   tpm: reduce polling time to usecs for even finer granularity (2018-05-18 10:00:01 +0300)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180602
> > 
> > for you to fetch changes up to 3ab2011ea368ec3433ad49e1b9e1c7b70d2e65df:
> > 
> >   tpm: fix race condition in tpm_common_write() (2018-05-30 20:11:31 +0300)
> 
> 4.17 was just released, I'll fold these into the 4.18 merge.

OK, thank you.

/Jarkko
