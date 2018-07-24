Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F25FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9FA20844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UaGf4QcA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VI4OGsGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9FA20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbeGXTBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:01:05 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:40527 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388429AbeGXTBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:01:04 -0400
Received: by mail-yw0-f194.google.com with SMTP id z143-v6so1853422ywa.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nqIIVlvGIN74n2BDuuG44kzyRQJmrxhU4oB0zieuleg=;
        b=UaGf4QcAYQRHhWHRSG/jRNw6Z49i8TjKOrifqY7VH5Ua/0O2g74Rc+lCr23xddSjOp
         JoIetW40F4NWMbLaX284uEB8/pN5mqD0b9KQ0t9Tr7VX0b7HBO1XIlCcPDfVICvS8c3e
         cU+hyeT3AK1ClBmX62y1Ha5LEDhqaqeQ9cuo2pAeJQfD+8NoKuEtpKICQSrUZcFVcZgi
         5aO8dEwcpuXtrbLoqxDEte/dc4gxIqTL1lzT/LXx1uQPbglRcdIlf5J0U2M1weo2/5Oh
         sI9+gGOsOak4IoJTc8bKmrCs55Muk9N7/4erqSU2hfJ2lz6RbGS7auhtdIRD/ro6DNQB
         k1QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nqIIVlvGIN74n2BDuuG44kzyRQJmrxhU4oB0zieuleg=;
        b=VI4OGsGmwLBFArQ6Tif7jghnF9Rg+IU08M4jAq8vUK+/4PlzZCEcTushzfQF/+eVcA
         jmZCWc147atTGr8H4Bqg7VG7r/ebeXvfEJIU84dTOW2qsB/aRH4HK2Zlf7uQHflj3e+p
         o/pyGmfisW/qgBckMiOB8amJ8gKLKHzSD5Z0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nqIIVlvGIN74n2BDuuG44kzyRQJmrxhU4oB0zieuleg=;
        b=fjXylZIfofx1/5XwwK2k9sx95GciYIEXDFOz0BIYfgV+gIqVruAWlYU315Cigy5ULL
         VDKrjiNLhGJIz95MyGCB/vJc2JHAF+iypdpiSJZQ4ct5Dpe4vmK9s/3DmmXGLPLhdkmv
         rbjoabxqrxFQtA5j3A/1KXlruq2KNxiA3f1ph+q9MxuDAHvK7zIFJeYDzc7PHb0/bhp2
         6xcLwyvqhGvGtj5J9rF3nfpN1BPwbFbtcVH4NQ7bZWLGN1kqwS4L4L2eoJdNIO2p2NRj
         4uBM2SASl51HKD6NBPXxsSEFYeyalmFl11aGMf4egnubyu0yNa7J17elP+pKOn+pNN6z
         wyCA==
X-Gm-Message-State: AOUpUlFyANDPeyqnyNf9+zg94HjudnGYJxmgh28FHHBZVRlfBm8g0+OB
        TVsqYQ3YCLOx4jIVC+2+3TvS7ZgtGTYbU7mW79BSOw==
X-Google-Smtp-Source: AAOMgpcP7BqA2KAsyUWWUkwBCEpHQSYU75rekTqp84UAec8hmAclmJ3VGVR7Ish3Y3h5I10hjKfZMZuukuSMu3rpepo=
X-Received: by 2002:a0d:e2cd:: with SMTP id l196-v6mr9369321ywe.38.1532454806967;
 Tue, 24 Jul 2018 10:53:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 10:53:26
 -0700 (PDT)
In-Reply-To: <1bdc706ae86039c4ffcff39698251424d54af116.camel@perches.com>
References: <20180724164936.37477-1-keescook@chromium.org> <20180724164936.37477-19-keescook@chromium.org>
 <1bdc706ae86039c4ffcff39698251424d54af116.camel@perches.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 24 Jul 2018 10:53:26 -0700
X-Google-Sender-Auth: KDelbFXxUcQMj895mSypvwsO7I8
Message-ID: <CAGXu5j+gTpZFkXE8XSNgYPEpBT4+hCb1kzv8s8KrSTerHyKp6w@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] crypto: Remove AHASH_REQUEST_ON_STACK
To:     Joe Perches <joe@perches.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Will Deacon <will.deacon@arm.com>,
        device-mapper development <dm-devel@redhat.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        drbd-dev@lists.linbit.com,
        linux-block <linux-block@vger.kernel.org>, qat-linux@intel.com,
        linux-ppp@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-afs@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:31 AM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2018-07-24 at 09:49 -0700, Kees Cook wrote:
>> All users of AHASH_REQUEST_ON_STACK have been removed from the kernel, so
>> drop it entirely so no VLAs get reintroduced by future users.
>
> checkpatch has a test for that.
> It could now be removed as well.
> ---
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 34e4683de7a3..a3517334d661 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -796,7 +796,7 @@ our $declaration_macros = qr{(?x:
>         (?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
>         (?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
>         (?:$Storage\s+)?${Type}\s+uninitialized_var\s*\(|
> -       (?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(
> +       (?:SKCIPHER_REQUEST|SHASH_DESC)_ON_STACK\s*\(
>  )};

Ah! Cool. I've added this now.

-Kees

-- 
Kees Cook
Pixel Security
