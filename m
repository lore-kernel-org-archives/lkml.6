Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1913331-1521038162-2-14238837786625574580
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, SUSPICIOUS_RECIPS 2.51, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521038161; b=XsmJ8fbDH6r0Q2t+kjPOuKCe4lV5F5PHQ2xL9jlTpNieL1K
    0ymnZu3Bco89Qok+8+e5xJ1XV5L4EYNaScJjbO0Fw7UGqqzWJRclzUmhzW3qtaLk
    lTRl5BSYxWuGHBkQmFr3CkiXegMnKAbPsooRQ4+Mivyo7tnS1DrYrhbBajSQiGVv
    9KIQc7k+J+zP6qozJPsF/L6CkXBE6kUX9XYjQHvS3i8ksw4LENYF5C4+HHYK/VSH
    YSjBkBFYkwIx8CmyXyTZcu3VAhvTEJ+PTuESvw04oRe5Ra3xnnnIpSiurHfmvkKM
    DN5Bm53bvwuGln0bV84okhMh68HkFgG/o0fPpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521038161; bh=bjPMnSXxCRAMTU46D36VIE/lJg
    1GtaFFN2dXDf4Ad08=; b=FHeKdb2Y4OEKwpQikiPq8dFeYnkBO6eJayCfcJsBdK
    sn9kUJ0KNauabLlop6BaSE1yJvHfBlqruRqAKuI40INbEJaePZhOPJjUeq/3DuUa
    skf6l7HuogOMK8zlr77p6zQlcwh+GnXiz2k5/JWBltVEDXQioFlmhZoJ6fU7u/Up
    x7zzm9T/pi6XEATVdJ+YHLKCUPwp/OmiNWlchBWqU6OevkOQcxkNf9o2zp1zS9b1
    Ugayuc9cBnR3nYMphh6WdAggZVTwES/cPzvdNmt+EYlUs7BGbEnaqEh6dshqytwZ
    EhaICEybGI3d+AD2NOXaPPGcdfovRKsB+5v0+XdE6BbA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeCNOfv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 10:35:51 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44881 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNOfo (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 10:35:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 00/16] remove eight obsolete architectures
Date: Wed, 14 Mar 2018 15:34:59 +0100
Message-Id: <20180314143529.1456168-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:WInKuzsl5E+V3c9AlxLSSxc+4ZGknT/OL6sbFGTOOKUoIWUHPce
 sOunIkU3WA3yS4K2U7KLuM21G9io/7RdSDfXqf1g08L51uCkoCyAjOMiXI4kUVcEF0/FqP/
 umDnF0uQsHtMOXgS1AiyzYPQ6W0JczwHRAY9QiiD/KUW+z5A+Vgixyn6TUIYx2uOcgiAjdC
 CrnI3DG9ch7X4/hA6MvHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wVHTYZy5nis=:leV/QOsRy+klt9pr0rr1GX
 0OpznBJ2TCgyn2XksizOCFLzDVV4U/maXG7iVijGIl/x2acLsLVbak981yRF0crwRhWM8VL0Y
 FmfTMV6G+Q+G/zGSZrMnuuRRmANd7hhyBBHjGVRlAJGdhrtgYXkTckB1A6KhY4dNJAX3agErt
 bULJRS0bBJY6VJFQz8aMgywVmctdOqlczTe3BJXyqcwCgssCKlZOlO6T2cbiBqJ1DTSVHQ7/Q
 yTH6O1t8GG6up8dacDsBihCPydN60UQIFzzNLQbEiH7hu83SIoXLGOXz6giGihUAh57L+1N3e
 KTeNMmlP8bvAwDBeOFoklj7K4SfHURuw6oGI059MQdksufa6i+Bh7VIhnHzLGoRcxJWNdkIAq
 6VBsOvp6WejaRqyrLdJ7Nm3CtReHmVyYYAtLB67+qQDv4CabeDWc6+TUpXMRNpb/CxSUhxPV8
 8EKWLg6tj+KuPiN7CO1Bknjxd3ALym6/8jHpNldZfOGVtMNYVsaFXeliEcOkRgQ0lte/F3w9L
 ryEcNNLHfTxbOGwpVp5pxgdmsL+N6nLM0yk9lfSmv3SbFD2zWtctbMSmpDHmr5Oi0Gw52NV/Z
 6Ai4bhFh5RCMdMqrp2bBL/DZMELXajKyorZcSTKuU+m3voOi/7c8boZFypspk6JnsARVMsojS
 QyAKMdF6waH9y8HWB45OYKbFtvNeo09G5Yx8t7ZRhnzsQFuHYP9fK6ZEcxxqPDh8AZEgz/PtD
 z7VWzn0Q/J5LOdpyygQ1C15sKWOO8zIdqI277Q==
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Here is the collection of patches I have applied to my 'asm-generic' tree
on top of the 'metag' removal. This does not include any of the device
drivers, I'll send those separately to a someone different list of people.

