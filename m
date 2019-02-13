Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF90C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A080521872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ParKQ7pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392292AbfBMVzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:55:48 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45374 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388453AbfBMVzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:55:47 -0500
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2471F304;
        Wed, 13 Feb 2019 22:55:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1550094943;
        bh=+PqTZYsu0QwX3YcMD1Wsz7r9QBDgexVby+p1yKd5nR8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ParKQ7pF1f7j3Z6fla49lfzpyIIX52ogRptm5hxq9f3i3L6clwINRQORTR9fff7J2
         Ipfik+SwhXpOskjp6qEoeNN4bjO9ggFMb27tgGc4kz7+iGtsFZHK5i3pAGfBqvrQWT
         /C6WZ+lwwe8SemWJ2UveeB2NhXAz3igS6juUBZmA=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [RFC v3 14/19] Documentation: kunit: add documentation for KUnit
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>, Tim.Bird@sony.com,
        khilman@baylibre.com, Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-15-brendanhiggins@google.com>
 <b4c72234-8c56-6efa-8003-f89d99a9779e@ideasonboard.com>
 <20181130034525.GP18410@garbanzo.do-not-panic.com>
 <CAFd5g47Cew6pmebsopjzmkd4RpnnC3zLAUfxCybjdhrO35OBpQ@mail.gmail.com>
 <0927c42a-8e65-f410-e6ed-27576572577f@ideasonboard.com>
 <CAFd5g44fKzriEs_pGyANxe7GuC9Ji2SD7EEz76__h8q9jjg8yA@mail.gmail.com>
 <57c3dc86-236f-e981-249a-8bbfe5c19f0e@ideasonboard.com>
 <CAFd5g46AEquMKzfrjLDVi+PP5-7aGs6C6pCunGAXDn3VRkJP+g@mail.gmail.com>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <eade3052-0aa4-90b4-d55b-8c44556f98bc@ideasonboard.com>
Date:   Wed, 13 Feb 2019 21:55:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g46AEquMKzfrjLDVi+PP5-7aGs6C6pCunGAXDn3VRkJP+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan,

On 12/02/2019 22:10, Brendan Higgins wrote:
> On Mon, Feb 11, 2019 at 4:16 AM Kieran Bingham
> <kieran.bingham@ideasonboard.com> wrote:
>>
>> Hi Brendan,
>>
>> On 09/02/2019 00:56, Brendan Higgins wrote:
>>> On Thu, Dec 6, 2018 at 4:16 AM Kieran Bingham
>>> <kieran.bingham@ideasonboard.com> wrote:
>>>>
>>>> Hi Brendan,
>>>>
>>>> On 03/12/2018 23:53, Brendan Higgins wrote:
>>>>> On Thu, Nov 29, 2018 at 7:45 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>>>>>
>>>>>> On Thu, Nov 29, 2018 at 01:56:37PM +0000, Kieran Bingham wrote:
>>>>>>> Hi Brendan,
>>>>>>>
>>>>>>> Please excuse the top posting, but I'm replying here as I'm following
>>>>>>> the section "Creating a kunitconfig" in Documentation/kunit/start.rst.
>>>>>>>
>>>>>>> Could the three line kunitconfig file live under say
>>>>>>>        arch/um/configs/kunit_defconfig?
>>>>
>>>>
>>>> Further consideration to this topic - I mentioned putting it in
>>>>   arch/um/configs
>>>>
>>>> - but I think this is wrong.
>>>>
>>>> We now have a location for config-fragments, which is essentially what
>>>> this is, under kernel/configs
>>>>
>>>> So perhaps an addition as :
>>>>
>>>>  kernel/configs/kunit.config
>>>>
>>>> Would be more appropriate - and less (UM) architecture specific.
>>>
>>> Sorry for the long radio silence.
>>>
>>> I just got around to doing this and I found that there are some
>>> configs that are desirable to have when running KUnit under x86 in a
>>> VM, but not UML.
>>
>> Should this behaviour you mention be handled by the KCONFIG depends flags?
>>
>> depends on (KUMIT & UML)
>> or
>> depends on (KUNIT & !UML)
>>
>> or such?
> 
> Not really. Anything that is strictly necessary to run KUnit on an
> architectures should of course be turned on as a dependency like you
> suggest, but I am talking about stuff that you would probably want to
> get yourself going, but is by no means necessary.
> 
>>
>> An example of which configs you are referring to would help to
>> understand the issue perhaps.
>>
> 
> For example, you might want to enable a serial console that is known
> to work with a fairly generic qemu setup when building for x86:
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> 
> Obviously not a dependency, and not even particularly useful to people
> who know what they are doing, but to someone who is new or just wants
> something to work out of the box would probably want that.

It sounds like that would be a config fragment for qemu ?

Although - perhaps this is already covered by the following fragment:
   kernel/configs/kvm_guest.config


>>> So should we have one that goes in with
>>> config-fragments and others that go into architectures? Another idea,
>>> it would be nice to have a KUnit config that runs all known tests
>>
>> This might also be a config option added to the tests directly like
>> COMPILE_TEST perhaps?
> 
> That just allows a bunch of drivers to be compiled, it does not
> actually go through and turn the configs on, right? I mean, there is
> no a priori way to know that there is a configuration which spans all
> possible options available under COMPILE_TEST, right? Maybe I
> misunderstand what you are suggesting...

Bah - you're right of course. I was mis-remembering the functionality of
COMPILE_TEST as if it were some sort of 'select' but it's just an enable..

Sorry for the confusion.



>> (Not sure what that would be called though ... KUNIT_RUNTIME_TEST?)
>>
>> I think that might be more maintainable as otherwise each new test would
>> have to modify the {min,def}{config,fragment} ...
>>
> 
> Looking at kselftest-merge, they just start out with a set of
> fragments in which the union should contain all tests and then merge
> it with a base .config (probably intended to be $(ARCH)_defconfig).
> However, I don't know if that is the state of the art.
> 
>>
>>> (this probably won't work in practice once we start testing mutually
>>> exclusive things or things with lots of ifdeffery, but it probably
>>> something we should try to maintain as best as we can?); this probably
>>> shouldn't go in with the fragments, right?
>>
>> Sounds like we agree there :)
> 
> Totally. Long term we will need something a lot more sophisticated
> than anything under discussion here. I was talking about this with
> Luis on another thread:
> https://groups.google.com/forum/#!topic/kunit-dev/EQ1x0SzrUus (feel
> free to chime in!). Nevertheless, that's a really hard problem and I
> figure some variant of defconfigs and config fragments will work well
> enough until we reach that point.
> 
>>
>>>
>>> I will be sending another revision out soon, but I figured I might be
>>> able to catch you before I did so.
>>
>> Thanks for thinking of me.
> 
> How can I forget? You have been super helpful!
> 
>> I hope I managed to reply in time to help and not hinder your progress.
> 
> Yep, no trouble at all. You are the one helping me :-)
> 
> Thanks!
> 

-- 
Regards
--
Kieran
