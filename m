Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15FDC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 08:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A79208B4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 08:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ8eC7o1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A79208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeGHIZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 04:25:17 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32894 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753774AbeGHIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 04:25:15 -0400
Received: by mail-oi0-f65.google.com with SMTP id c6-v6so30758139oiy.0;
        Sun, 08 Jul 2018 01:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tnfHLa00LuvmHD08Ta5f68QuKAbpzHHTTsGUXCXhtCQ=;
        b=RJ8eC7o1nv3EEu0FbZJoL+pazBo24ZqQF995gMwUf7bt5Zu8KMVJBP+x+rmTFTHA5s
         p3Ec8U6LTiZ6kTGPMlGRVMawEGmSfO1Fv/Wu6Ynp133P1ZtvWIcM2joed5MB14YjjCdY
         4MU6Pa7H4EVA8aDJ+/1FLP0TFwiRveQjmLd0ZsHgrFw9qEjywpJXjo7nZgf6H8qwkKWg
         GfMpFHqCrBzOfQe6eBURy3Z9RfgyobpWGbaxlgi8ZpruQEx28KCKpwv5ThHVwLMmV1GO
         TQkwqrAfJGz3QMfR93fPw+mIU4pRyGuPIglE4GGKRO7XqGg4QEy1ss6BdTkhFJ0wiaOD
         muXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tnfHLa00LuvmHD08Ta5f68QuKAbpzHHTTsGUXCXhtCQ=;
        b=GB3kPzMwUxTmUnaL2hACmSKO8GGuXVIyxhYSCHw/9wNa+woQjZ7r32Bkmr+6VHfogh
         EfRecKR1s8r7Q/MtxCZNNqEXERp5W2pP3L32jZJdHdSuD0+/ZgNGHAQj9F/lDALNY3mo
         vGT39gaHcijKY679O3aVo/I2HhxTKEU8Ru2X4bJGBxZCDbGS7cbqoKxa1DL+x156SLpd
         PQ6Fnw3dLOyT0Q5Fwg04OfIVian9qHqRqFO/LIs341msyxQK82dkEHZeLmvjkxJV9P8O
         8In+1xPqdATsWVknl05K0mAqEvuY5H4zwF9Ed1sSh/DTcMt+fWKbfA2DXNXFf/gafshQ
         adUQ==
X-Gm-Message-State: APt69E0brvqYZuqtV/orlLDxU1qQGeOhgsfwsU0VW1wT4eGMYilpOykp
        36S3VZkU4YDAjAX/67R39GL+hA4EpN/IDV1uNRua4w==
X-Google-Smtp-Source: AAOMgpesP2bQzTaGlpbajMv7sA7Gavks5YDjMvH2h+sDfUv01wC5n92/8qiNzZG+0pmievYBVqepLeLhwWuIoftxER8=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr19556184oie.233.1531038314819;
 Sun, 08 Jul 2018 01:25:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 01:25:14 -0700 (PDT)
In-Reply-To: <CAFgQCTsCjkDWJsNog_sTnS-ZaZ87fMFpKq1ekVSUG4MDs6K_jw@mail.gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan> <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan> <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
 <CAJZ5v0jo5-z0ZYDzdNPpn54+oAxpdG_=EvVDdz-HKxp7psu-EA@mail.gmail.com>
 <20180706083603.GA9063@wunner.de> <CAJZ5v0j6+m8NGMneG45tF9L1s6ahtFo91wPCO=3YOTEyAOL+VQ@mail.gmail.com>
 <CAFgQCTugu5XO06_xXb4ihkdfGJxtFX0813g2J-Jk2JeYtPP1vA@mail.gmail.com> <CAFgQCTsCjkDWJsNog_sTnS-ZaZ87fMFpKq1ekVSUG4MDs6K_jw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 8 Jul 2018 10:25:14 +0200
