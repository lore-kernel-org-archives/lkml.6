Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-923215-1520107939-2-5153228776378211222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520107938; b=bihK22HW6CuvFkJK4WVM0JYqS6b4zMGh3vhb0FMyJumchwJ
    s+lCQciBMJOXzjsCmjE/C8mLFldTy926gcVwRznGFzAqh387A0Nlt7ZOaG96SSN6
    tq4kvLE5eJF2vD9VLyWGSWOYCY9h9SGCr7HMvaaov+MKJYtHcZX3xNgJvWgMiLnH
    WqcAcMnFh/JlktnLYzmhMEGSJiSxodbSscvYJUPMb2cllOXOkrykXhXs67JS8PSw
    t0bBfBcwrYrk1tKqH7bKvuJGq/dZBeLecFNiYAkYgkOdr6hfNRMGOH5jmfCZIdQW
    ppW5Zx2XMISSu5UhZJcWAQVudi0PKAf5ckffIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520107938; bh=2snNDMdLGzpmnBFlyAjUN0WYSVZY3BV/m/4JfbugPtM=; b=l
    CeTRlsE7eKk+9DgY5HsuhU0Y4dcumfpAV6ekMfMuWxMjMWb72sBkLC1oRNtzL30k
    GKxVW68gtPz75nLLHWaxM9GOHyfdnZKTfEiYsMENpFo9vQNeWafG+0bs/ndJrZ/j
    iFeWneBPcP2278jASmqlyhQvwVpZQtzSR4kz/3ngPcF7I06lpgsRcwylX1ck1pxS
    o3xpGDZD4OgF7Ic9jBvpHKpt7l5q3BiXanNfg3IHafjMy5aPw8ZDZuDLGj6Xj6/m
    IUqvi/3uIzTaMaRVYgJgdfJf2VXqjrd/2DdmOwDXz1jyp8ga6kxeRnhtwZxu6VJD
    /sqqpo3SEpsxDSey1hnJA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=fYk0QCM5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20151216;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=hansenpartnership.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hansenpartnership.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=fYk0QCM5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20151216;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=hansenpartnership.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hansenpartnership.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932098AbeCCUME (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 15:12:04 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49746 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752330AbeCCUMC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Mar 2018 15:12:02 -0500
Message-ID: <1520107919.3105.9.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/5] tpm: Trigger only missing TPM 2.0 self tests
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Sat, 03 Mar 2018 12:11:59 -0800
In-Reply-To: <20180228195819.22231-2-jarkko.sakkinen@linux.intel.com>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
         <20180228195819.22231-2-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-28 at 21:58 +0200, Jarkko Sakkinen wrote:
> From: Alexander Steffen <Alexander.Steffen@infineon.com>
> 
> My Nuvoton 6xx in a Dell XPS-13 has been intermittently failing to
> work (necessitating a reboot). The problem seems to be that the TPM
> gets into a state where the partial self-test doesn't return
> TPM_RC_SUCCESS (meaning all tests have run to completion), but
> instead returns TPM_RC_TESTING (meaning some tests are still running
> in the background).  There are various theories that resending the
> self-test command actually causes the tests to restart and thus
> triggers more TPM_RC_TESTING returns until the timeout is exceeded.
> 
> There are several issues here: firstly being we shouldn't slow down
> the boot sequence waiting for the self test to complete once the TPM
> backgrounds them.  It will actually make available all functions that
> have passed and if it gets a failure return TPM_RC_FAILURE to every
> subsequent command.  So the fix is to kick off self tests once and if
> they return TPM_RC_TESTING log that as a backgrounded self test

I still think removing all logging traces is a mistake for something
that can consume a significant amount of time in the boot sequence.
 It's going to cause lost of people doing boot timings to waste lots of
effort.

However, removing the log messages makes the above statement a lie, so
one of the two needs fixing.

[...]
> @@ -852,27 +837,24 @@ static const struct tpm_input_header
> tpm2_selftest_header = {
>   */
>  static int tpm2_do_selftest(struct tpm_chip *chip)
>  {
> +	struct tpm_buf buf;
> +	int full;
>  	int rc;
> -	unsigned int delay_msec = 10;
> -	long duration;
> -	struct tpm2_cmd cmd;
>  
> -	duration = jiffies_to_msecs(
> -		tpm2_calc_ordinal_duration(chip,
> TPM2_CC_SELF_TEST));
> -
> -	while (1) {
> -		cmd.header.in = tpm2_selftest_header;
> -		cmd.params.selftest_in.full_test = 0;
> -
> -		rc = tpm_transmit_cmd(chip, NULL, &cmd,
> TPM2_SELF_TEST_IN_SIZE,
> -				      0, 0, "continue selftest");
> +	for (full = 0; full < 2; full++) {
> +		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS,
> TPM2_CC_SELF_TEST);
> +		if (rc)
> +			return rc;
>  
> -		if (rc != TPM2_RC_TESTING || delay_msec >= duration)
> -			break;
> +		tpm_buf_append_u8(&buf, full);
> +		rc = tpm_transmit_cmd(chip, NULL, buf.data,
> PAGE_SIZE, 0, 0,
> +				      "attempting the self test\n");

There shouldn't be a \n in the string: the failure message already
appends one.

James
