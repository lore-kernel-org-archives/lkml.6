Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB99ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912E220673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV8itchp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912E220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbeGSPeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:34:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35474 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbeGSPeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:34:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so7940044ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ueWuQoY3KPMGs6cLm8DT7HgM284Z4wn+l2ltjKznOTE=;
        b=WV8itchpHy416KF6nOY+2c8e1T648T+sypCiY2zdWqJlNRUnznI0eh82+VOhKfi2RM
         6Mj7bG85972CGU3y7oOsee7EFHpm/Tua4kvyoU13tsQA+u04Ut8Ta6xJF1MCk/bcBdbW
         w3BAFZHV28lJHPqg2Z/RfmTw9nvV6pDuWW7I9BJQ09VMJVBTk0FzzWvOx3Ld/+LRmKZZ
         J4UARAatc9cQT2J4twhrxLmqsKqoJjG+Pe8tNjg8T15f92wamJEmzEHtia7fItvZe+Tj
         y2F/G8rNoO8Xl6R2NXBQ4B3eFW1WruSLMh0B9x27n1NXiosJzk0+c6H013xZSipe89yq
         3fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ueWuQoY3KPMGs6cLm8DT7HgM284Z4wn+l2ltjKznOTE=;
        b=MRoIBVFWhN9UZWw4OFguTYaQXB1+AfOV0fNjjVyKbMU5Q4N2DKK4iss5taJwIoW0RA
         XGJD1wabG7QIYZu7jO9g1qbqrlW85c908+7XJxazWIS6uOM1uvAvENILlj10bvVDql8W
         +NLzAGzh+cyexmxSqbmBRuITNjf9whsBzJjknLvqRBzGH1+I8N14lbNgiJaDZcLuG4bh
         CI3xUmjjdTwuZHM5JHXhKeINuFYT/EJOq7kLiAkut5gbQhzMoLJtMiNK0ZSQMKhSPvbd
         2/UXrXXpKinVVxtdH+BR1mwVSzItQl7DIOAd7dd0uqHPHH1Am3z7fB6pkBYbg2X7SfW8
         Xecg==
X-Gm-Message-State: AOUpUlEeZQXMFYS0RKnDL6fEZQjkXgeRXchyKja5xOCRAG4cD95TEx0U
        R5ddyUeBxlNjQ42xQ+pXC8ZT1BSENgIuzKb/KstaGifF
X-Google-Smtp-Source: AAOMgpe86d/z8Mmyfwwp6MDmAI5yCk2HGtjxmndp4yPuELx8NSLbfkFl20d090or6lYJ722vFY7MnYyt8vPVkzyMxb0=
X-Received: by 2002:a2e:9f4d:: with SMTP id v13-v6mr1343386ljk.42.1532011826821;
 Thu, 19 Jul 2018 07:50:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 07:50:26
 -0700 (PDT)
In-Reply-To: <20180718145254.4770-1-geert+renesas@glider.be>
References: <20180718145254.4770-1-geert+renesas@glider.be>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Jul 2018 16:50:26 +0200
X-Google-Sender-Auth: ABg4w4jEvqfRIqHM22c0o63Bll0
Message-ID: <CAK8P3a19tFrP7ymiMHcmQ9Jah4_zTwuoM3=KN+WQROiZ36ArPA@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: Only encode UTF-8 quoted printable mail headers
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 4:52 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> As PERL uses its own internal character encoding, always calling
> encode("utf8", ...) on the author name may cause corruption, leading to
> an author signoff mismatch.
>
> This happens in the following cases:
>   - If a patch is in ISO-8859, and contains a non-ASCII author name in
>     the From: line, it is converted to UTF-8, while the Signed-off-by
>     line will still be in ISO-8859.
>   - If a patch is in UTF-8, and contains a non-ASCII author name in the
>     body (not header) From: line, it is assumed to be encoded in PERL's
>     internal character encoding, and converted to UTF-8 incorrectly,
>     while the Signed-off-by line will be in real UTF-8.
>
> Fix this by only doing the encode step if the From: line used UTF-8
> quoted printable encoding.
>
> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Fixes: bc76e3a125b44379 ("checkpatch: warn if missing author Signed-off-by")
> in -next
>
> To be folded into "checkpatch: Warn if missing author Signed-off-by" in
> Andrew's tree.

On a related note, I've looked through all files in the kernel, and found
that very file files in there are something other than 7-bit ASCII, UTF-8
or non-text files (according to /usr/bin/file). These are the only ones I found:

Documentation/devicetree/bindings/net/nfc/pn544.txt: ISO-8859 text
arch/arm/boot/dts/sun4i-a10-inet97fv2.dts:           C source, ISO-8859 text
arch/arm/crypto/sha256_glue.c:                       C source, ISO-8859 text
arch/arm/crypto/sha256_neon_glue.c:                  C source, ISO-8859 text
arch/m68k/hp300/hp300map.map:                        ISO-8859 text
arch/s390/kernel/ebcdic.c:                           C source, Non-ISO
extended-ASCII text
drivers/crypto/vmx/ghashp8-ppc.pl:                   a /usr/bin/env
perl script, ISO-8859 text executable
drivers/iio/dac/ltc2632.c:                           C source, ISO-8859 text
drivers/power/reset/ltc2952-poweroff.c:              C source, ISO-8859 text
drivers/staging/rtl8188eu/include/odm.h:             C source, ISO-8859 text
drivers/tty/vt/defkeymap.map:                        ISO-8859 text
kernel/events/callchain.c:                           C source, ISO-8859 text
lib/fonts/font_7x14.c:                               data
lib/fonts/font_8x16.c:                               data
lib/fonts/font_8x8.c:                                data
lib/fonts/font_pearl_8x8.c:                          data
net/netfilter/ipvs/Kconfig:                          ISO-8859 text
net/netfilter/ipvs/ip_vs_mh.c:                       C source, ISO-8859 text
tools/power/cpupower/po/de.po:                       GNU gettext
message catalogue, ISO-8859 text
tools/power/cpupower/po/fr.po:                       GNU gettext
message catalogue, ISO-8859 text

Almost all of those can be trivially converted using 'recode ISO-8859-1..UTF-8',
which we should probably do. The four font files contain comments for each
of the 256 characters, so that recode turns e.g. the <FF> character
into <U+00FF>,
which is probably still what we want here.

The one exception seems to be arch/s390/kernel/ebcdic.c, which apparently
uses 0x81 bytes as an excape before characters ISO-8859-1 characters with
the high bit set. I don't know what that encoding is called, but I managed
to manually convert it into something useful.

       Arnd