X-Google-Sender-Auth: lFj0vqZ_5-IU8whSjnFj-zYH94U
Message-ID: <CAJZ5v0gxJ9LJ328WbgPrZCV-0SEiO31trsTSYYS8L95P4kfkbA@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 6:24 AM, Pingfan Liu <kernelfans@gmail.com> wrote:
> On Fri, Jul 6, 2018 at 9:55 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>>
>> On Fri, Jul 6, 2018 at 4:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> >
>> > On Fri, Jul 6, 2018 at 10:36 AM, Lukas Wunner <lukas@wunner.de> wrote:
>> > > [cc += Kishon Vijay Abraham]
>> > >
>> > > On Thu, Jul 05, 2018 at 11:18:28AM +0200, Rafael J. Wysocki wrote:
>> > >> OK, so calling devices_kset_move_last() from really_probe() clearly is
>> > >> a mistake.
>> > >>
>> > >> I'm not really sure what the intention of it was as the changelog of
>> > >> commit 52cdbdd49853d doesn't really explain that (why would it be
>> > >> insufficient without that change?)
>> > >
>> > > It seems 52cdbdd49853d fixed an issue with boards which have an MMC
>> > > whose reset pin needs to be driven high on shutdown, lest the MMC
>> > > won't be found on the next boot.
>> > >
>> > > The boards' devicetrees use a kludge wherein the reset pin is modelled
>> > > as a regulator.  The regulator is enabled when the MMC probes and
>> > > disabled on driver unbind and shutdown.  As a result, the pin is driven
>> > > low on shutdown and the MMC is not found on the next boot.
>> > >
>> > > To fix this, another kludge was invented wherein the GPIO expander
>> > > driving the reset pin unconditionally drives all its pins high on
>> > > shutdown, see pcf857x_shutdown() in drivers/gpio/gpio-pcf857x.c
>> > > (commit adc284755055, "gpio: pcf857x: restore the initial line state
>> > > of all pcf lines").
>> > >
>> > > For this kludge to work, the GPIO expander's ->shutdown hook needs to
>> > > be executed after the MMC expander's ->shutdown hook.
>> > >
>> > > Commit 52cdbdd49853d achieved that by reordering devices_kset according
>> > > to the probe order.  Apparently the MMC probes after the GPIO expander,
>> > > possibly because it returns -EPROBE_DEFER if the vmmc regulator isn't
>> > > available yet, see mmc_regulator_get_supply().
>> > >
>> > > Note, I'm just piecing the information together from git history,
>> > > I'm not responsible for these kludges.  (I'm innocent!)
>> >
>> > Sure enough. :-)
>> >
>> > In any case, calling devices_kset_move_last() in really_probe() is
>> > plain broken and if its only purpose was to address a single, arguably
>> > kludgy, use case, let's just get rid of it in the first place IMO.
>> >
>> Yes, if it is only used for a single use case.
>>
> Think it again, I saw other potential issue with the current code.
> device_link_add->device_reorder_to_tail() can break the
> "supplier<-consumer" order. During moving children after parent's
> supplier, it ignores the order of child's consumer.

What do you mean?

> Beside this, essentially both devices_kset_move_after/_before() and
> device_pm_move_after/_before() expose  the shutdown order to the
> indirect caller,  and we can not expect that the caller can not handle
> it correctly. It should be a job of drivers core.

Arguably so, but that's how those functions were designed and the
callers should be aware of the limitation.

If they aren't, there is a bug in the caller.

> It is hard to extract high dimension info and pack them into one dimension
> linked-list.

Well, yes and no.

We know it for a fact that there is a linear ordering that will work.
It is inefficient to figure it out every time during system suspend
and resume, for one and that's why we have dpm_list.

Now, if we have it for suspend and resume, it can also be used for shutdown.

> And in theory, it is warranted that the shutdown seq is
> correct by using device tree info. More important, it is cheap with
> the data structure in hand. So I think it is time to resolve the issue
> once for all.

Not the way you want to do that, though.

Thanks,
Rafael
