Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEED6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57C320854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/Kdph18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57C320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeIJTb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:31:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33867 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbeIJTb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:31:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so18150958ljk.1;
        Mon, 10 Sep 2018 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mt07X8Zmz1G3uxvR/fZyYOcCG9AjEq9iEAcCAq83phQ=;
        b=h/Kdph18ELX6NChXtcVkdABtkp/JfFncOKojMs3R/RDvgYRWfGehi8VjLnhf12yJih
         7tl4YpneipBSPLAgQqIioVSLxhvIfwm3WtoqmjfEmGOoTZpQXHLBMG+u6XqaZz2BzKdT
         hB1EmgN+rIK6IavVYSQtMqKIKRDtrb9vRuWJYBDInpyOkPyRsb9Xwewf7MSOwzB8O8DA
         2oPyJ08qe/wPNp/59Pet2HlgdJyccqcqtcNmMBpLQaJoTNbiB88eWSlWI7CGVOFhJXK6
         HxK7UwHQuLL8sooUzwqlX66o3Lhryt0oX9PMN6LopVIhGveRNevSAxzFBJtOTOAjabFc
         +52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mt07X8Zmz1G3uxvR/fZyYOcCG9AjEq9iEAcCAq83phQ=;
        b=uXSzZgwOh9joXSNnzA8AxL/0ejOcD207uOS123f1w/4ruFXJPLYF43kplbfw9VTm7B
         JSwL81DB4UvRhj1fwceCFYxeOWlijuU8LuuGH7o0gAyhyL4Tt7aMEiDoEe3jE8PGXeIK
         /SMXeQSnzMaDqMMbTsdfW6bQgerHzb43b5+StuHDe9kPAyCdyTw4H/NRvBXsDul3uwY6
         B2n3syBQLLtfri8JgZJvUix5TtAUfFhwXr9+VT44clPlResHHioGVNsbsjGCRzOLzni6
         KIFBEZjoge9mpGy4m1bcQcgQ/QVcYVxAoPnAgyriivsIxdDUWgjvOnrq21nnoFrVD9d+
         AGhA==
X-Gm-Message-State: APzg51AppezRwHgQE1pZ56pZS3IHsihsEwYRrDdw6rXA3N+vHdon3hch
        UPd6nhaHn2qk9cgcsG/b11ZtcpAq6xxnvsaM2YE=
X-Google-Smtp-Source: ANB0VdbrBbbVM+4zL9VsiZVVdCRlmZjidZAtKeGLZB9fdH7E4/ZGK+Zf8eSdNAfnIpqNVfNm5Sm8rnMpY5GTefC1Cy0=
X-Received: by 2002:a2e:8098:: with SMTP id i24-v6mr12506697ljg.36.1536590250686;
 Mon, 10 Sep 2018 07:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
 <1536266581-7308-9-git-send-email-jim2101024@gmail.com> <20180906214955.2yzyj6tkmflnnvdx@pburton-laptop>
In-Reply-To: <20180906214955.2yzyj6tkmflnnvdx@pburton-laptop>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Mon, 10 Sep 2018 10:37:19 -0400
Message-ID: <CANCKTBumoy6mw2n+V7hN_T1SYxhq3JQMxgQUUSmOLuMX-Kv=zw@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] MIPS: BMIPS: add PCI bindings for 7425, 7435
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

On Thu, Sep 6, 2018 at 5:50 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Jim,
>
> On Thu, Sep 06, 2018 at 04:42:57PM -0400, Jim Quinlan wrote:
> > Adds the PCIe nodes for the Broadcom STB PCIe root complex.
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  arch/mips/boot/dts/brcm/bcm7425.dtsi     | 28 ++++++++++++++++++++++++++++
> >  arch/mips/boot/dts/brcm/bcm7435.dtsi     | 28 ++++++++++++++++++++++++++++
> >  arch/mips/boot/dts/brcm/bcm97425svmb.dts |  4 ++++
> >  arch/mips/boot/dts/brcm/bcm97435svmb.dts |  4 ++++
> >  4 files changed, 64 insertions(+)
>
> Do you have a preference for how this gets merged? If it goes via the
> PCI tree then for patches 8 & 9:
>
>     Acked-by: Paul Burton <paul.burton@mips.com>
>
Hi Paul,

I hope that the 12 commits  go together and will go through the PCI
tree.  I'm inclined to think I will have to do a V6, and in the cover
leter I will mention this request.

Thanks!
Jim

> Still looking at patch 6.
>
> Thanks,
>     Paul
