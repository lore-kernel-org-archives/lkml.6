Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2921BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A0D21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545409352;
	bh=NCzpWOiMMo4OfhPMHE3CMsFa5JVh6flpcNjcRBEG3A4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kXbhLeS5PWu1Nw8KMnEI14iijQ1OJvT+uUGkiJq3R0pYi6rk3sh84Pyf571JAilrA
	 WP8vFlSdhg87pQFcwrWWX5q1/0DH7Fls5MScHCpGhyQOCzVX+YdKAnSrTrsHL46zAV
	 /SG6ZV4ckquNcuFAwKcOMc27HeFXGQfuw10AD588=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbeLUQWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:22:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731601AbeLUQWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:22:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E4721903;
        Fri, 21 Dec 2018 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545409349;
        bh=NCzpWOiMMo4OfhPMHE3CMsFa5JVh6flpcNjcRBEG3A4=;
        h=Date:From:To:Cc:Subject:From;
        b=nptqMbFziiEi2h/roG6q5vIDl9BWCCY9YYi9WK3BcZ5QuCgSLgJhhxSAJH5MHKRTS
         2shCkdVOL+GJTwTV4DcxAZ6LMqtAp7gtwBpxYNVOEWsX6Gfdmxbrlyqw+Cr36+65vS
         JNY82V06aLhUDSkha/m8cvdOtTL3atPfpo8+6cck=
Date:   Fri, 21 Dec 2018 17:22:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.131
Message-ID: <20181221162227.GA7011@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.131 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                               |    2=20
 arch/arm/mm/cache-v7.S                 |    8 +-
 arch/powerpc/boot/Makefile             |    3 -
 arch/powerpc/kernel/legacy_serial.c    |    6 +-
 arch/x86/platform/efi/early_printk.c   |    2=20
 drivers/ata/libata-core.c              |    1=20
 drivers/i2c/busses/i2c-scmi.c          |   10 ++-
 drivers/ide/pmac.c                     |    1=20
 drivers/input/keyboard/omap4-keypad.c  |   18 ++++--
 drivers/mmc/host/omap.c                |   11 +++
 drivers/net/bonding/bond_3ad.c         |    3 +
 drivers/net/wireless/ath/wil6210/wmi.c |    7 ++
 drivers/sbus/char/display7seg.c        |    1=20
 drivers/sbus/char/envctrl.c            |    2=20
 drivers/scsi/libiscsi.c                |    4 -
 drivers/scsi/sr_ioctl.c                |   21 ++-----
 drivers/scsi/vmw_pvscsi.c              |    4 -
 drivers/tty/serial/suncore.c           |    1=20
 fs/cifs/Kconfig                        |    2=20
 include/linux/posix-timers.h           |    4 -
 include/sound/pcm.h                    |    2=20
 kernel/time/posix-cpu-timers.c         |    2=20
 kernel/time/posix-timers.c             |   29 ++++++----
 kernel/time/timer_list.c               |    2=20
 kernel/trace/ftrace.c                  |    1=20
 kernel/trace/trace_events_trigger.c    |    6 +-
 lib/interval_tree_test.c               |   93 ++++++++++++++++++++++------=
-----
 lib/rbtree_test.c                      |   55 ++++++++++++-------
 lib/swiotlb.c                          |   18 ++----
 net/sunrpc/xprt.c                      |   11 +++
 sound/core/pcm_lib.c                   |    2=20
 sound/core/pcm_native.c                |    6 --
 sound/isa/wavefront/wavefront_synth.c  |    9 +++
 33 files changed, 223 insertions(+), 124 deletions(-)

Aaro Koskinen (1):
      MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310

Benjamin Herrenschmidt (1):
      powerpc: Look for "stdout-path" when setting up legacy consoles

Cathy Avery (1):
      scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq d=
uring unload

Chris Cole (1):
      ARM: 8814/1: mm: improve/fix ARM v7_dma_inv_range() unaligned address=
 handling

