Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5293C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC0120657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfAQMfp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:35:45 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36125 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfAQMfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:35:45 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so11093372qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p0hScYoFhCRJKP3vcEop4zuq7cql99V1whRlYIUpwhY=;
        b=NKUNty56vUMjvJIbaBRYwGxS6zpgOgfhfzG+FretMN33Zj556MUQMQjtXRd7AYhPs5
         HuuZyByKwaV2Ac6NRBvn46ICQl3yJ4yWrSm0FGp0a9/P7+bfLE5VU11QGv0OqzTOBJri
         9mVIpnJ1Y9Rlo3QNwteVcpxk4sJ68UtbxidC3iMJyrj+Q8j/Cuds1F+YJayst79P4WaF
         oCdlVwCsicKm9lJldtvog5aj2QN3aTgvb9wuoj8/Saph1AFAjRqUW2j4SbbOIqQ3zgA5
         tfnrmk+v0Zda4WId7K+p7E2TjEuRYU1b8xYZDU1qBtST9dWKPaNFLs9qIQIy+0c2xIw5
         7ZQg==
X-Gm-Message-State: AJcUuke6CnaPixI+Fg6j09IpEps6SxAMKQLP07nN0FOEDI/xIWBmavsb
        vW43GL6hT3RdBPdKmXo6XZ9xv/T8b2/vlo0TExLl+6OAaoM=
X-Google-Smtp-Source: ALg8bN6pF7H3QR9yaBdlF8UnPjz6fuCZR37BKStUQtsXB4Cow3Es/b+zV/tgABQQsvWAh/yEGegTM7qFKi/c6vfFTG8=
X-Received: by 2002:aed:3a69:: with SMTP id n96mr11448365qte.246.1547728544291;
 Thu, 17 Jan 2019 04:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20190114084734.3362-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.1901141217550.6626@cbobk.fhfr.pm> <663EE74C-02E8-49DB-A197-2022AFE2D863@canonical.com>
 <2149AEF5-ABBF-4745-89F9-7FF9719251B5@canonical.com> <CAO-hwJLHm8b6X9kX1myz7xx1992VW2tVjdn6xw2n1MVX2dn0=g@mail.gmail.com>
 <1897F291-4EB4-4E4B-87AA-3C16EF321340@canonical.com>
In-Reply-To: <1897F291-4EB4-4E4B-87AA-3C16EF321340@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 17 Jan 2019 13:35:32 +0100
Message-ID: <CAO-hwJ+OQAsJkJj2YRGOE=8NcXhS=XWwdfGSaLjY9Bdvcfn7BQ@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Disable runtime PM on Goodix touchpad
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>, anisse@astier.eu
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 12:41 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
>
>
> > On Jan 17, 2019, at 16:06, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> >
> > On Thu, Jan 17, 2019 at 6:02 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> [snipped]
> >> Goodix says the firmware needs at least 60ms to fully respond ON and
> >> SLEEP command.
> >
> > I was about to say that this is not conformant to the specification.
> > But looking at 7.2.8 SET_POWER of
> > https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn642101(v=vs.85)
> >
> > They say:
> > "The DEVICE must ensure that it transitions to the HOST specified
> > Power State in under 1 second. "
> > But in the RESPONSE paragraph: "The DEVICE shall not respond back
> > after receiving the command. The DEVICE is mandated to enter that
> > power state imminently."
> >
> > My interpretation was always that the device has to be in a ready
> > state for new commands "immediately".
> > However, the first sentence may suggest that the driver would block
> > any command to the device before the 1 second timestamp.
> >
> >>
> >> I’ll see if an 200ms autosuspend can solve all Goodix, LG and Raydium
> >> touchpanels.
> >
> > We already have a I2C_HID_QUIRK_DELAY_AFTER_SLEEP quirk that delay
> > operations after sleep by 20ms. Maybe we can keep the runtime PM but
> > use the same timers to not confuse the hardware.
>
> Yes, but wouldn’t use pm_*_autosuspend() helpers can both solve the issue
> and make the code more cleaner?

You are probably correct :)

I am not too familiar with the details of the runtime PM API, but if
you can make this a barrier to prevent the host to call too many
suspends/resumes in a row, that would be nice.
And we might be able to ditch I2C_HID_QUIRK_DELAY_AFTER_SLEEP and
I2C_HID_QUIRK_NO_RUNTIME_PM.

Adding the involved people in the thread.

Cheers,
Benjamin
