Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8BCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6059420665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547088975;
	bh=DT6sErXDS5DXCOla2YdTQsFjT0WqP8p+gPhwhxL91zQ=;
	h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Subject:List-ID:From;
	b=zTY0dbw5ZebAauUj+TM60XsN/oPg/31t1a9aVuAHig4Zn+DGMdZTNnrtKAC95MWFl
	 CHQpGrNwP+/PXMxONCAzwpn5DA55VxFly7Kd2N0oIHkiwObMUjZVLAd2RUuqb20Qkt
	 wS3U26xc/UKgVPAHWwS6MTTgxWxOAXaKrXLNu22k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfAJC4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfAJC4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:56:14 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E42020665;
        Thu, 10 Jan 2019 02:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547088973;
        bh=DT6sErXDS5DXCOla2YdTQsFjT0WqP8p+gPhwhxL91zQ=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=mDQ/wkw08ufkF0eWdPNQHLKd4p/FQX8TWhtBiflfI4GwoHG1CtaLplXdupa6vdCbF
         cOz8F3JU+OM96L/76EGAUInWJSXlxb2kqv4ibKn7EaAYUG/qBDBdNVpQS1wkYKVKqN
         /Gib6imAhhv0rlGLQbCypNq11rLuGQnNCGcn8F6M=
From:   Sasha Levin <sashal@kernel.org>
Date:   Wed, 09 Jan 2019 21:56:12 -0500
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     kys@microsoft.com
Cc:     haiyangz@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Hyper-V commits for 5.0
Message-Id: <20190110025613.1E42020665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to b5679cebf780c6f1c2451a73bf1842a4409840e7:

  vmbus: fix subchannel removal (2019-01-09 19:20:31 -0500)

- ----------------------------------------------------------------
hyperv-fixes-signed

- ----------------------------------------------------------------
Dexuan Cui (2):
      Drivers: hv: vmbus: Check for ring when getting debug info
      vmbus: fix subchannel removal

Vitaly Kuznetsov (1):
      hv_balloon: avoid touching uninitialized struct page during tail onlining

 drivers/hv/channel.c     |  9 +----
 drivers/hv/hv_balloon.c  | 10 +++---
 drivers/hv/ring_buffer.c | 31 ++++++++---------
 drivers/hv/vmbus_drv.c   | 91 ++++++++++++++++++++++++++++++++----------------
 include/linux/hyperv.h   |  5 +--
 5 files changed, 86 insertions(+), 60 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAlw2tCsACgkQ3qZv95d3
LNyATg/9GIHd9dW3B7YcCQdxgnFJWNtEzHrPSx+qTstQE+wh3xD6Mv5W/81nfcYq
3FBlmFKEMTl9UWpVIZLF2aAKGFahlljJGNAmU2VSg9UCJQ4AtPKDWOdrn4o9go6R
VuAvkh0CXGyqZsO7rGUBnKLM3zA38eGoRZpSgAKe9pZfc4Uux7ibUnCzD2W2Ds/h
k8qYZDcmLHmQnqW4rywnkJ/YLe2wkhPEUYpq+fpUBmGU81S8QrSfBgDPrpz1NpEx
oBfZTwSx0Rk1u28+u/KhH7mOo5BnyS44MtgRmHdaEBhyGTP3gpkQgeZC5+hEV2qi
9ALvUNV80uh1Rv4cIHnFjGf8oFbdgFCVq/LQh+zYuJ8gsupoRmJjMJI4DmV1oviB
HhXE0rBmGHVOSe11dWyZOQR344pM0yxiB9jOooL54SKrulN8uidPUAETlsD5pfWc
yTF+3g40mv+hLAgxLu/j20PJmkIB2lR6m6wNe8+djnDKgs4TQLkTBBhJMaH1Uaf2
yad0jy1JTH0V0TUhCmvs49C++0OXGyS6N4yrNWISKGt+wo6c7lGMFJKVxKAGFkSt
NRw1muOa0AmypssbTqe6DCjtaX+q2U+/d1t85LdPIEOzrH4ukunVoXtuaWCXu5hQ
8cV93VXemBUaRurlCh2rrxt0p1RbOG+B1SsHAYTMOfQ0r3RHFfI=
=WONp
-----END PGP SIGNATURE-----
