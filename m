Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E81C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BBF23DA8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dOytIoTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BBF23DA8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932454AbeGCC1M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:27:12 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34642 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932381AbeGCC1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:27:11 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so356043ioj.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 19:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fd/+SbgwdDI5lLS41bnAMFsEER6wfJWJs+5khlUrtts=;
        b=dOytIoTb76dDLakJB9RsJKWANQW/ry3gAtWMgwyjr4Oq2ubcvGZB7M76e6qmMjZXxM
         4asfFIH7VadazONYIur5a+gwkhD7e5tLfzWBf4SLrC6Sk/yLuU1oByfJvDcQ/OOpmYpo
         K2EbaAy9dpfhywa3ZyaWLeef94uURiZx5SK3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fd/+SbgwdDI5lLS41bnAMFsEER6wfJWJs+5khlUrtts=;
        b=SSw/sspGvK9vrDr79qmYPG3JamUz1N6o1mFxrLDPjqxYay6PLI7WFP/YSMsOxEESnf
         eMEE2ya3HqWx19JLo/1a/EtqnBYPlts2I71vVlxl+VWRpTMx6v3mc6n78S6VMDHl27kE
         ++1Fn6FOezsG00gptkQ4XoA5IlPIjynEcEdEuak7cz5EqlAFnS9tjVdIu2MxKGUb1bF4
         wjao/60CXb/Tfj89Azx2h5F3al0QAA7yTTjxqXARwIWL8GqbzAmcNaaORXfO/8T9826U
         MPN4bdw1MGSfWS8iurkvTAMJaD8rswomJAxo1yVv1WYbvkQHy6/G5sHXFZ7RgYy7KcKe
         bxEw==
X-Gm-Message-State: APt69E2JVAC/Za3iY2Yrk5fp+0PVXkYmH9QFwYNOQJPmlwPzSJLm5tA6
        CqMxAgYgCoONfKQXCkOgXxLYTzx4CAX87hdm8055Sg==
X-Google-Smtp-Source: AAOMgpdW4tYdk4drxeYDeTmXep7pb4JqI8eEt73uEPXm59NLazUeJ7HT6tQC3ZV6jGi1oRJwqN0d8olNQxDpEd3xzQs=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr24339710iov.203.1530584830885;
 Mon, 02 Jul 2018 19:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
 <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
 <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
 <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
 <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org>
 <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
 <675c0752ea41c9dc52c2a4b69f09fb9746207de3.camel@kernel.crashing.org>
 <CA+55aFxqUyACDPBL4trTfGyJudg8P7YGazVGUW7-UaNFJiwZRQ@mail.gmail.com>
 <36fb9c9f873629abb7bf3758033cce00e463f768.camel@kernel.crashing.org>
 <CA+55aFzUhe7j+6XL_BB+gvSnCvMCOePZhanTBk5tq=zqvFFWSw@mail.gmail.com>
 <d56f1c255f7caa913ad77a174e1e3bde08043ac0.camel@kernel.crashing.org>
 <0dc3c0632b1821bd07abdf0224ccd9f32a4f250d.camel@kernel.crashing.org>
 <CA+55aFyzYXSTTuVoGfVeC574-7i0zp3q39RTsiPn3GoRceuwAQ@mail.gmail.com>
 <213dd8fa77629e04277e68552068581da881e7e4.camel@kernel.crashing.org> <CA+55aFy927VYjFDwe9Zy_M+XFNxSFh2HLFcQ25pm8AMNXBUoQA@mail.gmail.com>
In-Reply-To: <CA+55aFy927VYjFDwe9Zy_M+XFNxSFh2HLFcQ25pm8AMNXBUoQA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 19:26:59 -0700
Message-ID: <CA+55aFx7wgjx+d0Vdtpgzc46HM-4vN2r-Hyf2ZC4gQU-nxopMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 7:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's whitespace-damaged on purpose. It's probably broken shit. DO NOT
> USE UNDER ANY CIRCUMSTANCES.  Think of it more as a "something like
> this might work, but probably doesn't". Maybe it gives you an idea,
> although that idea might be "Linus has finally lost it".

Even if it were to work, it should probably just be done inside kernfs
and exposed as some kind of "kernfs_remove_if_empty()" function.

We happen to know that we hold the lock that creates all the entries
in the glue directory (and we don't allow users to move or create
stuff, afaik, even if we alloc chmod etc), so there should be no
races, but a generic kernfs helper function would probably have to get
proper locks and check it the right way.

                Linus
