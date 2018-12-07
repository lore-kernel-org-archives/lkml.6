Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425F4C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED38520700
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544157796;
	bh=RxSah6ZqqYrCQnUa0WzpHyjmj7N/23NsGyWgKCkekOg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=UwgEr8Xz9WvE39Csg+KVNp4kugIbHQ0VI1AOuuE56fzXrxtRzubsReaMDtG7wRAuq
	 NQCcvA/bKMTn9cCtl5WG1rLl2Xyg6wIDq1pZvdRcDt8Dwa4RW0Hjqhj9mv10+wecNU
	 R2WviUYFFoANrSkZqXp9rX9YqDktiRIU7IqvtKaE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED38520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeLGEnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGEnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 23:43:13 -0500
Received: from localhost (unknown [106.201.124.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1436720700;
        Fri,  7 Dec 2018 04:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544157792;
        bh=RxSah6ZqqYrCQnUa0WzpHyjmj7N/23NsGyWgKCkekOg=;
        h=Date:From:To:Cc:Subject:From;
        b=T9nJf1bbOcvULs19jmi2zL+keUT26sZUJVmeh8RybaJ4XBNnknx9VAN6hrDbdduv5
         7pSckrlh18D+A1WqcXElTAd9l9dFjvwvWMI3egMbD4qFOAu75yzf78oL3IAWy2x0AX
         Pbk0x2/51vbPW1C70fPfLqOhYy5JnioHuXAAzBO4=
Date:   Fri, 7 Dec 2018 10:13:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v4.20-rc6
Message-ID: <20181207044304.GB2847@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is another PULL request for dmaengine. We got bunch of fixes early
this week and all are tagged to stable. Hope this is last fix for this
cycle.

Please pull to receive fixes for imx-sdma, cppi and dw controllers.

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-4.20=
-rc6

for you to fetch changes up to ffe843b18211301ad25893eba09f402c19d12304:

  dmaengine: dw: Fix FIFO size for Intel Merrifield (2018-12-06 22:53:05 +0=
530)

----------------------------------------------------------------
dmaengine-4.20-rc6

dmaengine fixes for v4.20-rc6

 - Fixing imx-sdma handling of channel terminations, this involves
   reverting two commits and implement async termination
 - Fix cppi dma channel deletion from pending list on stop
 - Fix FIFO size for dw controller in Intel Merrifield

----------------------------------------------------------------
Andy Shevchenko (1):
      dmaengine: dw: Fix FIFO size for Intel Merrifield

Bin Liu (1):
      dmaengine: cppi41: delete channel from pending list when stop channel

Lucas Stach (4):
      Revert "dmaengine: imx-sdma: Use GFP_NOWAIT for dma allocations"
      Revert "dmaengine: imx-sdma: alloclate bd memory from dma pool"
      dmaengine: imx-sdma: implement channel termination via worker
      dmaengine: imx-sdma: use GFP_NOWAIT for dma descriptor allocations

 drivers/dma/dw/core.c   |  6 ++---
 drivers/dma/imx-sdma.c  | 69 +++++++++++++++++++++++++++++++--------------=
----
 drivers/dma/ti/cppi41.c | 16 +++++++++++-
 3 files changed, 62 insertions(+), 29 deletions(-)

Thanks
--=20
~Vinod

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcCfpYAAoJEHwUBw8lI4NHr70QAJlbB3DcZJHPFKqrKRw1T/TW
LeS4+algyy/Zuz4goXAYax2E0y8vZFF0YLFcFZQYtm5aU/fftIHGd3IMbyXLyh8z
GhSYVU3y22Pdyg8vFUih/RV57H8A+z0hby6DPajym5faqCMct9tsSrDrpk++vSBw
TEdr/JSZE0N6SxHKUDKgOww7zR6mJWLfM1v6omU45gAz1SrUaj0pQdfR//w47nLP
NGXEI3y80Y9pm48zhNtZDf6Ns0fc6psf4/1/eqxLgnzcCCoV+76wJVIQsq5hpA5j
+8aelrrev8RB90Dq4ZjOdsx8pELGvZpoMel2sRalEZ+YfaiH1N5SutYIJTVu1we9
h6h8a/nTrdjGRtfRfWvZAjNdIpZ0cK3Pq0Q0JHt0bpjynsfh+Dlp6eepNQxpGMZW
YEElb0+uAnIbElSr+aTjqPnHzJ7+Fe9PNCpW881KI23mzVuObphemwTDwUVMplwU
Dn06EgHDo4+NKkjZtsJF3u9ORurHdfNrqMg1nHMKOFQH/nQjNW1cTshYetCza+c7
SGMdqMH23KFwmeE8GvST64Ts3PuD6yUq3mDhJRnnEt35SKgbcSmnccN+8s3uvVRG
aGLgj2WcvHBOilqQPcxuND8uoY5/G0B+N+9MbKJGC3+UEh59KFDG1YUxG6E7Xbfj
gfYburcYC8QwAu2AXMY+
=Q9R0
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
