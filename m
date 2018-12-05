Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA528C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6872A2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfTBNihG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6872A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbeLEPIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:08:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45952 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeLEPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:08:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so18857616ota.12;
        Wed, 05 Dec 2018 07:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9WUZstKqAOsKHMYcP2ws0dyJFa2WDWkLWIP3NiPsHk=;
        b=CfTBNihGodl+w11JP/vLBANzcDljhfATXzqt7gu3xOcxYoaMxUE5T5LfHp5p9Cp2A4
         sd8shdYwl03X4jhxxMBWVw6gd5b6wtvAHQb0HZaOSPjVdq3XCpW38+MEKRytwofpOhzr
         6AbA6F4iM7+BjHic5hkJ95tXB04VY9/CA+9/qLQRIZ0XPHdT7KN2ZWMJwoJtA16FNc+C
         F2HSbRnwpBwgoblg6l+Dn+ozT58hSiNgBCY6SjnE+bpf3/ATjEVFfnrjtsoxJL5JW+xb
         V6Z0EitAAC6HL67bs6jEJBsW9Oby0926FDt9ct6LSP0I3ttc4zzNonXzC4D1CP5TTF9u
         Lzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9WUZstKqAOsKHMYcP2ws0dyJFa2WDWkLWIP3NiPsHk=;
        b=nvVOZXNXqEmGjKBGBXr6Pwd9jYL3PEAVixBHheMxRWkBfq9CNMeNskpDqwcbqHTKfR
         9TbXU5MbXeaoCrpUHBzddPoTnQLlHCfKSVGGnKwV2U9tTKB/7NgdR3Ztl9Bjr/p7uedf
         C5HM1suVNxM7p8FVipbiqEkAGzeFKL/ZyEeWnJGDAHCQAVg807l74d3RjUjg34N5z4Lo
         Gu85t+jGQXbHYdW4x0I+CpS4cbYVPqOazOIxLXJm6EG6HCVL5DTwVQBxJj2hWITj+WJC
         zE6ebiL1LypkXofPLNjXImFNoRy/K7zxIDEzgdh9W+snAXjP9YrmF/WmO4Dh3xtopGdV
         aWtA==
X-Gm-Message-State: AA+aEWaySoNHv/152sDgvQQKS5OVr0pY/kKXftv0MeM1n3TM066AveNT
        /1B/GN7RLMFJVLJ30ctg1Q/LPr7Xehb9UiXUWis=
X-Google-Smtp-Source: AFSGD/X7QyA8VLmuJH/v/CBHnI6KXMbAbP8U+qcZMVJJ1warNLJnopGZxEsnCxEp6ZDggSGDZADLYosZJNfT1RInyrM=
X-Received: by 2002:a9d:2c65:: with SMTP id f92mr15802100otb.18.1544022507769;
 Wed, 05 Dec 2018 07:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20181130205624.16227-1-TheSven73@googlemail.com>
 <20181130205624.16227-2-TheSven73@googlemail.com> <20181205075145.GN3987@dragon>
In-Reply-To: <20181205075145.GN3987@dragon>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 5 Dec 2018 10:08:16 -0500
Message-ID: <CAGngYiUvYHTRMvsS_4s8PVyPg5_sg4DhZZU4_k8US871oAWSvQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bus: imx-weim: support multiple address ranges per
 child node
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn, many thanks for the patch review, I really appreciate it !

On Wed, Dec 5, 2018 at 2:52 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Fri, Nov 30, 2018 at 03:56:23PM -0500, thesven73@gmail.com wrote:
> > From: Sven Van Asbroeck <TheSven73@googlemail.com>
> >
> > Ensure that timing values for the child node are applied to
> > all chip selects in the child's address ranges.
> >
>
> I'm not sure about that.  Shouldn't we have another child node for
> different chip select, something like below?
>
> &weim {
>         acme@0,0 {
>                 compatible = "acme,whatever";
>                 reg = <0 0 0x100>, <0 0x400000 0x800>;
>                 fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
>                                       0x00000000 0xa0000240 0x00000000>;
>         };
>
>         acme@1,400000 {
>                 compatible = "acme,whatever";
>                 reg = <1 0x400000 0x800>;
>                 fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
>                                       0x00000000 0xa0000240 0x00000000>;
>         };
>
> Shawn

I am submitting patches for a device that spans chip selects :(
And such a device needs multiple address changes with different chip selects.

Imagine we have an acme device, which contains a control and a fifo region,
on different chip selects:

&weim {
        acme@0 {
                compatible = "acme";
                reg = <0 0x0 0x100>, <1 0x0 0x100>;
        };
};

Now in probe we can access both regions:
int acme_probe(struct platform_device *pdev)
{
        control_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
        fifo_res =    platform_get_resource(pdev, IORESOURCE_MEM, 1);
        /* all ok */
}

But, if we have two separate child nodes, we also get two calls to probe(),
which assumes two devices on the bus, and that is incorrect:

&weim {
        acme@0 {
                compatible = "acme";
                reg = <0 0x0 0x100>;
        };
        acme@1 {
                compatible = "acme";
                reg = <1 0x0 0x100>;
        };
};

int acme_probe(struct platform_device *pdev)
{
        control_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
        /* next call always fails */
        fifo_res =    platform_get_resource(pdev, IORESOURCE_MEM, 1);
}

For my patchset, Rob Herring suggested I made changes to the imx-weim driver
to accommodate multi-chipselect devices.

See the conversation below between Rob Herring and myself:
https://lkml.org/lkml/2018/11/30/390

If you are not entirely satisfied with my patch, then perhaps you
could think of another way to support multi-chipselect devices?

Many thanks,
Sven
