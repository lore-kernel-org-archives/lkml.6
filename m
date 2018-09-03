Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9255AC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3548720856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat-com.20150623.gappssmtp.com header.i=@infinidat-com.20150623.gappssmtp.com header.b="UdihlNBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3548720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infinidat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeICMxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:53:54 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44638 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeICMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:53:53 -0400
Received: by mail-oi0-f68.google.com with SMTP id l82-v6so32228713oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOnnW28q9L9jgWagZfM00l8k+/0G0cItbeqZVIVUPsE=;
        b=UdihlNBmiqemF2Z5N+XUMV/DYPjwonaPEyJrGhj9L52LrTNUpxS03ET9nU3JL18GoJ
         ZE6F/8cCbcqNOUw2tWq4zpHv8nyL1EfqroUTJW53382mXiExYEJ2tiChbnX+F3R4GSJ9
         FNskjwVxY/OSH5q2NIyxVP3StVRZljafxsfnPwfB7tKEWN1p7o+uS9WtGexdJxQGXz+N
         /H4F2akv2nbM/bXKha1xMwlrwzdIllC2S6ALHuluvcPxL/y8uf+MrawTuaB61bbQz0Il
         EbFZ+JxFBmOrwUY5vGAD1TH3v1+s9J4+dKJ0/iERd5DI0vrisAdyTC2zLMI/Wm7/WByZ
         ENSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOnnW28q9L9jgWagZfM00l8k+/0G0cItbeqZVIVUPsE=;
        b=eOsKzx+sezA/GEPdz3S+2pmbK5PGY0g8qfZF70j5DGC9+X24iAhvpaVyMun11HR5Af
         7t61edVLJ3zsd5UB6A9jHyY/3nMb4GZpbYu4eJ6rhHR8wCOKeIPd9V6qfG0AJwY4X/Oc
         mbNCBp8lQGBO3LLbsy9LEk7zu7UxIvB/ndthq8B32bIaKb88jIBntGCe+wMbFx8ROiOH
         YvXoq3/nUf2w3yygjx1oOejeef1b6oRgPNFZOAKHkT7ebonAFhYFK4MJxfiz1tt63yoO
         DQeYNa9DOL1DrrkVVXKp+BarDMTmCkRo+UDz4AEgWfUcoTfhgQE3vEdVzXnmuVLpxcHA
         fFmg==
X-Gm-Message-State: APzg51AsucITExDX8Hc+AYZcrjBDZmoh4/mZkfrz8Z/266DfbCxO1sSn
        rqbqzLlI2gMEY0EE85lVdWwCG9GqhrdONenWkl7y
X-Google-Smtp-Source: ANB0VdZJrsgD2K2lZwmmIERgR/ZtNyzvZF9L3xO4tacqylRineJTdCiD9afmtfytHbEO2icb+knWDVeKkWh+o1hAVGk=
X-Received: by 2002:aca:3407:: with SMTP id b7-v6mr17596889oia.345.1535963687773;
 Mon, 03 Sep 2018 01:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuWhkaGjX8Q_xghkFVTqzZkDrUv-sdH=VbS7hvnqFWrT+3eOQ@mail.gmail.com>
 <CAFLxGvxX8QW4wUJKommXVMpGBj7G_H3=SOwQGjGuyPZZrhCzKw@mail.gmail.com> <CA+55aFyLC8PhjZ+iV7MucSZ1aGKMT=S9=EkEAQ6T1=ZRqD-xLA@mail.gmail.com>
In-Reply-To: <CA+55aFyLC8PhjZ+iV7MucSZ1aGKMT=S9=EkEAQ6T1=ZRqD-xLA@mail.gmail.com>
From:   Dror Levin <drorl@infinidat.com>
Date:   Mon, 3 Sep 2018 11:34:48 +0300
Message-ID: <CAOuWhkbNuesaVYar6ML-qFw7RAfkPsaOYUXT4Ypfiu5=Nt1kWw@mail.gmail.com>
Subject: Re: Recent removal of bsg read/write support
To:     torvalds@linux-foundation.org
Cc:     richard.weinberger@gmail.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        hch@infradead.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 8:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Sep 2, 2018 at 4:44 AM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
> >
> > CC'ing relevant people. Otherwise your mail might get lost.
>
> Indeed.

Sorry for that.

> > On Sun, Sep 2, 2018 at 1:37 PM Dror Levin <drorl@infinidat.com> wrote:
> > >
> > > We have an internal tool that uses the bsg read/write interface to
> > > issue SCSI commands as part of a test suite for a storage device.
> > >
> > > After recently reading on LWN that this interface is to be removed we
> > > tried porting our code to use sg instead. However, that raises new
> > > issues - mainly getting ENOMEM over iSCSI for unknown reasons.
>
> Is there any chance that you can make more data available?

Sure, I can try.

We use writev() to send up to SG_MAX_QUEUE tasks at a time. Occasionally not
all tasks are written at which point we wait for tasks to return before
sending more, but then writev() fails with ENOMEM and we see this in the syslog:

Sep  1 20:58:14 gdc-qa-io-017 kernel: sd 441:0:0:5: [sg73]
sg_common_write: start_req err=-12

Failing tasks are reads of 128KiB.

> I'd rather fix the sg interface (which while also broken garbage, we
> can't get rid of) than re-surrect the bsg interface.
>
> That said, the removed bsg code looks a hell of a lot prettier than
> the nasty sg interface code does, although it also lacks ansolutely
> _any_ kind of security checking.

For us the bsg interface also has several advantages over sg:
1. The device name is its HCTL which is nicer than an arbitrary integer.
2. write() supports writing more than one sg_io_v4 struct so we don't have
   to resort to writev().
3. Queue size is the device's queue depth and not SG_MAX_QUEUE which is 16.

> > > Because of this we would like to continue using the bsg interface,
> > > even if some changes are required to meet security concerns.
>
> I wonder if we could at least try to unify the bsg/sg code - possibly
> by making sg use the prettier bsg code (but definitely have to add all
> the security measures).
>
> And dammit, the SCSI people need to get their heads out of their
> arses. This whole "stream random commands over read/write" needs to go
> the f*ck away.
>
> Could we perhaps extend the SG_IO interace to have an async mode?
> Instead of "read/write", have "SG_IOSUBMIT" and "SG_IORECEIVE" and
> have the SG_IO ioctl just be a shorthand of "both".

Just my two cents - having an interface other than read/write won't allow
users to treat this fd as a regular file with epoll() and read(). This is
a major bonus for this interface - an sg/bsg device can be used just like
a socket or pipe in any reactor (we use boost asio for example).

Thanks,
Dror
