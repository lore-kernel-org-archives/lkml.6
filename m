Return-Path: <kieran.bingham@ideasonboard.com>
X-Google-Smtp-Source: AG47ELsIiYoPhE0UuhWe+DuS77RlZaKh+XhHHmymGT9f1LFL7hprhumsRHDTJ5viFsQGXeY1gaEC
ARC-Seal: i=1; a=rsa-sha256; t=1521185489; cv=none;
        d=google.com; s=arc-20160816;
        b=BO6Yh9IoEEw/2vOB3EGRzuKIdHYf4t6R7vA1PX5wdagryJqBCw/bmC1gafNPvYtrqB
         0PMf/PKiLdAoA0+y4m40sjA7QWty+xWK6p8hjsnJSZshoBBGR7BDgzxdnhldy36EIGHq
         92qK1ozfbl98L2RppRbKMqW49wqZSgvFgrjnEfUS8/Wx2yt/7vmavcZpIfqJasp6vCuP
         Gj0BAwmZbiDMFfXjOM9PPNYNP+zk6xRckAIfmLEZJxR6ISH1WlrP0QJjCvthYBlQQf+7
         wAUDedQ3SUKhFeD50oQjSLXdrjxT5uVhMR6KFWspTfXm7j5LyWv9uEmrpohL4TiJyihu
         asEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=Zeo13r/nYGYZbsIT7FAsiPG2r1uCAth0c1rS0Q3VXXk=;
        b=K2Vow2ifKB3RByTyTln0pfEjxdSjwakQ8a+4NtNPkhBPHUtjeyS+GyzbIn8I5QmhRr
         l+0R+kWsyACMwO4Zlj6t0cU29VZskIGFnA0atpjunot97HxV68FiqybO0jB9UOnBh2w7
         zcvGhTOQVrDDdtvFOx4k2zuch7ObGW1dWrgYDWixDKF16kEIMtVeVVAI4zp2Yt6gVmYF
         AdOzRvZJIeF38W+v9V7a//n+8p4bH/j22I1eC1HxzNA6SZb6dJ3QKpkLNutTUSlsKqbJ
         j+S425e138lImU19KBlbw2W222LOjM0G0OUse1LaC12f3eKVLN0eAc5ulR7QtrphTDn7
         BmTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@ideasonboard.com header.s=mail header.b=B5Rm1xff;
       spf=pass (google.com: domain of kieran.bingham@ideasonboard.com designates 185.26.127.97 as permitted sender) smtp.mailfrom=kieran.bingham@ideasonboard.com
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@ideasonboard.com header.s=mail header.b=B5Rm1xff;
       spf=pass (google.com: domain of kieran.bingham@ideasonboard.com designates 185.26.127.97 as permitted sender) smtp.mailfrom=kieran.bingham@ideasonboard.com
Subject: Re: [PATCH][RFC] kernel.h: provide array iterator
To: Julia Lawall <Julia.Lawall@lip6.fr>, Kees Cook <keescook@chromium.org>,
 Kieran Bingham <kbingham@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-media@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Ian Abbott <abbotti@mev.co.uk>, cocci@systeme.lip6.fr, keescook@google.com
References: <1521108052-26861-1-git-send-email-kieran.bingham@ideasonboard.com>
 <CAGXu5jJETok21C7Au=+hh+1jMwTOqULXpL1QF5S2b_i-CoeoQw@mail.gmail.com>
 <3d969683074366dfa32e2fbb83bf3b65@lip6.fr>
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <f6a501e5-10da-6dac-ba38-735d316dcac0@ideasonboard.com>
Date: Fri, 16 Mar 2018 08:31:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <3d969683074366dfa32e2fbb83bf3b65@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997409535098266?=
X-GMAIL-MSGID: =?utf-8?q?1595078595323693403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kees, Julia,

On 16/03/18 07:41, Julia Lawall wrote:
> Le 16.03.2018 05:21, Kees Cook a écrit :
>> On Thu, Mar 15, 2018 at 3:00 AM, Kieran Bingham
>> <kieran.bingham@ideasonboard.com> wrote:
>>> Simplify array iteration with a helper to iterate each entry in an array.
>>> Utilise the existing ARRAY_SIZE macro to identify the length of the array
>>> and pointer arithmetic to process each item as a for loop.
>>>
>>> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>>> ---
>>>  include/linux/kernel.h | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> The use of static arrays to store data is a common use case throughout the
>>> kernel. Along with that is the obvious need to iterate that data.
>>>
>>> In fact there are just shy of 5000 instances of iterating a static array:
>>>         git grep "for .*ARRAY_SIZE" | wc -l
>>>         4943
>>
>> I suspect the main question is "Does this macro make the code easier to read?"
>>
>> I think it does, and we have other kinds of iterators like this in the

Great :-D - I'm happy to read that response!


