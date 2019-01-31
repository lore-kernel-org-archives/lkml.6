Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10684C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D906F218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfAaSrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:47:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:23417 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbfAaSrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:47:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 10:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="296253840"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.212])
  by orsmga005.jf.intel.com with ESMTP; 31 Jan 2019 10:47:41 -0800
Date:   Thu, 31 Jan 2019 20:47:40 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        tomas.winkler@intel.com
Subject: Re: Getting weird TPM error after rebasing my tree to
 security/next-general
Message-ID: <20190131184739.GA29056@linux.intel.com>
References: <20190122025836.GH25163@ziepe.ca>
 <20190122132910.GA2720@linux.intel.com>
 <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
 <20190123153638.GA8727@linux.intel.com>
 <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com>
 <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com>
 <20190131170603.GA18349@linux.intel.com>
 <CAHk-=wh+TBaphuAbHyNMdGYz=JM6tcuAfAsF_Kgthdev7oj2uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+TBaphuAbHyNMdGYz=JM6tcuAfAsF_Kgthdev7oj2uA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 09:43:42AM -0800, Linus Torvalds wrote:
> On Thu, Jan 31, 2019 at 9:06 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > Found something that *does* fix the issue. If I replace memcpy_*io()
> > calls with regular memcpy(), the driver works and all my tests pass.
> 
> That's not surprising, since that's what we used to do. And it's
> horribly wrong because "memcpy()" can do things that are horribly
> wrong on IO accesses. Like doing them twice, but alternatively also
> "copy one byte at a time" which generally works, but is horrendously
> slow for IO.

Yup, was just a sanity check.

> Can you check *which* memcpy_*io() triggers the issue? Maybe by
> "bisecting" them (first perhaps on a file-by-file basis, and then
> within a file).

Already did that. See my follow-up.

/Jarkko
