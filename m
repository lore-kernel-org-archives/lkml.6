Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46695C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162C22086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162C22086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeLLRsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:48:03 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:51670 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726922AbeLLRsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:48:02 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 8547D9C0099;
        Wed, 12 Dec 2018 17:48:00 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 09:47:57 -0800
From:   Edward Cree <ecree@solarflare.com>
Subject: [RFC/WIP PATCH 0/2] dynamic calls
To:     Nadav Amit <namit@vmware.com>, Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <899194d1-9777-71ed-70db-212d2983a400@solarflare.com>
Message-ID: <cf6e9449-f3f6-e0fc-8096-eaba6b5a3b97@solarflare.com>
Date:   Wed, 12 Dec 2018 17:47:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <899194d1-9777-71ed-70db-212d2983a400@solarflare.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24280.005
X-TM-AS-Result: No-9.708800-4.000000-10
X-TMASE-MatchedRID: iZSYSp7wuoOoft0ZW3r/iQu4z2zJ4LkwBrGz9f3wJzlc+P5Lb7BNmVBd
        F6X5OpyIRInpfPpZMWE1eCdCD5PKUbP3o+ZlKNhqa0aUozXm0DZhBfGxmdHCggZbeEWcL03Vx6w
        Ad+Ddvm2ZzJUYRez6LSAyr+pzA58YYRidSTcEzWtT46Ow+EhYOF+U6kGoEdO3+Cckfm+bb6CtBF
        nLFqDVm0fcXkmynd8V4O5xOUvdXNHKFqYEr+5FcpyBsp6+TmyGUFxKv+2AmMiNXkYeZoSa+mMIX
        jR0WbWfPMFIpY/dxHMQEXGkOwA4tZM/iGkspNZAB7TqRAYVohZBrawMcuRDTlpbYq2f4jz+Unrm
        t73cm+TkmJ+rSFeO5UHtx5AxXwQHoHkSi6k0xD29sVmyowX1jzpmH5X+z4595DJ1FS+XdBO/F+8
        1OFeimrOyivSg9ieqWKNxvq78azVJI5ZUl647UIMbH85DUZXyXU/IDt4T4+H6C0ePs7A07RQEL0
        GGu6SD5Phyge6hCU+jqSJ1Y0pek9+o5uA442AmL8t4ZzYql0k=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.708800-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24280.005
X-MDID: 1544636881-T54OtJgiQq0T
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A fix to the static_calls series (on which this series depends), and a really
 hacky proof-of-concept of runtime-patched branch trees of static_calls to
 avoid indirect calls / retpolines in the hot-path.  Rather than any generally
 applicable machinery, the patch just open-codes it for one call site (the
 pt_prev->func() call in deliver_skb and __netif_receive_skb_one_core()); it
 should however be possible to make a macro that takes a 'name' parameter and
 expands to the whole thing.  Also the _update() function could be shared and
 get something useful from its work_struct, rather than needing a separate
 copy of the function for every indirect call site.

Performance testing so far has been somewhat inconclusive; I applied this on
 net-next, hacked up my Kconfig to use out-of-line static calls on x86-64, and
 ran some 1-byte UDP stream tests with the DUT receiving.
On a single stream test, I saw packet rate go up by 7%, from 470Kpps to
 504Kpps, with a considerable reduction in variance; however, CPU usage
 increased by a larger factor: (packet rate / RX cpu) is a much lower-variance
 measurement and went down by 13%.  This however may be because it often got
 into a state where, while patching the calls (and thus sending all callers
 down the slow path) we continue to gather stats and see enough calls to
 trigger another update; as there's no code to detect and skip an update that
 doesn't change anything, we get into a tight loop of redoing updates.  I am
 working on this & plan to change it to not collect any stats while an update
 is actually in progress.
On a 4-stream test, the variance I saw was too high to draw any conclusions;
 the packet rate went down about 2½% but this was not statistically
 significant (and the fastest run I saw was with dynamic calls present).

Edward Cree (2):
  static_call: fix out-of-line static call implementation
  net: core: rather hacky PoC implementation of dynamic calls

 include/linux/static_call.h |   6 +-
 net/core/dev.c              | 222 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 221 insertions(+), 7 deletions(-)

