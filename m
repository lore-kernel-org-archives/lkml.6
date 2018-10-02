Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77536C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FEE20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzPCohS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FEE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeJBJTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 05:19:42 -0400
Received: from mail-it1-f182.google.com ([209.85.166.182]:33678 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJBJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 05:19:42 -0400
Received: by mail-it1-f182.google.com with SMTP id h6-v6so7869704ith.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 19:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a41kHyGIPEvolYUCzwepAnvOTNYYdBz0y1rjRVvrOjo=;
        b=KzPCohS7cbaaBT0IgXCDudpIkDjiiyHR1WInOMjfhOzozYlJi/KdXkbI3gmIpF6y1L
         EZ6zzRW+Lh1oibNupQkh+zHZJSoMV1UMVK+heXeYpHFFZwPNVaUXMpajw7916wdKM5dj
         3exoha/naji6G2iX3FS23snxYA22tisoZded+yTXJJDoRE9gySYb8u6T/LH8/BwHl/VD
         Nh+ZK1q5tmgC/Nu566z/238S08Y94diro5sWVdadTuypeGfmiotq/E/zgGsmuBtBUIrl
         n7fu3BlQywShrXweyaDoNOzi3XM2ZIl4v2AkZkHWjpqHcCsf8adW4ZJe5C0F+gba/lyM
         VDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a41kHyGIPEvolYUCzwepAnvOTNYYdBz0y1rjRVvrOjo=;
        b=Nd+e58ECl5uRQzYfNIQv8BC06SeFP4k34puAgwH+zspPTy4IWhDfYsNyiFl8ptH979
         SKcpP83j19heBiHT1UawcrEG+bDUFgDWz9EjVbNnUh8B75lnBtBJfU4TfOL3U5DqkmjD
         hY/Xss3tjrqAFukafLkEt//zpnISG6uWhMgM+f/gBOCBLuXJF3tR9udgkoa998u1TDKL
         PV3ZoK1R76XCm5Y1ib0+/tGCQrZdkaOz73raYOljl/KeqXQMIt6awOZO4Uxv8zpDsfwn
         EVZKe9knVZqoInUkndq5HLCO9/bFpiqZ6B5Kxsj+a3O/RZrzrMY/Ph3FCNEgx1WomCAk
         iSHg==
X-Gm-Message-State: ABuFfogmHCWaBysFk71a5nHtMnbLtY2klUPMmptIfkH822ZOffF+eauO
        i8rq81zozJFFEN8/jxrb5ec=
X-Google-Smtp-Source: ACcGV61UT64Rkan3OYYWjkL1zlIGdIgQn9DnH1CEsuDXH6F8JMMK7FytqbL7g0j3EuivS8VhP9yfBg==
X-Received: by 2002:a63:5605:: with SMTP id k5-v6mr12873401pgb.189.1538447929839;
        Mon, 01 Oct 2018 19:38:49 -0700 (PDT)
Received: from localhost.localdomain ([39.7.19.27])
        by smtp.gmail.com with ESMTPSA id v83-v6sm35902744pfa.103.2018.10.01.19.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 19:38:48 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 0/3] printk: some pr_cont tweaks and cleanups
Date:   Tue,  2 Oct 2018 11:38:33 +0900
Message-Id: <20181002023836.4487-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	RFC

	Forked from "printk feature for syzbot". Let's have a separate
discussion thread.
	A buch of pr_cont tweaks and cleanups, please see commits and
commits' messages for more details.

Sergey Senozhatsky (3):
  printk: keep kernel cont support always enabled
  printk: lock/unlock console only for new logbuf entries
  printk: do not preliminary split up cont buffer

 kernel/printk/printk.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

-- 
2.19.0

