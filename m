Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeFDXJ2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:09:28 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39311 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752023AbeFDXJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:09:27 -0400
X-Google-Smtp-Source: ADUXVKKPUJ9HEOSeF6qe7wgA9P/KSbxxr3jue1lY8ME1bCrobMsiC4F48XDWEzDTCuKbUVRUmIs67g==
Subject: Re: [PATCH] arm64: dts: stingray: Add otp device node
To: Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1527106630-4760-1-git-send-email-scott.branden@broadcom.com>
 <c9219029-6e45-1889-6326-470d2bc9e46c@gmail.com>
 <f6f3e76e-eac9-797d-fea5-eac64327ec7f@broadcom.com>
 <efaf0373-2959-b238-e5f3-ae7e16534384@gmail.com>
 <e641f180-0b7e-678c-07c4-834ff0676b34@broadcom.com>
 <2d6cc541-7987-5b4c-a847-6fcbb27e12d2@gmail.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <2a159d0f-77dc-f03f-a7f6-9e5c51eba70a@broadcom.com>
Date: Mon, 4 Jun 2018 16:09:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2d6cc541-7987-5b4c-a847-6fcbb27e12d2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-06-04 03:41 PM, Florian Fainelli wrote:
> On 06/04/2018 03:33 PM, Scott Branden wrote:
>>
>> On 18-06-04 02:33 PM, Florian Fainelli wrote:
>>> On 06/04/2018 02:30 PM, Scott Branden wrote:
>>>> Hi Florian,
>>>>
>>>>
>>>> On 18-06-04 02:24 PM, Florian Fainelli wrote:
>>>>> On 05/23/2018 01:17 PM, Scott Branden wrote:
>>>>>> Add otp device node for Stingray SOC.
>>>>>>
>>>>>> Fixes: 2fa9e9e29ea2 ("arm64: dts: Add GPIO DT nodes for Stingray SOC")
>>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>>> Applied to devicetree-arm64/next with s/otp/OTP/ and removing the Fixes
>>>>> line since that is not a bug fix AFAICT.
>>>> It fixes the issue that OTP is not active as it is missing the device
>>>> node?
>>> By that token, any peripheral that is being added at some point in the
>>> lifetime of this DTS would qualify as a bugfix when it is in fact
>>> feature/peripheral enabling.
>>>
>>> I could not see the relationship between the commit being provided in
>>> the "Fixes:" tag and OTP, am I missing something?
>> The relationship is the fixes tag points was selected to the last tag
>> when the commit applies directly against (and is far enough back that it
>> covers any possible LTS kernels that would have needed it).
> I understand how ones gets to select an appropriate Fixes: tag, what I
> don't understand is the relationship between the two changes, like why
> would a GPIO Device Tree node influence the OTP peripheral here when
> there is no pinmux or GPIO phandle of some sort linking the two. Also,
> since you guys were very trigger happy with Fixes: tag lately (referring
> to the internal review of Srinath's changes) this one looked a lot like
> that.
>
> The only thing I am questioning here is treating that particular
> changeset as a bugfix proper. Yes it is technically a fix in that,
> without this changeset the OTP node is not there and that is
> functionality you want, but it is not preventing the platform from not
> booting for instance, or having an incorrect behavior for an established
> behavior before, right?
>
>> In this case
>> I don't care too much about whether this is fixed in LTS or not.  If
>> needed I'll send a request for the commit be ported to stable.
> If this is a true fix, I don't mind taking it as-is and keeping the
> Fixes: tag, keep in mind the following:
>
> I always treat bug fixes with a higher priority than features, and I
> will do my best to queue up fixes (separate branches, all ending in
> /fixes) and submit those at any time in the release cycle so they can
> land in Linus' tree and in the -stable trees as fast as possible.
>
> Don't bypass the maintainer if you can convince me this is a proper fix,
> then I will just move that patch into the appropriate branch, and you
> will get those stable backports automatically.
For now, nobody needs it in the LTS.  The OTP driver hasn't actively 
been used by applications.
So not critical for backport right now.  It's in now so OTP won't be a 
problem going forward.
> Thanks for reading me.
