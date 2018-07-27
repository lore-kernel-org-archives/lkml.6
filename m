Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C05C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E5220673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="VIiI/pO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E5220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbeG0Bgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 21:36:38 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38118 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbeG0Bgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 21:36:38 -0400
Received: by mail-pl0-f68.google.com with SMTP id b1-v6so1518794pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 17:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NSi69cpbx+BHGhZJBzNnE4hs9LmmYq33wYKMIa4Xb90=;
        b=VIiI/pO+W4cAKxLZ310Ve483aun4W+0WijoldjerfVV0m3D5n8fuTzQ1WFq/EkIKZz
         rZSyhbGr9wkQ5ar9ru7tiY0KcIKu513/Z/xLW6yOujjqLjlfcXSxMCFmqy4PyjHTmRSE
         1cpxb4ZvXnAYYedRA1MDNr0GGAu5ujFtB1AwbuflzGWc9zJqrkCwSDOHU3DGAmJsS28J
         gDOkmripmSKHzHhd0w6iKvcwMMpuPUDfo542/CoeuDYBHL636dxnRBf5xkTakdj5dV8I
         8wWDSf/8ZPMdRorXkrxyEPWhsFCf6TRuU1/Ibht8UICQ/lw8edehWxoIY0IIIdpjsdCz
         1NRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NSi69cpbx+BHGhZJBzNnE4hs9LmmYq33wYKMIa4Xb90=;
        b=gbFX6cDNoIXRsFebhVHPQvPl8+UXlrRe/hI/wz5rRlF+q9UIeKMww753sqST64MIJG
         dI3wJOGr6JoWryX44gzLc7a3zII8BAITxx7WhCj+nP+kcWUXlF+9us/mxkyYHwq4by73
         ItX/j0yeg9BZup2WijEGCuDCywN47yHB5B0wd0zSDQ0H0Po6WUayFzfU+Oj4pXOUGZpB
         BH3kSkdFdzCcc8fEDZcZ1xdpR12el5XgZHWpnzciBfQMiNwM24xn+YOPfBmPGi0N4LQ8
         3Sxa1o0IL6iw2Nm/4ZvZD58Eh2nJfF1hfLvI9or2TQLUM8D1XGlpmF8CVfXzRdhnyh8i
         70YQ==
X-Gm-Message-State: AOUpUlE4A5gyHz/XWpDyoDiolXrtDTcpIoQZMR4e3MrGENmfQKeCxkBS
        8MkRnJF4h2QXhomMTTqdKU3pE7rzBOk=
X-Google-Smtp-Source: AAOMgpcKurS7DyuCTJQ5pcRZ/Cl7Y1JLDJLJBtt8yij0Z9d9WAEe+LOJ3LRcOqKaeHobT0FR5hJX7g==
X-Received: by 2002:a17:902:d218:: with SMTP id t24-v6mr3879335ply.63.1532650645916;
        Thu, 26 Jul 2018 17:17:25 -0700 (PDT)
Received: from sherryy2.mtv.corp.google.com ([2620:0:1000:1611:8e0a:214e:3e7b:4985])
        by smtp.gmail.com with ESMTPSA id q65-v6sm5345864pfj.127.2018.07.26.17.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 17:17:25 -0700 (PDT)
From:   Sherry Yang <sherryy@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     tkjos@google.com, maco@google.com
Subject: [PATCH 0/2] android: binder: debug message improvements
Date:   Thu, 26 Jul 2018 17:17:16 -0700
Message-Id: <20180727001718.242587-1-sherryy@android.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set includes extra_buffers_size in trace so that the
total transaction size can be inferred. It also ratelimits debug
messages to avoid excessive log spams reported by sysbot.

    android: binder: Show extra_buffers_size in trace
    android: binder: Rate-limit debug and userspace triggered err msgs

 drivers/android/binder.c       |  5 +++--
 drivers/android/binder_alloc.c | 41 ++++++++++++++++++--------
 drivers/android/binder_trace.h |  7 +++++--
 3 files changed, 34 insertions(+), 19 deletions(-)


