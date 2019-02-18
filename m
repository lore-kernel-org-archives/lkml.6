Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F6BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7A8217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCmzcB66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfBRW4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:56:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42354 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfBRW4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 17:56:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id n74so9243520pfi.9;
        Mon, 18 Feb 2019 14:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iArAmDP+xoIkZF1Xqi2UwoZPuYyIhop07CMZicYNuG4=;
        b=DCmzcB66eIiRuhRxSon9u0bNDp1PLyl4npkSGRnMNAE3diKcxf0sU1yGtsMJcvqA1X
         vF9R4Ky0ZaPkVy0OiPlE6SkigOTGsOEloY+Sq4ejVvRwSepOY1U8/QlOy97iS3mGfxhB
         yQQmeCTs4exkqtJrULdvnvuL0WfC0zqeltHQ1JQkwae4MY2Q3ptx0CBIEMqzXADfHcfP
         GFqx6tc6zyGsyeANN0gP8ps9Bvye3DqqXqGClFZFpwfyY3y3XSxP86ulqqF1UmcIlNxG
         TOii7bm6++SX89zmg9HqEvdoo1QJAz4LlsmpWp1c1/3l8sTrj0AsVb19QW29IgiSSYNV
         go1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iArAmDP+xoIkZF1Xqi2UwoZPuYyIhop07CMZicYNuG4=;
        b=JoTFqxrqlsnchAwDgCB94/5H5OOANGz+/fZDCTIycAWIrPpJhgMm4Cii/QAMRhX/s2
         +G0FBst7zlWKOPBp4lp18JXFx5Z/N5nfkPlLjgaaOCjrCOAGMEC5uR5GcUYYJPgnVJ7R
         JsjkvFXuEXnFGLThch0UlsNOQosFjDzoceK7Xj6VknzhgDq7O6T4ffRygINEZsZLB8S0
         QEWsC+PklJj4nDvb7eoNkJ1To+rCuvP5rm0c7Gnl+SEuR5fkReJd/rzgCuOjKCPtc1eB
         usXvHLskI9yTJOEZrwVzncAbC5kgSzKzzgBEv0GBZD3ZmJHhlk7XWvH6Ho3LVbnoJy3m
         S5+A==
X-Gm-Message-State: AHQUAuZsGJcoI4HFnypAfWXs4Pmv4pdEODa5quBrloYtsbLgMrkkehxY
        sD6jh6QbsK+R+Vu/AwbUlmc=
X-Google-Smtp-Source: AHgI3IaedeiIhY4u66DDu/uRJTa+MUDbBjr3L/RVCunx1NPMXzIP1YdfkJR7gs4cplp+p/6sfItyyg==
X-Received: by 2002:a62:2044:: with SMTP id g65mr26249809pfg.127.1550530567623;
        Mon, 18 Feb 2019 14:56:07 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id s190sm23297184pfb.103.2019.02.18.14.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 14:56:06 -0800 (PST)
Subject: Re: [RFC v3 17/19] of: unittest: migrate tests to run on KUnit
To:     Brendan Higgins <brendanhiggins@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Knut Omang <knut.omang@oracle.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-18-brendanhiggins@google.com>
 <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
 <CAFd5g46NehKo=TT4reQ8r74bDTG9BkR=ELg+Q3n5YooUxFwBmA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <1d72f04e-08ba-e3dd-c8c0-512946126113@gmail.com>
