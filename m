Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZogQcWXCNwSAX5ai+20Iz5vtElXcfuqyszqO3uKrvPw+kVaDg7TFYJWEcMb4TriQWbZ2mMC
ARC-Seal: i=1; a=rsa-sha256; t=1525116355; cv=none;
        d=google.com; s=arc-20160816;
        b=ij3e6VwkIdRHbHc+PYgtsvJKEb5S8TqLcDaghXZj/UZ9r5WhbBN2WrDmNFl8NcZnkH
         d3GU81dMah4Xwi9WqPOqvWqCR66xnnh2OjsU2wVcAaKJd5fmy8dwmREr8mY7W6If9Fmi
         jbs5tXoFMaTA+Eem3E9P/BUdrk5EhvIgdzFT7WOGYQAcvJ/6fZXLwcRmIxs0Ki0lFWwB
         f8f0eR07QTkGO42kgkiaw4ijznvQkmnVTdif1kKz1w8KqlAee13h7k/a6py0d74GpzNz
         delrYZ+0OjiIbieB/1fx2/79QKIO1Io7Hy3vWENrQxJq8h1fkSMsoIGLzI+fsPgxn785
         eicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=qALgvHywLzkaklSbAJNRZMmyPmG6hAEesbVKHk0LnqU=;
        b=VzvLBD/tiaVVGZ+pl/oZcK2A4c3/IvjEpSPiGav+dtOHkDP3s5YfIoVc2ISlWHaJSI
         jWVSW/o2UFq1LnDqmWIjf41QRETmr6/R/7AZFYhDPv1NdEUFSp7lr1w9GuE20WQra0l0
         TuR/SCOOiCJdmkPF9qf69oLVa/q9xcnfqRRqf7R90fhacNZra+ImLEw9jXFCIHjiD6VZ
         XTdlDaOQ9u5qd7Nm9BoH2RkJFhvxbiZUhhiddKeKdaA69VGFsg+sC1arD4umpUEfOQjo
         ubSjl1bGNxbtkQDLU7Bl2vrjg2wD4LKGD6DHEhw6UuvUPiUhysnQYS/Q0pVJZAsJJRah
         pSjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7999422DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.4 00/44] 4.4.131-stable review
Date: Mon, 30 Apr 2018 12:24:11 -0700
Message-Id: <20180430190946.093694747@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.131-rc1
X-KernelTest-Deadline: 2018-05-02T19:09+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200407080581115?=
X-GMAIL-MSGID: =?utf-8?q?1599200407080581115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.131 release.
There are 44 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed May  2 19:09:34 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.131-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.131-rc1

Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
    ath10k: fix rfc1042 header retrieval in QCA4019 with eth decap mode

Romain Izard <romain.izard.pro@gmail.com>
    serial: mctrl_gpio: Add missing module license

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: mctrl_gpio: export mctrl_gpio_disable_ms and mctrl_gpio_init

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/smpboot: Don't use mwait_play_dead() on AMD systems

Arnd Bergmann <arnd@arndb.de>
    x86/ipc: Fix x32 version of shmid64_ds and msqid64_ds

Ilya Dryomov <idryomov@gmail.com>
    libceph: validate con->state at the top of try_write()

Nicolin Chen <nicoleotsuka@gmail.com>
    ASoC: fsl_esai: Fix divisor calculation failure at lower ratio

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: amba: Don't read past the end of sysfs "driver_override" buffer

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: amba: Fix race condition with driver_override

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: amba: Make driver_override output consistent with other buses

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

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add some fixes for ALC233

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Hardening for potential Spectre v1

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: oss: Hardening for potential Spectre v1

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device

David Henningsson <diwic@ubuntu.com>
    ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr

Takashi Iwai <tiwai@suse.de>
    ALSA: control: Hardening for potential Spectre v1

Takashi Iwai <tiwai@suse.de>
    ALSA: rme9652: Hardening for potential Spectre v1

Takashi Iwai <tiwai@suse.de>
    ALSA: hdspm: Hardening for potential Spectre v1

Takashi Iwai <tiwai@suse.de>
    ALSA: asihpi: Hardening for potential Spectre v1

