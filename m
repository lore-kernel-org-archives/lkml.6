Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9C0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2551D206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBVUzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:55:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35360 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfBVUzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:55:11 -0500
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gxHp0-0000Fv-D8
        for linux-kernel@vger.kernel.org; Fri, 22 Feb 2019 20:53:26 +0000
Received: by mail-wm1-f70.google.com with SMTP id g19so488675wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4VJ9JmshK8eifbcs0LbzgsfhsoR86SEK3Zw3F0Q9Js=;
        b=Bt3a8P1ATrFlidCgfngDTeC/ao1IC59oAw8mogZ3W7K4Y04PKhtuyr03yLFUEwZax2
         9D3RCWYhlNGeRAGoii4Gnqt/Y70ZkmaGhiCYfVOB/Bv0H9DMzosfKz519RJ36+mUiv8o
         GF/WkB9laqtD+a+ySlu3Xa6qYIUPFVs54itSOZ5DmMMzxYTiwAP8wOl5roBHYrjAehA1
         2PhC3NGhCFqRclks1N4ejeMaA8GVOM96MEWy3AgpDwGZ7NoonVz6AhhBnRhhB/tAe3VB
         b5rbkOEEgbHIOpWMxocn/SE+VeESsm7g7TfFomE4t4eEIaKKnsjUXkSRD0Rf03C1BhqC
         GWTQ==
X-Gm-Message-State: AHQUAuYKcjHK2ICXTmS+xgvc6EH8I3Qwhq7iGqk4124XBOONshA9uMEA
        FLIxVBtmUkld4/F+Fc6BrgY7VLyGT4fF02uGBtfsk+pWJxjxie7wpnh597K8i1kxkDKtp4okDUQ
        KbGB4RsnHH2psX+cYfA8idwGToKzsHuahtwUu2LId1A==
X-Received: by 2002:a5d:5544:: with SMTP id g4mr4181284wrw.269.1550868805895;
        Fri, 22 Feb 2019 12:53:25 -0800 (PST)
X-Google-Smtp-Source: AHgI3IbpRz321ejnU7aMXQFPW2BADCdqzIOkSKdFrmwVwFsGhNT1DLcvVfVx6m0gUlNPzgb0rTRD5w==
X-Received: by 2002:a5d:5544:: with SMTP id g4mr4181278wrw.269.1550868805704;
        Fri, 22 Feb 2019 12:53:25 -0800 (PST)
Received: from smeagol.c.hoisthospitality.com ([194.158.46.138])
        by smtp.gmail.com with ESMTPSA id j124sm2514415wmb.48.2019.02.22.12.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:53:25 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [RESEND PATCH v2 0/2] selftests/ftrace: Make ftracetest POSIX compliant
Date:   Fri, 22 Feb 2019 21:53:16 +0100
Message-Id: <20190222205318.689-1-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222091021.10178-1-juergh@canonical.com>
References: <20190222091021.10178-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shuah@kernel.org and linux-kselftest@vger.kernel.org.

The recent addition of colored output introduced some non-POSIX-compliant
constructs. Fix that.

Juerg Haefliger (2):
  selftests/ftrace: Replace echo -e with printf
  selftests/ftrace: Replace \e with \033

 tools/testing/selftests/ftrace/ftracetest | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
2.19.1

