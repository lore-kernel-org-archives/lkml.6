Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2401EECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6799D208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6799D208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbeGMJpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:45:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:41018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbeGMJpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:45:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5ACFAD60;
        Fri, 13 Jul 2018 09:31:15 +0000 (UTC)
Subject: Re: [PATCH 02/12] blk: use for_each_if
To:     Joe Perches <joe@perches.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-2-daniel.vetter@ffwll.ch>
 <20180711164058.GC72677@devbig577.frc2.facebook.com>
 <20180711164536.GD72677@devbig577.frc2.facebook.com>
 <965184f9-e5ed-3c8b-bfd7-a033a252371b@kernel.dk>
 <CAKMK7uE5aJq-1wd0ZOhwFaTy3iKMAZsfdAf=Tw+eGxtCmfcVQg@mail.gmail.com>
 <2296606a890a1f3543c5db825ed172f7d295a504.camel@perches.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSFWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmNvbT7CwZcEEwEKAEECGwMFCwkIBwMFFQoJCAsFFgIDAQAC
 HgECF4ACGQEWIQSpQNQ0mSwujpkQPVAiT6fnzIKmZAUCWi/zTwUJBbOLuQAKCRAiT6fnzIKm
 ZIpED/4jRN/6LKZZIT4R2xoou0nJkBGVA3nfb+mUMgi3uwn/zC+o6jjc3ShmP0LQ0cdeuSt/
 t2ytstnuARTFVqZT4/IYzZgBsLM8ODFY5vGfPw00tsZMIfFuVPQX3xs0XgLEHw7/1ZCVyJVr
 mTzYmV3JruwhMdUvIzwoZ/LXjPiEx1MRdUQYHAWwUfsl8lUZeu2QShL3KubR1eH6lUWN2M7t
 VcokLsnGg4LTajZzZfq2NqCKEQMY3JkAmOu/ooPTrfHCJYMF/5dpi8YF1CkQF/PVbnYbPUuh
 dRM0m3NzPtn5DdyfFltJ7fobGR039+zoCo6dFF9fPltwcyLlt1gaItfX5yNbOjX3aJSHY2Vc
 A5T+XAVC2sCwj0lHvgGDz/dTsMM9Ob/6rRJANlJPRWGYk3WVWnbgW8UejCWtn1FkiY/L/4qJ
 UsqkId8NkkVdVAenCcHQmOGjRQYTpe6Cf4aQ4HGNDeWEm3H8Uq9vmHhXXcPLkxBLRbGDSHyq
 vUBVaK+dAwAsXn/5PlGxw1cWtur1ep7RDgG3vVQDhIOpAXAg6HULjcbWpBEFaoH720oyGmO5
 kV+yHciYO3nPzz/CZJzP5Ki7Q1zqBb/U6gib2at5Ycvews+vTueYO+rOb9sfD8BFTK386LUK
 uce7E38owtgo/V2GV4LMWqVOy1xtCB6OAUfnGDU2EM7ATQRbGTU1AQgAn0H6UrFiWcovkh6E
 XVcl+SeqyO6JHOPm+e9Wu0Vw+VIUvXZVUVVQLa1PQDUi6j00ChlcR66g9/V0sPIcSutacPKf
 dKYOBvzd4rlhL8rfrdEsQw5ApZxrA8kYZVMhFmBRKAa6wos25moTlMKpCWzTH84+WO5+ziCT
 sTUZASAToz3RdunTD+vQcHj0GqNTPAHK63sfbAB2I0BslZkXkY1RLb/YhuA6E7JyEd2pilZO
 rIuBGl/5q2qSakgnAVFWFBR/DO27JuAksYnq+aH8vI0xGvwn75KqSk4UzAkDzWSmO4ZHuahK
 tQgZNsMYV+PGayRBX9b9zbldzopoLBdqHc4njQARAQABwsF8BBgBCgAmFiEEqUDUNJksLo6Z
 ED1QIk+n58yCpmQFAlsZNTUCGwwFCQPCZwAACgkQIk+n58yCpmQ83g/9Frg1sRMdGPn98zV+
 O2eC3h0p5f/oxxQ8MhG5znwHoW4JDG2TuxfcQuz7X7Dd5JWscjlw4VFJ2DD+IrDAGLHwPhCr
 RyfKalnrbYokvbClM9EuU1oUuh7k+Sg5ECNXEsamW9AiWGCaKWNDdHre3Lf4xl+RJWxghOVW
 RiUdpLA/a3yDvJNVr6rxkDHQ1P24ZZz/VKDyP+6g8aty2aWEU0YFNjI+rqYZb2OppDx6fdma
 YnLDcIfDFnkVlDmpznnGCyEqLLyMS3GH52AH13zMT9L9QYgT303+r6QQpKBIxAwn8Jg8dAlV
 OLhgeHXKr+pOQdFf6iu2sXlUR4MkO/5KWM1K0jFR2ug8Pb3aKOhowVMBT64G0TXhQ/kX4tZ2
 ZF0QZLUCHU3Cigvbu4AWWVMNDEOGD/4sn9OoHxm6J04jLUHFUpFKDcjab4NRNWoHLsuLGjve
 Gdbr2RKO2oJ5qZj81K7os0/5vTAA4qHDP2EETAQcunTn6aPlkUnJ8aw6I1Rwyg7/XsU7gQHF
 IM/cUMuWWm7OUUPtJeR8loxZiZciU7SMvN1/B9ycPMFs/A6EEzyG+2zKryWry8k7G/pcPrFx
 O2PkDPy3YmN1RfpIX2HEmnCEFTTCsKgYORangFu/qOcXvM83N+2viXxG4mjLAMiIml1o2lKV
 cqmP8roqufIAj+Ohhzs=
