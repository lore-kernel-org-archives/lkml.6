Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ED3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36192083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8ZFnvbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36192083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbeKGFln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:41:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37456 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKGFlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:41:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so6303772pgq.4;
        Tue, 06 Nov 2018 12:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tcslFpk0W53zOF+y25Wq/2pkDzrUWGzGbw1NypFVdy4=;
        b=B8ZFnvbx9NL09YqAqjFS9wFKCdDBQcAW9Wn284fBveFiQ/ae0s4sQm+fmS51Hjiffl
         lGXy27tkMmLodBJMaC8+W3FwK/+b6b6f7atm7PrKp+qPLx1wtxN+V2Q3xCETn3lKT4JZ
         c1s1bpCymFeyIrG6hDbH9kgDbA13ThGkGOoHDDxU3CSai38xfdNodMnt5ev372NroPcX
         J/wF5m9XNAU96YZoZIeA+6npSqjBKlMayfr056nGyouBXe9Gl0URQf8t6fjo9uQ4R0Ae
         XfLUZlaUDCMqytLbgthaLHE7WEvA7lQqy2yxo+5/e2K8wbZb2B4tNQH9chJ7m5LI2Tc9
         FZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tcslFpk0W53zOF+y25Wq/2pkDzrUWGzGbw1NypFVdy4=;
        b=QubVibwfdoXkpKMb3gg8PKQIlhlbmlvZIHSy2b3e/FaWgBSFeoDEf5zSFyjf+KLIJr
         0c4B7uUyP64EE0YaUCug+lO0hw2DaYIlThpRujAAJn69MARF4XHEhxTgFPN/4zOCn7Jc
         jl1uZLxcOxl1BA9b9qc4dKl2xkIBWOfnIUmmH3U71NuxjS9GZH+ecXpJvtZM5UjmVzLs
         +OdFVw7FWQW0o9QJN5wT27n1ZJ+8YLjXw6psJGr+efik7EriAcgaZbgl5+BX1qkmweh0
         pGYOVRRep1AY28tDK2FUoPQkYoIwWpNWcfVmocynR0uxVYa/mPKrrvR6zJ+cGiD5AUZc
         IaTQ==
X-Gm-Message-State: AGRZ1gKuwY7W4YF+5ItF0aenECDQWvTBBl4CseHTAzxYs0QYizcup9YD
        hMrpDdtAFy0Rv/RwKdJ6683nhdvVf4dF08sQK5URwUPA
X-Google-Smtp-Source: AJdET5dzMzogfrPH0pkMv+E6Of0Eq1Q6WFu8e5nSgyIs8DrL8IFsgAy70tv5cky7/Wo+0wEYIBAZA1Ansd2wiqcizRM=
X-Received: by 2002:a62:682:: with SMTP id 124-v6mr14301379pfg.161.1541535285879;
 Tue, 06 Nov 2018 12:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20181103065732.12134-1-jprvita@endlessm.com> <566af8d6-638e-8c7b-71b4-a7a8d6e71cdb@redhat.com>
In-Reply-To: <566af8d6-638e-8c7b-71b4-a7a8d6e71cdb@redhat.com>
From:   =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date:   Tue, 6 Nov 2018 12:14:08 -0800
Message-ID: <CA+A7VXUBCp3i18bz+LQ+gVpf_UdZALU=UpHXcCQ8V-eTSwOkJQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, linux@endlessm.com,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans, thanks for your quick response,

On Sat, Nov 3, 2018 at 4:28 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 03-11-18 07:57, Jo=C3=A3o Paulo Rechi Vita wrote:
> > Commit 19fffc8450d4378580a8f019b195c4617083176f fixed reporting
> > "Discharging" on some machines when AC was connected but the battery wa=
s
> > not charging. But now on these machines the battery status is reported
> > as "Not charging" even when the battery is fully charged.
> >
> > This commit takes the battery capacity into consideration when checking
> > if "Not charging" should be returned and "Full" is returned when the
> > capacity is 100%.
> >
> > Signed-off-by: Jo=C3=A3o Paulo Rechi Vita <jprvita@endlessm.com>
>
> acpi_battery_handle_discharging() only gets called if the ACPI_BATTERY_ST=
ATE_DISCHARGING
> bit is set by the firmware in that case if we are not actually dischargin=
g
> returning POWER_SUPPLY_STATUS_NOT_CHARGING is the only correct thing to d=
o,
> we should never return POWER_SUPPLY_STATUS_FULL when the
> ACPI_BATTERY_STATE_DISCHARGING bit is set.
>

I understand the reason behind your original patch, but can you
elaborate on why would it be wrong to return POWER_SUPPLY_STATUS_FULL
if the battery is full and we know it is not actually discharging?
IIUC that is the state returned on hw / firmware that behaves
correctly when there is AC power and the battery has 100% of charge.

> I was about to point you to the upower bug for upower not
> handling POWER_SUPPLY_STATUS_NOT_CHARGING as well as it
> could atm, but I see you've already found that and are working
> on fixing that. That is great, thank you.
>

Yes, I'm trying to fix this problem, but it touches different points
across the stack and there are different possible approaches for how
to present the "Not charging" state to the user. This patch is not
necessarily part of, although closely related to, the bigger problem
of better handling "Not charging". It actually addresses the problem
that the kernel returns "Not charging" when AC is present and the
battery is fully charged, which seems wrong to me, despite of "Not
charging" not being strictly defined anywhere (at least that I know
of).

> As for this kernel-side fix I do not believe that fixing thus in
> the kernel is the right thing to do. We try to stay away from
> heuristics using full_charge_capacity in the kernel since that
> is not really reliable / deterministic.
>

At first I thought that returning POWER_SUPPLY_STATUS_FULL when the
battery is full and AC is present was deterministic enough to have it
in the kernel. But I don't have any prior experience working with this
kind of hardware, so I may very well be wrong on this assumption. It
would be great to get some extra clarification though.

Thanks,
--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
