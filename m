Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F2FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD79D2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5m2ECXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD79D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbeGIGsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:48:47 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41901 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeGIGsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:48:45 -0400
Received: by mail-io0-f193.google.com with SMTP id q9-v6so16092521ioj.8;
        Sun, 08 Jul 2018 23:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZdHQyYpmW0ZeKX30eCgv2Sm0ntF0ddW31SvkSg/CsQ=;
        b=Y5m2ECXI045PTE1GPt0PD/7k+inQhwHmcA/L0sqDs+nKBH65Yv9sK+ZKR+GsCN4Wvd
         9kuqR5Komfvt8KP1ATmcBuH93lnxRDn06BsquGsSVoborWnnkwjm8IMCkVBOw356x1X7
         gKpkeJ5Bt5lVhQjupKpSSlMCqIkyieoQOrFotahLpFRja1x1R0gnn1qi9iQmG7SuejKg
         JNWimfYe93DmevQzqALCk2xcyFJzxIhOBc1RtYeDAgtR7TpNWmPbO1940poA2nbbQypt
         KcynCeVzL/yxPc/G19gnw/xrblkX2mTyLtHlGJounU6KpW94A4xRuvJDJX3R73b1c2qQ
         Lw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZdHQyYpmW0ZeKX30eCgv2Sm0ntF0ddW31SvkSg/CsQ=;
        b=l3G/nB0n8HEWMYicU510IKOs4LGlyBDf9CL2N9NuZf2eSvHWwVEK14SpvUt/Jj7s42
         EiC12SSWPXrd2nfaK0rq+HBcNp9EW8QnvW/xmLS3Xw4JacKSeHtUOCmA0/MTcvdQ3DK3
         5J9mWPVyL5rLqWlfQOeMzDy1Wuw2BNfOr8vtKIW8GmY2AFNKY82NLn6TrcKd99rHyytg
         OZGOq5JbN/jcI+17aDvtRcq8KwTsP/29kaSneM/K8gk/iNiVjL5a/HbjW4hBFMlBiaBY
         /HbL1Qvs8Lm2Mlvt+uqRq/p4h6ZFqy+Qu8HXIRXgO0Cb2byxxn8zPT5spy/DPKfUmVPp
         oUSg==
X-Gm-Message-State: APt69E1BSwVEC6wOMIHRj3K7M6EteSXRozXHTBqn8urh942grc6r9IM7
        6zhtrhVvbzieD9NHFopXC2Y1hsL1o0JCPojcoQ==
X-Google-Smtp-Source: AAOMgpfC4qsRJyFx/wJJMeTzbxbvDAXjx1mkdkWseWFjpVpzwE4xnn4luFrPXQpwvwkNd9b5XdVw/az2rRJELy5cskU=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr734491iom.238.1531118924856;
 Sun, 08 Jul 2018 23:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan> <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan> <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
 <CAJZ5v0jo5-z0ZYDzdNPpn54+oAxpdG_=EvVDdz-HKxp7psu-EA@mail.gmail.com>
 <20180706083603.GA9063@wunner.de> <CAJZ5v0j6+m8NGMneG45tF9L1s6ahtFo91wPCO=3YOTEyAOL+VQ@mail.gmail.com>
 <CAFgQCTugu5XO06_xXb4ihkdfGJxtFX0813g2J-Jk2JeYtPP1vA@mail.gmail.com>
 <CAFgQCTsCjkDWJsNog_sTnS-ZaZ87fMFpKq1ekVSUG4MDs6K_jw@mail.gmail.com> <CAJZ5v0gxJ9LJ328WbgPrZCV-0SEiO31trsTSYYS8L95P4kfkbA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gxJ9LJ328WbgPrZCV-0SEiO31trsTSYYS8L95P4kfkbA@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 9 Jul 2018 14:48:33 +0800
Message-ID: <CAFgQCTvYwjKtx+AQf-kQjTsJMPRz48vgJ__jqNpwZuayG21oQw@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To:     Rafael Wysocki <rafael@kernel.org>
Cc:     lukas@wunner.de, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org,
        kishon@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 8, 2018 at 4:25 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Jul 7, 2018 at 6:24 AM, Pingfan Liu <kernelfans@gmail.com> wrote:
