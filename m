Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeDXWf2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:35:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38394 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDXWfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:35:25 -0400
X-Google-Smtp-Source: AIpwx4+HpauIB68kJZ2O+fSz7mMRDGwYkaOGsR2c1zej5Iu6KOl0jODbFah9/s8nk2mpbfvVmjW0fA==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Misc devfreq_add_device() fixes
Date: Tue, 24 Apr 2018 15:35:15 -0700
Message-Id: <20180424223521.28193-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first 5 patches corrects error handling, reoder things and stop holding the
devfreq mutex in devfreq_add_device(). The last patch validates that a client
doesn't attempt to provide a freq_table, as the implementation relies on the
freq_table being an internal representation of the associated device's opp
table.

Bjorn Andersson (6):
  PM / devfreq: Free devfreq upon set_freq_table error
  PM / devfreq: Use the device release function for cleanup
  PM / devfreq: Reorder devfreq_add_device()
  PM / devfreq: Remove unnecessary locking
  PM / devfreq: Use put_device() on device_register error
  PM / devfreq: Reject client provided freq_table

 drivers/devfreq/devfreq.c | 73 ++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 42 deletions(-)

-- 
2.16.2
