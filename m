Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED71C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BE3217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsVB7dOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfBRTwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:52:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42401 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfBRTwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:52:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so9213428plp.9;
        Mon, 18 Feb 2019 11:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JEPXci3KQI2klfVBfktqeKE5UjX27j54j5u/w1t6njM=;
        b=XsVB7dOp4modAKdRFW+7/ijHREnsb7qLP6ur6KOYfoGO682O8o5SodYK3WkuQa3fww
         bJekk3q0RSaGWhidOU7/8j2XOOazNhZ4PbPsdNwhLJ4XjaYakFqJ9seB9e9WswsS2ytd
         NaYQ4jh4DF7kPmfDf5DqlNa2CJ0V62nTBhHAvmHU/29b712dUIpdbz3usdoQnFlhF9HZ
         /2yp2yvO+QU55tIWC6JL5B/pHzE0Suxddb68wzK9FolUGrLhXcPsdyf760AQ/2mz9aAY
         Hh5Z+RWGSOk9F7y3cGPHXiAVWMfxfbf0V3bu5fVYf2ghdI79T8Lhm/Xy+FcXSST19yzI
         J0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JEPXci3KQI2klfVBfktqeKE5UjX27j54j5u/w1t6njM=;
        b=e+fc369uw9hgCE/vG0HGJDgSlwLqJhV0WesfCs85Hj3I6isQlN7M08S9KMI2dIqxWq
         wiH1YI7eVxZJrshUQBLOq0g6g3/wANDPeYOS18mbSZSzVCqCd8ibsAFvmniqDWmcZ/Nt
         HdI4VJ1XTMlM7HdGVXHjYyrb1+yex1rEekvtsGqMcwu8O9DrF19U0HWrJD0uSVwqCpra
         4Osn+nYAnGXiBjinAUGLulwyRWCP4A4XpbAYJrSOJx0256M81vxVOfh0DBA52vIzKT55
         6eYgauDlIkKRqNLui5hk9EmBs4F5Sid56vZJt6/AZgAc/cuuV7ybxGDwjLfAOAgYYh6j
         f3Sg==
X-Gm-Message-State: AHQUAub5PB+pi9jBgiGcQ0RgxVnn890hg9bKEV/Dzt1cwL1DdzxPgwpy
        y0ZcqxyKfvo1EBCDVdYRzvY=
X-Google-Smtp-Source: AHgI3IaHfF0xeNU3nsTqBNbvRHMP45E49KKY4SxHMqIYceeKw2abxZ1zNqiFC7Vj9ZoK+9oIFQf+wQ==
X-Received: by 2002:a17:902:e18c:: with SMTP id cd12mr25983536plb.279.1550519560714;
        Mon, 18 Feb 2019 11:52:40 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id e123sm26852981pgc.14.2019.02.18.11.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 11:52:40 -0800 (PST)
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
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
 <20190214213729.21702-9-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <da1995fa-a362-dfe6-8184-7fcdf2b923e8@gmail.com>
Date:   Mon, 18 Feb 2019 11:52:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190214213729.21702-9-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 1:37 PM, Brendan Higgins wrote:
> Add support for aborting/bailing out of test cases. Needed for
> implementing assertions.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> Changes Since Last Version
>  - This patch is new introducing a new cross-architecture way to abort
>    out of a test case (needed for KUNIT_ASSERT_*, see next patch for
>    details).
>  - On a side note, this is not a complete replacement for the UML abort
>    mechanism, but covers the majority of necessary functionality. UML
>    architecture specific featurs have been dropped from the initial
>    patchset.
> ---
>  include/kunit/test.h |  24 +++++
>  kunit/Makefile       |   3 +-
>  kunit/test-test.c    | 127 ++++++++++++++++++++++++++
>  kunit/test.c         | 208 +++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 353 insertions(+), 9 deletions(-)
>  create mode 100644 kunit/test-test.c

< snip >

> diff --git a/kunit/test.c b/kunit/test.c
> index d18c50d5ed671..6e5244642ab07 100644
> --- a/kunit/test.c
> +++ b/kunit/test.c
> @@ -6,9 +6,9 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>  
> -#include <linux/sched.h>
>  #include <linux/sched/debug.h>
> -#include <os.h>
> +#include <linux/completion.h>
> +#include <linux/kthread.h>
>  #include <kunit/test.h>
>  
>  static bool kunit_get_success(struct kunit *test)
> @@ -32,6 +32,27 @@ static void kunit_set_success(struct kunit *test, bool success)
>  	spin_unlock_irqrestore(&test->lock, flags);
>  }
>  
> +static bool kunit_get_death_test(struct kunit *test)
> +{
> +	unsigned long flags;
> +	bool death_test;
> +
> +	spin_lock_irqsave(&test->lock, flags);
> +	death_test = test->death_test;
> +	spin_unlock_irqrestore(&test->lock, flags);
> +
> +	return death_test;
> +}
> +
> +static void kunit_set_death_test(struct kunit *test, bool death_test)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&test->lock, flags);
> +	test->death_test = death_test;
> +	spin_unlock_irqrestore(&test->lock, flags);
> +}
> +
>  static int kunit_vprintk_emit(const struct kunit *test,
>  			      int level,
>  			      const char *fmt,
> @@ -70,13 +91,29 @@ static void kunit_fail(struct kunit *test, struct kunit_stream *stream)
>  	stream->commit(stream);
>  }
>  
> +static void __noreturn kunit_abort(struct kunit *test)
> +{
> +	kunit_set_death_test(test, true);
> +
> +	test->try_catch.throw(&test->try_catch);
> +
> +	/*
> +	 * Throw could not abort from test.
> +	 */
> +	kunit_err(test, "Throw could not abort from test!");
> +	show_stack(NULL, NULL);
> +	BUG();

kunit_abort() is what will be call as the result of an assert failure.

BUG(), which is a panic, which is crashing the system is not acceptable
in the Linux kernel.  You will just annoy Linus if you submit this.

-Frank

< snip >
