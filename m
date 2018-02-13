Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-381307-1518539257-2-12235931266931677798
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518539256; b=OjTFqUmdi8FyN+8o0MAYgzklRzTvJPVzSFAPr6W+mrhRRnE
    Fz2pOVRqmBUpw9dKEI1f/QReE7/LRdXuYlWW3aAfIwFTR3VlyHU60AQz/hEUq/02
    MV+5a8ki+6YH50lhful4xQDSJcQ8Y124313D/5ok5m+mtIXpH1QY3FCI9Kyzy01E
    tkUfXlaJhCmvfccNuHUFyrgxhSIi4dMkCcBMZJa/LXhX+YhQgBvXf0IiPwcJrJvD
    3vUHKWSloKoMIi7M/qwKvhUKVX12rRdDNc/N+he9eZPXIpRQcyYQGnIaS3nWkkh4
    oVZoR2stsCIkB3VkC/u1pP3U4jhquVK5PRJ8vNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518539256; bh=XiTYBKL7LkRhlT7Hd5/tUCY+fUheUGchmVrLUmUG00E=; b=o
    kITIILgpXEm1CRS7wzv/QnDYnpgstGbhpMEl9uxbrnfa/GnysOAZuP6GaaXWWsDW
    +PgsSuO+cDYXwd5JAMOo0q1mQess3j6x8VMyDEr6OKvfR1mlWJEAik1jaUXZcsgl
    UHVmPW6wZhEZ4i8zR9ZHUuU5XFQbKeSo8e+DZLLR3pgVC3mURYilTptxQBr5u8EJ
    lorhYKGUYbaY6XlkcpeSM1dLDCHlpckOmCKhbH2S7fVmfGvNiQWihtnG6sm6Y5a3
    0sz93ucHWXLHFogr5CFoQRWFx8e1EU3ufyKc7tmzsjLg5F7YQBUdLHKQd2WK4rbD
    N7budbB6RqoVyqmqBFdTQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lIMqPV0N x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DocLOPNa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lIMqPV0N x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DocLOPNa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964913AbeBMQ1e (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 11:27:34 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35771 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934694AbeBMQ1d (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 11:27:33 -0500
X-Google-Smtp-Source: AH8x227QC0F4fxw4iWpg2uCbPggdvStYEuk+DMJi79jPTJeEkiqDuDt71a9drVSYRpTL5txUF99cjA==
Subject: Re: [PATCH] ALSA: usb-audio: Fix UAC2 get_ctl request with a RANGE
 attribute
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org,
        Stephen Barber <smbarber@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Julian Scheel <julian@jusst.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20180129053755.20136-1-k.marinushkin@gmail.com>
 <s5hvaf95p4i.wl-tiwai@suse.de>
 <40196230-8f73-4cca-08e5-d67bfbea2d6e@gmail.com>
 <s5hinb2aauh.wl-tiwai@suse.de>
 <120bc0f8-f472-268d-1247-3245ae994fe5@gmail.com>
 <s5hk1vh4h02.wl-tiwai@suse.de>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <1212656b-5eae-c3fe-f001-e9594d7bdb80@gmail.com>
Date: Tue, 13 Feb 2018 17:27:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <s5hk1vh4h02.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/13/18 06:04, Takashi Iwai wrote:
> On Mon, 12 Feb 2018 20:32:53 +0100,
> Kirill Marinushkin wrote:
>> Hello maintainers of <stable@vger.kernel.org>,
>>
>>
>> As discussed earlier in this thread, I propose this patch to stable.
>>
>> It fixes the issue, which exists since v2.6.34.
> It's already marked in the applied patch, so you don't need to ping
> stable kernel guys.
>
>
> thanks,
>
> Takashi

Hello Takashi,

Thank you for the clarification

Best Regards,
Kirill
>
>>
>> Best Regards,
>>
>> Kirill
>>
>> On 02/12/18 09:08, Takashi Iwai wrote:
>>> On Thu, 08 Feb 2018 07:21:36 +0100,
>>> Kirill Marinushkin wrote:
>>>> On 02/07/18 06:45, Takashi Iwai wrote:
>>>>> On Mon, 29 Jan 2018 06:37:55 +0100,
>>>>> Kirill Marinushkin wrote:
>>>>>> The layout of the UAC2 Control request and response varies depending on
>>>>>> the request type. With the current implementation, only the Layout 2
>>>>>> Parameter Block (with the 2-byte sized RANGE attribute) is handled
>>>>>> properly. For the Control requests with the 1-byte sized RANGE attribute
>>>>>> (Bass Control, Mid Control, Tremble Control), the response is parsed
>>>>>> incorrectly.
>>>>>>
>>>>>> This commit:
>>>>>> * fixes the wLength field value in the request
>>>>>> * fixes parsing the range values from the response
>>>>>>
>>>>>> Fixes: 23caaf19b11e ("ALSA: usb-mixer: Add support for Audio Class v2.0")
>>>>>> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
>>>>>> Cc: Jaroslav Kysela <perex@perex.cz>
>>>>>> Cc: Takashi Iwai <tiwai@suse.com>
>>>>>> Cc: Jaejoong Kim <climbbb.kim@gmail.com>
>>>>>> Cc: Bhumika Goyal <bhumirks@gmail.com>
>>>>>> Cc: Stephen Barber <smbarber@chromium.org>
>>>>>> Cc: Julian Scheel <julian@jusst.de>
>>>>>> Cc: alsa-devel@alsa-project.org
>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Sorry for the late reply, as I've been (and still) off.
>>>>>
>>>>> Does this bug actually hit on any real devices, or is it only a
>>>>> logical error so far?  In the former case, a Cc to stable is
>>>>> mandatory.
>>>>>
>>>>> In anyway, I'll review and merge it properly once after I back to
>>>>> work.
>>>>>
>>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>> Hello Takashi,
>>>>
>>>> Thank you for your answer. I will wait until you are back to work, don't 
>>>> worry about the late replies.
>>>>
>>>> I did not hit the issue on a real device.
>>>>
>>>> During my UAC2 experiments, I reproduced this issue on the development 
>>>> board, and then tested my solution on it.
>>> OK, if it happened on a development system, it's a real issue, and we
>>> should put Cc to stable.  Now I applied the patch.
>>>
>>> Thanks!
>>>
>>>
>>> Takashi
