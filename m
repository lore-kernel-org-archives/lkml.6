Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97257C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE8B20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE8B20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeIKCTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:19:02 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:44345 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726121AbeIKCTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:19:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C4E4B180A8854;
        Mon, 10 Sep 2018 21:23:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: farm90_5489fe1a5264e
X-Filterd-Recvd-Size: 2619
Received: from XPS-9350 (unknown [172.56.23.98])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Sep 2018 21:23:00 +0000 (UTC)
Message-ID: <5582ed9b297db98ddb713b240e6059acf26bb8a7.camel@perches.com>
Subject: Re: [PATCH v13 11/13] platform/x86: Intel SGX driver
From:   Joe Perches <joe@perches.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        serge.ayoun@intel.com, shay.katz-zamir@intel.com,
        "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 10 Sep 2018 14:22:58 -0700
In-Reply-To: <20180910183744.GB20225@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
         <20180827185507.17087-12-jarkko.sakkinen@linux.intel.com>
         <CAHp75VcqKunkHYNdd287_F7APHwYr7K9QD2PVCkqBqJWG2_E-g@mail.gmail.com>
         <20180905173355.GE11368@linux.intel.com>
         <CAHp75Vc2SZUfRnBPZ9xJ_B=KJL7yK9hqRZiFOTswn0AzjnLD1A@mail.gmail.com>
         <20180906092100.GA27302@linux.intel.com>
         <CANiq72kpY1y2aPH+GMi8mWZdttfdYJ3wk0cvE_qVD97vdvTJbQ@mail.gmail.com>
         <5137f85388e26ea1ed46b34901b0f18540aee7cb.camel@perches.com>
         <20180910183744.GB20225@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-10 at 21:37 +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 06, 2018 at 05:50:01PM -0700, Joe Perches wrote:
> > On Thu, 2018-09-06 at 19:35 +0200, Miguel Ojeda wrote:
> > > > Which one is right and why the kernel tree is polluted with C99-headers
> > > > when they do not pass checkpatch.pl?
> > 
> > checkpatch ignores c99 headers since 2016.
> 
> For headers I get these warnings:
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #243: FILE: drivers/platform/x86/intel_sgx/sgx.h:1:
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)

Because .h files are supposed to use /* */