>> kernel already. Would it be worth building a Coccinelle script to do
>> the 5000 replacements?

Perhaps - though I suspect each case may have its nuances.

Looking around - I see some loops depend on their 'i' index variable in
different ways, so it might not always be convenient to remove that automagically.

Or perhaps I'd have to provide an alternative _indexed variant somehow which can
include the current offset... (or just include a scoped index in this iterator
some how)

Is there any policy or precedent on creating variables inside the scope of the
loop only through a macro like this?

(I'm sure I recall something in the back of my memory so I'll dig, but if anyone
has pointers...)



> Coccinelle should be able to replace the for loop header. 

I think that would be the main focus.
We would also need to add an iterator somewhere in the scope of the function...



> Coccinelle
> could create the local macro. 

I made the local macro for better readability of my use case ... Other places
could use the core macro directly - or also create a local macro.

That would be a per use case option I believe. But I guess it wouldn't be too
hard to form a macro using coccinelle with the name of the array or type that it
is iterating though.



> Coccinelle might not put the definition in
> exactly the right place.  Before the function of the first use would be
> possible, or before any function.

IMO - a macro to iterate the array specifically should come directly(ish) after
the declaration of the array where possible. (but not inside any struct if the
array is in there of course)



> I don't think that Coccinelle could figure out how to split one loop into
> two as done here, unless that specific pattern is very common.  I guess
> that the split is to add the flush_workqueue, and is not the main goal?

Yes, the split of this loop into two was very specific to this instance of
adding the flush_workqueue in the middle.

It was this process of splitting the loop in two which led me wanting to
optimise the iterators, rather than just duplicating it.


Regards

Kieran Bingham



> julia
> 
> 
> 
> 
>> -Kees
>>
>>>
>>> When working on the UVC driver - I found that I needed to split one such
>>> iteration into two parts, and at the same time felt that this could be
>>> refactored to be cleaner / easier to read.
>>>
>>> I do however worry that this simple short patch might not be desired or could
>>> also be heavily bikeshedded due to it's potential wide spread use (though
>>> perhaps that would be a good thing to have more users) ...  but here it is,
>>> along with an example usage below which is part of a separate series.
>>>
>>> The aim is to simplify iteration on static arrays, in the same way that we have
>>> iterators for lists. The use of the ARRAY_SIZE macro, provides all the
>>> protections given by "__must_be_array(arr)" to this macro too.
>>>
>>> Regards
>>>
>>> Kieran
>>>
>>> =============================================================================
>>> Example Usage from a pending UVC development:
>>>
>>> +#define for_each_uvc_urb(uvc_urb, uvc_streaming) \
>>> +       for_each_array_element(uvc_urb, uvc_streaming->uvc_urb)
>>>
>>>  /*
>>>   * Uninitialize isochronous/bulk URBs and free transfer buffers.
>>>   */
>>>  static void uvc_uninit_video(struct uvc_streaming *stream, int free_buffers)
>>>  {
>>> -       struct urb *urb;
>>> -       unsigned int i;
>>> +       struct uvc_urb *uvc_urb;
>>>
>>>         uvc_video_stats_stop(stream);
>>>
>>> -       for (i = 0; i < UVC_URBS; ++i) {
>>> -               struct uvc_urb *uvc_urb = &stream->uvc_urb[i];
>>> +       for_each_uvc_urb(uvc_urb, stream)
>>> +               usb_kill_urb(uvc_urb->urb);
>>>
>>> -               urb = uvc_urb->urb;
>>> -               if (urb == NULL)
>>> -                       continue;
>>> +       flush_workqueue(stream->async_wq);
>>>
>>> -               usb_kill_urb(urb);
>>> -               usb_free_urb(urb);
>>> +       for_each_uvc_urb(uvc_urb, stream) {
>>> +               usb_free_urb(uvc_urb->urb);
>>>                 uvc_urb->urb = NULL;
>>>         }
>>>
>>>         if (free_buffers)
>>>                 uvc_free_urb_buffers(stream);
>>>  }
>>> =============================================================================
>>>
>>>
>>>
>>>
>>> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
>>> index ce51455e2adf..95d7dae248b7 100644
>>> --- a/include/linux/kernel.h
>>> +++ b/include/linux/kernel.h
>>> @@ -70,6 +70,16 @@
>>>   */
>>>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>>>
>>> +/**
>>> + * for_each_array_element - Iterate all items in an array
>>> + * @elem: pointer of array type for iteration cursor
>>> + * @array: array to be iterated
>>> + */
>>> +#define for_each_array_element(elem, array) \
>>> +       for (elem = &(array)[0]; \
>>> +            elem < &(array)[ARRAY_SIZE(array)]; \
>>> +            ++elem)
>>> +
>>>  #define u64_to_user_ptr(x) (           \
>>>  {                                      \
>>>         typecheck(u64, x);              \
>>> -- 
>>> 2.7.4
>>>
