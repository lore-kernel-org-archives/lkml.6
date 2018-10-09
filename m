Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B13C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B462087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B462087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.rutgers.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeJIVPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:15:47 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:38607 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeJIVPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:15:47 -0400
Received: by mail-qt1-f178.google.com with SMTP id l9-v6so1668032qtf.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 06:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=xjWs20RU0HrI89lsHaEBcr1iR8tVkybbvwIIXjr3tIQ=;
        b=ozr0jx7HlXk4SXjpAb5immZ7oJrBd/gsmWz1PiWB7oCLGG76Bc5+/XATO9F1+mq0KN
         qzWJl3PFlU3cibnuLBgqZrFQ4F8jna/91pWUvRhqbk6axxRSYE5/VB7jSsaMS9lAUO0g
         EuTo1TSRxzFrVPUjryhJOI/utkT+C6rBWMf7WaPnkiAgEvfW9ioygXieHq2n2iBbd3Oe
         91ifI7YWVH6YOXfwIOuahiQvCGDuu0dDNzY8jWKL8eg+d0RLXsK49r6sN//dscetyBZI
         yTRGepnNQteVrd4U3tyyJa1hWy1b1JqMVaT1/aiyb2K+s7GMiHV4HsANhEl92ETfVq4r
         HBDA==
X-Gm-Message-State: ABuFfoh4YwMBYqIFpx9X6WLpD0st9W5Hvj2QCc441dUV41zDj+9jCiL3
        PNb5ES5feC/v8BKLIiJGPGDJ2g==
X-Google-Smtp-Source: ACcGV626G3jydU5SxjqwYTIjpRSOARbD5Z0uzsmi7ZbrpYqHtuL8lyN515/1K7GQlZG3JM+O+QvBXw==
X-Received: by 2002:a0c:edcd:: with SMTP id i13-v6mr23800835qvr.15.1539093521181;
        Tue, 09 Oct 2018 06:58:41 -0700 (PDT)
Received: from [172.25.130.148] (pool-128-6-36-179.nat.rutgers.edu. [128.6.36.179])
        by smtp.gmail.com with ESMTPSA id z24-v6sm10193549qtg.42.2018.10.09.06.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 06:58:39 -0700 (PDT)
From:   "Zi Yan" <zi.yan@cs.rutgers.edu>
To:     "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        mhocko@suse.com, will.deacon@arm.com,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH] mm/thp: Correctly differentiate between mapped THP and
 PMD migration entry
Date:   Tue, 09 Oct 2018 09:58:36 -0400
X-Mailer: MailMate (1.12r5528)
Message-ID: <7E8E6B14-D5C4-4A30-840D-A7AB046517FB@cs.rutgers.edu>
In-Reply-To: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
References: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_D24ABCAE-03FA-4552-A378-F6F6EC1FF47E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_D24ABCAE-03FA-4552-A378-F6F6EC1FF47E_=
Content-Type: text/plain

cc: Naoya Horiguchi (who proposed to use !_PAGE_PRESENT && !_PAGE_PSE for x86
PMD migration entry check)

On 8 Oct 2018, at 23:58, Anshuman Khandual wrote:

> A normal mapped THP page at PMD level should be correctly differentiated
> from a PMD migration entry while walking the page table. A mapped THP would
> additionally check positive for pmd_present() along with pmd_trans_huge()
> as compared to a PMD migration entry. This just adds a new conditional test
> differentiating the two while walking the page table.
>
> Fixes: 616b8371539a6 ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> On X86, pmd_trans_huge() and is_pmd_migration_entry() are always mutually
> exclusive which makes the current conditional block work for both mapped
> and migration entries. This is not same with arm64 where pmd_trans_huge()

!pmd_present() && pmd_trans_huge() is used to represent THPs under splitting,
since _PAGE_PRESENT is cleared during THP splitting but _PAGE_PSE is not.
See the comment in pmd_present() for x86, in arch/x86/include/asm/pgtable.h

> returns positive for both mapped and migration entries. Could some one
> please explain why pmd_trans_huge() has to return false for migration
> entries which just install swap bits and its still a PMD ? Nonetheless
> pmd_present() seems to be a better check to distinguish between mapped
> and (non-mapped non-present) migration entries without any ambiguity.

If arm64 does it differently, I just wonder how THP splitting is handled
in arm64.


--
Best Regards
Yan Zi

--=_MailMate_D24ABCAE-03FA-4552-A378-F6F6EC1FF47E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQFKBAEBCgA0FiEEOXBxLIohamfZUwd5QYsvEZxOpswFAlu8tAwWHHppLnlhbkBj
cy5ydXRnZXJzLmVkdQAKCRBBiy8RnE6mzDkDB/0UH4oRh+cOCW0EYDRVhKtKBjs1
e1BD1S/Pcq/XFtgVfFoziz+3TRHYESnnwDOG86L7hyWON0yL20X6OIaKcQjRkRo7
OLReAB5Jq13CPF4q1U9jjRyNdl9dYvOEBtDsc02F8xv/8Hge3aIAqYH1eouCmAVa
Zo1hIRSxdHbWlLRLOOdNc2vD218gNuqtrcCsR78fddklGnItibcyokilXd3VBPRe
5gTJxg4s172rqL7IxkUs3N3KsiHnDDmH383tGZzIl7tULdLcboMvPK+ops5pOWTZ
UhCmfX0iauJoG8uHTkhQZvR2WiUz7gptJOA6QzlV80DqfgapNSpdzaJbn8mt
=ULbu
-----END PGP SIGNATURE-----

--=_MailMate_D24ABCAE-03FA-4552-A378-F6F6EC1FF47E_=--
