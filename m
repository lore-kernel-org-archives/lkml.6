Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79EDC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1B8217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546524543;
	bh=JMhPj3wqgoXUoSAP/CJUd1VFq4FYQU8pUystKu7FeDg=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=r9MsquDyHL9Lb8tzHEUASqZ/vholttRPjOLlu97ZzTTj0auSXvH29m6IRdMWnyobW
	 tA5sKpUXOPQiizmZLcs2EDJydW/g33uToKx/iqK4s2yLBm4EBX+lWr3X+CqIeqR/jU
	 VAwHNS8D2YIp8HJ7txfSjNdeCLLag67ZhG9Yyh3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfACOJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfACOJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:09:02 -0500
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCAE42070D;
        Thu,  3 Jan 2019 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546524541;
        bh=JMhPj3wqgoXUoSAP/CJUd1VFq4FYQU8pUystKu7FeDg=;
        h=Subject:From:To:Cc:Date:From;
        b=yxsFuH0+3ZA9oRK9mrQdYCCO4RUa8M9tf+MvxQ9qi/sPqfZNit7NQaCM0XjyvBYGN
         u4xolaTtJ3KDyUg99ZNIM8JuRHGl8bGc/T+VZD50ms/3Fyif1mvuIe1NtgZlnldAgj
         TqWQu3zZfDlrccgyHxtk44VMM0GD/7vLAGWm5hgs=
Message-ID: <ce790e2af03fadddc6ede9de94a59c72d13cf591.camel@kernel.org>
Subject: [GIT PULL] File locking bugfix for v4.21
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Neil Brown <neilb@suse.com>, Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 03 Jan 2019 09:08:54 -0500
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-iTLwIh0DaZWh3DyMkW3k"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iTLwIh0DaZWh3DyMkW3k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 8e143b90e4d45cca3dc53760d3cfab988bc74571=
:

  Merge tag 'iommu-updates-v4.21' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/joro/iommu (2019-01-01 15:55:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/lock=
s-v4.21-2

for you to fetch changes up to bf77ae4c98d721a9aae3840970d46669a78e034a:

  locks: fix error in locks_move_blocks() (2019-01-02 20:14:50 -0500)

----------------------------------------------------------------

This is a one-line fix for a bug that syzbot turned up in the new
patches to mitigate the thundering herd when a lock is released.

----------------------------------------------------------------
NeilBrown (1):
      locks: fix error in locks_move_blocks()

 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
--=20
Jeff Layton <jlayton@kernel.org>

--=-iTLwIh0DaZWh3DyMkW3k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAlwuF3YTHGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFXgfD/9OOup/fnSQHuNK8LzT9Frf2XwYNWbi
Ai1eLJa+3LKEe5jnoFhVW5CvRFa5+tazVPlnIcE/VTUKUJJq/feZSyfKGRIoE3R3
q1qqYn3zIzoMBQlQHnzvqhiMqM2ISGp/OmSMZ7x6nYAqvxkfQy/NCAh0x4Ka+Q1Q
yVWD+8h1hY0SBX6QKd9HzUqfB2zfquFd/R95v0Ld6nnxMuD83BLzT9lra6p+l5/J
TDRzpW4Y4u4R95nAZCBlgG0p42mum4HIPw2zaOIFsX5p0b6trydCYDTADYPEMDQa
rMlWEPTyLfOwqlUYjl6IL8AfIS3/nkyGfuDVqp4j5YIuA92t1nH6Kfuhd8m7w0eE
MgOkAwXC2O8fAplUq79M31hkZKSEfi8dhlAamxLoiT87NCL0khhvG6+UleA9wSk4
Q6dyOigMXteI1NcvmMug1j68skw7WpOQ2B09+LmtoGhdNzBnJgzpqomzeXTXRb3S
zC81lhn78hq3sb5xZuw1UEfngfXvPaghX0R3V5+a8ugmj6p6PGxkHk/UvSWaoQUz
ednXD1biu/vb77b7K72PUb7bI7heQPlWBFQdrh+tIpZh1nbF6Hc4N2TlEMWdSAUI
DQ5uLTaQw4DvLJveTtgTxhkyi3CXlUlnWCr3NGpvaTNa/qFsz5ALkNZMmeL3XO/u
Qf6HuR68Pan8VA==
=9pjt
-----END PGP SIGNATURE-----

--=-iTLwIh0DaZWh3DyMkW3k--

