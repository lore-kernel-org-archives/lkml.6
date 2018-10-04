Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E6EC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0021021473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat-com.20150623.gappssmtp.com header.i=@infinidat-com.20150623.gappssmtp.com header.b="Z9Dr9OQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0021021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infinidat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJDNuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:50:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34414 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeJDNug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:50:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12-v6so8171918otl.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILgMXlBvUEo+sZHLx50+QCGySzxBjzwtiFLrday+WkA=;
        b=Z9Dr9OQZk5sasDJozWyp9Acgu+ATjRQo4NOdWhIALWMgdSO5NF5jFsnvIm7muKaog+
         zmwsTgvfMqbrfW7+Lme5fT+MR938Q+TVBvvmqJE1pf2Kw334DHVndww7s995ywIrVsTx
         GYLeDngGS3R6vZhq+JnySDgyTK7BqrI4IgRzamVyj2+qVW2Pw/g1CrcAgEQ+rstKnola
         NKxQhH4ZQLlkEiZkow/wRIWwoWafQWe7WRDT7A8g0ZbQ5jdu03h/ZbNRTf/fPSJQcIad
         fb3lh6sXgMLIJzcHH+A3ASNVFpgK6f1adBMvsxZ3NNNLMsZP5XbKN9e7bzyjHBSAegOY
         hVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILgMXlBvUEo+sZHLx50+QCGySzxBjzwtiFLrday+WkA=;
        b=TMSgWjbHQIEPzo+rFG81vFsnQzhY38U599AhXrZmeYPxbDOMBFN2H+94/Yurxd3R52
         0T6fcJ+RpArk3TrqzRA3LR/1KgP4rSXhQVdMcWzjHSwF64Io/KpY8rGtNjDXbCRpljro
         pqutpxvurjxR+HyLyEpafhdPWD+4vH42FKQoDvODBxyqjmT+rO0YoQVjdxrMmi1wCrdz
         C52D33K3KO01j4ORVxElVLmKgD/tfyeHhb/+YnR9m7CNp1Z5c5XwFuN87x7nRxPYVj1s
         Dj4Yp14pr0QSCLZrDIoJxHcG03i4m8pwKQxe3kpDk+QVZfh1rBABo/rkzvISExK+Vjwf
         avcg==
X-Gm-Message-State: ABuFfoguXmNtKqxJb96D9yQ7nhCj+yxztMSNxliY9x8fEplmIbDIvUVE
        4y/i+EIaSgpt+2bVWVknXqIUpnWfaa5icDoFyYMP
X-Google-Smtp-Source: ACcGV61dWvoVtXCL1PDMM2ZJryEIYAX9U/3UXvB5hu1zSN1mOae4LgKzEfhl0WGAC0EqC7L1kV8qxYeWgEUeio5z/m4=
X-Received: by 2002:a9d:3c9:: with SMTP id f67-v6mr2986177otf.208.1538636329410;
 Wed, 03 Oct 2018 23:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuWhkaGjX8Q_xghkFVTqzZkDrUv-sdH=VbS7hvnqFWrT+3eOQ@mail.gmail.com>
 <CAFLxGvxX8QW4wUJKommXVMpGBj7G_H3=SOwQGjGuyPZZrhCzKw@mail.gmail.com>
 <CA+55aFyLC8PhjZ+iV7MucSZ1aGKMT=S9=EkEAQ6T1=ZRqD-xLA@mail.gmail.com> <CAOuWhkbNuesaVYar6ML-qFw7RAfkPsaOYUXT4Ypfiu5=Nt1kWw@mail.gmail.com>
In-Reply-To: <CAOuWhkbNuesaVYar6ML-qFw7RAfkPsaOYUXT4Ypfiu5=Nt1kWw@mail.gmail.com>
From:   Dror Levin <drorl@infinidat.com>
Date:   Thu, 4 Oct 2018 09:58:37 +0300
Message-ID: <CAOuWhkYRtTqrnp1uyDWFqXFcTLhPbcqv8XzdV_jurJHstGQmuA@mail.gmail.com>
Subject: Re: Recent removal of bsg read/write support
To:     torvalds@linux-foundation.org
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, hch@infradead.org, axboe@kernel.dk,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing Greg.

On Mon, Sep 3, 2018 at 11:34 AM Dror Levin <drorl@infinidat.com> wrote:
>
> On Sun, Sep 2, 2018 at 8:55 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, Sep 2, 2018 at 4:44 AM Richard Weinberger
> > <richard.weinberger@gmail.com> wrote:
> > >
> > > CC'ing relevant people. Otherwise your mail might get lost.
> >
> > Indeed.
>
> Sorry for that.
>
> > > On Sun, Sep 2, 2018 at 1:37 PM Dror Levin <drorl@infinidat.com> wrote:
> > > >
> > > > We have an internal tool that uses the bsg read/write interface to
> > > > issue SCSI commands as part of a test suite for a storage device.
> > > >
> > > > After recently reading on LWN that this interface is to be removed we
> > > > tried porting our code to use sg instead. However, that raises new
> > > > issues - mainly getting ENOMEM over iSCSI for unknown reasons.
> >
> > Is there any chance that you can make more data available?
>
> Sure, I can try.
>
> We use writev() to send up to SG_MAX_QUEUE tasks at a time. Occasionally not
> all tasks are written at which point we wait for tasks to return before
> sending more, but then writev() fails with ENOMEM and we see this in the syslog:
>
> Sep  1 20:58:14 gdc-qa-io-017 kernel: sd 441:0:0:5: [sg73]
> sg_common_write: start_req err=-12
>
> Failing tasks are reads of 128KiB.
>
> > I'd rather fix the sg interface (which while also broken garbage, we
> > can't get rid of) than re-surrect the bsg interface.

Discussion seems to have died down but release of 4.19 is drawing near.

Is there still any chance removal of bsg can be reconsidered? Maybe
postponed to the
next version to allow more time to adjust?

I'm especially concerned about the possibility of this being
backported to stable kernels
which might leave us very little time to fix our code.

Thanks,
Dror
