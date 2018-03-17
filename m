Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-191852-1521249638-2-13100024021970958213
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
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
    t=1521249638; b=XxJiur7kp2Rw8RPJXPg28f53G3vjo9Ciai2P78z8CyE2PVD
    yiTX8Jp8rCxZLXsDXri0gPyFiSuVEP3ZjpT2yFFg6cO1tWPj5hElOPMltDGdT6zK
    W9GoQ05zWu0rvO4MOSX0K/PNwMGHQovZyGMmkXzegX4GHfppHMmdQ1W/2OJHtZdr
    dSfz3SpD8CVxttNWLHM81zjNeLMxWaycTyupTOpXN4xvhTBVY9clbhes5O/evoIm
    56NDk6WWsI8oxfp0QARxBzRygcqJ47R/PbtQQCJVqMAWgpE6B0KHkQf2wiXnpfuy
    4nLqhaZhsCNt/d/9xxZuVcpJ+VH57mJH1PV52WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521249638; bh=aGY+uo6V5ZbiNgxqlXLq7MQ7gpkkiJZvcv2CxjnzHcY=; b=c
    +c/b9hHojusk13u3zVa6qUYZ7bIV1h2zpNFrLbtFnnAXZ9wRI37baH7wHjEajPoo
    WBxN9Uz5xDT+wu/beYLm0VRWt7QRjDjHa2ruAmT7KTImFo9oZ9t3y+U0FWSAuoV0
    Fba9j+4xtKSEOrrvZ+IVTOPJnr2lJ6x3JThdlLkA92mwO9pX8iTrns+3tX3+7Zgs
    XxKdQYbhxnABvpi2pzKL4Hp1ZbxCm2U+gTu6BwCVryveIA0aMDqnbCRNllCh+zVA
    IdjCt9M1QFDHLBIHxlyV8z7kEY1sS+8o1iNwyrKqR9klk55SD8JjnikToyJygjPf
    y9UKF/tbXAPWZ37Rxftjg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=cRH+59O8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20151216;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=hansenpartnership.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hansenpartnership.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=cRH+59O8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20151216;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=hansenpartnership.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hansenpartnership.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeCQBUe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 21:20:34 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54234 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751437AbeCQBUd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 21:20:33 -0400
Message-ID: <1521249631.12827.5.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 1/5] tpm: fix intermittent failure with self tests
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Fri, 16 Mar 2018 18:20:31 -0700
In-Reply-To: <20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
         <20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> index 9e80a953d693..1adb976a2e37 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -537,14 +537,26 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip,
> struct tpm_space *space,
>  			 const char *desc)
>  {
>  	const struct tpm_output_header *header = buf;
> +	unsigned int delay_msec = TPM2_DURATION_SHORT;
>  	int err;
>  	ssize_t len;
>  
> -	len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
> -	if (len <  0)
> -		return len;
> +	for (;;) {
> +		len = tpm_transmit(chip, space, (u8 *)buf, bufsiz,
> flags);
> +		if (len <  0)
> +			return len;
> +		err = be32_to_cpu(header->return_code);
> +		if (err != TPM2_RC_TESTING)
> +			break;
> +
> +		delay_msec *= 2;
> +		if (delay_msec > TPM2_DURATION_LONG) {
> +			dev_err(&chip->dev, "the self test is still
> running\n");
> +			break;
> +		}
> +		tpm_msleep(delay_msec);
> +	}

It turns out this bit is wrong ... I just discovered it testing the
RC_RETRY code.  You can't feed the buf back to tpm_transmit because the
header has already been changed to give you back the return code.  To
make this work, you have to save the header and handle area and restore
it before the command is resent.

I think the best solution for this hunk of code is to merge it with the
retry code.

James
