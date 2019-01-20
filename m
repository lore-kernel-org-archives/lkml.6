Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A38C282E9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048A520823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C4glJbX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfAUIJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:09:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41541 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbfAUIJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:09:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so9419231plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=I6FVRA4XSxZpmaxpsnd+V/mR5be0y9wtt8PvTBdO5UM=;
        b=C4glJbX5OSlpAr2CZvYAtmHh/yUu7K0U4rcvUgCvbmjx7VkwLmhnvEr9hl5su9Fg/S
         TSFUaOM2Ls3y/LBb/OlaaDkGpU4JVSUcKKF8+V2kxNzlZ0NSTZWaCspbbEpQ1sXJkDx/
         H4QH2MwnHqdZQVAcgeu9GyvtNCWYV42wKDW9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=I6FVRA4XSxZpmaxpsnd+V/mR5be0y9wtt8PvTBdO5UM=;
        b=FnmDObrFlTf12mS9/UWnKkczuzYh+P4LQIkYQYcxkHZfMFjh1UmxdSoYIu9Ho62lwE
         da+PIjHVwQBNhTjO/qif5sRmyCDMhZvSlqKnQ/CkhUb5zZiCoHTBvuqo58YFx2fn6Or8
         axx8nfwBwGoqbbATsKSTMyODJz8y7rjRQikq/nE3EJB0ewNgVMrz39o5Lu84UUXRNTGk
         uo0p/w1HlgSLYya8bnI3qR3PBcaHeZQMU44HnnbKoBLZJnceE0/MARFi+Lbc6AQh/BRH
         d7PJlIB4ikDlkZ9QVDoGdp1tugRccoP76GUBpIRUVXSw1lmmnb2QZtPNfE77J7JO6TWx
         5HkQ==
X-Gm-Message-State: AJcUukcwqsBy9wGyTQWlaI3nb5nbicr3npgiQCeTpv8F57OkgqCK6ngI
        /YIoP0waof7P+VxUsqrTLdMTn+3Czx4=
X-Google-Smtp-Source: ALg8bN4iq8HQIpcGz4T9WyZ5bd7dviYh+TUmymP+Gm1zQ0HEBHQ6WEu+tCtR2O4Ed/7KeuHmBN9ujQ==
X-Received: by 2002:a17:902:5982:: with SMTP id p2mr27433295pli.39.1548022858558;
        Sun, 20 Jan 2019 14:20:58 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z13sm26665781pgf.84.2019.01.20.14.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 14:20:57 -0800 (PST)
Date:   Sun, 20 Jan 2019 14:20:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kugan Vivekanandarajah <kugan.vivekanandarajah@linaro.org>
Subject: [GIT PULL] gcc-plugin fixes for v5.0-rc4
Message-ID: <20190120222056.GA35153@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these gcc-plugin fixes for v5.0-rc4.

Thanks!

-Kees

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.0-rc4

for you to fetch changes up to 2c88c742d011707b55da7b54b06a030c6f57233f:

  gcc-plugins: arm_ssp_per_task_plugin: fix for GCC 9+ (2019-01-20 14:06:40 -0800)

----------------------------------------------------------------
Bug fixes for gcc-plugins

- Fix ARM per-task stack protector plugin under GCC 9 (Ard Biesheuvel)

----------------------------------------------------------------
Ard Biesheuvel (2):
      gcc-plugins: arm_ssp_per_task_plugin: sign extend the SP mask
      gcc-plugins: arm_ssp_per_task_plugin: fix for GCC 9+

 scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
Kees Cook
