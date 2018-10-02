Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE13DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753282083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKDIIyxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753282083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeJCBXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:23:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40762 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJCBXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:23:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id c126-v6so1808860qkd.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKdQzwh51gV1JERCvmSwQQQPrW/AB+E9U+aVA5B3Zo4=;
        b=CKDIIyxIhcMsXx77Socv16pLMeZ1s7jzJeH7IG51FhBA/jMqMSBt8+KGRy2cir6d3A
         l9zsBrgflLnrvLIUjhJHsWc0I9CuRmEBlidK+84m0ieDCmMlEl+Asl9lRahigGNNCmqq
         xp0PqYK7Iuf1zBlbnaLGWovuwZe3cBGy8qS1wQdqeNEP6yD+6vPiQq77Cz8jobzc9USd
         PHX3CmnapWIaZYympBPO7ymmTkCDwI0cBiiWlPGfCdbYpkef9LshPvyHaWAB0efpljRW
         Rm6QEuGgkc/cKxv4l8Hdanos/WHwyFXoTCOVzpdj80IxHsln1RGicJmi8HcyLBLmbtZy
         8E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKdQzwh51gV1JERCvmSwQQQPrW/AB+E9U+aVA5B3Zo4=;
        b=I4TB1Wrh4PSCbautMO9Kq+xKw1Bfaj7DiA67baGNqYrNI56VY8ByCQle9fpmb4eS9h
         vlrE5MmvPXH+kOlaBnYfZR8+tfRADf2d+G78YxObe6e+JZfQgh1aZggK8q0UeVVil/My
         Ig+pgzj1qjKbSdHRw9UPv1ay/QTWeCnsO0FbgzgcKBoJFMpmTk4gNpYr4lICrdksv1Kz
         zDify+TuRb0IxEWJOkpRtUk/98sxv2BdRl+rX/YRap2zVq2yn7knrlLuFHXPr4d0pbPn
         SrjZXxFExhxxxn0EOzZP/Gf8sGo43f6KnYykYwKmwmPBwHThiiIWfq2Tr3qliWujTIHY
         2eQw==
X-Gm-Message-State: ABuFfoidi+TYq/BtVmlh3r6oOW9Ftmm6bUYJ3O9WACyX8Q2Dp4dlg1Q4
        pXqh8yoLOTh9oDnuxr6HQup6vrXVBMwEAC85RbuVD7c8
X-Google-Smtp-Source: ACcGV62kM/6LLMlg+blnGE54Y60tRxA8shDKFg5k2spp8sDv24X8hED0S+uEcEpgZBDwUExbMFbMunLEEKNUghR4jvI=
X-Received: by 2002:ae9:c107:: with SMTP id z7-v6mr6209376qki.192.1538505532715;
 Tue, 02 Oct 2018 11:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181002142327.GA19792@vkoul-mobl> <20181002163850.GA11549@kroah.com>
In-Reply-To: <20181002163850.GA11549@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Oct 2018 20:38:41 +0200
Message-ID: <CANiq72meqnbNYd0syo4DJftZedOD3GitAGeFT_66bpjCV93ehg@mail.gmail.com>
Subject: Re: [GIT PULL] SoundWire updates for 4.20-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     vkoul@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        pierre-louis.bossart@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Oct 2, 2018 at 8:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 02, 2018 at 07:53:27PM +0530, Vinod wrote:
> > Hey Greg,
> >
> > Here are the SoundWire updates (again) for 4.20-rc1/5.0-rc1
> > This brings in the multi-link streaming support and rst format
> > corrections. The changes are in linux-next for quite some time.
> >
> > Please consider pull to receive:
> >
> > The following changes since commit 8d6ccf5cebbc7ed1dee9986e36853a78dfb64084:
> >
> >   soundwire: Fix acquiring bus lock twice during master release (2018-08-27 09:49:48 +0530)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-4.20-rc1
>
> Now pulled, thanks.
>
> greg k-h

Confused here -- pulled to where? 4.19 will still have rc7, no?

Thanks.

Cheers,
Miguel
