Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D08C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F3324073
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F3324073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cosifan.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753904AbeGEOA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:00:29 -0400
Received: from mail2.cosifan.de ([85.239.105.221]:47526 "EHLO mail.cosifan.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753417AbeGEOA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:00:27 -0400
X-Virus-Scanned: amavisd-new at cosifan.de
Received: from [192.168.216.41] (unknown [192.168.216.41])
 by mail.cosifan.de (Postfix) with ESMTPSA id E2821A03EE;
 Thu,  5 Jul 2018 16:00:14 +0200 (CEST)
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
To:     Takashi Iwai <tiwai@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <s5hk1qaf9hv.wl-tiwai@suse.de>
 <CAJZ5v0guCPET3gM-G_NAM-BjER2D3yW2i_CwR-5sHyNzCQ6R+Q@mail.gmail.com>
 <s5hk1qaui3w.wl-tiwai@suse.de> <1999215.6UrMtQZ5Bj@aspire.rjw.lan>
 <s5ha7r5vq2r.wl-tiwai@suse.de>
From:   =?UTF-8?Q?Thomas_H=c3=a4nig?= <haenig@cosifan.de>
Openpgp: preference=signencrypt
Autocrypt: addr=haenig@cosifan.de; prefer-encrypt=mutual; keydata=
 xsDiBDy8NoURBACtgvNVUTFG6T3wOZkSzdJ26LEkXupbS8jCaEmAug7cR/dQcUbNhMaR6ijp
 LBmLoCCA/9Yvz6GTdeIKjlY3wJ+NyUMP5R85NsPv9+EjVK6YAIQekhcg6WfcjE6gCsLLBO+M
 nwTaWqLo/Q3q2l18VgB8VNLpFkIzsZG1F0JbpBqajwCglsmt8eQgng+DqoTSZjnkaOj1K4EE
 AIDk4KmByPpQi3kvCoBdQGSmHBN0MowKIMcDGUigVcokcdrDTmL1CFNGavj0wOkP4wl3kIPs
 2zNcVW2WNMgAvhAmaz8w1lfn7p0ax1pUVbC46NwPyaYp2YPwKL+cEiYbFJwKZzihxAXCzxc9
 vQbfzvFYw+6C2+HWMXZW3cLKTrH4BACY5QDpUjG2iiD99EHZqg6bcI1pXnksGJOMg6MSSR9w
 bxKK0qiMSSS5JG7PRk3YgNrtTbEb9neviXkdSh1ItDF4HXJZlj2duCXwQwkIOCWCmYdEO8QU
 moxZbLiBC7zE6fhr0B/MOMIOyPYPPJF89POi09sHdP7cYSDbWrGo2tcICs0rVGhvbWFzIEhh
 ZW5pZyAoQ29zaUZhbikgPGhhZW5pZ0Bjb3NpZmFuLmRlPsJgBBMRAgAgBQJJyNJ2AhsjBgsJ
 CAcDAgQVAggDBBYCAwECHgECF4AACgkQoLaSaJmIjTb0nQCfbTOUH79OLDX1mrBjzvdVs7z3
 V2EAnR3gqGqEpazK2gZvVGYOfGpaFrWWzsBNBDy8NogQBADCdQ/wJ5xopgje7lpWCXfRQLqR
 vKtknjybZxyVpgHQqvTXQj9HK96uPgkCFMwBONTYuQwHKpBjz+1iQRjS6vjSpWj0nSup1dQd
 DB8ZS0ztWr5yUWX4aVQS46v0KEbXVBr0cENVZojcZ06J0MeckR4gsMEzXDedgUKfga6oacz+
 1wADBQQAqS98DcPG7pfFGkP1VLxlWQMUXcLOQhiVBq2uLczTiS5Axzab5mnI22/nDBn4cFYQ
 dU2Swc97pD8ZuE1rr7mfSuoZ1Vupv95TKDZ7KHNfSNKM7hHF69dbWbutOUg/Eg0fMvKrsdjm
 F/XA0VlF03XXgw6xTNwuca4v4IAG6pxVpC7CRgQYEQIABgUCPLw2iAAKCRCgtpJomYiNNunp
 AJ4piTdHnixDPkGiNgVNA4iW7P+hAwCfRGZcwHPpxIqnDkeibEmvO6qcRYs=
Message-ID: <da324a44-9520-db81-2106-146d98431a54@cosifan.de>
Date:   Thu, 5 Jul 2018 16:00:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <s5ha7r5vq2r.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.07.2018 um 14:12 schrieb Takashi Iwai:
> On Thu, 05 Jul 2018 12:41:03 +0200,
> Rafael J. Wysocki wrote:
>>
>> On Thursday, July 5, 2018 11:50:11 AM CEST Takashi Iwai wrote:
>>> On Thu, 05 Jul 2018 11:34:59 +0200,
>>> Rafael J. Wysocki wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Thu, Jul 5, 2018 at 9:05 AM, Takashi Iwai <tiwai@suse.de> wrote:
>>>>> Hi,
>>>>>
>>>>> we've got a regression report since 4.17 about the behavior of
>>>>> power-off with the power button.  When a machine is powered off with
>>>>> the power button on desktop, it reboots after a few seconds instead of
>>>>> power down.
>>>>>
>>>>> The manual power down via "systemctl poweroff" works fine, so it's
>>>>> possibly some spurious wakeup by the power button action, and some
>>>>> ACPI-related change is suspected.
>>>>> The regression still remains in 4.18-rc3.
>>>>
>>>> There are only a few ACPI commits directly related to power management
>>>> between 4.16 and 4.17 and none of them looks particularly suspicious.
>>>
>>> OK, interesting.
>>>
>>>> It looks like the power button state may not be cleared sufficiently
>>>> after it's been pressed which is now visible for some reason.
>>>
>>> Hmm, where can such a state remain?  Since it happens after the
>>> machine turned off, some (ACPI) wakeup bits?
>>
>> Basically, yes.
>>
>> It looks like a GPE may remain active which then triggers wakeup after
>> shutdown.
>>
>> On a hunch, I'm wondering if reverting commit
>>
>> 18996f2db918 ACPICA: Events: Stop unconditionally clearing ACPI IRQs during suspend/resume
>>
>> (may not revert clearly, though) makes any difference.
> 
> OK, I'm building a 4.17.x test kernel with that revert, in OBS
> home:tiwai:bsc1099930 repo.
> 
> Thomas, could you try later the kernel in
>   http://download.opensuse.org/repositories/home:/tiwai:/bsc1099930/standard/
> ?  It'll take an hour or so until the build finishes.

With your new built kernel
4.17.4-1.g6f23755-default

the power button works again, so the revert solved the problem

Thanks
Thomas
