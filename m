Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E932AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993DF208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eHjiXG6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993DF208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeHTO7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:59:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38594 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeHTO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:58:59 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so25228286oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1lFxuQ+rJ8f3vGxa5mrmC0/WSn5E1c4FuXgT2koIl+E=;
        b=eHjiXG6w1TIKMrWpzY/QBf79EBpVUmMzgqTI2knz/mwDbCbTcW48Ps9BKaC+hNu3dJ
         /Gbb2BR1lcloA78G8UPSEQ21z06QtA+lySMtgk8vCv+0z6+EDbnRIRxhnn2E2xvCxhgu
         dm5ixZx0VsX/1ZL3y65hH1X8FyoUmUZdJQC+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1lFxuQ+rJ8f3vGxa5mrmC0/WSn5E1c4FuXgT2koIl+E=;
        b=lT5hbnBUqJrgq4FRN4awaVsscZIp8WKvHdXQQhmaeApKcpWWmRRhYL9tGvvgJsWr5w
         +5TP7BNT5IbSWC6ts65fpr8CE/m83b7dIJaARfC0l85Yu/u39SVeSRtNIR49cC35bm4j
         HnZYvdxrgJimX38LmNc+d7XmCl0Y4MQZq8wiRRm2xDWqTXXs3ojqQMXMg+c4JC+CaOVb
         ZhxqktrX64HaNPUvDdDo+lCjwELW6VMwbhch5pjjG2MOBHLJ3wcOKn6islfVd/QA2Kqz
         wc/LLg+AXHcwr2S0iHCzKw+Q7PBui3kHGBA8inkn7CCG0JyeYNZ9IPMZ+o/CIQfSCzqv
         xDWQ==
X-Gm-Message-State: AOUpUlElOzDuCOXzaH1p3gNVjVBgwqBgrl9KUPw0Kxc1cXAZ37Mb0LWa
        EmS8Pi/dMZFTMLmWYmNk9t7onKpU3CJBB63gqicPSA==
X-Google-Smtp-Source: AA+uWPzeTJ/wKiTj9PXEzjCTXuMBfsFhObEQw7wgqi3rHmDQGXBJKvNGI/M1OQ7UlX0vmbHkKCxGl/3PCHc/hVdrloM=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr14510248oib.116.1534765420989;
 Mon, 20 Aug 2018 04:43:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:6a83:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 04:43:40
 -0700 (PDT)
In-Reply-To: <21451a6ba97eada5d4a8a49b2726edde58266817.camel@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
 <20180817044902.31420-2-benh@kernel.crashing.org> <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
 <06c1233b71dea08b1fc32334acefc48c32c46557.camel@kernel.crashing.org>
 <20180819022440.GG128050@bhelgaas-glaptop.roam.corp.google.com>
 <4d777ed8c17b479e59b16cc0b4e9a3f6537f9884.camel@kernel.crashing.org>
 <CAM5rFu_dsfAiQtVnM58631tFUxYyzXrA5tgz8_v0=or3Lv8YbA@mail.gmail.com> <21451a6ba97eada5d4a8a49b2726edde58266817.camel@kernel.crashing.org>