The removal came out of a discussion that is now documented at
https://lwn.net/Articles/748074/

Following up from the state described there, I ended up removing the
mn10300, tile, blackfin and cris architectures directly, rather than
waiting, after consulting with the respective maintainers.

However, the unicore32 architecture is no longer part of the removal,
after its maintainer Xuetao Guan said that the port is still actively
being used and that he intends to keep working on it, and that he will
try to provide updated toolchain sources.

In the end, it seems that while the eight architectures are extremely
different, they all suffered the same fate: There was one company in
charge of an SoC line, a CPU microarchitecture and a software ecosystem,
which was more costly than licensing newer off-the-shelf CPU cores from
a third party (typically ARM, MIPS, or RISC-V). It seems that all the
SoC product lines are still around, but have not used the custom CPU
architectures for several years at this point.

      Arnd

Arnd Bergmann (14):
  arch: remove frv port
  arch: remove m32r port
  arch: remove score port
  arch: remove blackfin port
  arch: remove tile port
  procfs: remove CONFIG_HARDWALL dependency
  mm: remove blackfin MPU support
  mm: remove obsolete alloc_remap()
  treewide: simplify Kconfig dependencies for removed archs
  asm-generic: siginfo: remove obsolete #ifdefs
  Documentation: arch-support: remove obsolete architectures
  asm-generic: clean up asm/unistd.h
  recordmcount.pl: drop blackin and tile support
  ktest: remove obsolete architectures

David Howells (1):
  mn10300: Remove the architecture

Jesper Nilsson (1):
  CRIS: Drop support for the CRIS port

Dirstat only (full diffstat is over 100KB):

   6.3% arch/blackfin/mach-bf548/include/mach/
   4.5% arch/blackfin/mach-bf609/include/mach/
  26.3% arch/blackfin/
   4.1% arch/cris/arch-v32/
   5.6% arch/cris/include/arch-v32/arch/hwregs/iop/
   4.1% arch/cris/include/arch-v32/mach-a3/mach/hwregs/
   4.7% arch/cris/include/arch-v32/
   7.8% arch/cris/
   5.6% arch/frv/
   5.5% arch/m32r/
   7.0% arch/mn10300/
   7.6% arch/tile/include/
   6.4% arch/tile/kernel/
   0.0% Documentation/admin-guide/
   0.0% Documentation/blackfin/
   0.0% Documentation/cris/
   0.0% Documentation/devicetree/bindings/cris/
   0.0% Documentation/devicetree/bindings/interrupt-controller/
   2.8% Documentation/features/
   0.5% Documentation/frv/
   0.0% Documentation/ioctl/
   0.0% Documentation/mn10300/
   0.0% Documentation/
   0.0% block/
   0.0% crypto/
   0.0% drivers/ide/
   0.0% drivers/input/joystick/
   0.0% drivers/isdn/hisax/
   0.0% drivers/net/ethernet/davicom/
   0.0% drivers/net/ethernet/smsc/
   0.0% drivers/net/wireless/cisco/
   0.0% drivers/pci/
   0.0% drivers/pwm/
   0.0% drivers/rtc/
   0.0% drivers/spi/
   0.0% drivers/staging/speakup/
   0.0% drivers/usb/musb/
   0.0% drivers/video/console/
   0.0% drivers/watchdog/
   0.0% fs/minix/
   0.0% fs/proc/
   0.0% fs/
   0.0% include/asm-generic/
   0.0% include/linux/
   0.0% include/uapi/asm-generic/
   0.0% init/
   0.0% kernel/
   0.0% lib/
   0.0% mm/
   0.0% samples/blackfin/
   0.0% samples/kprobes/
   0.0% samples/
   0.0% scripts/mod/
   0.0% scripts/
   0.0% tools/arch/frv/include/uapi/asm/
   0.0% tools/arch/m32r/include/uapi/asm/
   0.0% tools/arch/mn10300/include/uapi/asm/
   0.0% tools/arch/score/include/uapi/asm/
   0.0% tools/arch/tile/include/asm/
   0.0% tools/arch/tile/include/uapi/asm/
   0.0% tools/include/asm-generic/
   0.0% tools/scripts/
   0.0% tools/testing/ktest/examples/
   0.0% tools/testing/ktest/

Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-rtc@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
