Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsDyXb9sPx0OeGwPVkeuGpKeQecRby8pY8rmzfx0txtp19AQZZQ5hQaDzlpKivLL1GHcyJ9
ARC-Seal: i=1; a=rsa-sha256; t=1521483565; cv=none;
        d=google.com; s=arc-20160816;
        b=wEGPslyCFNc79sNDKaHY3XO3A2ZSWFnV4/gB5FPmJ21Rnl+67WvXCr/lcMof2wnvsU
         Yva8MTYoErIbQ9BfMzOEGyX0jPMFSgeroo7LPNpG8CvU04eGCJxqVuOatSMwVaaTHC5E
         4DRlbPSojjjyQgzCstI4kaHZkq9dsMTPRYOvNxfKCAJoVGlDCRAFKhVLcQLVnYxH7t+H
         kQ4AJNdTleW8j/bC+5ENmlu4FRYDZqE1y2LszLncDIoJLMpuHfSw39ZRWNdErTnK1VsV
         t6kuCybXraRom0Tr0Xlvu2zrbJnAjyLmL03jUsVNUpKwsAGD4AsnjoDL4J8QXRFuDdwI
         Pl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ojNTAANax4DunH/F2dTjEYZH3MqEdMLGQ5YbnDXkWnk=;
        b=TC50HjV94k/FZ9POpapM2QIlmTE/qeXXvraI8dPA/vQvY7tILJzPEgu+mhflCe24SU
         Qk8cK9jjWFIHTpgjJ+OJAxs9DOXAC9sYp2LeQkUk2GUXBWN2F0XYTnJDPG1XKvguLHrT
         r24312G2sB3sdP5HL2KDy5YzvoJ30B1AKfnKwiZQO7xsAgfmeBh49hZYvmNKoPc9qStS
         x0qI7Scniw8pflhiBsqcXupSvrxdJBdCs8coWCAFYl4n2TB1GeNb9aOJSethApuWWUnG
         1kE8pnarB9tCQfCgdTYbnWPcStdd5C599eg9ekaVOND7VFWtihx47d/e2X1BpAX43tx6
         m86A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Eric Anholt <eric@anholt.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 036/241] ARM: bcm2835: Enable missing CMA settings for VC4 driver
Date: Mon, 19 Mar 2018 19:05:01 +0100
Message-Id: <20180319180752.673588665@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391150860110595?=
X-GMAIL-MSGID: =?utf-8?q?1595391150860110595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>


[ Upstream commit bdd3c25423cb42171446940bca0946e0443e1a84 ]

Currently bcm2835_defconfig has CMA disabled which makes the
HDMI output on a Raspberry Pi 1 stop working during boot:

    fb: switching to vc4drmfb from simple
    Console: switching to colour dummy device 80x30
    [drm] Initialized vc4 0.0.0 20140616 for soc:gpu on minor 0
    [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
    [drm] Driver supports precise vblank timestamp query.
    vc4-drm soc:gpu: failed to allocate buffer with size 9216000
    vc4-drm soc:gpu: Failed to set initial hw configuration.

So enable CMA and DMA_CMA in bcm2835_defconfig.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 4400d9ac05ee ("ARM: bcm2835: Enable the VC4 graphics driver in the defconfig")
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/configs/bcm2835_defconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -1,6 +1,5 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
-CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BSD_PROCESS_ACCT=y
@@ -32,6 +31,7 @@ CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
 CONFIG_KSM=y
 CONFIG_CLEANCACHE=y
+CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
@@ -52,6 +52,7 @@ CONFIG_MAC80211=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
+CONFIG_DMA_CMA=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_CONSTANTS=y
@@ -62,7 +63,6 @@ CONFIG_USB_NET_SMSC95XX=y
 CONFIG_ZD1211RW=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_TTY_PRINTK=y
