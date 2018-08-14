Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097C3C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74EE21727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p19DlpJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74EE21727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeHNVuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:50:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40843 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeHNVuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:50:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so13279728wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 12:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tIkFbFABjvvfk1dxZFKoeicLFrsnRdxac/WipZ4lNe4=;
        b=p19DlpJ4Vr4ybpBwsC5WGuprPLmL4Me5mb0yJEUt96Li0R83eBO3NMHPviSkZDzxew
         Zn2ALDN+PHHbmUqCJIfhF+QKYNqZB8QrP7LQoRvZWPm7liMPVw1hVLmSECZpoB8kJe8R
         IQRp9zNRJbZAmckw3JWQHFIzu4BIKxrr+jk1v/Ecd2QMyn89JcHNstnIcTMcHmDqaDNt
         FZRmM9pduP+QRPxCKMrgMMEtN0YjD6CWC3wH+c5ekB2t6TBZLqsVhbu/iUU4DZUKFhSu
         o7oB9UMT3VA39J+8P3CiQLZ9XcklrzsmvZ8nh9igrlex1E1ZidkiXK+3c+C9XqPnDV6m
         Rsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tIkFbFABjvvfk1dxZFKoeicLFrsnRdxac/WipZ4lNe4=;
        b=hKSjkr2lbCnUARZ0AZ/Bcnxq1FCezzt2esDDAnqDq4/q+Chzw0PYJOK5+xFx6LgtxY
         CuDAS3niVBAZp4bfcsqzc8S67Jt305EiwRyYVRjuBwacwlWxiNElDnF2VkISgfu6PiwZ
         6k466eCAiLavAZ6LK9erC3HWWYdCg5dUioVYYvYwW3v2uXyaSEFbgnyBTkqWPWlzQeow
         KgyR3KJM39FQV6OPLqQ6g8Ne7O+rpP7qdHYSO9laHOn/XZXdonk95j4oLCdb7m9h6fGl
         AGPQa8lfYeKYww2kunxzSdDSpPM04s/Hoi6uuCiytP3ckEzIGhf4972tq+5He7G4/pVO
         d56g==
X-Gm-Message-State: AOUpUlHZ8r5OB+98eK6d3BKAm5JpueXF8GgVYUXC9sOZS136bzw7X0Pg
        KOVch5WjHNTK5wN9RgP6PLMn6iz2
X-Google-Smtp-Source: AA+uWPxwUHl7nynofqcyH99KWht80frlH0tANnNc7eC7p7dzP9RMZzv1/3AkkHdHfK9xSB8gGD37Sg==
X-Received: by 2002:a1c:d750:: with SMTP id o77-v6mr11333924wmg.67.1534273285785;
        Tue, 14 Aug 2018 12:01:25 -0700 (PDT)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id x14-v6sm23186894wrv.21.2018.08.14.12.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 12:01:25 -0700 (PDT)
Date:   Tue, 14 Aug 2018 21:01:14 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] auxdisplay for v4.19
Message-ID: <20180814190114.GA3352@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these two small auxdisplay cleanups for 4.19.

Cheers,
Miguel Ojeda

The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70:

  Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v4.19

for you to fetch changes up to ada953de4486a3e2a42c3b8146adb36d0dcbded2:

  auxdisplay: simplify getting .drvdata (2018-08-01 18:58:09 +0200)

----------------------------------------------------------------
Two cleanups for char_lcd:

  - simplify getting .drvdata
    From Wolfram Sang

  - delete mdelay in long_sleep
    From Jia-Ju Bai

----------------------------------------------------------------
Jia-Ju Bai (1):
      auxdisplay: charlcd: delete mdelay in long_sleep

Wolfram Sang (1):
      auxdisplay: simplify getting .drvdata

 drivers/auxdisplay/arm-charlcd.c | 6 ++----
 drivers/auxdisplay/charlcd.c     | 5 +----
 2 files changed, 3 insertions(+), 8 deletions(-)
