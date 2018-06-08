Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rE26NDPOGVsMLgAAmS7hNA
	; Fri, 08 Jun 2018 00:30:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B6F026089E; Fri,  8 Jun 2018 00:30:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ghTB959Q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 47E8B606DD;
	Fri,  8 Jun 2018 00:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47E8B606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeFHAam (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:30:42 -0400
Received: from ozlabs.org ([203.11.71.1]:53131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbeFHAal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:30:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4123Gk3XGKz9rvt;
        Fri,  8 Jun 2018 10:30:36 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528417838;
        bh=wq2mHvhAC1VowLkkBj0sXnh7O5Ly6iwEEL9+DchaXj8=;
        h=Date:From:To:Cc:Subject:From;
        b=ghTB959Qb12FOoIbLdO1BRDVjUw+33QBpNuZGY1BhwgR4tN5Ge7qW7Lr51hs7HPCS
         tFx1eSiQwU8u9WrUakKri0HmgtxitxikzyZq9wf715izbN+JGYpUsFbTGU0oNTQdW2
         QwdZ+F+JUCxKi9jB5iaNbVBZNNOgFeqAgc3RkymRMcKc1+n675CZE1fyjbt73Cissx
         zN879bXTE4vU3tKb8RlzoN4xJDKSTFQ1BqoM+ZzO2xvijTiQ0V5q+h4Saz548I5753
         2c6h2GYR8XLdMeIvwuUesDb2SlgmpYtzlVyLLBt3dbjok+hBqC0SVmD0nwcuPeAeL8
         9KDzzsL4D9hgA==
Date: Fri, 8 Jun 2018 10:30:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: linux-next: build warning after merge of the pm tree
Message-ID: <20180608103035.266fa61b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ncqmE76IGCiWNItKgM.lURc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ncqmE76IGCiWNItKgM.lURc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

WARNING: vmlinux.o(.text+0xc5b83a): Section mismatch in reference from the =
function __intel_pstate_cpu_init() to the variable .init.rodata:intel_pstat=
e_hwp_boost_ids
The function __intel_pstate_cpu_init() references
the variable __initconst intel_pstate_hwp_boost_ids.
This is often because __intel_pstate_cpu_init lacks a __initconst=20
annotation or the annotation of intel_pstate_hwp_boost_ids is wrong.

Introduced by commit

  f50f70793d78 ("cpufreq: intel_pstate: enable boost for Skylake Xeon")

--=20
Cheers,
Stephen Rothwell

--Sig_/ncqmE76IGCiWNItKgM.lURc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsZzisACgkQAVBC80lX
0GxW8Af+MqOShKPW6Heab/wr9NodJgskeQtpfBsuThDeKewEt39Qd8LncT3JmBhF
hoRenM305b5fnvz6Y3pXWX7ydpvaNODEL8rZ95x0unK9SeE91uw+5g1LL1pb1eu/
K8CMyRNh92/Hlcx1jqMI421T6KR+v4NLXGEfaAO0sSwaqqjuaH+Q+EAxwNswNQL+
yc5vN8XeTi+syGixf0V0vKdo1naeKimFTpsGVxxhO7LEtotasXRserhexaPL+PHO
Nqp6TXBA2xPJl/7+NgvUmoUCZEflWTtbDSFiWwnmhIgvhunNyJKoBHumd2gMWCO8
E23+y71CJJIf9SViNRndUl4COvMeNQ==
=yyjF
-----END PGP SIGNATURE-----

--Sig_/ncqmE76IGCiWNItKgM.lURc--
