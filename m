Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFE7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2992192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWnoAvto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393941AbfBOXGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 18:06:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33382 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393640AbfBOXGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 18:06:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so5537929pfb.0;
        Fri, 15 Feb 2019 15:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XtnJjx9arFmmGfNRCHmJhaSBgoU6ZURNJ5IuU6XRcuE=;
        b=JWnoAvtoCY10jqOX4jeZtDVrYo7O6RjaugA1WuCiikgod4td+T3I9XJ7Rm/t40TEzX
         K2dyNjxJ+c9zSmzCE+N74Ji8U/slDW3mVnU3fKkgZf3fatbMzSsMaH1mqXXRTgUBqxRx
         jMMiOYyHg9qO1LS61q1KqBpPHqOfLirU80O1AAohzkT8d8GPwTGLOoLXQXFz6MSftzJR
         w8uoq+qBhSji83SUuYc9XvNu63hWS7ARQRWG2Shbre8sn1Jym50Wdqq3/NWh9UGzyDG0
         u0l0+jiJKdsY8e1kNOkT/l8N5dHcGTwFCtNR/YpM7KKjjlZLxGr5lICf/tMvjqddxl04
         57aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XtnJjx9arFmmGfNRCHmJhaSBgoU6ZURNJ5IuU6XRcuE=;
        b=FduioCz+1GVANNem5aUncyUc1sE5OMnOeAS8UbY/QyUMxP/YGOo3i6CiGKimF1h2Cz
         7scR8ey9nAZf417NKsgQqRCozXeP493F05H4jAIb/zwN4QiHerqVtD3fqQjUvkubww4P
         AHcDICNbsj6hv4ZQ6/5rFBoGjdjvODz5Fg/2uTtTa36BZ76cRNInNtVCGBxJu3IboaTh
         lQsBFhZQSjtq7FiYerop67mkNKLhdihu2sQTgi/Dp1gqJenevGbqmGg9Yjmj4neVSrrG
         H4HocC51GQzyOkU7rKJG7ARKugyuqUGhBlM5OXih2/pDzWgzwbAaHnztlEL7+K8cxuSe
         Ao0g==
X-Gm-Message-State: AHQUAuaAietPjS4VixZ0YiLFSwOwCcaMmI0N2VCNs1lbTSngkvx0ovfa
        b5omSxZ/eJZlReloFcDs9Oo=
X-Google-Smtp-Source: AHgI3IbmYVCqS4FTdqk4Xk6ovIYuw1+UowBImY8lzSMTPzNOkKc/ocsZldSmLWoNK9Mf+F42kBexgQ==
X-Received: by 2002:a65:500c:: with SMTP id f12mr7488436pgo.226.1550271969370;
        Fri, 15 Feb 2019 15:06:09 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id o1sm14736289pgn.63.2019.02.15.15.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 15:06:08 -0800 (PST)
Subject: Re: [PATCH v1 1/1] of: unittest: unflatten device tree on UML when
 testing
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190212185305.112847-1-brendanhiggins@google.com>
 <20190212185305.112847-2-brendanhiggins@google.com>
 <4cb7ca12-ce60-7516-b7eb-aef08f607acc@gmail.com>
 <CAFd5g441+6ATUKcNz7OstAB6Qd2BqeDh77SNnGUpZGBNvgysmg@mail.gmail.com>
 <bfa00740-9b67-58f9-6273-3de98de952f6@gmail.com>
 <CAFd5g44HkBLJmK8e4F+iaGPg1FEzubGtcUW-251GAOv1UmE5rg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <00f46226-e60b-c35c-ae00-3449f399e4ee@gmail.com>
