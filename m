Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FE7C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8970825A57
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8970825A57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965630AbeF0SRg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:17:36 -0400
Received: from shelob.surriel.com ([96.67.55.147]:55292 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934492AbeF0SRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:17:35 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fYF0T-0002Z8-2r; Wed, 27 Jun 2018 14:17:29 -0400
Message-ID: <1530123448.7898.233.camel@surriel.com>
Subject: Re: [PATCH 3/6] x86,tlb: make lazy TLB mode lazier
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, songliubraving@fb.com
Date:   Wed, 27 Jun 2018 14:17:28 -0400
In-Reply-To: <CALCETrVgDXe6NFCmxhyiwMEQmQqyidAh+wQBWeaCKg+z6jQOPw@mail.gmail.com>
References: <20180626173126.12296-1-riel@surriel.com>
         <20180626173126.12296-4-riel@surriel.com>
         <CALCETrVgDXe6NFCmxhyiwMEQmQqyidAh+wQBWeaCKg+z6jQOPw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hBhus1lTWfAfBvnX7Yzb"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hBhus1lTWfAfBvnX7Yzb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-06-27 at 11:10 -0700, Andy Lutomirski wrote:
> On Tue, Jun 26, 2018 at 10:31 AM Rik van Riel <riel@surriel.com>
> wrote:

> In general, the changes to this function are very hard to review
> because you're mixing semantic changes and restructuring the
> function.
> Is there any way you could avoid that?  Or maybe just open-code a
> tlb_gen check in the unlazying path?

Let me re-do v2 of the patch series in a way that
splits out the restructuring from the semantic
changes.

I already have code here that open-codes the tlb_gen
check in the unlazying path (not in v2 yet).

--=20
All Rights Reversed.
--=-hBhus1lTWfAfBvnX7Yzb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsz1LgACgkQznnekoTE
3oMc1wf/Vk8GEHNYU13d10NuuHt03KKmn7PiSHuvlQkKua0xYHq21J0DY+LfvM7Z
hv3QyTxOAcJAYRqs6a+i17YzJBKbPqNhh4VUjZJr0l3k+BAV8MzZ7gVzAoustqmb
iXdzWQu+/9Ads/uLlq9P8Ir+s+BzdOLfyaMfbB++f9OayPeWofaUx4H2vpjsY4SS
ku4UzG3OOAnWn/9YUQznS8PthmGb4VaJUVvfiFF9YE0Y6utGzxlO8RsCChyob0yK
6na8RAyQiPsRPTnSsvq1CqC4+vOFMhnX2Ky521NEDaNgNvOuAbnOaYJ3XOK8FXLm
MVsR4gjzNUkjX5kHgQm7RificqedYw==
=9Mqq
-----END PGP SIGNATURE-----

--=-hBhus1lTWfAfBvnX7Yzb--