Dan Carpenter (1):
      ALSA: isa/wavefront: prevent some out of bound writes

Davidlohr Bueso (5):
      lib/interval_tree_test.c: make test options module parameters
      lib/interval_tree_test.c: allow full tree search
      lib/rbtree_test.c: make input module parameters
      lib/rbtree-test: lower default params
      lib/interval_tree_test.c: allow users to limit scope of endpoint

Fred Herard (1):
      scsi: libiscsi: Fix NULL pointer dereference in iscsi_eh_session_reset

Greg Kroah-Hartman (1):
      Linux 3.18.131

Guenter Roeck (1):
      powerpc/boot: Fix random libfdt related build errors

Hans de Goede (1):
      i2c: scmi: Fix probe error on devices with an empty SMB0001 ACPI devi=
ce node

Ingo Molnar (1):
      timer/debug: Change /proc/timer_list from 0444 to 0400

Jens Axboe (1):
      sr: pass down correctly sized SCSI sense buffer

Juha-Matti Tilli (1):
      libata: whitelist all SAMSUNG MZ7KM* solid-state disks

Kees Cook (1):
      swiotlb: clean up reporting

Lior David (1):
      wil6210: missing length check in wmi_set_ie

Steve French (1):
      cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure =
cifs)

Steven Rostedt (VMware) (2):
      tracing: Fix memory leak in set_trigger_filter()
      tracing: Fix memory leak of instance function hash filters

Takashi Sakamoto (1):
      ALSA: pcm: remove SNDRV_PCM_IOCTL1_INFO internal command

Thomas Gleixner (1):
      posix-timers: Sanitize overrun handling

Toni Peltonen (1):
      bonding: fix 802.3ad state sent to partner when unbinding slave

Tony Lindgren (1):
      Input: omap-keypad - fix keyboard debounce configuration

Trond Myklebust (1):
      SUNRPC: Fix a potential race in xprt_connect()

Yangtao Li (4):
      sbus: char: add of_node_put()
      drivers/sbus/char: add of_node_put()
      drivers/tty: add missing of_node_put()
      ide: pmac: add of_node_put()

YiFei Zhu (1):
      x86/earlyprintk/efi: Fix infinite loop on some screen widths


--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwdE0AACgkQONu9yGCS
aT565w//evahBEZwFjgUXl3g0llYGg3gEqNleCEr5ViGSLNZs7EitK3uae/fq7N5
fCCYd6/QPO7Yas1Y1TYW6luLiEscY8oonyTUTRUhGIc1E+JA2aLwBpuUCU5ASqyz
s9T0Zl3AxjmGuQRsmzJIAi6w4lLALddLRg/rESNGPhm7qhwjJ6GTo4j3AmgGq/Y7
MS5198gCbx85fROPvVlAIUKEbA4mrg8Kl9OfnnvsA641KsM9BVUvqfSURtdsGfRj
vQNlmHre2BbnNyQ7IXe4UDwpTSynN9IC8JPHgXzWLiW6DaH+FDHoJHtseQPGyMa8
c6t8/NKSB1iXznXn32VAqFMXneroTITFHQjSc/PpOlZ1FyG+M291VLgETTon3Kme
X3I/9JT8yOyPARg06CXoJhsNHoI5qXZUulOb7Xm26ylSJipKwtiJk8LKFBm56InU
f2vw3xhGV/IONLNakuNUsnPzvhJEKYQgWRDIt+jX/BQeZhwbbeKaOXkfoyGpWIbq
URbKwPudYeqcjdY0dKb2Xds1TtvUSnGpfb426uYCguhcxu3tYFK2t4yWdsaYkKVb
6RQZtpMCfGb2kMkhYbcHU7WObLiEJOLqu7Seuvy9tyblY83dMAiCCa7p6WeyTJSn
BwQvqiEKpuRpNfg/GvkWomJ6K4kyOcHNiPTRIhDAvypB0ZsEHR8=
=ReG3
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
