Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0456FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A364220835
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gECJVaOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A364220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933342AbeGIPxE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:53:04 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:36573 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933537AbeGIPxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:53:01 -0400
Received: by mail-it0-f41.google.com with SMTP id j185-v6so26772827ite.1;
        Mon, 09 Jul 2018 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LoXojoxsLt5OU+BdW7QW+kP6cQh7DrAjcqL0X9C4KzA=;
        b=gECJVaOPPgLiLupvi5J0Ax3OpAaBz9GBraOjW6Lf8ozaNrA/3TY2ynYeL39hV0IIVa
         vlHumK52JnhtKAK4Pic25ho+GJYNBMV9lF4KusqY4GChVBhgZjvIUcsvXBRTuoqHUdEB
         3Ss4wbbm74Ts/KrqLjVASA8OvLSPIWR1Bibmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LoXojoxsLt5OU+BdW7QW+kP6cQh7DrAjcqL0X9C4KzA=;
        b=YaYKCNyp5B+mckKtJTV4IEhUmQ8RuU6XVB07I8r9WutQb0OoJ7dmdm0HGQvL5gUitr
         /R+bDb2Kx7sB4LOkg6m+H4eZqVneKeMa86O0CqLb4sKCsDKcMcambh3DP0MNF5T/kcxU
         H0uko41AyJ4MLeG6M4hC7jB+0P7+pX7Z08nW/3gMimJboRu+az6VLloFQkLCxGOV/os0
         RWPzOLhciqEQG9Fw47rX/8uCfAoj/13EGgcvj8ZuKqcUST2fozNHTGyl9Wcng5aruDKf
         H2RjDZ3N8yf7xP9BTaoYi/Mie12uNGT5j0msBVOPgc/XLW2Rg91fAo2ONZNPlpWTriEe
         pcug==
X-Gm-Message-State: APt69E1Nyqttqs6C1kpiVUeVt97Qau9apA5FKZymKlIkaIlMtx9v4FEJ
        8wNBkIUpBvX0wPcmnbDB3qfKIAL+JQukymkbK+tmfA==
X-Google-Smtp-Source: AAOMgpcmbzBxy2u9IPFEhsCJmWyfEK8ODxZkD42HkVFcaum2L/8SF11juknHihgl9GomJ9r8CtdfnNmpK2SamhjkL84=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr17154293jas.72.1531151580751;
 Mon, 09 Jul 2018 08:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20161213132414.GA7898@gondor.apana.org.au> <20170223125141.GA17400@gondor.apana.org.au>
 <20170714141855.GA29426@gondor.apana.org.au> <20170922084401.GA15541@gondor.apana.org.au>
 <20171128230929.GA17783@gondor.apana.org.au> <20171222064931.GA27068@gondor.apana.org.au>
 <20180105073808.GA14405@gondor.apana.org.au> <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au> <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180708162035.zunfeflnq5hgwq6n@gondor.apana.org.au> <CA+55aFwe3HrgMBUhyHC7kAOCvp31S4kpAqDSFQ+BQY6r=WBiiA@mail.gmail.com>
 <CAAUqJDsHzgGZTpYCAxAy=b3P0bq7dGrw6St68SkwjqwHpusN+A@mail.gmail.com>
In-Reply-To: <CAAUqJDsHzgGZTpYCAxAy=b3P0bq7dGrw6St68SkwjqwHpusN+A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Jul 2018 08:52:49 -0700
Message-ID: <CA+55aFwVw8iXwy+U4uQTqKZM+VPcPEe+aqJR4cw-zSBLkvQe8w@mail.gmail.com>
Subject: Re: Crypto Fixes for 4.18
To:     omosnacek+linux-crypto@gmail.com
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Milan Broz <gmazyland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 2:47 AM Ondrej Mosn=C3=A1=C4=8Dek
<omosnacek+linux-crypto@gmail.com> wrote:
>
> In conclusion, the bug remained undiscovered not because of lack of
> testing, but because by sheer luck it was "working" anyway...

Thanks for checking this out. That makes me a lot happier about this
whole thing.

                  Linus
