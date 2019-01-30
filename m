Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B7C282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC9A21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="DIBrp5I9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbfA3QTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:19:54 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33475 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbfA3QTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:19:53 -0500
Received: by mail-vk1-f193.google.com with SMTP id d201so33213vka.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 08:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1OSTSUc+1gsns6jfkPG4uHPBgSAMiDJvTOmjA9DSHk=;
        b=DIBrp5I9nz3cogKQvrSZ2KpWZTGzXsDJmHc0ef/YRrhZafArLDzikjaHwshTSYXGz2
         bF0ygh7sz6L/MryGrL9ibmjwl2DvQi0byh6Y1xSaOrZJj8q2iIeREPfRUUSqOXnp9cKg
         cwC4UBKqcPoBg7Z47Xm3JfMeWgqRVyB48CyBFzBqkB1/kNa/AFvsv/wMZFNSpJAWB5Gc
         EeK2UCXDg86mpaDSvkl1WJ4ahQUkM20H8qroXdaRPVb+gsFWmiAgdmRdBXxnKThDyNnx
         32MCm5Quz3VX6IgkwTcRzlxtoEjvV4WePM47r8VghaE2z5V8XJDPZi0T3xncQ55Ltbin
         zQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1OSTSUc+1gsns6jfkPG4uHPBgSAMiDJvTOmjA9DSHk=;
        b=dt/W1nS4pUSUEZkUCZFdADLhwxlGcrzH4jxLVUbmaXM26Bb4R8Jw5uCVKChanpD7wO
         mUrDBPxlClPZvsos6fWroqGq9Zy4gDJtLVRbqIGzg0PUdKA6BBbXSSNPdtRfDpAOLHkg
         Y0r096gZXeMDyY5Xahc9YHSg2Gw52ZBn3PzhMmjyhm9wbOQWsxrXkazvXYSymaD8XnhU
         SmV7WQ4dpia2IqWqc9wcEwvUjtJAiVwj3l6wAB1gx9SMWwn71D7+2ivEYmj+OnfpkfP5
         O4IBpLPjnSchQzk5sehsb03OV5qB27F6MTpD9e684YXMPUKmo3Y6Ad0TgYgQhphL1mRJ
         MY+w==
X-Gm-Message-State: AJcUukcm/0RzpKxEwXhBBrQi4ViE/4JvJIklj3EPOS4BBTeXDAuKeoGt
        ksqMwFd/6K7suHZNn79xg6/XqDdNWh6Hjv0cQaaKqfUo
X-Google-Smtp-Source: ALg8bN49OWwRKIlnoBpQEkLwne2NWX9XO+p80DK+Lzgl3+RUZWp98mk8GAQcmqSSN2eHLgF8ORscO0bGZeJxFiQzklA=
X-Received: by 2002:a1f:298e:: with SMTP id p136mr12881074vkp.40.1548865192778;
 Wed, 30 Jan 2019 08:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20190129212920.27921-1-jgebben@sweptlaser.com> <20190129233824.GA27719@roeck-us.net>
In-Reply-To: <20190129233824.GA27719@roeck-us.net>
From:   Jeremy Gebben <jgebben@sweptlaser.com>
Date:   Wed, 30 Jan 2019 09:19:42 -0700
Message-ID: <CAB48C-qXCBrnmsx8RQcpWwo-f48aC_oK+snKKaBgKw6agK3qqQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] hwmon: (lm85) add LM96000 high freqency pwm support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 4:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Jan 29, 2019 at 02:29:17PM -0700, Jeremy Gebben wrote:
> > Hi,
> >
> > This patch adds support for the PWM frequencies from 22.5 to 30 kHz
> > available on the LM96000.
> >
> > It looks like this chip has been supported for a long time, but wasn't
> > mentioned in the docs (which I have updated).
> >
> > Also, it has been using the generic 'lm85' prefix, which I have not
> > changed to avoid breaking userspace or device tree files. AFAICT,
> > lm85_detect() will only return 'lm85' for LM96000 chips, so it doesn't
> > look like you can get a bare 'lm85' prefix with any other chips.
> >
> > I stumbled on to a 10 year old thread discussing a patch which looks
> > like an early attempt to add support for this chip, which may be of
> > interest:
> > https://lm-sensors.lm-sensors.narkive.com/1SIwaMDT/patch-hwmon-lm96000-support
> >
> > Thanks for reviewing,
> >
> Where are the actual patches ?

Oops! It looks like they didn't send correctly. Hopefully they should
be showing up shortly.

Jeremy

>
> Guenter