From:   Hari Vyas <hari.vyas@broadcom.com>
Date:   Mon, 20 Aug 2018 17:13:40 +0530
Message-ID: <CAM5rFu-e7N0AseqjmiAOd1uEMjL8Kvupw7YK08ogYQh_6C5F6A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] Revert "PCI: Fix is_added/is_busmaster race condition"
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 4:39 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2018-08-20 at 11:55 +0530, Hari Vyas wrote:
>> On Mon, Aug 20, 2018 at 7:40 AM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > On Sat, 2018-08-18 at 21:24 -0500, Bjorn Helgaas wrote:
>> > > On Sat, Aug 18, 2018 at 01:24:51PM +1000, Benjamin Herrenschmidt wrote:
>> > > > On Fri, 2018-08-17 at 10:44 -0500, Bjorn Helgaas wrote:
>> > > > > On Fri, Aug 17, 2018 at 02:48:57PM +1000, Benjamin Herrenschmidt wrote:
>> > > > > > This reverts commit 44bda4b7d26e9fffed6d7152d98a2e9edaeb2a76.
>> > > > >
>> > > > > Just to be clear, if I understand correctly, this is a pure revert of
>> > > > > 44bda4b7d26e and as such it reintroduces the problem solved by that
>> > > > > commit.
>> > > > >
>> > > > > If your solution turns out to be better, that's great, but it would be
>> > > > > nice to avoid the bisection hole of reintroducing the problem, then
>> > > > > fixing it again later.
>> > > >
>> > > > There is no way to do that other than merging the revert and the fix
>> > > > into one. That said, the race is sufficiently hard to hit that I
>> > > > wouldn't worry too much about it.
>> > >
>> > > OK, then at least mention that in the changelog.
>> >
>> > Sure will do. This is just RFC at this stage :-)
>> >
>> > As for the race with enable, what's your take on my approach ? The
>> > basic premise is that we need some kind of mutex to make the updates to
>> > enable_cnt and the actual config space changes atomic. While at it we
>> > can fold pci_set_master vs. is_busmaster as well as those are racy too.
>> >
>> > I chose to create a new mutex which we should be able to address other
>> > similar races if we find them. The other solutions that I dismissed
>> > were:
>> >
>> >  - Using the device_lock. A explained previously, this is tricky, I
>> > prefer not using this for anything other than locking against
>> > concurrent add/remove. The main issue is that drivers will be sometimes
>> > called in context where that's already held, so we can't take it inside
>> > pci_enable_device() and I'd rather not add new constraints such as
>> > "pci_enable_device() must be only called from probe() unless you also
>> > take the device lock". It would be tricky to audit everybody...
>> >
>> >  - Using a global mutex. We could move the bridge lock from AER to core
>> > code for example, and use that. But it doesn't buy us much, and
>> > slightly redecuces parallelism. It also makes it a little bit more
>> > messy to walk up the bridge chain, we'd have to do a
>> > pci_enable_device_unlocked or something, messy.
>> >
>> > So are you ok with the approach ? Do you prefer one of the above
>> > regardless ? Something else ?
>> >
>> > Cheers,
>> > Ben.
>> >
>> >
>>
>> Some concern was raised about race situation so just to be more clear
>> about race condition.
>
> This is not what the above discussion is about.
>
> The race with is is_added is due to the fact that the bit is set too
> later as discussed previously and in my changelog.
>
> The race I'm talking about here is the race related to multiple
> subtrees trying to simultaneously enable a parent bridge.
>
>> Situation is described in Bug 200283 - PCI: Data corruption happening
>> due to a race condition.
>> Issue was discovered by our broadcom QA team.
>> Initially commit was to use one separate lock only for avoiding race
>> condition but after review, approach was slightly changed to move
>> is_added  to pci_dev private flags as it was completely
>> internal/private variable of pci core driver.
>> Powerpc legacy arch code was using is_added flag directly which looks
>> bit strange so  ../../ type of inclusion of pci.h was required. I know
>> it looks ugly but it is being used in some legacy code still.
>> Anyway, as stated earlier too, problem should be just solved in better way.
>
> The is_added race can be fixed with a 3 lines patch moving is_added up
> to before device_attach() I believe. I yet have to find a scenario
> where doing so would break something but it's possible that I missed a
> case.
>
> At this stage, I'm more intested however in us agreeing how to fix the
> other race, the one with enabling. As I wrote above, I proposed an
> approach based on a mutex in pci_dev, and this is what I would like
> discussed.
>
> This race is currently causing our large systems to randomly error out
> at boot time when probing some PCIe devices. I'm putting a band-aid in
> the powerpc code for now to pre-enable bridges at boot, but I'd rather
> have the race fixed in the generic code.
>
> Ben.
>
>
I was initially using spin lock in
"PATCH v1] PCI: Data corruption happening due to race condition" and didn't
face  issue at-least in our environment for our race condition.
Anyway, we can leave this minor is_added issue time-being and concentrate on
current pci bridge concern. Could you re-share your latest patch in
your environment
and your first doubt where race situation could happen. May be forum
can suggest
some-thing good.


Regard,
hari.
