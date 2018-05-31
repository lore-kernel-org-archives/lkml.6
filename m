Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755263AbeEaNXe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:23:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36119 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755159AbeEaNXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:23:32 -0400
X-Google-Smtp-Source: ADUXVKKZFFqdgqEBnXFO5+LF5QxFswG+CsDJCmSArCi+99iXLvCPQEX5DQFQVe/HqkDn22avpOQ7AQ==
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        filippo.muzzini@outlook.it, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/3] three fixes for the function bfq_requests_merged
Date: Thu, 31 May 2018 15:23:10 +0200
Message-Id: <20180531132313.2986-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
this series fixes three bugs in bfq_requests_merged. In more detail:

- two linked bugs, with the first (critical: wrong lock) hidden by the
  second (less critical: wrong check that made the body of the
  function not be executed at all)
- a rather minor bug: superflous code

Thanks,
Paolo

Filippo Muzzini (2):
  block, bfq: remove wrong lock in bfq_requests_merged
  block, bfq: remove the removal of 'next' rq in bfq_requests_merged

Paolo Valente (1):
  block, bfq: remove wrong check in bfq_requests_merged

 block/bfq-iosched.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--
2.16.1