Date:   Mon, 18 Feb 2019 14:56:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g46NehKo=TT4reQ8r74bDTG9BkR=ELg+Q3n5YooUxFwBmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 5:44 PM, Brendan Higgins wrote:
> On Wed, Nov 28, 2018 at 12:56 PM Rob Herring <robh@kernel.org> wrote:
>>
>> On Wed, Nov 28, 2018 at 1:38 PM Brendan Higgins
>> <brendanhiggins@google.com> wrote:
>>>
>>> Migrate tests without any cleanup, or modifying test logic in anyway to
>>> run under KUnit using the KUnit expectation and assertion API.
>>
>> Nice! You beat me to it. This is probably going to conflict with what
>> is in the DT tree for 4.21. Also, please Cc the DT list for
>> drivers/of/ changes.
>>
>> Looks good to me, but a few mostly formatting comments below.
> 
> I just realized that we never talked about your other comments, and I
> still have some questions. (Sorry, it was the last thing I looked at
> while getting v4 ready.) No worries if you don't get to it before I
> send v4 out, I just didn't want you to think I was ignoring you.
> 
>>
>>>
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>> ---
>>>  drivers/of/Kconfig    |    1 +
>>>  drivers/of/unittest.c | 1405 ++++++++++++++++++++++-------------------
>>>  2 files changed, 752 insertions(+), 654 deletions(-)
>>>
> <snip>
>>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>>> index 41b49716ac75f..a5ef44730ffdb 100644
>>> --- a/drivers/of/unittest.c
>>> +++ b/drivers/of/unittest.c
> <snip>
>>> -
>>> -static void __init of_unittest_find_node_by_name(void)
>>> +static void of_unittest_find_node_by_name(struct kunit *test)
>>
>> Why do we have to drop __init everywhere? The tests run later?
> 
>>From the standpoint of a unit test __init doesn't really make any
> sense, right? I know that right now we are running as part of a
> kernel, but the goal should be that a unit test is not part of a
> kernel and we just include what we need.
> 
> Even so, that's the future. For now, I did not put the KUnit
> infrastructure in the .init section because I didn't think it belonged
> there. In practice, KUnit only knows how to run during the init phase
> of the kernel, but I don't think it should be restricted there. You
> should be able to run tests whenever you want because you should be
> able to test anything right? I figured any restriction on that is
> misleading and will potentially get in the way at worst, and
> unnecessary at best especially since people shouldn't build a
> production kernel with all kinds of unit tests inside.
> 
>>
>>>  {
>>>         struct device_node *np;
>>>         const char *options, *name;
>>>
> <snip>
>>>
>>>
>>> -       np = of_find_node_by_path("/testcase-data/missing-path");
>>> -       unittest(!np, "non-existent path returned node %pOF\n", np);
>>> +       KUNIT_EXPECT_EQ_MSG(test,
>>> +                           of_find_node_by_path("/testcase-data/missing-path"),
>>> +                           NULL,
>>> +                           "non-existent path returned node %pOF\n", np);
>>
>> 1 tab indent would help with less vertical code (in general, not this
>> one so much).
> 
> Will do.
> 
>>
>>>         of_node_put(np);
>>>
>>> -       np = of_find_node_by_path("missing-alias");
>>> -       unittest(!np, "non-existent alias returned node %pOF\n", np);
>>> +       KUNIT_EXPECT_EQ_MSG(test, of_find_node_by_path("missing-alias"), NULL,
>>> +                           "non-existent alias returned node %pOF\n", np);
>>>         of_node_put(np);
>>>
>>> -       np = of_find_node_by_path("testcase-alias/missing-path");
>>> -       unittest(!np, "non-existent alias with relative path returned node %pOF\n", np);
>>> +       KUNIT_EXPECT_EQ_MSG(test,
>>> +                           of_find_node_by_path("testcase-alias/missing-path"),
>>> +                           NULL,
>>> +                           "non-existent alias with relative path returned node %pOF\n",
>>> +                           np);
>>>         of_node_put(np);
>>>
> <snip>
>>>
>>> -static void __init of_unittest_property_string(void)
>>> +static void of_unittest_property_string(struct kunit *test)
>>>  {
>>>         const char *strings[4];
>>>         struct device_node *np;
>>>         int rc;
>>>
>>>         np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-a");
>>> -       if (!np) {
>>> -               pr_err("No testcase data in device tree\n");
>>> -               return;
>>> -       }
>>> -
>>> -       rc = of_property_match_string(np, "phandle-list-names", "first");
>>> -       unittest(rc == 0, "first expected:0 got:%i\n", rc);
>>> -       rc = of_property_match_string(np, "phandle-list-names", "second");
>>> -       unittest(rc == 1, "second expected:1 got:%i\n", rc);
>>> -       rc = of_property_match_string(np, "phandle-list-names", "third");
>>> -       unittest(rc == 2, "third expected:2 got:%i\n", rc);
>>> -       rc = of_property_match_string(np, "phandle-list-names", "fourth");
>>> -       unittest(rc == -ENODATA, "unmatched string; rc=%i\n", rc);
>>> -       rc = of_property_match_string(np, "missing-property", "blah");
>>> -       unittest(rc == -EINVAL, "missing property; rc=%i\n", rc);
>>> -       rc = of_property_match_string(np, "empty-property", "blah");
>>> -       unittest(rc == -ENODATA, "empty property; rc=%i\n", rc);
>>> -       rc = of_property_match_string(np, "unterminated-string", "blah");
>>> -       unittest(rc == -EILSEQ, "unterminated string; rc=%i\n", rc);
>>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
>>> +
>>> +       KUNIT_EXPECT_EQ(test,
>>> +                       of_property_match_string(np,
>>> +                                                "phandle-list-names",
>>> +                                                "first"),
>>> +                       0);
>>> +       KUNIT_EXPECT_EQ(test,
>>> +                       of_property_match_string(np,
>>> +                                                "phandle-list-names",
>>> +                                                "second"),
>>> +                       1);
>>
>> Fewer lines on these would be better even if we go over 80 chars.

Agreed.  unittest.c already is a greater than 80 char file in general, and
is a file that benefits from that.


> On the of_property_match_string(...), I have no opinion. I will do
> whatever you like best.
> 
> Nevertheless, as far as the KUNIT_EXPECT_*(...), I do have an opinion: I am
> trying to establish a good, readable convention. Given an expect statement
> structured as
> ```
> KUNIT_EXPECT_*(
>     test,
>     expect_arg_0, ..., expect_arg_n,
>     fmt_str, fmt_arg_0, ..., fmt_arg_n)
> ```
> where `test` is the `struct kunit` context argument, `expect_arg_{0, ..., n}`
> are the arguments the expectations is being made about (so in the above example,
> `of_property_match_string(...)` and `1`), and `fmt_*` is the optional format
> string that comes at the end of some expectations.
> 
> The pattern I had been trying to promote is the following:
> 
> 1) If everything fits on 1 line, do that.
> 2) If you must make a line split, prefer to keep `test` on its own line,
> `expect_arg_{0, ..., n}` should be kept together, if possible, and the format
> string should follow the conventions already most commonly used with format
> strings.
> 3) If you must split up `expect_arg_{0, ..., n}` each argument should get its
> own line and should not share a line with either `test` or any `fmt_*`.
> 
> The reason I care about this so much is because expectations should be
> extremely easy to read; they are the most important part of a unit
> test because they tell you what the test is verifying. I am not
> married to the formatting I proposed above, but I want something that
> will be extremely easy to identify the arguments that the expectation
> is on. Maybe that means that I need to add some syntactic fluff to
> make it clearer, I don't know, but this is definitely something we
> need to get right, especially in the earliest examples.

