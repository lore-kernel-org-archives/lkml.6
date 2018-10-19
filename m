Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D10ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69F120658
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69F120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeJTAet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:34:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60910 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeJTAes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:34:48 -0400
Received: from [IPv6:2a00:5f00:102:0:ba02:a122:2d73:c919] (unknown [IPv6:2a00:5f00:102:0:ba02:a122:2d73:c919])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C0D90260CC2;
        Fri, 19 Oct 2018 17:27:57 +0100 (BST)
Subject: Re: [PATCH 0/2] boot to a mapped device
To:     Mike Snitzer <snitzer@redhat.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        device-mapper development <dm-devel@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Will Drewry <wad@chromium.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-lvm@redhat.com, kernel@collabora.com
References: <cover.1537936397.git.helen.koike@collabora.com>
 <CAFLxGvzCDOTR4stPmp1TTLkQ39x3e8MQuL=AR754abKc5skhpA@mail.gmail.com>
 <20180927142328.GA4074@redhat.com>
 <CAGXu5j+Y5e_oTZVCAHa48XgVcvEKGnVW_74oXZOUyLnfYPAjAg@mail.gmail.com>
 <20180927183141.GA4921@redhat.com>
From:   Helen Koike <helen.koike@collabora.com>
Openpgp: preference=signencrypt
Autocrypt: addr=helen.koike@collabora.com; keydata=
 xsFNBFmOMD4BEADb2nC8Oeyvklh+ataw2u/3mrl+hIHL4WSWtii4VxCapl9+zILuxFDrxw1p
 XgF3cfx7g9taWBrmLE9VEPwJA6MxaVnQuDL3GXxTxO/gqnOFgT3jT+skAt6qMvoWnhgurMGH
 wRaA3dO4cFrDlLsZIdDywTYcy7V2bou81ItR5Ed6c5UVX7uTTzeiD/tUi8oIf0XN4takyFuV
 Rf09nOhi24bn9fFN5xWHJooFaFf/k2Y+5UTkofANUp8nn4jhBUrIr6glOtmE0VT4pZMMLT63
 hyRB+/s7b1zkOofUGW5LxUg+wqJXZcOAvjocqSq3VVHcgyxdm+Nv0g9Hdqo8bQHC2KBK86VK
 vB+R7tfv7NxVhG1sTW3CQ4gZb0ZugIWS32Mnr+V+0pxci7QpV3jrtVp5W2GA5HlXkOyC6C7H
 Ao7YhogtvFehnlUdG8NrkC3HhCTF8+nb08yGMVI4mMZ9v/KoIXKC6vT0Ykz434ed9Oc9pDow
 VUqaKi3ey96QczfE4NI029bmtCY4b5fucaB/aVqWYRH98Jh8oIQVwbt+pY7cL5PxS7dQ/Zuz
 6yheqDsUGLev1O3E4R8RZ8jPcfCermL0txvoXXIA56t4ZjuHVcWEe2ERhLHFGq5Zw7KC6u12
 kJoiZ6WDBYo4Dp+Gd7a81/WsA33Po0j3tk/8BWoiJCrjXzhtRwARAQABzR5IZWxlbiBLb2lr
 ZSA8aGVsZW5Aa29pa2Vjby5kZT7CwZcEEwEKAEECGwEFCQLEsxQFCwkIBwMFFQoJCAsFFgID
 AQACHgECF4AWIQSofQA6zrItXEgHWTzAfqwo9yFiXQUCWw2ZAAIZAQAKCRDAfqwo9yFiXajh
 D/9npW1VeySvAQmnmN4syxEbn+EaHOwFTJKSw6vXx9AX/GToCP+5ULeBjHwR/6e5PAwKcDoB
 DSFmV2WWpKvHQqC8AEJX6Aq0lXH4Ub5k8F31UIO+0hyTNc/qnL9LSevVhTK/ugtyPoiyJm+y
 HVkLxlQCZzMZdr7yNHSHXSOGw5NJzL0f0Ttrc9RPSyMYoZKt8Bm/T/Btql1x34T+PjNUwBiH
 saCotMPft6fZyG3pW9hNrNHKU+5lH3vIf8REsCEec/IG7hXW41ETlqZrZB++IlXhUvy7mqwS
 KuT/E72s5aIxEs6YjEDJTqFbOAt3CGMI6GOE8xU0oQSL9wLMW9aG6916oUMMvcx3DD9EhhTN
 G1cRqNJd2Tsnde+nQJvc5GnBZ+7FK/0xRkF8fYCdhdZYuaxk47+KteTAmR/yrxs/9dQ2VI5g
 SMGJb1ZD4C8P9XhRiNCGvBg68JtmjvkUCDh1nTnZj1PB7CiT6N3fTFl83WAohLDdG9n7wM3f
 5k4zBLmWQlBbPdlIzr01SV9dSGC+yhPNZop2hXcNZyPxLJIxpTATtIqHgpIRyA2GkzRJYpGQ
 AhafHBfvhHrHLVaTqTWaDcZyt9e736RjkK8QYnv1hEa7br9OQglGbBbQATr5t7sHv9+gY/sr
 njBiD7iJanr6gtNu3riKXsvJbvlRO0J6gRtJc87BTQRZjjDJARAAxWnRTfwt7t3zQy7oBP7V
 0x6zzuIqffRN0y4u9KDa5ionVPauJEEXvNTq7vgcXrOmzSs9C+IFc6ChK4prWGdLo7AVv3HJ
 A+WTvotj3pJQHmM9Ynd87vxkZLCRVskW4b2CkP/jWfxSefWFeANvaBRrEPShe//vbcSZNgK9
 KjfPpjwDZoFA2v4/KFAA8NrO9VD4/u+dlirWgrTD4PtoiLH8GniajhVuAB4B4zFdZJmzw3k1
 C1d5MGAHsOqt8k/nBbCAKxE5952zoSh11xiCqEbTNVT0TngLwlw84DTApWz736C3Z7JE23HR
 SEVtqHupe4kaFbL/QIte9WgKhL7uqlbPTvRMECU9muD0PSjaA7DTW2tCCgoBgEoqAmHFpf/i
 DOL7kJybfctgf2UBVN3N2it6O5XXFZ2yc3Jzw4A96hcF/1EghZ9BWZuFVcGnYMA+NXr+QgkS
 aXsw0l8S+qNX3MqxYX0AWWyoNZkMLJR2pH3pqFNIPfilHBvpr0f338auN6jAppov3kMhVlML
 pJO8M0vqSnKziw57YAyZAa/YwxwkHdpgvMfx/WwRD1LRQxfv/oKJ8Qbomh0bpj9b+UujVW8P
 F4MD67guCrqrGWSynwzvwWNybEVWV/hykKLa5xtnG6uGUGSO1lnwxUAR17eGWqNwGXYCHpAP
 zboVPGxw4aUcR80AEQEAAcLBfAQYAQoAJhYhBKh9ADrOsi1cSAdZPMB+rCj3IWJdBQJZjjDJ
 AhsMBQkCxLJmAAoJEMB+rCj3IWJdY34QAMVy70677f9vXJsYVndP1xmnMYqnI5CEViQ3GP9W
 k8I2q8nUN3NHyjWe5Ro/UKlj03REymVdtSq7xBRAINQmfgVELvOBEJY6cO8JAujPl4EiJ0kL
 Y7D0+WfRrMvs/pR9jG7h3e3oG080ezRIkh9amGi1rj/uG39vpBc5avNpvOqqdwyCIyAQuG/Z
 00CcD92WMQH3LmZkHJ0A5amZmVp/2NhWFIXnzMGCG+pnenYkYTs+nPwpEeF9aURlT3RQ6MEX
 te5bno0pQAZmJGlfxzPeId4BXGIlyCBGa8AYVcAH4byD/Lj1CWMuF/n+PQOloCMTUQsWuHJG
 WAFfICCspjVwzVDZMr3W3dKesrufYdXM0yVlXc39Zvx2sI94tMPaaFGvk758TQohg28OlPFD
 AxxgkCTrLa8OeJxNJFAz4cmmCWiZbm3SSYLzVFkNozQujL8c3y2U5yM3Tq7RmU9Djxh4s10p
 OoTFbIyky1af/kDLOBTNMXSNJ95+CDyH4g6rHhYJcjUribIgChGr7eLiSdQCpoyjcOe6n7ua
 NDLkOLQPocgjJb/AE46aMq67SVffqOTtLZZNPrSKnw/RVt7kbpRrcz5a45oX1x2kwYBBa//G
 cNC+diAifR6fnbn0lFc5oop99E0SCa0F4V/PYh6myRcqYH8huntTFLvBSYnG/tBYAeu1
