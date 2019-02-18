Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB03A217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7DulkjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfBRUCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:02:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38522 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBRUC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:02:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so9236641plb.5;
        Mon, 18 Feb 2019 12:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zFy0qC5hoVx2qztUjByA/pAinuKIgai5yAnGoAOF3dM=;
        b=N7DulkjEtxgvSTpLr8CHNtCDH2SU14RdRsf58Su1sItGpVMGKJJnIlKJskX80RlgSQ
         NdeQG2ogskQSrnGDSROZg5tYBUv1TCE/b0VkC+l/Up/RzPMNBWEjpw7S3hUy1Au9UrQm
         JOHv9m+68yNSyn+hVVYSZUvA9mPzi+zqEKUQ99OhwU7e4mlW5ur1b/h89ltWE7WYoqCS
         pVIFmCbLIawEJltsVL9P5rBsMtj5Yn3ThfL/H2t7trG8VQAUr33FztMN0/WTN6y1Lsle
         R4MNJ+8+4L2ddR+/dZsqexUEdIEZd8WNAdxqgSRxA8Ci2be7/y+CmFfho3iLLLQUhNSz
         Fg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zFy0qC5hoVx2qztUjByA/pAinuKIgai5yAnGoAOF3dM=;
        b=l04lQ6htVxAssgUnRbQFgyNDfO4PisgixEPHtc0mEdVcJrALuK6SSFDv9c7abKNRZA
         iklj4QNBlUgUcIOSIqxPZNcKfvhZTRkkyaQbwfqfN96iG8GZ9R0N1emLZ82AFmNcgYrL
         xuo63ACVkASWef0iwXxaBtUnIQ+/UIwnbTSKZHFCxdu1OXZ5Bgw88gYdCWodsdIDQxO4
         VE/lv9hn5IZinWemog3rKL3xaUlkVPRzxA1kvtslplZYC9s+PUjDPztZyJekvCOG8TmS
         ln4yUSR0F2c02IBUEr0lROEQA+WROBztwSDQPgy1cV9u0tvPlptIrRnuC6WG/JihpaDm
         HqKQ==
X-Gm-Message-State: AHQUAua2UPgwvTLjKttq0YmyR47qr97t3VNU0UJkSU2vw7dTmczAfeA1
        /YyoL9U9hnSvDZaorfsi6xw=
X-Google-Smtp-Source: AHgI3IYUbAcYcTjGfdzYpdT1KGIwMkouhhnPyFehNsyCMlBO8kadBET8PmI2mnlQ5DMkRO2GL+MI7w==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr27578143plf.202.1550520148334;
        Mon, 18 Feb 2019 12:02:28 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n73sm20458162pfj.148.2019.02.18.12.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 12:02:27 -0800 (PST)
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>, keescook@google.com,
        mcgrof@kernel.org, shuah@kernel.org, robh@kernel.org,
        kieran.bingham@ideasonboard.com
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        linux-um@lists.infradead.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, knut.omang@oracle.com,
        devicetree@vger.kernel.org, pmladek@suse.com,
        Alexander.Levin@microsoft.com, amir73il@gmail.com,
        dan.carpenter@oracle.com, wfg@linux.intel.com
References: <20190214213729.21702-1-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a6ae907e-391b-993e-6011-6f40c761b339@gmail.com>
Date:   Mon, 18 Feb 2019 12:02:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190214213729.21702-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 1:37 PM, Brendan Higgins wrote:
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
> makes unit tests deterministic: a failing unit test always indicates a
> problem. Finally, because unit tests necessarily have finer granularity,
> they are able to test all code paths easily solving the classic problem
> of difficulty in exercising error handling code.
> 
> ## Is KUnit trying to replace other testing frameworks for the kernel?
> 
> No. Most existing tests for the Linux kernel are end-to-end tests, which
> have their place. A well tested system has lots of unit tests, a
> reasonable number of integration tests, and some end-to-end tests. KUnit
> is just trying to address the unit test space which is currently not
> being addressed.
> 
> ## More information on KUnit
> 
> There is a bunch of documentation near the end of this patch set that
> describes how to use KUnit and best practices for writing unit tests.
> For convenience I am hosting the compiled docs here:
> https://google.github.io/kunit-docs/third_party/kernel/docs/
> Additionally for convenience, I have applied these patches to a branch:
> https://kunit.googlesource.com/linux/+/kunit/rfc/5.0-rc5/v4
> The repo may be cloned with:
> git clone https://kunit.googlesource.com/linux
> This patchset is on the kunit/rfc/5.0-rc5/v4 branch.
> 
> ## Changes Since Last Version
> 
>  - Got KUnit working on (hypothetically) all architectures (tested on
>    x86), as per Rob's (and other's) request
>  - Punting all KUnit features/patches depending on UML for now.
>  - Broke out UML specific support into arch/um/* as per "[RFC v3 01/19]
>    kunit: test: add KUnit test runner core", as requested by Luis.
>  - Added support to kunit_tool to allow it to build kernels in external
>    directories, as suggested by Kieran.
>  - Added a UML defconfig, and a config fragment for KUnit as suggested
>    by Kieran and Luis.
>  - Cleaned up, and reformatted a bunch of stuff.
> 

I have not read through the patches in any detail.  I have read some of
the code to try to understand the patches to the devicetree unit tests.
So that may limit how valid my comments below are.

I found the code difficult to read in places where it should have been
much simpler to read.  Structuring the code in a pseudo object oriented
style meant that everywhere in a code path that I encountered a dynamic
function call, I had to go find where that dynamic function call was
initialized (and being the cautious person that I am, verify that
no where else was the value of that dynamic function call).  With
primitive vi and tags, that search would have instead just been a
simple key press (or at worst a few keys) if hard coded function
calls were done instead of dynamic function calls.  In the code paths
that I looked at, I did not see any case of a dynamic function being
anything other than the value it was originally initialized as.
There may be such cases, I did not read the entire patch set.  There
may also be cases envisioned in the architects mind of how this
flexibility may be of future value.  Dunno.

-Frank
