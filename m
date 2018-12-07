Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA5FC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE86208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EeW2jro/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE86208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeLGLaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:30:39 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:44844 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeLGLaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:30:39 -0500
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 93B39537;
        Fri,  7 Dec 2018 12:30:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1544182235;
        bh=21sn3No9vTImcnA5ONUX2pEmjhljoAzL+ofIJEsTpR8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EeW2jro/SQwWlM2rWOn2bpzPY407qmx2Bx8FBEiHsCTmO6BGOo9tohdDiLHFNriVm
         vPVL7v/uKttNUAyHOfvG4TByvTIPBxrDw64UhYHb2o29O0XhecpojSPqoJmoB9D3RX
         9xg1FJkYTmnMkpTpvWD4zchTqudztQDiOu9aww+I=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@sandeen.net>, jeffm@suse.com,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
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
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-fsdevel@vger.kernel.org
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
 <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
 <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
 <20181204204701.GT28501@garbanzo.do-not-panic.com>
 <f8722f4a-44c8-24c2-c433-5178f9f40b82@ideasonboard.com>
 <20181206153718.GD24603@bombadil.infradead.org>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <f2a3d7fc-21f2-7bd0-94e2-4122f2073da5@ideasonboard.com>
Date:   Fri, 7 Dec 2018 11:30:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206153718.GD24603@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On 06/12/2018 15:37, Matthew Wilcox wrote:
> On Thu, Dec 06, 2018 at 12:32:47PM +0000, Kieran Bingham wrote:
>> On 04/12/2018 20:47, Luis Chamberlain wrote:
>>> On Mon, Dec 03, 2018 at 03:48:15PM -0800, Brendan Higgins wrote:
>>>> On Thu, Nov 29, 2018 at 5:54 AM Kieran Bingham
>>>> <kieran.bingham@ideasonboard.com> wrote:
>>>>>
>>>>> Hi Brendan,
>>>>>
>>>>> Thanks again for this series!
>>>>>
>>>>> On 28/11/2018 19:36, Brendan Higgins wrote:
>>>>>> The ultimate goal is to create minimal isolated test binaries; in the
>>>>>> meantime we are using UML to provide the infrastructure to run tests, so
>>>>>> define an abstract way to configure and run tests that allow us to
>>>>>> change the context in which tests are built without affecting the user.
>>>>>> This also makes pretty and dynamic error reporting, and a lot of other
>>>>>> nice features easier.
>>>>>
>>>>>
>>>>> I wonder if we could somehow generate a shared library object
>>>>> 'libkernel' or 'libumlinux' from a UM configured set of headers and
>>>>> objects so that we could create binary targets directly ?
>>>>
>>>> That's an interesting idea. I think it would be difficult to figure
>>>> out exactly where to draw the line of what goes in there and what
>>>> needs to be built specific to a test a priori. Of course, that leads
>>>> into the biggest problem in general, needed to know what I need to
>>>> build to test the thing that I want to test.
>>>>
>>>> Nevertheless, I could definitely imagine that being useful in a lot of cases.
>>>
>>> Whether or not we can abstract away the kernel into such a mechanism
>>> with uml libraries is a good question worth exploring.
>>>
>>> Developers working upstream do modify their kernels a lot, so we'd have
>>> to update such libraries quite a bit, but I think that's fine too. The
>>> *real* value I think from the above suggestion would be enterprise /
>>> mobile distros or stable kernel maintainers which have a static kernel
>>> they need to support for a relatively *long time*, consider a 10 year
>>> time frame. Running unit tests without qemu with uml and libraries for
>>> respective kernels seems real worthy.
>>
>> I think any such library might be something generated by the kernel
>> build system, so if someone makes substantial changes to a core
>> component provided by the library - it can be up to them to build a
>> corresponding userspace library as well.
>>
>> We could also consider to only provide *static* libraries rather than
>> dynamic. So any one building some userspace tool / test with this would
>> be required to compile against (the version of) the kernel they expect
>> perhaps... - much like we expect modules to be compiled currently.
>>
>> And then the userspace binary would be sufficiently able to live it's
>> life on it's own :)
>>
>>> The overhead for testing a unit test for said targets, *ideally*, would
>>> just be to to reboot into the system with such libraries available, a
>>> unit test would just look for the respective uname -r library and mimic
>>> that kernel, much the same way enterprise distributions today rely on
>>> having debugging symbols available to run against crash / gdb. Having
>>> debug modules / kernel for crash requires such effort already, so this
>>> would just be an extra layer of other prospect tests.
>>
>> Oh - although, yes - there are some good concepts there - but I'm a bit
>> weary of how easy it would be to 'run' the said test against multiple
>> kernel version libraries... there would be a lot of possible ABI
>> conflicts perhaps.
>>
>> My main initial idea for a libumlinux is to provide infrastructure such
>> as our linked-lists and other kernel formatting so that we can take
>> kernel code directly to userspace for test and debug (assuming that
>> there are no hardware dependencies or things that we can't mock out)
>>
>> I think all of this could complement kunit of course - this isn't
>> suggesting an alternative implementation :-)
> 
> I suspect the reason Luis cc'd me on this is that we already have some
> artisinally-crafted userspace kernel-mocking interfaces under tools/.

Aha - excellent - I had hoped to grab you at Plumbers to talk about
this, after hearing you mention something at your Xarray talk - but
didn't seem to find a suitable time.

> The tools/testing/radix-tree directory is the source of some of this,
> but I've been moving pieces out into tools/ more generally where it
> makes sense to.

Sounds like we already have a starting point then.


> We have liburcu already, which is good.  The main sticking points are:
> 
>  - No emulation of kernel thread interfaces

Scheduling finesse aside, This shouldn't be too hard to emulate/wrap
with pthreads?


>  - The kernel does not provide the ability to aggressively fail memory
>    allocations (which is useful when trying to exercise the memory failure
>    paths).

Fault injection throughout would certainly be a valuable addition to any
unit-testing.

Wrapping tests into a single userspace binary could facilitate further
memory leak checking or other valgrind facilities too.



>  - printk has started adding a lot of %pX enhancements which printf
>    obviously doesn't know about.

Wrapping through User-mode linux essentially provides this already
though. In fact I guess that goes for the thread interfaces topic above too.


>  - No global pseudo-random number generator in the kernel.  Probably
>    we should steal the i915 one.
> 
> I know Dan Williams has also done a lot of working mocking kernel
> interfaces for libnvdimm.


Thanks for the references - more to investigate.

-- 
Regards
--
Kieran
