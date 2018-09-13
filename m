Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05169FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CCE204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIaSbSEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CCE204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeINFMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:12:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37144 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeINFMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:12:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so8506798wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 17:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r3uMyMh72g5KYKrfWWi/BpaPo/FERq9fgAweX/IC2P8=;
        b=vIaSbSEWkDY971zlqNhFXUcbJMG72ruEq69fponyOlrkVKYawMIyWXimIYkAcodJP8
         MuLcNvD/qaZ8yIB95MbdFYPwy8Vu6mrDWrgpWX774dic3g9ktfQY64+bVl4Im7d3QYo3
         c1Uz7752SjUYR0u5koCf4WV6/GjgyCYnLU1WQXIeKu252PSjCuTXn7a2RvPihzygTHbm
         WwsypZZ7PxCuBgkOuUpePRZyXPDlN50Zb6GWjB5ETEhdd/usJgoBYt8uylo1mc1mzA/2
         4eE/gmPpUVUZXKWDC1RD7FIx/cDlB9hw5kNFzAZMFEu4Rl46q8quhKISsx74S4QE2Ivq
         2rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r3uMyMh72g5KYKrfWWi/BpaPo/FERq9fgAweX/IC2P8=;
        b=Ns9NPYEQOj9rTtmbm5aIj7PL5HKJ2HhPNU+lBLsHriWnFKDwTZLNo02u9jPzeoEoYp
         TvQJdf2QboHDEaywdicyIYGXTnm0w66xVXrQkzKHYgRBZeH29SBlUd1gok83DsYYu1F4
         EIH3uWGhjHa0zvLOA/I60+pFwseuYlVpB2syk8QGH+0dKILCz1fHMUruvldY8Cs1rzc7
         81cIBtlxZpJeKYnjFV/fCMPGaPKG90tfmVv+8cMBE5v3UFJ7i3XmoMjYRtba87dMxub2
         dGfdQwbOFNH1JSTwalLS/xNRbp5BoY5YjcO5a9Tx7bhu58ilu9eknahLL+QbQlrETp3Y
         7XLQ==
X-Gm-Message-State: APzg51BwmpMQAmJGLHMxcksnxeu785BPKjWPm5AiRurK0QqZE6dr2sUA
        7+tXEyOANZcRUb9gxu0tAXH042QC8HE=
X-Google-Smtp-Source: ANB0VdbtTnenxo2v1gvB6vOnU5Llc7CXE/GTtW34iPicvYPv9i07OCawLQxes4CDzABf5w7iWRn+Nw==
X-Received: by 2002:a5d:5383:: with SMTP id d3-v6mr7729857wrv.191.1536883251777;
        Thu, 13 Sep 2018 17:00:51 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id x125-v6sm118129wmg.27.2018.09.13.17.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 17:00:51 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH 0/2] Compiler Attributes (naked only, for v4.19)
Date:   Fri, 14 Sep 2018 01:59:39 +0200
Message-Id: <20180913235941.31211-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches are the 5th and 6th of the Compiler Attributes series,
which Stefan and Nick requested to go into v4.19 so that the clang ARM32
build is fixed. The v5 of Compiler Attributes will have these two removed
if this goes in.

Miguel Ojeda (2):
  Compiler Attributes: naked was fixed in gcc 4.6
  Compiler Attributes: naked can be shared

 include/linux/compiler-gcc.h   | 14 --------------
 include/linux/compiler_types.h |  8 ++++++++
 2 files changed, 8 insertions(+), 14 deletions(-)

-- 
2.17.1

