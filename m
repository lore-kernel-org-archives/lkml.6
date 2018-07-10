Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A832EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA0F2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4bD+sT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA0F2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933245AbeGJKcd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:32:33 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40958 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932172AbeGJKc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:32:29 -0400
Received: by mail-oi0-f67.google.com with SMTP id w126-v6so41616467oie.7;
        Tue, 10 Jul 2018 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=khS7D/OkYfdUVcKGmyvawna1j46BuK/HifDdC0ilySE=;
        b=A4bD+sT3OW8+UjP43+tpEo0fQGzBZScNr+9BafeVNUK2ewyYHUiwGUgHcot1ITuiH6
         P2IRwofS0P7OBsjocBFiMT2qRW9SV5XCMOk7zp8XeysqC9W3Zgut3jrZKN73N3akY+TR
         MaP68G7rsr0XUWWnOyiYAYD01LIxigfkaaEgch/ylHuLNftsrJlMJ5cvRAuq5l/s2j3/
         6jX4JvlqJamee+pIi1m/XSiQCjy1ShazA/j+AYxYFSCjOknhw9HmACyJwpb/5/suMm8Q
         zvOhWapnKfKbmDhHZpOSUBL8usoJc9oS6wKEnXS/BlcFaxhIP8I8y9NHoMH6kca0/IzZ
         BZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=khS7D/OkYfdUVcKGmyvawna1j46BuK/HifDdC0ilySE=;
        b=oOTxAnLSmndPbnazk/3cHPbpHwvoYCDD+SLsb8Qii9qEKCLxDf/69S6RCrI6WWPcZ6
         QvugKYeMiFG/0IYerXh+qfIp1UdgSxwOPa3/h0gQUohvdAV1o0Bw54FxApqbqd2uRJKS
         xk1XCAd+/6SE1Y2UHPEOTCAoHI4V9qPkafibNdUaQlPO0Mg2XXAp4yDzPuIymKa2+hzF
         yGWVovdS2ey1nT1sk6lVkOUFXq519Buu2mV1CpRiv4qKDH7POFqqKW2Z9xEpMziiVfUj
         rMDUN/CvUjOL8cnU46kYwkZ5DCX8i1H2/1UDh/oqGfKOJxS4QQ+FgImml4h1sTupnMGo
         DeIQ==
X-Gm-Message-State: APt69E2XavJqCz4/0pDNgc3Ub5DLh1vqx2gDRzbRheZQWP78er1JOJ1M
        EVA3g4PSSHy47UpfRNhugU8fPG4+UbpypzLMYoo=
X-Google-Smtp-Source: AAOMgpdJGk8qSllvajZjyANBSsen8irjnOs+8RD1nqSBzxj8NADbCflkDpv3qjCznlQkZT4mirM2WvBmhX+2bR0cO+4=
X-Received: by 2002:aca:ccc4:: with SMTP id c187-v6mr25299446oig.282.1531218749069;
 Tue, 10 Jul 2018 03:32:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 03:32:28
 -0700 (PDT)
In-Reply-To: <5b134ed3-b473-90f3-acc7-5943e1669bb5@ti.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <2108146.dv4EAOf6IP@aspire.rjw.lan> <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan> <CAErSpo4eaaieQiZjAejXAoCv82wddPOcRQXpiqD6X=fFW5XAHQ@mail.gmail.com>
 <CAJZ5v0hVDo-Y2gPTxd6yHVY=vr093hai1VhLzNzzhFkKe0LoKA@mail.gmail.com>
 <CAErSpo4TOiBtdG0iwgeFpv76Lhs4s7PXAWv5_DG-VRyEoP5bOQ@mail.gmail.com> <5b134ed3-b473-90f3-acc7-5943e1669bb5@ti.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jul 2018 12:32:28 +0200
X-Google-Sender-Auth: ZuAhyvFm53vRzpkbHG4R0O0lOLQ
Message-ID: <CAJZ5v0j3Ss5Sa++ZjudMN0Jo2mu5YY6qJ4yEA5TG-zn=qYw2jg@mail.gmail.com>
Subject: Re: [PATCH] driver core: Drop devices_kset_move_last() call from really_probe()
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 8:19 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> +Mark, Liam
>
> Hi,
>
> On Tuesday 10 July 2018 03:36 AM, Bjorn Helgaas wrote:
>> [+cc Kishon]
>>
>> On Mon, Jul 9, 2018 at 4:35 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Mon, Jul 9, 2018 at 3:57 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>> On Fri, Jul 6, 2018 at 5:01 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>>
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> The devices_kset_move_last() call in really_probe() is a mistake
>>>>> as it may cause parents to follow children in the devices_kset list
>>>>> which then causes system shutdown to fail.  Namely, if a device has
>>>>> children before really_probe() is called for it (which is not
>>>>> uncommon), that call will cause it to be reordered after the children
>>>>> in the devices_kset list and the ordering of that list will not
>>>>> reflect the correct device shutdown order.
>>>>>
>>>>> Also it causes the devices_kset list to be constantly reordered
>>>>> until all drivers have been probed which is totally pointless
>>>>> overhead in the majority of cases.
>>>>>
>>>>> For that reason, revert the really_probe() modifications made by
>>>>> commit 52cdbdd49853.
>>>>
>>>> I'm sure you've considered this, but I can't figure out whether this
>>>> patch will reintroduce the problem that was solved by 52cdbdd49853.
>>>> That patch updated two places: (1) really_probe(), the change you're
>>>> reverting here, and (2) device_move().
>>>>
>>>> device_move() is only called from 4-5 places, none of which look
>>>> related to the problem fixed by 52cdbdd49853, so it seems like that
>>>> problem was probably resolved by the hunk you're reverting.
>>>
>>> That's right, but I don't want to revert all of it.  The other parts
>>> of it are kind of useful as they make the handling of the devices_kset
>>> list be consistent with the handling of dpm_list.
>>>
>>> The hunk I'm reverting, however, is completely off.  It not only is
>>> incorrect (as per the above), but it also causes the devices_kset list
>>> and dpm_list to be handled differently.
>>
>> If I understand correctly, you are saying:
>>
>>   - the 52cdbdd49853 really_probe() hunk fixed a problem, but
>>   - that hunk was the wrong fix for it, and
>>   - this patch removes the wrong fix (and probably reintroduces the problem)
>>
>> If devices_kset is supposed to be ordered so children follow parents,
>> I agree the really_probe() hunk doesn't make much sense because the
>> parent/child relation is determined by the circuit design, not by the
>> probe order.
>>
>> It just seems like it's worth being clear that we're reintroducing the
>> problem fixed by 52cdbdd49853, so it needs to be solved a different
>> way.  Ideally that would be done before this patch so there's not a
>> regression, and this changelog could mention what's happening.
>>
>>> It had attempted to fix something, but it failed miserably at that.
>>
>> If you're saying that 52cdbdd49853 *tried* to fix a DRA7XX_evm reboot
>> problem, but in fact, it did not fix that problem, then I guess there
>> should be no issue with reverting that hunk.
>
> It did fix a problem making sure the regulator's shutdown is invoked after the
> mmc shutdown. And reverting 52cdbdd49853 reintroduces the problem.

But, of course, it didn't prevent regulator suspend from being run
before mmc suspend, so it really addressed part of the problem only
and while doing that it introduced a regression.

This piece of really_probe() is incorrect and it has to go away.

Thanks,
Rafael
