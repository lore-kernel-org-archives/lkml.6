Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-97583-1526468971-2-17327088449862951787
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526468970; b=K2yJ+DnlRJl264QvHK0x0VTPpOm+CAsTaYXRfDU+KY9syJJ8sD
    UllIG9GeLeUkEfOQaOj2zffj8JAkY1I9gu4uN4UHHvTSg6efhD1O2JzSlGb98TfH
    WGRtipQD7KIXy/pzNqGXGhgnA3IQGyqZEXO1HV5+BaTZd6iBLNbhx5wgO7XWs0Km
    dzDLex+KTEcmkv0iMuVRtG+XNyRtLUE/0+0bR6EPTIXxOOoGoYfuppskf1yFLV7/
    Z2yKN9cKfgesT+O68Fus3ylDqqzOT/xQzloHcQz9vzwf9lyk6LTdZbjg/aPw/4Ok
    Gy5AAlNgOdCQZ2LP5RHaLQYNoIKteZI1QDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526468970; bh=ECpoIE+rDcTJtxE+EauHeVxSWeNl1v
    UuYv1+g2fyoto=; b=fnFVecx78jPBJ1/C8KiwlniVqkFC7MlHPQMkn+jQ8dmUDi
    a55fKXnHzFCpa6mCae4KFju6VLxv63LkqJUf9unWg2oiaGps4x4CmYOiT+IAKWZV
    ZowVwMrlIYQ1JndUIS7+pWdcdEHrusZbkzhQX/JZXiHHdB9oFsnh7cl44T0+HbIC
    PnWIVx6YdQvNLBVy5E7HJLXCtxIyAlyfjyDZM2CbfWG4phLIN8vzAkTb8L9IHXYU
    j3qVLiQbVmnSfu76y7jabbt/P3pMOH8MqgxRbxsVqXLEgqVWxM1z2sETcZKWM1IW
    BE5Ikqdf2BHSWr2925rlK+VQz1V6cBXESYUh3LMA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCf+qckMIYtEQII9FX0+Ekqy/eJ0GoEzoiFVa6rfa/CxJ/ojj7pGqdnqUUo4RTNteUSytlmjzFtpDuDDDj7eU2uy6uttLNJ/O7q85FElKfLyx659277S
    7cTLyzW90Y67A8pCAkSVT+Xgo05QSE687cdPEQGCHkaGNKlnnZwkz62lEcirHwt6wVOqi4D2d4cPXicDLc230quyO/+aDZOP0XDdOeqrreMMQPT2Sxu8EUl0
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=8ZdwkT5fHe8rUTUaryoA:9 a=MKrPHKQXVN8LrCC9:21 a=_VdGwx_KtLd-faVm:21
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeEPLJN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 07:09:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:57194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752479AbeEPLJL (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 16 May 2018 07:09:11 -0400
Date: Wed, 16 May 2018 13:09:09 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mike Travis <mike.travis@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>, jgross@suse.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/3] x86/platform/UV: Update Memory Block Size Setting
Message-ID: <20180516110909.GN12670@dhcp22.suse.cz>
References: <20180510231832.035433756@stormcage.americas.sgi.com>
 <20180511064837.GB23231@dhcp22.suse.cz>
 <6a67bfcd-c80f-b0bd-aeb3-3c8d27d45e88@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a67bfcd-c80f-b0bd-aeb3-3c8d27d45e88@hpe.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 15-05-18 09:08:10, Mike Travis wrote:
[...]
> Hi Michal,
> 
> I will add more info but this patch does not address anything about
> incomplete memblocks.  They have existed in 2GB mem block size form since
> 2009 (v2.6) with the first UV1 system release.  I am not changing any of
> that handling.
> 
> The fixing part was to adapt to what Intel BIOS was using as a different
> boundary to align the PMEM NVDIMMs.  This is explained in both patch 1 and
> patch 2:
> 
> "Add a new function to "adjust" the current fixed UV memory block size of
> 2GB so it can be changed to a different physical boundary.  This is out of
> necessity so UV BIOS can accommodate Intel BIOS changes for NVDIMM's, which
> can align these new PMEM modules at other than 2GB boundaries."
> 
> "Add a call to the new function to "adjust" the current fixed UV memory
> block size of 2GB so it can be changed to a different physical boundary.
> This accommodates changes in the Intel BIOS, and therefore UV BIOS, which
> now can align boundaries different than the previous UV standard of 2GB. It
> also flags any UV Mem boundaries that cause a change in the mem block size
> boundary."
> 
> I can't explain why the Intel BIOS changed the boundaries, it probably has
> something to do with accommodating other areas of the NVDIMMs physical
> address space.  This caused a boundary alignment to be less than 2GB which
> UV had been using.  From one of the UV BIOS engineers I found out that Intel
> really only guarantees a 64MB boundary (which is actually less than the
> current Linux minimum of 128MB.)  Our own UVHUB requirements dictated that
> 2GB was an acceptable boundary up until now.
> 
> So let me know how much more info is needed on how I need to explain _this_
> change.

Thanks for the additional information. It helps to some extend but still
feel rather magic. It doesn't explain why this is UV specific and
require an UV specific fix. Why cannot we fix the generic hotplug code
instead and potentially allow other 128 unaigned memory ranges instead?
-- 
Michal Hocko
SUSE Labs
