Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116227-5-1288088326271807600
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116226; b=Knzwxjp1J4AOTbOHODL3l+dNwU4xhbFmVU8nv1y8YvgKRZFSNI
    urFPe5ae51hFl1qq1kVD/zca5Aaw4sCXXqE09hesA3JEAMtIwVLmjzVJ0yFFMwyp
    WVLsZqNueCzLi0/zSaNK6FA6PjvXInZBsJLsFgoKxgCHIvT5rl3YpSp/Art2/6HT
    MlssQbvXiHnpPa4lbrtdCRWL0i5HwZWYFMLkikco4Q13cYHr3N6iu1wtTp5yIcRa
    w0g/X+yWQzX0CbJ6wBc4nM57jFjXDZJ07wp9jtyve3CVswZbZIR+zx2c/4wjuKL/
    xmGhCoSZJGf+5s8KxTSq2nu+cQXU60KIqlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525116226; bh=7L85p6XnmtCbiBbLpHKS47N5L76HfT
    TEyzkKHuKmYGk=; b=hy6v2A3en0hq3htrnG5Yz829Lbrk4//iFlP3H3JCcrYyIv
    E+pc2iK4xQ/ASwt2/XiorXmdBSB/0rAf+vi2mdNjm/kYe6wFf5ctyQGahGlZaZyP
    BN2UJ++Z5yjIk2s7VB7LTqvbxra10R1fPoiB3xmcYJtXx1C6caOdItfjx56nmCyg
    pquQ/zTvMHoIgx+F4wYS+fvt1srJqSAR4SO7yPGODHWRAPPSBwXCW18ZVzWOWCnk
    Tvvd1Pho9h6CpZ9jtLlK3jfDugnEBmlQyjqtfBi0pjeQ3iGhxGAQpVK4QDE6Ke3R
    r8f6WH0vP8W6G054pdSL6Oyo6ewFQDF2N0GTJE5w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK9AqdJNwmLyDErW/jerVF1a3ZlqOZ+Ef+Sk4mlb0ZsymqX2fL1AgN+ZN5KSlNokkdtTqLlOF3FpH7gNgqRa0fGhjqgom/6Er1dopFmbTBiMIni8W2Kx
    AdpXqtgr0TL2u625bnZHoUn0E4N1nfTnVB8TIppIYrN6wOLQVs5732TMqyNHo8XmRBoJEYfY9vURJQTxNIslmSob5TmqeWu94A99RTLkpoxsVxc7JEgDjE/z
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=vmN5MLnUJFoA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=pGLkceISAAAA:8 a=uBuKx8GwAAAA:8
    a=1XWaLZrsAAAA:8 a=EeMhvEcYAAAA:8 a=fxJcL_dCAAAA:8 a=2KMo9-giAAAA:8
    a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=QyXUC8HyAAAA:8 a=gVGD3344AAAA:8
    a=hD80L64hAAAA:8 a=AweM8bunQQmayc3p-DQA:9 a=m3vKfNzqF0QA:10 a=RdtxUbJDZeoA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=wZgZ3yaTFkxMEWn-yT5t:22
    a=X1EAwBm2vS_uL_oFwTEp:22 a=UeCTMeHK7YUBiLmz_SX7:22 a=xmb-EsYY8bH0VWELuYED:22
    a=xQEvYfgLW3QvObN0DhJi:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754860AbeD3TXo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754858AbeD3TXn (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:23:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D0622DA3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/25] 3.18.108-stable review
Date: Mon, 30 Apr 2018 12:23:07 -0700
Message-Id: <20180430183910.801976983@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.108-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.108-rc1
X-KernelTest-Deadline: 2018-05-02T18:39+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.108 release.
There are 25 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed May  2 18:39:02 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.108-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.108-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "perf tests: Decompress kernel module before objdump"

Ilya Dryomov <idryomov@gmail.com>
    libceph: validate con->state at the top of try_write()

