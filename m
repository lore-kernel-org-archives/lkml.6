Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeEQSDK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:03:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39098 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeEQSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:03:07 -0400
X-Google-Smtp-Source: AB8JxZpKMDvA23o2zNsMvy+MzfWU3R+i2WVZ35ChlhnaH5qULKdWgHnY6EjNvuLe8lAe8d2InMRZfd9P1HvbaNqELNI=
MIME-Version: 1.0
In-Reply-To: <20180517170656.1f746914@canb.auug.org.au>
References: <20180517170656.1f746914@canb.auug.org.au>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 17 May 2018 23:33:05 +0530
Message-ID: <CA+G9fYsJ01fWgD1ER1s46VNtHG57dZ26javkLtqwftjQTnA=rw@mail.gmail.com>
Subject: Re: linux-next: Tree for May 17
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 May 2018 at 12:36, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> News: I will not be doing any linux-next releases between Friday 18 May
> and Friday 25 May inclusive.
>
> Changes since 20180516:
>
> New trees: devicetree-fixes
>
> The kbuild tree still had its build failure for which I applied a patch.
>
> The mvebu tree gained a conflict against the arm-soc tree.
>
> The renesas tree gained conflicts against the mvebu tree.
>
> The net-next tree gained a conflict against the vfs tree.
>
> The drm tree still had its build failure for which I applied a patch.
>
> The usb-gadget tree gained a conflict against the usb tree.
>
> The staging tree gained a conflict against the v4l-dvb tree.
>
> The akpm tree gained a conflict against the vfs tree.
>
> Non-merge commits (relative to Linus' tree): 7398
>  7852 files changed, 294207 insertions(+), 302289 deletions(-)
>
> ----------------------------------------------------------------------------
>
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
>
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There are also quilt-import.log and merge.log
> files in the Next directory.  Between each merge, the tree was built
> with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
> multi_v7_defconfig for arm and a native build of tools/perf. After
> the final fixups (if any), I do an x86_64 modules_install followed by
> builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
> ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
> and sparc64 defconfig. And finally, a simple boot test of the powerpc
> pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Linux-20180517 - arm64 build failed.
Build failed for HiKey, Juno and dragonboard 410c.

Build failed log:
---------------------
  CC [M]  drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.o
drivers/gpu/drm/rcar-du/rcar_du_vsp.c: In function
 'rcar_du_vsp_plane_atomic_duplicate_state':
drivers/gpu/drm/rcar-du/rcar_du_vsp.c:325:6: error:
 'struct rcar_du_vsp_plane_state' has no member named 'alpha'
  copy->alpha = to_rcar_vsp_plane_state(plane->state)->alpha;
      ^~
drivers/gpu/drm/rcar-du/rcar_du_vsp.c:325:53: error:
 'struct rcar_du_vsp_plane_state' has no member named 'alpha'
  copy->alpha = to_rcar_vsp_plane_state(plane->state)->alpha;
                                                     ^~
scripts/Makefile.build:311: recipe for target
 'drivers/gpu/drm/rcar-du/rcar_du_vsp.o' failed
make[6]: *** [drivers/gpu/drm/rcar-du/rcar_du_vsp.o] Error 1
make[6]: *** Waiting for unfinished jobs....
  CC [M]  drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.o
  CC [M]  net/bluetooth/mgmt_util.o
scripts/Makefile.build:552: recipe for target 'drivers/gpu/drm/rcar-du' failed
make[5]: *** [drivers/gpu/drm/rcar-du] Error 2

Complete log link:
------------------------
https://ci.linaro.org/job/openembedded-lkft-linux-next/DISTRO=rpb,MACHINE=juno,label=docker-stretch-amd64/263/console
