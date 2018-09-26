Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EF2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377F420833
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377F420833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeIZVoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:44:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45065 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeIZVoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:44:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id l2-v6so17665808qtr.12;
        Wed, 26 Sep 2018 08:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDSNVmouWnBBWONUR8ESHt5PTgh2XiK+9dNGcjg5YaU=;
        b=rqvHI3yc7J1Is7RnTFh2WtibWPqruygrLWl8vDhywqAXUAVj4MDmoKdlOrxDDqNASe
         MTWMlBjI1cWAt9uVZ3D84dgUacsmY2cl5Q+2g7iuRJQeKQg8LZEOhFu9tebGSO1rf8FG
         oo72XkP+ahIKlhju5ZVfutbSal47qCgGxzo1EKL7kuoiSyiqZrw5DcEM17rUrBKEcmYt
         SpNXgT6tAV1FvnJ+DJk+P+6eh9L11BGH8/eWcujkspjFmvhL5TyDW2NEABo5aSXS4VsA
         J5LxVPPthbJA+9Qj6hNd6+8uaFQTy3do+ceXj1BsfO1N5c2PdJD6ZBx7q12LwkXc15Xi
         Qd3g==
X-Gm-Message-State: ABuFfoj/2ci88yKYNyfWVsdhPdM6Gu3kEYef7kAU47MBuEOZfgWqqg5Q
        q5FGz4h3z5qozPaKzHntE+h0QF1hNbmR24RFsco=
X-Google-Smtp-Source: ACcGV63BsbBcM6CrMtoMwcpKhYQYzHSefF7QS15pC3a0uK6soYxbi69p7H6TxfoFxc+wizw++alfBIBUT9RIdSqFHEg=
X-Received: by 2002:ac8:7254:: with SMTP id l20-v6mr4883333qtp.213.1537975838128;
 Wed, 26 Sep 2018 08:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180926142029.619397-1-arnd@arndb.de> <20180926165240.77a78fc4@xps13>
In-Reply-To: <20180926165240.77a78fc4@xps13>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 26 Sep 2018 17:30:21 +0200
Message-ID: <CAK8P3a29=N9AoBAfKzNR-8fKQgoLGyPJJrqXn0eMwas+nKWN=A@mail.gmail.com>
Subject: Re: [PATCH] [v2] ARM: omap1: add nand_chip declaration
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Wolfram Sang <wsa@the-dreams.de>, Suman Anna <s-anna@ti.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 4:52 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> Arnd Bergmann <arnd@arndb.de> wrote on Wed, 26 Sep 2018 16:20:16 +0200:
> > @@ -82,6 +81,7 @@ void omap1_restart(enum reboot_mode, const char *);
> >
> >  extern void __init omap_check_revision(void);
> >
> > +struct nand_chip;
> >  extern void omap1_nand_cmd_ctl(struct nand_chip *this, int cmd,
> >                              unsigned int ctrl);
> >
>
> Boris pointed me that the commit introducing the regression is still
> in nand/next, so do you mind if I squash both patches with it?

No worries, please do that if it makes it easier for you.

      Arnd