> > On Fri, Jul 6, 2018 at 9:55 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >>
> >> On Fri, Jul 6, 2018 at 4:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> >
> >> > On Fri, Jul 6, 2018 at 10:36 AM, Lukas Wunner <lukas@wunner.de> wrote:
> >> > > [cc += Kishon Vijay Abraham]
> >> > >
> >> > > On Thu, Jul 05, 2018 at 11:18:28AM +0200, Rafael J. Wysocki wrote:
> >> > >> OK, so calling devices_kset_move_last() from really_probe() clearly is
> >> > >> a mistake.
> >> > >>
> >> > >> I'm not really sure what the intention of it was as the changelog of
> >> > >> commit 52cdbdd49853d doesn't really explain that (why would it be
> >> > >> insufficient without that change?)
> >> > >
> >> > > It seems 52cdbdd49853d fixed an issue with boards which have an MMC
> >> > > whose reset pin needs to be driven high on shutdown, lest the MMC
> >> > > won't be found on the next boot.
> >> > >
> >> > > The boards' devicetrees use a kludge wherein the reset pin is modelled
> >> > > as a regulator.  The regulator is enabled when the MMC probes and
> >> > > disabled on driver unbind and shutdown.  As a result, the pin is driven
> >> > > low on shutdown and the MMC is not found on the next boot.
> >> > >
> >> > > To fix this, another kludge was invented wherein the GPIO expander
> >> > > driving the reset pin unconditionally drives all its pins high on
> >> > > shutdown, see pcf857x_shutdown() in drivers/gpio/gpio-pcf857x.c
> >> > > (commit adc284755055, "gpio: pcf857x: restore the initial line state
> >> > > of all pcf lines").
> >> > >
> >> > > For this kludge to work, the GPIO expander's ->shutdown hook needs to
> >> > > be executed after the MMC expander's ->shutdown hook.
> >> > >
> >> > > Commit 52cdbdd49853d achieved that by reordering devices_kset according
> >> > > to the probe order.  Apparently the MMC probes after the GPIO expander,
> >> > > possibly because it returns -EPROBE_DEFER if the vmmc regulator isn't
> >> > > available yet, see mmc_regulator_get_supply().
> >> > >
> >> > > Note, I'm just piecing the information together from git history,
> >> > > I'm not responsible for these kludges.  (I'm innocent!)
> >> >
> >> > Sure enough. :-)
> >> >
> >> > In any case, calling devices_kset_move_last() in really_probe() is
> >> > plain broken and if its only purpose was to address a single, arguably
> >> > kludgy, use case, let's just get rid of it in the first place IMO.
> >> >
> >> Yes, if it is only used for a single use case.
> >>
> > Think it again, I saw other potential issue with the current code.
> > device_link_add->device_reorder_to_tail() can break the
> > "supplier<-consumer" order. During moving children after parent's
> > supplier, it ignores the order of child's consumer.
>
> What do you mean?
>
The drivers use device_link_add() to build "supplier<-consumer" order
without knowing each other. Hence there is the following potential
odds: (consumerX, child_a, ...) (consumer_a,..) (supplierX), where
consumer_a consumes child_a. When
device_link_add()->device_reorder_to_tail() moves all descendant of
consumerX to the tail, it breaks the "supplier<-consumer" order by
"consumer_a <- child_a". And we need recrusion to resolve the item in
(consumer_a,..), each time when moving a consumer behind its supplier,
we may break "parent<-child".

> > Beside this, essentially both devices_kset_move_after/_before() and
> > device_pm_move_after/_before() expose  the shutdown order to the
> > indirect caller,  and we can not expect that the caller can not handle
> > it correctly. It should be a job of drivers core.
>
> Arguably so, but that's how those functions were designed and the
> callers should be aware of the limitation.
>
> If they aren't, there is a bug in the caller.
>
If we consider device_move()-> device_pm_move_after/_before() more
carefully like the above description, then we can hide the detail from
caller. And keep the info of the pm order inside the core.

> > It is hard to extract high dimension info and pack them into one dimension
> > linked-list.
>
> Well, yes and no.
>
For "hard", I means that we need two interleaved recursion to make the
order correct. Otherwise, I think it is a bug or limitation.

> We know it for a fact that there is a linear ordering that will work.
> It is inefficient to figure it out every time during system suspend
> and resume, for one and that's why we have dpm_list.
>
Yeah, I agree that iterating over device tree may hurt performance. I
guess the iterating will not cost the majority of the suspend time,
comparing to the device_suspend(), which causes hardware's sync. But
data is more persuasive. Besides the performance, do you have other
concern till now?

> Now, if we have it for suspend and resume, it can also be used for shutdown.
>
Yes, I do think so.

Thanks and regards,
Pingfan
