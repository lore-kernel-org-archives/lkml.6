Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-791436-1524206721-2-1303589649995452848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524206719; b=PVUKjiBP1Meq4TKeZp+4MwVNEqKey+bqImuEUZMbH10let/roq
    Cjsk1ogNZ3sm2YBvn/Takz3ukGT8kqiUkRob8fYnOh1xkt3sVjOK1i30YXtMq28d
    0uiEhUhbPWkVjsBuPr7BwKCV0Qi/74lS9taU7AznFbm/57GYD2CWuumcHLuSTlKY
    pYqr0K4sXh2LlzBo6XhzBAfE4BEcFnAH5NbYNdffIz3twm8ucDpxYaPK7X/M89D7
    l8PoqdfWCqYKmEZ12aIFBHydgTsl+uiYVV4TmkFUTFNoHoQOMpBLRczBYozaBvBd
    /DF/f18eym3vixdXOXha+Yd2IgSUA9GfwGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524206719;
    bh=7ReUyr7MMlem4EeBfjdb0ljCQDKF8Enimf7EREr/EqI=; b=q5G+CAza4E+z
    Nn9ZrrbmNmZ6v0cF1W1jPw9DdlFOEf6geoTeFBlbZgZ2y8Zq6h+cTvkRbsS1qwbn
    s3MftBocRVIyqgmiQlUL9Wlyzfc4QY51sr/o1ZVvLqklCV05qGCZGNA/RZ/fFZJj
    UFiDTlemLuh04HqQgq1FazOEC+GlUk6SNdHl01lj1PWhwfZsoiziPoR0zac62AjJ
    JwEkGKAUGY/nsTshc7GlkrnzaXh7gn6NmGtLfEq34giwftBL3EMREgtJ6OU9Vrnq
    ENhqZvzJ9rUmncG9UzXYTyhQvrYdJHIvT1RvssW2i8JAiyNo/tnj0FKtxdnFtb9N
    9LUGW/VFqg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
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
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKML6kBh1juRVqC5u2+DhNkzKO5ffIzHfm8riLDe5FiSZhMnPw+FcjHRF+SLNotTZSS3RbSt4/WucbYScVgPc3t/t3xh8zqSAWrFbB7B4M0VxEbgKXFD
    wDfApHvflvHDSVtEC7j/inAufL5CQoih0rSxlU+aAZ5P2ltzVH+4IC8u0jqybekusGhM/EaeQHYbKT31xq+DrwNGF7W+SbGfBhTeN+1GhrhyQUqR+W/OC9wL
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=mlcCp7fm3k_atoCOKNUA:9 a=CjuIK1q_8ugA:10 a=HKNf2GJ-EwGSGIURt-AA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeDTGpR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 02:45:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753551AbeDTGpQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Apr 2018 02:45:16 -0400
Date: Fri, 20 Apr 2018 08:25:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.95
Message-ID: <20180420062521.GA8476@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.95 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                            |    2=20
 arch/arm/include/asm/kvm_host.h                     |    6=20
 arch/arm/include/asm/kvm_mmu.h                      |   10=20
 arch/arm/include/asm/kvm_psci.h                     |   27=20
 arch/arm/kvm/arm.c                                  |   11=20
 arch/arm/kvm/handle_exit.c                          |    4=20
 arch/arm/kvm/psci.c                                 |  143 +
 arch/arm64/Kconfig                                  |   17=20
 arch/arm64/crypto/sha256-core.S                     | 2061 +++++++++++++++=
