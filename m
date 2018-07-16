Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D308CECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB6E208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB6E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeGPMHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:07:52 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:45384 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeGPMHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:07:51 -0400
Received: by mail-vk0-f68.google.com with SMTP id b78-v6so7460396vka.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMadaCnxyFkeKiav5z1+/iu5CWb7rw8Mi5nFwwqriow=;
        b=LcshrSDN/AIRBMt5wSGjRXRvsXbQEOdr3vQvnngoVsv3kt/1dmxkBFAtQe1K3u/tjB
         NhcXEbudXojSrtut2fQv9an3P2ufm7tX6cbCnXJAHO3yFxI9ePXsnWq2kRqyp1yosbT1
         cjWwVxvhMMSKlNeErmwvXSNkV3Zw8a/fIfraAIgcIttQOprlBMZw4JcQPw84CF0EQr+5
         nwwApltqzCzGFtkK/+qS0GiDfM2ciASBuAkRq5tRpnCsCnK01JtmEYhp4wJSwaALFTKS
         Om65Yd5Tf18RbUtRyHHeXLDiM2RhSyGxG1hS+dppXSqKrc3xtVQjqarnKz0mdP/ykNtB
         iCQA==
X-Gm-Message-State: AOUpUlHkQ3elw0ImgXSyGO84I8eIuNm5N4cE7s5uueNntqVbnJoGF9wm
        Jlf7VOQzsivv8S+SEyfnYW43FCru4PHLpb/VBrgCTCFG
X-Google-Smtp-Source: AAOMgpess9XD53XbFgyR81TcLMBJNL6X2QkkkFi/6b+vua/XffK0nA3WfCRQKItcsLXwPHswUuKVFKWH4QW0sJatOMs=
X-Received: by 2002:a1f:4a03:: with SMTP id x3-v6mr9227128vka.90.1531741246870;
 Mon, 16 Jul 2018 04:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180716113300.27032-1-geert@linux-m68k.org>
In-Reply-To: <20180716113300.27032-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Jul 2018 13:40:35 +0200
Message-ID: <CAMuHMdUy1N7kGOO3DvTeG-0Z2ETC4E4PAZnRk5RZpdqWK==fLA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.18-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 1:36 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.18-rc5[1] to v4.18-rc4[3], the summaries are:
>   - build errors: +93/-0

  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
