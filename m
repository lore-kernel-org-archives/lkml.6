Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2091355-1517949977-2-14141346990481506802
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517949976; b=g5tL65g2hLVFU+hQU5tBIYQ1rrsVJEF0hN8FUPC6mcAGqwX
    1k9TpkNzBO34wIG65/RAwvU5SFOQIzvcYyaEVmvoxpFrySxXoZ7j+E+Av2AK7yvX
    lm4+2glMnnQhDSoA7FK8cYnXA9xrPjxY1accoMCYGyM+bDxeL5QyYZRbE6MfiBO6
    X4bKbaKTwIG7Ui20Z1RyEI8Sqh/GQuIuI0Z6cW+Gdeh+KRPueVmQuLDfPVzqZPut
    EH53P0PqQ8JBiULO0xotCaRzPFhzQa5LtLV9YIk044f5uw9ImC8//bq7YDoj4wuv
    I6/XFDROi3ShITZfCcpAvF+sdhjpWFjdbhqlw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517949976; bh=tZAoLdfvHaDC54OCIal5HiBHmAAU/PyfCTXgTCn5K9w=; b=w
    79GftMPovrhLxMAmumXwENYvQRPvZK5Ii8tgFI8DIrrHe04fr7AP8rXGGh0jhk95
    Dr0LKfvlVyeLqZFfhYo8B+yGFYBR7q3tGxeJ2n9doo4/CaakHdD7egFX3vH4ena8
    yufUA6aj7Ab0PXMn1p6f8bjJBZ72tJz9v26AEYGQEwgy1BHuFagCzGr6TDEtnt7k
    eaMHirQ89SdK8MJaWc4IWWwBM6FCpy6U+M4LfV7yfk2dgQktcH1+jGhbnAABSYVM
    RvaWfT1JfAh8TiZ/mC7SnKrpreJeYZm5eTpxkiOMq/fOBjeNY4tUgMNMoNK6llTP
    UuCwhCE9x44OUgtMGvTog==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=G3ANITlb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Qo8Cniju;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=G3ANITlb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Qo8Cniju;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753640AbeBFUqP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 15:46:15 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:52011 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeBFUqO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 15:46:14 -0500
X-Google-Smtp-Source: AH8x224Jbbkh2XzE5ut/EZm2jF6TtgeQwzGOX3o47ZbDeSuKxMajKNHjh6i1Lh9D+nkydnnzQfQThA==
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Pavel Machek <pavel@ucw.cz>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-65-alexander.levin@microsoft.com>
 <20180203203525.GA5860@amd> <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
 <20180204090531.GA29468@amd> <20180204111500.GB14797@kroah.com>
 <20180204171736.GA1388@amd> <20180206020210.m6gl7vai4p6azb6s@sasha-lappy>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <713113d8-7662-d80c-c62f-af020469d0bf@gmail.com>
Date: Tue, 6 Feb 2018 21:44:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180206020210.m6gl7vai4p6azb6s@sasha-lappy>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/06/2018 03:02 AM, Sasha Levin wrote:
> On Sun, Feb 04, 2018 at 06:17:36PM +0100, Pavel Machek wrote:
>>
>>>>>>> *** if brightness=0, led off
>>>>>>> *** else apply brightness if next timer <--- timer is stop, and will never apply new setting
>>>>>>> ** otherwise set led_set_brightness_nosleep
>>>>>>>
>>>>>>> To fix that, when we delete the timer, we should clear LED_BLINK_SW.
>>>>>>
>>>>>> Can you run the tests on the affected stable kernels? I have feeling
>>>>>> that the problem described might not be present there.
>>>>>
>>>>> Hm, I don't seem to have HW to test that out. Maybe someone else does?
>>>>
>>>> Why are you submitting patches you have no way to test?
>>>
>>> What?  This is stable tree backporting, why are you trying to make a
>>> requirement for something that we have never had before?
>>
>> I don't think random patches should be sent to stable just because
>> they appeared in mainline. Plus, I don't think I'm making new rules:
>>
>> submit-checklist.rst:
>>
>> 13) Has been build- and runtime tested with and without ``CONFIG_SMP``
>> and
>>    ``CONFIG_PREEMPT.``
>>
>> stable-kernel-rules.rst:
>>
>> Rules on what kind of patches are accepted, and which ones are not,
>> into the "-stable" tree:
>>
>> - It must be obviously correct and tested.
>> - It must fix a real bug that bothers people (not a, "This could be a
>>   problem..." type thing).
> 
> So you're saying that this doesn't qualify as a bug?
> 
>>> This is a backport of a patch that is already upstream.  If it doesn't
>>> belong in a stable tree, great, let us know that, saying why it is so.
>>
>> See jacek.anaszewski@gmail.com 's explanation.
> 
> I might be missing something, but Jacek suggested I pull another patch
> before this one?

Just to clarify:

For 4.14 below patches are chosen correctly:

[PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness setting when
setting delay_off=0
[PATCH AUTOSEL for 4.14 094/110] leds: core: Fix regression caused by
commit 2b83ff96f51d

For 4.9 both above patches are needed preceded by:

eb1610b4c273 ("led: core: Fix blink_brightness setting race")

The issue the patch [PATCH AUTOSEL for 4.14 065/110] fixes was
introduced in 4.7, and thus it should be removed from the series
for 3.18 and 4.4.

-- 
Best regards,
Jacek Anaszewski
