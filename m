Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F83C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C9520868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpcLTqdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C9520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeLHGjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 01:39:18 -0500
Received: from mail-vk1-f177.google.com ([209.85.221.177]:43100 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeLHGjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 01:39:17 -0500
Received: by mail-vk1-f177.google.com with SMTP id o130so1446280vke.10;
        Fri, 07 Dec 2018 22:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=CGWP46JBeuRCg3v0dljRFUPXJCpFsKo4GvsUsAFImnQ=;
        b=DpcLTqdxNaXbJk6lu8XYUsPy8yIdS9Jo97LZ6oojOQW+VWw2r1Lv6c202UHQkSr1IT
         G29ho/oT2PMkTU6yMMMggs2tSv4AtAicHXSJktd3JTBA38b/ZOIWRCXsBhtP5m611TKx
         cvAFr8CSy3R4u8wAe+smRIQU/nPSQmNT6AMIwOrqjXun6n6eNO5i7EnNn447PWlXBnVN
         kk742R9JZM01tTFdVNXu91NbEtZWoQhtyubx+27XWRB/ZnUEzQ9IKYIeH8rOvwX+6cF1
         KjnVRkkICnwbNh+zXq0uFYszYGN69F1e/fC1vhA4+knA2YKJDIW9UuygxTHECZQhiFT5
         eJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CGWP46JBeuRCg3v0dljRFUPXJCpFsKo4GvsUsAFImnQ=;
        b=tPJugBUw4Tua6VtD7SDTs9e1PePrYGpFapLWa2Q+wVo5+uXrjcCitN+xQsfyD3NyW9
         3hXubEQyNkADdzgnv1QVlZM0QZ0vJVyrqdv/BZ5wFsi8as2HY37pu0yUT0ZUMgRao5vE
         aRtmhiQm65J/OMc3FXQO0Sak8blM6Dh/8Es78Wo6pBOwdAuRmUOBu4h0h/8sO30UpfkR
         95arkeIk98L7PIocthh9F0hmBZqC7FrRQCQPEDfUNh6eyf4zzimHXKtuh0jD5zLE6RjM
         5d0XM0Z8lc7jfFr/fGG1zPylcw2iUVnDvr7swVFrBhB9DaeuVK3yHbw4xXRgXAfqmEsh
         ON+w==
X-Gm-Message-State: AA+aEWYd79idVgqq4mlfKr/wV4677Qxhrw353bCClPwb4b4DQNO6FdNR
        KnVOMY8OdAgwUatBZgLh2w==
X-Google-Smtp-Source: AFSGD/VdvyksXpk7pyWk8f1+MOwQ8armoW/z9cz7rJ7zMHFSbaPSMzE1QK4S6Z9XUqHq2AUhAYLrzw==
X-Received: by 2002:a1f:a702:: with SMTP id q2mr2084037vke.43.1544251155964;
        Fri, 07 Dec 2018 22:39:15 -0800 (PST)
Received: from 960.ws ([2601:902:c200:6512:a7fd:514d:7aab:c075])
        by smtp.gmail.com with ESMTPSA id w140sm1613366vkw.2.2018.12.07.22.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 22:39:15 -0800 (PST)
Message-ID: <3c3dd5eeef2af0c8b913cfddc46663d44dbbf13c.camel@gmail.com>
Subject: Re: [PATCH v9 2/3] x86: add support for Huawei WMI hotkeys.
From:   ayman.bagabas@gmail.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Date:   Sat, 08 Dec 2018 01:39:13 -0500
In-Reply-To: <577ee93043ae7f2d3ff9818696c1b759efa5b1c8.camel@gmail.com>
References: <20181203185344.3521-1-ayman.bagabas@gmail.com>
         <20181203185344.3521-3-ayman.bagabas@gmail.com>
         <s5h8t16jut7.wl-tiwai@suse.de>
         <CAHp75VcqiKaWYwMGJcehE9RAC56GExdK5skky2S-eUPs+ekgaA@mail.gmail.com>
         <577ee93043ae7f2d3ff9818696c1b759efa5b1c8.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-07 at 00:52 -0500, ayman.bagabas@gmail.com wrote:
On Mon, 2018-12-03 at 21:17 +0200, Andy Shevchenko wrote:
> On Mon, Dec 3, 2018 at 9:04 PM Takashi Iwai <tiwai@suse.de> wrote:
> > On Mon, 03 Dec 2018 19:53:39 +0100,
> > Ayman Bagabas wrote:
> > > +     if (code == 0x80) {
> > > +             acpi_status status;
> > > +             acpi_handle handle;
> > > +             unsigned long long result;
> > > +             union acpi_object args[1];
> > > +             struct acpi_object_list arg_list = {
> > > +                     .pointer = args,
> > > +                     .count = ARRAY_SIZE(args),
> > > +             };
> > > +
> > > +             args[0].type = ACPI_TYPE_INTEGER;
> > > +             args[0].integer.value = 0;
> > > +
> > > +             status = acpi_get_handle(NULL, "\\WMI0", &handle);
> > > +             if (ACPI_FAILURE(status)) {
> > > +                     dev_err(&wdev->dev, "Unable to get ACPI
> > > handle\n");
> > > +                     return;
> > > +             }
> > > +
> > > +             status = acpi_evaluate_integer(NULL, "WQ00",
> > > &arg_list, &result);
> > 
> > I guess you need to pass handle here?  In the earlier version, you
> > passed \\WMI0.WQ00, so it worked with NULL handle.  But now it's no
> > longer so...
> 
> I think in this case we don't need to have a separate call to get
> handle and try to get integer directly. In either we will have an
> error case if method  / namespace / etc is not found.
> 
> 

I was digging further into the DSDT table of the laptop that has WQ00
method and it turned out that this method is a ACPI_WMI_EXPENSIVE. It
has its own GUID of "39142400-C6A3-40fa-BADB-8A2652834100". I believe
wmi_query_block, which is deprecated BTW, can be used to access this
method instead of acpi_evaluate. However, I don't have a machine to
test it on. Any ideas?