Nicolin Chen <nicoleotsuka@gmail.com>
    ASoC: fsl_esai: Fix divisor calculation failure at lower ratio

Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>
    scsi: sd: Defer spinning up drive while SANITIZE is in progress

Dmitry Vyukov <dvyukov@google.com>
    kobject: don't use WARN for registration failures

Joakim Tjernlund <joakim.tjernlund@infinera.com>
    mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.

Joakim Tjernlund <joakim.tjernlund@transmode.se>
    mtd: cfi: cmdset_0001: Workaround Micron Erase suspend bug.

Joakim Tjernlund <joakim.tjernlund@transmode.se>
    mtd: cfi: cmdset_0001: Do not allow read/write to suspend erase block.

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device

David Henningsson <diwic@ubuntu.com>
    ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    tty: Use __GFP_NOFAIL for tty_ldisc_get()

Tony Lindgren <tony@atomide.com>
    tty: n_gsm: Fix DLCI handling for ADM mode if debug & 2 is not set

Tony Lindgren <tony@atomide.com>
    tty: n_gsm: Fix long delays with control frame timeouts in ADM mode

Michael S. Tsirkin <mst@redhat.com>
    virtio_console: free buffers after reset

Michael S. Tsirkin <mst@redhat.com>
    virtio: add ability to iterate over vqs

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Skip broken EU on Dell dock USB-audio

Ravi Chandra Sadineni <ravisadineni@chromium.org>
    USB: Increment wakeup count on remote wakeup.

Kamil Lulko <kamilx.lulko@intel.com>
    usb: core: Add quirk for HP v222w 16GB Mini

Kyle Roeschley <kyle.roeschley@ni.com>
    USB: serial: cp210x: add ID for NI USB serial console

Vasyl Vavrychuk <vvavrychuk@gmail.com>
    USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: vhci_hcd: Fix usb device and sockfd leaks

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: usbip_host: fix to hold parent lock for device_attach() calls

Lukas Czerner <lczerner@redhat.com>
    ext4: fix bitmap position validation

Theodore Ts'o <tytso@mit.edu>
    ext4: add validity checks for bitmap block numbers

Theodore Ts'o <tytso@mit.edu>
    ext4: set h_journal if there is a failure starting a reserved handle


-------------

Diffstat:

 Makefile                            |  4 +--
 drivers/char/virtio_console.c       | 49 ++++++++++++++++++-------------------
 drivers/mtd/chips/cfi_cmdset_0001.c | 33 +++++++++++++++++++++----
 drivers/mtd/chips/cfi_cmdset_0002.c |  9 ++++---
 drivers/scsi/sd.c                   |  2 ++
 drivers/tty/n_gsm.c                 | 23 ++++++++++++++++-
 drivers/tty/tty_ldisc.c             | 11 ++++-----
 drivers/usb/core/hcd.c              |  1 +
 drivers/usb/core/hub.c              | 10 +++++++-
 drivers/usb/core/quirks.c           |  3 +++
 drivers/usb/serial/cp210x.c         |  1 +
 drivers/usb/serial/ftdi_sio.c       |  3 ++-
 drivers/usb/usbip/stub_main.c       |  5 ++++
 drivers/usb/usbip/usbip_common.h    |  2 +-
 fs/ext4/balloc.c                    | 17 +++++++++++--
 fs/ext4/ialloc.c                    |  8 +++++-
 fs/jbd2/transaction.c               |  1 +
 include/linux/mtd/flashchip.h       |  1 +
 include/linux/virtio.h              |  3 +++
 lib/kobject.c                       | 12 ++++-----
 net/ceph/messenger.c                |  7 ++++++
 sound/core/pcm_native.c             |  1 +
 sound/core/seq/oss/seq_oss_synth.c  | 12 ++++++---
 sound/soc/fsl/fsl_esai.c            |  7 ++++++
 sound/usb/mixer_maps.c              |  3 +++
 tools/perf/tests/code-reading.c     | 20 +--------------
 26 files changed, 170 insertions(+), 78 deletions(-)
