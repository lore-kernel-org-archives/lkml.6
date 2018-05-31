Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755516AbeEaOqa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:46:30 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:47015 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755421AbeEaOp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:45:28 -0400
X-Google-Smtp-Source: ADUXVKKhXORA7kL3JlMNPVPiL41rPuCpWXKydlUT/QbcUIYRvNg6fzN8GKOl0W0/3dPrC0XvOi4uyA==
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        sapienza.dav@gmail.com, 177992@studenti.unimore.it,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENTS 0/4] bfq: fix regressions on slow virtual machines
Date: Thu, 31 May 2018 16:45:04 +0200
Message-Id: <20180531144508.3927-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
we have bumped into some BFQ latency regressions on slow virtual
machines. The patches in this series fix all these regressions, apart
from the first patch, which provides an indirect contribution, by
improving the description of the mechanisms affected by these
regressions.

Thanks,
Paolo and Davide


Davide Sapienza (2):
  block, bfq: increase weight-raising duration for interactive apps
  block, bfq: prevent soft_rt_next_start from being stuck at infinity

Paolo Valente (2):
  block, bfq: add description of weight-raising heuristics
  block, bfq: remove slow-system class

 block/bfq-iosched.c | 252 ++++++++++++++++++++++------------------------------
 block/bfq-iosched.h |  14 +--
 2 files changed, 109 insertions(+), 157 deletions(-)

--
2.16.1