Takashi Iwai <tiwai@suse.de>
    ALSA: opl3: Hardening for potential Spectre v1

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    tty: Use __GFP_NOFAIL for tty_ldisc_get()

Tony Lindgren <tony@atomide.com>
    tty: n_gsm: Fix DLCI handling for ADM mode if debug & 2 is not set

Tony Lindgren <tony@atomide.com>
    tty: n_gsm: Fix long delays with control frame timeouts in ADM mode

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    tty: Don't call panic() at tty_ldisc_init()

Gerd Hoffmann <kraxel@redhat.com>
    drm/virtio: fix vq wait_event condition

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

Collin May <collin@collinswebsite.com>
    USB: serial: simple: add libtransistor console

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

Eric Biggers <ebiggers@google.com>
    ext4: prevent right-shifting extents beyond EXT_MAX_BLOCKS


-------------

Diffstat:

 Makefile                               |  4 +-
 arch/x86/include/uapi/asm/msgbuf.h     | 31 +++++++++++++
 arch/x86/include/uapi/asm/shmbuf.h     | 42 +++++++++++++++++
 arch/x86/kernel/smpboot.c              |  2 +
 drivers/amba/bus.c                     | 17 ++++---
 drivers/char/virtio_console.c          | 49 ++++++++++----------
 drivers/gpu/drm/virtio/virtgpu_vq.c    |  4 +-
 drivers/mtd/chips/cfi_cmdset_0001.c    | 33 +++++++++++--
 drivers/mtd/chips/cfi_cmdset_0002.c    |  9 ++--
 drivers/net/wireless/ath/ath10k/core.c |  8 ++++
 drivers/net/wireless/ath/ath10k/core.h |  4 ++
 drivers/scsi/sd.c                      |  2 +
 drivers/tty/n_gsm.c                    | 23 ++++++++-
 drivers/tty/serial/serial_mctrl_gpio.c |  5 ++
 drivers/tty/tty_io.c                   |  5 +-
 drivers/tty/tty_ldisc.c                | 16 +++----
 drivers/usb/core/hcd.c                 |  1 +
 drivers/usb/core/hub.c                 | 10 +++-
 drivers/usb/core/quirks.c              |  3 ++
 drivers/usb/serial/Kconfig             |  1 +
 drivers/usb/serial/cp210x.c            |  1 +
 drivers/usb/serial/ftdi_sio.c          |  3 +-
 drivers/usb/serial/usb-serial-simple.c |  7 +++
 drivers/usb/usbip/stub_main.c          |  5 ++
 drivers/usb/usbip/usbip_common.h       |  2 +-
 fs/ext4/balloc.c                       | 17 ++++++-
 fs/ext4/extents.c                      | 16 +++++--
 fs/ext4/ialloc.c                       |  7 +++
 fs/jbd2/transaction.c                  |  1 +
 include/linux/mtd/flashchip.h          |  1 +
 include/linux/tty.h                    |  2 +-
 include/linux/virtio.h                 |  3 ++
 include/sound/control.h                |  7 ++-
 lib/kobject.c                          | 12 ++---
 net/ceph/messenger.c                   |  7 +++
 sound/core/pcm_native.c                |  1 +
 sound/core/seq/oss/seq_oss_event.c     | 15 +++---
 sound/core/seq/oss/seq_oss_midi.c      |  2 +
 sound/core/seq/oss/seq_oss_synth.c     | 85 ++++++++++++++++++++--------------
 sound/core/seq/oss/seq_oss_synth.h     |  3 +-
 sound/drivers/opl3/opl3_synth.c        |  7 ++-
 sound/pci/asihpi/hpimsginit.c          | 13 ++++--
 sound/pci/asihpi/hpioctl.c             |  4 +-
 sound/pci/hda/hda_hwdep.c              | 12 ++++-
 sound/pci/hda/patch_realtek.c          |  2 +
 sound/pci/rme9652/hdspm.c              | 24 ++++++----
 sound/pci/rme9652/rme9652.c            |  6 ++-
 sound/soc/fsl/fsl_esai.c               |  7 +++
 sound/usb/mixer_maps.c                 |  3 ++
 49 files changed, 408 insertions(+), 136 deletions(-)
