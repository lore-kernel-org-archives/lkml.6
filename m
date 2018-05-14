Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-616870-1526294833-2-4416460439062700432
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526294832; b=C0VNMAi225dwwJWqE+4H8Lvfnh3/7THuEJ3FLCHgpfDMprz9T5
    Ids72tkgxzGqguhUxQqKEZvpW+uB7nW/lJQG+DDTadRUrM45ezbv//yKqW7gbr1g
    5r270+4qbRw31SCwBd4qvOZPphwh8ZziYRJaxZ6SunnKWu/IpUNigthfA86Ycz6o
    YrOa75Ul6i6mt8Iu21ZbIlnqHfJdrNLynlUpSHUmHlzgFAD0Kq7TVBynY+2b/oCg
    WgiJlH8idWs7kchv+AHtamBMqLwuuLFEKYp1TuH2UIqey+q92FTBv6eK+PcBVEwr
    4lypYc7X5/oReRx2zkaZMZWv/9RRxIiKlTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526294832; bh=9Ze5sYpvRvifArSEzrqyTUnRb4qNPA
    PZFeaMPuX2/wM=; b=mmDb/GPYLyATvKR+ySOCfP14Xp2P7SrZWUhN71DdaJpMiX
    yNTDn0h1oUrSMPqrHhkVl2hS7Wj3JSzJa7yB16c7jK+aefrYsxk7LXXLmTD04VPU
    HrezIhhN8QMggOUXUwMW4SQO6f4WA1wTrsq11AXk7AMCXgIg1otggeYB6cFWu2jw
    Nen9BQoDyqcTRAssS5I5/lNEMkKb1lqWh0vgqC2JB+jhJeQhGwZG42d0LYth8+pZ
    UH4wNeYuZMfR+Bdfcwh5V9lVX/Xi9yWxhSCEm3GfpgH2oS1QCp6t6OeSxM0bvocl
    ho95siJhSoT14niMiL330wNsnMlHcXhnqDi9q4Ew==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfGzkaJEqra+Wfq1FQjmrgfOutzve/R+Nevlk0ZPWJ8WFhr7Ufi/LnYLc+WVQ+toPtrGJXMSKqvSksvSYrI7YHmt2LS/dGWlvo0o73+yczmwHUu4Z/FB1
    TuNWNXCAZSOHjLRxM3Dy+ux+6fFy+m7OZD9Q/digxrf3oJb3k9hjdlVqpYjxezpvnrCtGQfHbp9oMq1rEFB3N+zu3Y3FJWwL5BFZzD/c997Yj+BXf6aEpjQ9
    iwNpZU+WhqNxc1Xzy2A9/w==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=HBB4jZ_6XXNUyDNREbEA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeENKrI (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 06:47:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:10266 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752011AbeENKrI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 May 2018 06:47:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="228347569"
Date: Mon, 14 May 2018 13:47:01 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
Subject: Re: [PATCH v3 1/2] tpm: reduce poll sleep time in tpm_transmit()
Message-ID: <20180514104701.GD8228@linux.intel.com>
References: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
 <20180507160733.8817-2-nayna@linux.vnet.ibm.com>
 <20180514104600.GC8228@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514104600.GC8228@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 01:46:00PM +0300, Jarkko Sakkinen wrote:
> On Mon, May 07, 2018 at 12:07:32PM -0400, Nayna Jain wrote:
> > tpm_try_transmit currently checks TPM status every 5 msecs between
> > send and recv. It does so in a loop for the maximum timeout as defined
> > in the TPM Interface Specification. However, the TPM may return before
> > 5 msecs. Thus the polling interval for each iteration can be reduced,
> > which improves overall performance. This patch changes the polling sleep
> > time from 5 msecs to 1 msec.
> > 
> > Additionally, this patch renames TPM_POLL_SLEEP to TPM_TIMEOUT_POLL and
> > moves it to tpm.h as an enum value.
> > 
> > After this change, performance on a system[1] with a TPM 1.2 with an 8 byte
> > burstcount for 1000 extends improved from ~14 sec to ~10.7 sec.
> > 
> > [1] All tests are performed on an x86 based, locked down, single purpose
> > closed system. It has Infineon TPM 1.2 using LPC Bus.
> > 
> > Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
>  
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
