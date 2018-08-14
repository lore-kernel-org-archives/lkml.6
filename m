Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24998C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAAA21728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmv6j3Im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAAA21728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbeHNWCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:02:31 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:40624 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeHNWCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:02:31 -0400
Received: by mail-wm0-f45.google.com with SMTP id y9-v6so13312951wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 12:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lNTQZLdobIXiWCRfD/yeQT5WUly1Bgl/fvAHf5rxgpc=;
        b=hmv6j3Im/wNf0WVZCXykM+kc9QgwPBm1F49ZKceTLAXQ1OCN3pq94oSxXZdTbJjwmS
         DHz2TYBpsgnYQYCDrzljWYFevzbYVeuMyMF07d0NItYOQ1ddcoSOafvGmusv79c34wTO
         2dBScIDUHuNe1w1qWr2yg2hCdwkNB/NykiZKBAWkRWE32XqrC5kmMtNxbYewgRhcaNn/
         B8xsC+v3chUXbETAJ83/HnkdI8lgwokCoeGpYl3RtpFLIgC9yi/C8bgZMuZlD+Hz+I+R
         eSrfFildrq3n8HiFF7ACxaWjrauCTQKRAJ2gB/FfFqsJ+UcfloXxf+VX2PC49FzUapQF
         7NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lNTQZLdobIXiWCRfD/yeQT5WUly1Bgl/fvAHf5rxgpc=;
        b=CmVo6lepZSpXbCCOcIEUEpw8VIYDE+CNzaWlGFpO720IaBwYc0xbjwSIhoAIdQtE8R
         IIk1ZExwgdcYMGwAWNrelE9BeBsJm00JuFudyVO3LVBJk9dPLLbGnkvuZ4CJx17m2xMS
         2tyykSbxCWaAnZsUZIa3GhF4gYIzmXj+v0cZLPx1fahTySVkC4SMayhoWUvjrgndHyCr
         7wZ4nQCZ5mVdIL8IvA42x2chLeH3HY5HqVO7U/x8xhmm9YtgsMusAJ9QbkQpD7DSJkmy
         enwXyq4vy4VBijKmOfSty3FQvyz22JnnSJocmSPXUmlKwyhT3NVq4S21pbWzIrDcaG1c
         2OGA==
X-Gm-Message-State: AOUpUlF4a1oPSmDceAUd+ULasGUURIy+R6VqWkb0a9B5cbS6q3v1Xkck
        ydZZMstdIc71tF7S2gQmCe56rCXV
X-Google-Smtp-Source: AA+uWPwEdQRudwAeRWf52KKS+rMj56K3wG6E6pIvSsLbaG0ewUVopa8P/HBSm8KzreDthnvpngtdCQ==
X-Received: by 2002:a1c:149:: with SMTP id 70-v6mr12203260wmb.2.1534274032978;
        Tue, 14 Aug 2018 12:13:52 -0700 (PDT)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id n5-v6sm8172150wmh.1.2018.08.14.12.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 12:13:52 -0700 (PDT)
Date:   Tue, 14 Aug 2018 21:13:38 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] .clang-format for v4.19
Message-ID: <20180814191338.GA3410@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

[Jason Gunthorpe (author of the patch in this set) and I discussed
in which tree this file should be. Since anyway I will maintain it
and there is no specific tree (that we know of) for this, I just
created a branch in my github account.]

Please pick this improvement for the .clang-format file from Jason.
I also added myself as maintainer for the file.

Cheers,
Miguel Ojeda

The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70:

  Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/clang-format-for-linus-v4.19

for you to fetch changes up to 16b7db4c8150ba12e7eb63a5de962e1b05b3b612:

  MAINTAINERS: Add .clang-format entry (2018-08-01 18:39:24 +0200)

----------------------------------------------------------------
Two improvements for .clang-format:

  - Set IndentWrappedFunctionNames false
    From Jason Gunthorpe

  - Add MAINTAINERS entry
    From Miguel Ojeda

----------------------------------------------------------------
Jason Gunthorpe (1):
      clang-format: Set IndentWrappedFunctionNames false

Miguel Ojeda (1):
      MAINTAINERS: Add .clang-format entry

 .clang-format | 2 +-
 MAINTAINERS   | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)
