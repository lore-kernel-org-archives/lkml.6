Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E46BFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC5D20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuyLCMB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC5D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeINROa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbeINROa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:14:30 -0400
Received: from localhost (unknown [122.178.224.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D125520881;
        Fri, 14 Sep 2018 12:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536926419;
        bh=JCuF1Cfzsp/kkOXnoXnRCrFDk1GjdyUTEbr/75VeJVU=;
        h=Date:From:To:Cc:Subject:From;
        b=iuyLCMB+xWxFfZ7y4DPH5EApJ3EDrKkIFoMz+uPQE1mEeWNOe6OFaj8DL+KGbhH3H
         zV36QPBydinHw1+2PEhloVP9P3UkJ773v4a6jy5DbmTiXTqbiG/gyxF28Q1Lqhfxr0
         iKD7SAtdLt2a4hisMzHd0rIlV9dm/1Gi41bXgxBI=
Date:   Fri, 14 Sep 2018 17:30:10 +0530
From:   Vinod <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v4.19-rc4
Message-ID: <20180914120010.GB2780@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please consider the pull to receive a small fix for mic_x100_dma driver
which fixes driver to use devm_kzalloc for driver memory so that it is
freed properly when it unregisters from dmaengine using managed API


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-4.19=
-rc4

for you to fetch changes up to 111b009f7e8bcdfc8d565b1f0e3ee5072bb7490b:

  dmaengine: mic_x100_dma: use devm_kzalloc to fix an issue (2018-08-27 11:=
16:04 +0530)

----------------------------------------------------------------
dmaengine fix for dmaengine-fix-4.19-rc4

 - Fix mic_x100_dma to use devm_kzalloc to ensure memory is freed after
   use by device manage dmaengine release function added in merge window

----------------------------------------------------------------
Huang Shijie (1):
      dmaengine: mic_x100_dma: use devm_kzalloc to fix an issue

 drivers/dma/mic_x100_dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Thanks
--=20
~Vinod

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbm6LKAAoJEHwUBw8lI4NH6NEQALnfyIi7rnpJ9Wc9SYVEbcLn
Z1KceCgz3T2D+maYeSHKP83wt2XsOHwfBuiJHTt86ecOQAocvQx6b/AjvAj1Tk2B
+5QMeZubeVZA7qIPyaymbYpwL0u3R+x5l87565PXUTZb50AcJQGWh0BxDD1nCx6r
MSHMNgMc2sHnSkKLY6TZiQJKKHmr9IODvbeuh/K0EXAn2/24ZdyZouTm7GyPQwHI
iQLO9sr0FRTnhaNCtIvB1JCIuJK8KhlRxnDSb6uokOr690g8GfdMzO5lQSK5/S9h
AimIbAbM7edZ6DZPi5wR8LkUQsPmzCtOQSp/s/EQzyNeykPJpBzEa/s9gbcz/GvH
Hu7V4Leaz+F2iZQB2qNp0zULxFAOIMYMGFDEb/8F0pKz9FYjs+U5elttR7OPtehK
NLhyaa4v9ZWl0Y0mvsT92oJVB3cbCCSJgf3maCsxZr6d7UfqPAKG4GvA3YUr8nLF
xI/FtddZQ8TrMBF/OlJkHXnfhZ3CWhfXpBagqKtN43nVZKYFSvOPRij8MIMGpQJ1
UAITDYBviosAWg93BepPfOjfym11L8jUo8pRqfRZNGNy7EEo2zLVf0+MxqJrl/8o
qnKOm5F9+gjXrtVx9tA9MniF2ywzugZwvJ9uBKJIk1n0IOD7TSWlS4FV+gyr3uFA
ps6EDhRCC8LLWbwlqjH8
=BHo5
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