I will probably raise the ire of the kernel formatting rule makers by offering
what I think is a _much_ more readable format __for this specific case__.
In other words for drivers/of/unittest.c.

If you can not make your mail window _very_ wide, or if this email has been
line wrapped, this example will not be clear.

Two possible formats:


### -----  version 1, as created by the patch series

static void of_unittest_property_string(struct kunit *test)
{
        const char *strings[4];
        struct device_node *np;
        int rc;

        np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-a");
        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);

        KUNIT_EXPECT_EQ(
                test,
                of_property_match_string(np, "phandle-list-names", "first"),
                0);
        KUNIT_EXPECT_EQ(
                test,
                of_property_match_string(np, "phandle-list-names", "second"),
                1);
        KUNIT_EXPECT_EQ(
                test,
                of_property_match_string(np, "phandle-list-names", "third"),
                2);
        KUNIT_EXPECT_EQ_MSG(
                test,
                of_property_match_string(np, "phandle-list-names", "fourth"),
                -ENODATA,
                "unmatched string");
        KUNIT_EXPECT_EQ_MSG(
                test,
                of_property_match_string(np, "missing-property", "blah"),
                -EINVAL,
                "missing property");
        KUNIT_EXPECT_EQ_MSG(
                test,
                of_property_match_string(np, "empty-property", "blah"),
                -ENODATA,
                "empty property");
        KUNIT_EXPECT_EQ_MSG(
                test,
                of_property_match_string(np, "unterminated-string", "blah"),
                -EILSEQ,
                "unterminated string");

        /* of_property_count_strings() tests */
        KUNIT_EXPECT_EQ(test,
                        of_property_count_strings(np, "string-property"), 1);
        KUNIT_EXPECT_EQ(test,
                        of_property_count_strings(np, "phandle-list-names"), 3);
        KUNIT_EXPECT_EQ_MSG(
                test,
                of_property_count_strings(np, "unterminated-string"), -EILSEQ,
                "unterminated string");
        KUNIT_EXPECT_EQ_MSG(
                test,
                of_property_count_strings(np, "unterminated-string-list"),
                -EILSEQ,
                "unterminated string array");




### -----  version 2, modified to use really long lines

