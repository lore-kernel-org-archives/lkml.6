Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907840-1520970374-2-1732879580943320524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520970373; b=B9o423jZQjB+lzyCIhOsK7ZYOp3ecJTR/qGu3wt2x/n/zk+
    T9BBPPClhMtwNdhcxga/bkVW8FmHoJLD43jBFVMNMFZh1QCg7YjMq1YZDkZyc1+p
    ZS9A8GxhGL35uFFg6o/zD9ipA0mxLUMS20sQ0BeiCg8nxsHQagA+LNPkzXXFiW8C
    mGEXXL8FyK/GKy9+hDnZ/xPDuHv/NrFzGltLsztzowvDstL3mppuq8tRHoul8Eb7
    TC8E/qgNc/Y7W/Vd2L3FIVb0EdXC/UT9wU2MuHDnYncAsSiAMjLEUxifj1gBxs1D
    Xr0P/9YDP2VTVFROSrlGKxeuLq/ZDqGCFZ5Qpdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520970373; bh=M/2omy9bW4HljjMzkzkVZNElxcKB3muL4HrYUnMIGNo=; b=k
    llaoPzj4WswxwLRCKuMrciAk6T9qNO/UOVYedpMOXm8DnqKa00ooQkuhho5FU7al
    9D90mNUqy2xxbNQwGDKF10TcJRwi36pJ3mOhKAImkH6J0yIFz+UPTn7AulCe1V5s
    Ntf1xGko5UONx7FS1n5B6ZJLLIj4UOoC9CMqHLhbuiP4urmd5zP1k5BKUi48OT/H
    wXZy2in7ThBm2EHmGtPAAt2bYHHKxI0uztza2MEG/itvuiegZrmT9mO5NWL3WEou
    Dz4HsyBc1J1aXbxnLADMr0L1PgkACNbi6kfNDv6Qu+nloPx+wd//8eyv66/HY5jH
    UY1jY3Sx5Q8m6MGZhncZQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PhDr7Xsa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hpoapefq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PhDr7Xsa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hpoapefq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeCMTqK (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 15:46:10 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:45862 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCMTqJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 15:46:09 -0400
X-Google-Smtp-Source: AG47ELtp+GISRQSdxBqlhdfzbR9zcePhLSy4Rj1b4sdWMaFxyhnQ1KLVkry7BpxOz8wpwoKCCNagiw==
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
To: Pavel Machek <pavel@ucw.cz>, Greg KH <gregkh@linuxfoundation.org>
References: <20180204090531.GA29468@amd> <20180204111500.GB14797@kroah.com>
 <20180204171736.GA1388@amd> <20180206020210.m6gl7vai4p6azb6s@sasha-lappy>
 <713113d8-7662-d80c-c62f-af020469d0bf@gmail.com>
 <f072a5c1-95f1-e81b-c629-ebdea723e6f4@universe-factory.net>
 <20180312152811.GB16944@kroah.com>
 <5747831a-b237-aa2c-cb47-9773cd2b5956@universe-factory.net>
 <0cd72fe4-2b98-e6f7-6ae7-530524786cec@gmail.com>
 <20180313093703.GB27669@kroah.com> <20180313132748.GA20246@amd>
Cc: Matthias Schiffer <mschiffer@universe-factory.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
X-Enigmail-Draft-Status: N1010
Message-ID: <7a59c129-60be-9c4b-6002-242b873e8468@gmail.com>
Date: Tue, 13 Mar 2018 20:44:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180313132748.GA20246@amd>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/13/2018 02:27 PM, Pavel Machek wrote:
> Hi!
> 
>>>> At least 7b6af2c531 ("leds: core: Fix regression caused by commit
>>>> 2b83ff96f51d") is missing, causing visible regressions (LEDs not working at
>>>> all) on some OpenWrt devices. This was fixed in 4.4.121 by reverting the
>>>> offending commit, but if I followed the discussion correctly, 4.9 should
>>>> get the follow-up commit 7b6af2c531 instead (like 4.14 already did).
>>>>
>>>> Jacek's mail I replied to mentions that eb1610b4c273 ("led: core: Fix
>>>> blink_brightness setting race") should be included in 4.9 as well, but I
>>>> don't know the impact of the issue it fixes.
>>>
>>> It doesn't fix any reported issue, but is just an improvement
>>> aiming at preventing potential races while changing blink brightness.
>>>
>>> After taking closer look it turns out that for the patches in question
>>> to apply cleanly we need in 4.9 also a patch which introduces atomic
>>> bit fields for blink flags.
>>>
>>> Effectively, here is the list of patches required in 4.9 stable:
>>>
>>> Revert "led: core: Fix brightness setting when setting delay_off=0"
>>>
>>> followed by:
>>>
>>> a9c6ce57ec ("led: core: Use atomic bit-field for the blink-flags")
>>> eb1610b4c2 ("led: core: Fix blink_brightness setting race")
>>> 2b83ff96f5 ("led: core: Fix brightness setting when setting delay_off=0")
>>> 7b6af2c531 ("leds: core: Fix regression caused by commit 2b83ff96f51d")
>>
>> Odd, I just got another report that the 4.9.87 release fixed some
>> reported LED issues, so why do I need all of these?

Because 2b83ff96f5 introduces another bug, fixed in 7b6af2c531.
7b6af2c531 in turn uses atomic blink flags introduced in a9c6ce57ec.

eb1610b4c2 fixes theoretical races, actually we can do without it
in stable.

In order to avoid applying patch a9c6ce57ec, we could come up with the
below change which does exactly what 7b6af2c531 intended, but without
atomic blink flags, which are irrelevant for this bug.


diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 3bce448..454ed4d 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -188,6 +188,7 @@ void led_blink_set(struct led_classdev *led_cdev,
 {
        del_timer_sync(&led_cdev->blink_timer);

+       led_cdev->flags &= ~LED_BLINK_SW;
        led_cdev->flags &= ~LED_BLINK_ONESHOT;
        led_cdev->flags &= ~LED_BLINK_ONESHOT_STOP;


I can submit it to stable if it is preferred.

In every case tha patch 2b83ff96f5 needs to be reverted beforehand,
since otherwise none of the discussed patches will apply cleanly
(besides the aforementioned reasoning it has a truncated commit
message).


>> Should I just revert the single 2b83ff96f51d commit here instead?
> 
> I believe so, yes.
> 
> I'm not aware of any _really bad_ issues with LED subsystem in
> 4.9. Take a look at changelog of
> 2b83ff96f51d0b039c4561b9f95c824d7bddb85c -- it fixes rather
> theoretical issue; user can reproduce it by hand in shell, but,
> well... don't do it then.

Greg mentioned that 4.9.87 release fixed some LED issue for someone,
and it was the only LED related patch in that release.

> The rest of fixes ... fix some more theoretical races. I don't think
> it is -stable material, as I pointed out before.

-- 
Best regards,
Jacek Anaszewski
