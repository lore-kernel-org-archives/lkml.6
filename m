Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518F1C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCDF20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="afh2DtTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCDF20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeGLKM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:12:59 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:47653 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeGLKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:12:58 -0400
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com [209.85.213.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w6CA3wB0032015;
        Thu, 12 Jul 2018 19:03:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w6CA3wB0032015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531389839;
        bh=qJizQwsYHUTt3kO3mClL7d76CP/ebTR37RRTe4WQ5H4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=afh2DtTwR/XZ+7h0M3+R67SIB3YzHI+73Ie/o1NoQPiwXW1gQHgOwB13eOecnTdVn
         3FASfaMn37/hL8fN6oqya34o6CI8nGhBoeNTgpaumOdaNIdFi4XnCJU9ZpYcI8shHv
         YNH6em7hLUFSKiCiipLlYhmiSy9kjH9muqi9h7W0NRcM/rglrDZxy1GIjjxEMkOpbU
         vNHO3Cn9GhlHzPiRtB+dAI+mIdeoHHhulZDJzAqwT/w8zLSHapxeUXIM7iTE2BrWnc
         Vak5ufIH2wkg/BdsDkCzh8GcisMZAvXnEFAsFAuK8Or01BYgecuscy3u6yuOTrTapZ
         fDbOQ0nI+hdgQ==
X-Nifty-SrcIP: [209.85.213.50]
Received: by mail-vk0-f50.google.com with SMTP id d74-v6so16020277vke.10;
        Thu, 12 Jul 2018 03:03:58 -0700 (PDT)
X-Gm-Message-State: AOUpUlH7UJ3jHV8ZMzDtU2NxV5r3xV9XJvMmjaw8H5zo40pCBkafRKOi
        adktrgSOgJWnxqjFERNxxrU4jE/WHH/H7q/BfxU=
X-Google-Smtp-Source: AAOMgpdQujQWdL6nqcpqoZ/bT84u8ahBUijJr4402E2EC9g2Y5kqI5O6EWhkKzymj4Cqwmhpq7as2zmwTx9oh+RnwFE=
X-Received: by 2002:a1f:d982:: with SMTP id q124-v6mr795925vkg.166.1531389837667;
 Thu, 12 Jul 2018 03:03:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 03:03:16
 -0700 (PDT)
In-Reply-To: <20180710004602.21599-4-labbott@redhat.com>
References: <20180710004602.21599-1-labbott@redhat.com> <20180710004602.21599-4-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 12 Jul 2018 19:03:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNbV1afjkoKfgvjijkhkQN3-8or8Aq7Mm9X2xiemiXrw@mail.gmail.com>
Message-ID: <CAK7LNAQNbV1afjkoKfgvjijkhkQN3-8or8Aq7Mm9X2xiemiXrw@mail.gmail.com>
Subject: Re: [PATCHv2] treewide: Rename HOSTCFLAGS -> KBUILD_HOSTCFLAGS
To:     Laura Abbott <labbott@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Jarry <robin.jarry@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


2018-07-10 9:45 GMT+09:00 Laura Abbott <labbott@redhat.com>:
> In preparation for enabling command line CFLAGS, re-name HOSTCFLAGS to
> KBUILD_HOSTCFLAGS as the internal use only flags. This should not have any
> visible effects.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Dropped name change for individual files (still CHOSTFLAGS_foo)
> ---



One more fix for a document.


diff --git a/Documentation/kbuild/makefiles.txt
b/Documentation/kbuild/makefiles.txt
index 048fc39..63655c1 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -661,7 +661,7 @@ Both possibilities are described in the following.

        When compiling host programs, it is possible to set specific flags.
        The programs will always be compiled utilising $(HOSTCC) passed
-       the options specified in $(HOSTCFLAGS).
+       the options specified in $(KBUILD_HOSTCFLAGS).
        To set flags that will take effect for all host programs created
        in that Makefile, use the variable HOST_EXTRACFLAGS.


I will fold this.


-- 
Best Regards
Masahiro Yamada