adv7842.c: undefined reference to `__ucmpdi2':  => .text+0x600),
.text+0x18ae)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
alloc.c: undefined reference to `__ashldi3':  => .text+0xe3d8)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
attrib.c: undefined reference to `__ashrdi3':  => .text+0x4166),
.text+0x3694), .text+0x4162), .text+0x42f2)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
cadence_ttc_timer.c: undefined reference to `__lshrdi3':  =>
.init.text+0x1c6)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
cec-pin-error-inj.c: undefined reference to `__ashldi3':  =>
.text+0x5b4)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
dev-replace.c: undefined reference to `__ucmpdi2':  => .text+0x1878)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
dir.c: undefined reference to `__ashldi3':  => .text+0x4e82)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
direct-io.c: undefined reference to `__ashldi3': .text+0x1858) =>
.text+0x1076), .text+0x1858), .text+0x16de), .text+0x16e2),
.text+0x1880)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
dm-integrity.c: undefined reference to `__ashldi3':  => .text+0x4d4c)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
dm-verity-target.c: undefined reference to `__ashldi3':  =>
.text+0x12ec), .text+0x1880), .text+0x187c), .text+0x13a2),
.text+0x139e)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
dm-verity-target.c: undefined reference to `__lshrdi3':  =>
.text+0x180c), .text+0x12f8), .text+0x189c), .text+0x12fc),
.text+0x1810), .text+0x1898), .text+0x13b0), .text+0x13ac)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
dm-writecache.c: undefined reference to `__ashldi3':  => .text+0x19c4)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
dm-zoned-metadata.c: undefined reference to `__ashldi3':  =>
.text+0x3a40), .text.unlikely+0x44)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
dm-zoned-target.c: undefined reference to `__lshrdi3':  =>
.text+0x13f6), .text+0x1660), .text+0x10aa), .text+0x13f2)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
do_mounts_rd.c: undefined reference to `__ashldi3':  =>
.init.text+0x3e2)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
drm_ioctl.c: undefined reference to `__ucmpdi2':  => .text+0x1e4),
.text+0x94)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
extent-tree.c: undefined reference to `__ucmpdi2':  => .text+0x4ca2)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
extent_io.c: undefined reference to `__lshrdi3':  => .text+0x6bd0)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
extents.c: undefined reference to `__lshrdi3':  => .text+0x630),
.text+0x6ae), .text+0x6b2)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
file.c: undefined reference to `__ashldi3':  => .text+0x3812),
.text+0x3816), .text+0x2c9c)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
hdpvr-core.c: undefined reference to `__ashldi3':  => .text+0x478)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
inode.c: undefined reference to `__ashldi3':  => .text+0x1260)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
inode.c: undefined reference to `__ashrdi3':  => .text+0x24b2)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
journal.c: undefined reference to `__lshrdi3':  => .text+0x1394)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
kernel/futex.o: relocation truncated to fit: R_NDS32_25_PCREL_RELA
against `.text':  => (.fixup+0xb0), (.fixup+0xbc), (.fixup+0xaa),
(.fixup+0xc4), (.fixup+0x4), (.fixup+0xb6)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
mballoc.c: undefined reference to `__ashldi3':  => .text+0x20c8),
.text+0x20e4), .text+0x20cc), .text+0x20e8)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
mballoc.c: undefined reference to `__ashrdi3': .text+0x1bc2) =>
.text+0x209e), .text+0x1bc2), .text+0x20a2), .text+0x2062)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
mmio.c: undefined reference to `__lshrdi3': .init.text+0x60) =>
.init.text+0x64), .init.text+0x60), .init.text+0x58)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
namei.c: undefined reference to `__ashldi3':  => .text+0x2f50),
.text+0x2f4c), .text+0x3124), .text+0x2e24)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
nand_base.c: undefined reference to `__lshrdi3':  => .text+0x6320)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
nand_bbt.c: undefined reference to `__ashldi3':  => .text+0x15f0),
.text.unlikely+0x12e), .text.unlikely+0x132), .text+0x578),
.text+0x165e)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
nand_bbt.c: undefined reference to `__lshrdi3':  =>
.text.unlikely+0x11a), .text.unlikely+0x116), .text.unlikely+0xd0)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
nandsim.c: undefined reference to `__ashldi3':  => .init.text+0xdbe)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
nandsim.c: undefined reference to `__lshrdi3':  => .init.text+0xe5a),
.init.text+0xdd0), .init.text+0xe56), .init.text+0xdcc)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
onenand_base.c: undefined reference to `__ashldi3':  => .text+0x1098),
.text+0x109c), .text+0x1080)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
onenand_base.c: undefined reference to `__ashrdi3':  => .text+0x211c),
.text+0x215e), .text+0x2162), .text+0x244a)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
sharpslpart.c: undefined reference to `__lshrdi3':  =>
.text.unlikely+0x24), .text.unlikely+0x48), .text.unlikely+0x44)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
sidewinder.c: undefined reference to `__ashldi3':  =>
.text.unlikely+0x70)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
super.c: undefined reference to `__ashldi3':  => .text+0xfc70),
.text+0xfc74)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
super.c: undefined reference to `__ashrdi3': .text+0x6504) =>
.text+0xe038), .text+0x6504)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
super.c: undefined reference to `__lshrdi3':  => .text+0xfab8),
.text+0xfab4)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
super.c: undefined reference to `__ucmpdi2':  => .text+0x522c)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
sysfs.c: undefined reference to `__ashldi3':  => .init.text+0x1ca)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
tee_core.c: undefined reference to `__ucmpdi2':  => .text+0x34),
.text+0x11ac)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
timekeeping.c: undefined reference to `__ashldi3': .init.text+0x1ac)
=> .init.text+0x1ac), .init.text+0x144)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
timekeeping.c: undefined reference to `__lshrdi3': .init.text+0x1ec),
.init.text+0x1f0) => .init.text+0x1f0), .init.text+0x1ec),
.init.text+0x182), .init.text+0x17e)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
xfs_fsmap.c: undefined reference to `__ucmpdi2':  => .text+0xb80)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
xfs_ialloc.c: undefined reference to `__ashldi3':  => .text+0x3f68),
.text+0x3f6c), .text+0x3c6c)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
xfs_iomap.c: undefined reference to `__lshrdi3':  => .text+0x81c)
  + error: adv7842.c: undefined reference to `__ucmpdi2':  =>
.text+0x18aa), .text+0x5fc)
  + error: alloc.c: undefined reference to `__ashldi3':  => .text+0xe3d4)
  + error: attrib.c: undefined reference to `__ashrdi3':  => .text+0x3690)
  + error: cadence_ttc_timer.c: undefined reference to `__lshrdi3':
=> .init.text+0x1c2)
  + error: cec-pin-error-inj.c: undefined reference to `__ashldi3':
