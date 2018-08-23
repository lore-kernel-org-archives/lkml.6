Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D9DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D613208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg6xs/HC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D613208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeHWUgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:36:44 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37184 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeHWUgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:36:43 -0400
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so10524418oic.4;
        Thu, 23 Aug 2018 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PxBH25Id8jTqXCLU43k4dNrlQ5OabbgqPZN7qveV23o=;
        b=Sg6xs/HCkIi/k8q8c2m0pd4aCukt3Uslg1/dbFiaNIlzg58n+kBtn8KkOpPqWEa8ND
         Y9eXlA7i2hbnvQshPnlC0OZ20LHqL74enrZloJisjnPO9ZovfVn+xuEIiXe9N9J+Ia5K
         GD2LY4eqgHTVfV6LBR0LxNCcxQMejSaV4doN33YC6kQNngbGXC4PI+Jpsdg6OvAsEw8y
         IN3K8GWZOUC6X0fa7YCSFDd117H46yZu+rQCqt6kUW1RBhDVYdElxmu4CZI49x6Kifz6
         NktVmOiFOiJEQsc0DKOnBhtqEnQ3SZlI9VbI4TS1yk4RQjgtUWySV3ii7c1mCVfGafJC
         wbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PxBH25Id8jTqXCLU43k4dNrlQ5OabbgqPZN7qveV23o=;
        b=Mz0xtxIPQ5VmORy24WXD6BIWLHe6qzPKKLU4g8KtlKHwiccqdRR/ut9Dfky2MNGwmx
         HV+nUFGkK9khgXkkRvy+ZNxSOllRCWcfhGyWgx4LjJsNJEDvRf4MPHoAk3Oa4S3XveXa
         5bM8YMKRP2+b9P8P6HGGOhmXnSsjQhvfbdQ0Zxa+rOzEPsSAqydqzXDisVA0o+0kMUBw
         4nF4FR4r3veZVnwA33cW7NNAgp2lICdDYZ8f771m1JPOdYgQNvUw8HPRRQetR3sgh5no
         9V45US3wGJCGKueEkAKPJEmzmiRCpPPhR6GFLDIZnqjiSBsaSK/BB3ts56N9SXGeLH7J
         ZKsQ==
X-Gm-Message-State: APzg51AHi8Ajkt+Zj8WGQsU8bNKMbIo+RFrpHv+J+Np7AZKv+XmU1L83
        fYOQTy4zoObip+oasL8XHREtATY4Vf4GOmx2QK6ziU49
X-Google-Smtp-Source: ANB0VdaSrH18FjadpSrIPfB1nPmMXqimrRHBrbxcpjySkk9aG8rhXXSaplvxMq2bH9rTTBOLbqaUGcWxBma7LS0U+rY=
X-Received: by 2002:a54:4805:: with SMTP id j5-v6mr2611498oij.210.1535043964524;
 Thu, 23 Aug 2018 10:06:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:491:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 10:06:04 -0700 (PDT)
In-Reply-To: <87in41nxfx.fsf@kamboji.qca.qualcomm.com>
References: <20180208052801.15670-1-kai.heng.feng@canonical.com>
 <56d650e6-d26f-087c-4e86-2e5d4e859414@nbd.name> <A5972CE9-8325-404A-A63D-ED29E44FB67B@canonical.com>
 <87k1vmeip8.fsf@kamboji.qca.qualcomm.com> <E500FA42-23F1-433F-9BFB-78A2FD1946AF@canonical.com>
 <7170e2d5-a59d-8260-fa8e-f02f583b773f@nbd.name> <6A0F65EF-A7C4-469F-8FAF-CBE314676237@canonical.com>
 <9AF82E83-2EBE-4076-BAFA-EEA44B1DB423@canonical.com> <87in41nxfx.fsf@kamboji.qca.qualcomm.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Thu, 23 Aug 2018 19:06:04 +0200
Message-ID: <CAKR_QV+6yW6c51ve3sV=yadhL5fgPDTKQOfahnjNhtE1RHDzUw@mail.gmail.com>
Subject: Re: [PATCH] ath9k: turn on btcoex_enable as default
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Felix Fietkau <nbd@nbd.name>, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I keep this setting on all the time and just when i read this mail
again i'm suspicious if the bluetooth could actually have an impact on
wifi reception? I am using AR9462 card and it can transmit at 215Mbps
average, but receives only about 125Mbps (2spatial streams AP, 2.4GHz,
AR9531)

On 23/08/2018, Kalle Valo <kvalo@codeaurora.org> wrote:
> Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
>
>> at 12:15, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
>>
>>>
>>>
>>>> On 10 Feb 2018, at 10:05 PM, Felix Fietkau <nbd@nbd.name> wrote:
>>>>
>>>> On 2018-02-10 14:56, Kai Heng Feng wrote:
>>>>>> On 9 Feb 2018, at 3:16 PM, Kalle Valo <kvalo@codeaurora.org> wrote:
>>>>>> Sure, but we have to make sure that we don't create regressions on
>>>>>> existing systems. For example, did you test this with any system
>>>>>> which
>>>>>> don't support btcoex? (just asking, haven't tested this myself)
>>>>>
>>>>> No not really, but I will definitely test it.
>>>>> The only module I have that uses ath9k is Dell=E2=80=99s DW1707.
>>>>> How do I check if it support btcoex or not?
>>>> I just reviewed the code again, and I am sure that we cannot merge thi=
s
>>>> patch. Enabling the btcoex parameter makes the driver enable a whole
>>>> bunch of code starting timers, listening to some GPIOs, etc.
>>>>
>>>> On non-btcoex systems, some of those GPIOs might be floating or even
>>>> connected to different things, which could cause a lot of undefined
>>>> behavior.
>>>>
>>>> This is simply too big a risk, so there absolutely needs to be a
>>>> whitelist for systems that need this, otherwise it has to remain
>>>> disabled by default.
>>>
>>> So what information can we use to whitelist btcoex chips?
>>> Can we get btcoex support status at ath9k probing?
>>
>> Sorry for bringing this up again.
>>
>> Is DMI based match an acceptable approach for ath9k?
>
> I don't know what Felix thinkgs, but to me using DMI sounds like a good
> idea to try, assuming the matches are unique enough and there's no risk
> of enabling bt coex on wrong platforms. Should the PCI bus number etc
> checked as well in case the user adds more ath9k devices to the
> platform?
>
> But of course I need to see the patch to comment more.
>
> --
> Kalle Valo
>
