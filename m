Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-110966-1520853188-2-15930218611716505826
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520853188; b=NrMEXR8otTUNrbOxRQHbpX0EEmc8l4iqKCX65uYvsg09sF4
    AGEQ/zeyEmar9BsxwLS0x6qNB2U0YSnHvc2JkkNzWnCREmSFi6pmUSN6CgyDHiOy
    4TgV0+aVBqsnkqh3ME0YzmPZhDrWZ0TBmBsnWtTCzVRYMiuQQmA1PCjMci+IsecI
    le8rIDHbhxvxMwX80dpxAAM68F7+Ux4ZlqgI8wXlbepw9lJQMfumek3OTIQPrQ2q
    I7xj4Z4XUUTEhBvjiejBiJqaT4Q7Mv3CfOwtdTJLHpzHjKRfltqL0xIG5Z/ico66
    s9YpBsvd9eA4Gvl+eqIIvPy1xEjpDimJ4WUAnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520853188; bh=2mYO1sPa6J0q0ZJsHnfNmWZJP9
    xc2VDNgLgPazrhWyg=; b=Fw8yr8nfRTvvgghMzUy8iTfA7xnZG1P74PYmLTnaZ9
    9euyTVcp5MpCwrHkEFC/bE4Z0yir+BEh/RyEqJJFUk5g8+pOnKy3h4asKh1bWsHW
    3B/t7VY1PVs+Fpyxfp1s1th2ZKCxyAGBdONmz1X2ebfUoIoTVHrm9BjSCJQWCrCA
    nge3TecsjxTG5ysHHIzBEku91FmcVlu+Hyfz/yp8dU6UdkB2nveN+a4SmJ+K/RbA
    ItUE+TGUSkqjUpH0llyY0z1gmI4NjPHzzdeg+9U7p0r3TyO8aKYd2YxOIy/pSDH1
    trZC035slZDxhKLMCgC+nbV7s+gjhVKhK11HaDI5NPdQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbeCLLNG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 07:13:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:18505 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbeCLLNE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 12 Mar 2018 07:13:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,460,1515484800";
   d="scan'208";a="37423648"
Date: Mon, 12 Mar 2018 13:13:00 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] tpm: fix intermittent failure with self tests
Message-ID: <20180312111300.GB7448@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
 <20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 06:56:10PM +0200, Jarkko Sakkinen wrote:
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> My Nuvoton 6xx in a Dell XPS-13 has been intermittently failing to work
> (necessitating a reboot). The problem seems to be that the TPM gets into a
> state where the partial self-test doesn't return TPM_RC_SUCCESS (meaning
> all tests have run to completion), but instead returns TPM_RC_TESTING
> (meaning some tests are still running in the background).  There are
> various theories that resending the self-test command actually causes the
> tests to restart and thus triggers more TPM_RC_TESTING returns until the
> timeout is exceeded.
> 
> There are several issues here: firstly being we shouldn't slow down the
> boot sequence waiting for the self test to complete once the TPM
> backgrounds them.  It will actually make available all functions that have
> passed and if it gets a failure return TPM_RC_FAILURE to every subsequent
> command.  So the fix is to kick off self tests once and if they return
> TPM_RC_TESTING log that as a backgrounded self test and continue on.  In
> order to prevent other tpm users from seeing any TPM_RC_TESTING returns
> (which it might if they send a command that needs a TPM subsystem which is
> still under test), we loop in tpm_transmit_cmd until either a timeout or we
> don't get a TPM_RC_TESTING return.
> 
> Finally, there have been observations of strange returns from a partial
> test. One Nuvoton is occasionally returning TPM_RC_COMMAND_CODE, so treat
> any unexpected return from a partial self test as an indication we need to
> run a full self test.
> 
> [jarkko.sakkinen@linux.intel.com: cleaned up James' original commit and
>  added a proper Fixes line]
> 
> Fixes: 2482b1bba5122 ("tpm: Trigger only missing TPM 2.0 self tests")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>

Already applied to my master (bleeding edge) branch in order to
facilitate testing/review:

git://git.infradead.org/users/jjs/linux-tpmdd.git

I also rewrote the description of the updatesthat I did to this commit
to be more precise (see the commit msg in my GIT tree). If it turns out
that some klog would make a huge difference I'm willing to consider that
later but lets go with this for now.

I'll also send an updated tpm_buf patch set with this one dropped soon.

/Jarkko
