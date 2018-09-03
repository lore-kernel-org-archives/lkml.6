Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C1FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B9D20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pUeWcc+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B9D20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeICOXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:23:04 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:37052 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeICOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:23:03 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w83A2AsX026175;
        Mon, 3 Sep 2018 19:02:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w83A2AsX026175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535968931;
        bh=PXjL+SIa1nuOWGclDXrdVYTvPL+0A8B86deu6ZFzxRI=;
        h=From:To:Cc:Subject:Date:From;
        b=pUeWcc+Tr+d33r33xPLsfK6PVgfA6wPa3tXESiOHL+05IMKsKstbERiKjR3WsTXKT
         6myDsH3tKZMzD8j2GVdewSGOrNiKC493HLjitSqWdYNsXSDQ4I/u6LDKyq/k09Uwu+
         wyJMaMTHxgA31rLCed8Sdz2Dr5mqOUmXrf2qILVnqwpLqw6yBP4gzLdzNLoSHLd9YL
         TIlABAr99WqoxgLI8lCqNfBSlUgZGDQk7A2jRBTDF8cIPZY3djKWqcsQfpVjPQQYyy
         mkmWSXizW5FA+0SG7+8Pcmvx0nVvAMPNQJ32G1FCyedgeEmPCIlXnCdL/MTkB47WkT
         B5W/0In2fRcQg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        =?UTF-8?q?Michal=20Such=8F=AB=A1nek?= <msuchanek@suse.de>,
        Takashi Iwai <tiwai@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [RFC PATCH 0/3] kbuild: support syncing .config non-interactively and record ARCH in spec file
Date:   Mon,  3 Sep 2018 19:01:53 +0900
Message-Id: <1535968916-9159-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This work was prompted by the criticism about the recent Kconfig change:
https://lkml.org/lkml/2018/6/27/254

I may not fully understand his concern, though.



Masahiro Yamada (3):
  kconfig: support an environment variable for non-interactive
    syncconfig
  kbuild: rpm-pkg: hard-code ARCH in RPM SPEC file
  kbuild: rpm-pkg: set KCONFIG_NONINTERACTIVE_UPDATE

 Documentation/kbuild/kconfig.txt |  6 ++++++
 scripts/kconfig/conf.c           |  5 +++++
 scripts/package/mkspec           | 23 +++++++++++++----------
 3 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.7.4

