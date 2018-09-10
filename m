Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C76BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E643820854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZrfBJq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E643820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeIJThV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:37:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41758 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbeIJThV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:37:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id y17-v6so18101852ljy.8;
        Mon, 10 Sep 2018 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnFGGnHhWxIC6mS7/G9pK9gNLGNPEC7YGgvXN1jUgoY=;
        b=jZrfBJq+k1aIaVzDefoJgKNzgUZV6xK1qgWMf6qOYb3mcNVF6EAjR+hR+Rj3CKn4BT
         c0KCxAq9w8DGoNbtdq7Yy9tsRaS+nYbM1zzm5hrsxd6RXd9kiBWQb5Hw3Nl5ZYW67qiW
         yS9BYViSRBTyoGBinEpg78G0GfOCkxAfMA626U72seN5ucKcV/LvKs+OC8KXudCdRMAI
         6jacOZz7lzn0qOKGJnjjqDxKOj/DHLkgxtSlzkLazT6P61B9t/nbWSGUb1qsQJkLU8AQ
         P5EAkzbWibB7kRs37K1PlTiCmtgM2o/jzTQfg/yyI3Zc1K5QTi9uC7rGFOPNx6RVm86Z
         BQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnFGGnHhWxIC6mS7/G9pK9gNLGNPEC7YGgvXN1jUgoY=;
        b=s/V0UqFX50aNnvkJcZh/MQHHKXn+tkRKohuIYAk/lmc17QpHH5h/Y64d13o4seFF5L
         dwGe0vlDKkwXsQ9dze0VLYDsSd0mphXiOSUs2EeVnh+v8c4yQ4t2/T4TKQlqDaTh4/js
         Bf5SzfWfHRzoVzBvp1gnZubzqpBSQ/QpI/DRxYajdr7BfdvRCf8+zzRbsUQtbKKiLLrh
         qlTE8Qm3VnS+TcOLkO3OdfIRQN4Nvr/MClFd6ILmysL9xWTzqlZVUMpLXXOJ8f5oAry9
         sNnAL9VOIHlyNtIRZ3Yz6/fgQ0j3DRas7W6Vox1iGCZhX/7niSvF2IaKFMWDP6EcrIaB
         3v6w==
X-Gm-Message-State: APzg51CADnRVdSMprsz3VCQX+pF3d9M1Ibxpt5uwTshK3wafha+2GKwT
        sFYpBOrJVNUdh+xEhCTO8c48hS2AI7FXC8l+mII=
X-Google-Smtp-Source: ANB0VdbyqplGAFSaQceSQIFoHVANC9x+c6lkT4mDnnK7uO/rAMRp2hUQnnxDbmS+tlk3Cr3s1q4sQ5Q6SjVPT+mkg/4=
X-Received: by 2002:a2e:3e0d:: with SMTP id l13-v6mr12673531lja.151.1536590574469;
 Mon, 10 Sep 2018 07:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
 <1536266581-7308-8-git-send-email-jim2101024@gmail.com> <20180906214549.y4xpleiukzw5rmqs@pburton-laptop>
In-Reply-To: <20180906214549.y4xpleiukzw5rmqs@pburton-laptop>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Mon, 10 Sep 2018 10:42:43 -0400
Message-ID: <CANCKTBsuEaeW=95tpjOPF2RecfTbdUP+C7a1QwFdvOBFG6o8Vg@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] PCI/MSI: enable PCI_MSI_IRQ_DOMAIN support for MIPS
To:     paul.burton@mips.com
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux@armlinux.org.uk, Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, jhogan@kernel.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        yamada.masahiro@socionext.com, Arnd Bergmann <arnd@arndb.de>,
        nicolas.pitre@linaro.org, keescook@chromium.org,
        jinb.park7@gmail.com, vladimir.murzin@arm.com,
        alexandre.belloni@bootlin.com, palmer@sifive.com, stefan@agner.ch,
        eric@anholt.net, horms+renesas@verge.net.au, tony@atomide.com,
        stefan.wahren@i2se.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        martin.blumenstingl@googlemail.com, olof@lixom.net,
        thellstrom@vmware.com, alexander.deucher@amd.com, dirk@hohndel.org,
        tglx@linutronix.de, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        Robin Murphy <robin.murphy@arm.com>, justinpopo6@gmail.com,
        markus.mayer@broadcom.com, gpowell@broadcom.com, opendmb@gmail.com,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 5:46 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Jim,
>
> On Thu, Sep 06, 2018 at 04:42:56PM -0400, Jim Quinlan wrote:
> > Add MIPS as an arch that supports PCI_MSI_IRQ_DOMAIN and add
> > generation of msi.h in the MIPS arch.
>
> I guess the second part of this probably became untrue after rebasing
> atop something including commit 34a4399f196c ("mips: use asm-generic
> version of msi.h"), and ought to be removed.
Hi Paul,

Yes, the second clause of this commit message will be removed.

Thanks,
Jim

>
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/pci/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Otherwise this looks fine:
>
>     Acked-by: Paul Burton <paul.burton@mips.com>
>
> Thanks,
>     Paul
