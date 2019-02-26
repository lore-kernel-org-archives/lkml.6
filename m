Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D919C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394C1213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lkZvxAf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfBZGFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:05:08 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36020 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfBZGFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:05:07 -0500
Received: by mail-io1-f68.google.com with SMTP id r136so9615058iod.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBbQSjxgXNOYZnEmoNiNRV58Re9OYSStn0JNxlv7v/o=;
        b=lkZvxAf1FWMD9XdaKePztbZ19t1muIkBBWFeYmpvJU1Fkmw1Bog/cSaLWeL9I/5+tS
         bjyR9sgxgk3B1dqF3NCmCI2F7zCSbx0VXF0pL6Sy+MoVZsgdMmRDae8iy0p8+ItEfzfe
         h1xrJnMNk0BFA/Bu0fiSrZTQXEl1vu7Ez0GR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBbQSjxgXNOYZnEmoNiNRV58Re9OYSStn0JNxlv7v/o=;
        b=kTur1FysoVSGnFQvDvIbjU7XTE8Ju9dl8+8PXhlbWz4pLfOMtlf0fW7mQwH1WwBPxZ
         Y4o6ycsSTPdYU7ciOrCScqbzvx/+6Ip/7RdnWYeSKa9WiaBReIY2jkD8BQKW+wP4Iaqy
         31Ng1Wo15GVUjbMfcyMOiE1j4FhK/XEemGnlm/pasmEEK7NyDvfNswB23Rq0NQ6zNrS6
         OJ2oXy0AOSX5Yt+fIHKtxGCplkNR+zsUDtmF8XM+hFcTb7h/Zrug5e+pSSZ/kowXTmV+
         w+KU6p5u6jLu+1LuMHui8nSVP0ffM7adlhfXUhtwzGVMctlC7tn0VRC6tH4gNxrYbH0S
         g/8w==
X-Gm-Message-State: AHQUAubMhbH/4Fw5BTm9NSlpvFinHcUm9z40VDqhPH/McrF2Z9VawX8e
        UJapX94NQ3vS44hMNsgHEqBeMgPCRiW1q+ilsEq2Bg==
X-Google-Smtp-Source: AHgI3IayJXoPFhflLHgZWELMwCRx0Yb2FMD2NYdu+Ti8duXQp4OzM215LULD3zn5NYbwzLyMEZB1wX1XxAcC/USnIXo=
X-Received: by 2002:a5e:c605:: with SMTP id f5mr11998100iok.252.1551161106550;
 Mon, 25 Feb 2019 22:05:06 -0800 (PST)
MIME-Version: 1.0
References: <20190212113808.3040-1-jagan@amarulasolutions.com>
 <CAMty3ZBaOZoj+xV+e+4BtYdaWA2biwENmngOa9vbbMB=_vbB1w@mail.gmail.com> <59969c88-585c-cb7d-3104-8059b78ed2e3@roeck-us.net>
In-Reply-To: <59969c88-585c-cb7d-3104-8059b78ed2e3@roeck-us.net>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 26 Feb 2019 11:34:55 +0530
Message-ID: <CAMty3ZCT+yBJOnjcvLoKva+E1Zkdgr0aA=_kAreqpM3=c7yczg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: hwmon: Add missing documentation for lm75
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

On Thu, Feb 21, 2019 at 7:32 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/20/19 9:22 AM, Jagan Teki wrote:
> > On Tue, Feb 12, 2019 at 5:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >>
> >> Add missing dt-binding documentation for lm75 hwmon sensor.
> >>
> >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >> ---
> >> Changes for v2:
> >> -  Add all compatible nodes available in lm75.
> >>
> >>   .../devicetree/bindings/hwmon/lm75.txt        | 37 +++++++++++++++++++
> >>   1 file changed, 37 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
> >
> > Any comments on this? It is blocking some dts changes to get merge
> > into Mainline.
> >
>
> Waiting for Rob's Ack.

Any comments?
