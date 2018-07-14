Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867E3ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 20:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1252087C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 20:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlFm55vH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1252087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeGNVAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 17:00:44 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42561 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbeGNVAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 17:00:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id l9-v6so12771003pff.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kW65wvSFS/wADxm8RxvMGO8BJqpIUO81dXNZDHRL/U8=;
        b=qlFm55vHBffL2boyhOemCCWpMtYsUzq468W7/llHH5gzXiPRRyO30ThHR+uO1uAaxx
         tt617MfQNIfEMTTKMAaoaWx/B+TgdZ1TgbHVF4B2EdFYMUuzAqMKKMUsHHdz8lOGP26F
         NswlqXJfBqxZwntnhqt1HyHmore3w/KwFCcNVcWCqTK+dDvvOmiyU+BNWTdZFFmwd0rp
         g7+yJzTTR7TZc+N2hNZuN6BOqQAdRf3vMr3Cpk+lF5RgWdcdTKXYmuHPobyPgwIX7Z8y
         Ro8+GXuodSREGYBb4mxgCAqYGAVNRu0U25YX7AczTe2dOPYyP3ucMflXSKCXkY2CfrEA
         ACfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kW65wvSFS/wADxm8RxvMGO8BJqpIUO81dXNZDHRL/U8=;
        b=mRvOxnn54NozAaPeQqcATjHe2IHr1/YoKjdKcqfpyf0ldlJzlQJrOczUV21FoALMsZ
         keF6rPgT846/HAFAYM2tikyGVZVK9pXx8OtJYgwbMm3loToiAV7HF17tUVv74q9j85dL
         h1SCUJVRtx1XKvL5eGErzmYGebz+yIKXUWTjyjzEpRpuMZ6o1aPm7OwWthasosF67EOM
         lNYfAzOV0dd2M0OS1USf04q4ZFghecZmFCgDlEmRL+nCoOeiKsQOIjdRqcJaGTy0swIG
         nHOAnSjMsZZquroYmmD0bj4mJWeSekth349SIcSJRVv7Bn+b5V2ASv5PuaTpZqyxkb0a
         lw8A==
X-Gm-Message-State: AOUpUlE2vLXKVreD0lLPqklyp7qy9hgu1ndYnshmdeZNlgIWcB5dyFeu
        DWBYSWRLTeXavCPbyd7/Q0LOZQ==
X-Google-Smtp-Source: AAOMgpfBZg1IDUz0RvI9cklnZCVUfahEYVSUIz6kRo+60h5Rt6TKbRqsb5gRuu6aVqjiSkDhmkSBfQ==
X-Received: by 2002:a63:da04:: with SMTP id c4-v6mr10089691pgh.398.1531600827673;
        Sat, 14 Jul 2018 13:40:27 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f126-v6sm24767509pgc.88.2018.07.14.13.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 13:40:26 -0700 (PDT)
Subject: Re: [Ksummit-discuss] bug-introducing patches
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Willy Tarreau <w@1wt.eu>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org> <20180501220228.GD7397@sasha-vm>
 <20180502043017.GA11938@1wt.eu> <20180502194139.GA18390@sasha-vm>
 <20180502200229.GA12729@1wt.eu> <20180714173812.xhfwtcijlxebmn2k@devuan>
 <e1198cd9-9113-d231-d15a-31ac5224b3b1@roeck-us.net>
 <20180714194716.GA27381@amd>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4fbbb00c-dcc1-8a2a-a1c6-8d61d545b7b6@roeck-us.net>
Date:   Sat, 14 Jul 2018 13:40:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180714194716.GA27381@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/14/2018 12:47 PM, Pavel Machek wrote:
> Hi!
> 
>>>>> The way I see it, if a commit can get one or two tested-by, it's a good
>>>>> alternative to a week in -next.
>>>>
>>>> Agreed. Even their own actually. And I'm not kidding. Those who run large
>>>> amounts of tests on certain patches could really mention is in tested-by,
>>>> as opposed to the most common cases where the code was just regularly
>>>> tested.
>>>
>>> Actually, it would be cool to get "Tested: no" and "Tested: compile"
>>> tags in the commit mesages. Sometimes it is clear from the context
>>> that patch was not tested (treewide update of time to 64bit), but
>>> sometime it is not.
>>>
>>> This is especially problem for -stable, as it seems that lately
>>> patches are backported from new version without any testing.
>>
>>
>> When I started my own testing some five years ago, most architectures
>> did not even build in stable releases. At that time, the only tests being
>> done on stable release candidates were a number of build tests, and most
>> of the results were ignored.
>>
>> Today, we have 0day, kernelci, kerneltests, Linaro's LKFT, and more, plus
>> several merge and boot tests done by individuals. Stable release candidates
>> are build tested on all supported architectures, with hundreds of
> ...
>> Sure, testing is still far from perfect and needs to be improved. However,
>> requiring that every patch applied to stable releases be tested individually
>> (where ? on all affected architectures ?) would be the wrong
>> direction.
> 
> Well, 0day, kernelci etc... is nice... until the change is in the
> driver. Most of the kernel are drivers, remember?
> 
> I don't know. I'd say that if patch is important enough for -stable,
> there should be someone testing it. For core kernel changes, that can
> be 0day bot, but for drivers...
> 

For my part I am just glad that we were able to pick up a fix in xhci code
just last week, tested or not, from -stable, instead of having to track it
down ourselves. Similar for many other driver patches which _do_ affect us
(like the flurry of ext4 patches this week). Granted, there are lots of
patches which we don't use/need, but even there it is surprising how many
problems are found with existing testing.

For anyone interested in making sure that obscure (whatever that means)
drivers are tested for stable releases, but does not want to spend time on it,
all I can recommend is to implement qemu support for it and let me know,
and I'll be happy to add a respective test to my test farm.

However, ultimately, stable release candidates are public. Everyone is
invited to test them. Anyone interested in a specific release and driver
is invited take stable release candidates and do the necessary testing,
just like I and several others do.

> And problem exists on mainline, too.
> 
> Hmm. Patch for obscure driver. Wow, nice, is WellKnownName actually
> using that driver? Aha, no, he is not; he is doing global
> search&replace, and did not test the patch...
> 

Ah, like me with the strncpy(x, y, strlen(y)) -> memcpy() replacements
I did a week or so ago ? You are right, I only compile tested those and
otherwise trusted my ability to understand C code. If that caused any
problems, please let me know, and hopefully I'll be able to learn something
from it.

Really, there are infrastructure changes all the time. Sometimes I am asked
to run a complete test sequence with those, but most of the time they are
applied to -next and people wait for the fallout. That may not be perfect but,
seriously, the only alternative would be to declare that in-kernel APIs
shall not be changed anymore. I don't think that would be feasible.

Thanks,
Guenter