Message-ID: <be625c55-26f2-f0df-ecb3-3520d19b9ef1@suse.cz>
Date:   Fri, 13 Jul 2018 11:28:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2296606a890a1f3543c5db825ed172f7d295a504.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 08:45 AM, Joe Perches wrote:
> On Wed, 2018-07-11 at 20:50 +0200, Daniel Vetter wrote:
>> On Wed, Jul 11, 2018 at 8:30 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>> On 7/11/18 10:45 AM, Tejun Heo wrote:
>>>> On Wed, Jul 11, 2018 at 09:40:58AM -0700, Tejun Heo wrote:
>>>>> On Mon, Jul 09, 2018 at 10:36:40AM +0200, Daniel Vetter wrote:
>>>>>> Makes the macros resilient against if {} else {} blocks right
>>>>>> afterwards.
>>>>>>
>>>>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>>>>> Cc: Tejun Heo <tj@kernel.org>
>>>>>> Cc: Jens Axboe <axboe@kernel.dk>
>>>>>> Cc: Shaohua Li <shli@fb.com>
>>>>>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
>>>>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>>>
>>>>> Acked-by: Tejun Heo <tj@kernel.org>
>>>>>
>>>>> Jens, it'd probably be best to route this through block tree.
>>>>
>>>> Oops, this requires an earlier patch to move the for_each_if def to a
>>>> common header and should be routed together.
>>>
>>> Yeah, this is a problem with the submission.
>>>
>>> Always (ALWAYS) CC folks on at least the cover letter and generic
>>> earlier patches. Getting just one patch sent like this is mostly
>>> useless, and causes more harm than good.
>>
>> Ime sending a patch with more than 20 or so recipients means it gets
>> stuck everywhere in moderation queues. Or outright spam filters. I
>> thought the correct way to do this is to cc: mailing lists (lkml has
>> them all), but apparently that's not how it's done. Despite that all
>> the patch series I get never have the cover letter addressed to me
>> either.
>>
>> So what's the magic way to make this possible?
> 
> Jens' advice is crap.

This statement was rather offensive and totally uncalled for, AFAICS.
Why did you write it like that?

> There is no generic way to make this possible.
> 
> BCC's don't work, series that touch multiple subsystems
> get rejected when the recipient list is too large.

I don't know what's the usual limit for recipient list, probably never
hit it myself, but for series that are not so large, I use this approach
to make sure the cover letter is CC'd to everyone that's CC'd in any
patch in the series:

- add per-patch Cc:'s to the git commit logs
- clear out *.patch from the working dir
- git format-patch --cover-letter ...
- edit cover letter
- git send-email ... --cc-cmd=./cc.sh ...

where cc.sh contains this:

#/bin/sh
if [[ $1 == *cover-letter* ]]; then
        grep '<.*@.*>' -h *.patch | sed 's/^.*: //' | sort | uniq
else
        grep '<.*@.*>' -h $1 | sed 's/^.*: //' | sort | uniq
fi

That proceses all tags besides Cc (acked-by, reported-by etc) and turns
them to Cc's for each patch (or does git now do that by itself as well?)
and for cover letter, it accumulates that from all the patches.

Vlastimil

> I think you did it correctly.
> 