=> .text+0x5b0)
  + error: dev-replace.c: undefined reference to `__ucmpdi2':  => .text+0x1874)
  + error: dir.c: undefined reference to `__ashldi3':  => .text+0x4e7e)
  + error: direct-io.c: undefined reference to `__ashldi3':
.text+0x185c), .text+0x16a0), .text+0x16a4) => .text+0x16a0),
.text+0x185c), .text+0x1072), .text+0x16a4)
  + error: diskonchip.c: undefined reference to `__lshrdi3':  =>
.init.text+0x1f8)
  + error: dm-integrity.c: undefined reference to `__ashldi3':  => .text+0x4d48)
  + error: dm-verity-target.c: undefined reference to `__ashldi3':  =>
.text+0x12e8)
  + error: dm-writecache.c: undefined reference to `__ashldi3':  =>
.text+0x19c0)
  + error: dm-zoned-metadata.c: undefined reference to `__ashldi3':
=> .text+0x3a3c), .text.unlikely+0x40)
  + error: dm-zoned-target.c: undefined reference to `__lshrdi3':  =>
.text+0x10a6)
  + error: do_mounts_rd.c: undefined reference to `__ashldi3':  =>
.init.text+0x3de)
  + error: drm_ioctl.c: undefined reference to `__ucmpdi2':  =>
.text+0x1e0), .text+0x90)
  + error: extent-tree.c: undefined reference to `__ucmpdi2':  => .text+0x4c9e)
  + error: extent_io.c: undefined reference to `__lshrdi3':  => .text+0x6bcc)
  + error: extents.c: undefined reference to `__lshrdi3':  => .text+0x62c)
  + error: file.c: undefined reference to `__ashldi3':  => .text+0x2c98)
  + error: hdpvr-core.c: undefined reference to `__ashldi3':  => .text+0x474)
  + error: inode.c: undefined reference to `__ashldi3':  =>
.text+0x125c), .text+0x34ee)
  + error: inode.c: undefined reference to `__ashrdi3':  => .text+0x24ae)
  + error: journal.c: undefined reference to `__lshrdi3':  => .text+0x1390)
  + error: mballoc.c: undefined reference to `__ashrdi3':
.text+0x1c0e), .text+0x1bbe), .text+0x1c12) => .text+0x1c0e),
.text+0x205e), .text+0x1c12), .text+0x1bbe)
  + error: mmio.c: undefined reference to `__lshrdi3':
.init.text+0x5c) => .init.text+0x54), .init.text+0x5c),
.init.text+0x60)
  + error: namei.c: undefined reference to `__ashldi3':  => .text+0x2e20)
  + error: nand_base.c: undefined reference to `__lshrdi3':  => .text+0x631c)
  + error: nand_bbt.c: undefined reference to `__ashldi3':  =>
.text+0x574), .text+0x15ec)
  + error: nand_bbt.c: undefined reference to `__lshrdi3':  =>
.text.unlikely+0xcc)
  + error: nandsim.c: undefined reference to `__ashldi3':  => .init.text+0xdba)
  + error: onenand_base.c: undefined reference to `__ashldi3':  => .text+0x107c)
  + error: onenand_base.c: undefined reference to `__ashrdi3':  => .text+0x2118)
  + error: samsung_pwm_timer.c: undefined reference to `__lshrdi3':
=> .init.text+0x2e4)
  + error: sharpslpart.c: undefined reference to `__lshrdi3':  =>
.text.unlikely+0x20)
  + error: sidewinder.c: undefined reference to `__ashldi3':  =>
.text.unlikely+0x6c)
  + error: super.c: undefined reference to `__ashrdi3': .text+0x6500)
=> .text+0x6500), .text+0xe034)
  + error: super.c: undefined reference to `__ucmpdi2':  => .text+0x5228)
  + error: sysfs.c: undefined reference to `__ashldi3':  => .init.text+0x1c6)
  + error: tee_core.c: undefined reference to `__ucmpdi2':  =>
.text+0x11a8), .text+0x30), .text+0x144e)
  + error: timekeeping.c: undefined reference to `__ashldi3':
.init.text+0x1a8) => .init.text+0x1a8), .init.text+0x140)
  + error: xfs_fsmap.c: undefined reference to `__ucmpdi2':  => .text+0xb7c)
  + error: xfs_ialloc.c: undefined reference to `__ashldi3':  => .text+0x3c68)
  + error: xfs_iomap.c: undefined reference to `__lshrdi3':  => .text+0x818)

All nds32Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
