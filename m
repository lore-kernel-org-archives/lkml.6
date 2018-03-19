Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493618-2-10579909291404898674
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493617; b=fqUHe98rz4vrZd5B9FgVrR0w/sflcfGuUGTYSC0cTOwIsCO
    sRiucl/3CGG6zQ3sqmLeLpZlAoiQ206pTTSBZXbsZASocpSh4m4hEHAIquoaa0J0
    ktZJm+Alta8KvsveS39D68+IlT2CAXaaFWHiZLUfn+ht+/hF53SOi35ImA2v4KCA
    sVsM+7W/TYyhpXHKjfy+LpWAbIl+QQOGl4+b1p4MOl2MiDIJ5326HTul2KVmCnMy
    VrTy99XZQy6jcl1BHRXroQa+F3ywMMB2NAzK5SVKIFG6m3AKzrSLoKTbN3aWcUu0
    r/OwanyR/HYTFsDWY7KHJZfWpsaU0dfCjK5bhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521493617; bh=RYHKo5b
    817BugNtALdkZke25lUqwhUpWUbgIh8jMgFM=; b=Uh2yq1hV1uVTHMW/Xriq7oi
    K9V+Fv485cGCDRgzLqox5JOz0c2vFdK/3Ei4T1qaPgzVMFfO9auggRJ6lzKAdoOB
    kjmPfSiZNhB1dXf932udQkvvoMRaXHpQRas97xCIG3R7qdsS0a2vrKA2Lx/c26cr
    wB6wAgoVm0ZX0D2Xz5z6jNbliy7rZSyn0IU3ABHdRYcnUWpQrjpT8iztT95nKddo
    g5kwPZbGctwhO04Jhp6eSGZb066jymtbIVej6Wyv1uKQg+wpU0VZ34cmkBpRxiDA
    JcsWvkGqOgkL5KGX9JBVbHtKckEuc+rKSrv9ihWlAl5edWGTOWphx13fPp02bQg=
    =
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggugfgjohgfshhpjeesthekredttderudenucfhrhhomheplfgrrhhkkhhoucfurghkkhhinhgvnhcuoehjrghrkhhkohdrshgrkhhkihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdduledvrdehhedrhedvrddufeeinecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfedtgedvnecuvehluhhsthgvrhfuihiivgepge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggugfgjohgfshhpjeesthekredttderudenucfhrhhomheplfgrrhhkkhhoucfurghkkhhinhgvnhcuoehjrghrkhhkohdrshgrkhhkihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdduledvrdehhedrhedvrddufeeinecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfedtgedvnecuvehluhhsthgvrhfuihiivgepge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935530AbeCSVGb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:06:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:56673 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935776AbeCSVG2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 17:06:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,332,1517904000";
   d="scan'208";a="35141598"
Date: Mon, 19 Mar 2018 23:06:21 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        '@linux.intel.com
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] tpm: fix intermittent failure with self tests
Message-ID: <20180319210620.GB14364@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
 <20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
 <1521249631.12827.5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521249631.12827.5.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 06:20:31PM -0700, James Bottomley wrote:
> It turns out this bit is wrong ... I just discovered it testing the
> RC_RETRY code.  You can't feed the buf back to tpm_transmit because the
> header has already been changed to give you back the return code.  To
> make this work, you have to save the header and handle area and restore
> it before the command is resent.
> 
> I think the best solution for this hunk of code is to merge it with the
> retry code.

Yeah, right, so it is embarrasingly so :-) I wonder how I missed ths
during the review. Thanks for spotting this one out. Are you saying
that I should merge the patches into a single one? Perhaps you could
send me the merged patch if so?

If you agree, please send only that patch. I'll send v4 of my patch
set after 4.17 pull request.

/Jarkko
