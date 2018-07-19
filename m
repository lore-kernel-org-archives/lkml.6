Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17AEECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B4420661
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B4420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbeGSSXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:23:00 -0400
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:38845 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731774AbeGSSW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:22:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C8D66837F24D;
        Thu, 19 Jul 2018 17:38:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: knot34_86c087648a736
X-Filterd-Recvd-Size: 3961
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu, 19 Jul 2018 17:38:45 +0000 (UTC)
Message-ID: <e03d364551b205afeef5b1702efec9eedef388f6.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Only encode UTF-8 quoted printable mail
 headers
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Thu, 19 Jul 2018 10:38:44 -0700
In-Reply-To: <CAMuHMdWCjr__9QB-wSiuo7ZZnOc9PuCRLJU=cVTrfvywJh5eBg@mail.gmail.com>
References: <20180718145254.4770-1-geert+renesas@glider.be>
         <CAK8P3a19tFrP7ymiMHcmQ9Jah4_zTwuoM3=KN+WQROiZ36ArPA@mail.gmail.com>
         <CAMuHMdWCjr__9QB-wSiuo7ZZnOc9PuCRLJU=cVTrfvywJh5eBg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-19 at 17:03 +0200, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Thu, Jul 19, 2018 at 4:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On a related note, I've looked through all files in the kernel, and found
> > that very file files in there are something other than 7-bit ASCII, UTF-8
> > or non-text files (according to /usr/bin/file). These are the only ones I found:
> > 
> > Documentation/devicetree/bindings/net/nfc/pn544.txt: ISO-8859 text
> > arch/arm/boot/dts/sun4i-a10-inet97fv2.dts:           C source, ISO-8859 text
> > arch/arm/crypto/sha256_glue.c:                       C source, ISO-8859 text
> > arch/arm/crypto/sha256_neon_glue.c:                  C source, ISO-8859 text
> > arch/m68k/hp300/hp300map.map:                        ISO-8859 text
> > arch/s390/kernel/ebcdic.c:                           C source, Non-ISO
> > extended-ASCII text
> > drivers/crypto/vmx/ghashp8-ppc.pl:                   a /usr/bin/env
> > perl script, ISO-8859 text executable
> > drivers/iio/dac/ltc2632.c:                           C source, ISO-8859 text
> > drivers/power/reset/ltc2952-poweroff.c:              C source, ISO-8859 text
> > drivers/staging/rtl8188eu/include/odm.h:             C source, ISO-8859 text
> > drivers/tty/vt/defkeymap.map:                        ISO-8859 text
> > kernel/events/callchain.c:                           C source, ISO-8859 text
> > lib/fonts/font_7x14.c:                               data
> > lib/fonts/font_8x16.c:                               data
> > lib/fonts/font_8x8.c:                                data
> > lib/fonts/font_pearl_8x8.c:                          data
> > net/netfilter/ipvs/Kconfig:                          ISO-8859 text
> > net/netfilter/ipvs/ip_vs_mh.c:                       C source, ISO-8859 text
> > tools/power/cpupower/po/de.po:                       GNU gettext
> > message catalogue, ISO-8859 text
> > tools/power/cpupower/po/fr.po:                       GNU gettext
> > message catalogue, ISO-8859 text
> > 
> > Almost all of those can be trivially converted using 'recode ISO-8859-1..UTF-8',
> > which we should probably do. The four font files contain comments for each
> > of the 256 characters, so that recode turns e.g. the <FF> character
> > into <U+00FF>,
> > which is probably still what we want here.
> > 
> > The one exception seems to be arch/s390/kernel/ebcdic.c, which apparently
> > uses 0x81 bytes as an excape before characters ISO-8859-1 characters with
> > the high bit set. I don't know what that encoding is called, but I managed
> > to manually convert it into something useful.
> 
> Yes, we should convert everything to UTF-8.

Thanks.

Can you send a patch or a script for Linus to apply?

