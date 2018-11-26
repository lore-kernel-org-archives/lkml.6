Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29059C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF412084E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mIn5okrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF412084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbeKZLL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:11:59 -0500
Received: from ozlabs.org ([203.11.71.1]:55687 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeKZLL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:11:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4336x22xBhz9s29;
        Mon, 26 Nov 2018 11:19:34 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543191574;
        bh=tRxW+omdH+QqFOjZVCxBvkcvMZa63hyB0pOlEvieRo0=;
        h=Date:From:To:Cc:Subject:From;
        b=mIn5okrDYsQyFFen/MylOX9N6PGnVATKBJbX+dckzaaECO2vMD6+K9HBFhBxwoB7b
         y5cGcx/+DFyGb1rLtsFfKRRGjAcNCSEOGG/A1j5nGSuw/+Iayu+g4SfFEOd8xHMlqZ
         Sd+Jx1pdnv+eTuVYIRuiIe7vxVyelLvm6Gvi5nbqtm80b/gd0Z6b+XG0oadeY6zXWc
         fCPDHGbYAlNz0FRTuIDEzjr4SLhxrKdRuAdzqBAzWLx6KFL4BfItzFFWJdLfsJbyL7
         by5mQp0VsPoZoLevDmTO3ZzTvD7uR387F0+kdr1f7zg/bS+yRPAG3YKrZ3ClNWvb3U
         9IhDb/Kvsj3CA==
Date:   Mon, 26 Nov 2018 11:19:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Kees Cook <keescook@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the f2fs tree
Message-ID: <20181126111933.1b0fb324@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/61jSQ85djv1WbQ9/FxPbGSK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/61jSQ85djv1WbQ9/FxPbGSK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jaegeuk,

After merging the f2fs tree, today's linux-next build
(x86_64_allmodconfig) produced this warning:

In file included from fs/f2fs/dir.c:11:
fs/f2fs/f2fs.h: In function '__mark_inode_dirty_flag':
fs/f2fs/f2fs.h:2388:6: warning: this statement may fall through [-Wimplicit=
-fallthrough=3D]
   if (set)
      ^
fs/f2fs/f2fs.h:2390:2: note: here
  case FI_DATA_EXIST:
  ^~~~

Exposed by my use of -Wimplicit-fallthrough

I am not sure why this has turned up now (as opposed to earlier today).

--=20
Cheers,
Stephen Rothwell

--Sig_/61jSQ85djv1WbQ9/FxPbGSK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7PBUACgkQAVBC80lX
0GyWZgf/ZkYA1gJUFaIJwm03LPobMPWfJmqvZJQ4gqB1pmtAejp4eyePfiIymtt7
XpCLqakTpnh0sDIyUd9AUrhO7DNiCyxrs+13mfF6JlolsF5HhCUrrZt+RhFoZcUW
6in3JNUIwd9KK9vbhuP0XzuKXq0eXubSI4RoPC53wm38nIuPPv7E/IYQ0utmA5oN
0qA2BFJqbHoYW6PIWy9ArITH6R0+nM7fs3zJYQ5AyeUhZ0L8BWk6lsOFrmNRUCy3
pkvVWjch7zC699x7AA5OJ7EntKlvXGoCly2tMO0NfkuF1VmUIFPSriebO7txNTAX
6eVJfGCeaHuc3sqg4cmPzTs8+Xq6/Q==
=gpQL
-----END PGP SIGNATURE-----

--Sig_/61jSQ85djv1WbQ9/FxPbGSK--
