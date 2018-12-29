Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A479CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DE02146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeL2PmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 10:42:01 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59887 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbeL2PmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 10:42:01 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MV6G6-1gkWHV2J4o-00S5p2; Sat, 29 Dec 2018 16:41:31 +0100
Subject: Re: [PATCH v6 0/1] ns: introduce binfmt_misc namespace
From:   Laurent Vivier <laurent@vivier.eu>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, dima@arista.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20181010161430.11633-1-laurent@vivier.eu>
 <7ed6f823-547b-922d-59ff-aba9c4c3ab39@vivier.eu>
 <1541041159.4632.6.camel@HansenPartnership.com>
 <CAG48ez3HnkRM6bUZMNjuTy5DgujgamEKhZOEWDfCjqW7fTJSzQ@mail.gmail.com>
 <fcebfa0c-b389-5c4d-19b8-2f08b487ec25@vivier.eu>
 <87zhusq3x7.fsf@xmission.com>
 <36933e07-d7b3-49be-4ad9-2028fa1977f7@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a1003659-3c16-5921-b221-befd078dfa42@vivier.eu>
Date:   Sat, 29 Dec 2018 16:41:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <36933e07-d7b3-49be-4ad9-2028fa1977f7@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TFRmrc9oPLhpB86hmalHTMv4qTuDTEZxHFGmIf00HMfY2JOXxsg
 ROT7rsk5UUqgDiE1P8gMAtYSDyF/7VZ8JSXXmraEyzxB6wUkQARC2gJmjodMTWo+B8IN2n5
 7NXxXKNCjm12qfPSqMXMluh+Iz/yDIziAGBwfwkndBIP2MkgGodvCb5cWFQY8qqDXyX3k5k
 Nwf3+JwpLu9ZoEImM7d6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IDv4TjktQTA=:4rJUfY+sAr8INwB1UilLBT
 3f+1xnDUYn4RAsg7HsjBb6P2gaashP4l2FCW628D+gWeWcn08SS3Fv+HDzan00icUDlf8KyFs
 Ks1C4NajCT6DMRoMvbUeRIt1H7k1oMqJMV9hFcLJE3BvzoCBv4f8BWRO3zUBHmUgTe3RJFQSm
 cX7EC6JDI/RnyWK2jBJxY5kPvTJV+NNITJPwj+CJdqKsRvV4gIQfIBC8ixQtqjeN82f+/HadP
 k1tkPEmQj/JNREmkrOwMlJqjzp0COz5ua7ruojbfXsEThIbO1+JOEicqFxUc2hDgOp0yEvm2y
 LUAicj5MTtoRJf6nA6Zq51sCHBmvwSKOVnzWxZRquZm6XpjmyhHihGr/sUeUXHZNfLBsKQITN
 AZ0W616q1qhsRC1nLfxQUiBbfTsreVEepQVo7R7I30y+HVLxTcUdYiaHMuHq+ul3HdGkb8A8X
 RltqiKTVQKn311D5xLiBdWKbec2MjJMMvXxvSuVTaAM/vslBgwH7h0a5gkvaXD+voA4oz151U
 Vdo9uexypk/phu2RkYV7dvmXaE06PSDNuAtc38NapFIsgk98OQEW2ocGY9RThG0k43y2bvg1v
 cbWkExUiXosYXFjSXXhNH1VyWdzHWJuvrSVK/G2tYFC9YSR0yTJ9N2In0/BslyjszKr3DJUN8
 +sxx3UdQbiP0v2Ldd/tCReF17EWd2XyV+AxrXbDZhD36H3818LAZyrRABBhX2eefKh00yFbIw
 C7SfTuBdgIKA6fbpq2g0FAOqJKO+e3Tec2U769Hj/zUUijNlNwwJoS/ktYw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping

Thanks,
Laurent

Le 29/11/2018 à 14:05, Laurent Vivier a écrit :
> Le 01/11/2018 à 15:16, Eric W. Biederman a écrit :
>> Laurent Vivier <laurent@vivier.eu> writes:
>>
>>> On 01/11/2018 04:51, Jann Horn wrote:
>>>> On Thu, Nov 1, 2018 at 3:59 AM James Bottomley
>>>> <James.Bottomley@hansenpartnership.com> wrote:
>>>>>
>>>>> On Tue, 2018-10-16 at 11:52 +0200, Laurent Vivier wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Any comment on this last version?
>>>>>>
>>>>>> Any chance to be merged?
>>>>>
>>>>> I've got a use case for this:  I went to one of the Graphene talks in
>>>>> Edinburgh and it struck me that we seem to keep reinventing the type of
>>>>> sandboxing that qemu-user already does.  However if you want to do an
>>>>> x86 on x86 sandbox, you can't currently use the binfmt_misc mechanism
>>>>> because that has you running *every* binary on the system emulated.
>>>>> Doing it per user namespace fixes this problem and allows us to at
>>>>> least cut down on all the pointless duplication.
>>>>
>>>> Waaaaaait. What? qemu-user does not do "sandboxing". qemu-user makes
>>>> your code slower and *LESS* secure. As far as I know, qemu-user is
>>>> only intended for purposes like development and testing.
>>>>
>>>
>>> I think the idea here is not to run qemu, but to use an interpreter
>>> (something like gVisor) into a container to control the binaries
>>> execution inside the container without using this interpreter on the
>>> host itself (container and host shares the same binfmt_misc
>>> magic/mask).
>>
>> Please remind me of this patchset after the merge window is over, and if
>> there are no issues I will take it via my user namespace branch.
>>
>> Last I looked I had a concern that some of the permission check issues
>> were being papered over by using override cred instead of fixing the
>> deaper code.  Sometimes they are necessary but seeing work-arounds
>> instead of fixes for problems tends to be a maintenance issue, possibly
>> with security consequences.  Best is if the everyone agrees on how all
>> of the interfaces work so their are no surprises.
> 
> I don't know where we are in the merge window, but is there something I
> can do to have this merged?
> 
> Thanks,
> Laurent
> 

