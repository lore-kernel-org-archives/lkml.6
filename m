Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B500BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8515E2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8515E2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeKAKxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:53:43 -0400
Received: from mout.perfora.net ([74.208.4.197]:48611 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbeKAKxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:53:42 -0400
Received: from localhost.localdomain.ziswiler.net ([188.155.129.42]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MV4A7-1g3wiV1T0H-00YS8J; Thu, 01 Nov 2018 02:52:42 +0100
Received: from localhost.localdomain.ziswiler.net ([188.155.129.42]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MV4A7-1g3wiV1T0H-00YS8J; Thu, 01 Nov 2018 02:52:42 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 0/3] clk/serial tegra: uart related fixes
Date:   Thu,  1 Nov 2018 02:52:27 +0100
Message-Id: <20181101015230.27310-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.5
X-Provags-ID: V03:K1:ksI8/gSo/km7aS18ZGVWhEimC5c9P1mv1HOsuuJehGiYb5pHjDF
 R4kBmNItzwAW6uFfi6QoOH56qtNG8U6egUrF/LImKWK3krRxnlEVkLKvZalp+5SnUFBRRkf
 5CnYVT9NH0CTfIfGed52bYxtBOYOxvdS5YGLtT/sTe8fmumOZ+JvClbx71St7B7NyL9XVp8
 jchHXdFurN4bhHRx6fRfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2m0vJmH542A=:L26udLIwMob/Vhvwhbql2Z
 ZEwnLHsGumEJN/UD/U7Q/ytATU974z337h2x/oMFY1k0A7789QHC3cxkdvn71NUTjC4eoF/8f
 tbMd50iAKJcsgee0rJopK8TWv/gBSwSQ2feEKkvpaebw3KjtTdSYgkj4cRH7HyOUCozaLtxm3
 05gl2wCM4FgSwnohPbn08zZs0wxIVapbwfnN6gevd6syTCKMKk7nDPZVOAoPz5PIkohwPDLqa
 qNmuYtPB8JryfJUaQjeIRJ/gcFSDBA2G0nDIhOtzV3WfWPhCg2LWVAXr/LLjmeYx310etPCwz
 zrmsasTIC2fTQjtZTK650kKEilS1DVCBzi6p3tP+WpE5qq0NEUR2fqHk+f4rEvjhj6kpZjv2u
 rJsTRI4DQCBSh7eocBcKWh10eODpeSLe+gRxKixOnex20BRqj5uNQN/+MmCTUbV8u1dO4GIG/
 lECdtlYWuUsWyi8otffQjrnpF+lX6aXz1q0wKiqVs7xA7bY3DeSx/NAQRN16Jg55PozUq0VQt
 q1+tfvApsTHB0BzNH9CHgR41eGHNquMYlfixQgOiwxYo+9zqekHxbaesb1c0RHtRbao61dW9k
 fZY65iMISN6NjQW233/zkqaKNptxFSU/kSZcnkCj6VY7l29GgYD7DE4p0aZqrYsIvhwkuDWRP
 L99mqdO+xQ08iFwnhQ/+SbffJqUSsFomH43n31k3Jgjk91gZB2gejbn8XZhvY0+BrzNo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series features some UART related clock issue fix and clean-up.


Marcel Ziswiler (3):
  clk: tegra: get rid of duplicate defines
  clk: tegra: ignore unused vfir clock shared with uartb
  serial: tegra: fix some spelling mistakes

 drivers/clk/tegra/clk-tegra-periph.c |  5 +----
 drivers/tty/serial/serial-tegra.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.14.5

