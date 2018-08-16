Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449E6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0043720C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGHLAMAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0043720C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbeHPTvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:51:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44338 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeHPTve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:51:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so4732988wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 09:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kAJN5fxC24ZODwvl+eKV5x4mhAs5Fw7VBfu8pF7El8s=;
        b=fGHLAMAMm2lu4C8wbEa9LebpuT0CWFBu8Dl2kK/eZX0j4PU7yubwoMjcXb2/l76E68
         url8VIG0TUwC7auEYiMr006uz+2nxGfKfIOTQL9YYHzLD3VnfZsvw17xw+NjiPY41s1o
         XaiDFv07Bb2iWxRqI2up33sXAQZF8mvSVmgpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kAJN5fxC24ZODwvl+eKV5x4mhAs5Fw7VBfu8pF7El8s=;
        b=ECbCcY5ntgAj1pyyjQHDf1ap+scnWkiLQNrul5WPxRZjOinfWvN6LAriPVgnqq8apm
         wmdZ2BPpm9+snhQemXfgrQKNn0t8P1/nLIS8CsnV/BMDES/vO723uDHBHWXTjIAKA5Xb
         likdFblrreXf8Hng5wi9EcvBQVBIALo95TCBTPdanQnqmr2OUdjQY1iiUsjukJm6QxlX
         4lE26yl145qtf+/wMRzOBWmdRznHY4Q5/3QBiOEq4Rjj6VAHN3b7rVYDANT4trglU94S
         wDkQVIEXdFODt9Tc9zC5vVrqeY5JXg3zdHKViyjfnhNKJmD6XXD/Hlvp0WH7RB6D2WpP
         O85g==
X-Gm-Message-State: AOUpUlF7S5BV5o+O/Toai1sPran3YyI/iW70lmFPleuEyBKZSEMGLnsl
        oSy8tqIwGvBGDe/vN537y3u/7g==
X-Google-Smtp-Source: AA+uWPwrIXEOxfwHQ1ScvvFjEAlbdtaxTUZ6ObwN+omTBKgZLK8CpHMh2nF5cbOoqF8dyCzzROSWsQ==
X-Received: by 2002:adf:f1c8:: with SMTP id z8-v6mr2412002wro.214.1534438315762;
        Thu, 16 Aug 2018 09:51:55 -0700 (PDT)
Received: from localhost.localdomain (146-241-5-103.dyn.eolo.it. [146.241.5.103])
        by smtp.gmail.com with ESMTPSA id o3-v6sm30036180wrj.31.2018.08.16.09.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 09:51:55 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 0/4] bfq: two fixes and one improvement related to I/O control
Date:   Thu, 16 Aug 2018 18:51:14 +0200
Message-Id: <20180816165118.17402-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

while working a little bit on cgroups I/O control, I found two nasty
bugs in bfq. They break bandwidth control in simple configurations
with one-process groups. These bugs are fixed by the first two patches
in this series.

These fixes improved I/O control so much, that I could reduce the
write overcharge factor, used by bfq to counter write-induced
issues. This reduction is performed by the third patch.

The fourth patch contains a little code improvement I made in a
function that has to do with I/O control.

I hope we are still in time for 4.19.

Thanks,
Paolo

Paolo Valente (4):
  block, bfq: readd missing reset of parent-entity service
  block, bfq: always update the budget of an entity when needed
  block, bfq: reduce write overcharge
  block, bfq: improve code of bfq_bfqq_charge_time

 block/bfq-iosched.c | 54 +++++++++++++++++++++++++++++++++++++++--------------
 block/bfq-wf2q.c    | 22 +++++++++++-----------
 2 files changed, 51 insertions(+), 25 deletions(-)

--
2.16.1
