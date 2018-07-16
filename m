Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D828ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5562098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5562098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbeGPWqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:46:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:33072 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728794AbeGPWqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:46:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04935ADE6;
        Mon, 16 Jul 2018 22:16:36 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 17 Jul 2018 08:16:23 +1000
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Wang <wvw@google.com>, Stefan Agner <stefan@agner.ch>,
        Andrei Vagin <avagin@openvz.org>,
        Yisheng Xie <ysxie@foxmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] kernel.h: Add for_each_if()
In-Reply-To: <f361dcc9c25e46819100ba1634f56db1c867f1b8.camel@linux.intel.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch> <20180709162509.29343-1-daniel.vetter@ffwll.ch> <20180709163001.8fb8148223a57bc46a13fbda@linux-foundation.org> <20180710075328.GG3008@phenom.ffwll.local> <871scbwfd4.fsf@notabene.neil.brown.name> <CAKMK7uFEYyD2ChWnO_0PS_rkK180dDoQ1g4J0UWRfchnYQxOTA@mail.gmail.com> <20180711160547.59f086a587c7f3c8d3c40f0f@linux-foundation.org> <87bmbavhai.fsf@notabene.neil.brown.name> <79133322-b04b-f005-f1f6-25c28c5058e4@infradead.org> <f361dcc9c25e46819100ba1634f56db1c867f1b8.camel@linux.intel.com>
Message-ID: <87muuqsu6g.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 16 2018, Andy Shevchenko wrote:

> On Fri, 2018-07-13 at 16:42 -0700, Randy Dunlap wrote:
>> On 07/13/2018 04:37 PM, NeilBrown wrote:
>
>>=20
>> coding-style.rst says:
>> Also, use braces when a loop contains more than a single simple
>> statement:
>
> Independently on a) would we use some macro for condition, or b) fix
> macros against this kind of nested conditions, there is another
> weirdness we would like to avoid, i.e.
>
> for_each_foo() {
>  ...
> } else {
>  ...
> }
>
> It is written according to coding style, but too much weird.

Agreed.  Too weird.

>
> So, summarize this discussion I think we would
> - keep for_each_if() in DRM subsystem alone
> - fix macros which are using positive condition 'if (cond)' by replacing
> with 'if (!cond) {} else' form for sake of robustness.
>
> Do you agree on that?

I agree.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltNGTcACgkQOeye3VZi
gbnFDQ//SB2gVd+uNlfPffgUJ2DEQdQOAitY6PtSLZWC66UlgkUMmpLm3zOytIIW
Zbn9FYbz9MKLiwwkDvQP/8EpzgCHq2SUi5j5sdWm47Qalhg81ngPk2HvVVbfErTm
SmnoVj3TZdem9jmlqpq9gmOsbtmZbcZQBGM9XmQQBjeBT/cZOfBequRROOZeFp2e
higfsKn8vvMqATk2jwdvefrvAkaNfEawFZcPeAkGuMlFxB88R2OlLL8wg2F/3+qM
RH4oOJ5FhTudBcxGP2gHCWDT0PGtC2JTL+jI0wmwYV9d8Jcoz8I+P26SyskxnYWJ
CjtGBWxRHZqGfwDYVzi3i4A9aQFm5dKLTau7XgC+HMiXLdPwC0/8bRXJUv7Wezbx
HyJ4aVYXBVZdjmtTslLt1RSZh1WSrh/gO7AQsbyhgJj9vGKnBPx7QX7fYfCzBMhM
KEfviX5Umv1Kjayl7gKqNpcUgBKGGEMqgBTttwpOotuA9CuX0UWcXwBY1Ao/nbWT
6JY/DUlxpH0WwtZ+j/CZzUHVtToVVDzrE1+TQkWUHnjXAh78Rr2Mv1ImhydP0o89
9a7Nc1VaLZhw+SIzhcNGxVPzUH70vH6bKvZo3e1SNAjGvmS5OPS8nkRKMSXhGNKI
4ACxN5GAhA1d1NhAaklJhxbl4Uf/VGCITiQLdCxHt4/l9Dy3Nds=
=WTCR
-----END PGP SIGNATURE-----
--=-=-=--
