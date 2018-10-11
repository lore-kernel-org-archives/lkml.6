Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30639C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C042085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MosP9A7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C042085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeJKQVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:21:01 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52299 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKQVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:21:00 -0400
Received: by mail-it1-f193.google.com with SMTP id 134-v6so12332094itz.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WYTjmcBhVHuVOQTcuvvNJsnjCtNM5+sLBFRDY4fZcS8=;
        b=MosP9A7JykCdEjQFdZ6/0dNcjOibRSoSSBHKmy3QOdwJTAq3RQp8P8sdZsjWQHzsIQ
         hOHz71LTovrzsuJ9X2YRfGzQwDr5rusucU1B5oYI4DlxCAGgIePeAJP+Wqhsmk6oBYsj
         6WveNUdz5t8eo8V0k2CmFZvKODp6HnLOaub+RR+Ilj96mvbN1kEYL0L74qX+a0snmIQj
         87W/ZJYKI2lEkaqDuYA5OvdjXDO67GPzNPxBFluBf8S7DHZSeh3WDf2zde4LWqoG4CzF
         jCk+hfN6A/y0ynlkQotKgQXsE0YRpGVTI2aIF7yRb92ztPlvbXib8Iw+VteeNBiYWw8X
         5Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WYTjmcBhVHuVOQTcuvvNJsnjCtNM5+sLBFRDY4fZcS8=;
        b=mHxrkhf9z/o+4Oi4ZFEFhScGl3Su6ADbBDtnRuopj0LhCLMaA30OZaoSRm5zUDVaK0
         wYPYJ0gcZDLD5VgyVm7VyRMoXocaNmXi6Tqel3wTbje5Uaw+QPfx1tgy+bKFDUEfze+D
         Mf4SRM7nVXTLt6Onj4rd0xNJHeMDXrAes7kaFUuS9YsMRmS3QSHywPJGjC5eI34i1uO5
         bqhAbLUjSikirde8go7v/yp+TTXCF8o+S7A/vdnP8xZsaQBk/odW4sppxsUJrAK7jocd
         gOBa92FbFt1wvEzfiMM5YFh+L2nyIhpmKcPtKsiVL3Kull8Klboh3orvOhcUcx7/JsA6
         cIQQ==
X-Gm-Message-State: ABuFfogrCq0kEiwHipQfWQk8u7WBvXO3iBVJAM7ZkdTAbhNYRrQE2fkX
        nVSpFYfYb23ZWe7P9HtfyDcrorcgWnuDg5fHUeq4KQ==
X-Google-Smtp-Source: ACcGV62zWxv2ystcn6yyb/PgRcJ+6OypxmDbOBJsdZvUIWD3LoisUGVC796YgSAhE55MFUMxprnod+IZdC3xNPVNmmY=
X-Received: by 2002:a02:9716:: with SMTP id x22-v6mr509431jai.82.1539248081097;
 Thu, 11 Oct 2018 01:54:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 01:54:20
 -0700 (PDT)
In-Reply-To: <CAPhKKr8QvK3bkT6gQB9jc31Cx+gLmZwRnKuRUD_1xaidwL14Dg@mail.gmail.com>
References: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
 <CACT4Y+Y+6arxj4=72DZSj45u5kjKRksJZ7c6pBLeFDxUSBFwOg@mail.gmail.com>
 <20181008142300.3aacaabe@gandalf.local.home> <CAPhKKr8QvK3bkT6gQB9jc31Cx+gLmZwRnKuRUD_1xaidwL14Dg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Oct 2018 10:54:20 +0200
Message-ID: <CACT4Y+aiSXsyFqXueRGXeVeY6KAJ4M2Oy6RZWFnNS_d9Z9pAnw@mail.gmail.com>
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
To:     Dhaval Giani <dhaval.giani@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 5:47 PM, Dhaval Giani <dhaval.giani@gmail.com> wrote:
> On Mon, Oct 8, 2018 at 11:23 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> On Mon, 8 Oct 2018 19:02:51 +0200
>> Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> > On Wed, Sep 19, 2018 at 7:13 PM, Dhaval Giani <dhaval.giani@gmail.com> wrote:
>> > > Hi folks,
>> > >
>> > > Sasha and I are pleased to announce the Testing and Fuzzing track at
>> > > LPC [ 1 ]. We are planning to continue the discussions from last
>> > > year's microconference [2]. Many discussions from the Automated
>> > > Testing Summit [3] will also continue, and a final agenda will come up
>> > > only soon after that.
>> > >
>> > > Suggested Topics
>> > >
>> > > - Syzbot/syzkaller
>> > > - ATS
>> > > - Distro/stable testing
>> > > - kernelci
>> > > - kernelci auto bisection
>> > > - Unit testing framework
>> > >
>> > > We look forward to other interesting topics for this microconference
>> > > as a reply to this email.
>> >
>> > Hi Dhaval and Sasha,
>> >
>> > My syzbot talk wasn't accepted to main track, so I would like to do
>> > more or less full-fledged talk on the microconf. Is it possible?
>>
>> Hi Dmitry,
>>
>> Note, microconfs are not for full-fledged talks. They are to be
>> discussion focused. You can have a 5-10 minute presentation that leads
>> up to discussion of future work, but we like to refrain from any talks
>> about what was done if there's nothing to go forward with.
>
> Dmitiry,
>
> Can you clarify the scope of what you want to discuss during the
> microconference? Further to what Steven said, we don't want
> presentations (So 3, maybe 4 slides). We want discussions about future
> work.
>
> Thanks!
> Dhaval


Hi Steven, Dhaval,

Acknowledged.

Then smaller topic that would benefit from discussion are:

the main one being:

1. syzbot: developer process; unfixed bugs; bug triage; what's
working? what's not? why? how can we make more parts work? collecting
feedback

2. how to increase test coverage/find more bugs, in particular:
 - adding manual spot KASAN/KMSAN checks into kernel codebase
 - stubbing hardware/external inputs to kernel for testing
 - description of kernel interfaces (again)

3. dealing with kernel console output mess
 - intermixed/split lines
 - understand when/how kernel crashed
 - and where is that message
 - crash identity
