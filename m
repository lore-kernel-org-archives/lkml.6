Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9A3C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581B120843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A84gWf7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581B120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeIDNXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:23:21 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:39378 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeIDNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:23:21 -0400
Received: by mail-oi0-f52.google.com with SMTP id c190-v6so5305481oig.6;
        Tue, 04 Sep 2018 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XG3j2LpdsGYoK2nVucrMeIiKgg2xSHkL1DC1iX0SA4c=;
        b=A84gWf7AKd5Weu0SC3UEnGUdW902EuuMIiEUAFVXQMrk7SiCtB0xOoWjI1D0cnJiAM
         6GI2wbhUqnlBqo6vBWkpmmjy3f88Wuy7uqxmJcUounfysyu2McDfCjckTevcc/10s1G3
         TE0f7WXpr61LDv6Vsao56DUwtWQzP1lh+Ae+lheb52d2hbNKDuyqHLb6m+EfzipEjIDs
         PP9N/oL+mTsCKAAXSD/J1PsjghGO5Lvn5zQ4S22YS5EHlG56b+79fBgJNjq81cYhuuuI
         2/3bnoHNlBP9dbZrNcdhB+9ozT7Ec7lyiGIgqxsJhr35/Q5ujo5NzvMdiG6T3DbqLzOV
         XqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XG3j2LpdsGYoK2nVucrMeIiKgg2xSHkL1DC1iX0SA4c=;
        b=G10vWkJUu7KIJua9kPVD2d44mfvKS1H+5Ca819zmCNNE2HqLjGFxNXDXtBtmjr7lWs
         wpJbYNqeBsI3zsL0q8lKk2BDZCViZiWnOHLOjcCsShalZDzRlbuTohzQIiSn5VOVNki8
         +iVD8bUV4fMHKJneUAaOpXXaHm4bjbWxtXXRc+NrGioADJY58BwwaqobR8cWmuHVMw0i
         0XQszYwVJotaBmaRp74VZQjVUvZAMv/tXZm0F1jhbbiSdu8fCVhgyMH/n1qEVckBcdSc
         L5VOCi9HtAOUf0dLqoU13LcfuAmmLP6xmphVPrx7yhxtCgwDs2sUqVDfXaEIRHFNd2XD
         gCQg==
X-Gm-Message-State: APzg51D4YX5BLikcNhGho8GXt5FGXY6zHl4Ek2EQ+4c/sxYI2qjLjujZ
        EAxoCaqHa3eI+CXtErpvJ7Jz5hrh9fpq3VkX0vFB5sFX
X-Google-Smtp-Source: ANB0VdbspIYf6SoM0QdMocjO3w/1h2iPuQkxblKC4GVRDL7uiiZLix8wrnU6sOoi3qsO+OZNxZkysgQBjzStctppEs0=
X-Received: by 2002:aca:5489:: with SMTP id i131-v6mr24736964oib.340.1536051550371;
 Tue, 04 Sep 2018 01:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <20180904075347.GH11854@BitWizard.nl>
In-Reply-To: <20180904075347.GH11854@BitWizard.nl>
From:   =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date:   Tue, 4 Sep 2018 16:58:59 +0800
Message-ID: <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
Subject: Re: POSIX violation by writeback error
To:     R.E.Wolff@bitwizard.nl
Cc:     jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 3:53 PM Rogier Wolff <R.E.Wolff@bitwizard.nl> wrote:

...
> >
> > Jlayton's patch is simple but wonderful idea towards correct error
> > reporting. It seems one crucial thing is still here to be fixed. Does
> > anyone have some idea?
> >
> > The crucial thing may be that a read() after a successful
> > open()-write()-close() may return old data.
> >
> > That may happen where an async writeback error occurs after close()
> > and the inode/mapping get evicted before read().
>
> Suppose I have 1Gb of RAM. Suppose I open a file, write 0.5Gb to it
> and then close it. Then I repeat this 9 times.
>
> Now, when writing those files to storage fails, there is 5Gb of data
> to remember and only 1Gb of RAM.
>
> I can choose any part of that 5Gb and try to read it.
>
> Please make a suggestion about where we should store that data?

That is certainly not possible to be done. But at least, shall we report
error on read()? Silently returning wrong data may cause further damage,
such as removing wrong files since it was marked as garbage in the old file.

As I can see, that is all about error reporting.

As for suggestion, maybe the error flag of inode/mapping, or the entire inode
should not be evicted if there was an error. That hopefully won't take much
memory. On extreme conditions, where too much error inode requires staying
in memory, maybe we should panic rather then spread the error.

>
> In the easy case, where the data easily fits in RAM, you COULD write a
> solution. But when the hardware fails, the SYSTEM will not be able to
> follow the posix rules.

Nope, we are able to follow the rules. The above is one way that follows the
POSIX rules.

>
>         Roger.
>
> --
> ** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
> **    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
> *-- BitWizard writes Linux device drivers for any device you may have! --*
> The plan was simple, like my brother-in-law Phil. But unlike
> Phil, this plan just might work.
