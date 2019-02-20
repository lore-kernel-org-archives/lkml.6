Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABD9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBC92147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuCs+nQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfBTGo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:44:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38376 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfBTGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:44:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so9101639pgl.5;
        Tue, 19 Feb 2019 22:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LODZetcs0AnT93QYQC0UK8k2tg9s5tX3hMm2xNga27I=;
        b=kuCs+nQ8OpBtGvxxn3MOBEVS0ZXl2jxhX6B7xop63kucnr/h6FRNrWni4/vUjsEFkL
         cIiISlOypm7kpWLDcoM0QDLRfWtAMbipPeshkasB38UpWyKg8wnIWQKtNAhKClu5DeHc
         LlHCoiIb095x6B9b0bAkO3WvWDgzQCP3GEX1ts2Qgb8w+MeASdpx/Semtt1qqNYRWWxO
         txiXo0ObyFyknmeZjeut1sP4UbBU7igHfZy5ut3gmi9oapA64ETjmol+7DCdL+HwNdoa
         bIjqKPSKMPt7Ga+XmeNpQiT4Sc9xVrDWHoB09N+cUshH2e0kJ0WmGaou5RvS+78wABkX
         mvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LODZetcs0AnT93QYQC0UK8k2tg9s5tX3hMm2xNga27I=;
        b=I+xVRXmWLrxvZzmKaU//R5Np7Ufqe0XTEegLmNTpDfHV/bcjFFgziVlokqJOit+Ej/
         7CBk3L7jMkytWe5jql0LWBzKE8Dw3qYrVE/leSs/k8sKqyPqajHgOeaG/fUIyGSPwh9L
         +IGWK0DRynv2lnRXub+yir0gymYAsQAYK9tfhJFzjwAw2KruIHAqrx+K7lShPz4UmLZQ
         icquJW41Nh9Ka12C3sBQ4DCaMqFAWTHxIAr6WCz9JkcPDrP0ZSeBzsVzuDchnVTBe7X9
         L6lXpXFktNJHYndmEOleqzGgZte3IGTP5djs9Kp0oViaAIkvJU47bex36a1L3YL3PG/H
         ImlA==
X-Gm-Message-State: AHQUAuZMCI7FitygYXMNI4U+vhlMDB10049N6FLhg6l+FLeTqXgX25DY
        GFIhZXn9NskHA1Afftiu230=
X-Google-Smtp-Source: AHgI3IaVDLLPrpXPyepLnXpS5y5DLdE5s7gpZiK++Lv+zkzCTtdSXTG08jFKlv0mfXMolajrPrODlA==
X-Received: by 2002:a63:7444:: with SMTP id e4mr4762824pgn.398.1550645067019;
        Tue, 19 Feb 2019 22:44:27 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id s21sm35375176pfk.133.2019.02.19.22.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 22:44:26 -0800 (PST)
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>, dan.carpenter@oracle.com,
        wfg@linux.intel.com
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-9-brendanhiggins@google.com>
 <da1995fa-a362-dfe6-8184-7fcdf2b923e8@gmail.com>
 <CAFd5g467OV8wTB7zEshgZw8g8=zoq0dLVfwx3wDH-8UA+9GWFA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <0124ed28-466c-e954-ddde-495419630a9f@gmail.com>
