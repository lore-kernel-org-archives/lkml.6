Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C126DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB1521B1A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc5+reIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfBOCFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:05:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46962 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfBOCFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:05:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id g6so4040034pfh.13;
        Thu, 14 Feb 2019 18:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cQeCnKL3KLXfjx1vM5WnXJGIQOLSIZakVytIUjl8vRc=;
        b=hc5+reIuzf3luIY4sj44NHibatD99qEyGgRZjk+SIjWtDppLN6svCuFG6O9m/jICR/
         PaQoicxPoXo6owudvjJMaR8EmeMS7K528IKE0TCYol/ea2dNYFTN+/T79TiEgtX+LT5b
         frIjoRFm4/kDOYr3IMJf2J5cRJQL41C3Rh9E9ZdiKKZ7zS4VNb3Rh+lOMS6cfY6E9rh8
         N8NlzRCP/M26TO+/1zAxlKBpWtfemHasEsFMobFNiB/ospu77rSrbk4GXcQICf+L3Lkn
         Jo9Q8opNT6VYYmb8Bi6ZOyONxXjWqE6ulQSwbp2dSZQRB0ghvA4q3r6SRjgxJ9FaX69K
         0osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cQeCnKL3KLXfjx1vM5WnXJGIQOLSIZakVytIUjl8vRc=;
        b=ZDEyMju8Lib06fJ9yvtrd68+qeyQFU0YTPXOXoRc5qALPLo5ZkSy2G34INMGw871P6
         oPnzmHkSsah8UEcBixAFrCVh0Kz4FnZGohin2vjuBMNUr5aTBrexNbLNGIpFWtENKQNe
         xdGdzWxA2P557qU180B6lVzvWmMprt1HzNFRWtjdL9maZFux7wGA9L3WfRDJFI2YwWGV
         l1CorgeSKbAUh54RyVpkTHxWgdmBy6V1DJUqGbwJnOWXZ29dP1pecuAWhE9sCftDhtae
         9Rsfgw4ZfjdHL/orW7tqjg2qptAGWs7OL81ucrymuFA+lXNGfQynWj8+3Y4U67Yt0zDv
         NKWw==
X-Gm-Message-State: AHQUAuYDmxaQJMjMBOH431PPRrV6TA/3AtNlLJ8EIs/t6CPq6x7jklnt
        gG98hmGYJ0K3Z6zwDjBjnoA=
X-Google-Smtp-Source: AHgI3IbiwhrImCi/sROY/nOcvVPMXib0kuPG/S5xdqMnMboyZ5oWPYoIdqXPn8a6wasBwXvRPRctXQ==
X-Received: by 2002:a63:440d:: with SMTP id r13mr2976861pga.5.1550196351190;
        Thu, 14 Feb 2019 18:05:51 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id z14sm4385545pgv.47.2019.02.14.18.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 18:05:50 -0800 (PST)
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
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
        Rob Herring <robh@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Knut Omang <knut.omang@oracle.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-19-brendanhiggins@google.com>
 <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
 <CAFd5g45tOGgf_sKGYRC=fpnTBKGaG=8frbQdgZ3ZTkQFyTfP5A@mail.gmail.com>
 <88fe0546-7850-5bb4-9673-b1aef2dccb3e@gmail.com>
 <CAFd5g444f-FBq4x3U7BL-EY+bFxP0rsJhJ14=mjOi89PhMkURg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <0e311e88-c4d4-e98d-1720-53a04bd526fc@gmail.com>
Date:   Thu, 14 Feb 2019 18:05:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g444f-FBq4x3U7BL-EY+bFxP0rsJhJ14=mjOi89PhMkURg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 4:56 PM, Brendan Higgins wrote:
> On Thu, Feb 14, 2019 at 3:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 12/5/18 3:54 PM, Brendan Higgins wrote:
>>> On Tue, Dec 4, 2018 at 2:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> Hi Brendan,
>>>>
>>>> On 11/28/18 11:36 AM, Brendan Higgins wrote:
>>>>> Split out a couple of test cases that these features in base.c from the
>>>>> unittest.c monolith. The intention is that we will eventually split out
>>>>> all test cases and group them together based on what portion of device
>>>>> tree they test.
>>>>
>>>> Why does splitting this file apart improve the implementation?
>>>
>>> This is in preparation for patch 19/19 and other hypothetical future
>>> patches where test cases are split up and grouped together by what
>>> portion of DT they test (for example the parsing tests and the
>>> platform/device tests would probably go separate files as well). This
>>> patch by itself does not do anything useful, but I figured it made
>>> patch 19/19 (and, if you like what I am doing, subsequent patches)
>>> easier to review.
>>
>> I do not see any value in splitting the devicetree tests into
>> multiple files.
>>
>> Please help me understand what the benefits of such a split are.

Note that my following comments are specific to the current devicetree
unittests, and may not apply to the general case of unit tests in other
subsystems.


> Sorry, I thought it made sense in context of what I am doing in the
> following patch. All I am trying to do is to provide an effective way
> of grouping test cases. To be clear, the idea, assuming you agree, is

Looking at _just_ the first few fragments of the following patch, the
change is to break down a moderate size function of related tests,
of_unittest_find_node_by_name(), into a lot of extremely small functions.
Then to find the execution order of the many small functions requires
finding the array of_test_find_node_by_name_cases[].  Then I have to
chase off into the kunit test runner core, where I find that the set
of tests in of_test_find_node_by_name_cases[] is processed by a
late_initcall().  So now the order of the various test groupings,
declared via module_test(), are subject to the fragile orderings
of initcalls.

There are ordering dependencies within the devicetree unittests.

I do not like breaking the test cases down into such small atoms.

I do not see any value __for devicetree unittests__ of having
such small atoms.

It makes it harder for me to read the source of the tests and
understand the order they will execute.  It also makes it harder
for me to read through the actual tests (in this example the
tests that are currently grouped in of_unittest_find_node_by_name())
because of all the extra function headers injected into the
existing single function to break it apart into many smaller
functions.

Breaking the tests into separate chunks, each chunk invoked
independently as the result of module_test() of each chunk,
loses the summary result for the devicetree unittests of
how many tests are run and how many passed.  This is the
only statistic that I need to determine whether the
unittests have detected a new fault caused by a specific
patch or commit.  I don't need to look at any individual
test result unless the overall result reports a failure.


> that we would follow up with several other patches like this one and
> the subsequent patch, one which would pull out a couple test
> functions, as I have done here, and another that splits those
> functions up into a bunch of proper test cases.
> 
> I thought that having that many unrelated test cases in a single file
> would just be a pain to sort through deal with, review, whatever.

Having all the test cases in a single file makes it easier for me to
read, understand, modify, and maintain the tests.


> This is not something I feel particularly strongly about, it is just
> pretty atypical from my experience to have so many unrelated test
> cases in a single file.
> 
> Maybe you would prefer that I break up the test cases first, and then
> we split up the file as appropriate?

I prefer that the test cases not be broken up arbitrarily.  There _may_
be cases where the devicetree unittests are currently not well grouped
and may benefit from change, but if so that should be handled independently
of any transformation into a KUnit framework.


> I just assumed that we would agree it would be way too much stuff for
> a single file, so I went ahead and broke it up first, because I
> thought it would make it easier to review in that order rather than
> the other way around.



