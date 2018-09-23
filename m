Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90B4C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A06214AB
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBRsBXlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A06214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeIWUEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 16:04:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53273 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeIWUEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 16:04:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so7190056wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ET9YZ6lCoYcg34usLNJq8z9f9i3ZAU77VaToy+KjYIs=;
        b=PBRsBXlmjot+0mvVxIbt9y+OUTbJAUZY1GN6bm/1b+3h+sPrASrIH71wKT2X31QFXm
         KazoWnVqFLvlQtMLdoWcXWMMcouPNHuMeea9G72M/t9AjlnL79v4jzHS8J9UXISDMWOy
         MWdlSlvTruRHHLWTkfX36ZECtyQL7nuaj+pP9UH9mPrQqqeYy7D4wLA9+Eg7/lTHM/wf
         k2SaZrORaNIW8bV6SEQmzeggg6UzvwirpiSUx+5rBgwTvEEPF+JGMekXIvIMwM7LMQKt
         XeemdLyVGfoUIP5yysf8WZ4iPW9CF/FDtrBA/kK0jVTtcklKiAYX7/FG0/ic+0qvzDsx
         9F+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ET9YZ6lCoYcg34usLNJq8z9f9i3ZAU77VaToy+KjYIs=;
        b=SL+yGvXCJ+QLAJrtg3GYussNW4dE8VoXvLNlNZFFv7V8MVZFZmPnoRZbU4hZCf4pQ0
         TgQ6CDz9ovZ5F3eeP5qMh1RJzj3ERqibwC0hzJHyY6V38FBOuLx2uYB4qFDMCbysoQ4h
         EWNGqnIxFEjDCwbvSh/BOHQAYyS4JpRcYOuzuP0ZHjCXUTkG+BDGf7RXqzTWSq241RZW
         b2qPw6YcCEuEafC5RQPOZFA+psvO1RI5y8j1PlySUXZqPnvN6hjTukSQjapxjfIFJXuZ
         D8Q+layFXtWZzfDhWWR72wN4aF5SIZxbCPc3baoXl/buVQL/Mg/nJJiw3c3t6nkjmW9e
         OquQ==
X-Gm-Message-State: APzg51BPEfnhyy4sWbDWee1W2MVjqCViT+sQ5YhFk9K+3LhNu4svc/4b
        slw/bk5qwW9/xzLhd8qrXnY=
X-Google-Smtp-Source: ANB0VdaQLUHd9QT31rqy2BzTJsvUrZ6c+1W9Ahrkegx3xWp0mv8IgL/JWWe3lSghj7QiTzy3olPvVA==
X-Received: by 2002:a1c:1eca:: with SMTP id e193-v6mr3899366wme.99.1537711598215;
        Sun, 23 Sep 2018 07:06:38 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:8])
        by smtp.gmail.com with ESMTPSA id j66-v6sm47477498wrj.28.2018.09.23.07.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 07:06:37 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] staging: vc04_services: Fix checkpatch.pl errors
Date:   Sun, 23 Sep 2018 15:06:15 +0100
Message-Id: <20180923140620.14583-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the following checkpatch.pl errors in the
interface/vchi directory:

ERROR: space prohibited after/before that open/closed parenthesis
ERROR: code indent should use tabs where possible
ERROR: space required after that ','
ERROR: Macros with complex values should be enclosed in parentheses
ERROR: "foo * bar" should be "foo* bar"

Aymen Qader (5):
  staging: vc04_services: Fix "space prohibited"
  staging: vc04_services: Use tabs instead of spaces
  staging: vc04_services: Add spaces after commas
  staging: vc04_services: Surround complex macros
  staging: vc04_services: Remove spaces after '*'

v2: Added cover letter correctly

 .../vc04_services/interface/vchi/vchi.h       | 200 +++++++++---------
 .../vc04_services/interface/vchi/vchi_cfg.h   |   2 +-
 2 files changed, 101 insertions(+), 101 deletions(-)

-- 
2.17.1

