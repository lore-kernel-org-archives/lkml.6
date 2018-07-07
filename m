Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191AEC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 04:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED7A224F0
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 04:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw1wWlOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED7A224F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeGGEYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 00:24:40 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40491 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeGGEYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 00:24:38 -0400
Received: by mail-io0-f194.google.com with SMTP id l14-v6so2641784iob.7;
        Fri, 06 Jul 2018 21:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdq4PjkT1aZJntFAZIaQxTy+p3y2mnP6dUaCyNkVzYc=;
        b=Mw1wWlOPWMPOXj/M4C1mAlcWzrt7ickg2aIdUbFZmlEjxdG4cJhUkQybi9PrwQswvK
         +Lj/EpgVxKo7nF43ac0KegmXGJtowyFI1TP/gQDu3mba1wPa1C3w8LzHto8KHuM4WlBN
         klluBLINb4pG6ptXWEp1IZKI5sOTes211xtEMhy+EvGKckF5bp14GLvj0LtCUQvdpr1y
         NFgsUNcFumdCaCWTGQ6LUVPONgofRjakGxKRM89Xpem+AC14ly19bi+b3L4n01Kh1Zk+
         EcRVsmTWR7a52+tToeLa1kwWCQBg5SGzyXgpoeBA9Im2ic06qDimS6JEyWzQjMsVweMB
         bDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdq4PjkT1aZJntFAZIaQxTy+p3y2mnP6dUaCyNkVzYc=;
        b=F0SgB0mCe5wZpMv2tZFKDMlhhvY+/pvKvRqmUoeXU7H5BjG80+h+oTd4wsgkGZs8dm
         r10Tw+vM/5gJRRoudCaRVGsJZVqGn8CAnRmbNu3izvoH5zWxZFnxkgAoJnyOCaa9SPPW
         xsO++gzwWElfYQQrbC9PUctViaV7JkCJ9R7KvCclI1bL4BWvTKqJCv9zx5rAhd1u7cSy
         nAJ+ioe5pTThAoFDNGht10Go652pCHoC3tuM0uFeY6fe4Oa9RqemNER3+cxC49UHmEv9
         c8HLk4LwS1c5YskAJHrzMNSnCPZF7uODnv8AsDIhUNA8Oie6ScKtAGnjUvZplIPa2mBl
         VZGA==
X-Gm-Message-State: APt69E1ReuvAlByI2zwvSCT987QsrcalxHMOqTqkP0wIRbUTCeGIEU+I
        D0kzk/qLENDHO++VRvOvGxNLsEpP7MyZ1SE8Aw==
X-Google-Smtp-Source: AAOMgpf1COW0JLYQKtid4aGaY3zUHtww5pxEzGjKw+1JvxA7NHSNFgJsW8Mo2gA7qUHbqwzfXvTv0F9UJuS+srWUacg=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr11248765iov.203.1530937478107;
 Fri, 06 Jul 2018 21:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan> <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan> <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
 <CAJZ5v0jo5-z0ZYDzdNPpn54+oAxpdG_=EvVDdz-HKxp7psu-EA@mail.gmail.com>
 <20180706083603.GA9063@wunner.de> <CAJZ5v0j6+m8NGMneG45tF9L1s6ahtFo91wPCO=3YOTEyAOL+VQ@mail.gmail.com>
 <CAFgQCTugu5XO06_xXb4ihkdfGJxtFX0813g2J-Jk2JeYtPP1vA@mail.gmail.com>
In-Reply-To: <CAFgQCTugu5XO06_xXb4ihkdfGJxtFX0813g2J-Jk2JeYtPP1vA@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Sat, 7 Jul 2018 12:24:26 +0800
Message-ID: <CAFgQCTsCjkDWJsNog_sTnS-ZaZ87fMFpKq1ekVSUG4MDs6K_jw@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To:     rafael@kernel.org
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

On Fri, Jul 6, 2018 at 9:55 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Fri, Jul 6, 2018 at 4:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Jul 6, 2018 at 10:36 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > > [cc += Kishon Vijay Abraham]
> > >
> > > On Thu, Jul 05, 2018 at 11:18:28AM +0200, Rafael J. Wysocki wrote:
> > >> OK, so calling devices_kset_move_last() from really_probe() clearly is
> > >> a mistake.
> > >>
> > >> I'm not really sure what the intention of it was as the changelog of
> > >> commit 52cdbdd49853d doesn't really explain that (why would it be
> > >> insufficient without that change?)
> > >
> > > It seems 52cdbdd49853d fixed an issue with boards which have an MMC
> > > whose reset pin needs to be driven high on shutdown, lest the MMC
> > > won't be found on the next boot.
> > >
> > > The boards' devicetrees use a kludge wherein the reset pin is modelled
> > > as a regulator.  The regulator is enabled when the MMC probes and
> > > disabled on driver unbind and shutdown.  As a result, the pin is driven
> > > low on shutdown and the MMC is not found on the next boot.
> > >
> > > To fix this, another kludge was invented wherein the GPIO expander
> > > driving the reset pin unconditionally drives all its pins high on
> > > shutdown, see pcf857x_shutdown() in drivers/gpio/gpio-pcf857x.c
> > > (commit adc284755055, "gpio: pcf857x: restore the initial line state
> > > of all pcf lines").
> > >
> > > For this kludge to work, the GPIO expander's ->shutdown hook needs to
> > > be executed after the MMC expander's ->shutdown hook.
> > >
> > > Commit 52cdbdd49853d achieved that by reordering devices_kset according
> > > to the probe order.  Apparently the MMC probes after the GPIO expander,
> > > possibly because it returns -EPROBE_DEFER if the vmmc regulator isn't
> > > available yet, see mmc_regulator_get_supply().
> > >
> > > Note, I'm just piecing the information together from git history,
> > > I'm not responsible for these kludges.  (I'm innocent!)
> >
> > Sure enough. :-)
> >
> > In any case, calling devices_kset_move_last() in really_probe() is
> > plain broken and if its only purpose was to address a single, arguably
> > kludgy, use case, let's just get rid of it in the first place IMO.
> >
> Yes, if it is only used for a single use case.
>
Think it again, I saw other potential issue with the current code.
device_link_add->device_reorder_to_tail() can break the
"supplier<-consumer" order. During moving children after parent's
supplier, it ignores the order of child's consumer.  Beside this,
essentially both devices_kset_move_after/_before() and
device_pm_move_after/_before() expose  the shutdown order to the
indirect caller,  and we can not expect that the caller can not handle
it correctly. It should be a job of drivers core.  It is hard to
extract high dimension info and pack them into one dimension
linked-list. And in theory, it is warranted that the shutdown seq is
correct by using device tree info. More important, it is cheap with
the data structure in hand. So I think it is time to resolve the issue
once for all.

Thanks and regards,
Pingfan
