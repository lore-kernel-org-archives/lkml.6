Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FC4C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BFA20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BFA20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeJBRFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:05:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34731 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeJBRFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:05:15 -0400
Received: by mail-qt1-f196.google.com with SMTP id x23-v6so1308600qtr.1;
        Tue, 02 Oct 2018 03:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1detcQgGngO0H7vdwbmJ3gVEBJe22pTIFUUbRFQe+8=;
        b=pZ/ZdOzjwkdHqjufjIyNf1zsTX3G25INPIlW/UlmTRNZIYB3/Ru6ikcVp6kJwRIZj0
         7iH3MM9UwVAMw7j+4IXM2yvUmcvKqGTqqS6+SGBPwEOBdiJq8ISncV6xokpEo87qX/M4
         iCWPuZCq8ZloG9djZKvGkqoKkkVjNwvysk2daH/Wq9BA2q3XQmp64DCpPCw9uHA9IWNy
         tHHWYj60hLniNO/InNYgsFVHS/YKNIM0Nwg3FtIV8LnhfLHm5ypxO8bMnRkrD+7r/Tun
         70Ic9h9r2tpEgcUs7chge+5vg8U7T1YoU9usAOdv2ZXBFQCnW6qMAwOXXt61u/AHsxZo
         4ygQ==
X-Gm-Message-State: ABuFfoiPc3cKZKsW/BfPVDNmFUgPtUTFxgo4V7F/gNKUpSJjiGe9SEDU
        aWVysvtNZYa0PvkeJhjepGI8Pv1j+7YES+O7yp4=
X-Google-Smtp-Source: ACcGV63JEmy/c/yCZQ/jYN5uYfG+IuUcf48Tk6SJPEB9RykCJx59zsi/l8UIrE0MhfvSkhhSVIXUwCIVSPuco1+7IRI=
X-Received: by 2002:aed:2bc6:: with SMTP id e64-v6mr11988797qtd.132.1538475760405;
 Tue, 02 Oct 2018 03:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181001174349.26357-1-f.fainelli@gmail.com> <CAHp75Vd2js3QCJYjPDea5xapYLiOObSUF7_Q2hjG8RS=QYyPaQ@mail.gmail.com>
In-Reply-To: <CAHp75Vd2js3QCJYjPDea5xapYLiOObSUF7_Q2hjG8RS=QYyPaQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Oct 2018 12:22:24 +0200
Message-ID: <CAK8P3a22COa4YyWc7_pCSAy3TU0mne76RGwG8d73Aphad_ekwg@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: brcmstb: Allow enabling the driver on DSL SoCs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        jarkko.nikula@linux.intel.com, Jean Delvare <jdelvare@suse.de>,
        kramasub@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        eajames@linux.vnet.ibm.com, James Hogan <jhogan@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 8:13 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Oct 1, 2018 at 8:44 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> >  config I2C_BRCMSTB
> > -       tristate "BRCM Settop I2C controller"
> > -       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> > +       tristate "BRCM Settop/DSL I2C controller"
> > +       depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_63XX || \
> > +                  COMPILE_TEST
>
> I would rather split this to two 'depends' entries, though it's
> cosmetic and up to you.

You can only split 'depends on A && B' into multiple lines, not
'depends on A || B'.

      Arnd
