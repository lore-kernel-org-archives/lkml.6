Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82945C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354C22081C
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj8PA+cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354C22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeK1JkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:40:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46939 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbeK1JkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:40:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so16318126ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=epJEwGhIlOTf4E3hr/jnK2x328XOXS++LkLUZdPYtWg=;
        b=Yj8PA+cOZCLAXaTPkx1RVIg97vZ38v7Ewjq8CTSZs6RISt+sK4z7jcj4pn8/UeDQYj
         7A88Hwbfy84Gx0lwYqNIQ9gcKeHSdMIWv4VJ748lZMrmW0yB4kzTsSwUJOmG000XGCA9
         oYpBRGEXTGbF4tSugIxilcHszBxbpbfgh2kN6JyRTAYmQ6tf7JjlOGUR0EYPqXRrPkDh
         CQym2b7pC+UaneJd/AMbssx2bBWvHC01OTvho9Spw3/EiHpMXmWfr2lTaEuSleyGBZS2
         mLDQvijz8q+I+hlAx+FV3jSXY1cgMiSD45HL8gpNMIdQEjywI/5bhvf0bLPKNxusOYWu
         8duQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=epJEwGhIlOTf4E3hr/jnK2x328XOXS++LkLUZdPYtWg=;
        b=gc18OomkiznKvmOH7TKzQKR+OXRmbwQXhuq0P54ay923XUQOWzfeF6xhoHb3ol4f9b
         TqgnacpUWsidpP2mzjHNXusK0IkhK/AyEZ2YEQTBPaG5QRQ1ljg4+G02qBkQTS9H5Dn8
         v4FT5IolTpk+7+FbbufWwQjWBWi4aT4r8gkCt9lfwiCczYVV77N3XtjM2qjVvUfau/E0
         fzXBtVlU6+7PNfnfc1vshOM6IKNJTiibhvm3C5q/i5ZiXVz60aL7cQWkl+CKD1Tak/O4
         crDO1f/efQuR0Tg6341nA6IODabIK9nLt0uWYCYFzkaa87HBej2iRFUioWMFD0I8m+h5
         K5Sg==
X-Gm-Message-State: AA+aEWbPbFCfad7MolPhVttN6b1ZqCHIvTXmBkOkFChC39nyC3GALWG7
        ij8Gy0FZSR+PF2Y5xJH7+3A=
X-Google-Smtp-Source: AFSGD/V60jjGf2wsR1lXNo2MM21ALbajVhhPtfZXstmq5+Uwhdi6NRQ2OV29WaUBP6sBCLAN/gR/Pg==
X-Received: by 2002:a17:902:6e16:: with SMTP id u22mr33840728plk.175.1543358460304;
        Tue, 27 Nov 2018 14:41:00 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id x127sm6667685pfd.156.2018.11.27.14.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 14:40:59 -0800 (PST)
Date:   Tue, 27 Nov 2018 12:40:52 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Herrmann <dh.herrmann@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Nick Piggin <npiggin@gmail.com>, pifang@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCHi v2] mm: put_and_wait_on_page_locked() while page is
 migrated
Message-ID: <20181127224052.2zyxkdo4lbecq4cz@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Herrmann <dh.herrmann@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@linux.com>, Nick Piggin <npiggin@gmail.com>,
        pifang@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils>
 <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com>
 <alpine.LSU.2.11.1811251900300.1278@eggly.anvils>
 <alpine.LSU.2.11.1811261121330.1116@eggly.anvils>
 <20181127105848.GD16502@rapoport-lnx>
 <alpine.LSU.2.11.1811271258070.4506@eggly.anvils>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rjiqytyomg5yqcqz"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1811271258070.4506@eggly.anvils>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rjiqytyomg5yqcqz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 01:08:50PM -0800, Hugh Dickins wrote:
