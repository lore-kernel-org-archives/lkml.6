Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAD1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65740205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sY3yGXUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65740205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbeK2Gj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:39:56 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:54380 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeK2Gj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:39:56 -0500
Received: by mail-qk1-f202.google.com with SMTP id v74so27360514qkb.21
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=99nVbqfKL8VgOyeZOYLd9fGPS1EwErpNGV1fQd8c1qI=;
        b=sY3yGXUB7UeexaSMFHiqXwQqWJc1kjASLGdzGosIcyV73/cIl5rC3ujnaaFiogt+qr
         3UE0kqZrHe4N0ZtFk/g86WTYoPDbzISqGuduMrCxPQwcp5oXsOu032M3QYhSlkD2IzRM
         TnlBclywIp4pcV6BZG0eZh1pFbgKpOhPIVc6DS8FUrhoeCIJFCt8JEPCwtviX2ht06z/
         9+mzN2WmSwCSedYDp3xYEWab6D3TeVKlxQSvba8+nnsvOP5NYDb3usBmFA4lHcOxbI2b
         uFGVzNcSo+M+swI0AtqlEZDDIHixe4xlolsVlF1r81+Naprqiegt/QdNILlqOCQoHtDn
         JNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=99nVbqfKL8VgOyeZOYLd9fGPS1EwErpNGV1fQd8c1qI=;
        b=Cprz2kkMuj0sQzIdHotRbOEjlwosj/6ZAF1X+tEe83YGCG5rdyroBnrPyJATyyrloq
         LrYHgyTHCaoPKcw0JNBZuMKnojlw3iYoROZaoAiUW0NZ+Ys936Ik5p2YiwwYG5cxxCbH
         nuswvHGEm4RsR+yM6SjxcYU8LymWiEJ/T4H3lOXjE0d6s68Hsp9dIkddpGJOFzif2Ryx
         IFbW9IVCzbkDP+90nEp+JOmJS5Kl27+JB1W/WbxQZ2j0XSRqBy7qIACyw4/ZJInP/jtR
         RFVNNtVXfGiSLGfT3uO1nCrtboaRU8byibS8OKc2HLFU29pGgQEVyyC+M8fMm43xGBLL
         V0Tw==
X-Gm-Message-State: AA+aEWYpmqV9qgoznVN6nyX7tI+bPGpOD09l+9I/TReZoQkPRW+eaqeg
        ypilpZ/IHl5nLkFMTDuy/17MbFaYOTVUrARxnGKKWA==
X-Google-Smtp-Source: AFSGD/VCWycCbDmFp6Z5qNxzgmexxk1/jZS8YbUaoMOmSU6YkTfkM2zG1R/OjWIDtfLq/fQe62iAC1tOjqPaVFw87UApQA==
X-Received: by 2002:ac8:7244:: with SMTP id l4mr4486112qtp.21.1543433831218;
 Wed, 28 Nov 2018 11:37:11 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:36:17 -0800
Message-Id: <20181128193636.254378-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [RFC v3 00/19] kunit: introduce KUnit, the Linux kernel unit testing framework
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
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com, Brendan Higgins <brendanhiggins@google.com>
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
Additionally for convenience, I have applied these patches to a branch:
https://kunit.googlesource.com/linux/+/kunit/rfc/4.19/v3
The repo may be cloned with:
git clone https://kunit.googlesource.com/linux
This patchset is on the kunit/rfc/4.19/v3 branch.

## Changes Since Last Version

 - Changed namespace prefix from `test_*` to `kunit_*` as requested by
   Shuah.
 - Started converting/cleaning up the device tree unittest to use KUnit.
 - Started adding KUnit expectations with custom messages.

-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

