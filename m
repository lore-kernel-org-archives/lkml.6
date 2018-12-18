Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E77C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FC820815
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeLRPZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:25:03 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44339 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeLRPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:25:02 -0500
Received: by mail-qk1-f196.google.com with SMTP id n12so9659497qkh.11;
        Tue, 18 Dec 2018 07:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TohuLPIf0o9dPse0NxnUD/wZGM8HyqMmatknUS6JBdo=;
        b=TsxSXCVmf51l6tvfnEx14CCvQ3Cxht0Je+DW8ugboSFDKLHyxp7bgfYlHubmxqTffW
         wB+C+6IWam29BrjLNtPGgIM0kmsr7qdE/XrSt+8NsTXBey5E8mUc53eBEeRkMW2nOGXn
         AeXuq99VT1914JTPLPQtAhH4DI0NYNrnA0AXknH9kidK28HG0bZAos9qhZXCTjXvT5jv
         hH5PcjprnoI5rtkcZetOuaw6/mqmjdLpzXrbh5xFWI3S3DL74WuZuN6Wxbt1aAT2ixWA
         3hPxZwJwC0z32miaLkOHU5sipw0lP3oyyKpYQKAORiXqDumr5LdIZ1vxBOaTbIiQ+Uhq
         fBVg==
X-Gm-Message-State: AA+aEWbckxhuxXpX7KfQpYEOLQ9Oo/bfqcNkugBW4162UfaIjBrpoKnp
        h9S7EFWZjePQBE/8oywZgvnnn4X5wT36AnM43aU=
X-Google-Smtp-Source: AFSGD/VTjn43qT8Lfr+9KkSs74tGoZD2Fxc+cAfG6p+N9hFFssdKam1XkMeIdbyGw4JzWDKSfoZUIXh/VTsoiFTezSs=
X-Received: by 2002:a37:324a:: with SMTP id y71mr16649536qky.291.1545146701922;
 Tue, 18 Dec 2018 07:25:01 -0800 (PST)
MIME-Version: 1.0
References: <1542125174-8204-1-git-send-email-thor.thayer@linux.intel.com>
 <1542125174-8204-2-git-send-email-thor.thayer@linux.intel.com>
 <CAK8P3a1+LKakyD_gJTiNqKwNuP2Ptr_Wj4zJXf=+SDHSJHbexA@mail.gmail.com> <183b18b9-55f4-55d0-b1f6-674a6df49d1b@linux.intel.com>
In-Reply-To: <183b18b9-55f4-55d0-b1f6-674a6df49d1b@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Dec 2018 16:24:44 +0100
Message-ID: <CAK8P3a2=v=Kn5ECTFT-HkqhdtEkgG5sJ=jGpEa-FVFzP5M3Sgw@mail.gmail.com>
Subject: Re: [RESEND 1/4] mfd: altera-sysmgr: Add SOCFPGA System Manager abstraction
To:     thor.thayer@linux.intel.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        David Miller <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:21 AM Thor Thayer
<thor.thayer@linux.intel.com> wrote:
>
> Hi Arnd,
>
> On 12/14/18 6:36 AM, Arnd Bergmann wrote:
> > On Tue, Nov 13, 2018 at 5:03 PM <thor.thayer@linux.intel.com> wrote:
> >>
> >> From: Thor Thayer <thor.thayer@linux.intel.com>

> >> +static int socfpga_is_s10(void)
> >> +{
> >> +       return of_machine_is_compatible("altr,socfpga-stratix10");
> >> +}
> >
> > I don't really like the way you are checking for a specific here
> > here though, that is something that should only be done in
> > an absolute emergency when there is no way of fixing the
> > device tree files.
> >
> > Since this is a new driver for a device that is not used in
> > mainline kernels yet (AFAICT), let's fix the binding and add
> > a proper detection method here.
> >
> Thank you. I'm not completely clear on this. Are you saying this
> function should test for a new compatible that is assigned to Stratix10
> in the binding ("altr,sys-mgr-s10") instead of the machine name?

Yes, exactly.

      Arnd
