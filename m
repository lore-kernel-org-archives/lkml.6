Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D15C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BC7208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="yrodVKZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BC7208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933319AbeGIPKe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:10:34 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:32970 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932949AbeGIPKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:10:32 -0400
Received: by mail-wr1-f45.google.com with SMTP id g6-v6so2463905wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=A9WyYXnaz4KVQL3+Z3uZmrYwkrmW8H6gzqN5mdKskF0=;
        b=yrodVKZ5z/nXevDYxT11owaCAmWnxSxq11HbJYCyHPygDTmDAhUL7+b/Vw2QjzRnrZ
         bWuWPzF8ykZcsjdhpdb/7M49I6bDTcYZTDoVJhI29J/Pi+JkAu6tg/Bb9p/QNN9DwveT
         BvnhjzSFqQYNUGh5GJ9YGPzHqaXNflki05B7qAU01VRZXH9fc63Whz9bhK0LlzpTQX5h
         GDL6nN5whEr2ISeNSVbay6NuOdRM/2wpMYFHWBrbttJi9TvLecbSvosVZt+004TF9qqZ
         O3MrCb5shiE5TPl0FYfIlWKd1uB9ef7ccxNkqRN5dajB7dbzSWHcrpslGxOUnbxtV/iY
         tlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A9WyYXnaz4KVQL3+Z3uZmrYwkrmW8H6gzqN5mdKskF0=;
        b=XiXnp8UthIYh85K2D7Uh6KJ7TUFlz6BykvHZENYYig4EctA3zXuF38BTWFBpV3wS9p
         2Cp4yJO7/diseAlbr2eNBLIRQJ32RK8gMRO+vrBAFTwETDfXQwQ7GNhbq1YuAOal4fxn
         26BFIRR6ymKMCW/Lp+r8ah7C1GA1k8ttDvUH6KuY6TdbaHdSTDoilMlZ9RPk70Z8yjp8
         Fl9rm1Gh98G+dhuPz6mxabndRhmGrNAm9hHS7mnhqOOv9k1lQTpBagZLA75qiajn9mmz
         kQZFRLgYqfEqVTCzXo0ZBiaLAYKA+H7mhoSeXJWCrMy88738FRZ2HKqjwwKpnHPD67fl
         VwAQ==
X-Gm-Message-State: APt69E0gAg7+KR7XsD75JaqNcTtbVVc9e+aEuQobFaoGGJBqiJogM7rW
        Q7CRWwpUqXuGSyMf0uWMVzyV4A==
X-Google-Smtp-Source: AAOMgpeFqJc+i8GsLi0ciYRd0K2ZYN5MPwMNJvcNhmVYK07Gizg9LasJJZe18/hPyYinyimfB1w2AA==
X-Received: by 2002:adf:ecc6:: with SMTP id s6-v6mr16001464wro.160.1531149031142;
        Mon, 09 Jul 2018 08:10:31 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id u124-v6sm7817330wme.26.2018.07.09.08.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:10:30 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 0/12 V2] ipc: cleanups & bugfixes, rhashtable update
Date:   Mon,  9 Jul 2018 17:10:07 +0200
Message-Id: <20180709151019.1336-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have merged the patches from Dmitry, Davidlohr and myself:

- patch #1-#6: Fix syzcall findings & further race cleanups
- patch #7: Cleanup from Dmitry for ipc_idr_alloc.
- patch #8-#11: rhashtable improvement from Davidlohr
- patch #12: Another cleanup for ipc_idr_alloc.

@Davidlohr:
Please double check that I have taken the correct patches, and
that I didn't break anything.
Especially, I had to reformat the commit ids, otherwise checkpatch
complained.

@Dmitry: Patch #12 reworks your ipc_idr_alloc patch.
Ok?

@Andrew:
Can you merge the patches into -mm/next?

I have not seen any issues in my tests.

--
	Manfred