Date:   Fri, 15 Feb 2019 15:06:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g44HkBLJmK8e4F+iaGPg1FEzubGtcUW-251GAOv1UmE5rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 1:49 AM, Brendan Higgins wrote:
> On Thu, Feb 14, 2019 at 6:48 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 2/14/19 5:26 PM, Brendan Higgins wrote:
>>> On Thu, Feb 14, 2019 at 4:10 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> On 2/12/19 10:53 AM, Brendan Higgins wrote:
>>>>> UML supports enabling OF, and is useful for running the device tree
>>>>> tests, so add support for unflattening device tree blobs so we can
>>>>> actually use it.
>>>>>
>>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>>>> ---
>>>>>  drivers/of/unittest.c | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>>>>> index 84427384654d5..effa4e2b9d992 100644
>>>>> --- a/drivers/of/unittest.c
>>>>> +++ b/drivers/of/unittest.c
>>>>> @@ -2527,6 +2527,9 @@ static int __init of_unittest(void)
>>>>>       }
>>>>>       of_node_put(np);
>>>>>
>>>>> +     if (IS_ENABLED(CONFIG_UML))
>>>>> +             unflatten_device_tree();
>>>>> +
>>>>>       pr_info("start of unittest - you will see error messages\n");
>>>>>       of_unittest_check_tree_linkage();
>>>>>       of_unittest_check_phandles();
>>>>>
>>>>
>>>> (Insert my usual disclaimer that I am clueless about UML, I still need to learn
>>>> about it...)
>>>>
>>>> This does not look correct to me.
>>>>
>>>> A few lines earlier in of_unittest(), the live devicetree needs to exist for
>>>> unittest_data_data() and a few of_*() functions to succeed.  So it seems
>>>> that the unflatten_device_tree() for uml should be at the beginning of
>>>> of_unittest().
>>>
>>> It is true that other functions ahead of it depend on the presence of
>>> a device tree, but an unflattened tree does get linked in somewhere
>>> else. Despite that, this is needed for overlay_base_root. I got
>>> similar behavior if you don't link in a flattened device tree on x86.
>>> Thus, the order in which you call them doesn't actually seem to
>>> matter. I found no difference from changing the order in UML myself.
>>>
>>> Without my patch we get the following error,
>>> ### dt-test ### FAIL of_unittest_overlay_high_level():2372
>>> overlay_base_root not initialized
>>> ### dt-test ### end of unittest - 219 passed, 1 failed
>>>
>>> With my patch we get:
>>> ### dt-test ### end of unittest - 224 passed, 0 failed
>>
>> Thanks for reporting both the failure and the success cases,
>> that helps me understand a little bit better.
>>
>> If instead of the above patch, if you add the following (untested,
>> not even compile tested) to the beginning of of_unittest():
>>
>>         if (IS_ENABLED(CONFIG_UML))
>>                 unittest_unflatten_overlay_base();
>>
>> does that also result in a good test result of:
>>
>>         ### dt-test ### end of unittest - 224 passed, 0 failed
> 
> Yep, I just tried it. It works as you suspected.
> 
>>
>> I think I need to find some time to build and boot a UML kernel soon.
> 
> It's really no big deal, just copy the .config I sent and build with
> `make ARCH=um` then you "boot" the kernel with `./linux` (note this
> will mess up your terminal settings); that's it! (Shameless plug: you
> can also try it out with the KUnit patchset with
> `./tools/testing/kunit/kunit.py --timeout=30 --jobs=12 --defconfig`,
> which builds the kernel with a pretty similar config, boots the
> kernel, and then parses the output for you. ;-) )

Thanks, that was enough info to prod me into building and "booting"
a uml kernel.  I have another framework that I use, so I did not
try kunit.py, but reading that filled in any missing details that
I needed.

As I mentioned, I used my own framework, but the commands that it
emitted essentially boil down to a rather simple recipe:

   export ARCH=um
   make kunit_defconfig
   make olddefconfig
   make linux

   # KBUILD_OUTPUT is my build directory
   ${KBUILD_OUTPUT}/linux mem=256m


> 
>>
>> My current _guess_ is that the original problem was not a failure to
>> unflatten any present devicetree in UML but instead that the UML
>> kernel does not call unflatten_device_tree() and thus fails to
>> indirectly call unittest_unflatten_overlay_base(), which is
>> called by unflatten_device_tree().
> 
> I think you are right. Sorry for not noticing this before making my
> change. Since it was pretty much the only architecture (the only one I
> care about) that does not unflatten DT, I assumed that was the
> problem. I didn't put too much thought into it after that point beyond
> making sure that it did what I wanted.
> 
>>
>> unittest_unflatten_overlay_base() is an unfortunate wart that I
>> added, but I don't have a better alternative yet.
> 
> Hey, I get it. No worries.
> 
> In any case, it seems like unittest_unflatten_overlay_base() is the
> right function to call there. I will send out patch. Do you want me to

Thanks for the updated patch.


> send a patch on top of this one, or do you want to revert this one and
> for me to send a v2 follow up to this patch? I don't care either way,
> whatever you guys prefer.
> 
> Cheers
> 