Message-ID: <90071912-047f-fb7b-3372-32cca9f2de06@collabora.com>
Date:   Fri, 19 Oct 2018 13:27:55 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180927183141.GA4921@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Sorry the delay of my reply.

On 9/27/18 3:31 PM, Mike Snitzer wrote:
> On Thu, Sep 27 2018 at 12:36pm -0400,
> Kees Cook <keescook@chromium.org> wrote:
> 
>> On Thu, Sep 27, 2018 at 7:23 AM, Mike Snitzer <snitzer@redhat.com> wrote:
>>> On Wed, Sep 26 2018 at  3:16am -0400,
>>> Richard Weinberger <richard.weinberger@gmail.com> wrote:
>>>
>>>> Helen,
>>>>
>>>> On Wed, Sep 26, 2018 at 7:01 AM Helen Koike <helen.koike@collabora.com> wrote:
>>>>>
>>>>> This series is reviving an old patchwork.
>>>>> Booting from a mapped device requires an initramfs. This series is
>>>>> allows for device-mapper targets to be configured at boot time for
>>>>> use early in the boot process (as the root device or otherwise).
>>>>
>>>> What is the reason for this patch series?
>>>> Setting up non-trivial root filesystems/storage always requires an
>>>> initramfs, there is nothing
>>>> wrong about this.
>>>
>>> Exactly.  If phones or whatever would benefit from this patchset then
>>> say as much.
>>
>> I think some of the context for the series was lost in commit logs,
>> but yes, both Android and Chrome OS do not use initramfs. The only
>> thing that was needed to do this was being able to configure dm
>> devices on the kernel command line, so the overhead of a full
>> initramfs was seen as a boot time liability, a boot image size
>> liability (e.g. Chrome OS has a limited amount of storage available
>> for the boot image that is covered by the static root of trust
>> signature), and a complexity risk: everything that is needed for boot
>> could be specified on the kernel command line, so better to avoid the
>> whole initramfs dance.
>>
>> So, instead, this plumbs the dm commands directly instead of bringing
>> up a full userspace and performing ioctls.

