Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36C2C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF6C20C10
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kLwQk2zI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF6C20C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390894AbeGKXyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:54:36 -0400
Received: from ozlabs.org ([203.11.71.1]:35573 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388425AbeGKXyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:54:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Qwjf1Vmmz9rxs;
        Thu, 12 Jul 2018 09:47:50 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531352870;
        bh=X277FGwoIJLaNCFyDfdp0Qi2wzT+O03VasZeJmJYqsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kLwQk2zIno1P9SNw1ZIdm1JLT+eFnHrKwKUKZe1KOGRZoSWuepbBpFlIqDzeizUo0
         fHLdgJqO7hcgNnW86/eev+e3cH4K20bhkdyrt7qmkdotBrnW1xZx7CJI31cuTvCttO
         7pC+bbhMLzmxwD4OvW0nkvErhGMSPqvLb9hnIgsKT7e5kuOHbGW35uCd+7xZEm5dDv
         IJPdSpZ4AcyRehy67rlKU7xIRhpHbdBE4WWr1EOgJMKsS0llVqGCIeoiSIpdV4kqYN
         zE5TUOvZMsI/rPq79P4OY49Zmy8iVHrV/a4Ipo6LGP2fdQM27+z2ynt/mYu15XLKwc
         nZbJf+jRejf1w==
Date:   Thu, 12 Jul 2018 09:47:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        osalvador@techadventures.net, mpe@ellerman.id.au,
        broonie@kernel.org, mhocko@suse.cz, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, mm-commits@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bhe@redhat.com,
        aneesh.kumar@linux.ibm.com, khandual@linux.vnet.ibm.com
Subject: Re: Boot failures with "mm/sparse: Remove
 CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER" on powerpc (was Re: mmotm
 2018-07-10-16-50 uploaded)
Message-ID: <20180712094729.1112f290@canb.auug.org.au>
In-Reply-To: <20180711141344.10eb6d22b0ee1423cc94faf8@linux-foundation.org>
References: <20180710235044.vjlRV%akpm@linux-foundation.org>
        <87lgai9bt5.fsf@concordia.ellerman.id.au>
        <20180711133737.GA29573@techadventures.net>
        <CAGM2reYsSi5kDGtnTQASnp1v49T8Y+9o_pNxmSq-+m68QhF2Tg@mail.gmail.com>
        <20180711141344.10eb6d22b0ee1423cc94faf8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EYBWYqRmT+9CpTkc3L=Ei9_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EYBWYqRmT+9CpTkc3L=Ei9_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, 11 Jul 2018 14:13:44 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> OK, I shall drop
> mm-sparse-remove-config_sparsemem_alloc_mem_map_together.patch for now.

I have dropped it from linux-next today (in case you don't get time).

--=20
Cheers,
Stephen Rothwell

--Sig_/EYBWYqRmT+9CpTkc3L=Ei9_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltGlxEACgkQAVBC80lX
0GwoUwf/bx0m01nkKzrGDRN2EbV745BfGn4LcFCUqgnVbtIwvCgd21+BSMQKZeBQ
hXceLO2LFHU5+BQxG8CsGyLob2rijmXu35ie3boJKXPjMPdng8QaCCtSDyUkjTuu
XkiNYUspbTMVZWlnHX3tFV0Urm4SI7xHOG5lrE/c58rLoJnTOqL9ssC2cdiN0j2w
glkgPVXLSljiB5RwUmF/cXf3Q6knDeHF2f3XikAlUjKv5NIa+JR3wz1H/pzzIw7K
kSVxPcRjwRBaAmqxPMep92ZpthSBZ9sJfTxQajHFyTKfgpSfWB6aP8FuavEL8zuC
xHM1AI0ggVguLGhN2yKqtxRw77KLmQ==
=c4bd
-----END PGP SIGNATURE-----

--Sig_/EYBWYqRmT+9CpTkc3L=Ei9_--
