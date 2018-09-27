Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C1AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082252156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FB2z/HMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082252156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeI0H4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:56:31 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53583 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeI0H4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:56:30 -0400
Received: by mail-it1-f195.google.com with SMTP id q70-v6so5788182itb.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 18:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UcFqGP3E85oXXWZas0ZEpht64w14o6DJQsM8Rotqa9k=;
        b=FB2z/HMwA1QWVmkeQnhBjN9AfeT4u6XjzqW1pZlAcfUMFTSNcfPuVlt8zm27VtGvm7
         dY0SGt3oL4+GT0wVnKJ5dVJgL04FAyB392LQVDeKWqLwXwsB/m/T+BGM9GiN7iXKCTUF
         CHtg9DiEcqjfU3wKt7Qnnrae2Qfbv9aOs4bGvV3K97TuW3mL7sf71ThVuN1CIlckwl7c
         hiNdtPD3ecGLStSPluIpWcDM1wl7w0/DhsGjXCNPVDw+i5kInKGIjhKe7m6JxjXWep2N
         nk9jGvXSvv+J3Eg8FoUx0NImFY9nx+8HgEyFd00l2UxOgocY2kBsOEhsBTnavA7Y2y6B
         R/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UcFqGP3E85oXXWZas0ZEpht64w14o6DJQsM8Rotqa9k=;
        b=Z1PKQVq9kGE2E0CDUsoy29Xk9ysodf8ZHcnwhj9qMFugLEL/gmtdjck74xj9GTYkDQ
         JfuaAyBwLVHJj1rdxOnpUNRtLQnJpRofE9RHTgoOmyXjEmRO3tRrwPuxVBKDYDqSwSJB
         UIYPYighZH4+PlJh/sRL//HL3LaAgEsDot1ZZ8/bUOnKkpWmRj6ElV1jSRwo4fPB34Nt
         O6FIIARW1s9BVPdvmxO8ihfnzXjYXUQELSkDZql0j+YUadFJJqM6tmoqPFC1EoJxr/4C
         rTUWzouvOpT8xBUZNqium6t5xis3UkGvSpj1JSpSNHEva5i14b5Ij7V5+j+kvtxAohxV
         SMQA==
X-Gm-Message-State: ABuFfojRhJ7EUC+EdJuQXsu6hMBc4FEslb1gHvyBtt8fKvuMDUoIaBEe
        DyZUZ5qvLAX1Oz+SWh62Kr9kGw==
X-Google-Smtp-Source: ACcGV62mwwFdDTzGUTK6zJebt8AmnwfgaI+4fTXY9e+yJ5TueKl8DDAalAaOPocV19ApJX9G0vBNgw==
X-Received: by 2002:a02:9b97:: with SMTP id p23-v6mr8345893jak.5.1538012443474;
        Wed, 26 Sep 2018 18:40:43 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id e16-v6sm254348iob.64.2018.09.26.18.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 18:40:42 -0700 (PDT)
Date:   Wed, 26 Sep 2018 19:40:40 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH] mmc: add quirk for O2 Micro dev 0x8620 rev 0x01
Message-ID: <20180927014040.GA183684@google.com>
References: <20180923203924.68452-1-yuzhao@google.com>
 <CAPDyKFqiUO-7O6bgrszuR3YKMkEoPT4976gvDKvUWpYuNp03ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqiUO-7O6bgrszuR3YKMkEoPT4976gvDKvUWpYuNp03ag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 01:48:58AM +0200, Ulf Hansson wrote:
> On 23 September 2018 at 22:39, Yu Zhao <yuzhao@google.com> wrote:
> > This device reports SDHCI_CLOCK_INT_STABLE even though it's not
> > ready to take SDHCI_CLOCK_CARD_EN. The symptom is that reading
> > SDHCI_CLOCK_CONTROL after enabling the clock shows absence of the
> > bit from the register (e.g. expecting 0x0000fa07 = 0x0000fa03 |
> > SDHCI_CLOCK_CARD_EN but only observed the first operand).
> >
> > mmc1: Timeout waiting for hardware cmd interrupt.
> > mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> > mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00000603
> > mmc1: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> > mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
> > mmc1: sdhci: Present:   0x01ff0001 | Host ctl: 0x00000001
> > mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> > mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
> > mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> > mmc1: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
> > mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
> > mmc1: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x00002077
> > mmc1: sdhci: Cmd:       0x00000000 | Max curr: 0x005800c8
> > mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
> > mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> > mmc1: sdhci: Host ctl2: 0x00000008
> > mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> > mmc1: sdhci: ============================================
> >
> > The problem happens during wakeup from S3. Adding a delay quirk
> > after power up reliably fixes the problem.
> >
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> 
> Applied for next, thanks!
> 
> Kind regards
> Uffe
> 
> > ---
> >  drivers/mmc/host/sdhci-pci-o2micro.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> > index 77e9bc4aaee9..3e5ecf7ce101 100644
> > --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> > +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> > @@ -490,6 +490,8 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
> >                 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> >                 break;
> >         case PCI_DEVICE_ID_O2_SEABIRD0:
> > +               if (chip->pdev->revision == 0x01)
> > +                       chip->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;

Hi Uffe,

I apologize for the missing /* fall through */ here. Could you
please add it in case it causes any static checker problem?
Or I can send a v2.

Thank you.
