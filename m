Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3CEC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21C021907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfBGV2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:28:23 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40047 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGV2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:28:22 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A82581BF20B;
        Thu,  7 Feb 2019 21:28:19 +0000 (UTC)
Date:   Thu, 7 Feb 2019 22:28:19 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v2 0/2] sched/wait, staging/android: simplification of freeze
 related code
Message-ID: <cover.1549564792.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces a new wait_event_freezable_hrtimeout method
to the wait api.

wait_event_freezable_hrtimeout is then used to greatly simplify
handle_vsoc_cond_wait in the android vsoc driver, reducing the
size of the vsoc driver.

Changes since v1 [1]:

- Delete "[1/3] sched/wait: use freezable_schedule when possible",
  it was submitted separately.
- Patch 3/3 (now 2/2): Fix removal of a necessary linux/freezer.h
  include and improve commit message.

[1] v1: https://lkml.org/lkml/2019/2/1/19

Hugo Lefeuvre (2):
  sched/wait: introduce wait_event_freezable_hrtimeout
  staging/android: simplify handle_vsoc_cond_wait

 drivers/staging/android/vsoc.c | 68 +++++-----------------------------
 include/linux/wait.h           | 25 +++++++++++--
 2 files changed, 31 insertions(+), 62 deletions(-)

-- 
2.20.1
