Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6C9C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461122171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfA1Xqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:46:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45971 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfA1Xqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:46:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so8730467pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 15:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UQCk2IeQLJhFVYRcx+5p7K8bgJVFi5NiWJVUUw5Mx14=;
        b=PkmABJJrldMSvx6rLYnjYTULQPtTN0dSwNPzuXbijyo2ZIKh5OdZ2avhaeMwCH+/yj
         hdA4hyCJ8WJLsjxqnqYSBOYfRH0Ia/9MijPnRL2rez8TKTNMId45w95Zebn2HjABUk2c
         LV6+hunCfxYMi4ABfMI9COL5hUXO0qplmcQij6D7G86iGORG4XJVQ0ZMk7KH8/6zOjwa
         CJTDxKu5ms1touVhyzc+Xl3xalyzzx+n9qT/gADa3lfNW2K+WmEfQ/KiJvUKpzuYwami
         1qSNR2GG/AaYcTjm1xAcDQc+DMG0YvRlMWoG2XRS0LVgmk4QMqv5tANXxp0i06kQv62n
         8Nrg==
X-Gm-Message-State: AJcUukd/u06Jr+UpsMa8GP41Mil0FdFAglza3lGlCSwqlF+rLu0o5AZO
        0UimBzC9YL24D6XbWOACWebbjw==
X-Google-Smtp-Source: ALg8bN7QQ0l8+6JDMRy8nEF1EK0CH0mAutYQvW1fynCA3YwHMnNap3wCpN8jJUgkJaeoCCvaqs9FYg==
X-Received: by 2002:a63:6906:: with SMTP id e6mr21271232pgc.144.1548719196275;
        Mon, 28 Jan 2019 15:46:36 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f67sm52473331pfc.141.2019.01.28.15.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 15:46:35 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/2] softirq: Don't skip softirq execution when softirq thread is parking
Date:   Mon, 28 Jan 2019 15:46:23 -0800
Message-Id: <20190128234625.78241-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Kaehlcke (2):
  kthread: Add __kthread_should_park()
  softirq: Don't skip softirq execution when softirq thread is parking

 include/linux/kthread.h | 1 +
 kernel/kthread.c        | 8 +++++++-
 kernel/softirq.c        | 3 ++-
 3 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.20.1.495.gaa96b0ce6b-goog

