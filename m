Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2021767-1517697341-2-12943888331013694049
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
    t=1517697340; b=aBOWCYWRFS+TLorT4jqF3bFEPPe0d41QBiOY0xoVKFotwRP
    A1A0gvGAyxAJF0PHmpBDk8MLep7lFruixm2lyO9t3FDA6en5ozkMPUFNPiXO4KNr
    52pjLJlqB6pHrkU9+v3HnVrynPgdAyYS45bl3U0lvaPOlIbimhJ8NpAQJ8v+R2q3
    te55G/UFW0ipXABuJwuvFx6m8IuLL7rrDNY152qAr4+wlAIcsDMavQqUG4AjmEn9
    fGAhbUMdCwP2S4c/Tl3ka8ZthD/b/uM45GIP/Vq5YDyQQT964TaDg46Bh24oP8Ks
    DiEh1zz72E/RD8lg2y9BMywxb29XSvv/mn2n1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517697340; bh=ne6Xb3GapCMyndyWItneb1dTScliMu9E7OtNOuuoUN0=; b=U
    050xzSUvH1jqO5++E5jS6xYEPSPsG7BBWffEQAk2xsL/+v/m1VCPM/TjH5v46gXr
    dWtWHqLtBtEo7mhB/JkkUTMJYpQyEdeoxkFUW07MsIDp78TUMXX6YH1CpHnViJZh
    0qXDG/LEYvhHH5Adq9NsmSc+yVwgBhHLENWNLPBryUb99Dyb3yR69PUehsRfnD8l
    nNQhvN7w9lDTKRrfV94VCvlr08b3GK+JlkFjE5sezy5FlPtCc7+S9DNXVsrC6viy
    gTtda7H14qiwliflrJdKohk0nc8YnrepgUkrp+0FaghOKl7OyyGRBPP9zbGumC6k
    1VaL8xUv0XPL2csgh84Tw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hgJ1hAWY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U3HTpUrD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hgJ1hAWY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U3HTpUrD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754567AbeBCWfi (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 17:35:38 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34271 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbeBCWfh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 17:35:37 -0500
X-Google-Smtp-Source: AH8x2256mbqh1OIzYOMxkt4lXUttrVysPiv8N4t0miEjNFEJG2zcB0J8iWfupYES6p3Lw7Ky/cbUeA==
Subject: Re: [PATCH AUTOSEL for 4.9 28/52] led: core: Fix brightness setting
 when setting delay_off=0
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
 <20180203180303.8490-28-alexander.levin@microsoft.com>
 <fb170821-02d5-8aff-5985-9df303f4030a@gmail.com>
Cc: Matthieu CASTET <matthieu.castet@parrot.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <dba34443-fee8-e586-5a74-d2316dac9300@gmail.com>
Date: Sat, 3 Feb 2018 23:34:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <fb170821-02d5-8aff-5985-9df303f4030a@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/03/2018 10:22 PM, Jacek Anaszewski wrote:
> Hi Sasha,
> 
> All 3.18, 4.4 and 4.9 also require the follow-up
> patch [0], similarly like autosel did it for 4.14,
> since this one alone breaks the other use case.

Actually after taking closer look, it turns out that
the patch [0] applies cleanly only to 4.14.

4.9 requires also the patch :

eb1610b4c273 ("led: core: Fix blink_brightness setting race")

3.18 and 4.4 shouldn't have the issue since it was introduced
along with LED_BLINK_SW flag added in 4.7.

Thanks,
Jacek Anaszewski

> [0] https://lkml.org/lkml/2018/2/3/249
> 
> On 02/03/2018 07:03 PM, Sasha Levin wrote:
>> From: Matthieu CASTET <matthieu.castet@parrot.com>
>>
>> [ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]
>>
>> With the current code, the following sequence won't work :
>> echo timer > trigger
>>
>> echo 0 >  delay_off
>> * at this point we call
>> ** led_delay_off_store
>> ** led_blink_set
>> *** stop timer
>> ** led_blink_setup
>> ** led_set_software_blink
>> *** if !delay_on, led off
>> *** if !delay_off, set led_set_brightness_nosleep <--- LED_BLINK_SW is set but timer is stop
>> *** otherwise start timer/set LED_BLINK_SW flag
>>
>> echo xxx > brightness
>> * led_set_brightness
>> ** if LED_BLINK_SW
>> *** if brightness=0, led off
>> *** else apply brightness if next timer <--- timer is stop, and will never apply new setting
>> ** otherwise set led_set_brightness_nosleep
>>
>> To fix that, when we delete the timer, we should clear LED_BLINK_SW.
>>
>> Cc: linux-leds@vger.kernel.org
>> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> ---
>>  drivers/leds/led-core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
>> index 3bce44893021..d70d4a5273b8 100644
>> --- a/drivers/leds/led-core.c
>> +++ b/drivers/leds/led-core.c
>> @@ -186,7 +186,7 @@ void led_blink_set(struct led_classdev *led_cdev,
>>  		   unsigned long *delay_on,
>>  		   unsigned long *delay_off)
>>  {
>> -	del_timer_sync(&led_cdev->blink_timer);
>> +	led_stop_software_blink(led_cdev);
>>  
>>  	led_cdev->flags &= ~LED_BLINK_ONESHOT;
>>  	led_cdev->flags &= ~LED_BLINK_ONESHOT_STOP;
>>
> 
