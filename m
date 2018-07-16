Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92CDECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFA22098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBpX0A9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFA22098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbeGPVqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:46:07 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:43154 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbeGPVqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:46:07 -0400
Received: by mail-yw0-f193.google.com with SMTP id l189-v6so14711114ywb.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xZ41iNaqOki9J22NOJdLz04MJiWb9HnqMaCKm1Di7Bk=;
        b=HBpX0A9wWdzDkoqP6G7kXV19f4C5+RwmMBGkHdNHcUQSzP8S0VBi5DhqFcSuBRoP2C
         nA8eGwX5xCrcbDl2k2FzZatDB3UGkxujGANpCCjjfPLNwB0QoAdRRoNgKIM1svj38N48
         MpNJvh5qcyuv+dpVa1jqm23J0Lpvr+s7vNRJ0wwVVdJaP+r4w08/+r5mt+ktL0FY/EcT
         Cu1Q4+sQVkqXX/TLrMfAHCAeUWjud5x1zD2Pfzp/L1EGTz2YsR83+WXwwd7Zp1D17pYh
         8BMEk58rTqlsXu2KIEOxoPjD0E2Fx8tPBD/tDzZht5imEWxg9QylX2bsPP7LgGVFPKO6
         KvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xZ41iNaqOki9J22NOJdLz04MJiWb9HnqMaCKm1Di7Bk=;
        b=CnYMYGRu1xIq/xj62IQA6U6YhoxuqOme4s03pU8K8YqJFzCvDd4+dvUE4gojlC/zsL
         3wAWcw+ZDjGyX2TQkMZsxIX2XedNOJ08ikMHt2ZdvdGXTozkJadSHqbQjybg7ljgRJks
         N88zE7ga8GJ49/Kx1XvVABGq5x/wzYnSw04vEVKqSDrIn3Xi/41FAykkz1QhTw+2E+xi
         uDfgF2eJjBe0VOdZGT/oY/YA8fVrSuyCze7L5cfNbR720tOgW8cm5TF+kZWsGDRFhJap
         H0vQD6x6xoVnI56dIlRPuZliJeopfDAYPBQPxiLq/3mcf6Qn0tdVPEdZZFPCpzZ0E540
         uSPA==
X-Gm-Message-State: AOUpUlFuZppbH6O3vo8asz3B0azGnVfjrRyCEIuw+ruyFko6RtglBasd
        ed4VzrYegQMcwITCCrGsf0qTuojMQXRxNv8Usn8=
X-Google-Smtp-Source: AAOMgpfI3Su1YcXk8mTTn/rWJ3xq6ShioMUxPH5GutEKuAz+HpHLi3pJDrIDjNQBFkKtPunwd0hY7skjTW2vpcputNA=
X-Received: by 2002:a81:a949:: with SMTP id g70-v6mr8551791ywh.324.1531775813194;
 Mon, 16 Jul 2018 14:16:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 14:16:52
 -0700 (PDT)
In-Reply-To: <20180714125749.GA19498@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-7-toddpoynor@gmail.com>
 <CAE_wzQ9BCLryFUrytYEJ+tSsog4nUXEr4cbtYNgbq3w7U-qezQ@mail.gmail.com> <20180714125749.GA19498@kroah.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Mon, 16 Jul 2018 14:16:52 -0700
Message-ID: <CAO3upoYB2aZ=pZCuh-OObHvaQQdpCMvRuDmqChaGQ3pyGHeh4g@mail.gmail.com>
Subject: Re: [PATCH 06/18] staging: gasket: fix deadlock in pci driver
 unregister path
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Zhongze Hu <frankhu@chromium.org>,
        Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 5:57 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Jul 14, 2018 at 11:07:21AM +0300, Dmitry Torokhov wrote:
>> On Sat, Jul 14, 2018 at 8:58 AM Todd Poynor <toddpoynor@gmail.com> wrote:
>> >
>> > From: Todd Poynor <toddpoynor@google.com>
>> >
>> > g_mutex held across pci_unregister_driver() call, also held in
>> > gasket_pci_remove(), which deadlocks.
>> >
>> > Reported-by: Dmitry Torokhov <dtor@chromium.org>
>> > Signed-off-by: Zhongze Hu <frankhu@chromium.org>
>> > Signed-off-by: Todd Poynor <toddpoynor@google.com>
>> > ---
>> >  drivers/staging/gasket/gasket_core.c | 7 ++-----
>> >  1 file changed, 2 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
>> > index 3bdf7d36b397..6d240dc59557 100644
>> > --- a/drivers/staging/gasket/gasket_core.c
>> > +++ b/drivers/staging/gasket/gasket_core.c
>> > @@ -668,13 +668,10 @@ static void gasket_pci_remove(struct pci_dev *pci_dev)
>> >         struct gasket_dev *gasket_dev = NULL;
>> >         const struct gasket_driver_desc *driver_desc;
>> >         /* Find the device desc. */
>> > -       mutex_lock(&g_mutex);
>> > +       __must_hold(&g_mutex);
>>
>> And what exactly ensures that mutex is held here? Yes, we are holding
>> the mutex when we unload the driver, but PCI hot-unplug or unbinding
>> the device though sysfs do not go through module unload code path, so
>> you'll end up here without holding the mutex.
>
> Which is a huge reason the whole "wrap the pci core calls" is not going
> to work here at all.  The device ownership rules are all wonky because
> of this.  Unwinding that is key to getting all of this right.

OK, I'll drop this patch in favor of redoing things not to wrap PCI
core calls in the future, thanks.

>
> thanks,
>
> greg k-h



-- 
Todd
