Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3705410-1527677555-2-18145890620452753125
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527677555; b=ZSKVIMA5icpuEkCLuPuE4CCbmTb3mXU0SrFVCLTEYMpB6qui+w
    zhYcLc8QiKC/NKZPQwuXj0+Npp23LwsbzUogjB9fK8osUCITTryL4YPSOw9opHq/
    dzohEpeq5VNr/IoiTupRm9VhHDtUCMAPydhB+5kg7/KoUDSoA+gh4QLOStfkAI7A
    KRl9PhUDjbIehZ7lc3dXuupsgltswXWSCVn2CQLOuKe/kiqF/SWKlZHTnLf4McR2
    TQiXpILwPDDNye4KRKJRdM2piMZNrOs1YFdmQFJJb8kJU4U4lllc/cQLJTkCN1/e
    1ehG3uwmq+TOB72PCFrC4Zvlp50RRAX1QodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1527677555; bh=aQS5xtYog8
    PIP8//8rjyZDSIBOABF11ChN8wdTm47z0=; b=QcnaT92Jj65mBdMvhPU0od74Nj
    FdI+XBJHlBUi6AVMwdQ5eUk++ZbEOb6xIDSJD0jh5GhriTeEiezGKMowrHPJFhFr
    jCxWaa9727R96EpsdAH4fkJuHcsQAAe3YNQUItGQApj6A5YgrxxGmDJjAAW5ZfPx
    yhfuZEpzPx807Bghe6V39c73KDSJJc94y1IxQFpTueVR8zjQmKvCkBYPhp31WcL3
    +QoZqeQYXsBTHk94pBn/IPTo87hLMko++/vROAA7Ic5JbmegTndya5TrfptFVE5e
    AoQCo4lgUty3OoXhfDZMr25JT0tesKpFAsLAXWXmtqgBArNyyQdkwtiE2PZg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBqn6FRqUkEiCqhr9N439DzBlxOCNRFTPTNXOQHi1qTxpsWdvB3AnK1mIEnCrcqFoIOnWOIypw3iLxGFybOgBOkLxdfs9jS5kLHVQmQaSsZmRBC0uiab
    LQBRL+LA7YA6Nanqnb3MWNBGpsia/BVvUvtudY6/ir9uzFTjvhI3I9PSfGhOk1T+viw1XGOTlBJ3wKdov6N6bazLL22w8Jhw/2QuC4/foXB+5FUhVRluOmyq
    w2MMZS8x6UI2qJYcaAKSGw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=SLJXOZ6RIzkA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=HMUOS-HQBpGvpefJB6gA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751119AbeE3Kwd convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Wed, 30 May 2018 06:52:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:1050 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751082AbeE3Kwc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 May 2018 06:52:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,460,1520924400";
   d="scan'208";a="55108451"
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
Thread-Index: AQHT7VevIUY7rd7ojEqiu0sBZix5jKQ7TnMAgAAymDCAAaJwAIAAMykwgAqkdACAADKekA==
Date: Wed, 30 May 2018 10:52:28 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D940DC6@hasmsx108.ger.corp.intel.com>
References: <20180516194600.28189-1-tomas.winkler@intel.com>
 <20180522091732.GA5228@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D89D350@hasmsx109.ger.corp.intel.com>
 <20180523131616.GD363@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D8A1269@hasmsx109.ger.corp.intel.com>
 <20180530105034.GA14905@linux.intel.com>
In-Reply-To: <20180530105034.GA14905@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjAyOTQ1M2MtODQ1Zi00Mzc2LTk2NGItYzVlOGQxOGE2NjZhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibmlNKzBocStwOFd5WWE2Yk1Jb0NnUjgzbngrMTdqSm9EVkxHZ1NkVGR1YXZWRXg5eFB6cjJLdFFCQnJxU254eiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.12.116.154]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> 
> On Wed, May 23, 2018 at 01:48:17PM +0000, Winkler, Tomas wrote:
> >
> > > On Tue, May 22, 2018 at 09:27:46AM +0000, Winkler, Tomas wrote:
> > > > >
> > > > > On Wed, May 16, 2018 at 10:46:00PM +0300, Tomas Winkler wrote:
> > > > > > New wrappers are added tpm_cmd_ready() and tpm_go_idle()
> > > wrappers
> > > > > > to streamline tpm_try_transmit code. TPM_TRANSMIT_UNLOCKED
> > > > > > flag
> > > is
> > > > > abused
> > > > > > to resolve tpm spaces recursive calls to tpm_transmit().
> > > > >
> > > > > This looks good and all but I don't think we want to abuse
> > > > > anything in the driver code, do we?
> > > >
> > > > It's not abuse just the flag UNLOCKED is not really named
> > > > correctly I think this has to be backported so wanted to do less invasive
> change.
> > >
> > > It should be renamed anyway and possible merge conflicts are not
> > > hard to sort out in this change. Can you rename it as SPACE?
> >
> > Not sure, I believe UNLOCKED is still better name than SPACE, I'm not
> > sure this is Do you also want to remove TPM_TRANSMIT_RAW?
> > clk_enable is handling its own anti recursion counter 'data-
> >clkrun_enabled'
> > but it should be all handled under one flag I guess.
> >
> > > Right, and even without rename this will probably cause merge
> > > conflicts at least in v4.4 an v4.9 since in-kernel RM landed in
> > > v4.12, so not much gain not do the rename :-)
> >
> > I belive we should do minimal change and the big cleanup after that.
> > Not sure, I believe UNLOCKED is still better name than SPACE even it wasn't
> the original intention.
> > No the SPACE is the issue, but any recursion call into tpm_transmit. A
> > bigger change is needed and rename to SPACE would be just another
> intermediat change.
> >
> > Please reconsider.
> >
> > Thanks
> > Tomas
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>


Does it mean you're Okay with the patch now?
Thanks
Tomas


