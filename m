Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-154247-1527083305-2-4597646274032968610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527083305; b=QDifutYxgSY/Hm0ygwmWwZ1NYNA/s3Jh2ATUVaHsXbGnZKWUsq
    4PKzHeJlX9MMkSYYAcCKnKmTbT86TIfHQhytIJg0pFffSHqCGjcv4dpvqZFCMB4X
    6TOPSPOdwdYhebQyj0TAuFA5nde/wO8/LNqVLVunEfn2YcRQP7fslRYgRKSM/EUB
    nPlzT5IuRLfDP37um66ridt/fsqfvuudVpYYDOFUjzpjVSrEu7767HPXVlA3M/oM
    +RXdv33/VUq1AyRcLSc5kOLdavUukgKDBVCAR/Q6btSxOyfkxO2fziJy+r20d858
    lv6KmqD5Ceo0yGs7CKaTbCuuxiQ1zrJQeE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1527083305; bh=m9MYAwn3sw
    2Jrbp9kHN/5Ia1FaKPuAQTRbXtv2IqfcM=; b=ZOok445qDX21WmE8vB/5eIJOtf
    Gjz7Plb+Up8GqoWXoLn/VA6h9JR5/2O4xfvESjy08LTlmtJXUYeRUj0kP7axEHO/
    9A+wOmKQshSVt5ys1Jes12YkX51gRlqGcVnY0oA4ulae9lou1rE5zMGibM3MhCiE
    B1/ho+DcsEH8JjBb9r3j7MXNH4w8wWz6VxyH/vJxWkiDpk7dXjZ+ISXIAZKqhzu4
    R2HXWHXYab6SOPCUJL7B0ZH7ReMngJjwS7sZAxXzFqk4m18hMNfB6LYZ8FD6caKC
    fk0eW0mQ5HUP9zMfVnE+L7lNZM40AbtWlWvy0qRNUKqd3URCmSgXB1n80IeQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO6YzjNfegYsxX5WjTsLCqrLlogxuqgsYxcYZiWdc6HETJqq4XX6ZrvEKkrCseKr2QAOBtByKAlSiKH66ClhTaOhpc5WxpNvzzlxpTSxY6uVUE8eOeBM
    H0zxYdA5U3YBNIjHj2sxa6hDEf9Ov5Tp+Sk2amhTCuiqvFdo0q5gOsFL5zAC5iMgCmmun02dV7Pr31oRpxqf5IElFXfrANb0RhuXjcqw6KxL2gZhWus8PVD1
    hBDr4ImgzKR6D3UC3sCofg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=mGt09jk8uU4A:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=LUgFCyWd1gE6-lJWd-IA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeEWNsX convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Wed, 23 May 2018 09:48:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:26359 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932976AbeEWNsW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 May 2018 09:48:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="43295906"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Topic: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Index: AQHT7VevIUY7rd7ojEqiu0sBZix5jKQ7TnMAgAAymDCAAaJwAIAAMykw
Date: Wed, 23 May 2018 13:48:17 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D8A1269@hasmsx109.ger.corp.intel.com>
References: <20180516194600.28189-1-tomas.winkler@intel.com>
 <20180522091732.GA5228@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D89D350@hasmsx109.ger.corp.intel.com>
 <20180523131616.GD363@linux.intel.com>
In-Reply-To: <20180523131616.GD363@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjNkMjBlZDAtNmEwNy00NDdkLWI2M2YtZjUwNjcxNmZlZDU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMExnenA0V1VhUDl0WlVcL3VXUTZybVJQT1BOZE5zU2dOazNId1IwZUZwaGNMOUliMGltbzQzZFpjK1lCOFRvWEEifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.12.117.59]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On Tue, May 22, 2018 at 09:27:46AM +0000, Winkler, Tomas wrote:
> > >
> > > On Wed, May 16, 2018 at 10:46:00PM +0300, Tomas Winkler wrote:
> > > > New wrappers are added tpm_cmd_ready() and tpm_go_idle()
> wrappers
> > > > to streamline tpm_try_transmit code. TPM_TRANSMIT_UNLOCKED flag
> is
> > > abused
> > > > to resolve tpm spaces recursive calls to tpm_transmit().
> > >
> > > This looks good and all but I don't think we want to abuse anything
> > > in the driver code, do we?
> >
> > It's not abuse just the flag UNLOCKED is not really named correctly I
> > think this has to be backported so wanted to do less invasive change.
> 
> It should be renamed anyway and possible merge conflicts are not hard to
> sort out in this change. Can you rename it as SPACE?

Not sure, I believe UNLOCKED is still better name than SPACE, I'm not sure this is 
Do you also want to remove TPM_TRANSMIT_RAW? 
clk_enable is handling its own anti recursion counter 'data->clkrun_enabled' 
but it should be all handled under one flag I guess.

> Right, and even without rename this will probably cause merge conflicts at
> least in v4.4 an v4.9 since in-kernel RM landed in v4.12, so not much gain not
> do the rename :-)

I belive we should do minimal change and the big cleanup after that.
Not sure, I believe UNLOCKED is still better name than SPACE even it wasn't the original intention.  
No the SPACE is the issue, but any recursion call into tpm_transmit. A bigger change is needed
and rename to SPACE would be just another intermediat change.

Please reconsider.

Thanks
Tomas 
