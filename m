Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAE2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69645214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jTuSMQZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69645214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeHWU7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:59:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39441 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeHWU7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:59:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so3124246pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NDv/LxMju/lDFudpRpjmbSKGkWcek9tg1+gdAElmdko=;
        b=jTuSMQZyIRED0lprbzo8kPglV56SJ2LfeigdSH5tsw3O3TdQ33KZy4My52mhOU11ux
         t910QKCDzWauYKSbF3GJTxiVj6vNhZKe7Xi1hNqQ1zupOfKmK7x5vtWtE56OcrbhUYIF
         AlifI9dh/rml0rIvPMnCsAwtadnWF0ZQOxmBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NDv/LxMju/lDFudpRpjmbSKGkWcek9tg1+gdAElmdko=;
        b=XSu4FtqHN1MWypK6Nw2NWY58eHV5jgW4xWMrTo/gMcWWM77Y6wjMal9y0wczdcA5ol
         jyKiGoJiPVVif8mp/1Z2MUm4kFtdmrlZJXqzOnO25PnX4YmYmxhGMgk8RRf0xPacuXpX
         W8NQijnTvh89lkFo9Exyv40Hjr4i/sEiCkhlfhNFst3svNxZd4sKLIWrgf9jNPpNWXih
         dtSPBg5L4Gbkae5wgjGEVs1NMRQswKKpHgEhC+Oa1ZoNrOvNxneVusoTiJmMI2TAeGh0
         RwOhkWUUusKv4O4USYTToAhwSR/E5DoF9QePuRVxQ694WfT6mZ0FXK5kvRKQBq0R5K3l
         WVmg==
X-Gm-Message-State: AOUpUlFELqNOKpzRU/Wn7L8Ozsyl4jJZ4xotgocw5DIokt5jFIyyghbo
        VQ+oprMtwTI8koC+VwwaCeXu3A==
X-Google-Smtp-Source: AA+uWPz7HjCKWtN0t0Vvq4GDig1KPPSBn5eXSztUh9xcZyqwB6CB11iFYlt/pJ66G/sqMhSeywrHcQ==
X-Received: by 2002:a63:f414:: with SMTP id g20-v6mr56552661pgi.407.1535045310936;
        Thu, 23 Aug 2018 10:28:30 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x2-v6sm9086743pfi.166.2018.08.23.10.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 10:28:29 -0700 (PDT)
Date:   Thu, 23 Aug 2018 10:28:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stefan Agner <stefan@agner.ch>
Subject: [GIT PULL] gcc-plugins update for v4.19-rc1 (fix)
Message-ID: <20180823172828.GA2756@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please pull this gcc-plugins fix for v4.19-rc1. This is for better
behavior when the kernel is built with Clang, reported by Stefan Agner.

Thanks!

-Kees

The following changes since commit 7ccb95e8fe9131b8fa14b947c60dfb30044fa002:

  gcc-plugins: Regularize Makefile.gcc-plugins (2018-07-24 16:11:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v4.19-rc1-fix

for you to fetch changes up to b04413330c773c808c4c6a6cdd278f8ee0f8b613:

  gcc-plugins: Disable when building under Clang (2018-08-23 10:06:12 -0700)

----------------------------------------------------------------
gcc plugin fix:

- Lift gcc test into Kconfig

----------------------------------------------------------------
Kees Cook (1):
      gcc-plugins: Disable when building under Clang

 scripts/gcc-plugins/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Kees Cook
Pixel Security
