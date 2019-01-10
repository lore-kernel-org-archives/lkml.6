Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C43BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A5E21773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547103950;
	bh=mUgduJWoYcBx1YfLRJQKwOKB6QzQ4Y1grRn9hoZxVCE=;
	h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Subject:List-ID:From;
	b=tQLKuWUG69YeobhhdQf3ZDDR5Ce+xUskRk+rG5KwIwETPf0GPpxBNV9hLQk+TQarP
	 03lJ/U26hAKOdN5e7HTlhNWsmdTA+CaRLtmFuG0ApuYssOQSpbAOVkuiR9yozsOA0t
	 1Exld6ClLHoy21jllXgsUTENVqR6/L6LnK0l9nmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfAJHFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbfAJHFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:05:48 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE9A620657;
        Thu, 10 Jan 2019 07:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547103948;
        bh=mUgduJWoYcBx1YfLRJQKwOKB6QzQ4Y1grRn9hoZxVCE=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=0y8GtkFuCtt6XYtQAE52aHBc3v9DQlPw3RIq44p1u3R/l8+tWBiNeV56hGeBLifLG
         EEskRyrC1EeUUSo9hkvEDb96kN5FDEnAAkE512xJR8FpninD9Eqm/dDYa/lUZ6Ft9e
         kikUBZ9DjXAStIp2mk6rsl9xF6X78Z8upydN66zU=
From:   Sasha Levin <sashal@kernel.org>
Date:   Thu, 10 Jan 2019 02:05:46 -0500
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     kys@microsoft.com
Cc:     haiyangz@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL v2] Hyper-V commits for 5.0
Message-Id: <20190110070547.BE9A620657@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Greg,

Three bug fixes for different parts of the hyper-v code:

 - Fix for a lockup when changing NIC's MTU from Dexuan.
 - Fix of use of uninitialized memory from Dexuan.
 - Fix for memory corruption caused by ballooning from Vitaly.

All 3 were tested internally.

- --
Thanks,
Sasha


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

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAlw27rAACgkQ3qZv95d3
LNyvPBAAiL6q801s5CN1EmMO2VWyEW5UjUuG5loKcB1/0H9D1ZfcEkq3U3eTIGk2
/OU2YNYz3Wz6zlmWum6Qf5EtvPZOmLDjVk3hozCyIz1w0DgNizFbXfa8sRqlYqPE
PzWX25bJwlSOG17QC2q9WeeZ7YGwe2aNc+qIUncmPYdSCkIGvoEm2WUKhvT3Tgvv
gxRao0mQkErjvVu6gkVhnDI7tv7qNPkrl6go/wOpZCoVNrhI2infR9G3hn2cOTL5
1yCV5Un2sqI9ZQ9/lJJ0qtSPs7eW0DGtayuYQqUNUKfProQZJGd/eAB5eEvts0f5
AdaU91E16/NK+U2pBOurYeLO9Kb7shOE6/DOerUzYVOg6KN//6+ZWSvnjM2/NDr5
nfPh6tUUdf7MtwQS9YPhqQR/teP/9s7M5tIlikHZt5rLTUvNq7QQxI9Twz0tQEwE
G+iBrUnhShKDW60c6sxUDbG9BJiszFDrnImY5YEZM3MUYlxLZ18ROpUNyk7SRdUc
jojqke17DttzlWIYW4xkIuwdHpMwIQ2aCqKUmj4awjC86f75w5viWKZGuiUEDuNz
Xw8twUNGYTwO1jjjrQLL7UCAygXnCJAjlp/BsXfnpzOQrXu1IE4y33t5WK+2Pw87
N+ATh72/IzsOHcvokTBeMrVrudW+vFLNwvbO183nYbxdnt8GSF4=
=/FGz
-----END PGP SIGNATURE-----
