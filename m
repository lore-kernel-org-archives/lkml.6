Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57948C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9752152C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="fP9nYHI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9752152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeI0Jaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 05:30:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44427 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeI0Jaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 05:30:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id k38-v6so1221054qtk.11;
        Wed, 26 Sep 2018 20:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cKgLph78qRZFq6tvtp1QjFO+mqXdlSWTwvpo7hDQH2I=;
        b=fP9nYHI4Eo/KZnqM4tDDUEwkAGKd0cnxNjhoGFmJN35OX1le7rkvhvMW6CTxGn9M0b
         3UkSu+Rw3dJGPt3TmJzL2/wd6NBHZwoyMd2zpkn7omrwqMmjdeY3yoQzdb0uY5vu9DcT
         KQymykkoqQEDxBOoWwBbBm9ZCdtfjM2XgjUP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKgLph78qRZFq6tvtp1QjFO+mqXdlSWTwvpo7hDQH2I=;
        b=k/+L8E4BihvrMdmeV+PbRCoDi6vkMCNDeeiCfvDyXkytcNVyKZa9CA/cgsr6e54QV9
         mLRV6FSd0Pqwlu3WFOkRHiGukXP7Ui1qrQ7edGe3BhGzgDlVu7sbDWh/g1BSEICDh3gR
         fob63eC+ZW5T2xr8oKhGKelnM4chY7qk8t+EJ1BtDrWoXmo3400pqhLrEXe4ZAEsK7ZS
         785JIXWyza7UY2TJChO65zvNJLgr+ikHOVTZCEpgGMNAgf+Y/901qlf5hlVXEe3Qmmyw
         uJCq4mSIGcn/GTDB4rouYfXlyXfICte2O/uxSmgvBvd47atIYiCqn5r4irN37vNKEmsz
         cg8g==
X-Gm-Message-State: ABuFfojp4dx+hGqMhVacnN6aejmxveP2rLHI71+i/x2uBiGVbZUpVjHk
        V/8kyXya1ZdfsJP4siqjEJAVhyGHEVVBDEogNRE=
X-Google-Smtp-Source: ACcGV6007fHWRnnrvcMDW8W1E1F42/pDdrpf7B9B31x8fUy+6zcAxz//5By621sDkL3EDiYPWpL6bVTjFfGlF9pj24A=
X-Received: by 2002:a0c:eac3:: with SMTP id y3-v6mr6388549qvp.89.1538018091779;
 Wed, 26 Sep 2018 20:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180919164712.4030353-1-vijaykhemka@fb.com> <20180926230026.GA26508@bogus>
In-Reply-To: <20180926230026.GA26508@bogus>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 27 Sep 2018 07:14:39 +0400
Message-ID: <CACPK8XctuiN8yphXFUmwXnpphb5LP2i8Cje_HAdsBwMWSvpsdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dt-bindings: Add vendor prefix for Facebook
To:     Rob Herring <robh@kernel.org>
Cc:     vijaykhemka@fb.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 at 03:01, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 19 Sep 2018 09:47:10 -0700, Vijay Khemka wrote:
> > Initial introduction of Facebook TiogaPass family equipped with
> > Aspeed 2500 BMC SoC. TiogaPass is a x86 server development kit
> > with a ASPEED ast2500 BMC manufactured by Facebook.
> >
> > This adds an entry of Facebook in Documentation for vendor prefix
> >
> > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Rob, can you take this through the dt tree? I've already merged
Vijay's device tree through the arm soc tree, and don't plan on
sending another pull req for 4.20 at this stage.

Cheers,

Joel
