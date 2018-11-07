Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4D4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F02920862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj3yar3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F02920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeKHFeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:34:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeKHFeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:34:25 -0500
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 959EF20818;
        Wed,  7 Nov 2018 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541620951;
        bh=wTMYW0KJzzpHR61jC1KnlLkuPTJ6PdggDIghMR/gkxw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Bj3yar3PEtsScDZ8o9zccTFwAtnWOdVNsPWDHah/25MuvEHYIwNt29qduaM1G/p/f
         Cn/uS/0WR6o2mziv4QM/c4YDr06bds8KqslxOFtuZAOO5AujzYxSU5YPjsXIsIb7QF
         +Y3QfqrZHMjlLNkumlhVl1rhMca/kBOvc1DNl+Rw=
Subject: Re: [RFC v2 01/14] kunit: test: add KUnit test runner core
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, Shuah Khan <shuah@kernel.org>
References: <20181023235750.103146-1-brendanhiggins@google.com>
 <20181023235750.103146-2-brendanhiggins@google.com>
 <017b111f-d960-c1ef-46ae-eb0eb639fe5b@kernel.org>
 <CAFd5g45KNNGPVh4EBm8vKGdVhqajZZA0TU=CFbceJziYufb0Ug@mail.gmail.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <0149d343-937c-1a99-10ff-d2bcb546e49b@kernel.org>
Date:   Wed, 7 Nov 2018 13:02:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g45KNNGPVh4EBm8vKGdVhqajZZA0TU=CFbceJziYufb0Ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2018 06:28 PM, Brendan Higgins wrote:
> On Fri, Nov 2, 2018 at 11:44 AM Shuah Khan <shuah@kernel.org> wrote:
>>
>> On 10/23/2018 05:57 PM, Brendan Higgins wrote:
> <snip>
>>> + * Example:
>>> + *
>>> + * .. code-block:: c
>>> + *
>>> + *   void add_test_basic(struct test *test)
>>> + *   {
>>> + *           TEST_EXPECT_EQ(test, 1, add(1, 0));
>>> + *           TEST_EXPECT_EQ(test, 2, add(1, 1));
>>> + *           TEST_EXPECT_EQ(test, 0, add(-1, 1));
>>> + *           TEST_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
>>> + *           TEST_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
>>> + *   }
>>> + *
>>> + *   static struct test_case example_test_cases[] = {
>>> + *           TEST_CASE(add_test_basic),
>>> + *           {},
>>> + *   };
>>> + *
>>> + */
>>> +struct test_case {
>>> +     void (*run_case)(struct test *test);
>>> +     const char name[256];
>>> +
>>> +     /* private: internal use only. */
>>> +     bool success;
>>> +};
>>> +
>>
>> Introducing a prefix kunit_* might be a good idea for the API.
>> This comment applies to the rest of patches as well.
> 
> What about kunit_* instead of test_* and kmock_* instead of mock_*?
> Does that seem reasonable?
> 

kunit_* would work well.

thanks,
-- Shuah
