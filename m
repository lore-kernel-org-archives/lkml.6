Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D3AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5D9206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546947995;
	bh=yDB4UhqnFqYWN8WyYbYrq32odwI+Vs1d2GQAQLY7r2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pklEOlgQgVdT0bbjexNl9zW2zhDxFUpnvjCUYQBRaujJ+ohnRYaO2GsoHOufm0NRc
	 UaOU/L+qfsuTW+cNmRJIjbFOPRtKnBSQYSWzBoIzO9OOmdAw6mpvRK2Ze3/dhk4hTT
	 97MHZakfVxVaZtoEDN3GwChE3AU/hMvKiCe7MN+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfAHLqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:46:34 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39158 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfAHLqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:46:34 -0500
Received: by mail-oi1-f193.google.com with SMTP id i6so3053591oia.6;
        Tue, 08 Jan 2019 03:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=th4IqVR880tViL35e0Azqd3RbttlYjSzwniMxu3gx8U=;
        b=UDkyja0MokNltI12gab/Cld9PYPKHlTWPEFHq8xgUbypbN/BVZdheZv4W7ViGk9De9
         XGS1S9Mk8IQcaMKirzGwZsvCh9Jk80HAizhSv7wQqjLJ/FyTKLbVJt8ifzVcC1PcL0gR
         g6QsNEkaNbHOIeZ5b4cfhpGZzS2lhts/wn8Sn8230/C13Jn/+F1BF6KVKYhNH5Z3pEec
         qLuN0Sg+qsTiPynDJz5HU8GjanDO+pG1h0mQiA96GXHH37wHNgxcl+v4tvLc01RV27/b
         tRw7rexDRfzvdNxLfho3jt63WzozGDvaf+ljZDnNeeWqXtUr1qXGrhwlOBBT5zzZmjwH
         /KQw==
X-Gm-Message-State: AJcUukeO+YHLBMPARvB59dZTGEps9uChNdzBgf13CGgEXPrcmLoXy8ON
        FwJDDt4bI0146185HA88yViVW4+5wk+7KAJM4WM=
X-Google-Smtp-Source: ALg8bN5puYaxcTMmLmN2X+goVTJphamUv1E3hBOxe7MN8uU4YVVR+B6ntDMhOM0Wnazn8Hcek3l3+K/qZGBMtkPNMmc=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr954812oic.33.1546947993253;
 Tue, 08 Jan 2019 03:46:33 -0800 (PST)
MIME-Version: 1.0
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jan 2019 12:46:21 +0100
Message-ID: <CAJZ5v0gohGWgpmTx8mzuWdru2M9xbSGoOV=WBxzVo07JZW3G1g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] add support for power off check in suspend
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic.Desroches@microchip.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 11:56 AM <Claudiu.Beznea@microchip.com> wrote:
>
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>
> Hi,
>
> AT91 platforms support a power saving mode where SoC's power is cut off (we call
> it backup mode). The resume is done with the help of bootloaders.

But still the contents of RAM are preserved?

That would require at least the memory controller to be under power AFAICS.

> To be able to
> suspend/resume Linux to/from this mode all the drivers suspend/resume callbacks
> should save/restore the content of all the active registers. We have 2 problems
> we are trying to solve:
> - some of these drivers are shared with other non Microchip SoCs (e.g. macb
>   driver) and we don't want to disturbe other users of corresponding IPs with
>   all the register save/restore operations;
> - the suspend/resume time for the rest of the power saving mode we are using
>   could be improved if we would know in drivers the suspend mode the platform
>   is switched to.
>
> A solution that would have been solve our problems was proposed in [1] but in
> the end it wasn't accepted. It ended up with the introduction of
> pm_suspend_target_state variable that could be used along with the changes in
> this series.
>
> While the discussion of [1] progressed it has been proposed (in [2]) to
> implement a function that would tell if the platform's power would be cut off
> at the end of the suspend procedure.
>
> The patches in this series does as follows:
> 1/3 - add a new member to platform_suspend_ops that will tell if platform's
>       power will be cut off at the end of the suspend procedure; drivers could
>       use it via platform_off_in_suspend()

I would rather avoid doing this if possible.

Thanks,
Rafael