Sorry about the missing context, I should've added the change log and
worked a bit more in the cover letter with a more verbose explanation on
the reasons for this patch.

Just for reference (I'll describe better the changes in the next version):

v5: https://www.redhat.com/archives/dm-devel/2016-February/msg00112.html
v6: https://www.redhat.com/archives/dm-devel/2017-April/msg00316.html
v7: http://lkml.iu.edu/hypermail/linux/kernel/1705.2/02657.html
v8: https://www.redhat.com/archives/linux-lvm/2017-May/msg00055.html

>>
>>> I will not accept this patchset at this time.
>>>
>>>>> Example, the following could be added in the boot parameters.
>>>>> dm="lroot,,,rw, 0 4096 linear 98:16 0, 4096 4096 linear 98:32 0" root=/dev/dm-0
>>>>
>>>> Hmmm, the new dm= parameter is anything but easy to get right.
>>>
>>> No, it isn't.. exposes way too much potential for users hanging
>>> themselves.
>>
>> IIRC, the changes in syntax were suggested back when I was trying to
>> drive this series:
>> https://www.redhat.com/archives/dm-devel/2016-February/msg00199.html
>>
>> And it matches the "concise" format in dmsetup:
>> https://sourceware.org/git/?p=lvm2.git;a=commit;h=827be01758ec5adb7b9d5ea75b658092adc65534

Exactly, this is the "concise" format from dmsetup, it also makes it
easier for users to copy and paste from "dmsetup --concise", which
doesn't mean this format is ideal, but imho keeping it consistent with
dmsetup is a good thing, please let me know if you have any other ideas.

>>
>> What do you feel are next steps?
> 
> There is quite a lot of init/ code, to handle parsing the concise DM
> format, that is being proposed for inclusion.  I question why that
> DM-specific code would be located in init/

The main reason was that, taking "md=" and "raid=" as a reference, its
command line arguments are parsed in init/do_mounts_md.c, I could move
the parsing logic to drivers/md/* but I was wondering if it wouldn't be
better to be consistent with init/do_mounts_md.c, what do you think?

> 
> There also needs to be a careful comparison done between the proposed
> init/ code to support consise DM format and the userspace lvm2
> equivalent (e.g. lvm2.git commit 827be0175)

Yes, I am taking a deeper look into the lvm2 parsing code, and actually
we can use almost the same logic for parsing, which seems better because
lvm2 is already using it, we already have some validation/review and it
also seems cleaner.
I'll update this in the next version.

> 
> That aside, the DM targets that are allowed to be supported by this dm=
> commandline boot interface must be constrained (there are serious risks
> in allowing activation of certain DM targets without first using
> userspace tools to check the validity of associated metadata, as is done
> by the DM thin and cache targets).  Also, all targets supported must be
> upstream.  "linear", "verity" and "bootcache" DM targets are referenced
> in Documentation, "bootcache" must be a Google target.  I'm not aware of
> it.
> 
> Mike
> 

I see, I can add this constraint and I'll clean up the documentation for
the next version.


Thank you all for your comments and reviews, I am working on the next
version of this patch series taking yours comments into consideration
and cleaning up several parts of the code and documentation.

Please let me know if you have any other concerns.

Thanks
Helen
