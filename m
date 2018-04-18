Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbeDROPW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:15:22 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:49097 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751580AbeDROPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:15:20 -0400
X-Google-Smtp-Source: AIpwx49PKEUVIwDNAbHTlTGbfhsitxJ/RlUk8GrH399RnqXfgFx0VdN8HMaZAIzL5i9Xmkn5G2Lyi9Is3dlNbVPZyQI=
MIME-Version: 1.0
In-Reply-To: <20180109133412.uyai4s6vfnh37hn2@flea>
References: <20171219210523.10428-1-kevans91@ksu.edu> <20171221145512.llxvzkcrjpquhczi@flea.lan>
 <CACNAnaE9GiVTXD-TV1xXyBJKtTGKpdA6n0REk6a=qm218EgHbg@mail.gmail.com>
 <20171221152630.2vf57x5o2yi5sv3n@flea.lan> <20171221190903.56ebae536acf51401c63802c@bidouilliste.com>
 <20171222083508.dfcp6egfvxykmogg@flea.lan> <20171222110727.520df7394234f6a5dc0b9ec0@bidouilliste.com>
 <CAGb2v64mf-ihyOs-WJZuVa4Yib3Szp90RZu_a1EeQ1LJXnoXEQ@mail.gmail.com>
 <20180104140119.5pyfihp4zs2poz35@flea.lan> <CACNAnaHOuPH05hsJ-jt1135-Giknb-DOuvjeQRSGVR2L7Xc-Cg@mail.gmail.com>
 <20180109133412.uyai4s6vfnh37hn2@flea>
From: Kyle Evans <kevans@freebsd.org>
Date: Wed, 18 Apr 2018 09:05:19 -0500
X-Gmail-Original-Message-ID: <CACNAnaEyKztSt_SO25e+VcmyN=fdGTVbpooWSu891ueY6xvh-g@mail.gmail.com>
Message-ID: <CACNAnaEyKztSt_SO25e+VcmyN=fdGTVbpooWSu891ueY6xvh-g@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: sunxi: Add sid for a83t
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Emmanuel Vadot <manu@bidouilliste.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 9, 2018 at 7:34 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Jan 08, 2018 at 09:30:57AM -0600, Kyle Evans wrote:
>> On Thu, Jan 4, 2018 at 8:01 AM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Fri, Dec 22, 2017 at 06:11:52PM +0800, Chen-Yu Tsai wrote:
>> >> On Fri, Dec 22, 2017 at 6:07 PM, Emmanuel Vadot <manu@bidouilliste.com> wrote:
>> >> > On Fri, 22 Dec 2017 09:35:08 +0100
>> >> > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>> >> >
>> >> >> On Thu, Dec 21, 2017 at 07:09:03PM +0100, Emmanuel Vadot wrote:
>> >> >> >
>> >> >> >  Hi Maxime,
>> >> >> >
>> >> >> > On Thu, 21 Dec 2017 16:26:30 +0100
>> >> >> > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>> >> >> >
>> >> >> > > Hi,
>> >> >> > >
>> >> >> > > On Thu, Dec 21, 2017 at 09:19:24AM -0600, Kyle Evans wrote:
>> >> >> > > > On Thu, Dec 21, 2017 at 8:55 AM, Maxime Ripard
>> >> >> > > > <maxime.ripard@free-electrons.com> wrote:
>> >> >> > > > > Hi Kyle,
>> >> >> > > > >
>> >> >> > > > > On Tue, Dec 19, 2017 at 03:05:23PM -0600, kevans91@ksu.edu wrote:
>> >> >> > > > >> Allwinner a83t has a 1 KB sid block with efuse for security rootkey and
>> >> >> > > > >> thermal calibration data, add node to describe it.
>> >> >> > > > >>
>> >> >> > > > >> a83t-sid is not currently supported by nvmem/sunxi-sid, but it is
>> >> >> > > > >> supported in an external driver for FreeBSD.
>> >> >> > > > >>
>> >> >> > > > >> Signed-off-by: Kyle Evans <kevans91@ksu.edu>
>> >> >> > > > >
>> >> >> > > > > The patch looks fine in itself, but we've had a number of issues with
>> >> >> > > > > the register layout (and access patterns) in the past, so I'd rather
>> >> >> > > > > have something that works in Linux too if possible.
>> >> >> > > >
>> >> >> > > > I have a patch that I think should make it work fine on Linux [1], but
>> >> >> > > > I'm afraid I have little to no capability to test it myself and so I
>> >> >> > > > did not add it as well.
>> >> >> > > >
>> >> >> > > > I do know that the rootkey is offset 0x200 into the given space [2],
>> >> >> > > > as is the case with the H3, and that the readout quirk is not needed.
>> >> >> > > > I wasn't 100% sure that the a83t has 2Kbit worth of efuse space as the
>> >> >> > > > H3, but I do know that thermal data can be found at 0x34 and 0x38 in
>> >> >> > > > this space.
>> >> >> > >
>> >> >> > > Then maybe we should leave it aside until someone takes some time on
>> >> >> > > the A83t.
>> >> >> >
>> >> >> >  Take some time on the Linux driver and do not apply this patch for
>> >> >> > now you mean ?
>> >> >>
>> >> >> Yep.
>> >> >>
>> >> >> Maxime
>> >> >
>> >> >  Since linux doesn't have the compatible in it's driver what would
>> >> > be the harm to add the node in the DTS ? If a quirks is needed because
>> >> > some region is weird this would go in the driver right ? I don't see a
>> >> > technical problem for adding this node right now.
>> >> >  If Kyle confirm the lenght of the region and that no quirk is needed
>> >> > will it be enough ?
>> >>
>> >> I guess I wasn't very clear. I'm OK with the patch going in. The device
>> >> node currently says nothing about how much efuse space there is. The
>> >> memory region covers that and the control section, and the size matches
>> >> what the memory map says.
>> >>
>> >> The size and offset of the efuse space would be dealt with in the driver.
>> >
>> > Let's merge it then.
>> >
>> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
>> What does the timeline for these things normally look like? I'm new to
>> these parts. =)
>
> We're one week away from the merge window, so it's a bit late for it
> to be merged in 4.16, but it'll be in 4.17.
>
> Maxime
>

Hi,

It's been two months and this still hasn't quite landed in
sunxi/for-next. =( May I ask the status on this?

Thanks,

Kyle Evans
