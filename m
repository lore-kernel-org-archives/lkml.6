Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01E9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C924320872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbfAKPxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:53:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:21644 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732686AbfAKPx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:53:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 07:53:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; 
   d="scan'208";a="107525932"
Received: from gandrejc-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.144])
  by orsmga006.jf.intel.com with ESMTP; 11 Jan 2019 07:53:19 -0800
Date:   Fri, 11 Jan 2019 17:53:18 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     joeyli <jlee@suse.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Andy Lutomirski <luto@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Message-ID: <20190111154146.GA12093@linux.intel.com>
References: <20190103143227.9138-1-jlee@suse.com>
 <4499700.LRS4F2YjjC@tauon.chronox.de>
 <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
 <1565399.7ulKdI1fm5@tauon.chronox.de>
 <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
 <1546994671.6077.10.camel@HansenPartnership.com>
 <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
 <1547016579.2789.17.camel@HansenPartnership.com>
 <20190109181155.GI9503@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109181155.GI9503@linux-l9pv.suse>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 02:11:55AM +0800, joeyli wrote:
> > Well, I think here, if we were actually trying to solve the problem of
> > proving the hibernated image were the same one we would need to prove
> > some log of the kernel operation came to a particular value *after* the
> > hibernated image were restored ... it's not really possible to
> > condition key release which must occur before the restore on that
> > outcome, so it strikes me we need more than a simple release bound to
> > PCR values.
> >
> 
> hm... I am studying your information. But I have a question...
> 
> If PCR is not capped and the root be compromised, is it possible that a
> sealed bundle also be compromised? 
> 
> Is it possible that kernel can produce a sealed key with PCR by TPM when
> booting? Then kernel caps a PCR by a constant value before the root is
> available for userland. Then the sealed key can be exposed to userland
> or be attached on hibernate image. Even the root be compromised, the TPM
> trusted key is still secure.

I think this even might be reasonable. Especially when we land James'
encrypted sessions patches at some point.

/Jarkko
