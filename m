Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526280058-2-14785772190105119142
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526280057; b=j4HHzBnEllE2KKN1uzZ9VW+0mX+CbQkncW5fav6x55Z3kEi6XD
    hVPQ08mvjYOn9PIMeNWaS33Luf1ohDIuJ280yonAHYsRcNsam1Ozx3ribDXBZrtG
    a+juoh83DijB7JB0fFP9s/YSg6gY2rsacsoaNL6O6PNR4lqmHvXWcbH/jiNx7Yxn
    fvI+RhOkk8Uj/aQGYyAzeViGZqQKgLop3Pld+fTbC5wLoIDxqrb/maLAUDFRPCTB
    mKCLhfKCFoinDHwnzCW84svWt9Dql8JGNAhZ81o0LM+0i6Ujhn+mfpu8xm9EpZoW
    qb0biJB8oxWcB2MCftPJzWHCuC9T7vBmQeDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526280057; bh=J9sQGoPOXyUk0UgrxMO1Rx6k714/9N
    IKtj81I6Rn+tA=; b=MA+qPBfAnDDxLRdwboNGwDscfbKmNZtSGa+gqY9fA13vQH
    x+zy2exh7dv7KV77FsSssDtPNbAx+8cDcYpNLomrwUrIGrSeAg3ltVMvEZFfe2ax
    Xr65iXMf1UQR7U13rDjB6FjAseFGTkKb+/P5eKjzvaUtjv0wq7KdZo2EZmmr1PQv
    +dipZ9DRNyoOVfHEMtnDJzI0VRjIsRUoIkUyodvVEtzMIAKcgpU8heXBCq8o2tNG
    r1SioV0EC7kSinBFwwwIVfT4FsZn5SqBJ9l/l5bB8aYh3esz/K/NIVenzdIb2kMK
    OZS2S65p2Qhk60FCO+9GE7M3hdL9K1zglMTg5BKQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=hual7mXK x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=K/jULaR5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=hual7mXK x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=K/jULaR5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA1idjVrNiPpRh3NalIcYhlra9RDR7/XkwSsxbYC4i8quloBEjOUuDzONqaeduX1o4vdclT2txZrlpcgyBkJo1i4oZb/Hegj3KpW8Ml6oD7UdmISqQcv
    z0lcGeEsTU8rH+wP98kMM8JTiEWN2Ib+oXxlHJ1Ow1Soq7GU66LGxzztSAwc/lLLqBWcEQojSnbN4+J9STKoBA4SlCZ9l+R7D0+vub6kJp4QHmtDmwyBJ5nx
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=g3hpZwhNGNTiVa3zX0cA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeENGk4 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 02:40:56 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36637 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeENGkz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 May 2018 02:40:55 -0400
X-Google-Smtp-Source: AB8JxZrQXtQlYCclf2ONCZoxesRvFe2cd0LoYmHhbvpWrZ5ZR12VIJQrks7A7AfP3dIuTgYHw5Lbmg==
Date: Mon, 14 May 2018 08:40:51 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/17] efi/x86: Ignore unrealistically large option roms
Message-ID: <20180514064051.GA16596@gmail.com>
References: <20180504060003.19618-1-ard.biesheuvel@linaro.org>
 <20180504060003.19618-16-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504060003.19618-16-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> +	/*
> +	 * Some firmwares contain EFI function pointers at the place where the
> +	 * romimage and romsize fields are supposed to be. Typically the EFI
> +	 * code is mapped at high addresses, translating to an unrealistically
> +	 * large romsize. The UEFI spec limits the size of option ROMs to 16
> +	 * MiB so we reject any roms over 16 MiB in size to catch this.
> +	 */

JFYI, I fixed this:

 s/Some firmwares contain
  /Some firmware images contain

and:

 s/roms
  /ROMs

(Looks good otherwise, no need to resend.)

Thanks,

	Ingo
