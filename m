Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeBKLah (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 06:30:37 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40232 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbeBKLaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 06:30:35 -0500
X-Google-Smtp-Source: AH8x227+ZO0UupJ8zg8A6RgzdtPQNJNLR/xuPpfaF2Z+QWtDXpyWeUQfC6bB8G7igoPfWlzyAI4WcA==
Message-ID: <1518348631.1342.1.camel@gmail.com>
Subject: Re: [PATCH 0/3] Fix broken bananapi m2 devicetree/regulators
From: Philipp Rossak <embed3d@gmail.com>
To: Sergey Suloev <ssuloev@orpaltech.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Sun, 11 Feb 2018 12:30:31 +0100
In-Reply-To: <45fb86c9-2218-d00d-1952-6b79f9101049@orpaltech.com>
References: <20180209175236.21215-1-embed3d@gmail.com>
         <160b60e2-6e50-0d63-e6ac-b67e10317e12@orpaltech.com>
         <d3fcc9d2-f2e6-189c-529f-890f2afdd837@gmail.com>
         <40887d4b-0fb0-239e-e5a9-1a87f82946c2@orpaltech.com>
         <da8909da-4eea-0fdf-e104-4442f7986455@gmail.com>
         <45fb86c9-2218-d00d-1952-6b79f9101049@orpaltech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, den 11.02.2018, 10:55 +0300 schrieb Sergey Suloev:
> On 02/11/2018 01:07 AM, Philipp Rossak wrote:
> > 
> > 
> > On 10.02.2018 22:08, Sergey Suloev wrote:
> > > On 02/11/2018 12:01 AM, Philipp Rossak wrote:
> > > > Hey Sergey,
> > > > 
> > > > Thanks for mentioning, but I think the problem has nothing to
> > > > do 
> > > > with those patches. I tested them with the v4.15.0 Kernel since
> > > > this 
> > > > is the last stable release and we are right now in the merging
> > > > window.
> > > > 
> > > > I tested the latest mainline, without those patches and the
> > > > kernel 
> > > > is not booting (I can't see any uart output).
> > > > 
> > > > Thanks,
> > > > Philipp
> > > > 
> > > > On 10.02.2018 14:56, Sergey Suloev wrote:
> > > > > On 02/09/2018 08:52 PM, Philipp Rossak wrote:
> > > > > > This patchseries fixes the bananapi m1 devicetree, to be
> > > > > > able to 
> > > > > > boot again.
> > > > > > The first two patches update/improve the devicetree and the
> > > > > > last 
> > > > > > patch adds
> > > > > > all missing regulators.
> > > > > > 
> > > > > > Regards,
> > > > > > Philipp
> > > > > > 
> > > > > > Philipp Rossak (3):
> > > > > >    arm: dts: sun6i: a31s: bpi-m2: update mmc supply nodes
> > > > > >    arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
> > > > > >    arm: dts: sun6i: a31s: fix: bpi-m2: add missing
> > > > > > regulators
> > > > > > 
> > > > > >   arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 70 
> > > > > > +++++++++++++++++++++++-
> > > > > >   1 file changed, 67 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > 
> > > > > patches are not working
> > > > > 
> > > > > Thanks
> > > > > 
> > > 
> > > same problem, but after applying the patches my device is till
> > > hanging.
> > > 
> > > 
> > 
> > Can you please share a bootlog? Here is mine [1]. As you can see
> > I'm 
> > able to boot.
> > I build it with this branch [2]. For testing you should replace
> > the 
> > dtb and the uImage/zImage
> > 
> > Philipp
> > 
> > 
> > [1]: https://pastebin.com/mVjv3LDf
> > [2]: 
> > https://github.com/embed-3d/linux/tree/testing/bpi-m2-regulator-tes
> > t-2
> 
> My dmesg is very similar to yours unless it hangs on the last line
> [1]. 
> For this test I used kernel from tag v4.15 with no additional
> patching.
> 
> [1] https://pastebin.com/3a6bk5Dk
> 
> 

For me it looks like you have a different kernel and also an different
dtb that you patch! And you are applying also a fixup script.
These patches should be applied on top of linux mainline. 

fixup script:
Applying kernel provided DT fixup script (sun6i-a31s-fixup.scr)


Linux versions:
4.15.0-00003-g1bbe5edde691   vs   4.15.0-sunxi-dirty

In addition to that you are also booting into fb/hdmi.

If you use my branch (uImage and dtb) and replace the current boot.cmd
with this (to get the boot.scr you need to use mkimage) it should work:

setenv bootargs console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait
panic=10
load mmc 0:1 0x43000000 ${fdtfile} || load mmc 0:1 0x43000000
boot/${fdtfile}
load mmc 0:1 0x42000000 uImage || load mmc 0:1 0x42000000 boot/uImage
bootm 0x42000000 - 0x43000000
