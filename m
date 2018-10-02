Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79851C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1D12089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZM70HUsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1D12089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeJBODK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:03:10 -0400
Received: from ozlabs.org ([203.11.71.1]:41425 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeJBODJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:03:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PVv00cBcz9sBJ;
        Tue,  2 Oct 2018 17:21:16 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538464878;
        bh=9t76xXW3EaXd7ZEUZQ1D6hfKF4ZBziLbyPwg/7IAfFw=;
        h=Date:From:To:Cc:Subject:From;
        b=ZM70HUsqWwuORDg2kuPC0yW33sPxpdA6fBYIxPAMHFJ9OxjRUj9Qv+eHxmwXCSxBu
         iM37OMun/q73p/o6X2zBA8HfLiAM/E9438/sOsx55CZrfPX6vLNJa1OeRyyP/4n483
         ioq2bfIAM6KyNjnEgCu1HFmUwH9X2ZRlDyQxyvG69ndZL7cHpML/BuxbjZ3UEwkN1q
         RVw3KakH8SxswlItQu8X41xCnnHu+EvmdXFjMWBSklY36Veq/1AdSA8rdZZQTrmmDc
         b9wHrpiO5C0cPx+sQrZdoVqnSPDYObD3AaVGYCyQGEwYlU4L6RFeceZAPw+Lim9NOX
         2BB9hpKdVyEBQ==
Date:   Tue, 2 Oct 2018 17:21:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: linux-next: manual merge of the akpm-current tree with the block
 tree
Message-ID: <20181002172113.33dfbd9d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/z0nytnICs3AqwM/QDe8a9+E"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/z0nytnICs3AqwM/QDe8a9+E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  block/blk-iolatency.c

between commit:

  1fa2840e56f9 ("blk-iolatency: use a percentile approache for ssd's")

from the block tree and commit:

  07360251b445 ("sched-loadavg-consolidate-load_int-load_frac-calc_load-fix=
")
  1ccc64569a48 ("sched-loadavg-consolidate-load_int-load_frac-calc_load-fix=
-fix")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc block/blk-iolatency.c
index 35c48d7b8f78,8793f1344e11..000000000000
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@@ -186,80 -172,6 +186,81 @@@ static inline struct blkcg_gq *lat_to_b
  	return pd_to_blkg(&iolat->pd);
  }
 =20
 +static inline void latency_stat_init(struct iolatency_grp *iolat,
 +				     struct latency_stat *stat)
 +{
 +	if (iolat->ssd) {
 +		stat->ps.total =3D 0;
 +		stat->ps.missed =3D 0;
 +	} else
 +		blk_rq_stat_init(&stat->rqs);
 +}
 +
 +static inline void latency_stat_sum(struct iolatency_grp *iolat,
 +				    struct latency_stat *sum,
 +				    struct latency_stat *stat)
 +{
 +	if (iolat->ssd) {
 +		sum->ps.total +=3D stat->ps.total;
 +		sum->ps.missed +=3D stat->ps.missed;
 +	} else
 +		blk_rq_stat_sum(&sum->rqs, &stat->rqs);
 +}
 +
 +static inline void latency_stat_record_time(struct iolatency_grp *iolat,
 +					    u64 req_time)
 +{
 +	struct latency_stat *stat =3D get_cpu_ptr(iolat->stats);
 +	if (iolat->ssd) {
 +		if (req_time >=3D iolat->min_lat_nsec)
 +			stat->ps.missed++;
 +		stat->ps.total++;
 +	} else
 +		blk_rq_stat_add(&stat->rqs, req_time);
 +	put_cpu_ptr(stat);
 +}
 +
 +static inline bool latency_sum_ok(struct iolatency_grp *iolat,
 +				  struct latency_stat *stat)
 +{
 +	if (iolat->ssd) {
 +		u64 thresh =3D div64_u64(stat->ps.total, 10);
 +		thresh =3D max(thresh, 1ULL);
 +		return stat->ps.missed < thresh;
 +	}
 +	return stat->rqs.mean <=3D iolat->min_lat_nsec;
 +}
 +
 +static inline u64 latency_stat_samples(struct iolatency_grp *iolat,
 +				       struct latency_stat *stat)
 +{
 +	if (iolat->ssd)
 +		return stat->ps.total;
 +	return stat->rqs.nr_samples;
 +}
 +
 +static inline void iolat_update_total_lat_avg(struct iolatency_grp *iolat,
 +					      struct latency_stat *stat)
 +{
 +	int exp_idx;
 +
 +	if (iolat->ssd)
 +		return;
 +
 +	/*
- 	 * CALC_LOAD takes in a number stored in fixed point representation.
++	 * calc_load takes in a number stored in fixed point representation.
 +	 * Because we are using this for IO time in ns, the values stored
 +	 * are significantly larger than the FIXED_1 denominator (2048).
 +	 * Therefore, rounding errors in the calculation are negligible and
 +	 * can be ignored.
 +	 */
 +	exp_idx =3D min_t(int, BLKIOLATENCY_NR_EXP_FACTORS - 1,
 +			div64_u64(iolat->cur_win_nsec,
 +				  BLKIOLATENCY_EXP_BUCKET_SIZE));
- 	CALC_LOAD(iolat->lat_avg, iolatency_exp_factors[exp_idx], stat->rqs.mean=
);
++	iolat->lat_avg =3D calc_load(iolat->lat_avg,
++				   iolatency_exp_factors[exp_idx], stat->rqs.mean);
 +}
 +
  static inline bool iolatency_may_queue(struct iolatency_grp *iolat,
  				       wait_queue_entry_t *wait,
  				       bool first_block)

--Sig_/z0nytnICs3AqwM/QDe8a9+E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluzHGkACgkQAVBC80lX
0Gx88gf/Y4nDG8a3w5gSgM3kuhMi/cA5SuHgtmOFKNHoYZQSQr5T/mZosMLxyYSX
Qx/de9yzWyR/8PO3rxSU03MuCniZlKbE/1QZEdYi0Cx5g6Xw99iSL+osAvEJdlVd
AO10UjUkafEO1sBywzJgXC8JlF1a6x0Uuo8qhFltimLJq2A4IL78iKQPCoZpQaDl
iHH8X3sEqAHOV7blJ4m7NHzPB/yd+z0kWVyptXBQAgW7/mLKOIsO/AsjuNo0EsvX
ljr8Sz0ALyLTdzUDFnXQ2hASDLmIq5/aH4xTBQpct6Pg8voBuKan5vR/6GSFE9hz
eSztnksNAocYuWe2Ypgt9Rwywy8Qyw==
=8H48
-----END PGP SIGNATURE-----

--Sig_/z0nytnICs3AqwM/QDe8a9+E--
