Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED6C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC8F214DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="zkrmy0Nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC8F214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933132AbeGCOqj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:46:39 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40764 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932724AbeGCOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:46:37 -0400
Received: by mail-lf0-f67.google.com with SMTP id y200-v6so1832061lfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EgBVftvHFAcPZKULRvm/dTyKsbZX/FGBIqViYkDOIro=;
        b=zkrmy0NnPnAqQeOTLoJ9HL3jCaPS0QIYyFu34xPGQFdTk4iDpY+T625C42h7QwhZrQ
         zNlk1at5vpbKtmLsio5V0tF+uRXVUvRFblQJjUiO094HXr+EBqOxMOiLopmMkhygMZVW
         O7VuxT8Aadp0M4XnaXfoymEtJylocr2cSVfJaYI1z2B7Ytkey9x4mg0wpeEGO66UNvRn
         +V1JLYAamI5QDolBbcSkJkcbE0zg/Hpb32RzrzbG1m24HejqgrjgrIeBGDjOC0nIuGig
         QdrcfAmsjvzJNSMrnA2AmQzoNhO7nTi3oUHCvBbNsZaVUDfWY17rYrOcht6uPBjg2dVG
         96HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EgBVftvHFAcPZKULRvm/dTyKsbZX/FGBIqViYkDOIro=;
        b=Qd04xjhqIcVM3/pqtEdZGFTnMx8BLSLcUM/GCETlQRv9NHbm8/c9L0PKQY8Pefu0n0
         Ztq6w61+0IHuClo58wLPTfZFAcnYDNH47owO3aE8+N9spjDbFXKvV9JXNjgl+T4twgOq
         c8hNp195T1R2ArE0x18oIClxafk/ZJz7pEY7ep4mrbWdR9R9V2DItYf0k8ELYixdadUm
         84G796GPzWG162YGIqC/JdUXk2KE734sAh8P1eY0ocqltw/asqHOE0/Ze7BLXMgrwoUV
         6HknTIG/e60dA4EANPRLFk+JGYMuuWuBy8WxeJMsToGUUNVRb24lBtN+GNQahcTcZ0Kg
         NjjA==
X-Gm-Message-State: APt69E0twkVsmnuVr52c0KqfU0gUohBgTG7XDXDc7dYF1IYIX/gkJknx
        QjfzcpIo61dlQNrihonFMksYyqc28sp/Pzwud2NYqQ==
X-Google-Smtp-Source: AAOMgpe4jvIanRhFw7UxYzXK6cIZPQjxnuq2RuTmkd84d6qAkoAmg7PdAhGdhxeEgsIhgd+Y1UArnbgd54xKQiVjwlc=
X-Received: by 2002:a19:5418:: with SMTP id i24-v6mr15662538lfb.34.1530629195853;
 Tue, 03 Jul 2018 07:46:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 07:46:34 -0700 (PDT)
X-Originating-IP: [99.152.116.91]
In-Reply-To: <20180703041321.k2ewqta76cnqhsmm@vireshk-i7>
References: <cover.1527244200.git.viresh.kumar@linaro.org> <f8a4e5c3062397736475ec599de730206846cb9b.1527244201.git.viresh.kumar@linaro.org>
 <CAL_JsqJRKMREfJ8LoDfuda8BU3g5Eq1AX5cPZGzO3uN3vUhrAQ@mail.gmail.com>
 <20180702232735.eocdrdfwyj37577h@localhost> <20180703041321.k2ewqta76cnqhsmm@vireshk-i7>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 3 Jul 2018 07:46:34 -0700
Message-ID: <CAOesGMjtFSVg1yu-9TAxXTTtvzGaUGn6P9-hnK5XrgHVFVHDOQ@mail.gmail.com>
Subject: Re: [PATCH 12/15] arm: dts: highbank: Add missing OPP properties for CPUs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 9:13 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 02-07-18, 16:27, Olof Johansson wrote:
>> On Mon, Jul 02, 2018 at 02:25:40PM -0600, Rob Herring wrote:
>> > On Fri, May 25, 2018 at 4:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > >
>> > > The OPP properties, like "operating-points", should either be present
>> > > for all the CPUs of a cluster or none. If these are present only for a
>> > > subset of CPUs of a cluster then things will start falling apart as soon
>> > > as the CPUs are brought online in a different order. For example, this
>> > > will happen because the operating system looks for such properties in
>> > > the CPU node it is trying to bring up, so that it can create an OPP
>> > > table.
>> > >
>> > > Add such missing properties.
>> > >
>> > > Fix other missing property (clock latency) as well to make it all
>> > > work.
>> > >
>> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> > > ---
>> > >  arch/arm/boot/dts/highbank.dts | 30 ++++++++++++++++++++++++++++++
>> > >  1 file changed, 30 insertions(+)
>> >
>> > Acked-by: Rob Herring <robh@kernel.org>
>> >
>> > ARM-SOC maintainers, Please apply this.
>>
>> Applied to next/dt.
>
> Thanks Olof.
>
> Can you also apply other patches in this series, that haven't been
> applied yet by SoC maintainers ? And same for the arm64 series..

This is the kind of patch that should be applied by the maintainers
for active platforms, where they have systems to test with and can
make sure you haven't regressed something on them.

For very low patch rate platforms we can apply directly through
maintainer acks, like in this case.

So, my recommendation is to repost the series to the maintainers.
Please don't patchbomb arm@kernel.org though, so keep us off of cc by
default (you can add our individual addresses if you want).


Thanks,

-Olof
