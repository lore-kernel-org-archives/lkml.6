Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A28C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82815208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="iYjT2emj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82815208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeIZPsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:48:55 -0400
Received: from 8bytes.org ([81.169.241.247]:53676 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbeIZPsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:48:55 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 11DB86FB; Wed, 26 Sep 2018 11:36:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537954610; bh=nr8Zh7CT3hA/MHDrplbEtre90o32rLCY6sX+L0DHd4A=;
        h=Date:From:To:Cc:Subject:From;
        b=iYjT2emjUo9HO4+NXmp/MrtS5kSHfW6mJ4FMxVpWR1jjdcjujiUkW5YA/m+90S7Fu
         HsDGprULdeNp5la+9bRj2BveRDJfP/vWRQ9j1J/xJKhsMWP1c1HOvtvxMlGpat60uX
         q4DjAHDJz9VAB3eVN1ubM2koEXUbNcQWDpgqZy3k9xyiw3gdOQcxV2L1USrCq9nFXG
         2x+2m42k24n6ABkCZ+ymXCMw3wEHaESZ4XFjU0nKtIjz9jQMueYEN+xZYnT2dO1WhD
         2wjguGlI1fxfAy8kVI9W+2eBRO5G1LLyCBnp6Qb/saR0vptkVJC1hVohjrcj5eoN56
         zLOd+IisjSsAA==
Date:   Wed, 26 Sep 2018 11:36:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v4.19-rc5
Message-ID: <20180926093643.o67rf7q56fvfcrpt@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uywm56sl3lc6eur7"
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uywm56sl3lc6eur7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.19-rc5

for you to fetch changes up to 5ebb1bc2d63d90dd204169e21fd7a0b4bb8c776e:

  iommu/amd: Return devid as alias for ACPI HID devices (2018-09-26 09:41:11 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.19-rc5

Three fixes queued up:

	- Warning fix for Rockchip IOMMU where there were IRQ handlers
	  for offlined hardware.

	- Fix for Intel VT-d because recent changes caused boot failures
	  on some machines because it tried to allocate to much
	  contiguous memory.

	- Fix for AMD IOMMU to handle eMMC devices correctly that appear
	  as ACPI HID devices.

----------------------------------------------------------------
Arindam Nath (1):
      iommu/amd: Return devid as alias for ACPI HID devices

Heiko Stuebner (1):
      iommu/rockchip: Free irqs in shutdown handler

Lu Baolu (1):
      iommu/vt-d: Handle memory shortage on pasid table allocation

 drivers/iommu/amd_iommu.c      | 6 ++++++
 drivers/iommu/intel-iommu.c    | 6 +++---
 drivers/iommu/intel-pasid.h    | 2 +-
 drivers/iommu/rockchip-iommu.c | 6 ++++++
 4 files changed, 16 insertions(+), 4 deletions(-)

Please pull.

Thanks,

	Joerg

--uywm56sl3lc6eur7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJbq1MrAAoJECvwRC2XARrj8fIQALkXq/q5tpPoQ0UGuHotzsmj
fNcMbQjNmQSejG5d7P0dEiGm0hCTz1B9+g2p2obRcKCPXtsSdUqzBvZabBsjOulg
OhHNjUTU8f4GmZSzI1spnATv+9SejsaPZ1tiESTZ/GIOt4CcTqBLaPhjsrC/Mq+3
EV0wL3saPoDj/AhLSZiBDrR+1uCzdnz67f4NAvk9KdLJkzSTbUACfkOoOr0j1zDs
rNUKUuB2/eSIq1m56po2Je+IEkCK9goCi1udHA0zDVtPUhvqL/b9IhSJAWrnTT+x
m0f9zxBah6zFYY3KXARAXAK+nnBv2tHIeBw7/0OC6AHCIOiU++ILrKBFQovqmXU2
0nr68mBykBpWJF4/1Izgq8KPBo3JH3LN0SS4tDvras+Yuv6+239Lvyup8v30+0r0
DV86iklqcEAceRSo9fdylPFXg28V/HLQ2qreDvw70gZDNyAuqC+3JLbvW3nqEo/a
cO/cbhD1pcgqSMtHA/gUJE5/hqam3uth1DGTbnoK+Dgydyul/OA9kHp3LiqLwqug
zQSaUqLUi7z5gHqLXYLFByA0juaJAhFa0OVHqxLMKH+mCeHiTPHdZ3ZjLoVxszey
zdzmw64yQv7vDRD9n370yDlvdFI0DFdbjZU4VM5+XwnFLYqmvs9dcHHTuyqt35cp
PgFyZr8wwDQwVQEIOATs
=OzWo
-----END PGP SIGNATURE-----

--uywm56sl3lc6eur7--
