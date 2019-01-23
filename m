Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0E0C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7175021019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El688uLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfAWSMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:12:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39068 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAWSMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:12:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so2786227ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 10:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzg1tuHMjgGx62a+K5tizECkMPClbb8/9EWdUS2WvGY=;
        b=El688uLsjgJ9N1ouKt4nrxJnWh2+F1O5t7It6ryKTqp1rviTGliGGP7eiAkSCHQqFD
         rKHfgCdDTgzHJ/UWwHRvjDBWEyZHHZaiCrNLKtE38JKlplWr3lCmkTc0RHHXBUQB8kpf
         2fTt7D4quahj5Eh/6Nmtz5nPRoyI91BSnhs7CZrsjtrVl+eHzXv5uzDGeYrgFP/vJOrB
         MLYWi0Xi+Zxx0dIOIBaKxHY5XTFynUN9Zg8FR/i0Hjz1m1GYbWYX1Zw8TtKgdVMIYkr1
         NZCTooJZmQSCiXYkhJA3x4ATvvnn275pH6zQiHPGtmUDFeeHoZSwLFP+i2zBdfaUf40v
         cmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzg1tuHMjgGx62a+K5tizECkMPClbb8/9EWdUS2WvGY=;
        b=QlDXkDHdTM2Kjm5FJ6heQ1GiiOh1QTshhX2sY7mn0ie0o2inEx746FvzHg/gkIPVPX
         8G/zcQudlCamwXr50BBgkzDbRDaxlbUWx1E7TFlWky+hHRavV4KMdCgmC6r/oSf5fXx4
         f6+cRu6EG+0sBNSuzkNAYhLTZNuHgL0swqnV9W7aDzXsMyCrSw540S+xs2xgDlcFoCS1
         LKRxInxeBtRfKFrpWHzJlm6dZlcFT80o02STTyEBSm/v+VjcUWKCfYXaLV3N9eoq3P+N
         nHUrdQX1DM7yZYvuEcIVg0srUQk+0G/9HqfKDi5sP1Mw/qDzQdB8y8MfSqvpJ6U6xnqv
         hc7Q==
X-Gm-Message-State: AJcUukc3arK/u0QXGnQoCfTw2hylFdeqKAdHiX+YB74PYBTpBkA1Qq1k
        fIHSg4rnGPTO7hXgnl+HDv0vzk/XgMlq41POp+A=
X-Google-Smtp-Source: ALg8bN4sJziHX5v88Z50fTeT9/gw8EGHONPULe0qrtVM7y6+UGwcKWElJElF8F9Xy7JM5lGIPI6rDOG8PTf4h9iurpM=
X-Received: by 2002:a2e:890b:: with SMTP id d11-v6mr3007369lji.113.1548267130300;
 Wed, 23 Jan 2019 10:12:10 -0800 (PST)
MIME-Version: 1.0
References: <90cb9f5e-c0b5-dfa5-c6bd-4808dc47c799@redhat.com> <CANiq72nwuD8FWRD7eSbofqvQu2=dCH8sovjFip5OncQwoWqdog@mail.gmail.com>
In-Reply-To: <CANiq72nwuD8FWRD7eSbofqvQu2=dCH8sovjFip5OncQwoWqdog@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 23 Jan 2019 19:11:59 +0100
Message-ID: <CANiq72mcSYZK6QNBf6Skw7zv5Qu31evGs_fZTAzifFS1mkHOoA@mail.gmail.com>
Subject: Re: New warnings with gcc9
To:     Laura Abbott <labbott@redhat.com>, Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 6:17 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Laura,
>
> On Wed, Jan 23, 2019 at 4:27 PM Laura Abbott <labbott@redhat.com> wrote:
> >
> > There's also some missing attribute warnings. The majority are caused by a
> > missing attribute in module_init/module_exit
> >
> > BUILDSTDERR: In file included from drivers/scsi/hptiop.c:18:
> > BUILDSTDERR: ./include/linux/module.h:132:6: warning: 'init_module' specifies less restrictive attribute than its target 'hptiop_module_init': 'cold' [-Wmissing-attributes]
> > BUILDSTDERR:   132 |  int init_module(void) __attribute__((alias(#initfn)));
> > BUILDSTDERR:       |      ^~~~~~~~~~~
> > BUILDSTDERR: drivers/scsi/hptiop.c:1704:1: note: in expansion of macro 'module_init'
> > BUILDSTDERR:  1704 | module_init(hptiop_module_init);
> > BUILDSTDERR:       | ^~~~~~~~~~~
> > BUILDSTDERR: drivers/scsi/hptiop.c:1692:19: note: 'init_module' target declared here
> > BUILDSTDERR:  1692 | static int __init hptiop_module_init(void)
> > BUILDSTDERR:       |
>
> I have been discussing these new -Wmissing-attributes warnings with
> the author, Martin Sebor. There is a new copy() attribute that we may
> take advantage of, but I will send the patch I have since you already
> found this :-)

Sent -- since someone asked me for it, here it is the reference:

  https://lore.kernel.org/lkml/20190123173707.GA16603@gmail.com/

Cheers,
Miguel
