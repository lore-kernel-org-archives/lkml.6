Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeEOEta (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 00:49:30 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36426 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeEOEt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 00:49:29 -0400
X-Google-Smtp-Source: AB8JxZoP0krgUh+VcaptZg/CYx9j46axnjO2qseRWFX+1x685DNk6i2Mt2nAmZtugIl1O3nDz38OpOAgQTED8pZHhr0=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 15 May 2018 14:49:27 +1000
Message-ID: <CAPM=9ty7fEYbPbcbtSzk5gXyNEMvnDRMpAJWuZTf6fERy6XrYg@mail.gmail.com>
Subject: [git pull] drm fix for mmap regression
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch fixes the mmap regression reported to me on irc by an i686
kernel user today, he's tested the fix works, and I've audited all the
drm drivers for the bad mmap usage and since we use the mmap offset as
a lookup in a table we aren't inclined to have anything bad in there.

Thanks,
Dave.

The following changes since commit 67b8d5c7081221efa252e111cd52532ec6d4266f:

  Linux 4.17-rc5 (2018-05-13 16:15:17 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux
tags/drm-fixes-for-v4.17-rc6-urgent

for you to fetch changes up to 76ef6b28ea4f81c3d511866a9b31392caa833126:

  drm: set FMODE_UNSIGNED_OFFSET for drm files (2018-05-15 14:46:04 +1000)

----------------------------------------------------------------
urgent i686 mmap fix for drm drivers

----------------------------------------------------------------
Dave Airlie (1):
      drm: set FMODE_UNSIGNED_OFFSET for drm files

 drivers/gpu/drm/drm_file.c | 1 +
 1 file changed, 1 insertion(+)
