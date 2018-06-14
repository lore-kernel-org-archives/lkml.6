Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4ED7CC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F0C208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jRuObx5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F0C208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965690AbeFNOkk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:40:40 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:29498 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965321AbeFNOkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:40:37 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w5EEdw8m010795;
        Thu, 14 Jun 2018 23:39:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w5EEdw8m010795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528987199;
        bh=1gmh1DTQGid/k4Mg0YLIhZBexsqUQ8qWL/pr3Yxz3qA=;
        h=From:To:Cc:Subject:Date:From;
        b=jRuObx5PEUkHLsTr5KVVtZjqvw+XhJ2ERa3N/Z82HHk1sTHLaGwosRxjaOfC2o8FO
         LvinewRPJ27KQAUeNgBEt7eaMRV9LQmngzxL9015mTKbeQzS+O/2zVYTmRYlplIBWi
         5XUUXc4VBVnsQ7DUA9X+29jPElCmu0l5sLZlMIwTki2RQ5mdotUfH1Fg6jqjOVQgxa
         AMrr7V6ZFjjadnAz/qc4OYnBNDVoHlMHrl16ZeExgyqIFHX3ihrh2DTQjQmdsDBeHc
         6mXKvgQ89OSi7RIjZf2gs37cY4dIX4sbbXXabPRWbesaICPXN+RjaZo0HqpVGIQgVK
         EWmnb7FNUsvIw==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 0/3] net: bpfilter: clean-up build rules
Date:   Thu, 14 Jun 2018 23:39:29 +0900
Message-Id: <1528987172-19810-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Clean-up from Kbuild/Kconfig point of view.

I confirmed this series can apply and compile
based on today's Linus tree.
(commit 2837461dbe6f)



Masahiro Yamada (3):
  bpfilter: add bpfilter_umh to .gitignore
  bpfilter: include bpfilter_umh in assembly instead of using objcopy
  bpfilter: check compiler capability in Kconfig

 Makefile                         |  5 -----
 net/Makefile                     |  4 ----
 net/bpfilter/.gitignore          |  1 +
 net/bpfilter/Kconfig             |  2 +-
 net/bpfilter/Makefile            | 15 ++-------------
 net/bpfilter/bpfilter_kern.c     | 11 +++++------
 net/bpfilter/bpfilter_umh_blob.S |  7 +++++++
 scripts/cc-can-link.sh           |  2 +-
 8 files changed, 17 insertions(+), 30 deletions(-)
 create mode 100644 net/bpfilter/.gitignore
 create mode 100644 net/bpfilter/bpfilter_umh_blob.S

-- 
2.7.4