+++++
 arch/arm64/crypto/sha512-core.S                     | 1085 ++++++++++
 arch/arm64/include/asm/assembler.h                  |   19=20
 arch/arm64/include/asm/barrier.h                    |   23=20
 arch/arm64/include/asm/cpucaps.h                    |    3=20
 arch/arm64/include/asm/cputype.h                    |    6=20
 arch/arm64/include/asm/futex.h                      |    9=20
 arch/arm64/include/asm/kvm_host.h                   |    5=20
 arch/arm64/include/asm/kvm_mmu.h                    |   38=20
 arch/arm64/include/asm/kvm_psci.h                   |   27=20
 arch/arm64/include/asm/memory.h                     |   15=20
 arch/arm64/include/asm/mmu.h                        |   39=20
 arch/arm64/include/asm/processor.h                  |   24=20
 arch/arm64/include/asm/sysreg.h                     |    2=20
 arch/arm64/include/asm/uaccess.h                    |  153 -
 arch/arm64/kernel/Makefile                          |    4=20
 arch/arm64/kernel/arm64ksyms.c                      |    4=20
 arch/arm64/kernel/bpi.S                             |   75=20
 arch/arm64/kernel/cpu_errata.c                      |  189 +
 arch/arm64/kernel/cpufeature.c                      |   10=20
 arch/arm64/kernel/entry.S                           |   25=20
 arch/arm64/kvm/handle_exit.c                        |   16=20
 arch/arm64/kvm/hyp/hyp-entry.S                      |   20=20
 arch/arm64/kvm/hyp/switch.c                         |    5=20
 arch/arm64/lib/clear_user.S                         |    6=20
 arch/arm64/lib/copy_in_user.S                       |    4=20
 arch/arm64/mm/context.c                             |   12=20
 arch/arm64/mm/fault.c                               |   34=20
 arch/arm64/mm/proc.S                                |    7=20
 arch/parisc/kernel/drivers.c                        |    4=20
 arch/s390/kernel/ipl.c                              |    1=20
 drivers/acpi/nfit/core.c                            |   22=20
 drivers/block/loop.c                                |   12=20
 drivers/firmware/psci.c                             |   57=20
 drivers/gpu/drm/radeon/radeon_object.c              |    3=20
 drivers/hv/channel_mgmt.c                           |    2=20
 drivers/hwmon/ina2xx.c                              |    3=20
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c       |    4=20
 drivers/net/phy/micrel.c                            |   42=20
 drivers/net/slip/slhc.c                             |    5=20
 drivers/net/usb/cdc_ether.c                         |    6=20
 drivers/net/usb/lan78xx.c                           |    3=20
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c  |    2=20
 drivers/s390/cio/qdio_main.c                        |   42=20
 drivers/vhost/vhost.c                               |    8=20
 fs/namei.c                                          |    3=20
 include/kvm/arm_psci.h                              |   51=20
 include/linux/arm-smccc.h                           |  165 +
 include/linux/mm.h                                  |    4=20
 include/linux/psci.h                                |   14=20
 include/net/bluetooth/hci_core.h                    |    2=20
 include/net/slhc_vj.h                               |    1=20
 include/uapi/linux/psci.h                           |    3=20
 kernel/events/core.c                                |    6=20
 net/bluetooth/hci_conn.c                            |   29=20
 net/bluetooth/hci_event.c                           |   15=20
 net/bluetooth/l2cap_core.c                          |    2=20
 net/rds/send.c                                      |   15=20
 net/sunrpc/auth_gss/gss_krb5_crypto.c               |    3=20
 tools/perf/tests/code-reading.c                     |   20=20
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |   64=20
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h |    2=20
 tools/perf/util/intel-pt.c                          |   37=20
 71 files changed, 4442 insertions(+), 350 deletions(-)

Adrian Hunter (4):
      perf intel-pt: Fix overlap detection to identify consecutive buffers =
correctly
      perf intel-pt: Fix sync_switch
      perf intel-pt: Fix error recovery from missing TIP packet
      perf intel-pt: Fix timestamp following overflow

Al Viro (1):
      getname_kernel() needs to make sure that ->name !=3D ->iname in long =
case

Arnd Bergmann (1):
      radeon: hide pointless #warning when compile testing

Bassem Boubaker (1):
      cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN

Dan Williams (1):
      nfit: fix region registration vs block-data-window ranges

Dexuan Cui (1):
      Drivers: hv: vmbus: do not mark HV_PCIE as perf_device

Eric Biggers (1):
      sunrpc: remove incorrect HMAC request initialization

Greg Kroah-Hartman (3):
      Revert "perf tests: Decompress kernel module before objdump"
      Revert "net: phy: micrel: Restore led_mode and clk_sel on resume"
      Linux 4.9.95

Helge Deller (1):
      parisc: Fix out of array access in match_pci_device()

Julian Wiedmann (2):
      s390/qdio: don't retry EQBS after CCQ 96
      s390/qdio: don't merge ERROR output buffers

Ka-Cheong Poon (1):
      rds: MP-RDS may use an invalid c_path

Marek Szyprowski (1):
      hwmon: (ina2xx) Fix access to uninitialized mutex

Mark Rutland (41):
      arm64: barrier: Add CSDB macros to control data-value prediction
      arm64: Implement array_index_mask_nospec()
      arm64: move TASK_* definitions to <asm/processor.h>
      arm64: Make USER_DS an inclusive limit
      arm64: Use pointer masking to limit uaccess speculation
      arm64: entry: Ensure branch through syscall table is bounded under sp=
eculation
      arm64: uaccess: Prevent speculative use of the current addr_limit
      arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}=
