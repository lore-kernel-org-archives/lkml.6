Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFABC46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768A2214C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNBmgMJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768A2214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeHHCol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:44:41 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42693 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeHHCok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:44:40 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so547071qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=rbdYKph4iHGCLlfzWotyhFQsPufoS3H9J/bT8WC7mVw=;
        b=qNBmgMJec0fNgt1gV8wmJ5a6+JTLQibC3bGqQQ+MNb+ggIAnfe7CDWoNE4zELpu7cP
         jwc8ox+ppj2eQPk8gCVDDWJlDWMLGkQTlgFi9eDyUZoy5sp1Qxsrocatxt4lv95+Bfbd
         lIEkc330GdO/inb+8UXQHZ5Tl+16h/9L26HVPsDSpTs4Zltgq16YGz3KBB6N0rZkzF2r
         YAFC3VwfCMdcKGTIu6Eq6yYvvRAr56rD79NHKAA5ySsRHYLeGFjB5em7Baz6hz64qlrU
         ltq8rJdwsbYl32R/3vGae5nHFRdKpjD83mSRGu9L2WA83ZCYgEyogmPXPmN7C/I4bhw0
         QiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=rbdYKph4iHGCLlfzWotyhFQsPufoS3H9J/bT8WC7mVw=;
        b=QAprxxJ1n4DmQrppYeABDgWOcvDCqAu/dp9HBBxJjeSvwQTPXUKbD3X7M6sxSq6qnq
         eegQ/g7529ALRDGC1I84EmB5iPWfR1y0NWU1O5Tvyk17s8+Z/OZGAGSS/jHVkaPFA5il
         lovxR6BCaBNm2T4GYM2zMNnPukH5I66/qUtMj1pp1TzV5bMxfe7sH/8QsjdZwG6ePUu5
         mNj+o8FBHz97rfsRm+ozaathztEoNmI6Xrls84FfTFgH5+qKFx5zdkosTPryksL/+XlZ
         kD2ZhRwpav5UsH6AvY4V1/0I5+pLixUS5Qq1qOU8q58z/q9ZyiQfOmeszkkyFZFqfsT1
         fRXw==
X-Gm-Message-State: AOUpUlHwKsl+wPsNFj+4ccpEdi9XBq3mVjJOWjzWZum5QPm9v44ytDWh
        tjsrpi4NVOaw/CNSzenHY7k=
X-Google-Smtp-Source: AA+uWPzymUffAkXcGG6xOyfwPQG1ObUGcW5bZesZSlZ/loBDz9h101Xav7B/iUFj8F3d3SZmJX8I7w==
X-Received: by 2002:aed:3b6a:: with SMTP id q39-v6mr653217qte.246.1533688063787;
        Tue, 07 Aug 2018 17:27:43 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id q83-v6sm1761982qki.67.2018.08.07.17.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:27:43 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:27:38 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/15] staging: fbtft: Fixes some issues found with
 checkpatch.pl
Message-ID: <cover.1533686201.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes some issues found with checkpatch.pl, and other issues found browsing the code.

Leonardo Brás (15):
  staging: fbtft: Changes udelay(n) to usleep_range(n, n + x). - Style
  staging: fbtft: Puts macro arguments in parenthesis to avoid
    precedence issues - Style
  staging: fbtft: Fixes some alignment issues - Style
  staging: fbtft: Fixes some lines long lines (>80) - Style
  staging: fbtft: A bit more information on dev_err.
  staging: fbtft: Changes gamma table to define.
  staging: fbtft: Removes one nesting level to help readability - Style
  staging: fbtft: Adjust some empty-line problems - Style
  staging: fbtft: Erases some repetitive usage of function name - Style
  staging: fbtft: Fixes some defines styles - Style
  staging: fbtft: Includes description to mutex and spinlock - Style
  staging: fbtft: Add spaces around /  - Style
  staging: fbtft: Corrects long index line  - Style
  staging: fbtft: Replaces (1 << n) for macro BIT(n) - Style
  staging: fbtft: Replaces custom debug macro with dev_dbg().

 drivers/staging/fbtft/fb_agm1264k-fl.c |   2 +-
 drivers/staging/fbtft/fb_hx8347d.c     |   2 +-
 drivers/staging/fbtft/fb_ili9163.c     |   2 +-
 drivers/staging/fbtft/fb_ili9320.c     |   2 +-
 drivers/staging/fbtft/fb_ili9325.c     |   2 +-
 drivers/staging/fbtft/fb_ili9341.c     |   2 +-
 drivers/staging/fbtft/fb_ra8875.c      |   4 +-
 drivers/staging/fbtft/fb_s6d02a1.c     |   1 -
 drivers/staging/fbtft/fb_s6d1121.c     |   3 +-
 drivers/staging/fbtft/fb_sh1106.c      |   2 +-
 drivers/staging/fbtft/fb_ssd1289.c     |   9 +-
 drivers/staging/fbtft/fb_ssd1306.c     |   5 +-
 drivers/staging/fbtft/fb_ssd1325.c     |   2 +-
 drivers/staging/fbtft/fb_ssd1331.c     |   5 +-
 drivers/staging/fbtft/fb_ssd1351.c     |  39 +++++---
 drivers/staging/fbtft/fb_st7735r.c     |  21 +++--
 drivers/staging/fbtft/fb_st7789v.c     |  13 ++-
 drivers/staging/fbtft/fb_tinylcd.c     |   2 +-
 drivers/staging/fbtft/fb_uc1611.c      |   2 +-
 drivers/staging/fbtft/fb_upd161704.c   |  19 ++--
 drivers/staging/fbtft/fb_watterott.c   |  30 +++---
 drivers/staging/fbtft/fbtft-bus.c      |  27 +++---
 drivers/staging/fbtft/fbtft-core.c     |  53 ++++++-----
 drivers/staging/fbtft/fbtft-io.c       |  17 ++--
 drivers/staging/fbtft/fbtft-sysfs.c    |   9 +-
 drivers/staging/fbtft/fbtft.h          | 122 ++++++++++++++-----------
 drivers/staging/fbtft/fbtft_device.c   |  40 ++++----
 drivers/staging/fbtft/flexfb.c         |  45 +++++----
 28 files changed, 271 insertions(+), 211 deletions(-)

-- 
2.18.0

