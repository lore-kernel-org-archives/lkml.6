Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4AAC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D0421776
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AL5ODA5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D0421776
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbeHMXVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 19:21:01 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33254 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMXVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 19:21:00 -0400
Received: by mail-pl0-f65.google.com with SMTP id b90-v6so7383106plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7eyxbvVZSUSzEmbZVMCSfbFuAbywW3EtHP0omyd5FdA=;
        b=AL5ODA5Vz6c4rgFzmd9ZQGT6diB7vet9oTl6AaMj24EUp6aLxMfQcivkjF4n8gNOI/
         bLV2DN+i7onM45BjBu4qG30/0ej7NMh/CtkI4OnorUC/Tc4TPvKAA0ythNVyEJd2ybXz
         gXng6joDQnQUlDm4Haux/W+goVsNi5Be7NCRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7eyxbvVZSUSzEmbZVMCSfbFuAbywW3EtHP0omyd5FdA=;
        b=TelxJ3qzvqnDz35qdH3CqC+LwVjL6Kq7m13oINDHj8LwtKwhYDZ3yFOuBZmPuj9qBP
         zPzDOs210xCTC3ccl5qZDOgRgKzml0beQywRJjJZxAHk9tJximHxQ78S6tap2iKmBJxi
         6++6ESR1zEdzWWzVbBH+zdWPpNjooVgjiCqozEo7qrd9Metiruac3qvuN1cltMTF6hrs
         GnZItJtX3PfHaghbMnc+Gk2aIlzLd0KGm2Uu0fK/Mf82IIBxD6mDSj/lywTfVquunzAV
         qIe3uxvF6r2rid/J881OF51cv5s5qw2l2vxMk4Ovi5DbQySP6/oD85x1r/uu2PQAeV09
         Q60Q==
X-Gm-Message-State: AOUpUlFcXujDMWCahLb+UcKy+GDMWHTdbF4ag+w4IvPvRbiLlB06spWc
        rpOQ50KDYo7TkVEea98MCOjoZA==
X-Google-Smtp-Source: AA+uWPzSaYweF182/xVyCZpRzGbYZPC94pJMwuN67I8ZB9XQfSy8ogWwwt7+zMIUc1bt11XLsRs4gw==
X-Received: by 2002:a17:902:bd07:: with SMTP id p7-v6mr18013108pls.32.1534192631760;
        Mon, 13 Aug 2018 13:37:11 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id u1-v6sm23432135pgk.25.2018.08.13.13.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 13:37:10 -0700 (PDT)
Date:   Mon, 13 Aug 2018 13:37:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Geliang Tang <geliangtang@gmail.com>
Subject: [GIT PULL] pstore update for v4.19-rc1
Message-ID: <20180813203709.GA10208@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this pstore change for v4.19-rc1. This cycle has been
very quiet for pstore: the only change is adding awareness of the zstd
compression method.

Thanks!

-Kees

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v4.19-rc1

for you to fetch changes up to 1021bcf44d0e876b10f8739594ad7e6e9c746026:

  pstore: add zstd compression support (2018-08-03 18:12:18 -0700)

----------------------------------------------------------------
- Add awareness of zstd compression (Geliang Tang)

----------------------------------------------------------------
Geliang Tang (1):
      pstore: add zstd compression support

 fs/pstore/Kconfig    | 17 ++++++++++++++---
 fs/pstore/platform.c | 16 ++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

-- 
Kees Cook
Pixel Security
