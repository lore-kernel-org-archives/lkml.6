Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBF9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA364222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPkdxirG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfBMFqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 00:46:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42289 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfBMFqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 00:46:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so807223lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 21:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PeCBPDtNKEuaDKuiaHAzR3WaJUZOBwZPqqRsoj6cyhI=;
        b=UPkdxirGr+HslQwZfW7aZGsFIjX/hlnjhkEgIOZjSq/gGk0dL7x/rGp/35KCQTsyfi
         E0UcpVCn0e4A0Knks+0AXHnTnFHmXE2DUr8IBYqPIidXClhRwzHTU4SbMg/ccvpevDCn
         fn6oLBF8kAgU+lV2Ig2XWO1F2HOeFkgps4lxF/J5UzMZRDxETvMwBLRh69Z0NdDuPaA/
         a2VnxY9l6w31IMeZC83IQyv8LQZOR7nisU+gLkg8Om2nuSpjIIjxx2Y7fwyEglqo4yxA
         dkPwsCnSOqabvbmxTAdhTazgU7qwobUmqv3awExjwmof94h7yFDxkOuB5ve84T3Yq3fl
         M6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeCBPDtNKEuaDKuiaHAzR3WaJUZOBwZPqqRsoj6cyhI=;
        b=fNL4Rc081wmCzi8xDMEn+yG8W8N5KTpSP7L478NE1EFug3DMhqdIanoTN65cOj9uFN
         ZiTFK5o6nIViKjV1HwF8s+KqmtLbuc3kjDm7JI6wlZhLchygyFqI/o7l5Yq5bzMsBEon
         yBdSkyiEWvBmiAFRdnD4VO36Kr78NJmkGFra6eDHBir04AC+XJplNe5ZHKHXUOqT4lUa
         aIgy3fkdHHOk4I+VvkszfU9fyq+4TrplSZiuR88lmt+fjjjOEn49ywWIZ5u8TcoKLKYd
         PlfZBA2s57ogGkJYrzRL9N0pZXCJzHCVVmvrMaiI8/5WImmDVYOgmdlThD3DlNTlnV0E
         3Jrw==
X-Gm-Message-State: AHQUAubzV7vjsA24OgboHFlWUgJ8fFxjsIlpMqg2l4aUNRVCbq9ncNuo
        RFp7PQhyAl2JnOv5jAClYHIKh9cqWH82ULVhg/gh+w==
X-Google-Smtp-Source: AHgI3Iamku4Gk6WwnAlQTQH0P3xvFkH9o1Kpoob1PmQ254v3FRny5b5BJ2MVBR1/ydD7UCVLB1jrXDy9s0tm0TxPsxo=
X-Received: by 2002:a19:5205:: with SMTP id m5mr4613271lfb.61.1550036764803;
 Tue, 12 Feb 2019 21:46:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548052878.git.baolin.wang@linaro.org> <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
 <CAMz4kuLotnNom9kx2EmdfVEb+gvWfEbxoh6+hiqk87EjmtYJwA@mail.gmail.com>
 <20190201130519.GH20797@sirena.org.uk> <CAMz4kuJdPts31Ak-H=VAivvoqqPtxO5M1RdqrNPwTLT5d1h_7w@mail.gmail.com>
 <20190212122035.GA20635@sirena.org.uk>
In-Reply-To: <20190212122035.GA20635@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 13 Feb 2019 13:45:53 +0800
Message-ID: <CAMz4kuLCA2d0aRf4r7-F6w7q58F4Do-z5weTXNHYVvvJ4Acegg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 at 20:20, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Feb 12, 2019 at 04:40:10PM +0800, Baolin Wang wrote:
> > On Fri, 1 Feb 2019 at 21:05, Mark Brown <broonie@kernel.org> wrote:
>
> > > You can just list all the individual device names in the of_match_table
> > > for the MFD and then it can bind to any of them.  You can always map
> > > them onto the same behaviour in the MFD driver if they are identical
> > > from a software point of view.
>
> > If I understood correctly, as you suggested, we should add new
> > mfd_cell groups to list all different PMICs' device names. Something
> > like:
>
> I do think this is a good idea (registering the components of the MFD
> using mfd_cell), though it wasn't quite the point I was making.  Having
> individual device names matters less for Linux-internal names like this.
>
> > But from my point, they are just some meaningless duplication, and
> > will waste lots of code there.
>
> I was more thinking of the of_match table that has the IDs that appear
> in DT - they're the one that's the ABI.  Look at something like wm8994
> where the driver has several IDs listed in the main table then selects
> function drivers based on that.

Yes, we can use id_table to populate the PMIC child devices, but some
child devices need use the device node to get some resources which are
described in DT, so we must specify the of_compabible member of
mfd_cell. That means we should use compatible string of the
of_match_table to populate the child devices.

So the problem is still there, we should expand the mfd_cell groups to
list all device names, but just some meaningless duplication.




--
Baolin Wang
Best Regards
