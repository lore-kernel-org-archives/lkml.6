Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350AAECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D274A2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2H+TLs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D274A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbeGQHyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:54:35 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39036 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeGQHyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:54:35 -0400
Received: by mail-oi0-f67.google.com with SMTP id d189-v6so197246oib.6;
        Tue, 17 Jul 2018 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=el7ejpWXstJDyd+qyxw0SMZcUiX9w1BBKOxZq/mVX/4=;
        b=H2H+TLs5Kuv1UlErNkAqFzh6ypheugyID4jCaSKhe9nWmWXTcQzbPLtNZV4cVyKvpg
         YhRrHQrQDuLMuP2sbLQEt7u9/kpyeKMopKs8Cjqi34xrhKQUG8L/+JRw1yTMnGylZ+yv
         CfTlI9pO4zL+6mPMhnkcq7HRg7w/STLyY3YfZZxY7H++ifiK8NW9XfQ4/YVgsugmR34G
         sew9jCeLVhNiyCVfqRIYKeVtULtfOwvag4yTH32J+mPp5y0ZJ9MidBaKlwSf2KmJm2S4
         NDxZwwURdFUBWkDcPyXPAU7UjmISzu7zycsbTVny3TvFg8soliNQg0ALq7SpyaXbe4LC
         Z3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=el7ejpWXstJDyd+qyxw0SMZcUiX9w1BBKOxZq/mVX/4=;
        b=qt8fsTEbz75eanAMB6C/hMAB5xQHCFJOjMMWonNwTo9kvwBDVdPskGxwZBcYg2entc
         /o1ogud+W4Eip2cTZN/W15dacxzdbxIj0zf0dBJR436hV0Bp55D2plBtfB2CR7WZE9h6
         gny8Qup8+UyhPcSk2asV9eN2Tii7c5C+/2jB1J7LeSP9Tz1ILdoUwDOvMTnm553uvv1X
         kU09kzHZGrZye1oTJTkZ4CT2wJw3N5cWsNXG2DZBXujvyEyNd9wVSWYhEHyN26Tc8y+0
         Jc3myLF2N38tzceuK0sEDgkOUkmjWXacA3aCwyfra0d37jfBlQUTccxfGc88dpmxIgJ9
         cObA==
X-Gm-Message-State: AOUpUlG1fL6Ttp+9xiBSO2FVsHJ7k+d89J852YvuzjEQXFyNqBWHKJq1
        qb+bW/o1isG5rdo3GX1Fmdwj7q8SGLL/dM5rB8s=
X-Google-Smtp-Source: AAOMgpebIfC3BrK6jgyy7V3rfVUKFe5aDVhum9VmGkS86YsUOrvV6lMJSA/+0gvxiPPtmYWcDVk9NvJ3XlEEFP9ti4E=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr454245oia.154.1531812203814;
 Tue, 17 Jul 2018 00:23:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 00:23:23
 -0700 (PDT)
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53BB4D759@ORSMSX110.amr.corp.intel.com>
References: <s5hk1qaf9hv.wl-tiwai@suse.de> <1704080.gFTvVrrZA1@aspire.rjw.lan>
 <6f01a906-b27c-0e1a-e9f6-fa27c015faa3@cosifan.de> <2396867.eZQXUlvGZn@aspire.rjw.lan>
 <CF6A88132359CE47947DB4C6E1709ED53BB4D759@ORSMSX110.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jul 2018 09:23:23 +0200
X-Google-Sender-Auth: 0p8VSuK3hJDx8BBpjffHq5LFbXM
Message-ID: <CAJZ5v0gzK6bbQvmbhBwcTapC_DNR5wkxAymNQAs1_E4ESfXxFw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Clear status of all events when entering S5
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        =?UTF-8?Q?Thomas_H=C3=A4nig?= <haenig@cosifan.de>,
        Takashi Iwai <tiwai@suse.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 7:59 PM, Schmauss, Erik <erik.schmauss@intel.com> w=
rote:
>
>> -----Original Message-----
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Sent: Sunday, July 8, 2018 2:10 AM
>> To: Linux ACPI <linux-acpi@vger.kernel.org>
>> Cc: Thomas H=C3=A4nig <haenig@cosifan.de>; Takashi Iwai <tiwai@suse.de>;
>> Schmauss, Erik <erik.schmauss@intel.com>; Linux PM <linux-
>> pm@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel=
.org>
>> Subject: [PATCH] ACPICA: Clear status of all events when entering S5
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> After commit 18996f2db918 (ACPICA: Events: Stop unconditionally clearing=
 ACPI
>> IRQs during suspend/resume) the status of ACPI events is not cleared any=
 more
>> when entering the ACPI S5 system state (power
>> off) which causes some systems to power up immediately after turing off =
power
>> in certain situations.
>>
>> That is a functional regression, so address it by making the code clear =
the status
>> of all ACPI events again when entering S5 (for system-wide suspend or
>> hibernation the clearing of the status of all events is not desirable, a=
s it might
>> cause the kernel to miss wakeup events sometimes).
>>
>> Fixes: 18996f2db918 (ACPICA: Events: Stop unconditionally clearing ACPI =
IRQs
>> during suspend/resume)
>> Reported-by: Takashi Iwai <tiwai@suse.de>
>> Tested-by: Thomas H=C3=A4nig <haenig@cosifan.de>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> Resend https://patchwork.kernel.org/patch/10511451/ with a changelig and
>> tags.
>>
>> ---
>>  drivers/acpi/acpica/hwsleep.c |   15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> Index: linux-pm/drivers/acpi/acpica/hwsleep.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =3D=3D
>> --- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
>> +++ linux-pm/drivers/acpi/acpica/hwsleep.c
>> @@ -51,16 +51,23 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
>>               return_ACPI_STATUS(status);
>>       }
>>
>> -     /*
>> -      * 1) Disable all GPEs
>> -      * 2) Enable all wakeup GPEs
>> -      */
>> +     /* Disable all GPEs */
>>       status =3D acpi_hw_disable_all_gpes();
>>       if (ACPI_FAILURE(status)) {
>>               return_ACPI_STATUS(status);
>>       }
>> +     /*
>> +      * If the target sleep state is S5, clear all GPEs and fixed event=
s too
>> +      */
>> +     if (sleep_state =3D=3D ACPI_STATE_S5) {
>> +             status =3D acpi_hw_clear_acpi_status();
>> +             if (ACPI_FAILURE(status)) {
>> +                     return_ACPI_STATUS(status);
>> +             }
>> +     }
>>       acpi_gbl_system_awake_and_running =3D FALSE;
>>
>> +      /* Enable all wakeup GPEs */
>>       status =3D acpi_hw_enable_all_wakeup_gpes();
>>       if (ACPI_FAILURE(status)) {
>>               return_ACPI_STATUS(status);
>
> Rafael, I've created an ACPICA pull request containing this patch.

OK, thanks!

The patch is in the mainline kernel tree already at this point, so
that's an upstream only thing.

Can you please also do likewise for
https://patchwork.kernel.org/patch/10495943/ ?

Thanks,
Rafael
