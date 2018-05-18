Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3608381-1526632140-2-8536773014814628486
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5,
  T_TVD_MIME_EPI 0.01, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526632139; b=YGvsUeiQKdrm2yhWrsSDl2oQMRm4xgWgaRw5YG4FKQk+0HEgpa
    ZqooAX3SiiAn1kbLP559J+mvPq9dXy+T20BicGiRCaBU2y75AR8Cf7VXIpOm8nTG
    G1PibK6cqdo8g8m9z+hlpcR6nDQgS+acI+rhqoFwSmLN5L4cySEv1inm+Ru3Wv8c
    snvWSPEEkq9dHcWB0/QYjucLs2KOeJ/A4LnWPac1MBAf/DIlMi1PHjh7vt/z1tKt
    6VeY+25pqa39dHZxCRsG2AaSEW720eyF8MaFtUVLbtHl1OCYFouyxkQbfgCpKgrH
    2bVbMxSMcTtI18Wsbzatos3LHfwRRL7FQqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526632139; bh=qus3ZcAzcCuQSd6nNOdb77leAeanTx
    uG2fdfpIo8Pv0=; b=GS0An0dWPIhdMNkcST8w0fGPO//Es/DinuotKTU0S0huAF
    Taa5HsU17q2p9SOY+gHDiHR8soenTr8NOtjLssc4fzKPeYw3VKDAv8BixGt8MfPG
    ZoKCkmZray2xhzjZbKBLThwsHBwnZ+nJalzDyItji0QXDiVjXIcerlilWQ8ehQ+P
    1Vk0TZMfx+x11dvmUETe+u9VzwzzzxuWM4HaExE6gFXge2zwQ9yTBmtCt8Iwqdpr
    YFBG/7PI/scv7sHbL4Ij/CWO2JPfb70DFek7xQR8A6WryL4ySvyhUBPDZVfTKSj4
    vDIFdDeXd1y0Rs4zVuqMbmN2MnY9tUca7EZ2EpyA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=btsyyjqj x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=btsyyjqj x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBwts0wa5UE/5+LDncZDt345+6Wms7uOicjmFZVZ+xVuwvS9T5H0knCUXs1Qi5Gfltc/a4X/aG6YJJO13suau4coFdbkO/KwXnp2ILlzjPc3hmQDcYzL
    sBDkcDoiKqrcJQsl106uWPgoY8OIKgbmVAoUtcwNr1hO9F+Vpzd6zyuNGjns6EC9EK5UemzCyCF8Ysx4okrkHkoKBsNeVHgUfl+lZrc51CowQRNOMgEwHGyQ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=J6-U8lQPe4s6X7Y6CusA:9
    a=QEXdDO2ut3YA:10 a=16-b10-7OApJ_AkrYwMA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeERI2p (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 04:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753827AbeERI2n (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 18 May 2018 04:28:43 -0400
Date: Fri, 18 May 2018 09:28:38 +0100
From: James Hogan <jhogan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] aio: implement io_pgetevents
Message-ID: <20180518082837.GA3264@jamesdev>
References: <20180502211448.18276-1-hch@lst.de>
 <20180502211448.18276-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20180502211448.18276-8-hch@lst.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Given this:

On Wed, May 02, 2018 at 11:14:48PM +0200, Christoph Hellwig wrote:
> +struct __aio_sigset {
> +	sigset_t __user	*sigmask;
> +	size_t		sigsetsize;
> +};

and:

> +asmlinkage long sys_io_pgetevents(aio_context_t ctx_id,
> +				long min_nr,
> +				long nr,
> +				struct io_event __user *events,
> +				struct timespec __user *timeout,
> +				const struct __aio_sigset *sig);

The following paragraph in the commit message would appear to be
misleading since __aio_sigset contains a size:

> Note that unlike many other signal related calls we do not pass a sigmask
> size, as that would get us to 7 arguments, which aren't easily supported
> by the syscall infrastructure.  It seems a lot less painful to just add a
> new syscall variant in the unlikely case we're going to increase the
> sigset size.

Is it possible to correct it before this gets merged?

Thanks
James

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWv6OtAAKCRA1zuSGKxAj
8nzxAQC7f4RLhmqTHYo86l9+4h8Ta0h4zflObA+py2hwfuGW2wD/a+C9QJzr4ybw
XxWoWxP/rKTTnqobNheJw5wH6+HiqgQ=
=7rhk
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