static void of_unittest_property_string(struct kunit *test)
{
        const char *strings[4];
        struct device_node *np;
        int rc;

        np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-a");
        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);

        KUNIT_EXPECT_EQ(    test, of_property_match_string(np, "phandle-list-names", "first"),  0);
        KUNIT_EXPECT_EQ(    test, of_property_match_string(np, "phandle-list-names", "second"), 1);
        KUNIT_EXPECT_EQ(    test, of_property_match_string(np, "phandle-list-names", "third"),  2);
        KUNIT_EXPECT_EQ_MSG(test, of_property_match_string(np, "phandle-list-names", "fourth"), -ENODATA, "unmatched string");
        KUNIT_EXPECT_EQ_MSG(test, of_property_match_string(np, "missing-property", "blah"),     -EINVAL, "missing property");
        KUNIT_EXPECT_EQ_MSG(test, of_property_match_string(np, "empty-property", "blah"),       -ENODATA, "empty property");
        KUNIT_EXPECT_EQ_MSG(test, of_property_match_string(np, "unterminated-string", "blah"),  -EILSEQ, "unterminated string");

        /* of_property_count_strings() tests */
        KUNIT_EXPECT_EQ(    test, of_property_count_strings(np, "string-property"),             1);
        KUNIT_EXPECT_EQ(    test, of_property_count_strings(np, "phandle-list-names"),          3);
        KUNIT_EXPECT_EQ_MSG(test, of_property_count_strings(np, "unterminated-string"),         -EILSEQ, "unterminated string");
        KUNIT_EXPECT_EQ_MSG(test, of_property_count_strings(np, "unterminated-string-list"),    -EILSEQ, "unterminated string array");

        
        ------------------------  ------------------------------------------------------------- --------------------------------------
             ^                         ^                                                             ^
             |                         |                                                             |
             |                         |                                                             |
            mostly boilerplate        what is being tested                                          expected result, error message
            (can vary in relop
             and _MSG or not)

In my opinion, the second version is much more readable.  It is easy to see the
differences in the boilerplate.  It is easy to see what is being tested, and how
the arguments of the tested function vary for each test.  It is easy to see the
expected result and error message.  The entire block fits into a single short
window (though much wider).

- Frank

>>
>>> +       KUNIT_EXPECT_EQ(test,
>>> +                       of_property_match_string(np,
>>> +                                                "phandle-list-names",
>>> +                                                "third"),
>>> +                       2);
>>> +       KUNIT_EXPECT_EQ_MSG(test,
>>> +                           of_property_match_string(np,
>>> +                                                    "phandle-list-names",
>>> +                                                    "fourth"),
>>> +                           -ENODATA,
>>> +                           "unmatched string");
>>> +       KUNIT_EXPECT_EQ_MSG(test,
>>> +                           of_property_match_string(np,
>>> +                                                    "missing-property",
>>> +                                                    "blah"),
>>> +                           -EINVAL,
>>> +                           "missing property");
>>> +       KUNIT_EXPECT_EQ_MSG(test,
>>> +                           of_property_match_string(np,
>>> +                                                    "empty-property",
>>> +                                                    "blah"),
>>> +                           -ENODATA,
>>> +                           "empty property");
>>> +       KUNIT_EXPECT_EQ_MSG(test,
>>> +                           of_property_match_string(np,
>>> +                                                    "unterminated-string",
>>> +                                                    "blah"),
>>> +                           -EILSEQ,
>>> +                           "unterminated string");
> <snip>
>>>  /* test insertion of a bus with parent devices */
>>> -static void __init of_unittest_overlay_10(void)
>>> +static void of_unittest_overlay_10(struct kunit *test)
>>>  {
>>> -       int ret;
>>>         char *child_path;
>>>
>>>         /* device should disable */
>>> -       ret = of_unittest_apply_overlay_check(10, 10, 0, 1, PDEV_OVERLAY);
>>> -       if (unittest(ret == 0,
>>> -                       "overlay test %d failed; overlay application\n", 10))
>>> -               return;
>>> +       KUNIT_ASSERT_EQ_MSG(test,
>>> +                           of_unittest_apply_overlay_check(test,
>>> +                                                           10,
>>> +                                                           10,
>>> +                                                           0,
>>> +                                                           1,
>>> +                                                           PDEV_OVERLAY),
>>
>> I prefer putting multiple args on a line and having fewer lines.
> 
> Looking at this now, I tend to agree, but I don't think I saw a
> consistent way to break them up for these functions. I figured there
> should be some type of pattern.
> 
>>
>>> +                           0,
>>> +                           "overlay test %d failed; overlay application\n",
>>> +                           10);
>>>
>>>         child_path = kasprintf(GFP_KERNEL, "%s/test-unittest101",
>>>                         unittest_path(10, PDEV_OVERLAY));
>>> -       if (unittest(child_path, "overlay test %d failed; kasprintf\n", 10))
>>> -               return;
>>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, child_path);
>>>
>>> -       ret = of_path_device_type_exists(child_path, PDEV_OVERLAY);
>>> +       KUNIT_EXPECT_TRUE_MSG(test,
>>> +                             of_path_device_type_exists(child_path,
>>> +                                                        PDEV_OVERLAY),
>>> +                             "overlay test %d failed; no child device\n", 10);
>>>         kfree(child_path);
>>> -
>>> -       unittest(ret, "overlay test %d failed; no child device\n", 10);
>>>  }
> <snip>
> 