_user
      arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user
      arm64: cpufeature: __this_cpu_has_cap() shouldn't stop early
      arm64: Run enable method for errata work arounds on late CPUs
      arm64: cpufeature: Pass capability structure to ->enable callback
      drivers/firmware: Expose psci_get_version through psci_ops structure
      arm64: Factor out TTBR0_EL1 post-update workaround into a specific as=
m macro
      arm64: Move post_ttbr_update_workaround to C code
      arm64: Add skeleton to harden the branch predictor against aliasing a=
ttacks
      arm64: Move BP hardening to check_and_switch_context
      mm: Introduce lm_alias
      arm64: KVM: Use per-CPU vector when BP hardening is enabled
      arm64: entry: Apply BP hardening for high-priority synchronous except=
ions
      arm64: entry: Apply BP hardening for suspicious interrupts from EL0
      arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75
      arm64: cpu_errata: Allow an erratum to be match for all revisions of =
a core
      arm64: Implement branch predictor hardening for affected Cortex-A CPUs
      arm64: Branch predictor hardening for Cavium ThunderX2
      arm64: KVM: Increment PC after handling an SMC trap
      arm/arm64: KVM: Consolidate the PSCI include files
      arm/arm64: KVM: Add PSCI_VERSION helper
      arm/arm64: KVM: Add smccc accessors to PSCI code
      arm/arm64: KVM: Implement PSCI 1.0 support
      arm/arm64: KVM: Advertise SMCCC v1.1
      arm64: KVM: Make PSCI_VERSION a fast path
      arm/arm64: KVM: Turn kvm_psci_version into a static inline
      arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support
      arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
      firmware/psci: Expose PSCI conduit
      firmware/psci: Expose SMCCC version through psci_ops
      arm/arm64: smccc: Make function identifiers an unsigned quantity
      arm/arm64: smccc: Implement SMCCC v1.1 inline primitive
      arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support
      arm64: Kill PSCI_GET_VERSION as a variant-2 workaround

Mauro Carvalho Chehab (1):
      media: v4l2-compat-ioctl32: don't oops on overlay

Phil Elwell (1):
      lan78xx: Correctly indicate invalid OTP

Prashant Bhole (1):
      perf/core: Fix use-after-free in uprobe_perf_close()

Stefan Hajnoczi (1):
      vhost: fix vhost_vq_access_ok() log check

Sudhir Sreedharan (1):
      rtl8187: Fix NULL pointer dereference in priv->conf_mutex

Szymon Janc (1):
      Bluetooth: Fix connection if directed advertising and privacy is used

Tejaswi Tanikella (1):
      slip: Check if rstate is initialized before uncompressing

Tetsuo Handa (1):
      block/loop: fix deadlock after loop_set_status

Vasily Gorbik (1):
      s390/ipl: ensure loadparm valid flag is set

Will Deacon (1):
      arm64: futex: Mask __user pointers prior to dereference


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrZh9AACgkQONu9yGCS
aT6OqQ//Yjzmsq3ob8NSiKbkd1XVEXlek6ZjYPo1mOH0T4C1IKuTGFNZ+4F7aiSQ
pJ1wHleYxF+dNguIPpEzhCLTftfjoFgcfxKx8eXiwhQfXFHq7+3O/lMAXvpX5Qda
IrZTbgc2KdjErrDq7G0VjsRzOG/An3K1xxc6mOeYETD71nGTTAvTR5shakgTz5hZ
NKUDj0QPEjXZHpM9KRuyUnjONZW89Jb0PE9Th99eIgjE5oOSH+igkbzGT29SPDh+
mHX3l1O3ElAFDQTrq9kF9eOG+6oxnpGSLB5EFwPQoRAMPs1j6U3P/A32oJUsuSCx
nVzdaVS3mNpprKQCS4QoGx2ZVe2sW8OAJOPMkCUXwDHS+snsU1VYzRsB9fPGS8e9
DGz3UJuYP/JFWPNJ6KSqZf1zyQxMh9r5FbeWbxytWnnvYGJiKCbYwK/j9WFolSIR
d4pli6FNd93kGY+DJXkfJU2gsBwrsV4eQfd0lplqnJqW60NkKL5wqEeCKBRIYmtY
HVOH3k42716A9NK09+cVDeDKn17ulG7BbpYZorxBTMJhEnAxckgM0/LZko0rUW+B
RjsbK2N7PSNyFGG3oNZGtafNYBJJA4T8X5J1mUyGxfTTTNTBxUEXnl8rwPtEGIKW
mA0CUEiCGdlKJtzgl7vAWKB9gQzx7bknln4wJbrY2Fhv5XCycR0=
=sLUJ
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
