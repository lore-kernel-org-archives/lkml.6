Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeB1AGI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:06:08 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:47150 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeB1AGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:06:07 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 217.50.39.238) smtp.mailfrom=rabel@robertabel.eu smtp.helo=buildbert.robertabel.eu
From: Robert Abel <rabel@robertabel.eu>
To: linux-kernel@vger.kernel.org
Cc: Robert Abel <rabel@robertabel.eu>, miguel.ojeda.sandonis@gmail.com,
        w@1wt.eu, geert@linux-m68k.org, andy.shevchenko@gmail.com
Subject: [PATCH RFC 0/2] auxdisplay: charlcd: fix movement and home commands
Date: Wed, 28 Feb 2018 01:05:34 +0100
Message-Id: <20180228000536.9489-1-rabel@robertabel.eu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <911beeb5-529f-09bb-0e5a-c5b626adba60@robertabel.eu>
References: <911beeb5-529f-09bb-0e5a-c5b626adba60@robertabel.eu>
X-PPP-Message-ID: <20180228000605.8915.29398@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I reworked the previous patches 2-4 into these two patches.
The first patch proproses a different solution to the movement command
parse code that reduces the movement command two at most two movement
subcommands (x or y standalone, x followed by y or vice-versa).

The second patch add comments in code to the home and clear_fast functions
and explains their behavior a bit more.

Robert Abel (2):
  auxdisplay: charlcd: fix x/y address commands
  auxdisplay: charlcd: make home command unshift display

 drivers/auxdisplay/charlcd.c | 137 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 122 insertions(+), 15 deletions(-)

-- 
2.11.0
