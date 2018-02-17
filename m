Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3035676-1518880343-2-11876593395246334588
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518880343; b=pno57YSgpS3sXpuTFMPg82H7PEI0+cCqGfQFGImu9D5Qjd+
    HCAae7aznlX9rm6OHYd6jIyeB22VoXkVskA6LvlahjMqdJaePhzu2bDGKOXUie6Q
    5wBSqKCeLV+6wHdP7NSiXjFe03GREFbEoEQUu0V2qnaMAqtP7don/HiCX1vapO9L
    SCPVAH8aSFSCY3/t+lVMIAT7zSbFvuHS1dTGYkIo2VS8xcYLD8ZxVWj4mLd7AEmr
    Zhr41jyX7oM9iVwrOkbSvMvLyZEAwmNRse1DeGncdBNykj34TrW9PudhCqrRZ0MV
    ertKn/3f8GqHVqs86NpuFX5YF/449hpkY6a41OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518880343; bh=yF0aoV3v5TyINDz061rF7LMC9EUxu1TSRB3Q65KZ6A0=; b=M
    TkIpT51q1lm8xsACi3at9O8FEEIwQgptQJrmTaYdOWtayZ8OwVUOBN1YOt7if++x
    qdoQn9UYPjk0hbQ+i8Vb3OKDnsGqdJxFbdVUJp75KToA4nF4K8LBlnkMDOxpRjyM
    ntr91UH9q5Hv7/Mh652UlTtLrT3m3HKp8JW4LZzSTTo4ALgv11+l+MZfKVBVqP3u
    WhRhvI55/XgE/DpnjCzmmlzlQefV+rcf15rnDM9KnyKOW4XNe/Zra3e88hobbjZP
    EmgWlCkqc/rK6aLKl5JVlMeJ9QpUGRBKEUsyhqRFwg3uiL0wecuYQH7Og0HB8R1v
    B+wx+F3AcZZ8fudOlMpMQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PgIboW2S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cM+JAFFB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PgIboW2S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cM+JAFFB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751035AbeBQPMV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Feb 2018 10:12:21 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36235 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbeBQPMU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Feb 2018 10:12:20 -0500
X-Google-Smtp-Source: AH8x227gYsJajHpxy5pZlyip+reD4x+WuQve7ibWhUJVXo2oBsB3JZDoR2pk8X6okqJehgwXEoaW1w==
Subject: Re: [PATCH 4.4 095/108] Bluetooth: btusb: Restore QCA Rome
 suspend/resume fix with a "rewritten" version
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
References: <20180215151222.267507937@linuxfoundation.org>
 <20180215151235.620152736@linuxfoundation.org>
 <20180216023147.GB69988@rodete-desktop-imager.corp.google.com>
 <20180216064850.GA26224@kroah.com>
 <20180216181043.GA84497@rodete-desktop-imager.corp.google.com>
 <20180216185220.GA29352@roeck-us.net> <20180217134351.GB28145@kroah.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <befd1dc3-32ee-bd00-876e-a59397cffd37@roeck-us.net>
Date: Sat, 17 Feb 2018 07:12:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180217134351.GB28145@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/17/2018 05:43 AM, Greg Kroah-Hartman wrote:
> On Fri, Feb 16, 2018 at 10:52:20AM -0800, Guenter Roeck wrote:
>> On Fri, Feb 16, 2018 at 10:10:44AM -0800, Brian Norris wrote:
>>> On Fri, Feb 16, 2018 at 07:48:50AM +0100, Greg Kroah-Hartman wrote:
>>>> On Thu, Feb 15, 2018 at 06:31:48PM -0800, Brian Norris wrote:
>>>>> On Thu, Feb 15, 2018 at 04:17:32PM +0100, Greg Kroah-Hartman wrote:
>>>>>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>>>>
>>>>> Consider this an objection:
>>>>>
>>>>> I'm currently arguing that this is unnecessarily regressing power
>>>>> consumption here:
>>>>>
>>>>> https://patchwork.kernel.org/patch/10149195/
>>>>>
>>>>> I'll leave it up to you what to do with this, but if this ends up in
>>>>> Chromium OS kernels, I'm likely to revert it there...
>>>>
>>>> Is that patch in Linus's tree yet?  If so, I'll be glad to also apply it
>>>> here.
>>>
>>> The link is the original patch, where I'm (too late?) complaining about
>>> its side effects. Hans and Marcel are discussing potential alternatives.
>>> This stuff happens in -rc kernels. But you're already ready to push it
>>> out to -stable users? I can try to push another few reverts into Linus's
>>> tree if that really helps, or else you can wait on pushing these to
>>> -stable until 4.16 settles down.
>>
>> FWIW, here are the various commit SHAs.
>>
>> Upstream:			61f5acea8737
>> v4.15 (queued for v4.15.4):	e766a2d7f7c2
>> v4.14 (queued for v4.14.20):	736385472dfa
>> v4.9 (queued for v4.9.82):	1c6fc2167678
>> v4.4 (queued for v4.4.116):	575538a5371d
>>
>> I didn't check older stable kernels.
> 
> Thanks, but I've now released all of these with this patch committed, so
> we are now "bug compatible" :)
> 

FWIW, seems to me that trying to be "bug compatible" with -rc1 upstream
kernels may not really be a good idea for stable releases.

Guenter
