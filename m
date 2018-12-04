Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FB1C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206F920878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMDWhHmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206F920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeLDKwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:52:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46884 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDKwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:52:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so8095545ply.13;
        Tue, 04 Dec 2018 02:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3JGB9Rk8uh7bmDIvBxKSn8FwKCVRpWf8R2IWACPKkq4=;
        b=nMDWhHmDDVM4w+qva0l7MUwlmSLPu9dS9NXYp+EvzHCfNNmAw5D0OZxlulW3bIB7E0
         jt60t+fWrnpqLWySb0Zs8fsXq8zlx3jKL4kroL8QyTB2aPSXWSXPQHYEbmtN/172VeJP
         FzxfzoLFfopaaP5Vyx9LIbnX6K2SOl98RnoRGdvUNF89zRysvbd+gFzMrhgEFzasgQqD
         7Hymq1TMFfuLl/UNZaWikdRW224ABvM8d1HVFqlfL+i74rsD3UJ31absJdHd3G5zV513
         COvid2GFkNhNKCv+lupiEX+B930uH4ihCG2JGQJ6WRjipqXyYHJ134IbPdDdDIqMtiXK
         A51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3JGB9Rk8uh7bmDIvBxKSn8FwKCVRpWf8R2IWACPKkq4=;
        b=lSQzY360H4/fKqK6EANB0IWQOW5Spc1HXHqDWimzPkquB+fL7My0DhbK0Tb9ukk67/
         5cIpkfej2TxL5LRDH/2EJwXZbVifwiPZAsmaMC8V6rnFDoU2dguMnqLSUGTWIBnsna+Y
         IKMKNwcVxDA1awE3HDuoYJgzTX77AZFkLL1ossDrq8OPRLWwdwjEV55/mOWfWmmKut1H
         7dmrZ3NEg53b6H2gvOoKz50fueqfH56nIcwEFrga1c+vptQXzJeUjD6U+PQmwO0uxN7O
         w+GKHQfA/j38oR73FtEK2iiDMnyWvOlPgVwMZzcEOz3lFzhneLuMN+4mAiazNt3CTBfa
         Y8Qg==
X-Gm-Message-State: AA+aEWZvmZtQQB+fVa+bucz2QcFB16HX6sVNTyX2aIl77PB+r4EPpVYB
        /Qr73kxNSoh2T0XDw08Zl1o=
X-Google-Smtp-Source: AFSGD/XuQ2S5TNFJyQydO+LDs8TrcghFEq4S/2Mn1hnjBELALdxaXjTqj3YOaB7+rO5UT2LEfOH7nQ==
X-Received: by 2002:a17:902:714c:: with SMTP id u12mr19320476plm.234.1543920739006;
        Tue, 04 Dec 2018 02:52:19 -0800 (PST)
Received: from [10.231.245.170] ([125.29.25.186])
        by smtp.gmail.com with ESMTPSA id c23sm23354191pfi.83.2018.12.04.02.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 02:52:18 -0800 (PST)
Subject: Re: [RFC v3 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, knut.omang@oracle.com
References: <20181128193636.254378-1-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <8807ac55-44e7-0ab7-176d-a0f71bff07e6@gmail.com>
Date:   Tue, 4 Dec 2018 02:52:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/18 11:36 AM, Brendan Higgins wrote:
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.
> 
> Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> it does not require installing the kernel on a test machine or in a VM
> and does not require tests to be written in userspace running on a host
> kernel. Additionally, KUnit is fast: From invocation to completion KUnit
> can run several dozen tests in under a second. Currently, the entire
> KUnit test suite for KUnit runs in under a second from the initial
> invocation (build time excluded).
> 
> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> Googletest/Googlemock for C++. KUnit provides facilities for defining
> unit test cases, grouping related test cases into test suites, providing
> common infrastructure for running tests, mocking, spying, and much more.
> 
> ## What's so special about unit testing?
> 


> A unit test is supposed to test a single unit of code in isolation,
> hence the name. There should be no dependencies outside the control of
> the test; this means no external dependencies, which makes tests orders
> of magnitudes faster. Likewise, since there are no external dependencies,
> there are no hoops to jump through to run the tests. Additionally, this

This question might be a misunderstanding of the intent of some of the
terminology in the above paragraph, so this is mostly a request for
clarification.

With my pre-conception of what unit tests are, I read "test a single unit
of code" to mean a relatively narrow piece of a subsystem.  So if I
understand correctly, taking examples from patch 17 "of: unittest:
migrate tests to run on KUnit", each function call like
KUNIT_ASSERT_NOT_ERR_OR_NULL(), KUNIT_EXPECT_STREQ_MSG(), and
KUNIT_EXPECT_EQ_MSG() are each a separate unit test, and thus the
paragraph says that each of these function calls should have no
dependencies outside the test.  Do I understand that correctly?

< snip >

-Frank

