Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-487425-1520346580-2-18274376703032451215
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520346580; b=HnnlX0I3V1+W89y0EuADm/VyIiC6AVdfg8j+8Hg5jaYldia
    YoZWS8RL1B1liucg2XKI/83Dhu9kczTL1jXVFJGmk2g/zDH4MmqfQLGWkL+vtb0S
    fXuvEjkDyb+sb2Xn0419h8PERLOEW/+zxcP/bNCcJWUW+jZD4ppeCqB82b7Mq9u9
    1gzYkSHLXwZMnYe12p88FtGyJqWRLq2coXUk1OPD4r59MkErDmGzXoVPgiN45MbC
    aNJOdW5/g161P9OTuzqhppdNxPMGeGLXW38i1/OeCOxaKOkVjYXVsqD0nnUfZ06c
    mwFID5ClP8S3t6+EBCjSVWr+fup6hLoYLUpqD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520346580; bh=jwnyNXq+goXSzDxJBzuilS1hB/awuj00SoiVqMUqnXQ=; b=W
    DZOVGVFUZ4tLScW5AyV6F5ecTbQZvOWjkGs2E3j0SP4FS29UkfU5EfVoG2lR/eqQ
    pRG2YUomOI4GHeXiGvHNPPFZHgb4QNgSIn/M+WOA9s3Fo6O2KTbbJtlaUFAkNM74
    gmfVL4+9nh5Xkd7wlobvO2i4jBSbpIf26gjcJUPbWclK7S85feANE3LZ9gYyc9wU
    Y321D7Emi3Q/8WMSDiJFana8wZaUYx1XCFf24dwdTnvM5LRhgv+sBGriOvItMV1R
    iu7bKg5dpHLZa/wy6WtdOUuZm2gYynIBj6Fn+8RfhToRfQ+4hDR73wJYPaNC9/sj
    ZA1qZvq5KL7aTk+ahnJYQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753291AbeCFO3i (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 09:29:38 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:54106 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeCFO3i (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 09:29:38 -0500
Message-ID: <1520346571.23626.5.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 163/193] kasan: rework Kconfig settings
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Date: Tue, 06 Mar 2018 14:29:31 +0000
In-Reply-To: <20180223170351.424191376@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
         <20180223170351.424191376@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-23 at 19:26 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> commit e7c52b84fb18f08ce49b6067ae6285aca79084a8 upstream.
[...]
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -197,7 +197,7 @@ config ENABLE_MUST_CHECK
>  config FRAME_WARN
>  	int "Warn for stack frames larger than (needs gcc 4.4)"
>  	range 0 8192
> -	default 0 if KASAN
> +	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>  	default 1024 if !64BIT
>  	default 2048 if 64BIT
>  	help

This doesn't make sense for 4.4.  There is no GCC_PLUGIN_LATENT_ENTROPY
in 4.4, and this line wasn't added by the upstream commit.

I think all that was really needed in the backport was to delete the
'default 0', right?

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
