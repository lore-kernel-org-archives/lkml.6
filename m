Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37602ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F3D20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhxJSmp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F3D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbeGRKTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:19:44 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35945 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbeGRKTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:19:44 -0400
Received: by mail-qt0-f193.google.com with SMTP id t5-v6so3429034qtn.3;
        Wed, 18 Jul 2018 02:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O93GUDLyeuSJNlZ8mD9TukV5cMi2duw7aunstV5XTCM=;
        b=nhxJSmp2EpfctJieN3Td2jSj83DZEfHoA5wh6q/9XZtcoA6Aa0GLz1zSlTXqM9smzS
         fUwm2vptcKxt4dAWYO3vRFTclm6drWXZ5FriOf9wOJVCblWweB9Ut3KU8fDNRzs5oAjD
         ecBXQ9lRuYbHy47NsVsQTv0RrypufoGMsk+SJspne9NWnrhO9hu0vWFDGC1Njvck8t/A
         Bu8NNICayX+JZCqwvf2uMDrxzDzWwwEsyOrSiqn50YU+S/s5dPwy3flmP2OPRVnDSV+2
         fFVUlVIzC6uY3/OfQ7wZZf5vz7gh5SZC5+hHcqAWgKvuceSoDGKGw1f4B1ybXvDxb6zZ
         Q4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O93GUDLyeuSJNlZ8mD9TukV5cMi2duw7aunstV5XTCM=;
        b=bBEiGeHY30cwJpuht2mO7+6MlSlj0Wiqs7aHgFPFWsVFWb8LLZrt3e+9r6N/8H+PGG
         44CiOriojI2ge8AH5SNpc+1ONVTpdSGsuTlJsJnaQjWIq3bZg1ADz+yCsADOO2IY5nDR
         XsZntcCvxG3NZdyFU/bPRmzJV6bBEfmEysOc3xlllEzp4YcpfBLTSUTM4ywFvlbHgPva
         Z8FX+b0irwwPbQyYAYIeBLGrz088zqE7m1tNgTL4+q0CLx7XuWejMrZlA/jSEMJy88UM
         BL68udGTQrsb+kJDHzBUMrxbgZlcI0qx2mmndCSSiZd3dj+lCmIJ0x+O0mfffau/s26G
         +xSg==
X-Gm-Message-State: AOUpUlEt0yIIuGcdG85yFG/Icf0RgOb0YGXDlM4zQmM10s+m6Lx0mqkz
        0bGom7GjzdiSJ4iImZp1Ph0JBA5vP4O/hcw7YwQ=
X-Google-Smtp-Source: AAOMgpcj7usx6detfJToxQpXsl/jE+mSHfDkXSJ7xrv+7ww9qYTn0bsLIzQGZ2xiHhyewyBPXC7gnHq6kuRjDgBY+sU=
X-Received: by 2002:a0c:b310:: with SMTP id s16-v6mr5590163qve.243.1531906960325;
 Wed, 18 Jul 2018 02:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180710154035.26828-1-marc.zyngier@arm.com> <20180710154035.26828-2-marc.zyngier@arm.com>
In-Reply-To: <20180710154035.26828-2-marc.zyngier@arm.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 18 Jul 2018 11:42:28 +0200
Message-ID: <CAFqH_50Ky=yNmUXFjzwdWG0NiEHjBF3Mm0w1gAoSq2zL_E+HbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal_hwmon: Sanitize attribute name passed to hwmon
To:     marc.zyngier@arm.com
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,
Missatge de Marc Zyngier <marc.zyngier@arm.com> del dia dt., 10 de
jul. 2018 a les 17:42:
>
> My Chromebook Plus (kevin) is spitting the following at boot time:
>
> (NULL device *): hwmon: 'sbs-9-000b' is not a valid name attribute, please fix
>
> Clearly, __hwmon_device_register is unhappy about the property name.
> Some investigation reveals that thermal_add_hwmon_sysfs doesn't
> sanitize the name of the attribute.
>
> In order to keep it quiet, let's replace '-' with '_' in hwmon->type
> This is consistent with what iio-hwmon does since b92fe9e3379c8.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/thermal/thermal_hwmon.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index 11278836ed12..0bd47007c57f 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -142,6 +142,7 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>
>         INIT_LIST_HEAD(&hwmon->tz_list);
>         strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
> +       strreplace(hwmon->type, '-', '_');
>         hwmon->device = hwmon_device_register_with_info(NULL, hwmon->type,
>                                                         hwmon, NULL, NULL);
>         if (IS_ERR(hwmon->device)) {
> --
> 2.18.0
>

That's one of the annoying messages you saw for a long time during
boot but you had never time to look at. I am happy that when I found a
slot to look at I found already it was fixed.
Thanks!

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Best regards,
 Enric
