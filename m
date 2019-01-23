Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2339C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BB121872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548268233;
	bh=Z0E1QpdwJ46nm6DwTwerluIAiRPairjZbx8gQLnUpLA=;
	h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Cc:Subject:List-ID:From;
	b=X6x48QMzyE8vXy/kanLzWJ5mIjFcxCTlNKO5ODCaqCwwDs0Txcup2nXet1rUkNtxh
	 zwj0hiTLgIO9mBAuuTw9PU6lX9P/ibnvXLuVYOMWO7VOFyDWS1FN5pYZPLpfGwmxRa
	 PKGT6Im9x4wk9hlyOzzRGuTxOsI6Fm4LsNiHfRfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfAWSac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfAWSab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:30:31 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CFEE21872;
        Wed, 23 Jan 2019 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548268230;
        bh=Z0E1QpdwJ46nm6DwTwerluIAiRPairjZbx8gQLnUpLA=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=Dsv4kB48wR3QPRcSzkCx7KVV+4rD6KTxPr8PqAc3G8VJgYEHoPXExItZ4oUi1BgU+
         +VCXSG8Y3Hj/VcLTn2YTF7+1LyJDQSlA2W+fAj9FC+peaQyeh/LGoYpel+VRmR/7zu
         rBQ5ObOZZ+yfAKsQjlXKlgDR328bnmEWBBAOQjEs=
From:   Sasha Levin <sashal@kernel.org>
Date:   Wed, 23 Jan 2019 13:30:29 -0500
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@microsoft.com
Cc:     kys@microsoft.com
Cc:     haiyangz@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org
Subject: [GIT PULL] Hyper-V hv_netvsc commits for 5.0
Message-Id: <20190123183030.9CFEE21872@mail.kernel.org>
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

for you to fetch changes up to 52d3b4949192e93b948daaa40678fcd4b94bcbd0:

  hv_netvsc: fix typos in code comments (2019-01-23 13:21:34 -0500)

- ----------------------------------------------------------------
Three patches from Haiyang Zhang to fix settings hash key using ethtool,
and Adrian Vladu's first patch fixing a few spelling mistakes.

- ----------------------------------------------------------------
Adrian Vladu (1):
      hv_netvsc: fix typos in code comments

Haiyang Zhang (3):
      hv_netvsc: Fix ethtool change hash key error
      hv_netvsc: Refactor assignments of struct netvsc_device_info
      hv_netvsc: Fix hash key value reset after other ops

 drivers/net/hyperv/hyperv_net.h   |  12 ++--
 drivers/net/hyperv/netvsc.c       |   4 +-
 drivers/net/hyperv/netvsc_drv.c   | 145 ++++++++++++++++++++++++--------------
 drivers/net/hyperv/rndis_filter.c |  36 +++++++---
 4 files changed, 129 insertions(+), 68 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAlxIssUACgkQ3qZv95d3
LNyezg/5ARp4trV4xYrKn9KY3ctgk2MQMBWfJyTnJP/MMwH9U7c0c7xlWke+2+vp
B+9tbRdPU1amHMSeounLiQNrkqBQlqYUtJdTXx5Yq9r76IEh7qTkDsMdBOq1Uxpn
DpmcbfelylTEcmMj8XbYokAKgNWdLIJZbcbYQjuHv+2pEO6DfH/SnB1zh25dHWNt
TO1zXRiTISJN2yLD1rayUzvx9KwMiQAfhMCtvfo8X/8us5X96WH/Isvzjfuon1Aa
iq7PuwV8gm2OFFzR+mlLoE33TmtytvUyWOdBDj3I7QNmhvCa4uMlJrFh0smML3yU
SAtBLDGkCOsREDVCwe7R/P2NFvAf8gCn1NZ3Vnaywwb3nvgUTdqUZqEiv3T7cePv
Eossh4hhKDWTkBxk6iSqP2L+SiSYbg845TZTP+iPhgBGEnlEn04YIUdftT/i5sYE
K1awGnE8DOmaOFhgG+rpHvBnOhb5azepTpbs0ajxAVec6+vVXtdKf3STa+xqKOOd
JS2uHj/aF+PeS1FuZbaZxfBEOzy7PVP6wAfu6ZkzIlpy6XKXnyiPvW8zRvs2YqfG
0XsKn7e/hZelZ2bQXLNllYyXZTNh54E/vvfC/4uGrHSgSMxBuW2N5s3oC75VJtLw
II+2oIsRuUU8v5EwvyNxsXxjvIU/BxNAYz9Vb5CQE3gaxjOAQgg=
=OV99
-----END PGP SIGNATURE-----