Date:   Tue, 19 Feb 2019 22:44:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g467OV8wTB7zEshgZw8g8=zoq0dLVfwx3wDH-8UA+9GWFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/19 7:39 PM, Brendan Higgins wrote:
> On Mon, Feb 18, 2019 at 11:52 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 2/14/19 1:37 PM, Brendan Higgins wrote:
>>> Add support for aborting/bailing out of test cases. Needed for
>>> implementing assertions.
>>>
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>> ---
>>> Changes Since Last Version
>>>  - This patch is new introducing a new cross-architecture way to abort
>>>    out of a test case (needed for KUNIT_ASSERT_*, see next patch for
>>>    details).
>>>  - On a side note, this is not a complete replacement for the UML abort
>>>    mechanism, but covers the majority of necessary functionality. UML
>>>    architecture specific featurs have been dropped from the initial
>>>    patchset.
>>> ---
>>>  include/kunit/test.h |  24 +++++
>>>  kunit/Makefile       |   3 +-
>>>  kunit/test-test.c    | 127 ++++++++++++++++++++++++++
>>>  kunit/test.c         | 208 +++++++++++++++++++++++++++++++++++++++++--
>>>  4 files changed, 353 insertions(+), 9 deletions(-)
>>>  create mode 100644 kunit/test-test.c
>>
>> < snip >
>>
>>> diff --git a/kunit/test.c b/kunit/test.c
>>> index d18c50d5ed671..6e5244642ab07 100644
>>> --- a/kunit/test.c
>>> +++ b/kunit/test.c
>>> @@ -6,9 +6,9 @@
>>>   * Author: Brendan Higgins <brendanhiggins@google.com>
>>>   */
>>>
>>> -#include <linux/sched.h>
>>>  #include <linux/sched/debug.h>
>>> -#include <os.h>
>>> +#include <linux/completion.h>
>>> +#include <linux/kthread.h>
>>>  #include <kunit/test.h>
>>>
>>>  static bool kunit_get_success(struct kunit *test)
>>> @@ -32,6 +32,27 @@ static void kunit_set_success(struct kunit *test, bool success)
>>>       spin_unlock_irqrestore(&test->lock, flags);
>>>  }
>>>
>>> +static bool kunit_get_death_test(struct kunit *test)
>>> +{
>>> +     unsigned long flags;
>>> +     bool death_test;
>>> +
>>> +     spin_lock_irqsave(&test->lock, flags);
>>> +     death_test = test->death_test;
>>> +     spin_unlock_irqrestore(&test->lock, flags);
>>> +
>>> +     return death_test;
>>> +}
>>> +
>>> +static void kunit_set_death_test(struct kunit *test, bool death_test)
>>> +{
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&test->lock, flags);
>>> +     test->death_test = death_test;
>>> +     spin_unlock_irqrestore(&test->lock, flags);
>>> +}
>>> +
>>>  static int kunit_vprintk_emit(const struct kunit *test,
>>>                             int level,
>>>                             const char *fmt,
>>> @@ -70,13 +91,29 @@ static void kunit_fail(struct kunit *test, struct kunit_stream *stream)
>>>       stream->commit(stream);
>>>  }
>>>
>>> +static void __noreturn kunit_abort(struct kunit *test)
>>> +{
>>> +     kunit_set_death_test(test, true);
>>> +
>>> +     test->try_catch.throw(&test->try_catch);
>>> +
>>> +     /*
>>> +      * Throw could not abort from test.
>>> +      */
>>> +     kunit_err(test, "Throw could not abort from test!");
>>> +     show_stack(NULL, NULL);
>>> +     BUG();
>>
>> kunit_abort() is what will be call as the result of an assert failure.
> 
> Yep. Does that need clarified somewhere.
>>
>> BUG(), which is a panic, which is crashing the system is not acceptable
>> in the Linux kernel.  You will just annoy Linus if you submit this.
> 
> Sorry, I thought this was an acceptable use case since, a) this should
> never be compiled in a production kernel, b) we are in a pretty bad,
> unpredictable state if we get here and keep going. I think you might
> have said elsewhere that you think "a" is not valid? In any case, I
> can replace this with a WARN, would that be acceptable?

A WARN may or may not make sense, depending on the context.  It may
be sufficient to simply report a test failure (as in the old version
of case (2) below.

Answers to "a)" and "b)":

a) it might be in a production kernel

a') it is not acceptable in my development kernel either

b) No.  You don't crash a developer's kernel either unless it is
required to avoid data corruption.

b') And you can not do replacements like:

(1) in of_unittest_check_tree_linkage()

-----  old  -----

        if (!of_root)
                return;

-----  new  -----

        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, of_root);

(2) in of_unittest_property_string()

-----  old  -----

        /* of_property_read_string_index() tests */
        rc = of_property_read_string_index(np, "string-property", 0, strings);
        unittest(rc == 0 && !strcmp(strings[0], "foobar"), "of_property_read_string_index() failure; rc=%i\n", rc);

-----  new  -----

        /* of_property_read_string_index() tests */
        rc = of_property_read_string_index(np, "string-property", 0, strings);
        KUNIT_ASSERT_EQ(test, rc, 0);
        KUNIT_EXPECT_STREQ(test, strings[0], "foobar");


If a test fails, that is no reason to abort testing.  The remainder of the unit
tests can still run.  There may be cascading failures, but that is ok.
