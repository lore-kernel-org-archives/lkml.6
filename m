Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2256DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA8820894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HSgCFkw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA8820894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbeHBCZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:25:19 -0400
Received: from ozlabs.org ([203.11.71.1]:38743 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbeHBCZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:25:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41grpT3fGgz9rxx;
        Thu,  2 Aug 2018 10:36:49 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533170210;
        bh=DA9FYKmqOY5+9iJuCQLNuNPqUFgU5eiD0ab4tZYbSlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HSgCFkw9VDrYNTPS2kA0dx3mwPgwKRiSOTRUtMArEf2Va25fYgENOTgf+b2Nc+KkB
         TgZUkttstowsXtj+mwQaOOEYDRcsQBBD6cuaa1DVx4mWz4H2+5kHIVg3tMFkY9WqNC
         nKlovwpMSNt3p7jDlU8Y+WVvQQ/NcUUL6g4N9jy9eELpnG8ZEa2BQsszks8JGsMFiE
         orW1Yks7vCdo73LF2LSvl8YBHjhbqfRxKYlNSiu7Pwi7fkAtDkyg9R1rBbPBuO2qKA
         f83NeZqX/UjdU+zny2AelqjAGZ5kx3w3UjaXwExYt2YwX+dpP/2bBMgfOxvziOj/Mu
         l93aOze7NX47Q==
Date:   Thu, 2 Aug 2018 10:36:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] mm: introduce mem_cgroup_put() helper
Message-ID: <20180802103648.3d9f8e6d@canb.auug.org.au>
In-Reply-To: <20180802003201.817-2-guro@fb.com>
References: <20180802003201.817-1-guro@fb.com>
        <20180802003201.817-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Agfn7mIH_ICKtkxGZ9s+SbR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Agfn7mIH_ICKtkxGZ9s+SbR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Roman,

On Wed, 1 Aug 2018 17:31:59 -0700 Roman Gushchin <guro@fb.com> wrote:
>
> Introduce the mem_cgroup_put() helper, which helps to eliminate guarding
> memcg css release with "#ifdef CONFIG_MEMCG" in multiple places.
>=20
> Link: http://lkml.kernel.org/r/20180623000600.5818-2-guro@fb.com
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I have no idea why my Signed-off-by is attached to this patch (or
Andrew's for that matter) ...

--=20
Cheers,
Stephen Rothwell

--Sig_/Agfn7mIH_ICKtkxGZ9s+SbR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltiUiEACgkQAVBC80lX
0GxAyAf/TXDnyXATwzRiwgVQOOa8KP0UhK5pDewWcq4gK17X8rrf7jyuJjWWm4Q7
6lEANDfpnRcZ5WXPuksEHLGO0Ff4NtW4fGHxBshx7ai0CPow6Pp8wBTj1CKuE79M
MVyRLjhWDiGZAUm/PX3mX6FY8OQoNP/DCzHRG1tPgX8IewkBfO33um6w6eL2sGal
R8ihlwAg4O3vdIhv3TvcXvblLaEo25foMj9p7fs3o1QF7TGBb4hZtu6nb9X1KVNQ
EVgy7q2BL8R2iZ7F60bAEkviWmsVoTXBXHTc8pbRHxPy3DG9+LUuj3WH5dxTUU/Z
kfWX/U3YZYWMb+lThia/mQwbhuScXg==
=y4OD
-----END PGP SIGNATURE-----

--Sig_/Agfn7mIH_ICKtkxGZ9s+SbR--