> On Tue, 27 Nov 2018, Mike Rapoport wrote:
> > On Mon, Nov 26, 2018 at 11:27:07AM -0800, Hugh Dickins wrote:
> > >=20
> > > +/*
> > > + * A choice of three behaviors for wait_on_page_bit_common():
> > > + */
> > > +enum behavior {
> > > +	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
> > > +			 * __lock_page() waiting on then setting PG_locked.
> > > +			 */
> > > +	SHARED,		/* Hold ref to page and check the bit when woken, like
> > > +			 * wait_on_page_writeback() waiting on PG_writeback.
> > > +			 */
> > > +	DROP,		/* Drop ref to page before wait, no check when woken,
> > > +			 * like put_and_wait_on_page_locked() on PG_locked.
> > > +			 */
> > > +};
> >=20
> > Can we please make it:
> >=20
> > /**
> >  * enum behavior - a choice of three behaviors for wait_on_page_bit_com=
mon()
> >  */
> > enum behavior {
> > 	/**
> > 	 * @EXCLUSIVE: Hold ref to page and take the bit when woken,
> > 	 * like __lock_page() waiting on then setting %PG_locked.
> > 	 */
> > 	EXCLUSIVE,
> > 	/**
> > 	 * @SHARED: Hold ref to page and check the bit when woken,
> > 	 * like wait_on_page_writeback() waiting on %PG_writeback.
> > 	 */
> > 	SHARED,
> > 	/**
> > 	 * @DROP: Drop ref to page before wait, no check when woken,
> > 	 * like put_and_wait_on_page_locked() on %PG_locked.
> > 	 */
> > 	DROP,
> > };
>=20
> I'm with Matthew, I'd prefer not: the first looks a more readable,
> less cluttered comment to me than the second: this is just an arg
> to an internal helper in mm/filemap.c, itself not kernel-doc'ed.
>=20
> But the comment is not there for me: if consensus is that the
> second is preferable, then sure, we can change it over.

For something which is internal to a single file I strongly prefer
the first as well.

--=20
Cheers,
Joey Pabalinas

--rjiqytyomg5yqcqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv9x/MACgkQ2rGdfm9D
tVKdGRAAut8v4nSlw2U4Hn42UtEqzpblfw3CUOpTTRO8TArXhZyq7cCQW9+rmfXf
83gLqcfVwIt+jg9VqpORM6hFtotkwRtwBOM0ZO5KkcHKpgI1+z9UVTWI1ZYSwm67
0CF/TyeRdNm3VP8WF1RG0CffG1ujTEZMF2sG0krVwKhBVNARD3hZSaI5jWBtxyJ0
VnCiGrkzChqwoQDtRQaIb2DXNRd1w4GX2K+A3SJi7ALUvyPsk1+rrrsss+fHaEkB
pZIy/5NNnOKvO3vxtxOSs2xWKVF5weBdjOCtr9UbZOY7BMpoZxAGCRSXxngk4K6a
croT4+68OKW4OXmyHL2HXlHPuj9dRvHQXUXtBpYRPHdwz3QC9LK62nOo8FTjO6BK
mwuoAu5pnkdZZJKLB4jIfiyPssBl6+gyYfkS5WVpNTtHXB4jdvSbyg4GGUdBUiuB
zhv8SHNSsNpDL0SORZPkOpc6OYnvZVIa+tFyop7YWCeLh3GdMcKdKSxsynaizk3c
w4cXc7E8vawHWEiEDOTp0/cbAh0ZJeU0H7WyJssdHsNEjL90dppsMxGrOTJs+U2+
zjtB9te3QakLh48Y2nppuYy+9WH75Xs72lNHo+dN3wmuAQwUH74p+FPHSynh1yoE
sj8tpBBYrkDcOlDlFuL+37U2Noo39zzfXMCoZeoMcEy01DC92iQ=
=9Eyk
-----END PGP SIGNATURE-----

--rjiqytyomg5yqcqz--
