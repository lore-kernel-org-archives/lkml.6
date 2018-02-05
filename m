Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbeBETFi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:05:38 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:44987 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753599AbeBETF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:05:26 -0500
X-Google-Smtp-Source: AH8x225CMO/Nb1M1G3bIDIBXYUEalSJvZ9yKU9K5SqtCPpA29Vle4tc9oD5x9Nx1nKL3UclkEAtsjQ==
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        alban.browaeys@gmail.com, ming.lei@redhat.com, ivan@ludios.org,
        169364@studenti.unimore.it, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/1] block, bfq: handle requeues of I/O requests
Date: Mon,  5 Feb 2018 20:05:09 +0100
Message-Id: <20180205190510.5499-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
just a note: the most difficult part in the implementation of this
patch has been how to handle the fact that the requeue and finish
hooks of the active elevator get invoked even for requests that are
not referred in that elevator any longer. You can find details in the
comments introduced by the patch. This note is just to point out this
unexpected fact (for me), in case it is not intentional.

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: add requeue-request hook

 block/bfq-iosched.c | 101 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 25 deletions(-)

--
2.15.1
