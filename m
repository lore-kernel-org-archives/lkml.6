Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AD0ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F1E20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBELvfvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F1E20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeIRG6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:58:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39026 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIRG6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:58:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id c12-v6so287731otl.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 18:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5v+LXMTadmZ3qiLNZUn7bqc7NqxVxbWTqGkPS2D5kc=;
        b=eBELvfvPIlDYyHyOunwWPFNcFtPW2LNmOP3lI4QMl40/fYzzpSI57cf74C1h94ifF4
         c+mjVItAizgTuuHGaWcn8/Wcdc+duQD2aO98Z/+DLMFh2LmI3tdoPijNfeCaWeW00KeE
         u0+J0LBN4rLL2Hrjas1P2aacKl5lF6ZhLtivL0sveqafdO3nlIXoaxwmy3HrIspmNSo6
         HjPmlF+Qr1yQduJwtlao4i+2T/xfYSeDcwcp09qVbG5+E+W6ob7lUbzRxLV9HaJaSVu8
         ZTl9jGhdoZkXH9l+wn9ij7mupb1+cLyxduzf+v9LAJ8UE5ABdO2jOqIy0jRdbH2cqIXC
         latQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5v+LXMTadmZ3qiLNZUn7bqc7NqxVxbWTqGkPS2D5kc=;
        b=GRqjCr+VmWBpEvvNwIfTrRCX4DDTQ5lXVFtZ/nLZsOJKv4bNPBZqkGwAtVIsKwVos7
         bE/MSewrdnzAjvroSQVAsG//U0T0AY1sLcEXsM/4aKwvyDtP35WMyO4MGUdjAMyfMV1j
         cHUF93/ixtjVdHyDxjTA18t2lkSZA57Tt91YrUtUfMwNULO+gV1so+wQ+o9vnwVloOSu
         UD9sFOeennodLlm2EjmKNGgNkJjU5Fr+ZjWeymkr9i9esgwmnG7nA8Z+Cji6zku21JfV
         cT5RzdshHIMMWL94qTr/IxDn/abJOR6gg41Q/zzWsq8d7YfFM8u3Rj+ghB2S2hRX0ehr
         16UQ==
X-Gm-Message-State: APzg51AgoMFniT4rDWWCW0/9VfEMKE/RURdiKbFWgUl33nkUgwiEKL0T
        bY6dArxQP/wrjkcreknmGEktRaqgwVb5cjrhskwpQg==
X-Google-Smtp-Source: ANB0VdaLKsslc6XtQQn416UFFiueyc3mYXz3QCJW3rk0d/N4OX4LKIEuIQTyFQ++Y9PfYSFsTuE0Uw+Hl8dixY9xw2s=
X-Received: by 2002:a9d:6554:: with SMTP id q20-v6mr14595081otl.209.1537234123361;
 Mon, 17 Sep 2018 18:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <1536895810-28903-1-git-send-email-linux@roeck-us.net> <CACPK8XchoryZ_RS8f4n=-GoT-Ak+dXuC3cgqLmxK9C=gySEJFQ@mail.gmail.com>
In-Reply-To: <CACPK8XchoryZ_RS8f4n=-GoT-Ak+dXuC3cgqLmxK9C=gySEJFQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 17 Sep 2018 18:28:32 -0700
Message-ID: <CAFd5g44dZ+SvCBGNztuq2izMb7401izXVoq=fU9=BehrwikVwA@mail.gmail.com>
Subject: Re: [PATCH] i2c: aspeed: Acknowledge most interrupts early in
 interrupt handler
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux@roeck-us.net,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 6:11 PM Joel Stanley <joel@jms.id.au> wrote:
>
> On Fri, 14 Sep 2018 at 13:00, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Commit 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events
> > properly") moved interrupt acknowledgment to the end of the interrupt
> > handler. In part this was done because the AST2500 datasheet says:
> >
> >  I2CD10 Interrupt Status Register
> >    bit 2 Receive Done Interrupt status
> >          S/W needs to clear this status bit to allow next data receiving.
> >
> > Acknowledging Receive Done before receive data was handled resulted in
> > receive errors on high speed I2C busses.
> >
> > However, interrupt acknowledgment was not only moved to the end of the
> > interrupt handler for Receive Done Interrupt status, but for all interrupt
> > status bits. This could result in race conditions if a second interrupt was
> > received during interrupt handling and not handled but still acknowledged
> > at the end of the interrupt handler.
> >
> > Acknowledge only "Receive Done Interrupt status" late in the interrupt
> > handler to solve the problem.
> >
> > Fixes: 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events properly")
> > Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> Thanks for getting to the bottom of this Guenter. I gave it a spin on
> Romulus (ast2500) and Palmetto (ast2400) without issue.
>
> Tested-by: Joel Stanley <joel@jms.id.au>
>

Nice work! Thanks!

Acked-by: Brendan Higgins <brendanhiggins@google.com>
