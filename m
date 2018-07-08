Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D341C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 08:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F72208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 08:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbmzckhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F72208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932184AbeGHIS0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 04:18:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44151 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752907AbeGHISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 04:18:24 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so30690638oih.11;
        Sun, 08 Jul 2018 01:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=3dFgFOHycfXv7neAbeDK+nZCZP9qUNSpzJeancNjoRc=;
        b=GbmzckhL84qMcRO3F9ZjseVKhOnoYknZ3fx8vVBWgZ5dUO5cOweWMyGpeuqDpAL/hG
         lpIVGnyQ95YBy7QoZGJm6FB3JdeVaY3j8sqDDvySjEWM4BP+5X5lGPUdB6Gx2pWLwoyy
         SLAnUT1HF/rrIjOqP1rvqPwgZC+J6fYINgidvxmsi4AxF/XMU62P8/UbwvIpfyi1Pi0l
         2oGG+gRGny81++Me4NWu5EzIplWGo3kiGa9Si7wfIQNle4lxBt/U5gyBduU+SM19jRnK
         laSGgCGkKUZLewGdUEdYPI98FOrABxwGcdRKybEUXcxz01nVShdhjoiXHigFmc2Eibnh
         Y80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=3dFgFOHycfXv7neAbeDK+nZCZP9qUNSpzJeancNjoRc=;
        b=PAbHcWNvl2p1QBqdgeWLZYzGSdbUrkZ7qNzh3drnzI3URRewky+fvuS9mTqm2GxjbE
         YlLl/PDYd7h64zeA/wfN/St/MZDW+n8jjeeU+UgxLWhOyhO+SL1HtO6okmtEd0+XAuKF
         pecUUXZ2DGNfjp++gYP7NTI0Y4LctvRJuldOCu38hOirxJT9Vo/STxC8/ADQEqWRm8j0
         XmD/W/H1MW3FkbsaGK33+YkD+3oE7Nm5zVWzGQ4GWOd6uK5Ua7bc0teJA8Z5RIhY8R/M
         uMiHxh0KE71qb6dis1mOrBNbJ39swZiNVcjauSWWvxksNaxHFJNRQ8HfGUWUKjCIxwY3
         n8qg==
X-Gm-Message-State: APt69E39U30aQ9yvr8XKYzXRIPwgSWFKVB0ukpB0jXsHSCxX0ursyaJW
        Ck+woBNFhZS9nLecfnPnpJ4inxp+leyCnPgqOG4=
X-Google-Smtp-Source: AAOMgpf3CB4ZWPtjrTjbZ6k2171RrxGvzokjDzCr8Zu5JueNly5Qa/wQt/wM7dY8PwpYdOH6IEtFJHiXkGhqulhCdUQ=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr16790880oia.154.1531037903515;
 Sun, 08 Jul 2018 01:18:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 01:18:22 -0700 (PDT)
In-Reply-To: <c04bb990-8921-90c5-e298-bf68e3c9cd33@cosifan.de>
References: <s5hk1qaf9hv.wl-tiwai@suse.de> <7049b672-859c-e049-a391-f66e4336d4a9@cosifan.de>
 <CAJZ5v0ikijT8MRHRsTAZ=FGPbkTu4QeJENBCeaa7BDP_E964UQ@mail.gmail.com>
 <1704080.gFTvVrrZA1@aspire.rjw.lan> <s5hbmbksg6f.wl-tiwai@suse.de> <c04bb990-8921-90c5-e298-bf68e3c9cd33@cosifan.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 8 Jul 2018 10:18:22 +0200
X-Google-Sender-Auth: j5becRKacLnpDdA-yKdohzfHUe4
Message-ID: <CAJZ5v0ipP8JP01L7E4FwL1K6woda4oBKMxgLRfOiNYujzoY37w@mail.gmail.com>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
To:     =?UTF-8?Q?Thomas_H=C3=A4nig?= <haenig@cosifan.de>
Cc:     Takashi Iwai <tiwai@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 7:57 PM, Thomas H=C3=A4nig <haenig@cosifan.de> wrote=
:
>
>
> Am 06.07.2018 um 14:27 schrieb Takashi Iwai:
>> On Fri, 06 Jul 2018 14:13:04 +0200,
>> Rafael J. Wysocki wrote:
>>>
>>> On Friday, July 6, 2018 1:21:50 PM CEST Rafael J. Wysocki wrote:
>>>> On Fri, Jul 6, 2018 at 1:12 PM, Thomas H=C3=A4nig <haenig@cosifan.de> =
wrote:
>>>
>>> [cut]
>>>
>>>> So the latest patch:
>>>>
>>>> https://patchwork.kernel.org/patch/10511211/
>>>>
>>>> should work for you (please verify) and the change in
>>>> drivers/acpi/sleep.c in it most likely is not necessary.
>>>>
>>>> If you can confirm that this one works for you, I'll send a smaller
>>>> one with the acpi_hw_legacy_sleep() part alone.
>>>
>>> Well, scratch this, sorry.
>>>
>>> The power button probably is a fixed event and it won't be effected by
>>> that patch.
>>>
>>> Instead, please test the patch below.
>>
>> FWIW, the test kernel on OBS home:tiwai:bsc1099930-3 was refreshed
>> with this one.  The release number will be *.g2351e2d.
>>
>>
>> Takashi
>>
>>>
>>> ---
>>>  drivers/acpi/acpica/hwsleep.c |   15 +++++++++++----
>>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>>
>>> Index: linux-pm/drivers/acpi/acpica/hwsleep.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
>>> +++ linux-pm/drivers/acpi/acpica/hwsleep.c
>>> @@ -51,16 +51,23 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
>>>              return_ACPI_STATUS(status);
>>>      }
>>>
>>> -    /*
>>> -     * 1) Disable all GPEs
>>> -     * 2) Enable all wakeup GPEs
>>> -     */
>>> +    /* Disable all GPEs */
>>>      status =3D acpi_hw_disable_all_gpes();
>>>      if (ACPI_FAILURE(status)) {
>>>              return_ACPI_STATUS(status);
>>>      }
>>> +    /*
>>> +     * If the target sleep state is S5, clear all GPEs and fixed event=
s too
>>> +     */
>>> +    if (sleep_state =3D=3D ACPI_STATE_S5) {
>>> +            status =3D acpi_hw_clear_acpi_status();
>>> +            if (ACPI_FAILURE(status)) {
>>> +                    return_ACPI_STATUS(status);
>>> +            }
>>> +    }
>>>      acpi_gbl_system_awake_and_running =3D FALSE;
>>>
>>> +     /* Enable all wakeup GPEs */
>>>      status =3D acpi_hw_enable_all_wakeup_gpes();
>>>      if (ACPI_FAILURE(status)) {
>>>              return_ACPI_STATUS(status);
>>>
> Hello Takashi,
> with the kernel built by you the system shuts down when pressing the
> power button and stays off too!  :-)
>
> So the above mentioned patch to hwsleep.c seems to do the trick.

OK, thanks for verifying!

> Regards and thanks a lot @all!

Cheers,
Rafael
