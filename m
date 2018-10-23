Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF42C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B9920671
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7BqesJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B9920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeJXLt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:49:27 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:57004 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeJXLt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:49:27 -0400
Received: by mail-qk1-f201.google.com with SMTP id l75-v6so3955469qke.23
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 20:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZS2dPkLUDF5rzLuADBdbF55GgpLIevIetdCiSG5eHMw=;
        b=Z7BqesJk5QdbsF7zt5bRUxTXdE3EMzjlx4YZ5rYhcNVYjhIZjSikzed3mJgg1xazPy
         2IhRQlNxnlcddLtGdFKWFr3354ZqRbVH0608EijX2B5ABitG2orNV1s0pwDgEbLKVaw8
         OqrqbzKubtOP9YwLlCcUsf/R5QKeZI9wVm+HnCg5omP+KSP/factrtUpKyJOTj3RkSyM
         GBgpl6qnzZofSzYSI70PB69fk3BJC4vWHkKNn5nYZs9gTifR9BNi7DCp4HADDsNOs2PN
         dhowm35ZYvw/ie6OJOgFu6T6/ablpfb++1aTBJmV/GVM/AQB/Ll5Go1dxN/xdeIRpUrD
         Ul6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZS2dPkLUDF5rzLuADBdbF55GgpLIevIetdCiSG5eHMw=;
        b=WceJ63IhE7ILHi+aAMoe8bmsIVyosshhfo6Cdhx0tznunk8VR4lPXu7Uex+HkGkboJ
         HpGwMyCb+3tCeVN3uFnntgsuUfrEmH0SCGO1wWDTHX6wL5YIdGgqAoOSS80iGs7fTyLN
         kiVNyUTqO6fxaRU9bEaUrxjAhQbM4jre23u3ThuJtcAvDaConMqisy02cdzMSu182w5L
         1A2PN5Jr9/GCVtu/g6AjJT589g1xfoLw2EvvJKxh+cwfP7Ihrb+EgvH1NSesOmpERZEg
         dOf20T+YOmvT3JyHN8s4UnbcvfTM4pS8urpLkGbufoIeqJKG8+4AiXYH4ycPiGnqhQhF
         unng==
X-Gm-Message-State: AGRZ1gKzyAbd7x5G/+qSQf6o1YIg+bR6qMZNoXpLfkF2ujyA5beaquXk
        /H4AmlMujMqDDYAwB968KDu2FYHXwMymwxr50Vaxhw==
X-Google-Smtp-Source: AJdET5e72o3fX8sjy4I2lSUuxpUYKL7PmhaEGhr21zADJYN/VeaMFb5QSPJNWQmQ9FQZ/HRbEAXB3Hg7uI15O3w/xBrKAQ==
X-Received: by 2002:a0c:9e2e:: with SMTP id p46mr338716qve.22.1540339122147;
 Tue, 23 Oct 2018 16:58:42 -0700 (PDT)
Date:   Tue, 23 Oct 2018 16:57:36 -0700
Message-Id: <20181023235750.103146-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC v2 00/14] kunit: introduce KUnit, the Linux kernel unit testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
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

## Changes Since Last Version

 - Updated patchset to apply cleanly on 4.19.
 - Stripped down patchset to focus on just the core features (I dropped
   mocking, spying, and the MMIO stuff for now; you can find these
   patches here: https://kunit-review.googlesource.com/c/linux/+/1132),
   as suggested by Rob.
 - Cleaned up some of the commit messages and tweaked commit order a
   bit based on suggestions.

-- 
2.19.1.568.g152ad8e336-goog

