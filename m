Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0126FC7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A842086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A842086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sf-tec.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJONAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:00:49 -0400
Received: from mail.sf-mail.de ([78.47.74.12]:46281 "EHLO mail.sf-mail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeJONAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:00:48 -0400
Received: (qmail 2695 invoked from network); 15 Oct 2018 05:17:09 -0000
Received: from dslb-088-071-104-165.088.071.pools.vodafone-ip.de ([::ffff:88.71.104.165]:39886 HELO daneel.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.34dev) with (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA
        for <firoz.khan@linaro.org>; Mon, 15 Oct 2018 07:17:09 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-parisc-owner@vger.kernel.org
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
Date:   Mon, 15 Oct 2018 07:16:59 +0200
Message-ID: <4517632.a0TFakfgol@daneel.sf-tec.de>
In-Reply-To: <CALxhOngwHfFzCGXknF4_CHjD=4LeM8BnrZ+s-p6ZRcJ3G8i_RA@mail.gmail.com>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org> <c6280818c999449646ec216984f2df9e@sf-tec.de> <CALxhOngwHfFzCGXknF4_CHjD=4LeM8BnrZ+s-p6ZRcJ3G8i_RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3045382.2mgNMOvJcN"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3045382.2mgNMOvJcN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Firoz Khan wrote:
> Hi Rolf,
> 
> On Fri, 12 Oct 2018 at 17:37, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > Firoz Khan wrote:

> > > +prefix="$4"
> > > +offset="$5"
> > > +
> > > +fileguard=_UAPI_ASM_PARISC_`basename "$out" | sed \
> > > +    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> > > +    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> > > +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> > > +    echo "#ifndef ${fileguard}"
> > > +    echo "#define ${fileguard}"
> > > +    echo ""
> > > +
> > > +    nxt=0
> > > +    while read nr abi name entry compat ; do
> > > +     if [ -z "$offset" ]; then
> > > +         echo -e "#define __NR_${prefix}${name}\t$nr"
> > 
> > This mixed indentation with both tabs and spaces is a bit messy.
> 
> Is this what you suggested?
> -           echo -e "#define __NR_${prefix}${name}\t$nr"
> +           echo "#define __NR_${prefix}${name} $nr"

No, this was actually only about the script itself. Looks like your editor has 
tab-width 8 and indentation 4 or so.

Eike
--nextPart3045382.2mgNMOvJcN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCW8QiywAKCRBcpIk+abn8
TkW/AJ9u7BePqjngSBek/LuUdC5oSBYJUQCgknrnxjpoIDZmHtjFwq8YzC1FGpA=
=1rfo
-----END PGP SIGNATURE-----

--nextPart3045382.2mgNMOvJcN--



