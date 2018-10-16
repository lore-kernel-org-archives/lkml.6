Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AC6C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4244D2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7sM1dfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4244D2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeJQHqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:46:15 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:56215 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbeJQHqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:46:15 -0400
Received: by mail-qt1-f202.google.com with SMTP id 4-v6so25589071qtt.22
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gQdq5fFuo7J9iL+wWi/DYDZLWnOLQeSM2bBV4pqEMaU=;
        b=u7sM1dfw3W6YLtoL2O1mN3AkSjvkrHRDFsdiv3JxZ70XRYQo2/vGFQvAcYCK8DPx0B
         uxahW/Pvcr9RGuWdh29GATWj8ZnxmzHutuM90DLwgn9CTt2QrLn93j4zIwyXInYjYV7I
         DM1jOBXynBdZQuqKtlRh76DPZ1EPukEZapzU0hq20BAMCl1CApBsrHRdTaEG55I5bBXh
         1h48qJV7HWjKvXe5MErtT4ufNipg2YcD0OQYV0AYPnO9rrDXPSoH5LMJhFthGRFSqNOf
         QoSWFQEh3PQX+JIftNoyKafCvUzcEBzM0mqb34HR458N921ITPegfQn08OKLuwihxjrh
         +eXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gQdq5fFuo7J9iL+wWi/DYDZLWnOLQeSM2bBV4pqEMaU=;
        b=j5X/P/a/7dsEIKuMH0rO2NnV6iIaIpxjoBNeJzqmte/Q6gxfLmU4Rya/MvfG2YTcKI
         zJh+GtIzYW5IZpe9NJp5A0lVYNptw+IR50WW9V2fPVEs21cEc/ZoE0e+3ZnSY0HSqfX/
         NPVZoQzcInc2+R1AKA7IK3P2c2F8MvQ2yenN7uiG+f1mNxxIg+ZjY5+fWuKN6Xl1ZzwS
         s1RvoC7M1OFgH8SBLv99ISK57OHFmjhGzNF45hsXjtwygWAEjTAdLDGIJyyJSCEPsaXX
         0dmBLwZhWC3YsxU2OrR2Lb1jnoiMgqOXKY0ggddogvMzCFR+kUodroxXPn5/JavHJBMC
         4bgA==
X-Gm-Message-State: ABuFfoh/ot8z+WsAJsDIxH9JgONAdqLzjUeslaywiUtUphf37t1B7Vbx
        a786u8UhU3h0Clmp6l/0rzsoWI/dN3PUWipqaRfZKg==
X-Google-Smtp-Source: ACcGV6189le67K3C7ljYXSE78Y2eccwuuQt4t2ajkYLMbvrcRRjMhmvJKEIPJO9MaydmIoClUvPNiwfvBYIuEY0NbQFwvw==
X-Received: by 2002:aed:23ac:: with SMTP id j41-v6mr18937185qtc.5.1539734006237;
 Tue, 16 Oct 2018 16:53:26 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:50:49 -0700
Message-Id: <20181016235120.138227-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
 testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set proposes KUnit, a lightweight unit testing and mocking
framework for the Linux kernel.

Unlike Autotest and kselftest, KUnit is a true unit testing framework;
it does not require installing the kernel on a test machine or in a VM
and does not require tests to be written in userspace running on a host
kernel. Additionally, KUnit is fast: From invocation to completion KUnit
can run several dozen tests in under a second. Currently, the entire
KUnit test suite for KUnit runs in under a second from the initial
invocation (build time excluded).

KUnit is heavily inspired by JUnit, Python's unittest.mock, and
Googletest/Googlemock for C++. KUnit provides facilities for defining
unit test cases, grouping related test cases into test suites, providing
common infrastructure for running tests, mocking, spying, and much more.

## What's so special about unit testing?

A unit test is supposed to test a single unit of code in isolation,
hence the name. There should be no dependencies outside the control of
the test; this means no external dependencies, which makes tests orders
of magnitudes faster. Likewise, since there are no external dependencies,
there are no hoops to jump through to run the tests. Additionally, this
makes unit tests deterministic: a failing unit test always indicates a
problem. Finally, because unit tests necessarily have finer granularity,
they are able to test all code paths easily solving the classic problem
of difficulty in exercising error handling code.

## Is KUnit trying to replace other testing frameworks for the kernel?

No. Most existing tests for the Linux kernel are end-to-end tests, which
have their place. A well tested system has lots of unit tests, a
reasonable number of integration tests, and some end-to-end tests. KUnit
is just trying to address the unit test space which is currently not
being addressed.

## More information on KUnit

There is a bunch of documentation near the end of this patch set that
describes how to use KUnit and best practices for writing unit tests.
For convenience I am hosting the compiled docs here:
https://google.github.io/kunit-docs/third_party/kernel/docs/

-- 
2.19.1.331.ge82ca0e54c-goog

