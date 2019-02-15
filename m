Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2390C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B472192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmSId1gK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbfBOCsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:48:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34537 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfBOCsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:48:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so4196987plz.1;
        Thu, 14 Feb 2019 18:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YTTXry/F9FnlP7Ccd0qOJUjRwJ9EBC8s025sh3jkVd8=;
        b=XmSId1gKD+zcMzzQwZN/nKV0g+u0mAd7rGeZQldRufewjEicKtHuYqcKk78zfYTwU8
         Mx4ei3LDd4zMs7GbC7f1dHS3htRyAztp8zfwIqqJGt16rap32Ob05a1iGfguoB0aSBcW
         vRZpGgi4FtmcasRuodL4jP5SmMFOreGMtZKNeLjq/DHb/TQ4tKwmi14xzSQ5ayrLF4yq
         KZeeQVc1HfMv5xhjuHY+dss+duciyxXmiCI729u2wes8eBpqC8hn9iDiN9lIR1h4EEE3
         WxQIpu0P3wDF/VRBM+nERo4Zkz8k2xxYP/UMIJsvn6PWXF5L6hUWYFnD2AnzgZKjnCpL
         nFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YTTXry/F9FnlP7Ccd0qOJUjRwJ9EBC8s025sh3jkVd8=;
        b=RKcOIvY/EH636KYmpzfigMTxPj1BdHdUx3tHCzlYB1VEZGfJ4KTUAWl4f6MoM+2Ari
         UlF8J6pKpa4Ld3VpU/QAZtAOaJH+7lGnF1Ht/KGAKNlolwdKXjixOB6bzNEg1iEfvISu
         hIwvW91I/2IH0ce4lz42r5v1S5UVX6ClOO891PmKYHcC1o6ml7bsWrNhw0IIpzWD816v
         pQpoZAPdiUKmtB85sl6OHSA9HnhGWgrvdNejDwhnzaDpE3ETPofikN9TUVAOjzS8BL+d
         xJYqT6pAvAGpBG/w9Q0XbqnqD0RnsUp0cwvo+3gq7+VQScApFzrZMvb1xmNY3qVxqASf
         jC1g==
X-Gm-Message-State: AHQUAuaQU7jg/uRhDTPJiWWmNqqhJ/ZJ1mvv9fz+/dezMKIiuro6hW+y
        GeGAkLya3xPNIYt7qKwFw+s=
X-Google-Smtp-Source: AHgI3Ibf0LoCcnRNBMoVpx55coJIoDN79ZB6KBTEX8AkCX/7aqraxUvycjUMqGoxGkbJtnOeXGtfUw==
X-Received: by 2002:a17:902:2a0a:: with SMTP id i10mr7513031plb.323.1550198917870;
        Thu, 14 Feb 2019 18:48:37 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c124sm5389962pfb.3.2019.02.14.18.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 18:48:37 -0800 (PST)
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
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <bfa00740-9b67-58f9-6273-3de98de952f6@gmail.com>
Date:   Thu, 14 Feb 2019 18:48:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g441+6ATUKcNz7OstAB6Qd2BqeDh77SNnGUpZGBNvgysmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 5:26 PM, Brendan Higgins wrote:
> On Thu, Feb 14, 2019 at 4:10 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 2/12/19 10:53 AM, Brendan Higgins wrote:
>>> UML supports enabling OF, and is useful for running the device tree
>>> tests, so add support for unflattening device tree blobs so we can
>>> actually use it.
>>>
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>> ---
>>>  drivers/of/unittest.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>>> index 84427384654d5..effa4e2b9d992 100644
>>> --- a/drivers/of/unittest.c
>>> +++ b/drivers/of/unittest.c
>>> @@ -2527,6 +2527,9 @@ static int __init of_unittest(void)
>>>       }
>>>       of_node_put(np);
>>>
>>> +     if (IS_ENABLED(CONFIG_UML))
>>> +             unflatten_device_tree();
>>> +
>>>       pr_info("start of unittest - you will see error messages\n");
>>>       of_unittest_check_tree_linkage();
>>>       of_unittest_check_phandles();
>>>
>>
>> (Insert my usual disclaimer that I am clueless about UML, I still need to learn
>> about it...)
>>
>> This does not look correct to me.
>>
>> A few lines earlier in of_unittest(), the live devicetree needs to exist for
>> unittest_data_data() and a few of_*() functions to succeed.  So it seems
>> that the unflatten_device_tree() for uml should be at the beginning of
>> of_unittest().
> 
> It is true that other functions ahead of it depend on the presence of
> a device tree, but an unflattened tree does get linked in somewhere
> else. Despite that, this is needed for overlay_base_root. I got
> similar behavior if you don't link in a flattened device tree on x86.
> Thus, the order in which you call them doesn't actually seem to
> matter. I found no difference from changing the order in UML myself.
> 
> Without my patch we get the following error,
> ### dt-test ### FAIL of_unittest_overlay_high_level():2372
> overlay_base_root not initialized
> ### dt-test ### end of unittest - 219 passed, 1 failed
> 
> With my patch we get:
> ### dt-test ### end of unittest - 224 passed, 0 failed

Thanks for reporting both the failure and the success cases,
that helps me understand a little bit better.

If instead of the above patch, if you add the following (untested,
not even compile tested) to the beginning of of_unittest():

	if (IS_ENABLED(CONFIG_UML))
		unittest_unflatten_overlay_base();

does that also result in a good test result of:

	### dt-test ### end of unittest - 224 passed, 0 failed

I think I need to find some time to build and boot a UML kernel soon.

My current _guess_ is that the original problem was not a failure to
unflatten any present devicetree in UML but instead that the UML
kernel does not call unflatten_device_tree() and thus fails to
indirectly call unittest_unflatten_overlay_base(), which is
called by unflatten_device_tree().

unittest_unflatten_overlay_base() is an unfortunate wart that I
added, but I don't have a better alternative yet.

-Frank

> 
> I used the following .config for these results:
> CONFIG_OF=y
> CONFIG_OF_UNITTEST=y
> CONFIG_OF_OVERLAY=y
> CONFIG_I2C=y
> CONFIG_I2C_MUX=y
> 
>>
>> Rob, if I am correct please revert this patch.
>>
> 
> Cheers
> 

