Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2449C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F11D21783
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HjN02TN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfAIUMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:12:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44451 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAIUMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:12:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so4071530plt.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 12:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dUGESeK/9MQIfvHxSXrU9c86wdS7YZNtzcoyXjdX/4Q=;
        b=HjN02TN0hpxbSh+G9l5GdFeb6Ip1Mk1WnalbygClIZSUNFN6LEXkumH5RytYFi0Rnu
         oOTUY+2tvHjRrOqAoBuQe9ROSD7Mnu6WS9oz+10VHJ7hWE7D2eriqqMGP6H+ORFZiEWx
         DoEjajquwlmBloTjaAB3/uEAXkICoh+znE9Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dUGESeK/9MQIfvHxSXrU9c86wdS7YZNtzcoyXjdX/4Q=;
        b=pF+PMZX0s9XjHPfYb7RKia54rwvNPMS/tNQcu6wUbU1x18COtcRkkhK8u+zrCbfTHP
         jmtFOOv+fXfWHaASJFIk9QSa21lwOp1wOkSYeiPnw5Logo7EsJPF3TY8CVj/FodWnuUg
         MtuU1T3dm6NVZqjccWod2tTl10A1zR+lPnBi6Y1NJWxzRsY8iGXNwMhmZ78DhLgNieDT
         Wqwy2fk5AN7zF9ybcIK/e9p5MqBYD3AUULzF0icxqQ7KGC71HopWVv+ny2eD7cV87ax2
         kQdCq1oNU2T1hqG+VmqSfCso/XQiusZD8PCDHiGGlSZFu/ExXU2GTmDatlrA8PTWbUdc
         zb8Q==
X-Gm-Message-State: AJcUukdtKUzfi/hkrOZTGSFD3OJBNoPN5naCpPfBgBZMVGPsKxaVgtXe
        NLQM930hTj+BhngZ+azSnrpfSg==
X-Google-Smtp-Source: ALg8bN7tHenJHD2KNPdNSvk98wLG7QIoSE4nrWDWxEMAeOYhmvSt6j58Op0+14EVRuGT5jkLm5wgfw==
X-Received: by 2002:a17:902:bc44:: with SMTP id t4mr7382730plz.260.1547064763302;
        Wed, 09 Jan 2019 12:12:43 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id f13sm101462169pfa.132.2019.01.09.12.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 12:12:42 -0800 (PST)
Date:   Wed, 9 Jan 2019 12:12:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [GIT PULL] lkdtm updates for -next
Message-ID: <20190109201240.GA33464@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull these lkdtm changes for next (into, I assume, your
drivers-misc tree).

Thanks!

-Kees

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/lkdtm-next

for you to fetch changes up to 59a12205d3c32aee4c13ca36889fdf7cfed31126:

  lkdtm: Add tests for NULL pointer dereference (2019-01-09 12:00:31 -0800)

----------------------------------------------------------------
lkdtm updates and new tests

- Check NULL dereferences (Christophe Leroy)
- Print real addresses for debugging (Christophe Leroy)
- Drop CONFIG_BLOCK dependency

----------------------------------------------------------------
Christophe Leroy (2):
      lkdtm: Print real addresses
      lkdtm: Add tests for NULL pointer dereference

Kees Cook (1):
      lkdtm: Do not depend on BLOCK and clean up headers

 drivers/misc/lkdtm/core.c  | 11 ++---------
 drivers/misc/lkdtm/lkdtm.h |  2 ++
 drivers/misc/lkdtm/perms.c | 36 +++++++++++++++++++++++++++---------
 lib/Kconfig.debug          |  1 -
 4 files changed, 31 insertions(+), 19 deletions(-)

-- 
Kees Cook
