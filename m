Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C431C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD8D20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kSmd8vlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfAUIfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:35:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46699 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfAUIfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:35:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so9776116pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ikzf4xns+QcjnQLTzM7TU4QPpUBxd3PDfja3I4Ed6d0=;
        b=kSmd8vlhE98/YuDOWbJvBDY4AnaA0wrCwTi6pyv8g14TTgF9Uo7ojDfPfOidakpoBc
         RT6dSwP02AYWQBPTXpn8y2oB/cMFJnU+CmI1PeZjDwaVmtUZc5RNHiUPXKW8BDKK4Kt+
         KDifskKpMMurnGeCPORavZoD8p8EIFhRJIwow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ikzf4xns+QcjnQLTzM7TU4QPpUBxd3PDfja3I4Ed6d0=;
        b=A1/JM/+pf5Caaeod1pS+hWRqyuuiBFkywyYkxI7GM8BSL3AwvdvklQPhTRUd2d77s2
         M2hF+faSVOspUeMu4KV7ncLhyU0V28ZLLvY7Qx4+yTM831j/lIy6q3DAnvZskRbDc/al
         Z3VoaOCxKkOT5iqW/1Sd8y8RCNu55qWFlyEF7+/3wpRdgpzaQ8koBvkkQTYJ8dfsoWTp
         zQb/45DIhKKNPruc5nWdFpSBIhRb3419n4aoG/3Go4aanVTeBpRexssfSORoIv501X2q
         uWAPUiqmDbTy61yJ1IX6/L0YvRgZAMCRi8w+qn8fANeNfi+TwKDbga+FUuyziNr1Mi9r
         YHtA==
X-Gm-Message-State: AJcUukejzbH/Hd583rZ3oYeeycim7oGn9RskR1Vfe4JIEX47dKUPMEcH
        vBTEamkVsEs4lYZXlEN/Dh2YOhMr5qA=
X-Google-Smtp-Source: ALg8bN4eu/AF63hAMR5ZkMfv98fJryqdxNhJJfIo0zTjfZsujzKWpj1N6R6MxS/djPbWmearlGIcHA==
X-Received: by 2002:a62:8a51:: with SMTP id y78mr27427114pfd.35.1548025569991;
        Sun, 20 Jan 2019 15:06:09 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v191sm23147220pgb.77.2019.01.20.15.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 15:06:09 -0800 (PST)
Date:   Sun, 20 Jan 2019 15:06:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Yue Hu <huyue2@yulong.com>
Subject: [GIT PULL] pstore fixes for v5.0-rc4
Message-ID: <20190120230608.GA20111@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore fixes for v5.0-rc4.

Thanks!

-Kees

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.0-rc4

for you to fetch changes up to 5631e8576a3caf606cdc375f97425a67983b420c:

  pstore/ram: Avoid allocation and leak of platform data (2019-01-20 14:44:52 -0800)

----------------------------------------------------------------
Fixes for pstore/ram

- Fix console ramoops to show the previous boot logs (Sai Prakash Ranjan)
- Avoid allocation and leak of platform data

----------------------------------------------------------------
Kees Cook (1):
      pstore/ram: Avoid allocation and leak of platform data

Sai Prakash Ranjan (1):
      pstore/ram: Fix console ramoops to show the previous boot logs

 fs/pstore/ram.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

-- 
Kees Cook
