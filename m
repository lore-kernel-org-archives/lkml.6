Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DAFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0FC2156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0FC2156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeI0Tcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:32:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:45028 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbeI0Tcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:32:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 06:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,310,1534834800"; 
   d="scan'208";a="236458795"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.69])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2018 06:14:19 -0700
Date:   Thu, 27 Sep 2018 16:14:18 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        nhorman@redhat.com, npmccallum@redhat.com,
        "Ayoun, Serge" <serge.ayoun@intel.com>, shay.katz-zamir@intel.com,
        linux-sgx@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 09/19] x86/mm: x86/sgx: Signal SEGV_SGXERR for #PFs
 w/ PF_SGX
Message-ID: <20180927131418.GD5436@linux.intel.com>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
 <20180925130845.9962-10-jarkko.sakkinen@linux.intel.com>
 <CALCETrVAhiwv+g5fzVO3ZSHZgcQKbeeG8r3HUcXO9k7Gi94NdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVAhiwv+g5fzVO3ZSHZgcQKbeeG8r3HUcXO9k7Gi94NdQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 03:53:48PM -0700, Andy Lutomirski wrote:
> Minor nit:
> 
> On Tue, Sep 25, 2018 at 6:12 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> >
> 
> > by (c) as the kernel doesn't really have any other reasonable option,
> > e.g. we could kill the task or panic, but neither is warranted.
> 
> Not killing the task is quite nice, but...
> 
> > +       /*
> > +        * Access is blocked by the Enclave Page Cache Map (EPCM),
> > +        * i.e. the access is allowed by the PTE but not the EPCM.
> > +        * This usually happens when the EPCM is yanked out from
> > +        * under us, e.g. by hardware after a suspend/resume cycle.
> > +        * In any case, there is nothing that can be done by the
> > +        * kernel to resolve the fault (short of killing the task).
> 
> Maybe s/killing the task/sending a signal/?

Agreed. Thanks. 

/Jarkko
