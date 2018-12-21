Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019C0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04A821906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfUIAdTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbeLUV3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:29:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36374 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeLUV3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:29:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so6616367wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 13:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yChid6HDMI4xxGPmzrd8qLJBxFoUStU93gV6sSpgXds=;
        b=jfUIAdTFWy9ktUyuNX/ahQzFvBZ5lE1zv2XnTIp8lGEJenP/Vmwk8GZlrzA8SpS2DU
         MZTDx36lH3FyYRf9YNPDSJdVdqoluLRWjEDHISKM3yXix0083/OEAg9EBwNzoTiRYNxE
         Y1TiilxS3gl0rFp71GNGWz9blbLw/Molgz+PNVbvyTZzagRS5gBqp6axxji3so6RY3S/
         j/vcSZ4xHwuov6VkUJsel1M7wCNgxgvG7nObGkTravH871dKe9ka6KbuO1kkVlRnIYIa
         BSuSypJ2WFkWyT0IM8MgLAOVNquK7jtvYtdql0V1NPS7x2qLid+5Yuh3hPFmRHUzSgV+
         wGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yChid6HDMI4xxGPmzrd8qLJBxFoUStU93gV6sSpgXds=;
        b=tzW0yllxw9V3Xpa8UwcS2rWoHU3ubipzl+I61ZPotoEygLk5ewg5vN7ekZn4V/eXYg
         lNOMQ96aTgqqpRKEk3ci1L1eqr3xXlQoW80swHivDIJE6Go9mZIvlJq5Qaqh71yD6Snl
         +j1JN5l1e5Tl/yf2PE7NrV0Jhe9uS8RIuLohDFKGsDk91qW7CfYbWUXw1b8O1mqRw2YH
         TTQHwlzHG4xbebYTUHONW9h5s9Gwj0mQyvxOpNoLVzPK3I/CDCirCqJxiEeTL2TR2mGg
         x/+FQOPwXQrZ1qTSjFFOfraabht/D1pzESFRKtjJTWITATAyxbvnnAoIqz8qhvcjE0MC
         c8gg==
X-Gm-Message-State: AJcUukcfwr9pkYpG8CHyAEYXFRI1cjR0c6UzrnK87RLeL3yag0JJ+9c2
        ekapl8X1Vtog0GaFRnGnnJV4wvZh8ZI=
X-Google-Smtp-Source: ALg8bN5ke7GVVe/h1PcHxvRp/MVjkJLQ2OKX95NucbH0iPKfj54hz1BISquZJ4nd5gVf5PYJ3Ul+yg==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr4215043wrt.327.1545427771498;
        Fri, 21 Dec 2018 13:29:31 -0800 (PST)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id j63sm9643513wmb.40.2018.12.21.13.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 13:29:30 -0800 (PST)
Date:   Fri, 21 Dec 2018 22:29:22 +0100
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Xiaozhou Liu <liuxiaozhou@bytedance.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [GIT PULL] compiler-attributes for v4.20
Message-ID: <20181221212922.GA14646@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I picked this one up even if it is not exactly compiler-attributes.

I would like if you can take a look at the patch, please. The patch is harmless
for the kernel, but v4.19 was released with a few macros exposed to userspace
as the patch explains; which this removes, so it *could* happen that we break
something for someone (although leaving inline redefined is probably worse).

Greg said he would want to pick this if this ends up in your tree.

The patch has been in linux-next for a few days.

Cheers,
Miguel

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v4.20

for you to fetch changes up to 71391bdd2e9aab188f86bf1ecd9b232531ec7eea:

  include/linux/compiler_types.h: don't pollute userspace with macro definitions (2018-12-14 16:57:16 +0100)

----------------------------------------------------------------
A cleanup for userspace in compiler_types.h

  - don't pollute userspace with macro definitions
    From Xiaozhou Liu

----------------------------------------------------------------
Xiaozhou Liu (1):
      include/linux/compiler_types.h: don't pollute userspace with macro definitions

 include/linux/compiler_types.h | 108 ++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 54 deletions(-)
