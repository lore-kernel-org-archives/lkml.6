Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26780C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E943F2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547133875;
	bh=0lvzHpRemrxbnDGaD/Y+C9h2z448bnSaQi+pz5DOBwE=;
	h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Subject:List-ID:From;
	b=n0SUDmhO7J/HLsBmGQdKnPl7Jcm0Wp8NAi1wRI9Tl00uY1PfQOaej65eegqrpzfrM
	 WyCRLV1s4wnzSfwZRA6QIQSB4k2SbUqVjrOfZ6vgIq964kLdk8zQKSFr1dzjPCedl+
	 6isgdcb18veItQ/EO68lAvMsab3UG31XCagdHzqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfAJPYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:24:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbfAJPYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:24:33 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75529214C6;
        Thu, 10 Jan 2019 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547133872;
        bh=0lvzHpRemrxbnDGaD/Y+C9h2z448bnSaQi+pz5DOBwE=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=g75oSHfFEOl64g3maFlB99OvF6M7R5iDNouvDHVtD6om8GpJJQQvN2ayC3HaW8fn9
         9pwi7XckFaZO2QKeOGgakZW2FFGJGtkFgckDF3n4KuishrmP0+NQ/MKaF4e/VUWxg2
         QZmj4MfcbAmm14eFkbPejGoTWtKUpHOAWP9bVjv0=
From:   Sasha Levin <sashal@kernel.org>
Date:   Thu, 10 Jan 2019 10:24:31 -0500
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     kys@microsoft.com
Cc:     haiyangz@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL v3] Hyper-V commits for 5.0
Message-Id: <20190110152432.75529214C6@mail.kernel.org>
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
Three bug fixes for different parts of the hyper-v code:

 - Fix for a lockup when changing NIC's MTU from Dexuan.
 - Fix of use of uninitialized memory from Dexuan.
 - Fix for memory corruption caused by ballooning from Vitaly.

All 3 were tested internally.

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

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAlw3YyQACgkQ3qZv95d3
LNyE8w/+Of8iNo0BtW4BQNIX+vF2jtP2fzvqyZ01wGC2FHR0MRiwLwG24yvZ3z/k
xqihTkbK2aiZ2r1LT9Z3nkd0xxpkj5GBN/9voW3xJDukimUlor+wEBl/TID1WdgT
sl4u+pI/2kfLeWYf9sCkoO0oZ/AiRmuC0PG4tLB8o21y13Ngd1lW1cIpCFciX2OJ
LnNgEHi5wfLipEj7wJEKJPh095CaDtBpsnw++5Ef5pYbJBVqH9QPtqWSfCWY0+vA
PEQmpij4VAtjXhyPixoc8bi9AxiHw6bqRk94jowyeH8M5Cn1gX3uY0hJmhjVPYSY
6/odsGf5ZUrnGYBd0DuJsdQwKKzaZGbL4M6dnJML1yKsBnU7lzfHTW8OaE8ob9oX
13lBF9ii2YOiPdzB1SeQ3unnHYyyVlfuYGJwKM+51KU2BWnSWsq7Jaw6MeNEXwqK
T1Deiiqmg5hdRTlsmS77uywkkrcS+Y+Fu9R9RFeddYj/gTekyWCDhZJ7Sf2AtkXP
bxjlPwFuTmOdpz6VaM6kvgJLA1VkalSHmf0dXKlYibLiS5uonVVydYUOv6wMiuJc
mh6XeVv28aPyYAeEC3dkITqAAPx1Grijp6k066cvcIYz2qD31dlKi6OXjeuIlHLN
O3ddwIzGTPrTTxtvj9L1aIaeRxVwNdFFi1XZjzvk2vGsoOj/gGk=
=SmAD
-----END PGP SIGNATURE-----
