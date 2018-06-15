Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8299BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBCF208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yvYypnOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBCF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965682AbeFOK6Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965590AbeFOK6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:58:15 -0400
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2CA2208B2;
        Fri, 15 Jun 2018 10:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529060295;
        bh=5U7V9eGN1JS8ygcZzefuPYrzJIYsl4zfV4h++Y98lDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yvYypnOZg3VFmnSyzjjCevkh3t+jiDp9eIeDqqKMvPmhZZSVrcTOMTwbbYcrH72Uv
         1uP+4/4oP+tgcYqiOnjrT/BsoLer/Kwmdf1OtSuMIToiF2KV2mLRkncf3fSYkQXcCZ
         R34iIfAhUfOEtU8Rz9OfdBpa1ShLbRMwqBFNJsZQ=
Date:   Fri, 15 Jun 2018 11:58:10 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@linux-mips.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 4/4] rseq/selftests: Implement MIPS support
Message-ID: <20180615105809.GB7603@jamesdev>
References: <20180614235211.31357-1-paul.burton@mips.com>
 <20180614235211.31357-5-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <20180614235211.31357-5-paul.burton@mips.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Jun 14, 2018 at 04:52:10PM -0700, Paul Burton wrote:
> +#define __RSEQ_ASM_DEFINE_TABLE(version, flags,	start_ip,			\

Nit: technically all these \'s are on 81st column...

> +#define __RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown,			\
> +				abort_label, version, flags,			\
> +				start_ip, post_commit_offset, abort_ip)		\
> +		".balign 32\n\t"						\

ARM doesn't do this for DEFINE_ABORT. Is it intentional that we do for
MIPS?

Otherwise this whole series looks reasonable to me, so feel free to add
my rb on the whole series if you do apply youself:

Reviewed-by: James Hogan <jhogan@kernel.org>

Thanks
James

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWyObwQAKCRA1zuSGKxAj
8rB/AP92jAaGzv9MtOvxArSDM9bpCmUgwi+wcvUZLIenW/1HBwD+M5+uEzr940Es
CWMG8J2OTpcP2ojwsPFWP6Bi5pEkvg0=
=1YVE
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
